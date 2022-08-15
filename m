Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5671592CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiHOIYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiHOIYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:24:01 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00FA1F61F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:23:59 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n4so8204267wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=ccR4jofJWS4WjddLtDejUK8NNWJJwrLYpOoeEAK37hk=;
        b=Z4OrasUxwxONGoGSbJZ7h5ZiVDJCbioDFPaHHgazEMdyqJJQyiku6tGWNWKTBxDDij
         0XFLBmX+VKlhOW3GlHqttMscBJR/jHcG+2v12k6Saa+CiBcOnZdA3V1wyJLfs2NW9luD
         OI12bNtPzaSOi2q8S34U+cWSx6mFLjiXHMgGEyxjYoxR9ewN8DqFLFMGEaOLtkFCU7K6
         uMw0JCmAI4mkcpndUwsHxNzg4EGDXfB1SNKIN6iinjKhq5AiHj8qzTYoZaIWD/5JRuWL
         LT68U7GpoBQsbC/iS1pWAanZb98vASc0qbmjpZsf2YHcQ/Bm6TdkViWsHUFj4DVL48Kn
         eXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ccR4jofJWS4WjddLtDejUK8NNWJJwrLYpOoeEAK37hk=;
        b=jA2nWmwRmrt6Blgj6buQ0XDGYtiaEfwecXHCiPH1ujp341rjY3B6XhLfp0GJhDIZrA
         6sNJTQqTdeMguKPv0wfLLO89Sggl141tN0P1v2BTdloOpfMdgvvOT+VR4P1sxnA9wXEY
         ZHDWFz6JpwPv3Oc1LrmHN3Mzu8gGqfhzXyxGm/muCkN95MblmxdECyNTL4uytTxKkehY
         RC0JcB2L/x2jSqgiT5RpH5awod/S/0ULJvT/7z+RmOVUJpDbK1Bfj/B9y7ZlgakLxcXp
         Ze11aN1MK2nkHTM9cTTNGYj59FnmCmXHPTuLFOMiKu+wAyYpau8+ttwputHWgDudlNtw
         hAoQ==
X-Gm-Message-State: ACgBeo2BZa/PAOjNjSAapzVj/2cCB8mYU3gEjorOB0+IhQ1YYOxvBFHH
        7hKRgR+O+7KtZTd24A0yvqq3lg==
X-Google-Smtp-Source: AA6agR6vOZElDps4UHQbfw36ab2JeSARI3ajaEksSEKZIFJEVKaK27WUb3W9MKgJkVPPBd8kJfPTEQ==
X-Received: by 2002:a5d:5b17:0:b0:220:7cec:2953 with SMTP id bx23-20020a5d5b17000000b002207cec2953mr8158320wrb.697.1660551838382;
        Mon, 15 Aug 2022 01:23:58 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id q65-20020a1c4344000000b003a54d610e5fsm9033154wma.26.2022.08.15.01.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 01:23:57 -0700 (PDT)
Date:   Mon, 15 Aug 2022 11:23:56 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH V2 2/8] clk: imx93: guard imx93_clk_of_match with
 CONFIG_OF
Message-ID: <YvoCnLb1azLr4bno@linaro.org>
References: <20220815013039.474970-1-peng.fan@oss.nxp.com>
 <20220815013039.474970-3-peng.fan@oss.nxp.com>
 <YvoAwL9qhmE03kgi@linaro.org>
 <DU0PR04MB941789A6D3600233D878BBCB88689@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB941789A6D3600233D878BBCB88689@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-15 08:19:52, Peng Fan wrote:
> > Subject: Re: [PATCH V2 2/8] clk: imx93: guard imx93_clk_of_match with
> > CONFIG_OF
> > 
> > On 22-08-15 09:30:33, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > There is build warning when CONFIG_OF is not selected.
> > > >> drivers/clk/imx/clk-imx93.c:324:34: warning: 'imx93_clk_of_match'
> > > >> defined but not used [-Wunused-const-variable=]
> > >      324 | static const struct of_device_id imx93_clk_of_match[] = {
> > >          |                                  ^~~~~~~~~~~~~~~~~~
> > >
> > > Use CONFIG_OF to guard imx93_clk_of_match to avoid build warning.
> > >
> > > Fixes: 24defbe194b6 ("clk: imx: add i.MX93 clk")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/clk/imx/clk-imx93.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
> > > index f5c9fa40491c..5099048b7916 100644
> > > --- a/drivers/clk/imx/clk-imx93.c
> > > +++ b/drivers/clk/imx/clk-imx93.c
> > > @@ -321,11 +321,13 @@ static int imx93_clocks_probe(struct
> > platform_device *pdev)
> > >  	return ret;
> > >  }
> > >
> > > +#ifdef CONFIG_OF
> > 
> > Hmm, I'm not sure if we should do this or rather should we make this driver
> > depend somehow on CONFIG_OF in Kconfig.
> > 
> > Looking at the other i.MX clock drivers, it would seem we need this for all
> > them too.
> 
> No. It is i.MX93 use of_match_ptr, I could drop it as i.MX8M.
> 
> Thanks,
> Peng.

Right. Thanks for pointing that out.

> 
> > 
> > I fairly OK with this, but maybe Stephen suggests something different.
> > 
> > Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> > 

Oups, wrong address here too.

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> > >  static const struct of_device_id imx93_clk_of_match[] = {
> > >  	{ .compatible = "fsl,imx93-ccm" },
> > >  	{ /* Sentinel */ },
> > >  };
> > >  MODULE_DEVICE_TABLE(of, imx93_clk_of_match);
> > > +#endif
> > >
> > >  static struct platform_driver imx93_clk_driver = {
> > >  	.probe = imx93_clocks_probe,
> > > --
> > > 2.37.1
> > >
