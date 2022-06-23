Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A87555727C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 07:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiFWFLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 01:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiFWFK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 01:10:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBA743EF7;
        Wed, 22 Jun 2022 21:56:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 077B3B821BD;
        Thu, 23 Jun 2022 04:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10D3C3411B;
        Thu, 23 Jun 2022 04:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655960209;
        bh=7NGWiP7w2/KsMG4zeZeSF2thFnKJWhK9wepK+9ZyTbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bq9aC+hU2DAGDskJedAwYyFP1mR1YO0dUw/oRS4VsNngM+5esffT4Yb6oQtNVXFio
         IDNXwepW5I0mVUjFgURYfV2sZ77zmsNg6aedBvPnVZj5Aip1X0A+JDgRy8LvV2P+Sp
         BLMFXmdYFuy41yhwcOecRzDPz2wQisixbygQ/AwjR2zSSu/WLmACLwhzJ1FcKYalAt
         y20PsnXt+795h0MMq8p0AW+/4j/5cO341+1JYsv+jqs+zRfDA29UCvgWWIozd9kSbV
         6vXh3PUqV/BFPZrLMMdk5Z4VoSLuMNOzKE09+XHCJOoJ4eU00Vzvdx77y6UM+VKStd
         sKqKpBmRvCTEQ==
Date:   Thu, 23 Jun 2022 10:26:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, jonathan@marek.ca,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH v7 2/6] clk: qcom: add support for SM8350 GPUCC
Message-ID: <YrPyjKs0jG0xjgPW@matsya>
References: <20220622232846.852771-1-robert.foss@linaro.org>
 <20220622232846.852771-3-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622232846.852771-3-robert.foss@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-06-22, 01:28, Robert Foss wrote:
> The GPUCC manages the clocks for the Adreno GPU found on the
> sm8350 SoCs.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
> 
> Changes since v1
>  - Remove .name assignments for clk_parent_data - Dmitry
>  - Use ARRAY_SIZE where possible - Dmitry
>  - Remove commented out code - Dmitry
>  - Set CLAMP_IO flag for gpu_gx_gdsc - Dmitry
>  - Assign .parent_hws instead of .hw - Dmitry
> 
> Changes since v2
>  - Switch license to dual BSD/GPL - Bjorn
>  - Add Jonathans SoB - Jonathan
>  - Add Linaro to copyright statement - Bjorn
>  - Make .hw.init assignment const - Bjorn
>  - Extract & deduplicate bi_tcxo parent_data - Bjorn
>  - Removed further .name assignment - Bjorn
>  - Move of_device_id declaration - Bjorn
> 
> Changes since v3
>  - Change license to BSD/GPL - Rob/Bjorn
>  - Switch from .fw_name to .index
> 
> Changes since v4
>  - Change year of copyright statement
>  - Change to dual license for header file - Rob
> 
> Changes since v5
>  - Change hex to lower case - Konrad
> 
> Changes since v6
>  - Change hex to lower case - Konrad
>  - Change license go GPL 2.0 only - Konrad
> 
> 
>  drivers/clk/qcom/Kconfig        |   8 +
>  drivers/clk/qcom/Makefile       |   1 +
>  drivers/clk/qcom/gpucc-sm8350.c | 637 ++++++++++++++++++++++++++++++++
>  3 files changed, 646 insertions(+)
>  create mode 100644 drivers/clk/qcom/gpucc-sm8350.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index bc4dcf356d82..b11235c21952 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -712,6 +712,14 @@ config SM_GPUCC_8250
>  	  Say Y if you want to support graphics controller devices and
>  	  functionality such as 3D graphics.
>  
> +config SM_GPUCC_8350
> +	tristate "SM8350 Graphics Clock Controller"
> +	select SM_GCC_8350
> +	help
> +	  Support for the graphics clock controller on SM8350 devices.
> +	  Say Y if you want to support graphics controller devices and
> +	  functionality such as 3D graphics.
> +
>  config SM_VIDEOCC_8150
>  	tristate "SM8150 Video Clock Controller"
>  	select SM_GCC_8150
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 36789f5233ef..ef9c64824424 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -101,6 +101,7 @@ obj-$(CONFIG_SM_GCC_8450) += gcc-sm8450.o
>  obj-$(CONFIG_SM_GPUCC_6350) += gpucc-sm6350.o
>  obj-$(CONFIG_SM_GPUCC_8150) += gpucc-sm8150.o
>  obj-$(CONFIG_SM_GPUCC_8250) += gpucc-sm8250.o
> +obj-$(CONFIG_SM_GPUCC_8350) += gpucc-sm8350.o
>  obj-$(CONFIG_SM_VIDEOCC_8150) += videocc-sm8150.o
>  obj-$(CONFIG_SM_VIDEOCC_8250) += videocc-sm8250.o
>  obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
> diff --git a/drivers/clk/qcom/gpucc-sm8350.c b/drivers/clk/qcom/gpucc-sm8350.c
> new file mode 100644
> index 000000000000..d13fa813d190
> --- /dev/null
> +++ b/drivers/clk/qcom/gpucc-sm8350.c
> @@ -0,0 +1,637 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Linaro Limited
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,gpucc-sm8350.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-pll.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "common.h"
> +#include "clk-regmap-mux.h"
> +#include "clk-regmap-divider.h"
> +#include "gdsc.h"
> +#include "reset.h"

nit: this could be sorted alphabetically. Otherwise looks good to me

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
