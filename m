Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412244B31EF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 01:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354392AbiBLA0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 19:26:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236867AbiBLA0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 19:26:11 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2E1D7C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 16:26:05 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id e5so1828013ybn.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 16:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TwfljNfMHD+ROgrVmWHwXMijBcE+NYQY1La/QegqtZY=;
        b=FDgBqxKegyWCQLE5sxJsMSZUIKa59oF+XnUvbuOBeXizg+bd9EG/rtZgkx9RbV8V1f
         KmtVrozhrpmTquVjXvbFJ3t1D1B9O/z3tx9SYJUlHOSIWRYND5nzNLZAGYVQinyEP63q
         Th5uri6WKp1a6BGwJlTCQaXd6Op5asK9hidI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TwfljNfMHD+ROgrVmWHwXMijBcE+NYQY1La/QegqtZY=;
        b=IodumgX4wM7KYTrmXADUuUj0Cna/EXB0C0xzsZ20WNzIBROVyZUwXjnreC4RPDb0hk
         rnBbiUl9r4wYIFEqBfV/ryIemG/3Wc0KHSrYvWLnCJ51t/HYsSSc8/iGyz/iQRYfMdNx
         qGiM6ELaX5jXkl6Hul/S+3x2HvsUMLNYV289CIyx4QS0QxwB932m7/mYH7xuLiiuH6MA
         bvHtzRql0mpG4cXLtNJPLGMv5wvWDBPRAHRnIJV7MRuAErZk4uA5CNQdR7J9aeiXUk0T
         2kP3VwRQLqKkbHTIHYmua+MuJ/dy2fiEcLFy8jvA8jZituXUmvFyhEIDpzCEUS9Tf2JH
         HrdQ==
X-Gm-Message-State: AOAM530uJLVQpjHfOiYa6W51uDzAMV9aOzSDkFHVqDhuzB0BNwwtfYKm
        R6bJQCOs3KhoZ0Lzz4Nl8TQoW4VQcUFhb9P8ZXjs
X-Google-Smtp-Source: ABdhPJzBHst7CoCQY9NFe3GF3R4Rg8pLpj3xYCBQBLznc9okb/4xkcE1HZ2a+26udyZyk1y5W37pKGl9tctjaguK/FQ=
X-Received: by 2002:a81:1a0c:: with SMTP id a12mr4602965ywa.271.1644625564243;
 Fri, 11 Feb 2022 16:26:04 -0800 (PST)
MIME-Version: 1.0
References: <20220209123800.269774-1-heiko@sntech.de> <CAOnJCUL5w4+_zJvu-BxP+LGN2ohv6arY+uh0DOU586v_5mCE8g@mail.gmail.com>
 <CAOnJCUKzE3uBfu0Aqpr19b-XB76qY7qtaeK87FF7H4Tw5B+d_Q@mail.gmail.com> <2177281.3HUnQTRebA@diego>
In-Reply-To: <2177281.3HUnQTRebA@diego>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 11 Feb 2022 16:25:53 -0800
Message-ID: <CAOnJCUJX9bmPDN1S+dhjCi1RE5D=d2yHeHmfy9y8NLWrDDazvQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/14] riscv: support for Svpbmt and D1 memory types
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Wei Fu <wefu@redhat.com>,
        liush <liush@allwinnertech.com>, Guo Ren <guoren@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Drew Fustini <drew@beagleboard.org>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 6:04 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Freitag, 11. Februar 2022, 02:48:38 CET schrieb Atish Patra:
> > On Thu, Feb 10, 2022 at 4:25 PM Atish Patra <atishp@atishpatra.org> wro=
te:
> > >
> > > On Wed, Feb 9, 2022 at 4:38 AM Heiko Stuebner <heiko@sntech.de> wrote=
:
> > > >
> > > > Svpbmt is an extension defining "Supervisor-mode: page-based memory=
 types"
