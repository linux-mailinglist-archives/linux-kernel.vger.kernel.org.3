Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF705AB533
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbiIBPb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbiIBPbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:31:03 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6633BFE89
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:12:21 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oU8L0-0004mX-U0; Fri, 02 Sep 2022 17:12:06 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        guoren@kernel.org, apatel@ventanamicro.com, atishp@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] riscv: cleanup svpbmt cpufeature probing
Date:   Fri, 02 Sep 2022 17:12:06 +0200
Message-ID: <2910587.GUh0CODmnK@diego>
In-Reply-To: <20220902094939.wvzovl6ytujtjbtm@kamzik>
References: <20220901222744.2210215-1-heiko@sntech.de> <20220902094939.wvzovl6ytujtjbtm@kamzik>
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

Am Freitag, 2. September 2022, 11:49:39 CEST schrieb Andrew Jones:
> Hi Heiko,
> 
> Please use a cover-letter for a patch series. They allow the series to be
> threaded better and people can reply to the cover-letter with series-wide
> comments. For example, I'd like to reply to a cover-letter now with
> 
> For the series
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
> but now it looks like I need to go back and reply to each patch
> separately.

I'm not sure if tooling like b4 can handle Reviewed-by's in cover-letters.
At least some time back it couldn't, so am not sure if that was added
meanwhile. So tags added to cover-letters might even get lost.

But I'll add a cover-letter nevertheless - need a place for the v2 changelog
anyway :-)

Heiko


> 
> Thanks,
> drew
> 
> On Fri, Sep 02, 2022 at 12:27:41AM +0200, Heiko Stuebner wrote:
> > This can also do without the ifdef and use IS_ENABLED instead and
> > for better readability, getting rid of that switch also seems
> > waranted.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  arch/riscv/kernel/cpufeature.c | 13 +++++--------
> >  1 file changed, 5 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 553d755483ed..764ea220161f 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -253,16 +253,13 @@ void __init riscv_fill_hwcap(void)
> >  #ifdef CONFIG_RISCV_ALTERNATIVE
> >  static bool __init_or_module cpufeature_probe_svpbmt(unsigned int stage)
> >  {
> > -#ifdef CONFIG_RISCV_ISA_SVPBMT
> > -	switch (stage) {
> > -	case RISCV_ALTERNATIVES_EARLY_BOOT:
> > +	if (!IS_ENABLED(CONFIG_RISCV_ISA_SVPBMT))
> >  		return false;
> > -	default:
> > -		return riscv_isa_extension_available(NULL, SVPBMT);
> > -	}
> > -#endif
> >  
> > -	return false;
> > +	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> > +		return false;
> > +
> > +	return riscv_isa_extension_available(NULL, SVPBMT);
> >  }
> >  
> >  static bool __init_or_module cpufeature_probe_zicbom(unsigned int stage)
> 




