Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCF552BC4F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238093AbiERNmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbiERNms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:42:48 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B511A15CD
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:42:46 -0700 (PDT)
Received: from [10.1.250.9] (riviera.nat.ds.pw.edu.pl [194.29.137.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id C2AE720602;
        Wed, 18 May 2022 15:42:44 +0200 (CEST)
Message-ID: <d60f32dc-a9f5-95ad-245e-6b9521d73fce@somainline.org>
Date:   Wed, 18 May 2022 15:42:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v3 4/6] regulator: qcom_spmi: Add support for PMP8074
 regulators
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220517205341.536587-1-robimarko@gmail.com>
 <20220517205341.536587-4-robimarko@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220517205341.536587-4-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/05/2022 22:53, Robert Marko wrote:
> PMP8074 is a companion PMIC for the Qualcomm IPQ8074 WiSoC-s.
>
> It features 5 HF-SMPS and 13 LDO regulators.
>
> This commit adds support for S3 and S4 HF-SMPS buck regulators of
> the HFS430 type and LDO11 of the HT_P150 type.
> S3 is the CPU cluster voltage supply, S4 supplies the UBI32 NPU cores
> and LDO11 is the SDIO/eMMC I/O voltage regulator required for high speeds.
>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>   drivers/regulator/qcom_spmi-regulator.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
> index 38bbc70241ae..696b088aae40 100644
> --- a/drivers/regulator/qcom_spmi-regulator.c
> +++ b/drivers/regulator/qcom_spmi-regulator.c
> @@ -2137,6 +2137,13 @@ static const struct spmi_regulator_data pms405_regulators[] = {
>   	{ }
>   };
>   
> +static const struct spmi_regulator_data pmp8074_regulators[] = {

Please sort the struct alphabletically.


> +	{ "s3", 0x1a00, "vdd_s3"},
> +	{ "s4", 0x1d00, "vdd_s4"},
> +	{ "l11", 0x4a00, "vdd_l10_l11_l12_l13"},

Are the other regulators somehow not controllable through SPMI? Please 
leave a comment if that's the case.


> +	{ }
> +};
> +
>   static const struct of_device_id qcom_spmi_regulator_match[] = {
>   	{ .compatible = "qcom,pm8004-regulators", .data = &pm8004_regulators },
>   	{ .compatible = "qcom,pm8005-regulators", .data = &pm8005_regulators },
> @@ -2150,6 +2157,7 @@ static const struct of_device_id qcom_spmi_regulator_match[] = {
>   	{ .compatible = "qcom,pm660-regulators", .data = &pm660_regulators },
>   	{ .compatible = "qcom,pm660l-regulators", .data = &pm660l_regulators },
>   	{ .compatible = "qcom,pms405-regulators", .data = &pms405_regulators },
> +	{ .compatible = "qcom,pmp8074-regulators", .data = &pmp8074_regulators },

Please sort the compatible too.


Konrad

>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, qcom_spmi_regulator_match);
>
