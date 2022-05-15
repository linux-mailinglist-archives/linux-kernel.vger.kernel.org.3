Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519555275DE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 07:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbiEOF27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 01:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiEOF24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 01:28:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ACE2ADE
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 22:28:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8136B80AF4
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 05:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91874C385B8;
        Sun, 15 May 2022 05:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652592532;
        bh=SpKDu6aHLnyStI7ayt2jfV3MbCZDcJojYH368H8D2ow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z0rOVFNTMYqljGG8dTDdzAGnekqM0MDikIwjJ9XF+1zVBpl6k8f2tiJy7TTDrLN1Q
         Yza5uVixAuAhtxoR8DHtP778uJaiWzIxs3jiRuUEJDUQPNY0yLfVTnrao77p3EKMLk
         JtiPWUVJhbZDV57AXyZCwJn1a1Ds6vvukvpp0Hcb93j0G30ez2gxaniNqzbgPRb8E6
         s+TCYbOCqv6XaSsVqDwA0LPvME/IoWyCAs7Kbvci4a6zUBY6mLTOWkoIGOfVhdnbXn
         kRcuRDk1aIW1adt33P5QXHPeNF+WcJQ7YtNX0AaErZnPBgWwJVEsaNNhWdraHxuZuI
         Byor57WxNJt3A==
Date:   Sun, 15 May 2022 13:20:21 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] riscv: add irq stack support
Message-ID: <YoCNlWGUp02hgP27@xhacker>
References: <20220307140804.1400-1-jszhang@kernel.org>
 <f7f46323619e4084b4cfc551cdb47dd0@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f7f46323619e4084b4cfc551cdb47dd0@AcuMS.aculab.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 02:32:34PM +0000, David Laight wrote:
> From: Jisheng Zhang
> > Sent: 07 March 2022 14:08
> > Currently, IRQs are still handled on the kernel stack of the current
> > task on riscv platforms. If the task has a deep call stack at the time
> > of interrupt, and handling the interrupt also requires a deep stack,
> > it's possible to see stack overflow.
> > 
> ...
> I'd have thought that a single page is (probably) enough for the
> IRQ stack.
> Certainly its sizing isn't really related to the normal thread
> stack size.
> 
> > From another side, after this patch, it's possible to reduce the
> > THREAD_SIZE to 8KB for RV64 platforms. This is especially useful for
> > those systems with small memory size, e.g the Allwinner D1S platform
> > which is RV64 but only has 64MB DDR.
> 
> Are you sure?
> Is the stack use likely to be very much less than that of x86-64?
> The real problem isn't the stack use of the test you are doing,
> but the horrid worst case stack of some path that has multiple
> 1k+ buffers on stack.

Hi David,

Sorry for delay. I think you are right, at least I should not
put the confusing "it's possible to reduce the THREAD_SIZE to 8KB
for RV64 platforms..." in the commit msg. For one thing, the 8KB
IRQ stack isn't available in the mainline w/o a small patch; For
another, I only do tests on Allwinner D1 platform. So I remove the
section in V3's commit msg.

Thanks

> 
> Apart from compiler fubar (which usually hit KASAN) that stack
> is actually likely to be architecture independent.
> (The difference between 32bit and 64bit is also likely to be
> relatively small - unless there are on-stack arrays of 'long'.)
> 
> For VMAP stacks is there a 'guard' KVA page allocated below
> all of the stacks?
> 64bit systems should have lots of KVA so this shouldn't be
> a problem.
> Then stack overruns will fault and panic rather than trashing
> another data area - which is really hard to debug.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
