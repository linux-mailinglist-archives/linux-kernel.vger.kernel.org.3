Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7994FF0AD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbiDMHjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbiDMHjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:39:43 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B994D9E4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:37:21 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t4so1058769pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OvBmCpMD4WvNs2TV4Iwfm3Q6UCY8XLO8lhnqvUzlfmQ=;
        b=ezJpMnFtqu6SYjGyO6z0ZdpbRiSRqktyw1m72XPH9PlGKSl2LprXy8/1Pz8PJz+y7J
         55d+C6ovQycXEwAvRyl9Vxd/EsrGYh9T6fdGtMCYHMXNvGm+vWyY8mV6Yj2XaHvm7mb/
         zYvZMw4rGxX1orG19Y+xpbJNUXgio3ar/LU7G9Dg9QUBXyiAl4U6a+yutd0vkGhqhzxR
         0RFMnLfSle57raxIV9hsCpdJT0LQT6XwRz7Q19RsrZj5D1EftyyOA7VrWeVpXe/RKhGT
         q4FdIr+UbG7Irm/62lul+P3uYR1kcx5lQUgskC5PrBxhevRft7dzpXAgl8OVTTAzW1M3
         zZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OvBmCpMD4WvNs2TV4Iwfm3Q6UCY8XLO8lhnqvUzlfmQ=;
        b=v0BleKGUyziXzBXdPnPEWK90iTz7EYhgVpIbsX9WPgkeSM8T+OeMtizfCVpQDDeL/E
         VuILLxKKnx2f6oeGBM9S61+MVaMwuUQBNJtJnPli6DO+OLyzI95OUHWrCKvlTsGGjvhM
         p+UQqZKn5ra3SHt4pMSaobptRoIWuxiLjq6K19uaUaalnIIRYgdbDxhzinkJ5BApE+/9
         VRsjGympiVgpuZYJUByd6QFlVVvj0Vb9bjdbiUoZDh8M4qNZkfoVZMm4S6097RWksE5O
         /kO3ZXwc4Etmg4ErUqqllFofBxjskFLFYTTmCLUHEbLAfFzQN+7THzYv4JCKM6+GVoBa
         leFw==
X-Gm-Message-State: AOAM532l4JZa391q1s/NPGUsqcMEKZwnbfwg8JDv6VWxeC9fvM93kZG8
        uP8H5RWycKbZwLb34D23Ymdf
X-Google-Smtp-Source: ABdhPJy1Grt5MukdtrnClnqOOCFNj2cd7iE0NgSPKDA6mAkOQjYH6907VLEA5DWJ0xydgaibP94ngA==
X-Received: by 2002:a63:5710:0:b0:399:365e:5dde with SMTP id l16-20020a635710000000b00399365e5ddemr34937381pgb.192.1649835441312;
        Wed, 13 Apr 2022 00:37:21 -0700 (PDT)
Received: from thinkpad ([117.207.28.99])
        by smtp.gmail.com with ESMTPSA id pi2-20020a17090b1e4200b001c7b15928e0sm1977714pjb.23.2022.04.13.00.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 00:37:20 -0700 (PDT)
Date:   Wed, 13 Apr 2022 13:07:15 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Georgi Djakov <djakov@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Alex Elder <elder@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Subject: Re: [PATCH 2/2] interconnect: qcom: sdx55: Drop IP0 interconnects
Message-ID: <20220413073715.GD2015@thinkpad>
References: <20220412220033.1273607-1-swboyd@chromium.org>
 <20220412220033.1273607-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412220033.1273607-3-swboyd@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 03:00:33PM -0700, Stephen Boyd wrote:
