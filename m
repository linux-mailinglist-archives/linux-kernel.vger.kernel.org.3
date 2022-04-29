Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CB151497C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359338AbiD2Mjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiD2Mjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:39:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CE0C4DF53
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651235777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tmPALbAB2aFHap4uYCwyzn1Tmk9I3K+tWth9ftQrgaY=;
        b=EY3M1kSm4wT8l9wufLyrDwpugLXaS+8TFkeYQGMadx5wQlAobt9kl4yRDwhZtUGVT5xoqQ
        StXpUWrwILt9zjv79Soyv54DqK1oITYWHwotNYihZfPRlZzIoUhUEIZGqoNLR7JQBYNMuz
        OLxHNl8G54VG8/yd740H//3wsbn4uTU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-127-MgTbb_XDPoeB0lwdPMMXzA-1; Fri, 29 Apr 2022 08:36:15 -0400
X-MC-Unique: MgTbb_XDPoeB0lwdPMMXzA-1
Received: by mail-qk1-f199.google.com with SMTP id c8-20020a05620a268800b0069c0f1b3206so5145472qkp.18
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tmPALbAB2aFHap4uYCwyzn1Tmk9I3K+tWth9ftQrgaY=;
        b=KLxKB/YW0sCGhyn1r0lynWsa0vJg08nPQKE3ZRcATtrQR/IO9qC2/DCYEunvcfZAL6
         hPD6sPO2Vp1WKLX6dLUActEBjagEv13Fkx8KzeDhFZDWZ9XwqQ72vjLe2+PP616KHHq/
         2rzu9Q7LSi27nIAZo1JmHz40tRwASkUPXKWhshMTrRkcMtHAhfCJFHQLtqwYsp/3M0Ak
         ldvwAtkjWBZSKDdF2BDNnY+OTnNQ8oo5QpnLAacAviPE/jCFW1mnUJ8XQSnahm/Jo808
         AiA2KY7EsD8PrHaaWcw1mtC+Gik+St7AmecYPAiNMl1KgVXnK7WXtxmX8/oOCkow70c5
         t+rg==
X-Gm-Message-State: AOAM532yjrI+gHGSsKmclu3ptd0NvGzwI7Pr6J4EoOAe/5rYnl2qiJ10
        T0WwJhBKeg+ZCMbQj91QpjWZhmINw8frg/OEYyfWxwkjaBMMnStm7iLxoqHdldyiXjV528s2xDl
        6rI2b76PRrsomMamdA1FSLI9P
X-Received: by 2002:ae9:c30d:0:b0:69e:bd20:40cc with SMTP id n13-20020ae9c30d000000b0069ebd2040ccmr22855199qkg.10.1651235775352;
        Fri, 29 Apr 2022 05:36:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzR/e2gvH8C2pX3ZYsnNabO4ZISvCIsY0TiWhX1g+iYQGQTh69cKbIxck8xvTa6d132FN2MyQ==
X-Received: by 2002:ae9:c30d:0:b0:69e:bd20:40cc with SMTP id n13-20020ae9c30d000000b0069ebd2040ccmr22855187qkg.10.1651235775101;
        Fri, 29 Apr 2022 05:36:15 -0700 (PDT)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id h75-20020a379e4e000000b0069db8210ffbsm1383072qke.12.2022.04.29.05.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:36:14 -0700 (PDT)
Date:   Fri, 29 Apr 2022 07:36:12 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, mani@kernel.org,
        lorenzo.pieralisi@arm.com
Subject: Re: [PATCH] PCI: qcom-ep: check return value after calling
 platform_get_resource_byname()
Message-ID: <20220429123612.sugqipgfmyy2xc6s@halaneylaptop>
References: <20220429080740.1294797-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429080740.1294797-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 04:07:40PM +0800, Yang Yingliang wrote:
> If platform_get_resource_byname() fails, 'mmio_res' will be set to null pointer,
> it will cause null-ptr-deref when it used in qcom_pcie_perst_deassert(), so we
> need check the return value.
> 
> Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 6ce8eddf3a37..becb0c2ff870 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -416,6 +416,10 @@ static int qcom_pcie_ep_get_io_resources(struct platform_device *pdev,
>  
>  	pcie_ep->mmio_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>  							 "mmio");
> +	if (!pcie_ep->mmio_res) {
> +		dev_err(dev, "Failed to get mmio resource\n");
> +		return -EINVAL;
> +	}
>  
>  	syscon = of_parse_phandle(dev->of_node, "qcom,perst-regs", 0);
>  	if (!syscon) {
> -- 
> 2.25.1
> 

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

