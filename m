Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B4B4FF0A0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbiDMHhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbiDMHh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:37:27 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A097D4D9E8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:35:04 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 32so1043276pgl.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4shEO0FDjWAPEb/iOkbhrTf4wcohhpVSh+KPI0icLZI=;
        b=qets2QwMPoIS07bG1f+KyzSxy6S8KfID+zTuDtEKft9hUvDP7QZj5L+WzEREoAmiY/
         XOrB4o04xL+0RYSOVEMDw3reHRpqsa51k5T4ihGVeqQBAk9Ho2mspk66Bl+l56Dr6PnA
         OXMaSzqgFA6Cu3ryvS2nNYt+BMVcjYDJCeoyictMJ5uwYo8Q+jDXBNZtA56w09lyCRZe
         YKuZbPQDp/Lmcn2qX0ZVrncFMbVbfr15nMmbXBHqjWfTdFcFYfj5OcOArO5W40hVsUn2
         a51Mapulb8/S926Wh9qcxCXmC7IAcSSPS7a7UXSjHa0/8KiqsCCwgoA+O7nm6GKvATiM
         mKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4shEO0FDjWAPEb/iOkbhrTf4wcohhpVSh+KPI0icLZI=;
        b=w/tUYn0nZmqPRiu6Sds2PA7vdvvNbK/3mCvYwYP7clC4oZ8VNWDqvCGvhU9PKKvJ67
         Mv8t8FsFjkYNjNdduLrKSAKyouxjWO+PcItzpcOXSWp0Z2ajkU9c0i+SMMXWnyGStRwQ
         74hBXatzzzAf1Eqg6b9N82fEdpH/xMCpR86pibziplQplMj250otNvpzkWstDpp3b3UY
         dyIuvJ/7q63Ce4WczXaNDyEnV3fQ+PBLy6y1X34NPBzb1ZtNeSKqYg3hOTFV7s8eCRsx
         Haw7fEEWUxxo0ooKezhCiEbE6Z91+Mt/ckih9i1qw/CZwiD7PIFa8zNaVBIfO9NhsAy+
         LoNw==
X-Gm-Message-State: AOAM533WCddfOLvtqFoG/2yBMD1e/yo3+TcYa2/CfujYmeMCy8KtkfPr
        rRt7QsFx/yWJ3H0GFDubLPJq
X-Google-Smtp-Source: ABdhPJzMxUXE89aUhRoeF6JFh0xgIGr9S8og3SCLfG1L88EFRg2hK4A2qSzGupVw4T6UTu0MgphGLw==
X-Received: by 2002:a63:780f:0:b0:386:5d6f:2153 with SMTP id t15-20020a63780f000000b003865d6f2153mr33053657pgc.555.1649835303345;
        Wed, 13 Apr 2022 00:35:03 -0700 (PDT)
Received: from thinkpad ([117.207.28.99])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090a114800b001cb95a92bd7sm1816639pje.13.2022.04.13.00.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 00:35:02 -0700 (PDT)
Date:   Wed, 13 Apr 2022 13:04:56 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] phy: qcom-qmp: Add support for SDX65 QMP PHY
Message-ID: <20220413073456.GC2015@thinkpad>
References: <1649740652-17515-1-git-send-email-quic_rohiagar@quicinc.com>
 <1649740652-17515-3-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649740652-17515-3-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 10:47:32AM +0530, Rohit Agarwal wrote:
> Add support for USB3 QMP PHY found in SDX65 platform. SDX65 uses
> version 5.0.0 of the QMP PHY IP.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

I don't have access to SDX65 downstream devicetree source but overall it looks
good to me.

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 76 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 8ea87c6..58506b8 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -2535,6 +2535,50 @@ static const struct qmp_phy_init_tbl sdx55_qmp_pcie_pcs_misc_tbl[] = {
>  	QMP_PHY_INIT_CFG(QPHY_V4_20_PCS_LANE1_INSIG_MX_CTRL2, 0x00),
>  };
>  
> +static const struct qmp_phy_init_tbl sdx65_usb3_uniphy_tx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_1, 0xa5),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_2, 0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_3, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_4, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PI_QEC_CTRL, 0x21),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_TX, 0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_RX, 0x0b),
> +};
> +
> +static const struct qmp_phy_init_tbl sdx65_usb3_uniphy_rx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH4, 0xdb),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH3, 0xbd),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH2, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH, 0x7f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_LOW, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH4, 0xa9),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH3, 0x7b),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH2, 0xe4),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH, 0x24),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_LOW, 0x64),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_PI_CONTROLS, 0x99),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_THRESH1, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_THRESH2, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_GAIN1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_GAIN2, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FO_GAIN, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_VGA_CAL_CNTRL1, 0x54),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_VGA_CAL_CNTRL2, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x47),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_CNTRL, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SO_GAIN, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_GM_CAL, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_ENABLES, 0x00),
> +};
> +
>  static const struct qmp_phy_init_tbl sm8350_ufsphy_serdes_tbl[] = {
>  	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0xd9),
>  	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_SEL, 0x11),
> @@ -4217,6 +4261,35 @@ static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
>  	.pwrdn_delay_max	= 1005,		/* us */
>  };
>  
> +static const struct qmp_phy_cfg sdx65_usb3_uniphy_cfg = {
> +	.type			= PHY_TYPE_USB3,
> +	.nlanes			= 1,
> +
> +	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_serdes_tbl),
> +	.tx_tbl			= sdx65_usb3_uniphy_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(sdx65_usb3_uniphy_tx_tbl),
> +	.rx_tbl			= sdx65_usb3_uniphy_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(sdx65_usb3_uniphy_rx_tbl),
> +	.pcs_tbl		= sm8350_usb3_uniphy_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(sm8350_usb3_uniphy_pcs_tbl),
> +	.clk_list		= qmp_v4_sdx55_usbphy_clk_l,
> +	.num_clks		= ARRAY_SIZE(qmp_v4_sdx55_usbphy_clk_l),
> +	.reset_list		= msm8996_usb3phy_reset_l,
> +	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= sm8350_usb3_uniphy_regs_layout,
> +
> +	.start_ctrl		= SERDES_START | PCS_START,
> +	.pwrdn_ctrl		= SW_PWRDN,
> +	.phy_status		= PHYSTATUS,
> +
> +	.has_pwrdn_delay	= true,
> +	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
> +	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
> +};
> +
>  static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
>  	.type			= PHY_TYPE_UFS,
>  	.nlanes			= 2,
> @@ -6044,6 +6117,9 @@ static const struct of_device_id qcom_qmp_phy_of_match_table[] = {
>  		.compatible = "qcom,sdx55-qmp-usb3-uni-phy",
>  		.data = &sdx55_usb3_uniphy_cfg,
>  	}, {
> +		.compatible = "qcom,sdx65-qmp-usb3-uni-phy",
> +		.data = &sdx65_usb3_uniphy_cfg,
> +	}, {
>  		.compatible = "qcom,sm8350-qmp-usb3-phy",
>  		.data = &sm8350_usb3phy_cfg,
>  	}, {
> -- 
> 2.7.4
> 
