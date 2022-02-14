Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59DF4B5C14
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiBNVEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:04:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiBNVEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:04:50 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EAE1029F3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:04:37 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id bt13so50087516ybb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R1KF5DvlJdVH4Bws2tj3A2gaIIMuyfWnmk6aeYuHj/Y=;
        b=TLGz2evFQytCdnMz444QHq6DfW06IYxAZH44mVIrX3O9mAsgKXak/Ioa7MdzxoTqB2
         a8CiiXnINJ1ZSbzl6HVzhYpAjRPpvEZdRynlGMv/Cj6pmq3i3th2Q8+HL7ioLIxtXfed
         5WkpjXKrEgkbZcMpw2PTh03zgCgWx1Z+0CFB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R1KF5DvlJdVH4Bws2tj3A2gaIIMuyfWnmk6aeYuHj/Y=;
        b=kYLYZiCgsKryUziSMCmgoC8DCQYHekXze/Rxq9ziuNqA++XYFa6X+31DcltSwutNZm
         DJrnOeRu7mVX5cwOanS85yOf9oE8EFikbuLWe7A6nBXUAtiMaRuXkcUK40Fu4CYfP+m+
         6BSQIWQI8ddghaszsQkdp93e7ZHUPix5Qh03RexCc9derx5o6tHI7oImy/keSccAqlbX
         KEN6Ug3qN31HXW1hA07lK0nTmlRdvlcbA2WI1hs78TCkwZw3AD2QJnnoK/K1yBMvr2QN
         Y8H1Xf6Sm2yFzjr2uE5US6x3y/yYCkS+jW8jqBmVkfAMl+NzlV9kBRiTqsF64J0trSme
         Llgw==
X-Gm-Message-State: AOAM530WYNmej+GeWirBAzX8AfivujEMfcybA1PIXWsb4Khz+aaFMqhx
        ASTH5/yW9F9Xmk2VEwXFXE70oQLgf7d8qXVRX3jbJYsuDbuo
X-Google-Smtp-Source: ABdhPJzhpdmcZDwtD1tCmLVWJKAmsaYEZFGFu/qYafph9ees96yWWG4+sgucUO6I9tuULsk6oQfdVRotEd5V2UlCh/0=
X-Received: by 2002:a25:e406:: with SMTP id b6mr730241ybh.703.1644870317345;
 Mon, 14 Feb 2022 12:25:17 -0800 (PST)
MIME-Version: 1.0
References: <20220209123800.269774-1-heiko@sntech.de> <2177281.3HUnQTRebA@diego>
 <CAOnJCUJX9bmPDN1S+dhjCi1RE5D=d2yHeHmfy9y8NLWrDDazvQ@mail.gmail.com> <1644870918.0lLKBYk3Mk@diego>
In-Reply-To: <1644870918.0lLKBYk3Mk@diego>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 14 Feb 2022 12:25:06 -0800
Message-ID: <CAOnJCU+6X+oPwf1Y+M0Nwb9Bj1kbxQuJ2+Za_UwTgGmhpK7q8w@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 12:02 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote=
:
>
> Hi Atish,
>
> Am Samstag, 12. Februar 2022, 01:25:53 CET schrieb Atish Patra:
> > On Thu, Feb 10, 2022 at 6:04 PM Heiko St=C3=BCbner <heiko@sntech.de> wr=
ote:
> > >
> > > Am Freitag, 11. Februar 2022, 02:48:38 CET schrieb Atish Patra:
> > > > On Thu, Feb 10, 2022 at 4:25 PM Atish Patra <atishp@atishpatra.org>=
 wrote:
> > > > >
> > > > > On Wed, Feb 9, 2022 at 4:38 AM Heiko Stuebner <heiko@sntech.de> w=
rote:
> > > > > >
> > > > > > Svpbmt is an extension defining "Supervisor-mode: page-based me=
mory types"
> > > > > > for things like non-cacheable pages or I/O memory pages.
> > > > > >
> > > > > >
> > > > > > So this is my 2nd try at implementing Svpbmt (and the diverging=
 D1 memory
> > > > > > types) using the alternatives framework.
> > > > > >
> > > > > > This includes a number of changes to the alternatives mechanism=
 itself.
