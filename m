Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924D04C305B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbiBXPvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbiBXPvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:51:02 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8847D144F7E;
        Thu, 24 Feb 2022 07:50:31 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id i19so103194wmq.5;
        Thu, 24 Feb 2022 07:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VAU+x/FHA6Jlc8xXCTAj1x5xOvKQnNZlbxhMra3k1+0=;
        b=UgjMfNueviHEAJ5uQi9+BHYmwDK310ew8O/yaCEfOS6cdIaDmnZjRCenXTVSSTTOqs
         p860KcKtVd2JW6hEHzWGW8oxfEEpYFhZMERoS3au1eUOJYSCHn/+SGD90bsdTeMRJG5q
         gJpgfUG8KD1maVcSw/LEZg3f8wJ503IrFV6Y9wSvLgKghv+4EcZdb9t5N7wKqtb0JPPt
         UZ2ZdIug+TvDncdlAMk9qcm9uGUtCjUlBXA0cyTad91yjyG5dKnz63ragS/bG6d/pL8h
         MMrRSPq5WRSK0X319texLFLz53pNdxl4zKE8ol9r32eQxgYM3hoJUAQKAukHrd6g9I7t
         lKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VAU+x/FHA6Jlc8xXCTAj1x5xOvKQnNZlbxhMra3k1+0=;
        b=tk+gq3SdM+IsPJ/tf5mfJrwMLK0rm9zHvnowOeV94zhBbgfgV0aUVhY0ITbw9HTCPU
         eOJfnAb/R4uM6z9JPJVHbe6oqxt+YQ0BqxPAXztSo+9KK82jHl0mDDfcwGaiGaKnZgCB
         YtlGjlKvWZrWSinN7lmdeoh4idANFetm7021PdO+4hRsAERb6tSBvautUsw0Fv3SmSLk
         e8yOkCN+v3ZMJq2RBH7WDusE771t2mUOW8nJricQgEG1egAvB6OKZHf02BjxxPUnHAQW
         BIBhTWreJAsjqBd/6G1sHs0JECKeSRqdYMH3UkTBRrdcTBjznaGGqngGgr0yqeh2S+zV
         Qdjw==
X-Gm-Message-State: AOAM533plDCHZiZgJg/UvAgwvwkplyNY+jR2KiT7Ed9UMUdgQH9MnqZb
        w2kTWu8m6YF7QBjljcwrsM0ENPwW4Xk=
X-Google-Smtp-Source: ABdhPJyubDOmrxGB9Txp+2yBZMCjNf+ech3jj6h/8obNifoEBTzPHkPdViTBhH9Da7LvQQ0wgyjbQg==
X-Received: by 2002:a05:600c:3046:b0:380:d5d3:930e with SMTP id n6-20020a05600c304600b00380d5d3930emr11229595wmh.12.1645717829865;
        Thu, 24 Feb 2022 07:50:29 -0800 (PST)
Received: from Ansuel-xps.localdomain ([5.170.140.187])
        by smtp.gmail.com with ESMTPSA id e9sm3001686wrx.3.2022.02.24.07.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 07:50:29 -0800 (PST)
Date:   Thu, 24 Feb 2022 16:50:25 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/16] clk: qcom: gcc-ipq806x: drop hardcoded pxo and
 cxo source clk
Message-ID: <YhepQc3k8l1g5NZ/@Ansuel-xps.localdomain>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
 <20220217235703.26641-8-ansuelsmth@gmail.com>
 <YhcAdq4ouQenhn2f@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhcAdq4ouQenhn2f@builder.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 09:50:14PM -0600, Bjorn Andersson wrote:
> On Thu 17 Feb 17:56 CST 2022, Ansuel Smith wrote:
> 
> > We now define these clk in dts. Drop pxo and cxo hardcoded in the gcc
> > probe function.
> > 
> 
> As noted on the previous patch, this breaks booting with existing dtbs.
> So I would like to split this with 1-2 releases in between to avoid any
> problems.
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> on the change though.
> 
> Regards,
> Bjorn
>

Should I change this and register these clks only if they are not present?

> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  drivers/clk/qcom/gcc-ipq806x.c | 11 +----------
> >  1 file changed, 1 insertion(+), 10 deletions(-)
> > 
> > diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
> > index f6db7247835e..a4bf78fe8678 100644
> > --- a/drivers/clk/qcom/gcc-ipq806x.c
> > +++ b/drivers/clk/qcom/gcc-ipq806x.c
> > @@ -3119,23 +3119,14 @@ MODULE_DEVICE_TABLE(of, gcc_ipq806x_match_table);
> >  
> >  static int gcc_ipq806x_probe(struct platform_device *pdev)
> >  {
> > -	struct device *dev = &pdev->dev;
> >  	struct regmap *regmap;
> >  	int ret;
> >  
> > -	ret = qcom_cc_register_board_clk(dev, "cxo_board", "cxo", 25000000);
> > -	if (ret)
> > -		return ret;
> > -
> > -	ret = qcom_cc_register_board_clk(dev, "pxo_board", "pxo", 25000000);
> > -	if (ret)
> > -		return ret;
> > -
> >  	ret = qcom_cc_probe(pdev, &gcc_ipq806x_desc);
> >  	if (ret)
> >  		return ret;
> >  
> > -	regmap = dev_get_regmap(dev, NULL);
> > +	regmap = dev_get_regmap(&pdev->dev, NULL);
> >  	if (!regmap)
> >  		return -ENODEV;
> >  
> > -- 
> > 2.34.1
> > 

-- 
	Ansuel
