Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD895072FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354655AbiDSQfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354647AbiDSQfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:35:20 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D5128E24
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:32:37 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-e2fa360f6dso18088116fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=odPjXDn1qUyXBL474BmnX4+5acHAQntCdaPerLBY6uc=;
        b=OY3C4/FTf8IG5kfLY+hzIhzZZnzQvxaXEcEQzv9ujIhtG+YtUcNd4XunaL/UDSsy0r
         OLYTX0Nlp1+uoBdApb7N+Enc8DGSl4Ym2pE5E6YnDjWbRbS2UzQcn6nAhla11cWUgDEH
         Rg4tG79eX97PpZ+053iOo/2I5Bx9dEGbtetFu+7XdIaPpdHoG5qE6ZuIQjigTDtmsc4D
         6OlPiHwDHxwGb+r1QF084U41prxQy0Vp0d28WIB7ZFBPMqvXZbrEqprkPpCc/uqMDMgs
         OjR9u6UMqs5sB1CPul6qKT5bDXVa5nkQYgkdm3xZPsRuSHublhnDglAFnS1sB1rh4knJ
         qKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=odPjXDn1qUyXBL474BmnX4+5acHAQntCdaPerLBY6uc=;
        b=xGL+2hT/6Hxwt4xmGrRYJU6XbfB10WgR8XS2GfqQwv4EUZyKKASSdaflpDW873/5OK
         NyNRB2Gs+XU6RzlNrlAIo8CWYSGeulLmB+hQa1uaZhIlB6EJeSfMVYr+grseLUutFvvv
         WoEwHpD3zhwQQZujxH1jzfs2cAyF6I9lR0lZDpF+340FdofvvWd+OlVLQsMv9I1TKxef
         r7+QtxUk4blFxeQh3lqnu+mqlR3li/0ZYua+Wcgciyp5zlphza8mN0RtRD0NXDQl1nqt
         UWmTxvj9XhZplTluo/DMGPkxLx1j7q3NtYlAAi7k5Qsm44EvQNK+kqBpO4aJv4uevSVb
         X1UQ==
X-Gm-Message-State: AOAM533TEMED4gtJjvnZTKnM+VoPsVfBL/iUGSXSyZdfm6gbqRbOZ3d5
        Exq9rJ12q80mVbNW5ckOmSfI4A==
X-Google-Smtp-Source: ABdhPJyyaGnDnb8N6WNJC2Mxus4qrGseodJd3wTFR7i//oXY99DebeILx8V0O/GDzfmehQGpt7NnWA==
X-Received: by 2002:a05:6870:218e:b0:e6:1aae:c91d with SMTP id l14-20020a056870218e00b000e61aaec91dmr1967451oae.267.1650385956714;
        Tue, 19 Apr 2022 09:32:36 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id z10-20020a056870514a00b000e5aaea5448sm3533688oak.36.2022.04.19.09.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:32:35 -0700 (PDT)
Date:   Tue, 19 Apr 2022 09:34:41 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Remove ddrss_sf_tbu clock from sc8180x
Message-ID: <Yl7kofUVpMYirIjg@ripper>
References: <20220331013415.592748-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331013415.592748-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30 Mar 18:34 PDT 2022, Bjorn Andersson wrote:

> The Qualcomm SC8180X platform was piggy backing on the SM8250
> qcom_pcie_cfg, but the platform doesn't have the ddrss_sf_tbu clock, so
> it now fails to probe due to the missing clock.
> 
> Give SC8180X its own qcom_pcie_cfg, without the ddrss_sf_tbu flag set.
> 
> Fixes: 0614f98bbb9f ("PCI: qcom: Add ddrss_sf_tbu flag")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Ping. Would be nice to have this regression fix picked up for v5.18...

Thanks,
Bjorn

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6ab90891801d..816028c0f6ed 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1550,6 +1550,11 @@ static const struct qcom_pcie_cfg sc7280_cfg = {
>  	.pipe_clk_need_muxing = true,
>  };
>  
> +static const struct qcom_pcie_cfg sc8180x_cfg = {
> +	.ops = &ops_1_9_0,
> +	.has_tbu_clk = true,
> +};
> +
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.link_up = qcom_pcie_link_up,
>  	.start_link = qcom_pcie_start_link,
> @@ -1656,7 +1661,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-qcs404", .data = &ipq4019_cfg },
>  	{ .compatible = "qcom,pcie-sdm845", .data = &sdm845_cfg },
>  	{ .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
> -	{ .compatible = "qcom,pcie-sc8180x", .data = &sm8250_cfg },
> +	{ .compatible = "qcom,pcie-sc8180x", .data = &sc8180x_cfg },
>  	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &sm8450_pcie0_cfg },
>  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &sm8450_pcie1_cfg },
>  	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
> -- 
> 2.35.1
> 
