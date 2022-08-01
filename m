Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148F95867B8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiHAKmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiHAKmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:42:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B10A19E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 03:41:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57512B80FA0
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0457CC433D7
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659350515;
        bh=ZeCOGnXliu5ypNvTsU5DYYWNIfpEa2N4VcqTWqS4qSM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T+oaPHp510IBIJsTzfFB9JewjxXKJ2fP8PeBpBFDXyFAYXj+mmB8NdOktitrwKyOj
         48kmxUG3zuxgKPd2pIP6RuwMz7rh/41JAf7EtwvkORrSjjuHz8+CgGarfCTiCIDefS
         EKUs3uc0v2XIGQFrbNhUVz2QZyz9jGzMsYDaqoR17nRjH09Apjo0TN0uzmvW3VszQ2
         TcqbUhoRMKvDq/Oj7jcCjuopSpuECgfW/CVUYP/VBdnnsTtKBVIQoqboezU+9AuAOX
         GLLSjS/hGq73BLVFUDdMErc1j//jVf1nvilbti6oCo1is6kl/zWvA0+zs1KNSvnPhR
         9CQcIkjU/fAgA==
Received: by mail-vs1-f42.google.com with SMTP id 125so10748343vsd.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 03:41:54 -0700 (PDT)
X-Gm-Message-State: AJIora+mM4hT/s2oIrN79rq91z9J1RGZG+OmdZeNVZf7mISqdWl3Thqh
        svq1RSGgnDBat7CMgmjeT4AmVc6gkg0tWUxiDoU=
X-Google-Smtp-Source: AGRyM1u7Mmx11zfQ4sfKovAvjYYMYqjaLSzeJQKQv2gsEXA6V9dL8+/Z6//uNZbsaYRK2wwzlsL9vxn0knufnG8XPXs=
X-Received: by 2002:a05:6102:dd4:b0:358:62b5:20a6 with SMTP id
 e20-20020a0561020dd400b0035862b520a6mr5488170vst.84.1659350513969; Mon, 01
 Aug 2022 03:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <32a74a218c76611f897fd1df1ad0059068621133.camel@xry111.site>
 <ec52fd49-4a30-15d9-3d32-fd7bc6d8b3f0@loongson.cn> <0179679b736aea7258981dec2d83107cce74dfc1.camel@xry111.site>
 <a139a8475fe295ac9f17064269cd0312dca6f96e.camel@xry111.site>
 <6b5d2188f93ed72b67a4bbb7116113f833fe1ee5.camel@xry111.site>
 <d7670b60-2782-4642-995b-7baa01779a66@loongson.cn> <7cad6e78014168a8906e130e1cf3809077d2bda7.camel@xry111.site>
 <1d0783b87bda3e454a111862fcc5b5faffcb16b0.camel@xry111.site>
 <00eede4b1380888a500f74b1e818bb25a550632b.camel@xry111.site>
 <7512ae16-b171-d072-674f-a6b9a5e764d6@loongson.cn> <CAAhV-H5wSJZ2X46ySqoaJd7Z2soGcYKRNixnghmE3f3zEzyS+w@mail.gmail.com>
 <10751c9af5d45fea741e0bbed6c818ddb9db3ac3.camel@xry111.site>
In-Reply-To: <10751c9af5d45fea741e0bbed6c818ddb9db3ac3.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 1 Aug 2022 18:41:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7oQkGVqZV_s7tXjDGBL9yQ+CsUkCv7tC+pWuW2MXe9LA@mail.gmail.com>
Message-ID: <CAAhV-H7oQkGVqZV_s7tXjDGBL9yQ+CsUkCv7tC+pWuW2MXe9LA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] LoongArch: Support new relocation types
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     Youling Tang <tangyouling@loongson.cn>, loongarch@lists.linux.dev,
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

Hi, Ruoyao,

