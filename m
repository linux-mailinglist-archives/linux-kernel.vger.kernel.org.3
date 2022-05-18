Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8513252C662
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiERWht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiERWhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:37:46 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3773E7DE2E
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:37:43 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id u15so3412235pfi.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aFRU12DTpolAuGFmkxAhHBmEQsELfp0+L3UbPiDUDic=;
        b=fIA1tDQePC+WwhmrT2D2/WLcjuLa1rmtZQEy6T74alcSgoC+3JBHVOI7GA0bzW2bwO
         0sFSJJ6eC08nG9ML6l+hhrEJD5ka6gOlolbvaO0Os8KZASDLodw296ToE9sFLEZ4JSRe
         tv5bdKYjSPUEhdUYu1eGDgAh/PbnqTvjopYkIuXp9bJ/iRp9hLFuQD7jO+o9ZcIMN+DZ
         wNH58WZli0Sixu/mgV8sfjJfE+GaV27Ely440N3JmIemb9N9LAgH9wQqIWDBrnODD02+
         9Jjq0GVNbu3YKjIDc3D5JDyIEB2SNhVpQoDAEU7OsL/zBnJMNqpN83m+KKR5BKUH7tnP
         jNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aFRU12DTpolAuGFmkxAhHBmEQsELfp0+L3UbPiDUDic=;
        b=ndM4XXXVXV8nAUKb/G/ECTTfrvOK8r0i8/Pvwr+ZFcue8ILTw4X26eWHFL7pR9HpkD
         FYwUpYOb1lNLOoitAnBtAJt2Dzmf8wtUpCa9TAExJuXMGCmWe1fiph9h0az9+1te1/ag
         9LA4PQZMVzo2ZUta51iTVPk8wehsID7jnIGqG68t2XOHVKIodtVGPryM2KB6eOfmjrwn
         bXB7zLZWDapBgme9L0IAtSPwEUM7Pan8crtEolep9K5u340Ik7q1ihc8udetDGc6fOb8
         XhDoWfLm4oW75Cnx73RTB301MgyCGd4Arfs8P+/dWgKNBrnSEPUh4K9J3csc+gp2Oh/1
         lFxw==
X-Gm-Message-State: AOAM533FzBldKBzNh0+VKyhAAwPQO6zBA77Sl0q5y94vuH9oC2ZS9CY5
        fxe5rroQHNSa7hiQFLGfT0kCYg==
X-Google-Smtp-Source: ABdhPJx62VoZDlNYuHhcZzwHSLIChJL/iVEygcBtpNRtatDiQ1p6HcxgC7GBcLWLbgO8k5Q67US7vw==
X-Received: by 2002:a63:5510:0:b0:3db:8bb3:6059 with SMTP id j16-20020a635510000000b003db8bb36059mr1349343pgb.328.1652913462627;
        Wed, 18 May 2022 15:37:42 -0700 (PDT)
Received: from yoga (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id i65-20020a62c144000000b0050dc762816bsm2513004pfg.69.2022.05.18.15.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 15:37:41 -0700 (PDT)
Date:   Wed, 18 May 2022 15:37:34 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] phy: qcom-qmp: Add USB3 5NM QMP UNI registers
Message-ID: <YoV1Lv02q2jB1ptd@yoga>
References: <20220513225348.1671639-1-bjorn.andersson@linaro.org>
 <20220513225348.1671639-3-bjorn.andersson@linaro.org>
 <YoN5k0tNXDhwS9rC@matsya>
 <YoN6lLF6ffu4Jhgo@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoN6lLF6ffu4Jhgo@matsya>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17 May 03:36 PDT 2022, Vinod Koul wrote:

