Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5603559F117
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 03:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbiHXBit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 21:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiHXBir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 21:38:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DEC8A6D5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:38:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D3C3B8225D
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE797C43140
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661305123;
        bh=Gvvtn1u0RIXhBffV5Ro47CzVIUHMiwzddjAireiQsOY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qPlTq4XoLqLrTG1vZre+UqnUFuMUIrcvFkTqdzuB6TiKMngSvRoGYzrw0EGYA/2QC
         9Chhf5ltu+aJwF+ZnJX78rfv1tW9NPf0AgZVICzedlHX9p4StQvJbU5x1XStW2TzhF
         RblpPhknzO9tuZH7fycIbhY85wjyKESEuqLQ3y/KTCDUKA+W52z0BQFxXOKFy5dKqf
         vrsNQ2MWluKRDwwsMga1w8kEKwWD6CvXpoubgjYET2L7t1ep7SwRaq/tlNK++vwqxq
         Du/ZROZGAojef6N2r0E50gorXWtuOd1FcEEdPrwRK8AJr74RI0zTKemoVN+5hBWGWO
         gk1pqcD8AR6wQ==
Received: by mail-vs1-f44.google.com with SMTP id d126so16168353vsd.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:38:43 -0700 (PDT)
X-Gm-Message-State: ACgBeo0MQeL0Ic2FnzWWJpoGH4VSUGePuj5J7FsBzzxbJjvSH9dBiqDh
        iSPjWIiQpdX1nQWDlt4j0jPTix+I6624NP9AFEw=
X-Google-Smtp-Source: AA6agR6oXAmDdNb+wqfeTCMgPkSD+gWaba56jOWHft1AGp5Go9HbII0ziwxFQWvwtRaxVQ3AkRtz0x+U6txGDGnECGE=
X-Received: by 2002:a67:d483:0:b0:38f:4981:c4f3 with SMTP id
 g3-20020a67d483000000b0038f4981c4f3mr9970426vsj.59.1661305122473; Tue, 23 Aug
 2022 18:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <YwSRFzQQKAXP2ncp@debian> <CAHk-=wjn1=Gyi3Jxw4V0A=fXpOu5e1StPoyu52A6DHmbT+auzA@mail.gmail.com>
In-Reply-To: <CAHk-=wjn1=Gyi3Jxw4V0A=fXpOu5e1StPoyu52A6DHmbT+auzA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 24 Aug 2022 09:38:29 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6vvkuOzy8OemWdYK3taj5Jn3bFX0ZTwE=twM8ywpBUYA@mail.gmail.com>
Message-ID: <CAAhV-H6vvkuOzy8OemWdYK3taj5Jn3bFX0ZTwE=twM8ywpBUYA@mail.gmail.com>
Subject: Re: mainline build failure for loongarch allmodconfig with gcc-12
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, WANG Xuerui <kernel@xen0n.name>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Linus,

On Wed, Aug 24, 2022 at 2:09 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Aug 23, 2022 at 1:34 AM Sudip Mukherjee (Codethink)
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > I have been trying to build loongarch as part of my nightly builds, and
> > I can build loongson3_defconfig without any error. But allmodconfig fails
> > with the error:
> >
> > In function '__cmpxchg',
> >     inlined from 'ssh_seq_next' at drivers/platform/surface/aggregator/controller.c:61:9,
>
> Looks like ssh_seq_next() wants to do an atomic cmpxchg() on a single
> byte value, and the Loongarch implementation only does 4- and 8-byte
> versions.
>
> It looks like loongarch - from its MIPS heritage - inherited the "we
> can't do atomics on byte variables", so that it needs the same strange
> "do bytes as word accesses with mask-and-shifts".
>
> For MIPS, the code is in __xchg_small() in arch/mips/kernel/cmpxchg.c.
>
> Alpha has something similar, except it's all done in inline asm in
> arch/alpha/include/asm/xchg.h (look for "____cmpxchg(_u8," in there.
>
> Of course, we could just add a Kconfig variable like
> "ARCH_LACKS_BYTE_ATOMICS" and make that driver depend on it not being
> true, and just have Loongarch set it.
>
> But I think loongarch should just implement the byte masking stuff.
> Particularly since I suspect it can just copy the MIPS code as-is.
Yes, I agree. There is already a proposed patch to do this [1]. It was
discussed for a long time about the "forward progress", but I think
that problem is solved because LoongArch has "exclusive access (with
timeout) of ll" and "random delay of sc" in hardware. So I hope this
patch can be accepted now.

https://lore.kernel.org/loongarch/CAJF2gTQBjetiA1eDaXhBsiEmRYCdOAAWWAGcwVjhZTBYH5BpGQ@mail.gmail.com/T/#m9df7f86d9509cec23a66a0304152377e1070b62e

Huacai
>
>                   Linus
