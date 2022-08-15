Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D34D592BFB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiHOIRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241754AbiHOIQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:16:06 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628E8BC9F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:16:04 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso3568993wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=2EXJc+W0WiUMq6IfoG1+NtWZXhyvP3kHwdxs6Qb3+pI=;
        b=lesTjrSSeDPkH8yf41Y3AxvP2AQWHSlFR2nZLz0HLlk0Iy/HCk1CAwtRsXGnaysNLb
         tAPLT55tzSp6Q00NGkh8fjsx3iauwjBUM8O3v0CAlAT+6AldoCZ/EbIXAkMg+QM0X3Gp
         vIpw0FhvUXYktjK+CfSyatCMeNnGJfZlQUqKFVLrfaDV+zvmcYJRE1R4wylzSrDMmy93
         8pDQD3zsL0CVnv00HRDyQz/AYIazyi2KrBYDq5LPJJOZS4eGqjMO2ATAGtrdSCEXhFVW
         610Xz9+r+sXk+hpO/EICxAbe/080Sdr6GvdrOFlhu/aJCAxusPgrTy20zVQQCuiegM24
         eV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=2EXJc+W0WiUMq6IfoG1+NtWZXhyvP3kHwdxs6Qb3+pI=;
        b=m4ckBqeRpkRasViTNj5Ron9XPVzPvcS17cYUtjQ9zZRbUVADh+oyiac/3Uiz+dOgKY
         biAkC5+/oH7L6m8HyQo6se3N35/G8SJFzHFsXe13CF33ufbC3nezh+b80rZJ6Z44DGJ3
         8uAaWnhjGljksjB84306E98GO4Lz4KJqM44Ak5yR5TlfUrnAnH/Cq3i+QvgiQQjgLFZ5
         1C1TNKo8DWvzYuju3Al7L+m7UkGh8Gh6A6ALiD5MtQAjzkWvHQ9eVnT+h/zL1JL04zpd
         SYTUuYL2t6ASiF59Ir1F0RmsE55PZnhd44GHvRrF+7QjzrHrsQBaMkLyP64KRu+6YUo8
         TGyw==
X-Gm-Message-State: ACgBeo2NQlOWk3vZIZSi4ksOh05onaQuMFhZMc5T8cZOpxavIhzfeQSr
        YWN7VWJNhlRFllvQBCV+ORi5Ug==
X-Google-Smtp-Source: AA6agR7lE2pSrkUcP1I5mNHTVfwLSlcuX0/RK/cHwHELEIlPhh1ah5PsBhdugYuvVyleRs9OniBZng==
X-Received: by 2002:a05:600c:3492:b0:3a5:e1a0:24c9 with SMTP id a18-20020a05600c349200b003a5e1a024c9mr5265215wmq.177.1660551362921;
        Mon, 15 Aug 2022 01:16:02 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id i5-20020adff305000000b0021ef34124ebsm6602680wro.11.2022.08.15.01.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 01:16:02 -0700 (PDT)
Date:   Mon, 15 Aug 2022 11:16:00 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, abelvesa@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH V2 2/8] clk: imx93: guard imx93_clk_of_match with
 CONFIG_OF
Message-ID: <YvoAwL9qhmE03kgi@linaro.org>
References: <20220815013039.474970-1-peng.fan@oss.nxp.com>
 <20220815013039.474970-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815013039.474970-3-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-15 09:30:33, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> There is build warning when CONFIG_OF is not selected.
> >> drivers/clk/imx/clk-imx93.c:324:34: warning: 'imx93_clk_of_match'
> >> defined but not used [-Wunused-const-variable=]
>      324 | static const struct of_device_id imx93_clk_of_match[] = {
>          |                                  ^~~~~~~~~~~~~~~~~~
> 
> Use CONFIG_OF to guard imx93_clk_of_match to avoid build warning.
> 
> Fixes: 24defbe194b6 ("clk: imx: add i.MX93 clk")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-imx93.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
> index f5c9fa40491c..5099048b7916 100644
> --- a/drivers/clk/imx/clk-imx93.c
> +++ b/drivers/clk/imx/clk-imx93.c
> @@ -321,11 +321,13 @@ static int imx93_clocks_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +#ifdef CONFIG_OF

Hmm, I'm not sure if we should do this or rather should we make this driver
depend somehow on CONFIG_OF in Kconfig.

Looking at the other i.MX clock drivers, it would seem we need this for
all them too.

I fairly OK with this, but maybe Stephen suggests something different.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

>  static const struct of_device_id imx93_clk_of_match[] = {
>  	{ .compatible = "fsl,imx93-ccm" },
>  	{ /* Sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, imx93_clk_of_match);
> +#endif
>  
>  static struct platform_driver imx93_clk_driver = {
>  	.probe = imx93_clocks_probe,
> -- 
> 2.37.1
> 
