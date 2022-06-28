Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A104955EFB1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiF1UjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiF1Ui6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:38:58 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CD41FCD3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:38:57 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a4so10773084lfm.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=Xmi9Zlf0oj5LCKHCuDvQ1k8JqDaa3QSmZJvGzHNzvuM=;
        b=qxCq0oGZJ0MLKsBRQGAqd8dN+Q6795yvZIm4hb3cOT1md3MhZpNt6uhGPiIfoqKF81
         YF0nibH38J5rrH0BzHGScDRkBMl+hgM2TNZTCEZaPeOEhQdHJhZjIYhywQb3RfPvlM2T
         E+VP3Pu6qEOmFZm2m1XXCGKJNIaoz+DomscA+gQBxx3GFeNVpLlp7yxegA3znrRDA2vN
         vfai0EY/ffZLKcx3XN9URyY5681zXpmX6qSZHAsvxvexQ/Gp+vWKB+sseHsUia36+fSS
         3YbgEy7Lu7POLazTOTSW6lmBNfBTacW7xdHDTTuNBP2DH36Iv2BMpLMz3tp5mIHjchaN
         Ot5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=Xmi9Zlf0oj5LCKHCuDvQ1k8JqDaa3QSmZJvGzHNzvuM=;
        b=RVgvcR0F0bgCw/0+uwQpZsZJTUfoM5oGiG1Lto5k7B29iGXC3F9SGVqMNjyOjFNNHl
         iTfGJ5SFRi3PPMQsRQhT7r1rbh9nAJIgYsne4lNjKfjutGZAXHpyIn8GUJiMdB0uz/XX
         6v0pgh6N61Py1PTnnLVCjVz7n/xOCzXnq2xpjNQInF1V0cZv2Ifq3fJ7+J+5PGUb3NKB
         KSxeJmdsuGdUp37MJAMTaYzVJtc5K26RgBNCDa4CIccsP6KeQzee0oA/y2MrL0w7GNbE
         FgiT0LYcsVoNO3x6DMDvLMfNHbZSY8frRKO9N2Ps83Llr3t+u7cjMTEvGgOefF2xH9a6
         jKkw==
X-Gm-Message-State: AJIora9WRqfqQoYBVwc67iIjRhD/0Nj5PyGRy13Cz7hA7UV8Phg7abrN
        42XSCLeBLSPegQEXfeHJuktJpQ==
X-Google-Smtp-Source: AGRyM1uui+OQa7CWZ6BeoG7URy6HIyqC81TUIny4WbxhHjVxhV40t6lnln7hSf9wDCObVgP7qlLIHw==
X-Received: by 2002:a05:6512:260a:b0:47f:ab30:d624 with SMTP id bt10-20020a056512260a00b0047fab30d624mr13640371lfb.326.1656448735689;
        Tue, 28 Jun 2022 13:38:55 -0700 (PDT)
Received: from [127.0.0.1] ([188.162.64.167])
        by smtp.gmail.com with ESMTPSA id t11-20020ac24c0b000000b0047f8e9826a1sm2331073lfq.31.2022.06.28.13.38.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jun 2022 13:38:55 -0700 (PDT)
Date:   Tue, 28 Jun 2022 23:38:49 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
CC:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_2/3=5D_thermal=3A_qcom=3A_tse?= =?US-ASCII?Q?ns-v1=3A_Use_GENMASK_macro_for_bitmasks?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20220628142359.93100-2-konrad.dybcio@somainline.org>
References: <20220628142359.93100-1-konrad.dybcio@somainline.org> <20220628142359.93100-2-konrad.dybcio@somainline.org>
Message-ID: <30ED78BE-3B77-4779-AC4B-958E5B0B7499@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28 June 2022 17:23:58 GMT+03:00, Konrad Dybcio <konrad=2Edybcio@somainl=
ine=2Eorg> wrote:
>Convert the masks to use GENMASK=2E Tested by objdumping and making sure
>the output is identical pre- and post this patch=2E
>
>Signed-off-by: Konrad Dybcio <konrad=2Edybcio@somainline=2Eorg>
>---
>Changes since v3:
>* Add this patch
>
> drivers/thermal/qcom/tsens-v1=2Ec | 107 ++++++++++++++++----------------
> 1 file changed, 54 insertions(+), 53 deletions(-)
>
>diff --git a/drivers/thermal/qcom/tsens-v1=2Ec b/drivers/thermal/qcom/tse=
ns-v1=2Ec
>index 573e261ccca7=2E=2Ed6f0dec4bfa1 100644
>--- a/drivers/thermal/qcom/tsens-v1=2Ec
>+++ b/drivers/thermal/qcom/tsens-v1=2Ec
>@@ -3,6 +3,7 @@
>  * Copyright (c) 2019, Linaro Limited
>  */
>=20
>+#include <linux/bits=2Eh>
> #include <linux/bitops=2Eh>
> #include <linux/regmap=2Eh>
> #include <linux/delay=2Eh>
>@@ -22,34 +23,34 @@
> #define TM_HIGH_LOW_Sn_INT_THRESHOLD_OFF	0x0090
>=20
> /* eeprom layout data for msm8956/76 (v1) */
>-#define MSM8976_BASE0_MASK	0xff
>-#define MSM8976_BASE1_MASK	0xff
>+#define MSM8976_BASE0_MASK	GENMASK(7, 0)
>+#define MSM8976_BASE1_MASK	GENMASK(7, 0)
> #define MSM8976_BASE1_SHIFT	8

