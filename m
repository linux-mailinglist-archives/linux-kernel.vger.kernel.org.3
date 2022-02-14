Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0204B5D8D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 23:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiBNWWo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 17:22:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiBNWWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 17:22:43 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B48119405;
        Mon, 14 Feb 2022 14:22:33 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nJjjm-0003ac-29; Mon, 14 Feb 2022 23:22:26 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 4/6] RISC-V: Implement multi-letter ISA extension probing framework
Date:   Mon, 14 Feb 2022 23:22:25 +0100
Message-ID: <2413800.L4PxSk42VP@diego>
In-Reply-To: <CAOnJCU+cWBDrN-3Z37m8xA1GPrJY+JaOweYMiZBxJ-cT7ii_5Q@mail.gmail.com>
References: <20220210214018.55739-1-atishp@rivosinc.com> <3479483.A1skbJeUdD@diego> <CAOnJCU+cWBDrN-3Z37m8xA1GPrJY+JaOweYMiZBxJ-cT7ii_5Q@mail.gmail.com>
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

Am Montag, 14. Februar 2022, 21:42:32 CET schrieb Atish Patra:
> On Mon, Feb 14, 2022 at 12:24 PM Heiko Stübner <heiko@sntech.de> wrote:
> >
> > Am Montag, 14. Februar 2022, 21:14:13 CET schrieb Atish Patra:
> > > On Mon, Feb 14, 2022 at 12:06 PM Heiko Stübner <heiko@sntech.de> wrote:
> > > >
> > > > Am Donnerstag, 10. Februar 2022, 22:40:16 CET schrieb Atish Patra:
> > > > > Multi-letter extensions can be probed using exising
> > > > > riscv_isa_extension_available API now. It doesn't support versioning
> > > > > right now as there is no use case for it.
> > > > > Individual extension specific implementation will be added during
> > > > > each extension support.
> > > > >
> > > > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > > >
> > > > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > > >
> > > >
> > > > By the way, does a similar parsing exist for opensbi as well?
> > > > Things like svpbmt as well as zicbom have CSR bits controlling how
> > > > these functions should behave (enabling them, etc), so I guess
> > > > opensbi also needs to parse the extensions from the ISA string?
> > > >
> > > >
> > >
> > > No. Currently, OpenSBI relies on the CSR read/write & trap method to
> > > identify the extensions [1].
> > >
> > > https://github.com/riscv-software-src/opensbi/blob/master/lib/sbi/sbi_hart.c#L404
> >
> > I guess my question is more, who is supposed to set CBIE, CBCFE bits in the
> > ENVCFG CSR. I.e. at it's default settings CMO instructions will cause
> > illegal instructions until the level above does allow them.
> >
> > When the kernel wants to call a cache-invalidate, from my reading menvcfg
> > needs to be modified accordingly - which would fall in SBI's court?
> >
> 
> I think so. I had the same question for the SSTC extension as well.
> This is what I currently do:
> 
> 1. Detect menvcfg first, detect stimecmp
> 2. Enable SSTC feature only if both are available
> 3. Set the STCE bit in menvcfg if SSTC is available
> 
> Here is the patch
> https://github.com/atishp04/opensbi/commit/e6b185821e8302bffdceb4633b413252e0de4889

Hmm, the CBO fields are defined as WARL (write any, read legal),
so I guess some sort of trap won't work here.

The priv-spec only points to the cmo-spec for these bits and the cmo-spec
does not specifiy what the value should be when cmo is not present.


> > > In the future, zicbom can be detected in the same manner. However,
> > > svpbmt is a bit tricky as it doesn't
> > > define any new CSR. Do you think OpenSBI needs to detect svpbmt for any reason ?
> >
> > There is the PBMTE bit in MENVCFG, which I found while looking through the
> > zicbom-parts, which is supposed to "control wheter svpbmt is available for
> > use". So I guess the question is the same as above :-)
> >
> 
> PBMTE bit in MENVCFG says if PBMTE bit is available or not. OpenSBI
> needs other way to
> detect if PBMTE is available.
> 
> That's why, I think MENVCFG should be set correctly by the hardware
> upon reset. What do you think
> about that ? I couldn't find anything related to the reset state for menvcfg.

me neither. Both the priv-spec as well as the cmobase spec do not
specifiy any reset-values it seems.

So I guess in the Qemu case, Qemu needs to set that bit when
its svpbmt extension is enabled?


Heiko


