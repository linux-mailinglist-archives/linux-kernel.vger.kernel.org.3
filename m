Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086D758B85C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 23:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbiHFVCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 17:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbiHFVCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 17:02:47 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BA311833;
        Sat,  6 Aug 2022 14:02:47 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y141so5078256pfb.7;
        Sat, 06 Aug 2022 14:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LnCYxidkbqPSIhSju2tTZKFe01JSQbzeOLwbX11AAGA=;
        b=X4SjB28poocY80XBxfAS4UQBWvh89vlmp+kEbdLqdAy34xD/m9ryGH0elE2B5WsBml
         FrmXfF6fR/rBexMEuo7zWEmANf4o6Ww9TkRuC9m8gsfA3iNd7olBmUWaIR4+rdO0g7GC
         nkyMEg8u66d8Y5QW/8s/phgRzZDLTl72bV/HtpgI1y32PsSKGi7XJI6/vYSUJtjc7YUp
         sbDUeKedHgmjiPXhr4sa0oVagt/Rvt7HfmESQNeq9S3zVS6teThicb8+zVAJWO0jRDbI
         oci44NiGNZo1+IWJwx5Z2ks5FfOKVevJ0TahJRqUH2p/NjErWXe4IQ/SxN7+6RTYJzwm
         f6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LnCYxidkbqPSIhSju2tTZKFe01JSQbzeOLwbX11AAGA=;
        b=MB3qMRjkf7biLzieJSGB2fg8TCvd1Mtvw35pVnfR28Z7oWai/D982+BtqQBKFhkycl
         KRmQqFe5nchhqfz5iXcl6aDfmYrLmmXqm1fkUOZBNbroRQiExS7YrjV9/pHMRaY4ya/P
         OpXzSpIXUwdquUR9ynI6citG6+pb/L5WOL0ZtT5o/Azf3myRGtNISFCnRrIK/kUmDbHn
         qT3GJio8A4werC4TZT3kwpHe3GG5F7rVXLjTBU8pFX+NIviGMb48ujD6zr/B3ItkeaJc
         hPLkytJtZ/TW8A1c0sTzKM5hG/qHDhMUu/+oZDHvpR2kJe055Xc/iI5APwo0BVXK9g2S
         j8nw==
X-Gm-Message-State: ACgBeo0CTs/vnGulmqcPnA+xBHAzS6G6O8H0lN/BgoDfjfa84yL7lWvY
        HBES1a1V5wvWUvh8QvGecL5T1EgxwmFiEg==
X-Google-Smtp-Source: AA6agR72Gz7vEJVNeKZ1E7yqvPrB0xhFZbxFctqWWpBUcJkuh50bKes31Khl2Vt0d/VyttYOzZOrqQ==
X-Received: by 2002:a63:6a41:0:b0:41c:86b0:596b with SMTP id f62-20020a636a41000000b0041c86b0596bmr10045444pgc.582.1659819766925;
        Sat, 06 Aug 2022 14:02:46 -0700 (PDT)
Received: from fedora.. ([2405:201:e01d:6040:3f6e:eaa:537b:816f])
        by smtp.gmail.com with ESMTPSA id c203-20020a624ed4000000b0052ea306a1e8sm4538815pfb.210.2022.08.06.14.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 14:02:46 -0700 (PDT)
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Subject: [PATCH v3 2/2] arm64: dts: qcom: sdm845-xiaomi-beryllium-ebbg: introduce Xiaomi Poco F1 EBBG variant
Date:   Sun,  7 Aug 2022 02:32:20 +0530
Message-Id: <20220806210220.31565-3-joelselvaraj.oss@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220806210220.31565-1-joelselvaraj.oss@gmail.com>
References: <20220806210220.31565-1-joelselvaraj.oss@gmail.com>
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
---
 arch/arm64/boot/dts/qcom/Makefile                      |  1 +
 .../boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts     | 10 ++++++++++
 2 files changed, 11 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 02db413b228c..29f15031a199 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -106,6 +106,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-oneplus-fajita.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akari.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akatsuki.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-apollo.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium-ebbg.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium-tianma.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
new file mode 100644
index 000000000000..1e0be481b9da
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+
+#include "sdm845-xiaomi-beryllium-common.dtsi"
+
+&display_panel {
+	compatible = "ebbg,ft8719";
+	status = "okay";
+};
-- 
2.37.1