> Similar to the sc7180 commit, let's drop the IP0 interconnects here
> because the IP0 resource is also used in the clk-rpmh driver on sdx55.
> It's bad to have the clk framework and interconnect framework control
> the same RPMh resource without any coordination. The rpmh driver in the
> kernel doesn't aggregate resources between clients either, so leaving
> control to clk-rpmh avoids any issues with unused interconnects turning
> off IP0 behind the back of the clk framework.
> 
> Cc: Alex Elder <elder@linaro.org>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Taniya Das <quic_tdas@quicinc.com>
> Cc: Mike Tipton <quic_mdtipton@quicinc.com>
> Fixes: b2150cab9a97 ("clk: qcom: rpmh: add support for SDX55 rpmh IPA clock")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/interconnect/qcom/sdx55.c | 21 ---------------------
>  1 file changed, 21 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/sdx55.c b/drivers/interconnect/qcom/sdx55.c
> index 03d604f84cc5..e3ac25a997b7 100644
> --- a/drivers/interconnect/qcom/sdx55.c
> +++ b/drivers/interconnect/qcom/sdx55.c
> @@ -18,7 +18,6 @@
>  #include "icc-rpmh.h"
>  #include "sdx55.h"
>  
> -DEFINE_QNODE(ipa_core_master, SDX55_MASTER_IPA_CORE, 1, 8, SDX55_SLAVE_IPA_CORE);
>  DEFINE_QNODE(llcc_mc, SDX55_MASTER_LLCC, 4, 4, SDX55_SLAVE_EBI_CH0);
>  DEFINE_QNODE(acm_tcu, SDX55_MASTER_TCU_0, 1, 8, SDX55_SLAVE_LLCC, SDX55_SLAVE_MEM_NOC_SNOC, SDX55_SLAVE_MEM_NOC_PCIE_SNOC);
>  DEFINE_QNODE(qnm_snoc_gc, SDX55_MASTER_SNOC_GC_MEM_NOC, 1, 8, SDX55_SLAVE_LLCC);
> @@ -40,7 +39,6 @@ DEFINE_QNODE(xm_pcie, SDX55_MASTER_PCIE, 1, 8, SDX55_SLAVE_ANOC_SNOC);
>  DEFINE_QNODE(xm_qdss_etr, SDX55_MASTER_QDSS_ETR, 1, 8, SDX55_SLAVE_SNOC_CFG, SDX55_SLAVE_EMAC_CFG, SDX55_SLAVE_USB3, SDX55_SLAVE_AOSS, SDX55_SLAVE_SPMI_FETCHER, SDX55_SLAVE_QDSS_CFG, SDX55_SLAVE_PDM, SDX55_SLAVE_SNOC_MEM_NOC_GC, SDX55_SLAVE_TCSR, SDX55_SLAVE_CNOC_DDRSS, SDX55_SLAVE_SPMI_VGI_COEX, SDX55_SLAVE_QPIC, SDX55_SLAVE_OCIMEM, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_USB3_PHY_CFG, SDX55_SLAVE_AOP, SDX55_SLAVE_BLSP_1, SDX55_SLAVE_SDCC_1, SDX55_SLAVE_CNOC_MSS, SDX55_SLAVE_PCIE_PARF, SDX55_SLAVE_ECC_CFG, SDX55_SLAVE_AUDIO, SDX55_SLAVE_AOSS, SDX55_SLAVE_PRNG, SDX55_SLAVE_CRYPTO_0_CFG, SDX55_SLAVE_TCU, SDX55_SLAVE_CLK_CTL, SDX55_SLAVE_IMEM_CFG);
>  DEFINE_QNODE(xm_sdc1, SDX55_MASTER_SDCC_1, 1, 8, SDX55_SLAVE_AOSS, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_ANOC_SNOC, SDX55_SLAVE_AOP, SDX55_SLAVE_AUDIO);
>  DEFINE_QNODE(xm_usb3, SDX55_MASTER_USB3, 1, 8, SDX55_SLAVE_ANOC_SNOC);
> -DEFINE_QNODE(ipa_core_slave, SDX55_SLAVE_IPA_CORE, 1, 8);
>  DEFINE_QNODE(ebi, SDX55_SLAVE_EBI_CH0, 1, 4);
>  DEFINE_QNODE(qns_llcc, SDX55_SLAVE_LLCC, 1, 16, SDX55_SLAVE_EBI_CH0);
>  DEFINE_QNODE(qns_memnoc_snoc, SDX55_SLAVE_MEM_NOC_SNOC, 1, 8, SDX55_MASTER_MEM_NOC_SNOC);
> @@ -82,7 +80,6 @@ DEFINE_QNODE(xs_sys_tcu_cfg, SDX55_SLAVE_TCU, 1, 8);
>  DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
>  DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
>  DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
> -DEFINE_QBCM(bcm_ip0, "IP0", false, &ipa_core_slave);
>  DEFINE_QBCM(bcm_pn0, "PN0", false, &qhm_snoc_cfg);
>  DEFINE_QBCM(bcm_sh3, "SH3", false, &xm_apps_rdwr);
>  DEFINE_QBCM(bcm_sh4, "SH4", false, &qns_memnoc_snoc, &qns_sys_pcie);
> @@ -219,22 +216,6 @@ static const struct qcom_icc_desc sdx55_system_noc = {
>  	.num_bcms = ARRAY_SIZE(system_noc_bcms),
>  };
>  
> -static struct qcom_icc_bcm *ipa_virt_bcms[] = {
> -	&bcm_ip0,
> -};
> -
> -static struct qcom_icc_node *ipa_virt_nodes[] = {
> -	[MASTER_IPA_CORE] = &ipa_core_master,
> -	[SLAVE_IPA_CORE] = &ipa_core_slave,
> -};
> -
> -static const struct qcom_icc_desc sdx55_ipa_virt = {
> -	.nodes = ipa_virt_nodes,
> -	.num_nodes = ARRAY_SIZE(ipa_virt_nodes),
> -	.bcms = ipa_virt_bcms,
> -	.num_bcms = ARRAY_SIZE(ipa_virt_bcms),
> -};
> -
>  static const struct of_device_id qnoc_of_match[] = {
>  	{ .compatible = "qcom,sdx55-mc-virt",
>  	  .data = &sdx55_mc_virt},
> @@ -242,8 +223,6 @@ static const struct of_device_id qnoc_of_match[] = {
>  	  .data = &sdx55_mem_noc},
>  	{ .compatible = "qcom,sdx55-system-noc",
>  	  .data = &sdx55_system_noc},
> -	{ .compatible = "qcom,sdx55-ipa-virt",
> -	  .data = &sdx55_ipa_virt},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, qnoc_of_match);
> -- 
> https://chromeos.dev
> 
