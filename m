Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D00568995
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiGFNc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiGFNcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:32:51 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CD82495E;
        Wed,  6 Jul 2022 06:32:49 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id q6so27081118eji.13;
        Wed, 06 Jul 2022 06:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=BwTGtm/bNRREp1aBUcAs+S7luq0oxviV8pBVWLt+InY=;
        b=GKPSWMhBOzfO/YBN78J2m6A42DBcc3C2SEoO/Cf5G/XgZwOmGDdXUamaES8swT89Gu
         OGnX6W9oA3Mdu6dObmhJUUIjTSaq9fvK/p3nBY/RnUKCNIZihERp0OTTOjfTS0x7k0w8
         KULYv6JwX/onnhP5PU8ruMITdTbPb+OFJmi3GdK+arf61qONcqdWn9yKbE/Gxog1JfBh
         ZSJeNBU9V4JkQES1saWAaImlmXPkUQ+XTtl1UimatEbCgN3TQlkdL2olz7E2xH4Ct5qg
         +NQoJyXJaspkF2IhOcNwjOP3uBVRW6FM5EpHgDzaYGJhOzWgZQM2iGpRClbdn6LACfft
         55ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=BwTGtm/bNRREp1aBUcAs+S7luq0oxviV8pBVWLt+InY=;
        b=3Bav7XZQwAP2L4OOUpHiFGCd9F/AsgMfCZ9Tgx/yuLEZ3L0gxOAcI33hrEv2Qr9F7W
         mGQLkUVmMefqx3LM1p/acbYiyLKqzIEsVKYwFVa+ahFCPS0kJ9A/jvVDXaQ3l3CtFha2
         lxu2dSeGzESbMByozucPhe/R0OAfTjO4RbdW2BoiRMDGmLLlrZ/uoFSFTI8kwRp7d60M
         absf9eFLJ61rOF0Ss+4KraYvDsbkiqC2VE4M07mSMBlmV1e6djD8Ya/Wysjjb2DqX8zm
         S79WYd4UzCZ7oooaqYqiOXWiS98yKNbChmxtRtimQkvub8lH/fwGuavdcKoiqyUSn8sR
         Klbg==
X-Gm-Message-State: AJIora9617bp/c1TKCjtnt/55h/b9QGyA7UUc2CkBiE1uKN+I5d3K3Xb
        xrMZOyUKdZeWDOPmBdeBmkw=
X-Google-Smtp-Source: AGRyM1tSWBqRJwiH9jeXNAt4N2H9owkS7npZHATrZq4RIBHTxekj9ewJKTqjuQqn9AsFzffHabae/w==
X-Received: by 2002:a17:907:3f9f:b0:726:39d8:4c8c with SMTP id hr31-20020a1709073f9f00b0072639d84c8cmr38616750ejc.241.1657114367842;
        Wed, 06 Jul 2022 06:32:47 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id ml22-20020a170906cc1600b006febce7081bsm17412760ejb.163.2022.07.06.06.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 06:32:47 -0700 (PDT)
Message-ID: <62c58eff.1c69fb81.9bbbf.f072@mx.google.com>
X-Google-Original-Message-ID: <YsWLGqZxMZfUnlL3@Ansuel-xps.>
Date:   Wed, 6 Jul 2022 15:16:10 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] clk: qcom: clk-rpm: convert to parent_data API
References: <20220705202837.667-1-ansuelsmth@gmail.com>
 <20220705202837.667-4-ansuelsmth@gmail.com>
 <92d41b82-97ab-723d-4191-1fcaca17fb76@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92d41b82-97ab-723d-4191-1fcaca17fb76@somainline.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 03:26:53PM +0200, Konrad Dybcio wrote:
> 
> 
> On 5.07.2022 22:28, Christian Marangi wrote:
> > Convert clk-rpm driver to parent_data API and change parent names to cxo
> > and pxo instead of the board variant as pxo_board is an ancient name and
> > pxo should be used instead.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/clk/qcom/clk-rpm.c | 24 ++++++++++++++++--------
> >  1 file changed, 16 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/clk/qcom/clk-rpm.c b/drivers/clk/qcom/clk-rpm.c
> > index a18811c38018..d45a8b0fc97c 100644
> > --- a/drivers/clk/qcom/clk-rpm.c
> > +++ b/drivers/clk/qcom/clk-rpm.c
> > @@ -23,6 +23,14 @@
> >  #define QCOM_RPM_SCALING_ENABLE_ID			0x2
> >  #define QCOM_RPM_XO_MODE_ON				0x2
> >  
> > +static const struct clk_parent_data gcc_pxo[] = {
> > +	{ .fw_name = "pxo", .name = "pxo" },
> The .name lookup should include _board, as the old DTs expect that.
> If I understand correctly though, you need to preserve both pxo and
> pxo_board, as they were separate, not sure though..
>

pxo_board is what comes first... then qcom gcc driver hacks it and
create a factor clk with 1/1 div and provide pxo.
In practice they are the same clk. But yhea I should not change the
name, will resent with .name = pxo_board and be done with it.

> Konrad
> > +};
> > +
> > +static const struct clk_parent_data gcc_cxo[] = {
> > +	{ .fw_name = "cxo", .name = "cxo" },
> > +};
> > +
> >  #define DEFINE_CLK_RPM(_platform, _name, _active, r_id)			      \
> >  	static struct clk_rpm _platform##_##_active;			      \
> >  	static struct clk_rpm _platform##_##_name = {			      \
> > @@ -32,8 +40,8 @@
> >  		.hw.init = &(struct clk_init_data){			      \
> >  			.ops = &clk_rpm_ops,				      \
> >  			.name = #_name,					      \
> > -			.parent_names = (const char *[]){ "pxo_board" },      \
> > -			.num_parents = 1,				      \
> > +			.parent_data = gcc_pxo,				      \
> > +			.num_parents = ARRAY_SIZE(gcc_pxo),		      \
> >  		},							      \
> >  	};								      \
> >  	static struct clk_rpm _platform##_##_active = {			      \
> > @@ -44,8 +52,8 @@
> >  		.hw.init = &(struct clk_init_data){			      \
> >  			.ops = &clk_rpm_ops,				      \
> >  			.name = #_active,				      \
> > -			.parent_names = (const char *[]){ "pxo_board" },      \
> > -			.num_parents = 1,				      \
> > +			.parent_data = gcc_pxo,				      \
> > +			.num_parents = ARRAY_SIZE(gcc_pxo),		      \
> >  		},							      \
> >  	}
> >  
> > @@ -56,8 +64,8 @@
> >  		.hw.init = &(struct clk_init_data){			      \
> >  			.ops = &clk_rpm_xo_ops,			      \
> >  			.name = #_name,					      \
> > -			.parent_names = (const char *[]){ "cxo_board" },      \
> > -			.num_parents = 1,				      \
> > +			.parent_data = gcc_cxo,				      \
> > +			.num_parents = ARRAY_SIZE(gcc_cxo),		      \
> >  		},							      \
> >  	}
> >  
> > @@ -68,8 +76,8 @@
> >  		.hw.init = &(struct clk_init_data){			      \
> >  			.ops = &clk_rpm_fixed_ops,			      \
> >  			.name = #_name,					      \
> > -			.parent_names = (const char *[]){ "pxo" },	      \
> > -			.num_parents = 1,				      \
> > +			.parent_data = gcc_pxo,				      \
> > +			.num_parents = ARRAY_SIZE(gcc_pxo),		      \
> >  		},							      \
> >  	}
> >  

-- 
	Ansuel