> > > > for things like non-cacheable pages or I/O memory pages.
> > > >
> > > >
> > > > So this is my 2nd try at implementing Svpbmt (and the diverging D1 =
memory
> > > > types) using the alternatives framework.
> > > >
> > > > This includes a number of changes to the alternatives mechanism its=
elf.
> > > > The biggest one being the move to a more central location, as I exp=
ect
> > > > in the future, nearly every chip needing some sort of patching, be =
it
> > > > either for erratas or for optional features (svpbmt or others).
> > > >
> > > > The dt-binding for svpbmt itself is of course not finished and is s=
till
> > > > using the binding introduced in previous versions, as where to put
> > > > a svpbmt-property in the devicetree is still under dicussion.
> > > > Atish seems to be working on a framework for extensions [0],
> > > >
> > >
> > > Here is the patch series
> > > https://lore.kernel.org/lkml/20220210214018.55739-1-atishp@rivosinc.c=
om/
> > >
> > > I think we can simplify the cpu feature probing in PATCH 10 with the
> > > above series
> > > which simply relies on the existing riscv_isa bitmap.
> > >
> > > We also don't need the separate svpbmt property in DT mmu node.
> > > Let me know what you think.
> > >
> > > > The series also introduces support for the memory types of the D1
> > > > which are implemented differently to svpbmt. But when patching anyw=
ay
> > > > it's pretty clean to add the D1 variant via ALTERNATIVE_2 to the sa=
me
> > > > location.
> > > >
> > > > The only slightly bigger difference is that the "normal" type is no=
t 0
> > > > as with svpbmt, so kernel patches for this PMA type need to be appl=
ied
> > > > even before the MMU is brought up, so the series introduces a separ=
ate
> > > > stage for that.
> > > >
> > > >
> > > > In theory this series is 3 parts:
> > > > - sbi cache-flush / null-ptr
> > > > - alternatives improvements
> > > > - svpbmt+d1
> > > >
> > > > So expecially patches from the first 2 areas could be applied when
> > > > deemed ready, I just thought to keep it together to show-case where
> > > > the end-goal is and not requiring jumping between different series.
> > > >
> > > >
> > > > The sbi cache-flush patch is based on Atish's sparse-hartid patch [=
1],
> > > > as it touches a similar area in mm/cacheflush.c
> > > >
> > > >
> > > > I picked the recipient list from the previous version, hopefully
> > > > I didn't forget anybody.
> > > >
> >
> > I am also getting a load access fault while booting this series in Qemu=
.
> >
> > <with additional debug message when before sbi_trap_redirect in OpenSBI=
>
> > sbi_trap_error_debug: hart1: trap handler failed (error -2)
> > sbi_trap_error_debug: hart1: mcause=3D0x0000000000000005 mtval=3D0x0000=
000080046468
> > sbi_trap_error_debug: hart1: mtval2=3D0x0000000000000000 mtinst=3D0x000=
0000000000000
> > sbi_trap_error_debug: hart1: mepc=3D0x000000008080a8b8 mstatus=3D0x0000=
000a00000800
> > sbi_trap_error_debug: hart1: ra=3D0x0000000080202b06 sp=3D0x00000000812=
03f00
> > sbi_trap_error_debug: hart1: gp=3D0x00000000812d9db8 tp=3D0x00000000800=
46000
> > sbi_trap_error_debug: hart1: s0=3D0x0000000081203f80 s1=3D0x0000000080c=
1a8a8
> > sbi_trap_error_debug: hart1: a0=3D0x0000000080c1a8a8 a1=3D0x0000000080c=
1b0d0
> > sbi_trap_error_debug: hart1: a2=3D0x0000000000000002 a3=3D0x00000000000=
00000
> > sbi_trap_error_debug: hart1: a4=3D0x00000000812da902 a5=3D0x00000000000=
00000
> > sbi_trap_error_debug: hart1: a6=3D0x0000000000000006 a7=3D0x00000000000=
00010
> > sbi_trap_error_debug: hart1: s2=3D0x0000000080c1b0d0 s3=3D0x00000000000=
00002
> > sbi_trap_error_debug: hart1: s4=3D0x00000000bf000000 s5=3D0x00000000000=
00000
> > sbi_trap_error_debug: hart1: s6=3D0x8000000a00006800 s7=3D0x00000000000=
0007f
> > sbi_trap_error_debug: hart1: s8=3D0x0000000080018038 s9=3D0x00000000800=
39eac
> > sbi_trap_error_debug: hart1: s10=3D0x0000000000000000 s11=3D0x000000000=
0000000
> > sbi_trap_error_debug: hart1: t0=3D0x0000000080c04000 t1=3D0x00000000000=
00002
> > sbi_trap_error_debug: hart1: t2=3D0x0000000000001000 t3=3D0x00000000000=
00010
> > sbi_trap_error_debug: hart1: t4=3D0x00000000800168be t5=3D0x00000000000=
00027
> > sbi_trap_error_debug: hart1: t6=3D0x0000000000000001
> >
> > mepc : 0x000000008080a8b8 - call_function_init (kernel/smp.c)
> >
> > Kernel - 5.17-rc2 + my patches
> > Qemu - Alistairs next tree + my patches
>
> very strange. I was testing of course with Qemu as well, though never saw
> anything like this.
>
> But of course it was Qemu master + the then still pending svpbmt patchset=
 [0]
