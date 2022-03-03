Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CEB4CC41D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiCCRjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiCCRje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:39:34 -0500
Received: from mail-41103.protonmail.ch (mail-41103.protonmail.ch [185.70.41.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C313E108BE8;
        Thu,  3 Mar 2022 09:38:46 -0800 (PST)
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id 4K8dWT14blz4xLFv;
        Thu,  3 Mar 2022 17:38:45 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (1024-bit key) header.d=connolly.tech header.i=@connolly.tech header.b="WCL25u9O"
Date:   Thu, 03 Mar 2022 17:38:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1646329118;
        bh=HrxBmH3YwEP0q1bvU2BH7PU9i4V1wS4AlJ9ZNN4rP2A=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=WCL25u9OGiRYNyxzc0Kq+syOvA6uqkZX4H7hWkbmd9/HOiZhyDjidei+/QSpi+vro
         zDwgTsFc/AnMEYyN/hq8rAGSDuNpuZEQ/Atx5i0PzHX33CWO8ButXm87DS4qf1hvaW
         p/v6nxa2aJSxRkH9Rv6mQxoNhVXQE0BgkYc8TG1I=
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH 3/3] clk: qcom: smd: Add missing MSM8998 RPM clocks
Message-ID: <f06677f3-57ab-42eb-d707-a2d59fcdc3f2@connolly.tech>
In-Reply-To: <20220226214126.21209-3-konrad.dybcio@somainline.org>
References: <20220226214126.21209-1-konrad.dybcio@somainline.org> <20220226214126.21209-3-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[tested on Pixel 2 XL]
Tested-by: Caleb Connolly <caleb@connolly.tech>

On 26/02/2022 21:41, Konrad Dybcio wrote:
> Add missing RPM-provided clocks on msm8998 and reorder the definitions
> where needed.
>
> JAMI: fixed for a0384ecfe2aa ("clk: qcom: smd-rpm: De-duplicate identical=
 entries")
> JAMI: fixed for 36354c32bd76 ("clk: qcom: smd-rpm: Add .recalc_rate hook =
for clk_smd_rpm_branch_ops")
> Tested-by: Jami Kettunen <jami.kettunen@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>   drivers/clk/qcom/clk-smd-rpm.c | 40 +++++++++++++++++++++++-----------
>   1 file changed, 27 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rp=
m.c
> index 418f017e933f..afc6dc930011 100644
> --- a/drivers/clk/qcom/clk-smd-rpm.c
> +++ b/drivers/clk/qcom/clk-smd-rpm.c
> @@ -816,15 +816,18 @@ static const struct rpm_smd_clk_desc rpm_clk_qcs404=
 =3D {
>   =09.num_clks =3D ARRAY_SIZE(qcs404_clks),
>   };
>
> -DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, ln_bb_clk3_pin, ln_bb_clk3=
_a_pin,
> -=09=09=09=09     3, 19200000);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, ln_bb_clk3, ln_bb_clk3_a, 3, 19200=
000);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, ln_bb_clk3_pin, ln_bb_clk3=
_a_pin, 3, 19200000);
>   DEFINE_CLK_SMD_RPM(msm8998, aggre1_noc_clk, aggre1_noc_a_clk,
>   =09=09   QCOM_SMD_RPM_AGGR_CLK, 1);
>   DEFINE_CLK_SMD_RPM(msm8998, aggre2_noc_clk, aggre2_noc_a_clk,
>   =09=09   QCOM_SMD_RPM_AGGR_CLK, 2);
>   DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, rf_clk3, rf_clk3_a, 6, 19200000);
>   DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, rf_clk3_pin, rf_clk3_a_pi=
n, 6, 19200000);
> +
>   static struct clk_smd_rpm *msm8998_clks[] =3D {
> +=09[RPM_SMD_XO_CLK_SRC] =3D &sdm660_bi_tcxo,
> +=09[RPM_SMD_XO_A_CLK_SRC] =3D &sdm660_bi_tcxo_a,
>   =09[RPM_SMD_BIMC_CLK] =3D &msm8916_bimc_clk,
>   =09[RPM_SMD_BIMC_A_CLK] =3D &msm8916_bimc_a_clk,
>   =09[RPM_SMD_PCNOC_CLK] =3D &msm8916_pcnoc_clk,
> @@ -837,12 +840,22 @@ static struct clk_smd_rpm *msm8998_clks[] =3D {
>   =09[RPM_SMD_CE1_A_CLK] =3D &msm8992_ce1_a_clk,
>   =09[RPM_SMD_DIV_CLK1] =3D &msm8974_div_clk1,
>   =09[RPM_SMD_DIV_A_CLK1] =3D &msm8974_div_a_clk1,
> +=09[RPM_SMD_DIV_CLK2] =3D &msm8974_div_clk2,
> +=09[RPM_SMD_DIV_A_CLK2] =3D &msm8974_div_a_clk2,
> +=09[RPM_SMD_DIV_CLK3] =3D &msm8992_div_clk3,
> +=09[RPM_SMD_DIV_A_CLK3] =3D &msm8992_div_clk3_a,
>   =09[RPM_SMD_IPA_CLK] =3D &msm8976_ipa_clk,
>   =09[RPM_SMD_IPA_A_CLK] =3D &msm8976_ipa_a_clk,
>   =09[RPM_SMD_LN_BB_CLK1] =3D &msm8916_bb_clk1,
>   =09[RPM_SMD_LN_BB_CLK1_A] =3D &msm8916_bb_clk1_a,
>   =09[RPM_SMD_LN_BB_CLK2] =3D &msm8916_bb_clk2,
>   =09[RPM_SMD_LN_BB_CLK2_A] =3D &msm8916_bb_clk2_a,
> +=09[RPM_SMD_LN_BB_CLK3] =3D &msm8998_ln_bb_clk3,
> +=09[RPM_SMD_LN_BB_CLK3_A] =3D &msm8998_ln_bb_clk3_a,
> +=09[RPM_SMD_LN_BB_CLK1_PIN] =3D &msm8916_bb_clk1_pin,
> +=09[RPM_SMD_LN_BB_CLK1_A_PIN] =3D &msm8916_bb_clk1_a_pin,
> +=09[RPM_SMD_LN_BB_CLK2_PIN] =3D &msm8916_bb_clk2_pin,
> +=09[RPM_SMD_LN_BB_CLK2_A_PIN] =3D &msm8916_bb_clk2_a_pin,
>   =09[RPM_SMD_LN_BB_CLK3_PIN] =3D &msm8998_ln_bb_clk3_pin,
>   =09[RPM_SMD_LN_BB_CLK3_A_PIN] =3D &msm8998_ln_bb_clk3_a_pin,
>   =09[RPM_SMD_MMAXI_CLK] =3D &msm8996_mmssnoc_axi_rpm_clk,
> @@ -855,10 +868,14 @@ static struct clk_smd_rpm *msm8998_clks[] =3D {
>   =09[RPM_SMD_QDSS_A_CLK] =3D &msm8916_qdss_a_clk,
>   =09[RPM_SMD_RF_CLK1] =3D &msm8916_rf_clk1,
>   =09[RPM_SMD_RF_CLK1_A] =3D &msm8916_rf_clk1_a,
> -=09[RPM_SMD_RF_CLK2_PIN] =3D &msm8916_rf_clk2_pin,
> -=09[RPM_SMD_RF_CLK2_A_PIN] =3D &msm8916_rf_clk2_a_pin,
> +=09[RPM_SMD_RF_CLK2] =3D &msm8916_rf_clk2,
> +=09[RPM_SMD_RF_CLK2_A] =3D &msm8916_rf_clk2_a,
>   =09[RPM_SMD_RF_CLK3] =3D &msm8998_rf_clk3,
>   =09[RPM_SMD_RF_CLK3_A] =3D &msm8998_rf_clk3_a,
> +=09[RPM_SMD_RF_CLK1_PIN] =3D &msm8916_rf_clk1_pin,
> +=09[RPM_SMD_RF_CLK1_A_PIN] =3D &msm8916_rf_clk1_a_pin,
> +=09[RPM_SMD_RF_CLK2_PIN] =3D &msm8916_rf_clk2_pin,
> +=09[RPM_SMD_RF_CLK2_A_PIN] =3D &msm8916_rf_clk2_a_pin,
>   =09[RPM_SMD_RF_CLK3_PIN] =3D &msm8998_rf_clk3_pin,
>   =09[RPM_SMD_RF_CLK3_A_PIN] =3D &msm8998_rf_clk3_a_pin,
>   };
> @@ -868,9 +885,6 @@ static const struct rpm_smd_clk_desc rpm_clk_msm8998 =
=3D {
>   =09.num_clks =3D ARRAY_SIZE(msm8998_clks),
>   };
>
> -DEFINE_CLK_SMD_RPM_XO_BUFFER(sdm660, ln_bb_clk3, ln_bb_clk3_a, 3, 192000=
00);
> -DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(sdm660, ln_bb_clk3_pin, ln_bb_clk3_=
pin_a, 3, 19200000);
> -
>   static struct clk_smd_rpm *sdm660_clks[] =3D {
>   =09[RPM_SMD_XO_CLK_SRC] =3D &sdm660_bi_tcxo,
>   =09[RPM_SMD_XO_A_CLK_SRC] =3D &sdm660_bi_tcxo_a,
> @@ -900,16 +914,16 @@ static struct clk_smd_rpm *sdm660_clks[] =3D {
>   =09[RPM_SMD_LN_BB_A_CLK] =3D &msm8916_bb_clk1_a,
>   =09[RPM_SMD_LN_BB_CLK2] =3D &msm8916_bb_clk2,
>   =09[RPM_SMD_LN_BB_CLK2_A] =3D &msm8916_bb_clk2_a,
> -=09[RPM_SMD_LN_BB_CLK3] =3D &sdm660_ln_bb_clk3,
> -=09[RPM_SMD_LN_BB_CLK3_A] =3D &sdm660_ln_bb_clk3_a,
> +=09[RPM_SMD_LN_BB_CLK3] =3D &msm8998_ln_bb_clk3,
> +=09[RPM_SMD_LN_BB_CLK3_A] =3D &msm8998_ln_bb_clk3_a,
>   =09[RPM_SMD_RF_CLK1_PIN] =3D &msm8916_rf_clk1_pin,
>   =09[RPM_SMD_RF_CLK1_A_PIN] =3D &msm8916_rf_clk1_a_pin,
>   =09[RPM_SMD_LN_BB_CLK1_PIN] =3D &msm8916_bb_clk1_pin,
>   =09[RPM_SMD_LN_BB_CLK1_A_PIN] =3D &msm8916_bb_clk1_a_pin,
>   =09[RPM_SMD_LN_BB_CLK2_PIN] =3D &msm8916_bb_clk2_pin,
>   =09[RPM_SMD_LN_BB_CLK2_A_PIN] =3D &msm8916_bb_clk2_a_pin,
> -=09[RPM_SMD_LN_BB_CLK3_PIN] =3D &sdm660_ln_bb_clk3_pin,
> -=09[RPM_SMD_LN_BB_CLK3_A_PIN] =3D &sdm660_ln_bb_clk3_pin_a,
> +=09[RPM_SMD_LN_BB_CLK3_PIN] =3D &msm8998_ln_bb_clk3_pin,
> +=09[RPM_SMD_LN_BB_CLK3_A_PIN] =3D &msm8998_ln_bb_clk3_a_pin,
>   };
>
>   static const struct rpm_smd_clk_desc rpm_clk_sdm660 =3D {
> @@ -1011,8 +1025,8 @@ static struct clk_smd_rpm *sm6125_clks[] =3D {
>   =09[RPM_SMD_LN_BB_CLK1_A] =3D &msm8916_bb_clk1_a,
>   =09[RPM_SMD_LN_BB_CLK2] =3D &msm8916_bb_clk2,
>   =09[RPM_SMD_LN_BB_CLK2_A] =3D &msm8916_bb_clk2_a,
> -=09[RPM_SMD_LN_BB_CLK3] =3D &sdm660_ln_bb_clk3,
> -=09[RPM_SMD_LN_BB_CLK3_A] =3D &sdm660_ln_bb_clk3_a,
> +=09[RPM_SMD_LN_BB_CLK3] =3D &msm8998_ln_bb_clk3,
> +=09[RPM_SMD_LN_BB_CLK3_A] =3D &msm8998_ln_bb_clk3_a,
>   =09[RPM_SMD_QUP_CLK] =3D &sm6125_qup_clk,
>   =09[RPM_SMD_QUP_A_CLK] =3D &sm6125_qup_a_clk,
>   =09[RPM_SMD_MMRT_CLK] =3D &sm6125_mmrt_clk,
> --
> 2.35.1
>

--
Kind Regards,
Caleb

