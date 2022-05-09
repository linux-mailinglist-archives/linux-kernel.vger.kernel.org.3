Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69D951FFE2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237385AbiEIOiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237061AbiEIOix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:38:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186CF2A76B5
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 07:35:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3C6F615FA
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 14:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AC8C385AF;
        Mon,  9 May 2022 14:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652106899;
        bh=vfDKNwLVPbOGrvBsC/bFHFyH9ByxjZk7Ny2bY3inWbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uQMwhwbUUnAYDeU++/wgIqkeNZBLHJbf4vMQP3gzxkpB844FBoWNBm7/rABZXhYbb
         y80q28vwC0lHQsVKNbnuRokPCXjavY1s3HiZRWGfLa9iqs17PEVV4J8svIomw/wlm+
         Sq0ef9UE3VvBex/8y+iXuEkyOlM7ebQRcemtcw9krX5jZV11zF8a5T0S/dM2RyAgK4
         0ruHLnRwU5TYL7hKuRvGeQkBQmaHSFj+4rNF+RNQh45T4GAOuD8nnKrelvJXHdrLuU
         MuntnYMOO70yE1B9QhQTsn75W0OfuIC4nsU461yplhBtOmr4MZ64PkiY4oxbrvFiVD
         Jd10kMiGCcfZA==
Date:   Mon, 9 May 2022 22:26:20 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v2 0/4] unified way to use static key and optimize
 pgtable_l4_enabled
Message-ID: <YnkkjC065kCTtHBC@xhacker>
References: <20220508160749.984-1-jszhang@kernel.org>
 <CAAhSdy1qri5L9pVcZO8areB=TXMSJBg2+cTNMZGQ3g+3Qhxmfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAhSdy1qri5L9pVcZO8areB=TXMSJBg2+cTNMZGQ3g+3Qhxmfg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 10:07:16AM +0530, Anup Patel wrote:
> On Sun, May 8, 2022 at 9:46 PM Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > Currently, riscv has several features which may not be supported on all
> > riscv platforms, for example, FPU, SV48, SV57 and so on. To support
> > unified kernel Image style, we need to check whether the feature is
> > suportted or not. If the check sits at hot code path, then performance
> > will be impacted a lot. static key can be used to solve the issue. In
> > the past, FPU support has been converted to use static key mechanism.
> > I believe we will have similar cases in the future. For example, the
> > SV48 support can take advantage of static key[1].
> >
> > patch1 is a simple W=1 warning fix.
> > patch2 introduces an unified mechanism to use static key for riscv cpu
> > features.
> > patch3 converts has_cpu() to use the mechanism.
> > patch4 uses the mechanism to optimize pgtable_l4|[l5]_enabled.
> >
> > [1] http://lists.infradead.org/pipermail/linux-riscv/2021-December/011164.html
> 
> Overall, using a script to generate CPU capabilities seems a bit
> over-engineered to me. We already have RISC-V ISA extension

Not all riscv features are *ISA* extensions. For example, SV48 and SV57
are not ISA extensions. IIRC, I asked this question before, here are
Atish's comments:

https://lore.kernel.org/linux-riscv/CAHBxVyF65jC_wvxcD6bueqpCY8-Kbahu1yxsSoBmO1s15dGkSQ@mail.gmail.com/

> parsing infrastructure which can be easily extended to support
> static key arrays.
> 