> > > > > > The biggest one being the move to a more central location, as I=
 expect
> > > > > > in the future, nearly every chip needing some sort of patching,=
 be it
> > > > > > either for erratas or for optional features (svpbmt or others).
> > > > > >
> > > > > > The dt-binding for svpbmt itself is of course not finished and =
is still
> > > > > > using the binding introduced in previous versions, as where to =
put
> > > > > > a svpbmt-property in the devicetree is still under dicussion.
> > > > > > Atish seems to be working on a framework for extensions [0],
> > > > > >
> > > > >
> > > > > Here is the patch series
> > > > > https://lore.kernel.org/lkml/20220210214018.55739-1-atishp@rivosi=
nc.com/
> > > > >
> > > > > I think we can simplify the cpu feature probing in PATCH 10 with =
the
> > > > > above series
> > > > > which simply relies on the existing riscv_isa bitmap.
> > > > >
> > > > > We also don't need the separate svpbmt property in DT mmu node.
> > > > > Let me know what you think.
> > > > >
> > > > > > The series also introduces support for the memory types of the =
D1
> > > > > > which are implemented differently to svpbmt. But when patching =
anyway
> > > > > > it's pretty clean to add the D1 variant via ALTERNATIVE_2 to th=
e same
> > > > > > location.
> > > > > >
> > > > > > The only slightly bigger difference is that the "normal" type i=
s not 0
> > > > > > as with svpbmt, so kernel patches for this PMA type need to be =
applied
> > > > > > even before the MMU is brought up, so the series introduces a s=
eparate
> > > > > > stage for that.
> > > > > >
> > > > > >
> > > > > > In theory this series is 3 parts:
> > > > > > - sbi cache-flush / null-ptr
> > > > > > - alternatives improvements
> > > > > > - svpbmt+d1
> > > > > >
> > > > > > So expecially patches from the first 2 areas could be applied w=
hen
> > > > > > deemed ready, I just thought to keep it together to show-case w=
here
> > > > > > the end-goal is and not requiring jumping between different ser=
ies.
> > > > > >
> > > > > >
> > > > > > The sbi cache-flush patch is based on Atish's sparse-hartid pat=
ch [1],
> > > > > > as it touches a similar area in mm/cacheflush.c
> > > > > >
> > > > > >
> > > > > > I picked the recipient list from the previous version, hopefull=
y
> > > > > > I didn't forget anybody.
> > > > > >
> > > >
> > > > I am also getting a load access fault while booting this series in =
Qemu.
> > > >
> > > > <with additional debug message when before sbi_trap_redirect in Ope=
nSBI>
> > > > sbi_trap_error_debug: hart1: trap handler failed (error -2)
> > > > sbi_trap_error_debug: hart1: mcause=3D0x0000000000000005 mtval=3D0x=
0000000080046468
> > > > sbi_trap_error_debug: hart1: mtval2=3D0x0000000000000000 mtinst=3D0=
x0000000000000000
> > > > sbi_trap_error_debug: hart1: mepc=3D0x000000008080a8b8 mstatus=3D0x=
0000000a00000800
> > > > sbi_trap_error_debug: hart1: ra=3D0x0000000080202b06 sp=3D0x0000000=
081203f00
> > > > sbi_trap_error_debug: hart1: gp=3D0x00000000812d9db8 tp=3D0x0000000=
080046000
> > > > sbi_trap_error_debug: hart1: s0=3D0x0000000081203f80 s1=3D0x0000000=
080c1a8a8
> > > > sbi_trap_error_debug: hart1: a0=3D0x0000000080c1a8a8 a1=3D0x0000000=
080c1b0d0
> > > > sbi_trap_error_debug: hart1: a2=3D0x0000000000000002 a3=3D0x0000000=
000000000
> > > > sbi_trap_error_debug: hart1: a4=3D0x00000000812da902 a5=3D0x0000000=
000000000
> > > > sbi_trap_error_debug: hart1: a6=3D0x0000000000000006 a7=3D0x0000000=
000000010
> > > > sbi_trap_error_debug: hart1: s2=3D0x0000000080c1b0d0 s3=3D0x0000000=
000000002
> > > > sbi_trap_error_debug: hart1: s4=3D0x00000000bf000000 s5=3D0x0000000=
000000000
> > > > sbi_trap_error_debug: hart1: s6=3D0x8000000a00006800 s7=3D0x0000000=
00000007f
> > > > sbi_trap_error_debug: hart1: s8=3D0x0000000080018038 s9=3D0x0000000=
080039eac
> > > > sbi_trap_error_debug: hart1: s10=3D0x0000000000000000 s11=3D0x00000=
00000000000
> > > > sbi_trap_error_debug: hart1: t0=3D0x0000000080c04000 t1=3D0x0000000=
000000002
> > > > sbi_trap_error_debug: hart1: t2=3D0x0000000000001000 t3=3D0x0000000=
000000010
> > > > sbi_trap_error_debug: hart1: t4=3D0x00000000800168be t5=3D0x0000000=
000000027
> > > > sbi_trap_error_debug: hart1: t6=3D0x0000000000000001
> > > >
> > > > mepc : 0x000000008080a8b8 - call_function_init (kernel/smp.c)
> > > >
> > > > Kernel - 5.17-rc2 + my patches
> > > > Qemu - Alistairs next tree + my patches
> > >
> > > very strange. I was testing of course with Qemu as well, though never=
 saw
