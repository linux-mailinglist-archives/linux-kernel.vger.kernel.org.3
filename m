Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFFB51E976
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 21:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387630AbiEGTav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 15:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiEGTan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 15:30:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EFF1F60C
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 12:26:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14A3360959
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 19:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC91C385A6;
        Sat,  7 May 2022 19:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651951614;
        bh=JgTJgIHGYMFK0hU3vlZkqQAKJBZeHW+d7SlpswGidWQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=elVVnz+rabjmeIgdO9nzoBD4cMuFaJ49AYof7bFWRNd3Rcf9z9kJsNaShseCTb3SK
         86Pw5NlKXJECJCFbJtIEFlgQXObejpZDaDR0KWC/zK0ps7qiFGLb52v03mmlD75SgN
         flLn1asQ8VC/KZuGIklt+oNLM69ZsDzfUCmN2ZDU=
Date:   Sat, 7 May 2022 12:26:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH] init: call time_init() before rand_initialize()
Message-Id: <20220507122653.e5ea43e8200568b348b7a16d@linux-foundation.org>
In-Reply-To: <20220505003114.177552-1-Jason@zx2c4.com>
References: <20220505003114.177552-1-Jason@zx2c4.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  5 May 2022 02:31:14 +0200 "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:

> Currently time_init() is called before rand_initialize(), but

You mean "after"!  Changelog was really confusing until I went and
looked at the code.

> rand_initialize() makes use of the timer on various platforms, and
> sometimes this timer needs to be initialized by time_init() first. In
> order to not return zero, 

return zero from what?

> reverse the order of these two calls. The
> block doing random initialization was right before time_init() before,
> so changing the order shouldn't have any complicated effects.

I hope you're right.  Moving these things around tends to fix one thing
and break another.

> Andrew - this file has no formal maintainer, but you've signed the most
> commits, so I'm CC'ing you. This has some interactions with my
> random.git tree, so unless there are objections, I'll queue it up there.

No probs.  Plenty of testing in linux-next, please.


