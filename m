Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4417A5A0714
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 04:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiHYCE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 22:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiHYCE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 22:04:56 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C624FD6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 19:04:52 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oR2Ee-00072W-FB; Thu, 25 Aug 2022 04:04:44 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Atish Patra <atishp@atishpatra.org>,
        Anup Patel <apatel@ventanamicro.com>
Cc:     anup@brainfault.org, will@kernel.org, mark.rutland@arm.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, philipp.tomsich@vrull.eu,
        cmuellner@linux.com
Subject: Re: [PATCH] drivers/perf: riscv_pmu_sbi: add support for PMU variant on T-Head C9xx cores
Date:   Thu, 25 Aug 2022 04:04:43 +0200
Message-ID: <13084187.uLZWGnKmhe@phil>
In-Reply-To: <CAK9=C2U3OvUZmYTJ-C0wkSp8ViPA1+Nj2L6pd4CHTCuzaVtDJg@mail.gmail.com>
References: <20220817111348.745527-1-heiko@sntech.de> <CAOnJCUJu1fr2qxOkX4Sz-kLhB64xkcjAbBAeTkp214ZHAa0btA@mail.gmail.com> <CAK9=C2U3OvUZmYTJ-C0wkSp8ViPA1+Nj2L6pd4CHTCuzaVtDJg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 18. August 2022, 10:24:33 CEST schrieb Anup Patel:
> On Thu, Aug 18, 2022 at 1:03 AM Atish Patra <atishp@atishpatra.org> wrote:
> >
> > On Wed, Aug 17, 2022 at 4:13 AM Heiko Stuebner <heiko@sntech.de> wrote:
> > >
> > > With the T-HEAD C9XX cores being designed before or during the ratification
> > > to the SSCOFPMF extension, they implement functionality very similar but
> > > not equal to it. So add some adaptions to allow the C9XX to still handle
> > > its PMU through the regular SBI PMU interface instead of defining new
> > > interfaces or drivers.
> > >
> >
> > IMO, vendor specific workarounds in the generic implementation is not
> > a good idea.
> > If we have to support it, I think we should just put the IRQ number in
> > the DT and parse from the DT.
> > The initial sscofpmf series was based on the DT. It was removed later
> > as there was no need for it at that time.
> > We can always revive it.
> >
> > Regarding the CSR number difference and static key enablement, can we
> > use code patching techniques here as well ?
> > At least all the T-HEAD C9XX core erratas are in one place.
> >
> > The alternate would be just to say T-HEAD C9XX support SSCOFPMF but
> > with erratas. I don't prefer this approach
> > but it keeps the vendor specific checks out of the generic code.
> 
> Whether to have a DT node (or not) was already discussed and concluded
> in the past.
> 
> We don't need a DT node just to get the IRQ number. The T-HEAD custom
> IRQ number can be derived based on mvendorid.

Yeah, I remember reading that discussion and thus went with the mvendorid
way in this patch.

> Also, all these T-HEAD specific changes in SBI PMU driver should be
> implemented as erratas using ALTERNATIVE() macros.

(1) "All these T-HEAD specific changes ..."
Actually the only T-HEAD-specific change is reading that different CSR
for the overflow information, the rest only makes the irq-number variable

(2) ALTERNATIVE macros are working on assembler instructions, so are you
sugesting to replace the generic csr_read() for the overflow-csr with a
custom copy like

#define sbi_pmu_read_overflow(void)						\
({								\
	register unsigned long __v;				\
	ALT_THEAD_PMU_OVERFLOW(__v); \
	__v;							\
})

and then in errata_list.h

#define ALT_THEAD_PMU_OVERFLOW(__ovl) \
__asm__ __volatile__ (alternative(
	"csrr %0, " __ASM_STR(CSR_SSCOUNTOVF),	\
	"csrr %0, " __ASM_STR(THEAD_C9XX_CSR_SCOUNTEROF), THEAD_VENDOR_ID, \
		ERRATA_THEAD_PMU, CONFIG_ERRATA_THEAD_PMU) \
			      : "=r" (__ovl) :			\
			      : "memory");

I'm not yet seeing what you're gaining by going with this approach:
- that the overflow-csr is the same bitwise but only at a different
  address is specific to the c9xx, other deviants might implement things
  completely different
- you're not getting rid of the thead mention
- and we're now duplicating the generic csr-read code

Is this the preferred way or what am I overlooking?

Thanks
Heiko