Hmm=2E Is the BASE1_MASK correct? Should it be 0xff00 instead?
(Yes, it's not a mistake in your patch, but let's make sure it is not a mi=
stake)=2E

>=20
>-#define MSM8976_S0_P1_MASK	0x3f00
>-#define MSM8976_S1_P1_MASK	0x3f00000
>-#define MSM8976_S2_P1_MASK	0x3f
>-#define MSM8976_S3_P1_MASK	0x3f000
>-#define MSM8976_S4_P1_MASK	0x3f00
>-#define MSM8976_S5_P1_MASK	0x3f00000
>-#define MSM8976_S6_P1_MASK	0x3f
>-#define MSM8976_S7_P1_MASK	0x3f000
>-#define MSM8976_S8_P1_MASK	0x1f8
>-#define MSM8976_S9_P1_MASK	0x1f8000
>-#define MSM8976_S10_P1_MASK	0xf8000000
>-#define MSM8976_S10_P1_MASK_1	0x1
>-
>-#define MSM8976_S0_P2_MASK	0xfc000
>-#define MSM8976_S1_P2_MASK	0xfc000000
>-#define MSM8976_S2_P2_MASK	0xfc0
>-#define MSM8976_S3_P2_MASK	0xfc0000
>-#define MSM8976_S4_P2_MASK	0xfc000
>-#define MSM8976_S5_P2_MASK	0xfc000000
>-#define MSM8976_S6_P2_MASK	0xfc0
>-#define MSM8976_S7_P2_MASK	0xfc0000
>-#define MSM8976_S8_P2_MASK	0x7e00
>-#define MSM8976_S9_P2_MASK	0x7e00000
>-#define MSM8976_S10_P2_MASK	0x7e
>+#define MSM8976_S0_P1_MASK	GENMASK(13, 8)

I was thinking about:

#define MSM8976_MASK(shift) GENMASK((shift) + 5, (shift))
#define MSM8976_S1_P1_MASK MSM8976_MASK(MSM8976_S0_P1_SHIFT)

But=2E=2E=2E While you are reworking this driver, could you please replace=
 mask+shift statements with the FIELD_GET / FIELD_PREP?
There is a huge chance that we can drop _SHIFT completely and just use new=
ly defined masks from this patch=2E

