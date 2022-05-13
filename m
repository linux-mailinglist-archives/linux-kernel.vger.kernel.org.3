Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56BE526AE9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384035AbiEMUGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384024AbiEMUF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:05:56 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDA92E69D
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:05:55 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id e189so11398783oia.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/I8e8XHSj9FadDokH6BQcFNSs490tOz40Q/W3O77dAA=;
        b=XZn4TWTLD10sx+S1p65y+Xo38LIkJ1uBdSGxTOWHp5S3VFR66XDcZ90SkWK0hFBERn
         MjcPH4SgICgFKmrP7wbeDRlNxEglVhBjfgVV0e34sOXQ3ERgRNxhY2ytwP0Esj2Rwz+2
         ua4FnjAzgcmMpmDdBtJh1j0uSXo3VnwZiQFgIAcwC14bP0qxdyhh8jN90U7WZXzRvYUp
         CSqIL4A/ABA9Qq1VRYIrl/qE1bBzfJN0cPvVjqnLoRvYtKyJ6aay2TOMM97C1+eXDkKz
         Jzhtp1vjq49iLE3okqXb/UKE6JKQ2/c/eFHu62q+vsbJoSqwB9bWwbcJbVZoosQ4D64Y
         +1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/I8e8XHSj9FadDokH6BQcFNSs490tOz40Q/W3O77dAA=;
        b=KkykQ3j8nD1RIDVMlMzrIBZ/FSxi9iUGO3AoIsAStJASqj0Je5eDXdw4AE3AMOUs8R
         2lHmjdYqMLK6qDhu5v1xVIBnTMP8n37oveDi6oAcT9Mi8SxVbd5SE7yq2OIsQfQHKAQX
         ta2w1VOYb2iUhdOa7WPxH4a2AhzvXxGSK/upyR3ggt8mbFxM3Gd9GUJght+7XE0XVOWS
         vuTgP3sRxAKdvtfyKDHz9PNKE1ZY694TyQJmywLfkbw74jfvMFiYwLLHvdMuhlWLa0qY
         +MexZZ4wqx7n11AxEnnTxDYn9N7+M0Xdln4Gr49r6KeBkJB0G7vRSboVdljp7Tg+DvtG
         MuVA==
X-Gm-Message-State: AOAM530cd9115h3aQGQKrmUUN+lWOqWRRxF17o3+GKQ3gswDdXKN9Bt8
        leg+irUAezZUVxn2WSxIwZRC8w==
X-Google-Smtp-Source: ABdhPJww6k6u4X4pBs0yHlkrssPbVQ3j+fcAc2f4P7DuBf+/NsfQKqvKeZQW1JD69Hjpk5Kn3itBEg==
X-Received: by 2002:a05:6808:3098:b0:326:7275:73ec with SMTP id bl24-20020a056808309800b00326727573ecmr3081167oib.54.1652472354217;
        Fri, 13 May 2022 13:05:54 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id a1-20020a9d5c81000000b0060603221240sm1456962oti.16.2022.05.13.13.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 13:05:53 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: [PATCH v3 5/6] arm64: dts: qcom: sdm845-xiaomi-beryllium enable pmi8998 charger
Date:   Fri, 13 May 2022 21:05:11 +0100
Message-Id: <20220513200512.501156-6-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220513200512.501156-1-caleb.connolly@linaro.org>
References: <20220513200512.501156-1-caleb.connolly@linaro.org>
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

Enable the smb2 charger driver and add a battery node to report the
battery stats correctly.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 .../arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
index b3b6aa4e0fa3..1a5e127d7a43 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
@@ -109,6 +109,14 @@ rmtfs_mem: memory@f6301000 {
 		};
 	};
 
+	battery: battery {
+		compatible = "simple-battery";
+
+		charge-full-design-microamp-hours = <4000000>;
+		voltage-min-design-microvolt = <3400000>;
+		voltage-max-design-microvolt = <4400000>;
+	};
+
 	vreg_s4a_1p8: vreg-s4a-1p8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vreg_s4a_1p8";
@@ -302,6 +310,11 @@ vol_up_pin_a: vol-up-active {
 	};
 };
 
+&pmi8998_charger {
+	status = "okay";
+	monitored-battery = <&battery>;
+};
+
 &pm8998_pon {
 	resin {
 		compatible = "qcom,pm8941-resin";
-- 
2.36.1

