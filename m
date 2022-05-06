Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E77451DD4D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443707AbiEFQP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443839AbiEFQOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:14:32 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BDA517C9;
        Fri,  6 May 2022 09:10:30 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id g6so15363824ejw.1;
        Fri, 06 May 2022 09:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q7S/y28eqi3N/L95p7EBMJ6GJfVto1Y5X4u2RhsC0wE=;
        b=nDxXrLK/2alK0R/dV4PoFxfaIc0++7aUntrgqo9m3deZ6M4YC49MFiKb3uvMZBR3Zh
         2OF89jimVV/FPGFX3PncALdtEZGACmelc8xysgk5tLxz7ZECRUkz7PmgQOMO5H7O3zPc
         UwT/Y9XlitVF7JygPxTx8i13/0fpmU9XMK2FeRrlyPHkpUPFzvrJug8q45Sy7mKqFUug
         uN7AkrMaxy548vq2rjZriaZBuLq+Jr3xYLBH5ObUshZyV4a2b1Htrr4tMuUaJ2YBhZkq
         eQSkO5/gSwhZHosByDPvFwG2VEnsGQblvR3n4S4Fv4f03Y2otdhZGwpVsjhpCeAEt17+
         yoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q7S/y28eqi3N/L95p7EBMJ6GJfVto1Y5X4u2RhsC0wE=;
        b=gDOunqDLKFZPJU5+2IV7B3eOQZpHPETvumsYdRlk8+v7qne7E2jkE2QtBUyCGV4UHL
         UwYG5V6a+pJ7IlSrK9Lg4CWvP/39jqMSs8jh/cfjvwD6hiaQgfRUyv+sKHhZCKMdDuLx
         hs8kfyjVz59Ax+p7A5H6MpMPDgoxzbwvBJ5ASTrMlsOe8tjyitYRREUaRE1+fe1XoIyj
         XzoBoeJCF91Lc9heH9cJTayI9IDty+2FTQ+bK/UKAvn5LedftpnhKsnkXbyxPDol3fU3
         XGqSoa+kcjYkLQD7s05H+jtrHhrU7MnIXdu/H4kLQSJ15BBSX87QhVnCyXvpzJDwDbS/
         VlXQ==
X-Gm-Message-State: AOAM532nfwGRF9WBjtTMLBzQgHdg7wCUZTxjhjV4oEfa10/UxH4jzaCS
        HMKQMfZyuwVPI453tRStm1o=
X-Google-Smtp-Source: ABdhPJywfqlagcm1d/F3oR/wXhzRvDeJuuiv9xPJejbTkQJwuvMkE+QedR/B+OQM4YCWROCiFWqiuw==
X-Received: by 2002:a17:907:728f:b0:6f4:5d2d:38c8 with SMTP id dt15-20020a170907728f00b006f45d2d38c8mr3423115ejc.345.1651853428706;
        Fri, 06 May 2022 09:10:28 -0700 (PDT)