> [looks like Alistair applied this today] + a patch that made qemu insert =
the
> svpbmt dt-property for the virt machine.
>
> Oh ... just to make sure, did you enable the svpbmt parameter when starti=
ng
> Qemu? (-cpu ...,svpbmt=3Dtrue)
>

Yeah. I tried with or without. It's failing in both cases. I found a
fix but that may be unrelated and hiding the real issue.
Marking the cpufeature_svpbmt_check_of functions inline allows me to boot.

Here is my analysis:

Here is the trace of the trap:
sbi_trap_error_debug: hart0: trap handler failed (error -2)
sbi_trap_error_debug: hart0: mcause=3D0x0000000000000005 mtval=3D0x00000000=
80048468
sbi_trap_error_debug: hart0: mtval2=3D0x0000000000000000 mtinst=3D0x0000000=
000000000
sbi_trap_error_debug: hart0: mepc=3D0x000000008080a8b8 mstatus=3D0x0000000a=
00000800
sbi_trap_error_debug: hart0: ra=3D0x0000000080202b06 sp=3D0x0000000081203f0=
0
sbi_trap_error_debug: hart0: gp=3D0x00000000812d9db8 tp=3D0x000000008004800=
0
sbi_trap_error_debug: hart0: s0=3D0x0000000081203f80 s1=3D0x0000000080c1a8a=
8
sbi_trap_error_debug: hart0: a0=3D0x0000000080c1a8a8 a1=3D0x0000000080c1b0d=
0
sbi_trap_error_debug: hart0: a2=3D0x0000000000000002 a3=3D0x000000000000000=
0
sbi_trap_error_debug: hart0: a4=3D0x00000000812da902 a5=3D0x000000000000000=
0
sbi_trap_error_debug: hart0: a6=3D0x0000000000000006 a7=3D0x000000000000001=
0
sbi_trap_error_debug: hart0: s2=3D0x0000000080c1b0d0 s3=3D0x000000000000000=
2
sbi_trap_error_debug: hart0: s4=3D0x00000000bf000000 s5=3D0x000000000000000=
0
sbi_trap_error_debug: hart0: s6=3D0x8000000a00006800 s7=3D0x000000000000007=
f
sbi_trap_error_debug: hart0: s8=3D0x0000000080018038 s9=3D0x0000000080039ea=
8
sbi_trap_error_debug: hart0: s10=3D0x0000000000000000 s11=3D0x0000000000000=
000
sbi_trap_error_debug: hart0: t0=3D0x0000000080c04000 t1=3D0x000000000000000=
2
sbi_trap_error_debug: hart0: t2=3D0x0000000000001000 t3=3D0x000000000000001=
0
sbi_trap_error_debug: hart0: t4=3D0x00000000800168be t5=3D0x000000000000002=
7
sbi_trap_error_debug: hart0: t6=3D0x0000000000000001

mepc : 0x000000008080a8b8 - should be ffffffff8060a8b8 in objdump
output after offset

Here is the snippet of the objdump output for riscv_cpufeature_patch_func

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
inline output: (booting fails with above dump)

