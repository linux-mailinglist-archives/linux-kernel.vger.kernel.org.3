Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0AA584A2B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 05:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbiG2DYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 23:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiG2DYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 23:24:41 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE0F7C1A3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:24:40 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso4029467pjd.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q1Lq7KUo05n519UFqiy0/X3OfMebl6UDXCVyDW4GsoA=;
        b=I7P1wkNqAl1wnv0IiLInzobHs+RGv0nqejGxMJdl3aipPlOW4KhvtWpQJOExHASTY8
         rJhHRHGKFQhjFrrIcBcgPzUkzCvOB5TWFaxBfIDbeN/pKRrQ+SEYinFFOPJsb5SVNqwC
         wVUf7dCk741hZUB5PYYMw91wQV5YmFqs5BjsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q1Lq7KUo05n519UFqiy0/X3OfMebl6UDXCVyDW4GsoA=;
        b=aEadouzQ30RL/kDFJWtORPlMSTIg8MRw+Hvx98ZPPdmj0m7uyruo7M37VR3Ha7IgXe
         B0e8KxzXa+x9UMfzjNGuYZpSj+Yvtf5K4qhjSUX+4IvqRD4JtL/mn0tS+MR3qHIa+5Rp
         44BeELXLfC++Qxo522yAeTUAE2Qy6/8Nc1UoUphDXo0b06DR9hM0AFHDmlUKn9BtD16d
         2saR4IqkOe8lsTXWnpe7lLQhuoFcA7duMHNcR96n4HL2GqeL2h+Jk0hNXY54M0zz/DJ7
         w56nIkh0MZ5i2gzSiNL/IjrwwyXXW/pJqNguS2q8/5cB10q1PaaPb9P1zoBNdDbls007
         IDQw==
X-Gm-Message-State: ACgBeo0uuYtL4FBHonZOUTl3FChL7V/j8V7XdU/4KgpUnOI4ju/xuJ4d
        jWSRzmzgZ7jMG28PWwJO3iGHIQ==
X-Google-Smtp-Source: AA6agR6SMdNRzdPmTw+V/2OYfhKP553d0oZivr6hg6YyG766ehaFPezydPvsxQrjkWWpx+F/HasOUw==
X-Received: by 2002:a17:90b:2686:b0:1f2:503c:2472 with SMTP id pl6-20020a17090b268600b001f2503c2472mr1849462pjb.187.1659065079781;
        Thu, 28 Jul 2022 20:24:39 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:df93:db78:d658:2b3b])
        by smtp.gmail.com with ESMTPSA id n5-20020a170902e54500b0016c0593876csm2145129plf.157.2022.07.28.20.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 20:24:39 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Evan Benn <evanbenn@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        Pin-yen Lin <treapking@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v4] arm64: dts: mt8173-elm: Switch to SMC watchdog
Date:   Fri, 29 Jul 2022 11:24:23 +0800
Message-Id: <20220729032423.157144-1-treapking@chromium.org>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to SMC watchdog because we need direct control of HW watchdog
registers from kernel. The corresponding firmware was uploaded in
https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/3405.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

Changes in v4:
- Rename the watchdog node (smc_watchdog -> watchdog)
- Correct the patch summary (mt8173-oak -> mt8173-elm)

Changes in v3:
- Remove /delete-node/ and create a new node for SMC watchdog.

Changes in v2:
- Move the modifications to mt8173-elm.dtsi and add some comments.

 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index e21feb85d822..421bb2945135 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -161,6 +161,19 @@ hdmi_connector_in: endpoint {
 			};
 		};
 	};
+
+
+	watchdog {
+		compatible = "arm,smc-wdt";
+	};
+};
+
+/*
+ * Disable the original MMIO watch dog and switch to the SMC watchdog, which
+ * operates on the same MMIO.
+ */
+&watchdog {
+	status = "disabled";
 };
 
 &mfg_async {
-- 
2.37.1.455.g008518b4e5-goog

