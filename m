Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCBB529294
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350367AbiEPVM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349324AbiEPVKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:10:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEA91AF
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 13:55:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88338614DE
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30F4C385AA;
        Mon, 16 May 2022 20:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652734538;
        bh=dugUPCYBgA8+hGXd7VCk99Ywg4RL56xDXuN95GI3f/I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t9V8Kfrs85wyXWugBWf5HDM27Y6DeGms/QxZ1q5i5X/PCQKUDDyIqaquN6GAXPrgW
         BCay57CEkeaCYfJdDFFkdHZrOhbBzwFb9S3P1smqgWsF7ww2x4F+3Pc7S/I6xHCaZG
         d6hXl9Avj6g05HfnpMJ119E9h2abFZez1H1ASETM=
Date:   Mon, 16 May 2022 13:55:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH mm v2] tracing: incorrect gfp_t conversion
Message-Id: <20220516135537.8458fe08464d97bb45684252@linux-foundation.org>
In-Reply-To: <20220515180903.37fc18e4@gandalf.local.home>
References: <b8feb625dd2ba0d0dfc298a2f39ca1d8368ba5c9.camel@perches.com>
        <20220515180903.37fc18e4@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 10:20:39 +0300 Vasily Averin <vvs@openvz.org> wrote:

> Fixes the following sparse warnings:
> 
> include/trace/events/*: sparse: cast to restricted gfp_t
> include/trace/events/*: sparse: restricted gfp_t degrades to integer
> 
> gfp_t type is bitwise and requires __force attributes for any casts.

I already moved the previous version into mm-stable.  Would prefer not
to have to rebase it.

> v2: 1) re-based to 5.18-rc6
>     2) re-defined __def_gfpflag_names array according to
> 	akpm@, willy@ and Joe Perches recommendations

Please redo this against the mm-stable or mm-unstable branches against
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm, or against your
own previous version.

The new patch will simply switch to the gfpflag_string() trick, so it will
not be a "fix", so please let's position it as a "cleanup".

