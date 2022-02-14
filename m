Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC22B4B5C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiBNVGL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 16:06:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiBNVFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:05:51 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F3E107834;
        Mon, 14 Feb 2022 13:05:42 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nJi5u-0002va-Pr; Mon, 14 Feb 2022 21:37:10 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Atish Patra <atishp@atishpatra.org>
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
Subject: Re: [PATCH v6 00/14] riscv: support for Svpbmt and D1 memory types
Date:   Mon, 14 Feb 2022 21:37:09 +0100
Message-ID: <54830991.GVdpa7EOCm@diego>
In-Reply-To: <CAOnJCU+6X+oPwf1Y+M0Nwb9Bj1kbxQuJ2+Za_UwTgGmhpK7q8w@mail.gmail.com>
References: <20220209123800.269774-1-heiko@sntech.de> <1644870918.0lLKBYk3Mk@diego> <CAOnJCU+6X+oPwf1Y+M0Nwb9Bj1kbxQuJ2+Za_UwTgGmhpK7q8w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 14. Februar 2022, 21:25:06 CET schrieb Atish Patra:
> On Mon, Feb 14, 2022 at 12:02 PM Heiko Stübner <heiko@sntech.de> wrote:
> >
> > Hi Atish,
> >
> > Am Samstag, 12. Februar 2022, 01:25:53 CET schrieb Atish Patra:
> > > On Thu, Feb 10, 2022 at 6:04 PM Heiko Stübner <heiko@sntech.de> wrote:
> > > >
> > > > Am Freitag, 11. Februar 2022, 02:48:38 CET schrieb Atish Patra:
> > > > > On Thu, Feb 10, 2022 at 4:25 PM Atish Patra <atishp@atishpatra.org> wrote:
> > > > > >
> > > > > > On Wed, Feb 9, 2022 at 4:38 AM Heiko Stuebner <heiko@sntech.de> wrote:
> > > > > > >
> > > > > > > Svpbmt is an extension defining "Supervisor-mode: page-based memory types"
> > > > > > > for things like non-cacheable pages or I/O memory pages.
> > > > > > >
> > > > > > >
> > > > > > > So this is my 2nd try at implementing Svpbmt (and the diverging D1 memory
> > > > > > > types) using the alternatives framework.
> > > > > > >
> > > > > > > This includes a number of changes to the alternatives mechanism itself.
> > > > > > > The biggest one being the move to a more central location, as I expect
> > > > > > > in the future, nearly every chip needing some sort of patching, be it
> > > > > > > either for erratas or for optional features (svpbmt or others).
> > > > > > >
> > > > > > > The dt-binding for svpbmt itself is of course not finished and is still
> > > > > > > using the binding introduced in previous versions, as where to put
> > > > > > > a svpbmt-property in the devicetree is still under dicussion.
> > > > > > > Atish seems to be working on a framework for extensions [0],
> > > > > > >
> > > > > >
> > > > > > Here is the patch series
> > > > > > https://lore.kernel.org/lkml/20220210214018.55739-1-atishp@rivosinc.com/
> > > > > >
> > > > > > I think we can simplify the cpu feature probing in PATCH 10 with the
> > > > > > above series
> > > > > > which simply relies on the existing riscv_isa bitmap.
> > > > > >
> > > > > > We also don't need the separate svpbmt property in DT mmu node.
> > > > > > Let me know what you think.
> > > > > >
> > > > > > > The series also introduces support for the memory types of the D1
> > > > > > > which are implemented differently to svpbmt. But when patching anyway
> > > > > > > it's pretty clean to add the D1 variant via ALTERNATIVE_2 to the same
> > > > > > > location.
> > > > > > >
> > > > > > > The only slightly bigger difference is that the "normal" type is not 0
> > > > > > > as with svpbmt, so kernel patches for this PMA type need to be applied
> > > > > > > even before the MMU is brought up, so the series introduces a separate
> > > > > > > stage for that.
> > > > > > >
> > > > > > >
> > > > > > > In theory this series is 3 parts:
> > > > > > > - sbi cache-flush / null-ptr
> > > > > > > - alternatives improvements
> > > > > > > - svpbmt+d1
> > > > > > >
> > > > > > > So expecially patches from the first 2 areas could be applied when
> > > > > > > deemed ready, I just thought to keep it together to show-case where
> > > > > > > the end-goal is and not requiring jumping between different series.
> > > > > > >
> > > > > > >
> > > > > > > The sbi cache-flush patch is based on Atish's sparse-hartid patch [1],
> > > > > > > as it touches a similar area in mm/cacheflush.c
> > > > > > >
> > > > > > >
> > > > > > > I picked the recipient list from the previous version, hopefully
> > > > > > > I didn't forget anybody.
> > > > > > >
> > > > >
> > > > > I am also getting a load access fault while booting this series in Qemu.
> > > > >
> > > > > <with additional debug message when before sbi_trap_redirect in OpenSBI>
> > > > > sbi_trap_error_debug: hart1: trap handler failed (error -2)
> > > > > sbi_trap_error_debug: hart1: mcause=0x0000000000000005 mtval=0x0000000080046468
> > > > > sbi_trap_error_debug: hart1: mtval2=0x0000000000000000 mtinst=0x0000000000000000
> > > > > sbi_trap_error_debug: hart1: mepc=0x000000008080a8b8 mstatus=0x0000000a00000800
> > > > > sbi_trap_error_debug: hart1: ra=0x0000000080202b06 sp=0x0000000081203f00
> > > > > sbi_trap_error_debug: hart1: gp=0x00000000812d9db8 tp=0x0000000080046000
> > > > > sbi_trap_error_debug: hart1: s0=0x0000000081203f80 s1=0x0000000080c1a8a8
> > > > > sbi_trap_error_debug: hart1: a0=0x0000000080c1a8a8 a1=0x0000000080c1b0d0
> > > > > sbi_trap_error_debug: hart1: a2=0x0000000000000002 a3=0x0000000000000000
> > > > > sbi_trap_error_debug: hart1: a4=0x00000000812da902 a5=0x0000000000000000
> > > > > sbi_trap_error_debug: hart1: a6=0x0000000000000006 a7=0x0000000000000010
> > > > > sbi_trap_error_debug: hart1: s2=0x0000000080c1b0d0 s3=0x0000000000000002
> > > > > sbi_trap_error_debug: hart1: s4=0x00000000bf000000 s5=0x0000000000000000
> > > > > sbi_trap_error_debug: hart1: s6=0x8000000a00006800 s7=0x000000000000007f
> > > > > sbi_trap_error_debug: hart1: s8=0x0000000080018038 s9=0x0000000080039eac
> > > > > sbi_trap_error_debug: hart1: s10=0x0000000000000000 s11=0x0000000000000000
> > > > > sbi_trap_error_debug: hart1: t0=0x0000000080c04000 t1=0x0000000000000002
> > > > > sbi_trap_error_debug: hart1: t2=0x0000000000001000 t3=0x0000000000000010
> > > > > sbi_trap_error_debug: hart1: t4=0x00000000800168be t5=0x0000000000000027
> > > > > sbi_trap_error_debug: hart1: t6=0x0000000000000001
> > > > >
> > > > > mepc : 0x000000008080a8b8 - call_function_init (kernel/smp.c)
> > > > >
> > > > > Kernel - 5.17-rc2 + my patches
> > > > > Qemu - Alistairs next tree + my patches
> > > >
> > > > very strange. I was testing of course with Qemu as well, though never saw
> > > > anything like this.
> > > >
> > > > But of course it was Qemu master + the then still pending svpbmt patchset [0]
> > > > [looks like Alistair applied this today] + a patch that made qemu insert the
> > > > svpbmt dt-property for the virt machine.
> > > >
> > > > Oh ... just to make sure, did you enable the svpbmt parameter when starting
> > > > Qemu? (-cpu ...,svpbmt=true)
> > > >
> > >
> > > Yeah. I tried with or without. It's failing in both cases. I found a
> > > fix but that may be unrelated and hiding the real issue.
> > > Marking the cpufeature_svpbmt_check_of functions inline allows me to boot.
> > >
> > > Here is my analysis:
> > >
> > > Here is the trace of the trap:
> > > sbi_trap_error_debug: hart0: trap handler failed (error -2)
> > > sbi_trap_error_debug: hart0: mcause=0x0000000000000005 mtval=0x0000000080048468
> > > sbi_trap_error_debug: hart0: mtval2=0x0000000000000000 mtinst=0x0000000000000000
> > > sbi_trap_error_debug: hart0: mepc=0x000000008080a8b8 mstatus=0x0000000a00000800
> > > sbi_trap_error_debug: hart0: ra=0x0000000080202b06 sp=0x0000000081203f00
> > > sbi_trap_error_debug: hart0: gp=0x00000000812d9db8 tp=0x0000000080048000
> > > sbi_trap_error_debug: hart0: s0=0x0000000081203f80 s1=0x0000000080c1a8a8
> > > sbi_trap_error_debug: hart0: a0=0x0000000080c1a8a8 a1=0x0000000080c1b0d0
> > > sbi_trap_error_debug: hart0: a2=0x0000000000000002 a3=0x0000000000000000
> > > sbi_trap_error_debug: hart0: a4=0x00000000812da902 a5=0x0000000000000000
> > > sbi_trap_error_debug: hart0: a6=0x0000000000000006 a7=0x0000000000000010
> > > sbi_trap_error_debug: hart0: s2=0x0000000080c1b0d0 s3=0x0000000000000002
> > > sbi_trap_error_debug: hart0: s4=0x00000000bf000000 s5=0x0000000000000000
> > > sbi_trap_error_debug: hart0: s6=0x8000000a00006800 s7=0x000000000000007f
> > > sbi_trap_error_debug: hart0: s8=0x0000000080018038 s9=0x0000000080039ea8
> > > sbi_trap_error_debug: hart0: s10=0x0000000000000000 s11=0x0000000000000000
> > > sbi_trap_error_debug: hart0: t0=0x0000000080c04000 t1=0x0000000000000002
> > > sbi_trap_error_debug: hart0: t2=0x0000000000001000 t3=0x0000000000000010
> > > sbi_trap_error_debug: hart0: t4=0x00000000800168be t5=0x0000000000000027
> > > sbi_trap_error_debug: hart0: t6=0x0000000000000001
> > >
> > > mepc : 0x000000008080a8b8 - should be ffffffff8060a8b8 in objdump
> > > output after offset
> > >
> > > Here is the snippet of the objdump output for riscv_cpufeature_patch_func
> > >
> > > ========================================================================
> > > inline output: (booting fails with above dump)
> > >
> > > void riscv_cpufeature_patch_func(struct alt_entry *begin, struct alt_entry *end,
> > >                                  unsigned int stage)
> > > {
> > > ffffffff8060a89a:       7119                    addi    sp,sp,-128
> > > ffffffff8060a89c:       f8a2                    sd      s0,112(sp)
> > > ffffffff8060a89e:       f4a6                    sd      s1,104(sp)
> > > ffffffff8060a8a0:       f0ca                    sd      s2,96(sp)
> > > ffffffff8060a8a2:       e4d6                    sd      s5,72(sp)
> > > ffffffff8060a8a4:       fc86                    sd      ra,120(sp)
> > > ffffffff8060a8a6:       ecce                    sd      s3,88(sp)
> > > ffffffff8060a8a8:       e8d2                    sd      s4,80(sp)
> > > ffffffff8060a8aa:       e0da                    sd      s6,64(sp)
> > > ffffffff8060a8ac:       fc5e                    sd      s7,56(sp)
> > > ffffffff8060a8ae:       f862                    sd      s8,48(sp)
> > > ffffffff8060a8b0:       f466                    sd      s9,40(sp)
> > > ffffffff8060a8b2:       f06a                    sd      s10,32(sp)
> > > ffffffff8060a8b4:       ec6e                    sd      s11,24(sp)
> > > ffffffff8060a8b6:       0100                    addi    s0,sp,128
> > > ffffffff8060a8b8:       46823783                ld      a5,1128(tp) #
> > > 468 <__efistub_.L0 +0x5> --------> Faulting instruction
> > > ffffffff8060a8bc:       f8f43423                sd      a5,-120(s0)
> > > ffffffff8060a8c0:       4781                    li      a5,0
> > > ffffffff8060a8c2:       8932                    mv      s2,a2
> > > ffffffff8060a8c4:       84aa                    mv      s1,a0
> > > ffffffff8060a8c6:       8aae                    mv      s5,a1
> > >         switch (stage) {
> > > ffffffff8060a8c8:       ca1d                    beqz
> > > a2,ffffffff8060a8fe <riscv_cpufeature_patch_func+0x64>
> > > ffffffff8060a8ca:       4789                    li      a5,2
> > > ffffffff8060a8cc:       18f60363                beq
> > > a2,a5,ffffffff8060aa52 <riscv_cpufeature_patch_func+0x1b8>
> > >         for_each_of_cpu_node(node) {
> > > ffffffff8060a8d0:       4501                    li      a0,0
> > > ========================================================================
> > >
> > > noinline output (boots fine)
> > > ========================================================================
> > > void riscv_cpufeature_patch_func(struct alt_entry *begin, struct alt_entry *end,
> > >                                  unsigned int stage)
> > > {
> > > ffffffff8060a968:       7159                    addi    sp,sp,-112
> > > ffffffff8060a96a:       f0a2                    sd      s0,96(sp)
> > > ffffffff8060a96c:       eca6                    sd      s1,88(sp)
> > > ffffffff8060a96e:       e8ca                    sd      s2,80(sp)
> > > ffffffff8060a970:       fc56                    sd      s5,56(sp)
> > > ffffffff8060a972:       f486                    sd      ra,104(sp)
> > > ffffffff8060a974:       e4ce                    sd      s3,72(sp)
> > > ffffffff8060a976:       e0d2                    sd      s4,64(sp)
> > > ffffffff8060a978:       f85a                    sd      s6,48(sp)
> > > ffffffff8060a97a:       f45e                    sd      s7,40(sp)
> > > ffffffff8060a97c:       f062                    sd      s8,32(sp)
> > > ffffffff8060a97e:       ec66                    sd      s9,24(sp)
> > > ffffffff8060a980:       e86a                    sd      s10,16(sp)
> > > ffffffff8060a982:       e46e                    sd      s11,8(sp)
> > > ffffffff8060a984:       1880                    addi    s0,sp,112
> > > ffffffff8060a986:       8932                    mv      s2,a2
> > > ffffffff8060a988:       84aa                    mv      s1,a0
> > > ffffffff8060a98a:       8aae                    mv      s5,a1
> > >         switch (stage) {
> > > ffffffff8060a98c:       ca09                    beqz
> > > a2,ffffffff8060a99e <riscv_cpufeature_patch_func+0x36>
> > > ffffffff8060a98e:       4789                    li      a5,2
> > > ffffffff8060a990:       0ef60f63                beq
> > > a2,a5,ffffffff8060aa8e <riscv_cpufeature_patch_func+0x126>
> > >                 return cpufeature_svpbmt_check_of();
> > > ffffffff8060a994:       f07ff0ef                jal
> > > ra,ffffffff8060a89a <cpufeature_svpbmt_check_of>
> > >                         cpu_req_feature |= (1U << idx);
> > > ffffffff8060a998:       0005091b                sext.w  s2,a0
> > > ffffffff8060a99c:       a8d5                    j
> > > ffffffff8060aa90 <riscv_cpufeature_patch_func+0x128>
> > >         const void *fdt = dtb_early_va;
> > >
> > >
> > > Any thoughts ? It looks like it may related to "tp"
> >
> > Faulting instruction "efistub", so maybe something between efi
> > and the devicetree not agreeing?
> >
> 
> I don't think they are related as the execution has not reached the
> device tree parsing yet.
> It crashes before executing anything inside the DT parsing code.
> 
> __efistub_ is just a prefix to make sure that there are no absolute
> relocations in .init section.
> It is also enabled in defconfig. So you should see that error as well.
> 
> > Though at least on my build I also have efistub enabled, so it
> > should be the same. So it's very strange that you're seeing that
> > trap, which I've never seen so far.
> >
> 
> Maybe GCC has to do something with it. Because adding "nolnine" solves
> it for me.
> I am using v11.1.0.

I'm currently with 10.2.1 .. so that really might be an issue.
I tried gcc-11 from Debian last week, but that didn't even seem
to build working stock images, so I've reverted back to 10 for the
time being.


> > In any case, I tried your + Tsukasa's patches regarding the isa-extensions
> > today, and obviously that works fine, so we will get rid of the devicetree-
> > parts anyway I guess.
> >
> 
> I will try those changes and update the thread.
> 
> > With the change below on top of that v2/v3 version-mix, I also get a
> > working svpbmt of course. After hacking qemu to generate a
> > suitable isa-string for me :-) .
> 
> I will send a patch to Qemu to append the extension strings to the device tree.

thanks a lot :-)

Heiko


> > -------------- 8< ------------------
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > index 691fc9c8099b..656cd626eb1a 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -51,6 +51,7 @@ extern unsigned long elf_hwcap;
> >   * available logical extension id.
> >   */
> >  enum riscv_isa_ext_id {
> > +       RISCV_ISA_EXT_SVPBMT = RISCV_ISA_EXT_BASE,
> >         RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
> >  };
> >
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index ced7e5be8641..b5130b15ca8d 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -71,6 +71,7 @@ int riscv_of_parent_hartid(struct device_node *node)
> >         }
> >
> >  static struct riscv_isa_ext_data isa_ext_arr[] = {
> > +       __RISCV_ISA_EXT_DATA("svpbmt", RISCV_ISA_EXT_SVPBMT),
> >         __RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
> >  };
> >
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 2e4eaedbf7f5..d82033ece1fd 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -192,6 +192,8 @@ void __init riscv_fill_hwcap(void)
> >                         if (!ext_long) {
> >                                 this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
> >                                 this_isa |= (1UL << (*ext - 'a'));
> > +                       } else {
> > +                               SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
> >                         }
> >  #undef SET_ISA_EXT_MAP
> >                 }
> > @@ -253,64 +255,6 @@ struct cpufeature_info {
> >         bool (*check_func)(unsigned int stage);
> >  };
> >
> > -#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
> > -static bool __init_or_module cpufeature_svpbmt_check_fdt(void)
> > -{
> > -       const void *fdt = dtb_early_va;
> > -       const char *str;
> > -       int offset;
> > -
> > -       offset = fdt_path_offset(fdt, "/cpus");
> > -       if (offset < 0)
> > -               return false;
> > -
> > -       for (offset = fdt_next_node(fdt, offset, NULL); offset >= 0;
> > -            offset = fdt_next_node(fdt, offset, NULL)) {
> > -               str = fdt_getprop(fdt, offset, "device_type", NULL);
> > -               if (!str || strcmp(str, "cpu"))
> > -                       break;
> > -
> > -               str = fdt_getprop(fdt, offset, "mmu-type", NULL);
> > -               if (!str)
> > -                       continue;
> > -
> > -               if (!strncmp(str + 6, "none", 4))
> > -                       continue;
> > -
> > -               str = fdt_getprop(fdt, offset, "riscv,mmu", NULL);
> > -               if (!str)
> > -                       continue;
> > -
> > -               if (!strncmp(str + 6, "svpbmt", 6))
> > -                       return true;
> > -       }
> > -
> > -       return false;
> > -}
> > -
> > -static bool __init_or_module cpufeature_svpbmt_check_of(void)
> > -{
> > -       struct device_node *node;
> > -       const char *str;
> > -
> > -       for_each_of_cpu_node(node) {
> > -               if (of_property_read_string(node, "mmu-type", &str))
> > -                       continue;
> > -
> > -               if (!strncmp(str + 6, "none", 4))
> > -                       continue;
> > -
> > -               if (of_property_read_string(node, "riscv,mmu", &str))
> > -                       continue;
> > -
> > -               if (!strncmp(str + 6, "svpbmt", 6))
> > -                       return true;
> > -       }
> > -
> > -       return false;
> > -}
> > -#endif
> > -
> >  static bool __init_or_module cpufeature_svpbmt_check_func(unsigned int stage)
> >  {
> >         bool ret = false;
> > @@ -319,10 +263,8 @@ static bool __init_or_module cpufeature_svpbmt_check_func(unsigned int stage)
> >         switch (stage) {
> >         case RISCV_ALTERNATIVES_EARLY_BOOT:
> >                 return false;
> > -       case RISCV_ALTERNATIVES_BOOT:
> > -               return cpufeature_svpbmt_check_fdt();
> >         default:
> > -               return cpufeature_svpbmt_check_of();
> > +               return riscv_isa_extension_available(NULL, SVPBMT);
> >         }
> >  #endif
> >
> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > index c01012f3740d..ec07f991866a 100644
> > --- a/arch/riscv/kernel/head.S
> > +++ b/arch/riscv/kernel/head.S
> > @@ -10,7 +10,6 @@
> >  #include <asm/thread_info.h>
> >  #include <asm/page.h>
> >  #include <asm/pgtable.h>
> > -#include <asm/alternative.h>
> >  #include <asm/csr.h>
> >  #include <asm/cpu_ops_sbi.h>
> >  #include <asm/hwcap.h>
> > @@ -341,7 +340,6 @@ clear_bss_done:
> >         call kasan_early_init
> >  #endif
> >         /* Start the kernel */
> > -       call apply_boot_alternatives
> >         call soc_early_init
> >         tail start_kernel
> >
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index 339ceb595b38..b4879c942b42 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/efi.h>
> >  #include <linux/crash_dump.h>
> >
> > +#include <asm/alternative.h>
> >  #include <asm/cpu_ops.h>
> >  #include <asm/early_ioremap.h>
> >  #include <asm/pgtable.h>
> > @@ -295,6 +296,7 @@ void __init setup_arch(char **cmdline_p)
> >  #endif
> >
> >         riscv_fill_hwcap();
> > +       apply_boot_alternatives();
> >  }
> >
> >  static int __init topology_init(void)
> >
> >
> >
> 
> Looks good to me.
> 
> 




