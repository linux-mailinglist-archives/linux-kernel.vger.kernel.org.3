Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C6B5B0BED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiIGR7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiIGR7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:59:11 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EA2AEDB9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 10:59:08 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oVzK7-0007jl-Qw; Wed, 07 Sep 2022 19:58:51 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, Conor.Dooley@microchip.com
Cc:     samuel@sholland.org, guoren@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        lkp@intel.com
Subject: Re: [PATCH] riscv: make t-head erratas depend on MMU
Date:   Wed, 07 Sep 2022 19:58:51 +0200
Message-ID: <3490524.MsWZr2WtbB@diego>
In-Reply-To: <861b6cf0-c120-212f-43d8-3431551fe871@microchip.com>
References: <20220907154932.2858518-1-heiko@sntech.de> <861b6cf0-c120-212f-43d8-3431551fe871@microchip.com>
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

Am Mittwoch, 7. September 2022, 18:35:50 CEST schrieb Conor.Dooley@microchip.com:
> On 07/09/2022 16:49, Heiko Stuebner wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Both basic extensions of SVPBMT and ZICBOM depend on CONFIG_MMU.
> > Make the T-Head errata implementations of the similar functionality
> > also depend on it to prevent build errors.
> > 
> > Fixes: a35707c3d850 ("riscv: add memory-type errata for T-Head")
> > Fixes: d20ec7529236 ("riscv: implement cache-management errata for T-Head SoCs")
> > Reported-by: kernel test robot <lkp@intel.com>
> 
> In case anyone cares:
> Link: https://lore.kernel.org/all/202209070536.lIefsBuR-lkp@intel.com/
> 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  arch/riscv/Kconfig.erratas | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
> > index 6850e9389930..f3623df23b5f 100644
> > --- a/arch/riscv/Kconfig.erratas
> > +++ b/arch/riscv/Kconfig.erratas
> > @@ -46,7 +46,7 @@ config ERRATA_THEAD
> > 
> >  config ERRATA_THEAD_PBMT
> >         bool "Apply T-Head memory type errata"
> > -       depends on ERRATA_THEAD && 64BIT
> > +       depends on ERRATA_THEAD && 64BIT && MMU
> >         select RISCV_ALTERNATIVE_EARLY
> >         default y
> >         help
> > @@ -57,7 +57,7 @@ config ERRATA_THEAD_PBMT
> > 
> >  config ERRATA_THEAD_CMO
> >         bool "Apply T-Head cache management errata"
> > -       depends on ERRATA_THEAD
> > +       depends on ERRATA_THEAD && MMU
> 
> "Random" thought/question:
> These two (and the sifive) errata all use oneliner depends
> but the PMU series of yours has:
> config ERRATA_THEAD_PMU
> 	bool "Apply T-Head PMU errata"
> 	depends on ERRATA_THEAD
> 	depends on RISCV_PMU_SBI
> 
> What's the rationale behind not oneliner-ing that one?

probably not thinking too much about it beforehand ;-) .

But yes going with one line is probably nicer, so I transplanted this
comment over to the sbi-pmu patch, for when a v4 might be necessary.


Heiko


> That's obviously orthogonal to this patch though, so:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> >         select RISCV_DMA_NONCOHERENT
> >         default y
> >         help
> > --
> > 2.35.1
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> 




