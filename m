Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C045A3FC2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 22:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiH1U6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 16:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiH1U5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 16:57:40 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C4930F51;
        Sun, 28 Aug 2022 13:57:37 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id y187so5181830iof.0;
        Sun, 28 Aug 2022 13:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=yt4Ln5mavOnenD4+cxo4O1NwhU0jowj6f43C1oASLGc=;
        b=Kb8lGCpoi9ULMjoH7+Um63Vl2BgEoNyKDu1/XJnj5L3lu2ga0F3D3PfIedoFMmCrGt
         GokanMaQPm/WHcOTr8tnc/ty+LhWFdqPPKAVyJ/mOof1cb9RiEEhwiwgSogMniZv4Vu3
         Dyr+JHDPH3oy+7Of2VibMmmmg0Rnv74dFiKQ3Tz/MN2fdYBS02oWRTpTBr2RIzcFxohS
         CgMaTSPp/GTShmrViWmXwgId7s3oUHCOjgstZ+22KgufLqJO4AfKfAF41Gzh2eu3HqGc
         h4S9ZMnHTqBdH2WXg0GVpCGkvSrKPMyumtsDcHpqDxI5GXUWr09Lvt1AS8tCwcUUqMtt
         Q89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=yt4Ln5mavOnenD4+cxo4O1NwhU0jowj6f43C1oASLGc=;
        b=RdDNAYL8188hzkoN1PxyEpDZ9HfGuvbOPNOAeQTGsNIDoe+rhIJhKnqCrTfJx3rAI3
         9h6o91Le1CFYAZ51uRrdtZOxcIe2+1NaEU+wb3bGelamsi52JvhdVhyexFz9K1BNgDNk
         n7YsdZdu7xUPi8qmWcvnB/oHWHfR1N91l3sUBqG1BYnrSBfHfLW8YlnCKXb1dAXO3Lbd
         Y6Fdoddtfup9nC6w3c/eCdP4i7crQK6rcHPkmv+pL1FQaZdz6zFk9D+uMe4xMtmPeyeS
         qMSqcgdQjLtASX+nfVQq9tAXjIG16DmJfVRnJyDW/fHGT4ppjq9b4uAMmTrGWcsnnFjZ
         PqPQ==
X-Gm-Message-State: ACgBeo1Qb2naCcAg0XcTRz05KpOxWtQ6yCyYt1BabrNyRcI3tWujWjyk
        mqsCcrlZn+3p3iVBhlX7tjhi3aJOCWU=
X-Google-Smtp-Source: AA6agR5vNy6Eyx4YEGi8bcBzvZ3t+u1k+9V1F8fpQuE/+J/Q2WaN+41NTjso2y8ggZii5pisDfCcZg==
X-Received: by 2002:a05:6638:32aa:b0:349:ecfb:80a with SMTP id f42-20020a05663832aa00b00349ecfb080amr8529975jav.73.1661720256643;
        Sun, 28 Aug 2022 13:57:36 -0700 (PDT)
Received: from fedora.. ([2604:2d80:4d8e:a000:6063:7cd5:2f24:16a6])
        by smtp.gmail.com with ESMTPSA id k7-20020a02c767000000b00349be1ef390sm3572404jao.121.2022.08.28.13.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 13:57:36 -0700 (PDT)
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Subject: [PATCH v4 4/4] arm64: dts: qcom: sdm845-xiaomi-beryllium-ebbg: introduce Xiaomi Poco F1 EBBG variant
Date:   Sun, 28 Aug 2022 15:57:23 -0500
Message-Id: <20220828205723.20834-5-joelselvaraj.oss@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220828205723.20834-1-joelselvaraj.oss@gmail.com>
References: <20220828205723.20834-1-joelselvaraj.oss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce support for the Xiaomi Poco F1 EBBG variant. The EBBG variant
uses EBBG FT8719 panel manufactured by EBBG.

Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 arch/arm64/boot/dts/qcom/Makefile                 |  1 +
 .../dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts     | 15 +++++++++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index d0bba59d2a8c..a5045bd120c1 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -128,6 +128,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-oneplus-fajita.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akari.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akatsuki.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-apollo.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium-ebbg.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium-tianma.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-polaris.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
new file mode 100644
index 000000000000..76931ebad065
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+
+#include "sdm845-xiaomi-beryllium-common.dtsi"
+
+/ {
+	model = "Xiaomi Pocophone F1 (EBBG)";
+	compatible = "xiaomi,beryllium-ebbg", "qcom,sdm845";
+};
+
+&display_panel {
+	compatible = "ebbg,ft8719";
+	status = "okay";
+};
-- 
2.37.2