> > > anything like this.
> > >
> > > But of course it was Qemu master + the then still pending svpbmt patc=
hset [0]
> > > [looks like Alistair applied this today] + a patch that made qemu ins=
ert the
> > > svpbmt dt-property for the virt machine.
> > >
> > > Oh ... just to make sure, did you enable the svpbmt parameter when st=
arting
> > > Qemu? (-cpu ...,svpbmt=3Dtrue)
> > >
> >
> > Yeah. I tried with or without. It's failing in both cases. I found a
> > fix but that may be unrelated and hiding the real issue.
> > Marking the cpufeature_svpbmt_check_of functions inline allows me to bo=
ot.
> >
> > Here is my analysis:
> >
> > Here is the trace of the trap:
> > sbi_trap_error_debug: hart0: trap handler failed (error -2)
> > sbi_trap_error_debug: hart0: mcause=3D0x0000000000000005 mtval=3D0x0000=
000080048468
> > sbi_trap_error_debug: hart0: mtval2=3D0x0000000000000000 mtinst=3D0x000=
0000000000000
> > sbi_trap_error_debug: hart0: mepc=3D0x000000008080a8b8 mstatus=3D0x0000=
000a00000800
> > sbi_trap_error_debug: hart0: ra=3D0x0000000080202b06 sp=3D0x00000000812=
03f00
> > sbi_trap_error_debug: hart0: gp=3D0x00000000812d9db8 tp=3D0x00000000800=
48000
> > sbi_trap_error_debug: hart0: s0=3D0x0000000081203f80 s1=3D0x0000000080c=
1a8a8
> > sbi_trap_error_debug: hart0: a0=3D0x0000000080c1a8a8 a1=3D0x0000000080c=
1b0d0
> > sbi_trap_error_debug: hart0: a2=3D0x0000000000000002 a3=3D0x00000000000=
00000
> > sbi_trap_error_debug: hart0: a4=3D0x00000000812da902 a5=3D0x00000000000=
00000
> > sbi_trap_error_debug: hart0: a6=3D0x0000000000000006 a7=3D0x00000000000=
00010
> > sbi_trap_error_debug: hart0: s2=3D0x0000000080c1b0d0 s3=3D0x00000000000=
00002
> > sbi_trap_error_debug: hart0: s4=3D0x00000000bf000000 s5=3D0x00000000000=
00000
> > sbi_trap_error_debug: hart0: s6=3D0x8000000a00006800 s7=3D0x00000000000=
0007f
> > sbi_trap_error_debug: hart0: s8=3D0x0000000080018038 s9=3D0x00000000800=
39ea8
> > sbi_trap_error_debug: hart0: s10=3D0x0000000000000000 s11=3D0x000000000=
0000000
> > sbi_trap_error_debug: hart0: t0=3D0x0000000080c04000 t1=3D0x00000000000=
00002
> > sbi_trap_error_debug: hart0: t2=3D0x0000000000001000 t3=3D0x00000000000=
00010
> > sbi_trap_error_debug: hart0: t4=3D0x00000000800168be t5=3D0x00000000000=
00027
> > sbi_trap_error_debug: hart0: t6=3D0x0000000000000001
> >
> > mepc : 0x000000008080a8b8 - should be ffffffff8060a8b8 in objdump
> > output after offset
> >
> > Here is the snippet of the objdump output for riscv_cpufeature_patch_fu=
nc
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > inline output: (booting fails with above dump)
> >
> > void riscv_cpufeature_patch_func(struct alt_entry *begin, struct alt_en=
try *end,
> >                                  unsigned int stage)
> > {
> > ffffffff8060a89a:       7119                    addi    sp,sp,-128
> > ffffffff8060a89c:       f8a2                    sd      s0,112(sp)
> > ffffffff8060a89e:       f4a6                    sd      s1,104(sp)
> > ffffffff8060a8a0:       f0ca                    sd      s2,96(sp)
> > ffffffff8060a8a2:       e4d6                    sd      s5,72(sp)
> > ffffffff8060a8a4:       fc86                    sd      ra,120(sp)
> > ffffffff8060a8a6:       ecce                    sd      s3,88(sp)
> > ffffffff8060a8a8:       e8d2                    sd      s4,80(sp)
> > ffffffff8060a8aa:       e0da                    sd      s6,64(sp)
> > ffffffff8060a8ac:       fc5e                    sd      s7,56(sp)
> > ffffffff8060a8ae:       f862                    sd      s8,48(sp)
> > ffffffff8060a8b0:       f466                    sd      s9,40(sp)
> > ffffffff8060a8b2:       f06a                    sd      s10,32(sp)
> > ffffffff8060a8b4:       ec6e                    sd      s11,24(sp)
> > ffffffff8060a8b6:       0100                    addi    s0,sp,128
> > ffffffff8060a8b8:       46823783                ld      a5,1128(tp) #
> > 468 <__efistub_.L0 +0x5> --------> Faulting instruction
> > ffffffff8060a8bc:       f8f43423                sd      a5,-120(s0)
> > ffffffff8060a8c0:       4781                    li      a5,0
> > ffffffff8060a8c2:       8932                    mv      s2,a2
> > ffffffff8060a8c4:       84aa                    mv      s1,a0
> > ffffffff8060a8c6:       8aae                    mv      s5,a1
> >         switch (stage) {
> > ffffffff8060a8c8:       ca1d                    beqz
> > a2,ffffffff8060a8fe <riscv_cpufeature_patch_func+0x64>
> > ffffffff8060a8ca:       4789                    li      a5,2
> > ffffffff8060a8cc:       18f60363                beq
> > a2,a5,ffffffff8060aa52 <riscv_cpufeature_patch_func+0x1b8>
> >         for_each_of_cpu_node(node) {
> > ffffffff8060a8d0:       4501                    li      a0,0
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > noinline output (boots fine)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > void riscv_cpufeature_patch_func(struct alt_entry *begin, struct alt_en=
try *end,
> >                                  unsigned int stage)
> > {
> > ffffffff8060a968:       7159                    addi    sp,sp,-112
> > ffffffff8060a96a:       f0a2                    sd      s0,96(sp)
> > ffffffff8060a96c:       eca6                    sd      s1,88(sp)
> > ffffffff8060a96e:       e8ca                    sd      s2,80(sp)
> > ffffffff8060a970:       fc56                    sd      s5,56(sp)
> > ffffffff8060a972:       f486                    sd      ra,104(sp)
> > ffffffff8060a974:       e4ce                    sd      s3,72(sp)
> > ffffffff8060a976:       e0d2                    sd      s4,64(sp)
> > ffffffff8060a978:       f85a                    sd      s6,48(sp)
> > ffffffff8060a97a:       f45e                    sd      s7,40(sp)
> > ffffffff8060a97c:       f062                    sd      s8,32(sp)
> > ffffffff8060a97e:       ec66                    sd      s9,24(sp)
> > ffffffff8060a980:       e86a                    sd      s10,16(sp)
> > ffffffff8060a982:       e46e                    sd      s11,8(sp)
> > ffffffff8060a984:       1880                    addi    s0,sp,112
> > ffffffff8060a986:       8932                    mv      s2,a2
> > ffffffff8060a988:       84aa                    mv      s1,a0
> > ffffffff8060a98a:       8aae                    mv      s5,a1
> >         switch (stage) {
> > ffffffff8060a98c:       ca09                    beqz
> > a2,ffffffff8060a99e <riscv_cpufeature_patch_func+0x36>
> > ffffffff8060a98e:       4789                    li      a5,2
> > ffffffff8060a990:       0ef60f63                beq
> > a2,a5,ffffffff8060aa8e <riscv_cpufeature_patch_func+0x126>
> >                 return cpufeature_svpbmt_check_of();
> > ffffffff8060a994:       f07ff0ef                jal
> > ra,ffffffff8060a89a <cpufeature_svpbmt_check_of>
> >                         cpu_req_feature |=3D (1U << idx);
> > ffffffff8060a998:       0005091b                sext.w  s2,a0
> > ffffffff8060a99c:       a8d5                    j
> > ffffffff8060aa90 <riscv_cpufeature_patch_func+0x128>
> >         const void *fdt =3D dtb_early_va;
> >
> >
> > Any thoughts ? It looks like it may related to "tp"
>
> Faulting instruction "efistub", so maybe something between efi
> and the devicetree not agreeing?
>

I don't think they are related as the execution has not reached the
device tree parsing yet.
It crashes before executing anything inside the DT parsing code.

__efistub_ is just a prefix to make sure that there are no absolute
relocations in .init section.
It is also enabled in defconfig. So you should see that error as well.

> Though at least on my build I also have efistub enabled, so it
> should be the same. So it's very strange that you're seeing that
> trap, which I've never seen so far.
>

Maybe GCC has to do something with it. Because adding "nolnine" solves
it for me.
I am using v11.1.0.

>
> In any case, I tried your + Tsukasa's patches regarding the isa-extension=
s
> today, and obviously that works fine, so we will get rid of the devicetre=
e-
> parts anyway I guess.
>

I will try those changes and update the thread.

> With the change below on top of that v2/v3 version-mix, I also get a
> working svpbmt of course. After hacking qemu to generate a
> suitable isa-string for me :-) .

I will send a patch to Qemu to append the extension strings to the device t=
ree.

>
>
> Heiko
>
> -------------- 8< ------------------
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index 691fc9c8099b..656cd626eb1a 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -51,6 +51,7 @@ extern unsigned long elf_hwcap;
>   * available logical extension id.
>   */
>  enum riscv_isa_ext_id {
> +       RISCV_ISA_EXT_SVPBMT =3D RISCV_ISA_EXT_BASE,
>         RISCV_ISA_EXT_ID_MAX =3D RISCV_ISA_EXT_MAX,
>  };
>
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index ced7e5be8641..b5130b15ca8d 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -71,6 +71,7 @@ int riscv_of_parent_hartid(struct device_node *node)
>         }
>
>  static struct riscv_isa_ext_data isa_ext_arr[] =3D {
> +       __RISCV_ISA_EXT_DATA("svpbmt", RISCV_ISA_EXT_SVPBMT),
>         __RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
>  };
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 2e4eaedbf7f5..d82033ece1fd 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -192,6 +192,8 @@ void __init riscv_fill_hwcap(void)
>                         if (!ext_long) {
>                                 this_hwcap |=3D isa2hwcap[(unsigned char)=
(*ext)];
>                                 this_isa |=3D (1UL << (*ext - 'a'));
> +                       } else {
> +                               SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_S=
VPBMT);
>                         }
>  #undef SET_ISA_EXT_MAP
>                 }
> @@ -253,64 +255,6 @@ struct cpufeature_info {
>         bool (*check_func)(unsigned int stage);
>  };
>
> -#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
> -static bool __init_or_module cpufeature_svpbmt_check_fdt(void)
> -{
> -       const void *fdt =3D dtb_early_va;
> -       const char *str;
> -       int offset;
> -
> -       offset =3D fdt_path_offset(fdt, "/cpus");
> -       if (offset < 0)
> -               return false;
> -
> -       for (offset =3D fdt_next_node(fdt, offset, NULL); offset >=3D 0;
> -            offset =3D fdt_next_node(fdt, offset, NULL)) {
> -               str =3D fdt_getprop(fdt, offset, "device_type", NULL);
> -               if (!str || strcmp(str, "cpu"))
> -                       break;
> -
> -               str =3D fdt_getprop(fdt, offset, "mmu-type", NULL);
> -               if (!str)
> -                       continue;
> -
> -               if (!strncmp(str + 6, "none", 4))
> -                       continue;
> -
> -               str =3D fdt_getprop(fdt, offset, "riscv,mmu", NULL);
> -               if (!str)
> -                       continue;
> -
> -               if (!strncmp(str + 6, "svpbmt", 6))
> -                       return true;
> -       }
> -
> -       return false;
> -}
> -
> -static bool __init_or_module cpufeature_svpbmt_check_of(void)
> -{
> -       struct device_node *node;
> -       const char *str;
> -
> -       for_each_of_cpu_node(node) {
> -               if (of_property_read_string(node, "mmu-type", &str))
> -                       continue;
> -
> -               if (!strncmp(str + 6, "none", 4))
> -                       continue;
> -
> -               if (of_property_read_string(node, "riscv,mmu", &str))
> -                       continue;
> -
> -               if (!strncmp(str + 6, "svpbmt", 6))
> -                       return true;
> -       }
> -
> -       return false;
> -}
> -#endif
> -
>  static bool __init_or_module cpufeature_svpbmt_check_func(unsigned int s=
tage)
>  {
>         bool ret =3D false;
> @@ -319,10 +263,8 @@ static bool __init_or_module cpufeature_svpbmt_check=
_func(unsigned int stage)
>         switch (stage) {
>         case RISCV_ALTERNATIVES_EARLY_BOOT:
>                 return false;
> -       case RISCV_ALTERNATIVES_BOOT:
> -               return cpufeature_svpbmt_check_fdt();
>         default:
> -               return cpufeature_svpbmt_check_of();
> +               return riscv_isa_extension_available(NULL, SVPBMT);
>         }
>  #endif
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index c01012f3740d..ec07f991866a 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -10,7 +10,6 @@
>  #include <asm/thread_info.h>
>  #include <asm/page.h>
>  #include <asm/pgtable.h>
> -#include <asm/alternative.h>
>  #include <asm/csr.h>
>  #include <asm/cpu_ops_sbi.h>
>  #include <asm/hwcap.h>
> @@ -341,7 +340,6 @@ clear_bss_done:
>         call kasan_early_init
>  #endif
>         /* Start the kernel */
> -       call apply_boot_alternatives
>         call soc_early_init
>         tail start_kernel
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 339ceb595b38..b4879c942b42 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -21,6 +21,7 @@
>  #include <linux/efi.h>
>  #include <linux/crash_dump.h>
>
> +#include <asm/alternative.h>
>  #include <asm/cpu_ops.h>
>  #include <asm/early_ioremap.h>
>  #include <asm/pgtable.h>
> @@ -295,6 +296,7 @@ void __init setup_arch(char **cmdline_p)
>  #endif
>
>         riscv_fill_hwcap();
> +       apply_boot_alternatives();
>  }
>
>  static int __init topology_init(void)
>
>
>

Looks good to me.

--=20
Regards,
Atish
