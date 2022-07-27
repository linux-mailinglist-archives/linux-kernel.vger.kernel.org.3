Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E843582359
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiG0Jkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiG0Jkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:40:43 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF9C1EADD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:40:41 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q16so15467011pgq.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p3g9EzZvah+Gtbwyip2cq8Rx7bbD/kksWxXGuqDH5TY=;
        b=OLy9K64vZZHKw0I+myiumXXJ327EZ4fO3D1r2oechF169QBzjqFtMoDj48XCEzguWr
         Jf+Vw4UDazDGZvOY6ulcOQMnzjr3gM7TZ65azJMCxSOLoX0azoax7Mq01l2x97ykNL6a
         yCfBTrocZQzWSIkV5wODMg/0o8THtuU51HUO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p3g9EzZvah+Gtbwyip2cq8Rx7bbD/kksWxXGuqDH5TY=;
        b=1H1U0ANekrymrFm5EwHhSFB3DDqpL16QsO1kfnQgGSzDmyMuoim0AJXU15WowxO99/
         81Gr3pQ6pEWIiLY3pQfVlpulFXg4XGKbNTYhPUwY4G9catN79V4E4dM1ZFinVoI0EzD+
         NnuSVDRpusTyUA7k4UML61Sdb7ac6Mjaf2IaUP4Itbz7SVJE+tXbjFZp0t+veRZYwkEX
         mELNxjKACX9CWqem9ScWdB478eXIyAPa7/3RXzsw2V3XSjGT0cj9WSiUGSoFoJN7NgEZ
         UbJI48dAzDIEBGg+AJ52uEL2vXF058J/LhPWNaUIIp80ysQviNdT/kmaYdT5lpc35vph
         VuIA==
X-Gm-Message-State: AJIora/ygZkEZZ//dSLAodT6ZrYdS2hGmn18+9hvttt6/DCGga0k8upd
        xFU09/+S/z6e/SJRiL+WOLmajWiw9lb/Hw==
X-Google-Smtp-Source: AGRyM1vGMx/eXGTZ84c6OPRVIy6bKdnF7BHfGiWW4X9zD6FGDwvusPvwvbJ1cKMBXJc6IoBM5UTbWw==
X-Received: by 2002:a63:6b83:0:b0:41a:8419:c20b with SMTP id g125-20020a636b83000000b0041a8419c20bmr17730751pgc.522.1658914841179;
        Wed, 27 Jul 2022 02:40:41 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:8dc7:aefe:3b5a:da1e])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902784900b001678dcb4c5asm11775613pln.100.2022.07.27.02.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 02:40:40 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Eizan Miyamoto <eizan@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Evan Benn <evanbenn@chromium.org>,
        Pin-yen Lin <treapking@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2] arm64: dts: mt8173-oak: Switch to SMC watchdog
Date:   Wed, 27 Jul 2022 17:40:34 +0800
Message-Id: <20220727094034.1372745-1-treapking@chromium.org>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Changes in v2:
- Move the modifications to mt8173-elm.dtsi and add some comments.

 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index e21feb85d822..b2269770abc3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -161,6 +161,18 @@ hdmi_connector_in: endpoint {
 			};
 		};
 	};
+
+	soc {
+		/*
+		 * Disable the original MMIO watch dog and switch to the SMC watchdog,
+		 * which operates on the same MMIO.
+		 */
+		/delete-node/ watchdog@10007000;
+
+		watchdog {
+			compatible = "arm,smc-wdt";
+		};
+	};
 };
 
 &mfg_async {
-- 
2.37.1.359.gd136c6c3e2-goog

