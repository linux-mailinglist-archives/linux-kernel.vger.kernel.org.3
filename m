Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7076B5B1860
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiIHJUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiIHJUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:20:07 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6201F52DE7
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 02:20:01 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id f11so12690527lfa.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 02:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Om7NL/8n/AZHbaNF9gisHUFy/iTMOZIGCGU/AWMpqjM=;
        b=s3F6VUZmLEJvv6zvjBQg40i1axUWt3+JJdgs4yt/GB6omeW0dE+2w3sgAdqXd8CO4H
         EjhtYwhMtxpU5nTjGD/pAK74KbyuW97PiGSSHgAtkf2C4x0HNDj7ZfqLJ2JnHduQhvuH
         K3xLQoJke+1OWs1BSJIc4yfI275XPt1VnKad40eF9q2mRgRUV+rbvYPwFZbbBhKTX3he
         oQhrQnCyom76zocntvMbIB5usBwoXGfh9ul2ebOGEA0NScUDOZDzVxY1cHqs9FMv+qO3
         CelmNIzegsZklrWL7dBDspWZe+f4MUz+XSuHbRVLBvfVi30PJnb03YAoss4KtgojXYrs
         tqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Om7NL/8n/AZHbaNF9gisHUFy/iTMOZIGCGU/AWMpqjM=;
        b=wC39OQINXDAL/s5Io7SSSuxQViQD43V0fxXuoZxdiZx6lR09hLvLqogGwvgHS22OWK
         6/M87mklB1dEDtLJ3h3MNR8aTCFXZn1fkVrcvtrrZmUIkisO/De6XzlUjDqVmzEPn3wH
         4vqBndjqffZ0ULGVrqBcQG7HfujTxuJL5BieS+6DetyPQU7ECm6EEZ1uMIctvloJlQsV
         sPF6BDJc8/MK7R0VgzVi7IHiwtedIrIjo+nHrLvPrl0t8mP7hxrnBJkgnHjigC3H5R7Q
         sN38OntXk3wIgWBGMO1w42Xg7w8coLFh52nuLGnU8yG7GCCBIEwZI0SsHRqMvHZ72jxx
         FUpQ==
X-Gm-Message-State: ACgBeo2q6o0jx14ioTD0MTRSlp0RnKDA8uqTbxnr2VhfnK4XPsK2lSXs
        uY6sH5UwGnR52gaeb6tZVd43lw==
X-Google-Smtp-Source: AA6agR739bmADnlz9UMhbMUSLTU5hJ7EkzCnvwRUlCOppWXSP38GZm+/4RN3Rjek/hu6p9Bk449QVQ==
X-Received: by 2002:ac2:4f02:0:b0:495:79c7:f2f4 with SMTP id k2-20020ac24f02000000b0049579c7f2f4mr2473093lfr.35.1662628799439;
        Thu, 08 Sep 2022 02:19:59 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q17-20020a056512211100b004946a758d21sm218219lfr.161.2022.09.08.02.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 02:19:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 07/14] arm64: dts: qcom: qrb5165-rb5: align dai node names with dtschema
Date:   Thu,  8 Sep 2022 11:19:39 +0200
Message-Id: <20220908091946.44800-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220908091946.44800-1-krzysztof.kozlowski@linaro.org>
References: <20220908091946.44800-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT schema expects DAI node names to be "dai":

  qcom/qrb5165-rb5.dtb: dais: 'qi2s@16', 'qi2s@20' do not match any of the regexes: '^dai@[0-9]+$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index bf8077a1cf9a..d39ca3671477 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -867,7 +867,7 @@ &qupv3_id_2 {
 };
 
 &q6afedai {
-	qi2s@16 {
+	dai@16 {
 		reg = <PRIMARY_MI2S_RX>;
 		qcom,sd-lines = <0 1 2 3>;
 	};
@@ -875,7 +875,7 @@ qi2s@16 {
 
 /* TERT I2S Uses 1 I2S SD Lines for audio on LT9611 HDMI Bridge */
 &q6afedai {
-	qi2s@20 {
+	dai@20 {
 		reg = <TERTIARY_MI2S_RX>;
 		qcom,sd-lines = <0>;
 	};
-- 
2.34.1

