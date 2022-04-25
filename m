Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D9150E17F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241983AbiDYNZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241965AbiDYNZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:25:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5727E24951;
        Mon, 25 Apr 2022 06:22:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7081CCE1723;
        Mon, 25 Apr 2022 13:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D59C385A7;
        Mon, 25 Apr 2022 13:22:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="X6ctYhFr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650892925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RUgf9fdCddZSXHAZQi+E26zlz/usdttmv9k+wODO6tM=;
        b=X6ctYhFryjy44M5yK90kNoc8oX3U9zdJqFq+AvqVx0El/Z6vnqTCV1pwWrjGWO7Hh2i3Ou
        yGF9AHbS9BP1IREWHXKL/DWnlVABTRrqYRB9Et0HcydIRFo2FvSqDd5uN/yZcw58KgncoT
        kGLCLHFTPMMHbjfuJK+Uq6iUBmxXYLE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bda2c408 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 25 Apr 2022 13:22:04 +0000 (UTC)
Date:   Mon, 25 Apr 2022 15:22:00 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        arnd@arndb.de, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v6 06/17] timekeeping: add raw clock fallback for
 random_get_entropy()
Message-ID: <YmageFiSs0h1jzS7@zx2c4.com>
References: <20220423212623.1957011-1-Jason@zx2c4.com>
 <20220423212623.1957011-7-Jason@zx2c4.com>
 <87y1zt1gqw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y1zt1gqw.ffs@tglx>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, Apr 25, 2022 at 02:37:11PM +0200, Thomas Gleixner wrote:
> On Sat, Apr 23 2022 at 23:26, Jason A. Donenfeld wrote:
> > The addition of random_get_entropy_fallback() provides access to
> > whichever time source has the highest frequency, which is useful for
> > gathering entropy on platforms without available cycle counters. It's
> > not necessarily as good as being able to quickly access a cycle counter
> > that the CPU has, but it's still something, even when it falls back to
> > being jiffies-based.
> >
> > In the event that a given arch does not define get_cycles(), falling
> > back to the get_cycles() default implementation that returns 0 is really
> > not the best we can do. Instead, at least calling
> > random_get_entropy_fallback() would be preferable, because that always
> > needs to return _something_, even falling back to jiffies eventually.
> > It's not as though random_get_entropy_fallback() is super high precision
> > or guaranteed to be entropic, but basically anything that's not zero all
> > the time is better than returning zero all the time.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Theodore Ts'o <tytso@mit.edu>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> 
> Not that I care much, but in general taking over authorship w/o
> attribution via Suggested-by or such is frowned upon.

Sorry about that. Usually I'm pretty good about adding those. I guess
something must have gotten lost this time through, as the v1 of this
started out using sched_clock() (Arnd's suggestion) and then moved to
using the raw ktime clock after your suggestion, and I missed the
Suggested-by. I'll add that. Meanwhile, do you want to Ack this patch?
Do the technical aspects look okay to you?

Jason
