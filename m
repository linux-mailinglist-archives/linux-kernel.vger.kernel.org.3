Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D18C584EF7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 12:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiG2KiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 06:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbiG2KiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 06:38:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7C082FBA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 03:38:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8563DB82749
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 10:38:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A5AC433C1;
        Fri, 29 Jul 2022 10:38:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="F/Y6zFs/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659091089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/mTDH8o5XBJ6BCjVRop//5kfjjl5UXmaKSwAH4IORuY=;
        b=F/Y6zFs/897ixOfgILO03wLa0pFjwE44ip+3ima7viVBs3hoMa0iKVOmqqnXPo8NqxthF2
        THSEHdO+LUHZj1L9leK2O529W62dyJhS4pPqUR8lB9RCvlkuhU7NS7uGdPPjwXnCJVHMIt
        TwnPVW9RjSuxNnoeUmDD1qvQoD5LEcs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 50beb96d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 29 Jul 2022 10:38:09 +0000 (UTC)
Date:   Fri, 29 Jul 2022 12:38:06 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] random: Initialize vsprintf's pointer hash once the
 random core is ready.
Message-ID: <YuO4jj8rg9hjHErN@zx2c4.com>
References: <YuOf6qu453dOkR+S@linutronix.de>
 <YuOyeJu8PPAVnXiN@zx2c4.com>
 <YuO0p8lMhVmQj/K2@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YuO0p8lMhVmQj/K2@linutronix.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Fri, Jul 29, 2022 at 12:21:27PM +0200, Sebastian Andrzej Siewior wrote:
> So launching a worker to obtain the random data? That would mean that
> the first %p print won't have nothing, right? I could do it as part of

"First" isn't very meaningful here. If the rng isn't initialized by
add_bootloader_randomness() or similar, then it'll almost miss some
amount of %p anyway.

But anyway, it sounds like you only need to hoist into a worker IF
you're `IS_ENABLED(CONFIG_PREEMPT_RT) && in_hardirq()`, right? So just
conditionalize it on that, and this should have pretty minimal impact.

I don't think this patch will require touching random.c.

Jason