Received: from kista.localnet (cpe1-3-76.cable.triera.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id g3-20020a056402424300b0042617ba6387sm2499443edb.17.2022.05.06.09.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 09:10:28 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: Re: Re: [PATCH v11 1/6] clk: sunxi-ng: h6-r: Add RTC gate clock
Date:   Fri, 06 May 2022 18:10:26 +0200
Message-ID: <2108126.Mh6RI2rZIc@kista>
In-Reply-To: <875fc3d6-fb45-903c-e52e-4abf43b46db2@sholland.org>
References: <20220428230933.15262-1-andre.przywara@arm.com> <20220428230933.15262-2-andre.przywara@arm.com> <875fc3d6-fb45-903c-e52e-4abf43b46db2@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 03. maj 2022 ob 04:06:59 CEST je Samuel Holland napisal(a):
> On 4/28/22 6:09 PM, Andre Przywara wrote:
> > The H6 and H616 feature an (undocumented) bus clock gate for accessing
> > the RTC registers. This seems to be enabled at reset (or by the BootROM),
> > so we got away without it so far, but exists regardless.
> > Since the new RTC clock binding for the H616 requires this "bus" clock
> > to be specified in the DT, add this to R_CCU clock driver and expose it
> > on the DT side with a new number.
> > We do this for both the H6 and H616, but mark it as IGNORE_UNUSED, as we
> > cannot reference it in any H6 DTs.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> Reviewed-by: Samuel Holland <samuel@sholland.org>
> 
> One tiny nit below, if you resend.

Fixed and applied to sunxi/clk-for-5.19, thanks!

Best regards,
Jernej

> 
> > ---
> >  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c      | 5 +++++
> >  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h      | 2 +-
> >  include/dt-bindings/clock/sun50i-h6-r-ccu.h | 1 +
> >  3 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/
ccu-sun50i-h6-r.c
> > index 712e103382d8..88509339031e 100644
> > --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> > +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> > @@ -98,6 +98,8 @@ static SUNXI_CCU_GATE(r_apb1_ir_clk,	"r-apb1-ir",	
"r-apb1",
> >  		      0x1cc, BIT(0), 0);
> >  static SUNXI_CCU_GATE(r_apb1_w1_clk,	"r-apb1-w1",	"r-apb1",
> >  		      0x1ec, BIT(0), 0);
> > +static SUNXI_CCU_GATE(r_apb1_rtc_clk,	"r-apb1-rtc",	"r-apb1",
> > +		      0x20c, BIT(0), CLK_IGNORE_UNUSED);
> >  
> >  /* Information of IR(RX) mod clock is gathered from BSP source code */
> >  static const char * const r_mod0_default_parents[] = { "osc32k", "osc24M" 
};
> > @@ -147,6 +149,7 @@ static struct ccu_common *sun50i_h616_r_ccu_clks[] = {
> >  	&r_apb2_i2c_clk.common,
> >  	&r_apb2_rsb_clk.common,
> >  	&r_apb1_ir_clk.common,
> > +	&r_apb1_rtc_clk.common,
> >  	&ir_clk.common,
> >  };
> >  
> > @@ -163,6 +166,7 @@ static struct clk_hw_onecell_data sun50i_h6_r_hw_clks 
= {
> >  		[CLK_R_APB2_I2C]	= &r_apb2_i2c_clk.common.hw,
> >  		[CLK_R_APB2_RSB]	= &r_apb2_rsb_clk.common.hw,
> >  		[CLK_R_APB1_IR]		= 
&r_apb1_ir_clk.common.hw,
> > +		[CLK_R_APB1_RTC]	= &r_apb1_rtc_clk.common.hw,
> >  		[CLK_R_APB1_W1]		= 
&r_apb1_w1_clk.common.hw,
> 
> The new clock should go after CLK_R_APB1_W1 to match the ordering above.
> 
> >  		[CLK_IR]		= &ir_clk.common.hw,
> >  		[CLK_W1]		= &w1_clk.common.hw,
> > @@ -179,6 +183,7 @@ static struct clk_hw_onecell_data 
sun50i_h616_r_hw_clks = {
> >  		[CLK_R_APB2_I2C]	= &r_apb2_i2c_clk.common.hw,
> >  		[CLK_R_APB2_RSB]	= &r_apb2_rsb_clk.common.hw,
> >  		[CLK_R_APB1_IR]		= 
&r_apb1_ir_clk.common.hw,
> > +		[CLK_R_APB1_RTC]	= &r_apb1_rtc_clk.common.hw,
> >  		[CLK_IR]		= &ir_clk.common.hw,
> >  	},
> >  	.num	= CLK_NUMBER,
> > diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h b/drivers/clk/sunxi-ng/
ccu-sun50i-h6-r.h
> > index 7e290b840803..10e9b66afc6a 100644
> > --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
> > +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
> > @@ -14,6 +14,6 @@
> >  
> >  #define CLK_R_APB2	3
> >  
> > -#define CLK_NUMBER	(CLK_R_APB2_RSB + 1)
> > +#define CLK_NUMBER	(CLK_R_APB1_RTC + 1)
> >  
> >  #endif /* _CCU_SUN50I_H6_R_H */
> > diff --git a/include/dt-bindings/clock/sun50i-h6-r-ccu.h b/include/dt-
bindings/clock/sun50i-h6-r-ccu.h
> > index 890368d252c4..a96087abc86f 100644
> > --- a/include/dt-bindings/clock/sun50i-h6-r-ccu.h
> > +++ b/include/dt-bindings/clock/sun50i-h6-r-ccu.h
> > @@ -22,5 +22,6 @@
> >  #define CLK_W1			12
> >  
> >  #define CLK_R_APB2_RSB		13
> > +#define CLK_R_APB1_RTC		14
> >  
> >  #endif /* _DT_BINDINGS_CLK_SUN50I_H6_R_CCU_H_ */
> > 
> 
> 