On Mon, Aug 1, 2022 at 5:55 PM Xi Ruoyao <xry111@xry111.site> wrote:
>
> On Mon, 2022-08-01 at 10:34 +0800, Huacai Chen wrote:
> > Hi, all,
> >
> > On Mon, Aug 1, 2022 at 10:16 AM Youling Tang <tangyouling@loongson.cn>
> > wrote:
> > >
> > > Hi, Ruoyao
> > >
> > > On 07/30/2022 10:52 AM, Xi Ruoyao wrote:
> > > > On Sat, 2022-07-30 at 10:24 +0800, Xi Ruoyao wrote:
> > > > > On Sat, 2022-07-30 at 01:55 +0800, Xi Ruoyao wrote:
> > > > > > On Fri, 2022-07-29 at 20:19 +0800, Youling Tang wrote:
> > > > > >
> > > > > > > On 07/29/2022 07:45 PM, Xi Ruoyao wrote:
> > > > > > > > Hmm... The problem is the "addresses" of per-cpu symbols
> > > > > > > > are
> > > > > > > > faked: they
> > > > > > > > are actually offsets from $r21.  So we can't just load
> > > > > > > > such an
> > > > > > > > offset
> > > > > > > > with PCALA addressing.
> > > > > > > >
> > > > > > > > It looks like we'll need to introduce an attribute for GCC
> > > > > > > > to
> > > > > > > > make
> > > > > > > > an
> > > > > > > > variable "must be addressed via GOT", and add the
> > > > > > > > attribute into
> > > > > > > > PER_CPU_ATTRIBUTES.
> > > > > >
> > > > > > > Yes, we need a GCC attribute to specify the per-cpu
> > > > > > > variable.
> > > > > >
> > > > > > GCC patch adding "addr_global" attribute for LoongArch:
> > > > > > https://gcc.gnu.org/pipermail/gcc-patches/2022-July/599064.html
> > > > > >
> > > > > > An experiment to use it:
> > > > > > https://github.com/xry111/linux/commit/c1d5d70
> > > > >
> > > > > Correction: https://github.com/xry111/linux/commit/c1d5d708
> > > > >
> > > > > It seems 7-bit SHA is not enough for kernel repo.
> > > >
> > > > If addr_global is rejected or not implemented (for example,
> > > > building the
> > > > kernel with GCC 12), *I expect* the following hack to work (I've
> > > > not
> > > > tested it because I'm AFK now).  Using visibility in kernel seems
> > > > strange, but I think it may make some sense because the modules
> > > > are some
> > > > sort of similar to an ELF shared object being dlopen()'ed, and our
> > > > way
> > > > to inject per-CPU symbols is analog to ELF interposition.
> > > >
> > > > arch/loongarch/include/asm/percpu.h:
> > > >
> > > >    #if !__has_attribute(__addr_global__) && defined(MODULE)
> > > >    /* Magically remove "static" for per-CPU variables.  */
> > > >    # define ARCH_NEEDS_WEAK_PER_CPU
> > > >    /* Force GOT-relocation for per-CPU variables.  */
> > > >    # define PER_CPU_ATTRIBUTES
> > > > __attribute__((__visibility__("default")))
> > > >    #endif
> > > >
> > > > arch/loongarch/Makefile:
> > > >
> > > >    # Hack for per-CPU variables, see PER_CPU_ATTRIBUTES in
> > > >    # include/asm/percpu.h
> > > >    if (call gcc-does-not-support-addr-global)
> > > >      KBUILD_CFLAGS_MODULE += -fPIC -fvisibility=hidden
> > > >    endif
> > > >
> > > Using the old toolchain (GCC 12) can successfully load the
> > > nf_tables.ko
> > > module after applying the above patch.
> > I don't like such a hack..., can we consider using old relocation
> > types when building by old toolchains?
>
>
> I don't like the hack too.  I only developed it as an intellectual game.
>
> We need to consider multiple combinations:
>
> (1) Old GCC + old Binutils.  We need -mla-local-with-abs for
> KBUILD_CFLAGS_MODULE.
>
> (2) Old GCC + new Binutils.  We need -mla-local-with-abs for
> KBUILD_CFLAGS_MODULE, *and* adding the support for
> R_LARCH_ABS{_HI20,_LO12,64_LO20,64_HI12} in the kernel module loader.
>
> (3) New GCC + old Binutils.  As new GCC should support our new attribute
> (I now intend to send V2 patch to gcc-patches using "movable" as the
> attribute name), no special action is needed.
>
> Basically, we need:
>
> (1) Handle R_LARCH_ABS{_HI20,_LO12,64_LO20,64_HI12} in the kernel module
> loader.
> (2) Add -Wa,-mla-local-with-abs into KBUILD_CFLAGS_MODULE if GCC version
> is <= 12.
There is another simple solution: just refuse to build if the
toolchain is too old.

Huacai

> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
>
