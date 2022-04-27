Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DA6511307
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344407AbiD0H6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350586AbiD0H6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:58:35 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E813387B8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:55:24 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p6so808395pjm.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fNHux1IBm/5HLefyE9ps8fak1p3KFESTuY/jt3ka9yU=;
        b=tSN2lkK/7BcMnlnxCd588MGTAMk8P9VpuIntdx/jrVnwngmDS5zBggXknGWi5gYqTJ
         G687yRsYUeUk7zhyYGgm22RBDjK129UdzPVt0Mf7GW6ACQAcXbAeSTc1D1WsHTMvjmtH
         +/yCG9IBKWEqT5xyk+YTp34azvWamK1lLUavDSfergvN0KQDZVTUHDQgJFfQsjA/Eziu
         K5BG89W+0uj6F+n7sIqpRLb2t07tZH3cO19Oe/QZUxuo8dFajUuxN5I37n1Nlvuk/Qrp
         oS0ixZUty499qGio0DVX0/5km4fMf9mP+eY6bgDXCqnWUNEIExm2C1xbJXbhS97WhxSz
         ZBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fNHux1IBm/5HLefyE9ps8fak1p3KFESTuY/jt3ka9yU=;
        b=XM6D12BW9Sn6CDTKjfUY1B6dMrq0o0LPonng5itrb0CtAceI+pDddPa1cqYewgrb2H
         6sujf5fALD3MWWliTwXwpMfZ4MBdA/eF820CaH44Y1szMtWEsduNlJxnBK7E36bvleLE
         3GOdVyRxt6tp+EnU1FrHvHFcSovfJDHwqI+gYoi80BhdzyAUok+0Gz0XGcnmA8vn6fov
         ClVlyIZEf/ZtqB39J1Q33yx3duxT+PUjlAEsiFRVhI+So4q44iv6VKGELiU4dCIhSZfX
         aotqKfBoeRlzUV2VKPRmvdJlhfTVpThFD7MldSnPGnxXKmo6z/z9ngNbf42kDDTau2+Y
         i4Sg==
X-Gm-Message-State: AOAM530blxQOYz9dP4dnUlUYcXkh9PwVrsASLXKGgQaejPCm50r2IWxP
        9LLQig263uFL90Dw2xUNS/FN
X-Google-Smtp-Source: ABdhPJy+dOT8tPKckt8Xy6LcaOJl1PSgWgXOrviXgmnw02makXUuKn/BDlPXt0wCkZmeJqEWPFRriw==
X-Received: by 2002:a17:90a:7acb:b0:1d9:85a5:e1e3 with SMTP id b11-20020a17090a7acb00b001d985a5e1e3mr13841507pjl.172.1651046123549;
        Wed, 27 Apr 2022 00:55:23 -0700 (PDT)
Received: from thinkpad ([117.207.26.174])
        by smtp.gmail.com with ESMTPSA id u3-20020a626003000000b00505a38fc90bsm18447482pfb.173.2022.04.27.00.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 00:55:23 -0700 (PDT)
Date:   Wed, 27 Apr 2022 13:25:16 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: qcom: Fix unbalanced PHY init on probe errors
Message-ID: <20220427075516.GB2182@thinkpad>
References: <20220401133854.10421-1-johan+linaro@kernel.org>
 <20220401133854.10421-3-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401133854.10421-3-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 03:38:54PM +0200, Johan Hovold wrote:
> Make sure to undo the PHY initialisation (e.g. balance runtime PM) in
> case host initialisation fails during probe.
> 
> Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")
> Cc: stable@vger.kernel.org      # 4.5
> Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 0b0bd71f1bd2..df47986bda29 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1624,11 +1624,13 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	ret = dw_pcie_host_init(pp);
>  	if (ret) {
>  		dev_err(dev, "cannot initialize host\n");
> -		goto err_pm_runtime_put;
> +		goto err_phy_exit;
>  	}
>  
>  	return 0;
>  
> +err_phy_exit:
> +	phy_exit(pcie->phy);
>  err_pm_runtime_put:
>  	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);
> -- 
> 2.35.1
> 
