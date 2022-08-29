Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176DB5A4667
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiH2Jrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiH2Jrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:47:51 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE375E555
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:47:42 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bj12so14530250ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=QaOr7kjQluQGEI4QV2hD0EQiXL95H1mMxF4HdlYCuAE=;
        b=f7o8fPMW6B7WvFxln1Qe3eGbeGqhFkg2XYREZfxcyBy1e9mUqrKPwYvihO/8xI+4kL
         KyoXDYhRnW/IsW7Dr1yRSkL9+Ysg5pZ1VI3EluWXHKPUelhPPQpMuO5Oxojm7UIw++hN
         KR9/gaNSSkIFbah6BJ7AaMZlvrjCBqZi3cYbwKWi1svT4eoV7no85EROHVo2AVGNINdA
         6D3jXQaQFNyKbTntuzD5iSHAedL8KoYJ6uojNd/E42poYjqITLFFi1gX3IYCh8RtMwHa
         Qj9NVVj71RUaVve/TAsC6zAg/lA/AvxHRH2IIWC2w2htHtz+1drcRU6LbvcpMjae6gfH
         4KUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=QaOr7kjQluQGEI4QV2hD0EQiXL95H1mMxF4HdlYCuAE=;
        b=1+3+MmDHP8IglOUgSt3fvrUw6fGUN0YojSWBHm+0nLlUJnMlUdmNcrv8tXbKl9jhmg
         f7N7zqor2MekLi4AzRxUDrhSh6kCe4Ogfcr5+vkGizb6INT86Qmt6NP3PQdDE+apIEf5
         CG6CEbi4HTwXf0ryNXPezCKp9IQefJ3lekGF1AEB7YFr4obOMCuI6HTkPDr8JDKCheKt
         HhXFx+8/pggIZQevCB/isajqAxwImD9xOED8wA8nKPipeiTs1cV4M6NsLLT5eSdy8Id2
         T9M3kTJsVErYNCjiwFyLaoMSvrIYiaqotybPikbqPu7YuSxajAvmbxASolmAwkxjnirD
         KQqg==
X-Gm-Message-State: ACgBeo1oGxF/ulcAF+70Udi5y901VYT2aq61EsJDtygZgFw478tslraJ
        zv2/8HhoD05ASAaefOVzi/MZ8bm0ll+7Mw==
X-Google-Smtp-Source: AA6agR7OYg5w837dFUNhKmYdquqWXSlFv2lZXe5CSTfsBz1vezlDTWNN194U8OpIYE9XoypLOD8OSg==
X-Received: by 2002:a17:906:ef8b:b0:730:d348:61b9 with SMTP id ze11-20020a170906ef8b00b00730d34861b9mr12883076ejb.350.1661766460573;
        Mon, 29 Aug 2022 02:47:40 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id r4-20020a50c004000000b00445f2dc2901sm5486165edb.21.2022.08.29.02.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 02:47:40 -0700 (PDT)
Date:   Mon, 29 Aug 2022 11:47:39 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <anup@brainfault.org>
Cc:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        mchitale@ventanamicro.com, heiko@sntech.de
Subject: Re: [PATCH 3/4] riscv: KVM: Apply insn-def to hfence encodings
Message-ID: <20220829094739.pn7iltmtimpwpshf@kamzik>
References: <20220819140250.3892995-1-ajones@ventanamicro.com>
 <20220819140250.3892995-4-ajones@ventanamicro.com>
 <CAAhSdy0d8mjr5-5Um2DpLgnhPb3UnGggXvbu_=oqEHWYzMP1SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy0d8mjr5-5Um2DpLgnhPb3UnGggXvbu_=oqEHWYzMP1SQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 02:07:59PM +0530, Anup Patel wrote:
> On Fri, Aug 19, 2022 at 7:32 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > Introduce hfence instruction encodings and apply them to KVM's use.
> > With the self-documenting nature of the instruction encoding macros,
> > and a spec always within arm's reach, it's safe to remove the
> > comments, so we do that too.
> >
> > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/insn-def.h |   8 ++
> >  arch/riscv/kvm/tlb.c              | 117 ++++--------------------------
> >  2 files changed, 21 insertions(+), 104 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
> > index 4cd0208068dd..cd1c0d365f47 100644
> > --- a/arch/riscv/include/asm/insn-def.h
> > +++ b/arch/riscv/include/asm/insn-def.h
> > @@ -79,4 +79,12 @@
> >  #define RS1(v)         __REG(v)
> >  #define RS2(v)         __REG(v)
> >
> > +#define OPCODE_SYSTEM  OPCODE(115)
> > +
> > +#define HFENCE_VVMA(vaddr, asid)       \
> > +       INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(17), RD(0), vaddr, asid)
> > +
> > +#define HFENCE_GVMA(gaddr, vmid)       \
> > +       INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(49), RD(0), gaddr, vmid)
> > +
> >  #endif /* __ASM_INSN_DEF_H */
> > diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
> > index 1a76d0b1907d..f742a0d888e1 100644
> > --- a/arch/riscv/kvm/tlb.c
> > +++ b/arch/riscv/kvm/tlb.c
> > @@ -12,22 +12,7 @@
> >  #include <linux/kvm_host.h>
> >  #include <asm/cacheflush.h>
> >  #include <asm/csr.h>
> > -
> > -/*
> > - * Instruction encoding of hfence.gvma is:
> > - * HFENCE.GVMA rs1, rs2
> > - * HFENCE.GVMA zero, rs2
> > - * HFENCE.GVMA rs1
> > - * HFENCE.GVMA
> > - *
> > - * rs1!=zero and rs2!=zero ==> HFENCE.GVMA rs1, rs2
> > - * rs1==zero and rs2!=zero ==> HFENCE.GVMA zero, rs2
> > - * rs1!=zero and rs2==zero ==> HFENCE.GVMA rs1
> > - * rs1==zero and rs2==zero ==> HFENCE.GVMA
> > - *
> > - * Instruction encoding of HFENCE.GVMA is:
> > - * 0110001 rs2(5) rs1(5) 000 00000 1110011
> > - */
> > +#include <asm/insn-def.h>
> >
> >  void kvm_riscv_local_hfence_gvma_vmid_gpa(unsigned long vmid,
> >                                           gpa_t gpa, gpa_t gpsz,
> > @@ -41,31 +26,14 @@ void kvm_riscv_local_hfence_gvma_vmid_gpa(unsigned long vmid,
> >         }
> >
> >         for (pos = gpa; pos < (gpa + gpsz); pos += BIT(order)) {
> > -               /*
> > -                * rs1 = a0 (GPA >> 2)
> > -                * rs2 = a1 (VMID)
> > -                * HFENCE.GVMA a0, a1
> > -                * 0110001 01011 01010 000 00000 1110011
> > -                */
> > -               asm volatile ("srli a0, %0, 2\n"
> > -                             "add a1, %1, zero\n"
> > -                             ".word 0x62b50073\n"
> > -                             :: "r" (pos), "r" (vmid)
> > -                             : "a0", "a1", "memory");
> > +               asm volatile (HFENCE_GVMA("%0", "%1")

Thank you for the review, Anup! I'd also like to get opinions on whether
the caller should quote the register tokens or the call should be made as,
e.g. HFENCE_GVMA(%0, %1), and then do the quoting inside the macro for
C callers. I could go either way, but I'm starting to lean towards moving
the quoting into the macros.

Thanks,
drew
