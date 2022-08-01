Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAFA586727
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiHAJzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiHAJze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:55:34 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE67A456
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1659347731;
        bh=FR/txEqoWPrIigVkHFZzkPXBbv8QXt0Khc3wKvIA9kw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OIHY5amPN4Wd08csTgQgnpbEvdK0IJnf74jdAJOMBBtCHCNHLyBoEYbDBXbzmi5Fh
         Oao6nweN1BCC9zKBnqGs8L6W0HftkL4rfqyN2GuhXi37/Yl5I9ePgxN7wQHXoupcl4
         E7hJ5j80LQn0aUddpFC9kCa8eioKxqBAZ6qNwJ2g=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 0558A66787;
        Mon,  1 Aug 2022 05:55:28 -0400 (EDT)
Message-ID: <10751c9af5d45fea741e0bbed6c818ddb9db3ac3.camel@xry111.site>
Subject: Re: [PATCH v4 0/4] LoongArch: Support new relocation types
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jinyang He <hejinyang@loongson.cn>,
        Lulu Cheng <chenglulu@loongson.cn>
Date:   Mon, 01 Aug 2022 17:55:26 +0800
In-Reply-To: <CAAhV-H5wSJZ2X46ySqoaJd7Z2soGcYKRNixnghmE3f3zEzyS+w@mail.gmail.com>
References: <32a74a218c76611f897fd1df1ad0059068621133.camel@xry111.site>
         <ec52fd49-4a30-15d9-3d32-fd7bc6d8b3f0@loongson.cn>
         <0179679b736aea7258981dec2d83107cce74dfc1.camel@xry111.site>
         <a139a8475fe295ac9f17064269cd0312dca6f96e.camel@xry111.site>
         <6b5d2188f93ed72b67a4bbb7116113f833fe1ee5.camel@xry111.site>
         <d7670b60-2782-4642-995b-7baa01779a66@loongson.cn>
         <7cad6e78014168a8906e130e1cf3809077d2bda7.camel@xry111.site>
         <1d0783b87bda3e454a111862fcc5b5faffcb16b0.camel@xry111.site>
         <00eede4b1380888a500f74b1e818bb25a550632b.camel@xry111.site>
         <7512ae16-b171-d072-674f-a6b9a5e764d6@loongson.cn>
         <CAAhV-H5wSJZ2X46ySqoaJd7Z2soGcYKRNixnghmE3f3zEzyS+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-08-01 at 10:34 +0800, Huacai Chen wrote:
> Hi, all,
>=20
> On Mon, Aug 1, 2022 at 10:16 AM Youling Tang <tangyouling@loongson.cn>
> wrote:
> >=20
> > Hi, Ruoyao
> >=20
> > On 07/30/2022 10:52 AM, Xi Ruoyao wrote:
> > > On Sat, 2022-07-30 at 10:24 +0800, Xi Ruoyao wrote:
> > > > On Sat, 2022-07-30 at 01:55 +0800, Xi Ruoyao wrote:
> > > > > On Fri, 2022-07-29 at 20:19 +0800, Youling Tang wrote:
> > > > >=20
> > > > > > On 07/29/2022 07:45 PM, Xi Ruoyao wrote:
> > > > > > > Hmm... The problem is the "addresses" of per-cpu symbols
> > > > > > > are
> > > > > > > faked: they
> > > > > > > are actually offsets from $r21.=C2=A0 So we can't just load
> > > > > > > such an
> > > > > > > offset
> > > > > > > with PCALA addressing.
> > > > > > >=20
> > > > > > > It looks like we'll need to introduce an attribute for GCC
> > > > > > > to
> > > > > > > make
> > > > > > > an
> > > > > > > variable "must be addressed via GOT", and add the
> > > > > > > attribute into
> > > > > > > PER_CPU_ATTRIBUTES.
> > > > >=20
> > > > > > Yes, we need a GCC attribute to specify the per-cpu
> > > > > > variable.
> > > > >=20
> > > > > GCC patch adding "addr_global" attribute for LoongArch:
> > > > > https://gcc.gnu.org/pipermail/gcc-patches/2022-July/599064.html
> > > > >=20
> > > > > An experiment to use it:
> > > > > https://github.com/xry111/linux/commit/c1d5d70
> > > >=20
> > > > Correction: https://github.com/xry111/linux/commit/c1d5d708
> > > >=20
> > > > It seems 7-bit SHA is not enough for kernel repo.
> > >=20
> > > If addr_global is rejected or not implemented (for example,
> > > building the
> > > kernel with GCC 12), *I expect* the following hack to work (I've
> > > not
> > > tested it because I'm AFK now).=C2=A0 Using visibility in kernel seem=
s
> > > strange, but I think it may make some sense because the modules
> > > are some
> > > sort of similar to an ELF shared object being dlopen()'ed, and our
> > > way
> > > to inject per-CPU symbols is analog to ELF interposition.
> > >=20
> > > arch/loongarch/include/asm/percpu.h:
> > >=20
> > > =C2=A0=C2=A0 #if !__has_attribute(__addr_global__) && defined(MODULE)
> > > =C2=A0=C2=A0 /* Magically remove "static" for per-CPU variables.=C2=
=A0 */
> > > =C2=A0=C2=A0 # define ARCH_NEEDS_WEAK_PER_CPU
> > > =C2=A0=C2=A0 /* Force GOT-relocation for per-CPU variables.=C2=A0 */
> > > =C2=A0=C2=A0 # define PER_CPU_ATTRIBUTES
> > > __attribute__((__visibility__("default")))
> > > =C2=A0=C2=A0 #endif
> > >=20
> > > arch/loongarch/Makefile:
> > >=20
> > > =C2=A0=C2=A0 # Hack for per-CPU variables, see PER_CPU_ATTRIBUTES in
> > > =C2=A0=C2=A0 # include/asm/percpu.h
> > > =C2=A0=C2=A0 if (call gcc-does-not-support-addr-global)
> > > =C2=A0=C2=A0=C2=A0=C2=A0 KBUILD_CFLAGS_MODULE +=3D -fPIC -fvisibility=
=3Dhidden
> > > =C2=A0=C2=A0 endif
> > >=20
> > Using the old toolchain (GCC 12) can successfully load the
> > nf_tables.ko
> > module after applying the above patch.
> I don't like such a hack..., can we consider using old relocation
> types when building by old toolchains?


I don't like the hack too.  I only developed it as an intellectual game.

We need to consider multiple combinations:

(1) Old GCC + old Binutils.  We need -mla-local-with-abs for
KBUILD_CFLAGS_MODULE.

(2) Old GCC + new Binutils.  We need -mla-local-with-abs for
KBUILD_CFLAGS_MODULE, *and* adding the support for
R_LARCH_ABS{_HI20,_LO12,64_LO20,64_HI12} in the kernel module loader.

(3) New GCC + old Binutils.  As new GCC should support our new attribute
(I now intend to send V2 patch to gcc-patches using "movable" as the
attribute name), no special action is needed.

Basically, we need:

(1) Handle R_LARCH_ABS{_HI20,_LO12,64_LO20,64_HI12} in the kernel module
loader.
(2) Add -Wa,-mla-local-with-abs into KBUILD_CFLAGS_MODULE if GCC version
is <=3D 12.=20
--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
