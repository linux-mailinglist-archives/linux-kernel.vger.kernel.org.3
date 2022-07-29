Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA07584B38
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 07:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiG2FdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 01:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbiG2FdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 01:33:15 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAF17E33A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 22:33:06 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id w205so3721248pfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 22:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KElw61eLlKwxj7+Xj4c/fe2WkAnEdD75KF1vS/H3hCw=;
        b=V+dUhOUkEkwox3z7VTXI8K0jleX0N2fBr7eNQe0krpSetMQsJCmnCW/k5i7xFzo8oS
         zoRM1HsdBLAarjNWuxbe/Jn+jmiXSJvdA2kAL/dR0E8tcNlhKbNQ/fUe74i0u2KxNE4D
         WmR8QnCF493w/FK8xBFY2wNtqeN5fl9wB9dxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KElw61eLlKwxj7+Xj4c/fe2WkAnEdD75KF1vS/H3hCw=;
        b=SvU/8FPNKnsqZ7GNgwM0qu7bJ1G9FJNrj2bTOPW5MmuDPCgEZWmPSbHql+GwLc8NCE
         D+pgzc4tbIOJTWiETy41LQfqoW80sMg+tJ1+jCB/OyDl9L5gNqIRIrKWJRvA8t5f36Na
         yY8ilu3prOkxGkSLuOnUoVB25QqFc++Q/tFxuDKfR/htacCf3lOX/87NKIBY0OBDbqzX
         IGjuYofP9dC3GXMiQ4iIp/PATAxp2aGj27PV7wPjSNfO3MLthZMYXitzUipSRRotWZT1
         9kvDjwN3a+jqddT2aBrQMlRkfi4+zrLwMHYMupT2+LolnLAuqlcaqXENpNNotHgKIHvx
         QQvQ==
X-Gm-Message-State: AJIora/YgxEtKv1H5Kao3dmhjqZ2HqnrAgefwilE3ipnwvgl4SL/9xKi
        /5Fwfbtq5Yy1aHq1b2kIlrxi9A==
X-Google-Smtp-Source: AGRyM1thc/3FPJPxHBIe27C3oCbWb/CZ7bNvT/uFSgYftyyhmkTsNKx/WtR4DEu6RRDtx0dKyPB6TQ==
X-Received: by 2002:a63:2102:0:b0:41a:8139:2cb3 with SMTP id h2-20020a632102000000b0041a81392cb3mr1701228pgh.314.1659072780573;
        Thu, 28 Jul 2022 22:33:00 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:df93:db78:d658:2b3b])
        by smtp.gmail.com with ESMTPSA id h27-20020a63211b000000b0040d48cf046csm1820690pgh.55.2022.07.28.22.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 22:32:59 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Evan Benn <evanbenn@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        Pin-yen Lin <treapking@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v5] arm64: dts: mt8173-elm: Switch to SMC watchdog
Date:   Fri, 29 Jul 2022 13:32:54 +0800
Message-Id: <20220729053254.220585-1-treapking@chromium.org>
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

Changes in v5:
- Remove redundant new line.

Changes in v4:
- Rename the watchdog node (smc_watchdog -> watchdog)
- Correct the patch summary (mt8173-oak -> mt8173-elm)

Changes in v3:
- Remove /delete-node/ and create a new node for SMC watchdog.

Changes in v2:
- Move the modifications to mt8173-elm.dtsi and add some comments.

 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index e21feb85d822..abe3140cfcc6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -161,6 +161,18 @@ hdmi_connector_in: endpoint {
 			};
 		};
 	};
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

