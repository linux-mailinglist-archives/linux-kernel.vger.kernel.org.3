Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED8551E8FE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 19:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386692AbiEGRjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 13:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242983AbiEGRjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 13:39:44 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E97727FD6
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 10:35:57 -0700 (PDT)
Received: from [192.168.1.101] (abxi172.neoplus.adsl.tpnet.pl [83.9.2.172])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id A23423ED82;
        Sat,  7 May 2022 19:35:54 +0200 (CEST)
Message-ID: <c13621d1-8c33-2979-b455-2e1f4e4bc5c8@somainline.org>
Date:   Sat, 7 May 2022 19:35:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] arm64: dts: qcom: msm8998: Make regulator voltages
 multiple of step-size
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>
References: <20220507153627.1478268-1-marijn.suijten@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220507153627.1478268-1-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7.05.2022 17:36, Marijn Suijten wrote:
> These voltages are not a multiple of the given step-size 8000 (with base
> voltage 1664000) in pm8998_pldo, resulting in PLDO regulators l18 and
> l22 failing to validate and in turn not probing the rpm-pm8998-regulator
> driver:
> 
>     l18: unsupportable voltage constraints 2856000-2848000uV
>     qcom_rpm_smd_regulator rpm-glink:rpm-requests:pm8998-regulators: l18: devm_regulator_register() failed, ret=-22
> 
> Round the voltages down for the sake of erring on the safe side, leaving
> a comment in place to document this discrepancy wrt downstream sources.
> 
> Fixes: 390883af89d2 ("arm64: dts: qcom: msm8998: Introduce support for Sony Yoshino platform")
> Reported-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
Also:
Reported-by: Markuss Broks <markuss.broks@gmail.com>

Konrad


>  .../dts/qcom/msm8998-sony-xperia-yoshino-poplar.dts    | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dts b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dts
> index 4a1f98a21031..c21333aa73c2 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dts
> @@ -26,11 +26,13 @@ &lab {
>  };
>  
>  &vreg_l18a_2p85 {
> -	regulator-min-microvolt = <2850000>;
> -	regulator-max-microvolt = <2850000>;
> +	/* Note: Round-down from 2850000 to be a multiple of PLDO step-size 8000 */
> +	regulator-min-microvolt = <2848000>;
> +	regulator-max-microvolt = <2848000>;
>  };
>  
>  &vreg_l22a_2p85 {
> -	regulator-min-microvolt = <2700000>;
> -	regulator-max-microvolt = <2700000>;
> +	/* Note: Round-down from 2700000 to be a multiple of PLDO step-size 8000 */
> +	regulator-min-microvolt = <2696000>;
> +	regulator-max-microvolt = <2696000>;
>  };
