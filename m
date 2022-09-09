Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FC45B2D28
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 05:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiIIDzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 23:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiIIDzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 23:55:15 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6417940BCE;
        Thu,  8 Sep 2022 20:55:01 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id v15so221890iln.6;
        Thu, 08 Sep 2022 20:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=luAVF5aEdjvD1byneAmq5lnXjBJGV9h+Tb9rnaF2QKQ=;
        b=DPNJ0GZianmjCYdjstfUTn0ZmA+DvgwSZSek/P6nB2oFj7hr9jRPptwui2aj01GFLJ
         n0UIeO/pkMDqyssxsydEevhDEkCJ090n4Gc9H9TCpsiEV44yXC4/Pbrg4d554ZIipBxJ
         b9HDdFmk9I5DJOaGHVKxTNASIkLFs79UtYxRTywTngKWsT3WV2xxJqJTrNENJzVw9aAK
         z/IZcfEb8cVe18KhAn4EoVMCE8kmIiiiqXh+UinYHW/eXhWF1LhovqBtf3WHUjjvrPX+
         8ryGxtJLpkeMP6DR49GZCNmBtTEAXi+iX+Qhgewd5DMcFqoro1PWYEdtdQ3tipIDS95E
         TDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=luAVF5aEdjvD1byneAmq5lnXjBJGV9h+Tb9rnaF2QKQ=;
        b=LHJ0hOGofN3XAXK7eZheVddkHQexnTd+bIvnFCdTl838+gUDnPN93yNuTiMz7IkqJO
         lPPV/p1ZiMaNKG0ACk578C2qKAQ4yUpC6ECJ3H1fu4N11Q3WmVakP5RviHulGpMFgyhB
         LsiqUVh5kcXjSkV+08V2qWYURkOzHTE1vThaOZ+LWyxbZ0NEurkKZFn0oF51CN0mhP48
         VFuH94il3Gm7TX95nlKGwZdOe8C87WB3KsVZxee7TF/977NXf5MkOIklFCXjAc03Q+tr
         jXM7TV5CDgo7CwwSb5E89oCgNp3y4RtryS1qmdPUQ+peWm3W9hjR64zIaLTeTnTXd7kp
         X+8g==
X-Gm-Message-State: ACgBeo1PU+2aTBoikgi2W8Ce9I5T+jw2nJIAB+hRUkvFSXdUYetTaSaJ
        qobD2R/6nn29tpxqyKqQKvU=
X-Google-Smtp-Source: AA6agR42wPOdRNb1nMDzyXsFBo2JCHRxCP0NFAlpug4chL6u1jetlLY7a3mEcUY7XtKf3+Nt5lHLEw==
X-Received: by 2002:a92:cd0d:0:b0:2eb:e4a:2d4a with SMTP id z13-20020a92cd0d000000b002eb0e4a2d4amr3350218iln.309.1662695699618;
        Thu, 08 Sep 2022 20:54:59 -0700 (PDT)
Received: from fedora.. ([2604:2d80:4d8e:a000:6063:7cd5:2f24:16a6])
        by smtp.gmail.com with ESMTPSA id n28-20020a02715c000000b00346b4b25252sm330579jaf.13.2022.09.08.20.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 20:54:59 -0700 (PDT)
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
        Joel Selvaraj <joelselvaraj.oss@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 3/3] arm64: dts: qcom: sdm845-xiaomi-beryllium-ebbg: introduce Xiaomi Poco F1 EBBG variant
Date:   Thu,  8 Sep 2022 22:54:47 -0500
Message-Id: <20220909035447.36674-4-joelselvaraj.oss@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909035447.36674-1-joelselvaraj.oss@gmail.com>
References: <20220909035447.36674-1-joelselvaraj.oss@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
2.37.3

