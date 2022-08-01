Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69615862A8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbiHACe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237027AbiHACe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:34:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A83D12D18
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:34:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC631B80DD0
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8B0C43140
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659321262;
        bh=EfneEUvjIoNJJWXc+KdfORZ9jl55i2DJcu1ROCr2G2U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pr8KinnJoW+ynQVeLOeqw3R8Ujg43YomRM61cx0lBN4NkMuxGgUwnnR7wezo3tnH6
         lIsnlwXG+ElGV4D8L9h5OIYQFbvsLfS1OxVvXYTSO35UY008ssvqLHbYs5jAiKiqpu
         /G/Hca/KdxgXPHbRREWbbx+v0axtO9nWFLarE9cNaRJ8nTxXIoyTEkatFyJQFis5T+
         8xt33I0kGBIeMAxSkyaaXN5rimMnsWgFwNmpcVHbDXJdkT/XJppAgkvHNtqXV8Sxd+
         /6e2zfdVFgj+6ijZRL2iWE5ltNklh3s21tAgzJXtlf3tPgtklmtlW5qAKZ5RO+DRSZ
         uDVOpR7O+h9CA==
Received: by mail-vk1-f177.google.com with SMTP id l13so746125vka.12
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:34:22 -0700 (PDT)
X-Gm-Message-State: AJIora85lLUjKePPU7GwDFiahNLc+1W8kwiOw6vSfV45GXS4NQDHNfTW
        F3ANNgtHkvvQRjgyjS8sVpC7Lvr24+O03ItJS3A=
X-Google-Smtp-Source: AGRyM1uOwehDUHMO42ycTwCYtTO8K3mSE3snjtFJoyunNuvNjFalafRxgmeSxn1BvyIUbt6wXZF+2EsR7coMx/YJR/s=
X-Received: by 2002:a1f:a502:0:b0:376:8deb:2b40 with SMTP id
 o2-20020a1fa502000000b003768deb2b40mr5194206vke.35.1659321261400; Sun, 31 Jul
 2022 19:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <32a74a218c76611f897fd1df1ad0059068621133.camel@xry111.site>
 <ec52fd49-4a30-15d9-3d32-fd7bc6d8b3f0@loongson.cn> <0179679b736aea7258981dec2d83107cce74dfc1.camel@xry111.site>
 <a139a8475fe295ac9f17064269cd0312dca6f96e.camel@xry111.site>
 <6b5d2188f93ed72b67a4bbb7116113f833fe1ee5.camel@xry111.site>
 <d7670b60-2782-4642-995b-7baa01779a66@loongson.cn> <7cad6e78014168a8906e130e1cf3809077d2bda7.camel@xry111.site>
 <1d0783b87bda3e454a111862fcc5b5faffcb16b0.camel@xry111.site>
 <00eede4b1380888a500f74b1e818bb25a550632b.camel@xry111.site> <7512ae16-b171-d072-674f-a6b9a5e764d6@loongson.cn>
In-Reply-To: <7512ae16-b171-d072-674f-a6b9a5e764d6@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 1 Aug 2022 10:34:07 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5wSJZ2X46ySqoaJd7Z2soGcYKRNixnghmE3f3zEzyS+w@mail.gmail.com>
Message-ID: <CAAhV-H5wSJZ2X46ySqoaJd7Z2soGcYKRNixnghmE3f3zEzyS+w@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] LoongArch: Support new relocation types
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jinyang He <hejinyang@loongson.cn>,
        Lulu Cheng <chenglulu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

On Mon, Aug 1, 2022 at 10:16 AM Youling Tang <tangyouling@loongson.cn> wrote:
>
> Hi, Ruoyao
>
> On 07/30/2022 10:52 AM, Xi Ruoyao wrote:
> > On Sat, 2022-07-30 at 10:24 +0800, Xi Ruoyao wrote:
> >> On Sat, 2022-07-30 at 01:55 +0800, Xi Ruoyao wrote:
> >>> On Fri, 2022-07-29 at 20:19 +0800, Youling Tang wrote:
> >>>
> >>>> On 07/29/2022 07:45 PM, Xi Ruoyao wrote:
> >>>>> Hmm... The problem is the "addresses" of per-cpu symbols are
> >>>>> faked: they
> >>>>> are actually offsets from $r21.  So we can't just load such an
> >>>>> offset
> >>>>> with PCALA addressing.
> >>>>>
> >>>>> It looks like we'll need to introduce an attribute for GCC to
> >>>>> make
> >>>>> an
> >>>>> variable "must be addressed via GOT", and add the attribute into
> >>>>> PER_CPU_ATTRIBUTES.
> >>>
> >>>> Yes, we need a GCC attribute to specify the per-cpu variable.
> >>>
> >>> GCC patch adding "addr_global" attribute for LoongArch:
> >>> https://gcc.gnu.org/pipermail/gcc-patches/2022-July/599064.html
> >>>
> >>> An experiment to use it:
> >>> https://github.com/xry111/linux/commit/c1d5d70
> >>
> >> Correction: https://github.com/xry111/linux/commit/c1d5d708
> >>
> >> It seems 7-bit SHA is not enough for kernel repo.
> >
> > If addr_global is rejected or not implemented (for example, building the
> > kernel with GCC 12), *I expect* the following hack to work (I've not
> > tested it because I'm AFK now).  Using visibility in kernel seems
> > strange, but I think it may make some sense because the modules are some
> > sort of similar to an ELF shared object being dlopen()'ed, and our way
> > to inject per-CPU symbols is analog to ELF interposition.
> >
> > arch/loongarch/include/asm/percpu.h:
> >
> >    #if !__has_attribute(__addr_global__) && defined(MODULE)
> >    /* Magically remove "static" for per-CPU variables.  */
> >    # define ARCH_NEEDS_WEAK_PER_CPU
> >    /* Force GOT-relocation for per-CPU variables.  */
> >    # define PER_CPU_ATTRIBUTES __attribute__((__visibility__("default")))
> >    #endif
> >
> > arch/loongarch/Makefile:
> >
> >    # Hack for per-CPU variables, see PER_CPU_ATTRIBUTES in
> >    # include/asm/percpu.h
> >    if (call gcc-does-not-support-addr-global)
> >      KBUILD_CFLAGS_MODULE += -fPIC -fvisibility=hidden
> >    endif
> >
> Using the old toolchain (GCC 12) can successfully load the nf_tables.ko
> module after applying the above patch.
I don't like such a hack..., can we consider using old relocation
types when building by old toolchains?

Huacai
>
> Thanks,
> Youling
>
