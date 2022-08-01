Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9546586D22
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiHAOmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiHAOmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:42:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BBA3D599
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:41:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C854611BF
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 14:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479E9C433D6;
        Mon,  1 Aug 2022 14:41:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oG/vRklh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659364897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=htIi3XqksEfEoqLAYx07oI8o30SOM6ge3VdkGTv3zmk=;
        b=oG/vRklhyXZaR17jMX+GhIcO/gmN1XwrpPHRYyw86I2hFJowXlpPUFXPVgWIVEyVoTWZrU
        mI/+vz7O8jDHDklVtpoM9sg1yWYN4DNSoxEmTXwm6BgH9H3dggCgGcRBtCCiJIU64S9VA9
        TUKZLMhkBI/JGTkrAfYqXluH5QlDeCI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d5a7f480 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 1 Aug 2022 14:41:37 +0000 (UTC)
Date:   Mon, 1 Aug 2022 16:41:34 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: use raw spinlocks for use on RT
Message-ID: <YufmHsYX0+I3rpx4@zx2c4.com>
References: <20220801142530.133007-1-Jason@zx2c4.com>
 <YufkZU9kGkHHUhAK@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YufkZU9kGkHHUhAK@linutronix.de>
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

On Mon, Aug 01, 2022 at 04:34:13PM +0200, Sebastian Andrzej Siewior wrote:
> So I have everything ready for 5.20 (6.0) ready without the RT patch and
> then this vsprintf issues comes along…

I already sent my rc1 pull to Linus for 6.0, but I can do a second pull
with this in it for next week while the merge window is still open, so
that your RT-patch-len-zero objective is still met for 6.0.

> From that point of view I would prefer to either init it upfront in a
> way that works for everyone/ loose the first %p since it is probably a
> minor inconvenience if nobody complains - instead swapping all locks.
> We managed without this for kasan and lockdep which are both not used in
> a production environment.

The kfence change was a production change, actually. Lots of people turn
that on by default.

If you want to address this within printk itself, just do `if (rt || lockdep)`
as the condition, so we don't swallow the first one. When you have to
make code worse to satisfy a tool, the tool is the problem. We only
would need this first message dropping on rt, not on other kernels.
Don't knock other kernels.

However... I suspect these issues will continue to bite us in new subtle
ways for some time to come. Who is to say that you can't call
get_random_bytes() from a driver's hard IRQ? As RT gets integrated and
more widely deployed, I imagine these things will start coming up.
random.c was already designed to handle random bytes in irqoff; that's
why it uses irqsave/irqrestore all over its spinlock handling. This RT
thing is a snag in that original intention. But its an intention trivial
to recover with this patch. So if you're okay with it, I think I'd
prefer to do this and have our problems go away once and for all.

> I would need to do worst-case measurements and I've been looking at this
> just before writting the other email and there was a local_lock_t
> somewhere which needs also change…

That would be very interesting to learn about. If your measurements say
yes, then maybe we can do this. If your measurements say "yikes", then I
guess we can't. Either way, I like having some metric to decide this by.

Jason
