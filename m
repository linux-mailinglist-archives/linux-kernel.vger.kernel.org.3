Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ACB534EEE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346513AbiEZMPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiEZMPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:15:11 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97D9C6E51
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:15:09 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L86MB4xFWz4xXj;
        Thu, 26 May 2022 22:15:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1653567305;
        bh=qdGxLuOgWLxtGXOKT8uILQNK4Btl7FJ5JZwGbkMtGZY=;
        h=From:To:Cc:Subject:In-Reply-To:Date:From;
        b=gy/HsX4BcAReBDnH2meEdqv0xBEOfx6GpCJHtCRxUA2TaJxbHBPmt8AFbY5T6mec0
         pnpSvVoevK98Fo9Y7mkImcHOTfpnXb8bh1O1uVXiJv5Voaey3zNbeOZ976zjqL3heV
         qyOGYloDmu8j75LG/AEkilOAokL7NxLBEHGStWN065+jzpvOsREi/uA9KlURYKY1Dm
         eM6wktQ9ce7mUGpT7h6+mqQsLE1OfnCgb24rnWz+DbMrPz2DvsFZ9fuzhp94HJDw9Y
         o7M0+NMfHXpYF1/iec34epetlmqqblvv3oxZqreh7iA06fLjXXdSkVtXKqZzeU7GW2
         B4FcFh50RkD7A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Waiman.Long@hp.com,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] locking/lockref: Use try_cmpxchg64 in CMPXCHG_LOOP
 macro
In-Reply-To: <CAHk-=wh1XeaxWXG5QziGA4ds918UnW1hO924kusgVB-wGj+9Og@mail.gmail.com>
Date:   Thu, 26 May 2022 22:14:59 +1000
Message-ID: <871qwgmqws.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Wed, May 25, 2022 at 7:40 AM Uros Bizjak <ubizjak@gmail.com> wrote:
>>
>> Use try_cmpxchg64 instead of cmpxchg64 in CMPXCHG_LOOP macro.
>> x86 CMPXCHG instruction returns success in ZF flag, so this
>> change saves a compare after cmpxchg (and related move instruction
>> in front of cmpxchg). The main loop of lockref_get improves from:
>
> Ack on this one regardless of the 32-bit x86 question.
>
> HOWEVER.
>
> I'd like other architectures to pipe up too, because I think right now
> x86 is the only one that implements that "arch_try_cmpxchg()" family
> of operations natively, and I think the generic fallback for when it
> is missing might be kind of nasty.
>
> Maybe it ends up generating ok code, but it's also possible that it
> just didn't matter when it was only used in one place in the
> scheduler.

This patch seems to generate slightly *better* code on powerpc.

I see one register-to-register move that gets shifted slightly later, so
that it's skipped on the path that returns directly via the SUCCESS
case.

So LGTM.

> The lockref_get() case can be quite hot under some loads, it would be
> sad if this made other architectures worse.

Do you know of a benchmark that shows it up? I tried a few things but
couldn't get lockref_get() to count for more than 1-2%.

cheers
