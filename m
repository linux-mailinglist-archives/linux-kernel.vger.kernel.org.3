Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44A1578DCF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbiGRW5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbiGRW53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:57:29 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ABA32EF1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:57:28 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-10c0e6dd55eso27841501fac.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TuU3ZOFKTE6zQTfvXEKarKiWPE5JX+FTT3FfzT9iCBQ=;
        b=AY/0VRtOeRV9Q8nkjH+TBv+HhTW5snzi7o+EV++90GW8OK6g24oBpOuU7bncIzg0GE
         g5+Tozea7Qg3BVFoH/puHPco3xA7gUk/SQdwwZ2IdKjP+X6nsJ4Dwh/u3JnNyKbfsR8e
         tWRBAQktloKA5Moqf9IJCsENzFVB3LX0XGSg7UBYSuII12BVyN/4iX9HG4Mf0lvWThX5
         KArO6pDqzF2pzLzY/dBhS/ir6kJvz0GBW1dxnaOCfF32jwQlBOKGt1TRwLHX2S+x4wRM
         YkswQA3wZaIIlwGV4lxxKhovWX0VbEa+JNbAFRlLjfPZGMp4MhUZvMqBd0AMTxQ3ITIV
         5GDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TuU3ZOFKTE6zQTfvXEKarKiWPE5JX+FTT3FfzT9iCBQ=;
        b=fk/f8rFAxA1wGEnC1mhXK2upge0CoDmT/thGtUQzgV5MsdwzW3rjuhEQAOkXLjT6l3
         5iajLn9I6Ut8rG1wcrjxbDUGO0PSIQRXGneQCt4psHDH1kcXkz09VUa2fJxEMdqNovvc
         VyUYPESWD6RkkfOaV7acAccF0WdPXBzDsIAveg0Mz2V6koUPFqOBqyg+JWtPV6qa2QEj
         V3zg6hmfkYb21rqndlUnX5lxe1CBAzXE3/FWtiwOkVQ3JygqyGOcOqQ2mPZEPEuUu6zq
         AP7i9F/JEVpTwqUW5t7GUzOjJ7o9IMrCwJ3IPK9cBFD/vTiMiJXGh9YEZqqhGWujg3AQ
         NaoQ==
X-Gm-Message-State: AJIora+xyWA2ai/mlKZNWFCm4humfNshho7Lt3KaNXfFI7wboHvJyRut
        OVMTX6+97W/+cpnMcmyCpOsz0g==
X-Google-Smtp-Source: AGRyM1snqpROytp61XxtUIrGtJTcJPBz705918qLGe1VIp81gTLAd7RoS0IPcatzgT5Z8YKN+01gIg==
X-Received: by 2002:a05:6808:1313:b0:335:cad6:715c with SMTP id y19-20020a056808131300b00335cad6715cmr14808239oiv.130.1658185047923;
        Mon, 18 Jul 2022 15:57:27 -0700 (PDT)
Received: from localhost (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id u15-20020a056870304f00b0010be09dc797sm6865123oau.18.2022.07.18.15.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 15:57:27 -0700 (PDT)
From:   Steev Klimaszewski <steev@kali.org>
Cc:     Steev Klimaszewski <steev@kali.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sc8280xp: add missing 300MHz
Date:   Mon, 18 Jul 2022 17:57:14 -0500
Message-Id: <20220718225714.8074-1-steev@kali.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting a Thinkpad x13s, we see the message

[    0.997647] cpu cpu0: failed to update OPP for freq=300000

So, lets add in 300MHz to make it happy

Signed-off-by: Steev Klimaszewski <steev@kali.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 12267feb2fc5..49ea8b5612fc 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -36,6 +36,9 @@ cpu0_opp_table: cpu0-opp-table {
 		compatible = "operating-points-v2";
 		opp-shared;
 
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+		};
 		opp-403200000 {
 			opp-hz = /bits/ 64 <403200000>;
 		};
-- 
2.30.2

