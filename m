Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5033451AD71
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377455AbiEDTJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377484AbiEDTI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:08:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE016DE3;
        Wed,  4 May 2022 12:05:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7A33B8282B;
        Wed,  4 May 2022 19:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A6BC385A5;
        Wed,  4 May 2022 19:05:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CRGjQoNR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651691110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IxergFl485EsXY2KxptRvd0tHpmPVRyaJTdUoOrikA0=;
        b=CRGjQoNRUpEsYavQXvZk051nbB+Z+hM28IoCV9yZxl4KCq5jebxounT6kA8AqSNG3V6tMx
        D6VP8NroEjouvUCb68yuju53H+hPnkSFxcQVXa73d146I7PpI6icduzs3UMgZiencdkqoG
        wzLwBHXOqaVomlZjafSWf5AMOS83Ffw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 93d71f1d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 4 May 2022 19:05:10 +0000 (UTC)
Date:   Wed, 4 May 2022 21:05:01 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Filipe Manana <fdmanana@suse.com>, linux-crypto@vger.kernel.org
Subject: Re: [patch 3/3] x86/fpu: Make FPU protection more robust
Message-ID: <YnLOXZp6WgH7ULVU@zx2c4.com>
References: <20220501192740.203963477@linutronix.de>
 <20220501193102.704267030@linutronix.de>
 <Ym/sHqKqmLOJubgE@zn.tnic>
 <87k0b4lydr.ffs@tglx>
 <YnDwjjdiSQ5Yml6E@hirez.programming.kicks-ass.net>
 <87fslpjomx.ffs@tglx>
 <YnKh96isoB7jiFrv@zx2c4.com>
 <87czgtjlfq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87czgtjlfq.ffs@tglx>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Thomas,

On Wed, May 04, 2022 at 06:45:45PM +0200, Thomas Gleixner wrote:
> add_disk_randomness() on !RT kernels. That's what made me look into this
> in the first place as it unearthed the long standing FPU protection
> bug. See the first patch in this thread.
> 
> Possibly add_device_randomness() too, but I haven't seen evidence so far.

It looks like it's being hit from add_input_randomness() via
input_handle_event() too. There are two positions we could take toward
this:

One stance to take would be that if an event happens in an interrupt,
add_interrupt_randomness() should in theory already be siphashing in a
cycle counter so additional calls to add_{input,disk}_randomness() don't
contribute substantially (unless you assume the num field has some
entropic value). If that's compelling, then the next thing to do would
be adding a `if (in_interrupt()) return;` early on in some function, and
then we forever after impose a rule, "never mix into the input pool
directly from an irq".

The other stance is that these input/disk events are relatively rare --
compared to, say, a storm of interrupts from a NIC -- so mixing into the
input pool from there isn't actually a problem, and we benefit from the
quasi domain-specific accounting and the superior mixing function,
there, so keep it around. And the non-raw spinlock on the input pool
won't negatively affect RT from this context, because all its callers on
RT should be threaded.

The second stance seems easier and more conservative from a certain
perspective -- we don't need to change anything -- so I'm more inclined
toward it. And given that you've fixed the bug now, it sounds like
that's fine with you too. But if you're thinking about it differently in
fact, let me know.

Jason
