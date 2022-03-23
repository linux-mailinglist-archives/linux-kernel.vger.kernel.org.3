Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE704E5BB9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 00:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241475AbiCWXRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 19:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239570AbiCWXRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 19:17:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A98D90CC0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:16:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 010AF61807
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 23:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5C6C340E8;
        Wed, 23 Mar 2022 23:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648077364;
        bh=LBixttlfEF4WnQmYE8eava3/Q7V2ynpDMV3E2heHfnI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QwlayLwha2NecV4QfjN9ngL3kkZbvrjZOuezmPm7s7aAtKP7j6STnTg7OppEuCUlF
         XDC16s6afmEAvsixZdJXNbzxKBysYvnL0+JL9E8ZIfLlK3Zv0B3V7YGrlxcB/feVXb
         JdI541MWd0CJA57VArXAViP5Khkd4xpNVRtkD1lATksCBCvEY4GK6poXK1H0DnXV+W
         U2YnTzzGnPGm4WwD7ZKzjUrNH6jlWpZp+bPDpKVPal4eNDLaXOUnPDKB//AXwumwLL
         Qci7dTAmwRNdVNvbcecS7K52MNXaxiQ7y31TF/sTfOrZy/WHEP3RFLYCFc2CFXLgoj
         jUOWgzJD/DF3A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 33ABE5C0192; Wed, 23 Mar 2022 16:16:03 -0700 (PDT)
Date:   Wed, 23 Mar 2022 16:16:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH 0/2] nolibc: fix two build issues at -O0
Message-ID: <20220323231603.GS4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220323071807.14413-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323071807.14413-1-w@1wt.eu>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 08:18:05AM +0100, Willy Tarreau wrote:
> Hello Paul,
> 
> please find in this series two build fixes to apply on top of the series
> you've already queued:
>  - gcc errors at -O0 because it doesn't eliminate non-inline code and
>    keeps the reference to the external "environ" from getenv()
>  - clang fails at -O0 because __builtin_strlen() calls strlen()
> 
> I don't care about optimizing at -O0 by definition but at least it should
> build and work correctly! I've verified that rcutorture still runs.

Queued with Ammar's Tested-by, thank you both!

							Thanx, Paul

> Thanks!
> Willy
> 
> ---
> Willy Tarreau (2):
>   tools/nolibc/string: do not use __builtin_strlen() at -O0
>   tools/nolibc/stdlib: only reference the external environ when inlined
> 
>  tools/include/nolibc/stdlib.h | 22 +++++++++++++++-------
>  tools/include/nolibc/string.h | 11 ++++++++++-
>  2 files changed, 25 insertions(+), 8 deletions(-)
> 
> -- 
> 2.35.1
> 
