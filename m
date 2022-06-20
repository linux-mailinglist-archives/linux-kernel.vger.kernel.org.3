Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036C5551251
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239475AbiFTIPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbiFTIPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:15:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58421181D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:15:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B84EB80E19
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D8EC3411B;
        Mon, 20 Jun 2022 08:15:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PLuZLoja"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655712899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+X19RxcvbjERl3ri3qP76Zy15OFpjPX6+U0WKHFEW7I=;
        b=PLuZLojacHYHy2loWss+n4sQ8uPMmBHxEGiGFYb47J5D4g8+qOJyP0ZKorcEIgKWZsUKmp
        9ObApvQ5u0yDOI2X+39fhF6eMdeIS3VNVfERtVAVLE9hNXYaiemUPtehwceBmGAnmWHFbb
        wveTKqEly1ONwS4Xur/y7e766fv4WSo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7add4f2e (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 20 Jun 2022 08:14:58 +0000 (UTC)
Date:   Mon, 20 Jun 2022 10:14:57 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sebastian Siewior <bigeasy@linutronix.de>
Cc:     Jann Horn <jannh@google.com>, Theodore Ts'o <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] random: Fix signal_pending() usage
Message-ID: <YrAsgZC3iEHI+nu3@zx2c4.com>
References: <20220405163931.1108442-1-jannh@google.com>
 <CAHmME9pW6heXtPrfCP7J6ODgSc8sotsv6E3dnJoVBaPi+Ph=HA@mail.gmail.com>
 <YqywapDM7NPC/X+E@linutronix.de>
 <Yq0EcG9GsAkoiF3H@zx2c4.com>
 <YrAlPKeOowD5qv/B@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrAlPKeOowD5qv/B@linutronix.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Mon, Jun 20, 2022 at 09:43:56AM +0200, Sebastian Siewior wrote:
> > As for your suggestion to drop it entirely: that'd be nice, in that it'd
> > add a guarantee that currently doesn't exist. But it can lead to
> > somewhat large delays if somebody tries to read 2 gigabytes at a time
> > and hits Ctrl+C during it. That seems potentially bad?
> 
> So on my x86 box which runs a Debian kernel (based on v5.18.2):
> 
> | ~$ dd if=/dev/random of=/dev/null bs=2147483648 count=1
> | 0+1 records in
> | 0+1 records out
> | 2147479552 bytes (2,1 GB, 2,0 GiB) copied, 5,97452 s, 359 MB/s
> 
> almost 6 secs. On a smaller box it might take 12s or more. Your
> implementation change ensured that it does not block for unpredicted
> amount of time. Previously it would block until the random pool is
> filled with enough entropy and this could take an unforeseen amount of
> time. That read now makes more or less constant progress since it
> depends only on CPU time.
> Based on that, I don't see a problem dropping that signal check
> especially that requests larger than 4KiB are most likely exotic.

I don't have a huge objection to that, but I also don't really know
what's normal and expected behavior here. What do you make of the usage
of should_stop_iteration() in drivers/char/mem.c, for example? Would you
also remove that? If you send a patch to change this in random.c,
perhaps you should also change it in mem.c and elsewhere, so that some
broader consensus forms (or doesn't form) on what the expected behavior
is.

Jason