> > > > > ---
> > > > >  arch/riscv/include/asm/hwcap.h | 18 ++++++++++++++++++
> > > > >  arch/riscv/kernel/cpufeature.c | 27 ++++++++++++++++++++++++---
> > > > >  2 files changed, 42 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > > > > index 5ce50468aff1..170bd80da520 100644
> > > > > --- a/arch/riscv/include/asm/hwcap.h
> > > > > +++ b/arch/riscv/include/asm/hwcap.h
> > > > > @@ -34,7 +34,25 @@ extern unsigned long elf_hwcap;
> > > > >  #define RISCV_ISA_EXT_s              ('s' - 'a')
> > > > >  #define RISCV_ISA_EXT_u              ('u' - 'a')
> > > > >
> > > > > +/*
> > > > > + * Increse this to higher value as kernel support more ISA extensions.
> > > > > + */
> > > > >  #define RISCV_ISA_EXT_MAX    64
> > > > > +#define RISCV_ISA_EXT_NAME_LEN_MAX 32
> > > > > +
> > > > > +/* The base ID for multi-letter ISA extensions */
> > > > > +#define RISCV_ISA_EXT_BASE 26
> > > > > +
> > > > > +/*
> > > > > + * This enum represent the logical ID for each multi-letter RISC-V ISA extension.
> > > > > + * The logical ID should start from RISCV_ISA_EXT_BASE and must not exceed
> > > > > + * RISCV_ISA_EXT_MAX. 0-25 range is reserved for single letter
> > > > > + * extensions while all the multi-letter extensions should define the next
> > > > > + * available logical extension id.
> > > > > + */
> > > > > +enum riscv_isa_ext_id {
> > > > > +     RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
> > > > > +};
> > > > >
> > > > >  unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
> > > > >
> > > > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > > > > index e9e3b0693d16..469b9739faf7 100644
> > > > > --- a/arch/riscv/kernel/cpufeature.c
> > > > > +++ b/arch/riscv/kernel/cpufeature.c
> > > > > @@ -83,7 +83,7 @@ void __init riscv_fill_hwcap(void)
> > > > >
> > > > >       for_each_of_cpu_node(node) {
> > > > >               unsigned long this_hwcap = 0;
> > > > > -             unsigned long this_isa = 0;
> > > > > +             uint64_t this_isa = 0;
> > > > >
> > > > >               if (riscv_of_processor_hartid(node) < 0)
> > > > >                       continue;
> > > > > @@ -169,12 +169,22 @@ void __init riscv_fill_hwcap(void)
> > > > >                       if (*isa != '_')
> > > > >                               --isa;
> > > > >
> > > > > +#define SET_ISA_EXT_MAP(name, bit)                                           \
> > > > > +                     do {                                                    \
> > > > > +                             if ((ext_end - ext == sizeof(name) - 1) &&      \
> > > > > +                                  !memcmp(ext, name, sizeof(name) - 1)) {    \
> > > > > +                                     this_isa |= (1UL << bit);               \
> > > > > +                                     pr_info("Found ISA extension %s", name);\
> > > > > +                             }                                               \
> > > > > +                     } while (false)                                         \
> > > > > +
> > > > >                       if (unlikely(ext_err))
> > > > >                               continue;
> > > > >                       if (!ext_long) {
> > > > >                               this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
> > > > >                               this_isa |= (1UL << (*ext - 'a'));
> > > > >                       }
> > > > > +#undef SET_ISA_EXT_MAP
> > > > >               }
> > > > >
> > > > >               /*
> > > > > @@ -187,10 +197,21 @@ void __init riscv_fill_hwcap(void)
> > > > >               else
> > > > >                       elf_hwcap = this_hwcap;
> > > > >
> > > > > -             if (riscv_isa[0])
> > > > > +             if (riscv_isa[0]) {
> > > > > +#if IS_ENABLED(CONFIG_32BIT)
> > > > > +                     riscv_isa[0] &= this_isa & 0xFFFFFFFF;
> > > > > +                     riscv_isa[1] &= this_isa >> 32;
> > > > > +#else
> > > > >                       riscv_isa[0] &= this_isa;
> > > > > -             else
> > > > > +#endif
> > > > > +             } else {
> > > > > +#if IS_ENABLED(CONFIG_32BIT)
> > > > > +                     riscv_isa[0] = this_isa & 0xFFFFFFFF;
> > > > > +                     riscv_isa[1] = this_isa >> 32;
> > > > > +#else
> > > > >                       riscv_isa[0] = this_isa;
> > > > > +#endif
> > > > > +             }
> > > > >       }
> > > > >
> > > > >       /* We don't support systems with F but without D, so mask those out
> > > > >
> > > >
> > > >
> > > >
> > > >
> > >
> > >
> > >
> >
> >
> >
> >
> 
> 
> 