>+#define MSM8976_S1_P1_MASK	GENMASK(25, 20)
>+#define MSM8976_S2_P1_MASK	GENMASK(5, 0)
>+#define MSM8976_S3_P1_MASK	GENMASK(17, 12)
>+#define MSM8976_S4_P1_MASK	GENMASK(13, 8)
>+#define MSM8976_S5_P1_MASK	GENMASK(25, 20)
>+#define MSM8976_S6_P1_MASK	GENMASK(5, 0)
>+#define MSM8976_S7_P1_MASK	GENMASK(17, 12)
>+#define MSM8976_S8_P1_MASK	GENMASK(8, 3)
>+#define MSM8976_S9_P1_MASK	GENMASK(20, 15)
>+#define MSM8976_S10_P1_MASK	GENMASK(31, 27)
>+#define MSM8976_S10_P1_MASK_1	GENMASK(0, 0)
>+
>+#define MSM8976_S0_P2_MASK	GENMASK(19, 14)
>+#define MSM8976_S1_P2_MASK	GENMASK(31, 26)
>+#define MSM8976_S2_P2_MASK	GENMASK(11, 6)
>+#define MSM8976_S3_P2_MASK	GENMASK(23, 18)
>+#define MSM8976_S4_P2_MASK	GENMASK(19, 14)
>+#define MSM8976_S5_P2_MASK	GENMASK(31, 26)
>+#define MSM8976_S6_P2_MASK	GENMASK(11, 6)
>+#define MSM8976_S7_P2_MASK	GENMASK(23, 18)
>+#define MSM8976_S8_P2_MASK	GENMASK(14, 9)
>+#define MSM8976_S9_P2_MASK	GENMASK(26, 21)
>+#define MSM8976_S10_P2_MASK	GENMASK(6, 1)
>=20
> #define MSM8976_S0_P1_SHIFT	8
> #define MSM8976_S1_P1_SHIFT	20
>@@ -76,7 +77,7 @@
> #define MSM8976_S9_P2_SHIFT	21
> #define MSM8976_S10_P2_SHIFT	1
>=20
>-#define MSM8976_CAL_SEL_MASK	0x3
>+#define MSM8976_CAL_SEL_MASK	GENMASK(1, 0)
>=20
> #define MSM8976_CAL_DEGC_PT1	30
> #define MSM8976_CAL_DEGC_PT2	120
>@@ -84,34 +85,34 @@
> #define MSM8976_SLOPE_DEFAULT	3200
>=20
> /* eeprom layout data for qcs404/405 (v1) */
>-#define BASE0_MASK	0x000007f8
>-#define BASE1_MASK	0x0007f800
>+#define BASE0_MASK	GENMASK(10, 3)
>+#define BASE1_MASK	GENMASK(18, 11)
> #define BASE0_SHIFT	3
> #define BASE1_SHIFT	11
>=20
>-#define S0_P1_MASK	0x0000003f
>-#define S1_P1_MASK	0x0003f000
>-#define S2_P1_MASK	0x3f000000
>-#define S3_P1_MASK	0x000003f0
>-#define S4_P1_MASK	0x003f0000
>-#define S5_P1_MASK	0x0000003f
>-#define S6_P1_MASK	0x0003f000
>-#define S7_P1_MASK	0x3f000000
>-#define S8_P1_MASK	0x000003f0
>-#define S9_P1_MASK	0x003f0000
>-
>-#define S0_P2_MASK	0x00000fc0
>-#define S1_P2_MASK	0x00fc0000
>-#define S2_P2_MASK_1_0	0xc0000000
>-#define S2_P2_MASK_5_2	0x0000000f
>-#define S3_P2_MASK	0x0000fc00
>-#define S4_P2_MASK	0x0fc00000
>-#define S5_P2_MASK	0x00000fc0
>-#define S6_P2_MASK	0x00fc0000
>-#define S7_P2_MASK_1_0	0xc0000000
>-#define S7_P2_MASK_5_2	0x0000000f
>-#define S8_P2_MASK	0x0000fc00
>-#define S9_P2_MASK	0x0fc00000
>+#define S0_P1_MASK	GENMASK(5, 0)
>+#define S1_P1_MASK	GENMASK(17, 12)
>+#define S2_P1_MASK	GENMASK(29, 24)
>+#define S3_P1_MASK	GENMASK(9, 4)
>+#define S4_P1_MASK	GENMASK(21, 16)
>+#define S5_P1_MASK	GENMASK(5, 0)
>+#define S6_P1_MASK	GENMASK(17, 12)
>+#define S7_P1_MASK	GENMASK(29, 24)
>+#define S8_P1_MASK	GENMASK(9, 4)
>+#define S9_P1_MASK	GENMASK(21, 16)
>+
>+#define S0_P2_MASK	GENMASK(11, 6)
>+#define S1_P2_MASK	GENMASK(23, 18)
>+#define S2_P2_MASK_1_0	GENMASK(31, 30)
>+#define S2_P2_MASK_5_2	GENMASK(3, 0)
>+#define S3_P2_MASK	GENMASK(15, 10)
>+#define S4_P2_MASK	GENMASK(27, 22)
>+#define S5_P2_MASK	GENMASK(11, 6)
>+#define S6_P2_MASK	GENMASK(23, 18)
>+#define S7_P2_MASK_1_0	GENMASK(31, 30)
>+#define S7_P2_MASK_5_2	GENMASK(3, 0)
>+#define S8_P2_MASK	GENMASK(15, 10)
>+#define S9_P2_MASK	GENMASK(27, 22)
>=20
> #define S0_P1_SHIFT	0
> #define S0_P2_SHIFT	6
>@@ -139,7 +140,7 @@
> #define S9_P1_SHIFT	16
> #define S9_P2_SHIFT	22
>=20
>-#define CAL_SEL_MASK	7
>+#define CAL_SEL_MASK	GENMASK(2, 0)
> #define CAL_SEL_SHIFT	0
>=20
> static void compute_intercept_slope_8976(struct tsens_priv *priv,

--=20
With best wishes
Dmitry