> On 17-05-22, 16:01, Vinod Koul wrote:
> > On 13-05-22, 15:53, Bjorn Andersson wrote:
> > > Add all registers defines from qcom,usb3-5nm-qmp-uni.h of the msm-5.4
> > > kernel. Offsets are adjusted to be relative to each sub-block, as we
> > > describe the individual pieces in the upstream kernel and "5NM" are
> > > injected in the defines to not collide with existing constants.
> > > 
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > >  .../phy/qualcomm/phy-qcom-usb3-5nm-qmp-uni.h  | 617 ++++++++++++++++++
> > >  1 file changed, 617 insertions(+)
> > >  create mode 100644 drivers/phy/qualcomm/phy-qcom-usb3-5nm-qmp-uni.h
> > > 
> > > diff --git a/drivers/phy/qualcomm/phy-qcom-usb3-5nm-qmp-uni.h b/drivers/phy/qualcomm/phy-qcom-usb3-5nm-qmp-uni.h
> > > new file mode 100644
> > > index 000000000000..b912e50825f9
> > > --- /dev/null
> > > +++ b/drivers/phy/qualcomm/phy-qcom-usb3-5nm-qmp-uni.h
> > > @@ -0,0 +1,617 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/*
> > > + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> > 
> > should this be 2022 or add Linaro one for 2022..?
> > 
> > > + */
> > > +
> > > +#ifndef PHY_QCOM_USB3_5NM_QMP_UNI_H_
> > > +#define PHY_QCOM_USB3_5NM_QMP_UNI_H_
> > > +
> > > +/* Module: USB3_UNI_PHY_QSERDES_COM_QSERDES_COM_PCIE_USB3_UNI_QMP_PLL */
> > > +#define USB3_5NM_UNI_QSERDES_COM_ATB_SEL1			0x000
> > > +#define USB3_5NM_UNI_QSERDES_COM_ATB_SEL2			0x004
> > > +#define USB3_5NM_UNI_QSERDES_COM_FREQ_UPDATE			0x008
> > > +#define USB3_5NM_UNI_QSERDES_COM_BG_TIMER			0x00c
> > > +#define USB3_5NM_UNI_QSERDES_COM_SSC_EN_CENTER			0x010
> > > +#define USB3_5NM_UNI_QSERDES_COM_SSC_ADJ_PER1			0x014
> > > +#define USB3_5NM_UNI_QSERDES_COM_SSC_ADJ_PER2			0x018
> > > +#define USB3_5NM_UNI_QSERDES_COM_SSC_PER1			0x01c
> > > +#define USB3_5NM_UNI_QSERDES_COM_SSC_PER2			0x020
> > > +#define USB3_5NM_UNI_QSERDES_COM_SSC_STEP_SIZE1_MODE0		0x024
> > > +#define USB3_5NM_UNI_QSERDES_COM_SSC_STEP_SIZE2_MODE0		0x028
> 
> this seems to be QSERDES_V3_COM_* uptill now...
> 

Yes, some of these will be the same across several different versions of
QMP phys.

It takes me quite a bit of time trying to puzzle in missing entries in
the right place in the existing sets of defines. So the proposal here is
to use the generated files that exists for many of the QMP variants
downstream.

An example of this is that I got the USB combo phy for sc8280xp wrong,
because I couldn't copy paste the initialization sequence from the
downstream dts and we have mangled the names in the header file. So
either we just use the generated downstream file, or I will have to
spend a bunch of time trying to figure out which register(s) I got
wrong.