void riscv_cpufeature_patch_func(struct alt_entry *begin, struct alt_entry =
*end,
                                 unsigned int stage)
{
ffffffff8060a89a:       7119                    addi    sp,sp,-128
ffffffff8060a89c:       f8a2                    sd      s0,112(sp)
ffffffff8060a89e:       f4a6                    sd      s1,104(sp)
ffffffff8060a8a0:       f0ca                    sd      s2,96(sp)
ffffffff8060a8a2:       e4d6                    sd      s5,72(sp)
ffffffff8060a8a4:       fc86                    sd      ra,120(sp)
ffffffff8060a8a6:       ecce                    sd      s3,88(sp)
ffffffff8060a8a8:       e8d2                    sd      s4,80(sp)
ffffffff8060a8aa:       e0da                    sd      s6,64(sp)
ffffffff8060a8ac:       fc5e                    sd      s7,56(sp)
ffffffff8060a8ae:       f862                    sd      s8,48(sp)
ffffffff8060a8b0:       f466                    sd      s9,40(sp)
ffffffff8060a8b2:       f06a                    sd      s10,32(sp)
ffffffff8060a8b4:       ec6e                    sd      s11,24(sp)
ffffffff8060a8b6:       0100                    addi    s0,sp,128
ffffffff8060a8b8:       46823783                ld      a5,1128(tp) #
468 <__efistub_.L0 +0x5> --------> Faulting instruction
ffffffff8060a8bc:       f8f43423                sd      a5,-120(s0)
ffffffff8060a8c0:       4781                    li      a5,0
ffffffff8060a8c2:       8932                    mv      s2,a2
ffffffff8060a8c4:       84aa                    mv      s1,a0
ffffffff8060a8c6:       8aae                    mv      s5,a1
        switch (stage) {
ffffffff8060a8c8:       ca1d                    beqz
a2,ffffffff8060a8fe <riscv_cpufeature_patch_func+0x64>
ffffffff8060a8ca:       4789                    li      a5,2
ffffffff8060a8cc:       18f60363                beq
a2,a5,ffffffff8060aa52 <riscv_cpufeature_patch_func+0x1b8>
        for_each_of_cpu_node(node) {
ffffffff8060a8d0:       4501                    li      a0,0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

noinline output (boots fine)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
void riscv_cpufeature_patch_func(struct alt_entry *begin, struct alt_entry =
*end,
                                 unsigned int stage)
{
ffffffff8060a968:       7159                    addi    sp,sp,-112
ffffffff8060a96a:       f0a2                    sd      s0,96(sp)
ffffffff8060a96c:       eca6                    sd      s1,88(sp)
ffffffff8060a96e:       e8ca                    sd      s2,80(sp)
ffffffff8060a970:       fc56                    sd      s5,56(sp)
ffffffff8060a972:       f486                    sd      ra,104(sp)
ffffffff8060a974:       e4ce                    sd      s3,72(sp)
ffffffff8060a976:       e0d2                    sd      s4,64(sp)
ffffffff8060a978:       f85a                    sd      s6,48(sp)
ffffffff8060a97a:       f45e                    sd      s7,40(sp)
ffffffff8060a97c:       f062                    sd      s8,32(sp)
ffffffff8060a97e:       ec66                    sd      s9,24(sp)
ffffffff8060a980:       e86a                    sd      s10,16(sp)
ffffffff8060a982:       e46e                    sd      s11,8(sp)
ffffffff8060a984:       1880                    addi    s0,sp,112
ffffffff8060a986:       8932                    mv      s2,a2
ffffffff8060a988:       84aa                    mv      s1,a0
ffffffff8060a98a:       8aae                    mv      s5,a1
        switch (stage) {
ffffffff8060a98c:       ca09                    beqz
a2,ffffffff8060a99e <riscv_cpufeature_patch_func+0x36>
ffffffff8060a98e:       4789                    li      a5,2
ffffffff8060a990:       0ef60f63                beq
a2,a5,ffffffff8060aa8e <riscv_cpufeature_patch_func+0x126>
                return cpufeature_svpbmt_check_of();
ffffffff8060a994:       f07ff0ef                jal
ra,ffffffff8060a89a <cpufeature_svpbmt_check_of>
                        cpu_req_feature |=3D (1U << idx);
ffffffff8060a998:       0005091b                sext.w  s2,a0
ffffffff8060a99c:       a8d5                    j
ffffffff8060aa90 <riscv_cpufeature_patch_func+0x128>
        const void *fdt =3D dtb_early_va;


Any thoughts ? It looks like it may related to "tp"

>
> Heiko
>
> [0] http://lore.kernel.org/r/20220204022658.18097-1-liweiwei@iscas.ac.cn
>
>
> > I do have some out-of-tree patches but that shouldn't be an issue as I
> > am able to boot without your patches.
> > Commenting the *_boot_alternatives at both the places works fine as wel=
l.
> >
> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > index 0e1bb97f9749..bdeb7ab3e719 100644
> > --- a/arch/riscv/kernel/head.S
> > +++ b/arch/riscv/kernel/head.S
> > @@ -342,7 +342,7 @@ clear_bss_done:
> >         call kasan_early_init
> >  #endif
> >         /* Start the kernel */
> > -       call apply_boot_alternatives
> > +       //call apply_boot_alternatives
> >         call soc_early_init
> >         tail start_kernel
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 7216db5d6a2c..c6bf8f4d3d16 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -819,7 +819,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >         BUG_ON((kernel_map.virt_addr + kernel_map.size) >
> > ADDRESS_SPACE_END - SZ_4K);
> >  #endif
> >
> > -       apply_early_boot_alternatives();
> > +       //apply_early_boot_alternatives();
> >         pt_ops_set_early();
> >
> >         /* Setup early PGD for fixmap */
> >
> > I am currently debugging it and will let you know if I find the root ca=
use.
> >
> > > > changes in v6:
> > > > - rebase onto 5.17-rc1
> > > > - handle sbi null-ptr differently
> > > > - improve commit messages
> > > > - use riscv,mmu as property name
> > > >
> > > > changes in v5:
> > > > - move to use alternatives for runtime-patching
> > > > - add D1 variant
> > > >
> > > >
> > > > [0] https://lore.kernel.org/r/20211224211632.1698523-1-atishp@rivos=
inc.com
> > > > [1] https://lore.kernel.org/r/20220120090918.2646626-1-atishp@rivos=
inc.com
> > > >
> > > >
> > > > Heiko Stuebner (12):
> > > >   riscv: prevent null-pointer dereference with sbi_remote_fence_i
> > > >   riscv: integrate alternatives better into the main architecture
> > > >   riscv: allow different stages with alternatives
> > > >   riscv: implement module alternatives
> > > >   riscv: implement ALTERNATIVE_2 macro
> > > >   riscv: extend concatenated alternatives-lines to the same length
> > > >   riscv: prevent compressed instructions in alternatives
> > > >   riscv: move boot alternatives to a slightly earlier position
> > > >   riscv: Fix accessing pfn bits in PTEs for non-32bit variants
> > > >   riscv: add cpufeature handling via alternatives
> > > >   riscv: remove FIXMAP_PAGE_IO and fall back to its default value
> > > >   riscv: add memory-type errata for T-Head
> > > >
> > > > Wei Fu (2):
> > > >   dt-bindings: riscv: add MMU Standard Extensions support for Svpbm=
t
> > > >   riscv: add RISC-V Svpbmt extension support
> > > >
> > > >  .../devicetree/bindings/riscv/cpus.yaml       |  10 ++
> > > >  arch/riscv/Kconfig.erratas                    |  29 ++--
> > > >  arch/riscv/Kconfig.socs                       |   1 -
> > > >  arch/riscv/Makefile                           |   2 +-
> > > >  arch/riscv/errata/Makefile                    |   2 +-
> > > >  arch/riscv/errata/sifive/errata.c             |  10 +-
> > > >  arch/riscv/errata/thead/Makefile              |   1 +
> > > >  arch/riscv/errata/thead/errata.c              |  85 +++++++++++
> > > >  arch/riscv/include/asm/alternative-macros.h   | 114 ++++++++------=
-
> > > >  arch/riscv/include/asm/alternative.h          |  16 ++-
> > > >  arch/riscv/include/asm/errata_list.h          |  52 +++++++
> > > >  arch/riscv/include/asm/fixmap.h               |   2 -
> > > >  arch/riscv/include/asm/pgtable-32.h           |  17 +++
> > > >  arch/riscv/include/asm/pgtable-64.h           |  79 +++++++++-
> > > >  arch/riscv/include/asm/pgtable-bits.h         |  10 --
> > > >  arch/riscv/include/asm/pgtable.h              |  53 +++++--
> > > >  arch/riscv/include/asm/vendorid_list.h        |   1 +
> > > >  arch/riscv/kernel/Makefile                    |   1 +
> > > >  arch/riscv/{errata =3D> kernel}/alternative.c   |  48 ++++++-
> > > >  arch/riscv/kernel/cpufeature.c                | 136 ++++++++++++++=
+++-
> > > >  arch/riscv/kernel/head.S                      |   2 +
> > > >  arch/riscv/kernel/module.c                    |  29 ++++
> > > >  arch/riscv/kernel/sbi.c                       |  10 +-
> > > >  arch/riscv/kernel/smpboot.c                   |   4 -
> > > >  arch/riscv/kernel/traps.c                     |   2 +-
> > > >  arch/riscv/mm/init.c                          |   1 +
> > > >  26 files changed, 606 insertions(+), 111 deletions(-)
> > > >  create mode 100644 arch/riscv/errata/thead/Makefile
> > > >  create mode 100644 arch/riscv/errata/thead/errata.c
> > > >  rename arch/riscv/{errata =3D> kernel}/alternative.c (59%)
> > > >
> > > > --
> > > > 2.30.2
> > > >
> > > >
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > >
> > >
> > >
> > > --
> > > Regards,
> > > Atish
> >
> >
> >
> >
>
>
>
>


--=20
Regards,
Atish
