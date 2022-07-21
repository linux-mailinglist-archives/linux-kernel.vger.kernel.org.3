Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B757E57D37D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbiGUSln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGUSlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:41:40 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CE086C1E;
        Thu, 21 Jul 2022 11:41:38 -0700 (PDT)
Received: from [192.168.1.101] (abxj77.neoplus.adsl.tpnet.pl [83.9.3.77])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 7B0673F72A;
        Thu, 21 Jul 2022 20:41:35 +0200 (CEST)
Message-ID: <d960d442-4b0a-ef33-04da-8fe3a3c8fb90@somainline.org>
Date:   Thu, 21 Jul 2022 20:41:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: introduce sa8540p-ride dts
Content-Language: en-US
To:     Parikshit Pareek <quic_ppareek@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220721154057.15276-1-quic_ppareek@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220721154057.15276-1-quic_ppareek@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

On 21.07.2022 17:40, Parikshit Pareek wrote:
> Create new dts file specific for Qdrive board based on sa8540p chipset.
Is the SA8540P any different than SA8295P? My wild guess is that they're
binned versions of each other with different DVFS levels.. That could
use a separate SoC DTSI to hold these differences should that be true..


> Introduce common dtsi file sa8295p-adp.dtsi, to be included for adp and
> Qdrive board.
> 
> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts      | 378 +----------------
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dtsi     | 385 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts |  15 +
>  4 files changed, 403 insertions(+), 376 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8295p-adp.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 9e2a13d75f9d..fa0abcf7660b 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -51,6 +51,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
> +dtb-$(CONFIG_ARCH_QCOM) += sa8540p-adp-ride.dtb
This needs to be a tab.


>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1-lte.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> index 9398f0349944..adb6637117bc 100644
> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> @@ -2,388 +2,14 @@
>  /*
>   * Copyright (c) 2021, The Linux Foundation. All rights reserved.
>   * Copyright (c) 2022, Linaro Limited
> + * Copyright (c) 2022 Qualcomm Innovaion Center, Inc. All rights reserved.
Please add a comma after the year to keep it consistent.


>   */
>  
>  /dts-v1/;

[...]

> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dtsi b/arch/arm64/boot/dts/qcom/sa8295p-adp.dtsi
> new file mode 100644
> index 000000000000..75ef77b7cac1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dtsi
Are the boards based on each other? Or on a similar base platform?
Maybe sa8295p/sa8540p/sasomethingelse-automotive.dtsi could be a 
better name in the latter case?


[...]

> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Linaro Limited
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "sa8295p-adp.dtsi"
> +
> +/ {
> +	model = "Qualcomm SA8540 ADP";
So "Qdrive board" == SA8540 ADP == SA8540 ADP Ride? Or is there
a base platform for all of them? Maybe the Qdrive is simply based
on the ADPs? Is there a clear distinction between ADP and ADP Ride?

Konrad

> +	compatible = "qcom,sa8540p-adp-ride", "qcom,sa8540p";
> +};
