Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5405A66CF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiH3PDH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 Aug 2022 11:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiH3PDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:03:04 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35E7107C75
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 08:03:01 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oT2lP-0007UQ-Vl; Tue, 30 Aug 2022 17:02:52 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     atishp@atishpatra.org, anup@brainfault.org, will@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, Conor.Dooley@microchip.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        philipp.tomsich@vrull.eu, cmuellner@linux.com, samuel@sholland.org,
        guoren@kernel.org
Subject: Re: [PATCH v2] drivers/perf: riscv_pmu_sbi: add support for PMU variant on T-Head C9xx cores
Date:   Tue, 30 Aug 2022 17:02:51 +0200
Message-ID: <3973491.N7aMVyhfb1@diego>
In-Reply-To: <3627040.SvYEEZNnvj@diego>
References: <20220826163500.1748653-1-heiko@sntech.de> <5f72e3da-d87d-2d8d-bb4b-d95dca65d4f7@microchip.com> <3627040.SvYEEZNnvj@diego>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 30. August 2022, 16:33:27 CEST schrieb Heiko Stübner:
> Am Freitag, 26. August 2022, 19:57:33 CEST schrieb Conor.Dooley@microchip.com:
> > On 26/08/2022 17:35, Heiko Stuebner wrote:
> > > diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> > > index 202c83f677b2..e6101eab25c8 100644
> > > --- a/arch/riscv/errata/thead/errata.c
> > > +++ b/arch/riscv/errata/thead/errata.c
> > > @@ -44,6 +44,22 @@ static bool errata_probe_cmo(unsigned int stage,
> > >  #endif
> > >  }
> > > 
> > > +static bool errata_probe_pmu(unsigned int stage,
> > > +                            unsigned long arch_id, unsigned long impid)
> > > +{
> > > +#ifdef CONFIG_ERRATA_THEAD_PMU
> > 
> > Is there a reason that all the alternatives use ifdef
> > rather than if(IS_ENABLED())?
> 
> no real reason I guess - more like not enough thinking :-)
> 
> Using IS_ENABLED also makes it way nicer as we can just do
> 
> 	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_PMU))
> 		return false;

Though at least for the CMO this is not possible, as the
	riscv_noncoherent_supported()
is not defined in that case.

Though it might be nice to define a stub for the
not-CONFIG_RISCV_DMA_NONCOHERENT case
so that we don't need to #ifdef around it.


