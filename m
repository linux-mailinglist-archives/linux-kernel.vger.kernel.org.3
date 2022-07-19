Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F3757AA51
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 01:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237679AbiGSXOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 19:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiGSXOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 19:14:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AAA63910
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 16:14:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A00E9B81D0D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 23:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B1FC341C6;
        Tue, 19 Jul 2022 23:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1658272437;
        bh=L5uy3KHKIgaKuNoQ+k1PIKdYCBx322IETWpRn30VZL8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vS3AUKtyvUDiPNJUpNWXZbpJc3ggvVA8/DDdq9XUpTgTaxTdfTUBYHI/0xA3Yg3py
         Emrhi7WHgQoD9OaUgIet25oA0aytcS1SHctEHD34nvX4Y63rBLFOfljturqf1HNx+8
         BI9olIM2Q6hqRLmbHPfI7Ww+rPDEOx98r7mgb+fk=
Date:   Tue, 19 Jul 2022 16:13:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marco Elver <elver@google.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>, yee.lee@mediatek.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:KFENCE" <kasan-dev@googlegroups.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2 1/1] mm: kfence: apply kmemleak_ignore_phys on early
 allocated pool
Message-Id: <20220719161356.df8d7f6fc5414cc9cc7f8302@linux-foundation.org>
In-Reply-To: <CANpmjNPhhPUZFSZaLbwyJfACWMOqFchvm-Sx+iwGSM3sxkky8Q@mail.gmail.com>
References: <20220628113714.7792-1-yee.lee@mediatek.com>
        <20220628113714.7792-2-yee.lee@mediatek.com>
        <CAMuHMdX=MTsmo5ZVa8ya3xmr4Mx7f0PB3gvFF42pdaTYB6-u5A@mail.gmail.com>
        <20220715163305.e70c8542d5e7d96c5fd87185@linux-foundation.org>
        <CAMuHMdWSsibmL=LauLm+OTn0SByLA4tGsbhbMsnvSRdb381RTQ@mail.gmail.com>
        <CANpmjNPhhPUZFSZaLbwyJfACWMOqFchvm-Sx+iwGSM3sxkky8Q@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 16:26:25 +0200 Marco Elver <elver@google.com> wrote:

> On Sat, 16 Jul 2022 at 20:43, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> [...]
> > > - This patch has been accused of crashing the kernel:
> > >
> > >         https://lkml.kernel.org/r/YsFeUHkrFTQ7T51Q@xsang-OptiPlex-9020
> > >
> > >   Do we think that report is bogus?
> >
> > I think all of this is highly architecture-specific...
> 
> The report can be reproduced on i386 with CONFIG_X86_PAE=y. But e.g.
> mm/memblock.c:memblock_free() is also guilty of using __pa() on
> previously memblock_alloc()'d addresses. Looking at the phys addr
> before memblock_alloc() does virt_to_phys(), the result of __pa()
> looks correct even on PAE, at least for the purpose of passing it on
> to kmemleak(). So I don't know what that BUG_ON(slow_virt_to_phys() !=
> phys_addr) is supposed to tell us here.
> 

It's only been nine years, so I'm sure Dave can remember why he added
it ;)

		BUG_ON(slow_virt_to_phys((void *)x) != phys_addr);

in arch/x86/mm/physaddr.c:__phys_addr().


This kfence patch does seem to be desirable, but we can't proceed if
it's resulting in kernel crashes.

