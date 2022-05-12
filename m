Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD71524D41
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353903AbiELMm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348607AbiELMmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:42:53 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6980166FA3;
        Thu, 12 May 2022 05:42:50 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1np89T-00025a-Rp; Thu, 12 May 2022 14:42:43 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        DTML <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH 1/2] RISC-V: Fix counter restart during overflow for RV32
Date:   Thu, 12 May 2022 14:42:42 +0200
Message-ID: <23274575.ouqheUzb2q@diego>
In-Reply-To: <CAAhSdy3mbGdK9LrLxZX0JL0mQxP5FrFUuneX1cQS2SABpO=7dw@mail.gmail.com>
References: <20220511201107.2311757-1-atishp@rivosinc.com> <CAAhSdy3mbGdK9LrLxZX0JL0mQxP5FrFUuneX1cQS2SABpO=7dw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 12. Mai 2022, 06:44:12 CEST schrieb Anup Patel:
> On Thu, May 12, 2022 at 1:41 AM Atish Patra <atishp@rivosinc.com> wrote:
> >
> > Pass the upper half of the initial value of the counter correctly
> > for RV32.
> >
> > Fixes: 4905ec2fb7e6 ("RISC-V: Add sscofpmf extension support")
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  drivers/perf/riscv_pmu_sbi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> > index a1317a483512..24cea59612be 100644
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -526,7 +526,7 @@ static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
> >                         max_period = riscv_pmu_ctr_get_width_mask(event);
> >                         init_val = local64_read(&hwc->prev_count) & max_period;
> >                         sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx, 1,
> > -                                 flag, init_val, 0, 0);
> > +                                 flag, init_val, init_val >> 32, 0);
> 
> This should be under "#if __riscv_xlen == 32".

What's the difference between using CONFIG_32BIT
and checking the __riscv_xlen flag value?

CONFIG_32BIT seems to be a bit the more kernel'ish
way to do this, but it looks like most SBI parts check the
__riscv_xlen instead.


In any case, looking at the opensbi-side of the call,
this fix is abviously correct, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