> > > +#define USB3_5NM_UNI_QSERDES_COM_SSC_STEP_SIZE3_MODE0		0x02c
> > > +#define USB3_5NM_UNI_QSERDES_COM_SSC_STEP_SIZE1_MODE1		0x030
> > > +#define USB3_5NM_UNI_QSERDES_COM_SSC_STEP_SIZE2_MODE1		0x034
> > > +#define USB3_5NM_UNI_QSERDES_COM_SSC_STEP_SIZE3_MODE1		0x038
> > > +#define USB3_5NM_UNI_QSERDES_COM_POST_DIV			0x03c
> > > +#define USB3_5NM_UNI_QSERDES_COM_POST_DIV_MUX			0x040
> > > +#define USB3_5NM_UNI_QSERDES_COM_BIAS_EN_CLKBUFLR_EN		0x044
> > > +#define USB3_5NM_UNI_QSERDES_COM_CLK_ENABLE1			0x048
> > > +#define USB3_5NM_UNI_QSERDES_COM_SYS_CLK_CTRL			0x04c
> > > +#define USB3_5NM_UNI_QSERDES_COM_SYSCLK_BUF_ENABLE		0x050
> > > +#define USB3_5NM_UNI_QSERDES_COM_PLL_EN				0x054
> > > +#define USB3_5NM_UNI_QSERDES_COM_PLL_IVCO			0x058
> > > +#define USB3_5NM_UNI_QSERDES_COM_CMN_IETRIM			0x05c
> > > +#define USB3_5NM_UNI_QSERDES_COM_CMN_IPTRIM			0x060
> > > +#define USB3_5NM_UNI_QSERDES_COM_EP_CLOCK_DETECT_CTRL		0x064
> > > +#define USB3_5NM_UNI_QSERDES_COM_SYSCLK_DET_COMP_STATUS		0x068
> > > +#define USB3_5NM_UNI_QSERDES_COM_CLK_EP_DIV_MODE0		0x06c
> > > +#define USB3_5NM_UNI_QSERDES_COM_CLK_EP_DIV_MODE1		0x070
> > > +#define USB3_5NM_UNI_QSERDES_COM_CP_CTRL_MODE0			0x074
> > > +#define USB3_5NM_UNI_QSERDES_COM_CP_CTRL_MODE1			0x078
> > > +#define USB3_5NM_UNI_QSERDES_COM_PLL_RCTRL_MODE0		0x07c
> > > +#define USB3_5NM_UNI_QSERDES_COM_PLL_RCTRL_MODE1		0x080
> > > +#define USB3_5NM_UNI_QSERDES_COM_PLL_CCTRL_MODE0		0x084
> > > +#define USB3_5NM_UNI_QSERDES_COM_PLL_CCTRL_MODE1		0x088
> > > +#define USB3_5NM_UNI_QSERDES_COM_PLL_CNTRL			0x08c
> > > +#define USB3_5NM_UNI_QSERDES_COM_BIAS_EN_CTRL_BY_PSM		0x090
> > > +#define USB3_5NM_UNI_QSERDES_COM_SYSCLK_EN_SEL			0x094
> > > +#define USB3_5NM_UNI_QSERDES_COM_CML_SYSCLK_SEL			0x098
> > > +#define USB3_5NM_UNI_QSERDES_COM_RESETSM_CNTRL			0x09c
> > > +#define USB3_5NM_UNI_QSERDES_COM_RESETSM_CNTRL2			0x0a0
> > > +#define USB3_5NM_UNI_QSERDES_COM_LOCK_CMP_EN			0x0a4
> > > +#define USB3_5NM_UNI_QSERDES_COM_LOCK_CMP_CFG			0x0a8
> > > +#define USB3_5NM_UNI_QSERDES_COM_LOCK_CMP1_MODE0		0x0ac
> > > +#define USB3_5NM_UNI_QSERDES_COM_LOCK_CMP2_MODE0		0x0b0
> > > +#define USB3_5NM_UNI_QSERDES_COM_LOCK_CMP1_MODE1		0x0b4
> > > +#define USB3_5NM_UNI_QSERDES_COM_LOCK_CMP2_MODE1		0x0b8
> > > +#define USB3_5NM_UNI_QSERDES_COM_DEC_START_MODE0		0x0bc
> > > +#define USB3_5NM_UNI_QSERDES_COM_DEC_START_MSB_MODE0		0x0c0
> > > +#define USB3_5NM_UNI_QSERDES_COM_DEC_START_MODE1		0x0c4
> > > +#define USB3_5NM_UNI_QSERDES_COM_DEC_START_MSB_MODE1		0x0c8
> > > +#define USB3_5NM_UNI_QSERDES_COM_DIV_FRAC_START1_MODE0		0x0cc
> > > +#define USB3_5NM_UNI_QSERDES_COM_DIV_FRAC_START2_MODE0		0x0d0
> > > +#define USB3_5NM_UNI_QSERDES_COM_DIV_FRAC_START3_MODE0		0x0d4
> > > +#define USB3_5NM_UNI_QSERDES_COM_DIV_FRAC_START1_MODE1		0x0d8
> > > +#define USB3_5NM_UNI_QSERDES_COM_DIV_FRAC_START2_MODE1		0x0dc
> > > +#define USB3_5NM_UNI_QSERDES_COM_DIV_FRAC_START3_MODE1		0x0e0
> > > +#define USB3_5NM_UNI_QSERDES_COM_INTEGLOOP_INITVAL		0x0e4
> > > +#define USB3_5NM_UNI_QSERDES_COM_INTEGLOOP_EN			0x0e8
> > > +#define USB3_5NM_UNI_QSERDES_COM_INTEGLOOP_GAIN0_MODE0		0x0ec
> > > +#define USB3_5NM_UNI_QSERDES_COM_INTEGLOOP_GAIN1_MODE0		0x0f0
> > > +#define USB3_5NM_UNI_QSERDES_COM_INTEGLOOP_GAIN0_MODE1		0x0f4
> > > +#define USB3_5NM_UNI_QSERDES_COM_INTEGLOOP_GAIN1_MODE1		0x0f8
> > > +#define USB3_5NM_UNI_QSERDES_COM_INTEGLOOP_P_PATH_GAIN0		0x0fc
> > > +#define USB3_5NM_UNI_QSERDES_COM_INTEGLOOP_P_PATH_GAIN1		0x100
> > > +#define USB3_5NM_UNI_QSERDES_COM_VCOCAL_DEADMAN_CTRL		0x104
> > > +#define USB3_5NM_UNI_QSERDES_COM_VCO_TUNE_CTRL			0x108
> > > +#define USB3_5NM_UNI_QSERDES_COM_VCO_TUNE_MAP			0x10c
> > > +#define USB3_5NM_UNI_QSERDES_COM_VCO_TUNE1_MODE0		0x110
> > > +#define USB3_5NM_UNI_QSERDES_COM_VCO_TUNE2_MODE0		0x114
> > > +#define USB3_5NM_UNI_QSERDES_COM_VCO_TUNE1_MODE1		0x118
> > > +#define USB3_5NM_UNI_QSERDES_COM_VCO_TUNE2_MODE1		0x11c
> > > +#define USB3_5NM_UNI_QSERDES_COM_VCO_TUNE_INITVAL1		0x120
> > > +#define USB3_5NM_UNI_QSERDES_COM_VCO_TUNE_INITVAL2		0x124
> > > +#define USB3_5NM_UNI_QSERDES_COM_VCO_TUNE_MINVAL1		0x128
> > > +#define USB3_5NM_UNI_QSERDES_COM_VCO_TUNE_MINVAL2		0x12c
> > > +#define USB3_5NM_UNI_QSERDES_COM_VCO_TUNE_MAXVAL1		0x130
> > > +#define USB3_5NM_UNI_QSERDES_COM_VCO_TUNE_MAXVAL2		0x134
> > > +#define USB3_5NM_UNI_QSERDES_COM_VCO_TUNE_TIMER1		0x138
> > > +#define USB3_5NM_UNI_QSERDES_COM_VCO_TUNE_TIMER2		0x13c
> > > +#define USB3_5NM_UNI_QSERDES_COM_CMN_STATUS			0x140
> > > +#define USB3_5NM_UNI_QSERDES_COM_RESET_SM_STATUS		0x144
> > > +#define USB3_5NM_UNI_QSERDES_COM_RESTRIM_CODE_STATUS		0x148
> > > +#define USB3_5NM_UNI_QSERDES_COM_PLLCAL_CODE1_STATUS		0x14c
> > > +#define USB3_5NM_UNI_QSERDES_COM_PLLCAL_CODE2_STATUS		0x150
> > > +#define USB3_5NM_UNI_QSERDES_COM_CLK_SELECT			0x154
> > > +#define USB3_5NM_UNI_QSERDES_COM_HSCLK_SEL			0x158
> > > +#define USB3_5NM_UNI_QSERDES_COM_HSCLK_HS_SWITCH_SEL		0x15c
> > > +#define USB3_5NM_UNI_QSERDES_COM_INTEGLOOP_BINCODE_STATUS	0x160
> > > +#define USB3_5NM_UNI_QSERDES_COM_PLL_ANALOG			0x164
> > > +#define USB3_5NM_UNI_QSERDES_COM_CORECLK_DIV_MODE0		0x168
> > > +#define USB3_5NM_UNI_QSERDES_COM_CORECLK_DIV_MODE1		0x16c
> > > +#define USB3_5NM_UNI_QSERDES_COM_SW_RESET			0x170
> > > +#define USB3_5NM_UNI_QSERDES_COM_CORE_CLK_EN			0x174
> > > +#define USB3_5NM_UNI_QSERDES_COM_C_READY_STATUS			0x178
> > > +#define USB3_5NM_UNI_QSERDES_COM_CMN_CONFIG			0x17c
> > > +#define USB3_5NM_UNI_QSERDES_COM_CMN_RATE_OVERRIDE		0x180
> > > +#define USB3_5NM_UNI_QSERDES_COM_SVS_MODE_CLK_SEL		0x184
> > > +#define USB3_5NM_UNI_QSERDES_COM_DEBUG_BUS0			0x188
> > > +#define USB3_5NM_UNI_QSERDES_COM_DEBUG_BUS1			0x18c
> > > +#define USB3_5NM_UNI_QSERDES_COM_DEBUG_BUS2			0x190
> > > +#define USB3_5NM_UNI_QSERDES_COM_DEBUG_BUS3			0x194
> > > +#define USB3_5NM_UNI_QSERDES_COM_DEBUG_BUS_SEL			0x198
> > > +#define USB3_5NM_UNI_QSERDES_COM_CMN_MISC1			0x19c
> > > +#define USB3_5NM_UNI_QSERDES_COM_CMN_MODE			0x1a0
> > > +#define USB3_5NM_UNI_QSERDES_COM_CMN_MODE_CONTD			0x1a4
> > > +#define USB3_5NM_UNI_QSERDES_COM_VCO_DC_LEVEL_CTRL		0x1a8
> > > +#define USB3_5NM_UNI_QSERDES_COM_BIN_VCOCAL_CMP_CODE1_MODE0	0x1ac
> > > +#define USB3_5NM_UNI_QSERDES_COM_BIN_VCOCAL_CMP_CODE2_MODE0	0x1b0
> > > +#define USB3_5NM_UNI_QSERDES_COM_BIN_VCOCAL_CMP_CODE1_MODE1	0x1b4
> > > +#define USB3_5NM_UNI_QSERDES_COM_BIN_VCOCAL_CMP_CODE2_MODE1	0x1b8
> > > +#define USB3_5NM_UNI_QSERDES_COM_BIN_VCOCAL_HSCLK_SEL		0x1bc
> > > +#define USB3_5NM_UNI_QSERDES_COM_RESERVED_1			0x1c0
> > > +#define USB3_5NM_UNI_QSERDES_COM_MODE_OPERATION_STATUS		0x1c4
> 
> these are offset now...
> 

Not sure I see what you mean?

> Any reason why this should be 5NM and not use the VX convention we
> have...?
> 

The downstream file is named "5nm" and not V5, so this was simply an
attempt to reduce the effort spent maintaining these defines.

Regards,
Bjorn
