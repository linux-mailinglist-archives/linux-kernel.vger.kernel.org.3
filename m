Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE6652CD05
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiESH1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbiESH10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:27:26 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07A58CB08
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:27:02 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id i17so4023094pla.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aAwl0nMeiuQyulzpnQY+0Q3CMgejgrLMRz8aWvv0M80=;
        b=TCm4dq7k42XhcVURpAi98W3DD52g+rV9t2retTLhSARqOR3vx0HOSAEBHAd+IT0vqW
         NCYdc4hzFxG5KHr44IxqM2KzakWaqafx5DwQW/baXPYYt9/0/QCh0zLdjV4YDWMgaoMM
         G+7u+3OlAY3yeCssSlYR9pIe3ZnfyvvitTnK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aAwl0nMeiuQyulzpnQY+0Q3CMgejgrLMRz8aWvv0M80=;
        b=557xvodKYmsyVK7c7FqtdpoqfToFtCAWqKjqPpOeQOtRP+RVavHTsLTP83wK5/XE32
         bf7Y1WAjLwG4ngAV2Sk6bSArRU8uW2r+F7x18QVDl0+GIfL3B822W2Ap+2b4ayf6YqXt
         renuT7l9VFphB0OV75WvUGLZ3uOEHQWp/K1r6tJdvwutLa2yI5tlroes4X383mUPWmd2
         8M23wbJlUfW9fQbboQhrjLzR6tzhBzgq/J/KdTq8eQoS73NEyHe1YDmP9LSKRi4vcQF0
         1W97njlTsDCi9/G9wNOVy5iHNnQ0sdKfw0gFpUDHBlAiAE01eZ+RQ3McO46Zwexjpj4b
         8FBg==
X-Gm-Message-State: AOAM533F7Bs1mTufXAIOwD0vd9/cN6yhRqQ1q02S9C7x8LtrQhcoyr2y
        rMs5VCHlKutFt8LKrM/XGJb0ZA==
X-Google-Smtp-Source: ABdhPJwxYC9vOe2OgP9SywcJgr2vVxIIiMIGMDJNVZ/f/acPVTzBxtTzRayEoSDDSXE/IjWNvND/Hg==
X-Received: by 2002:a17:902:cf4a:b0:161:64f4:52d8 with SMTP id e10-20020a170902cf4a00b0016164f452d8mr3433156plg.83.1652945221701;
        Thu, 19 May 2022 00:27:01 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:7f93:9f84:d846:5099])
        by smtp.gmail.com with ESMTPSA id y23-20020aa78057000000b0050dc76281d8sm3296106pfm.178.2022.05.19.00.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 00:27:01 -0700 (PDT)
From:   Pin-Yen Lin <treapking@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Pin-Yen Lin <treapking@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] arm64: dts: mt8173: Fix elm panel DT node
Date:   Thu, 19 May 2022 15:26:49 +0800
Message-Id: <20220519072649.1493706-1-treapking@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the panel DT node under `aux-bus` node so it won't use the buggy
`ps8640_bridge_get_edid` to get display modes. Also change the
compatible string to "edp-panel" because the predefined
`lg_lp129qe_mode` is not working.

Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
Fixes: 689b937bedde ("arm64: dts: mediatek: add mt8173 elm and hana board")
---

 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 26 +++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index 9c75fbb31f98..1e0802a6f6d2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -90,18 +90,6 @@ volume_up {
 		};
 	};
 
-	panel: panel {
-		compatible = "lg,lp120up1";
-		power-supply = <&panel_fixed_3v3>;
-		backlight = <&backlight>;
-
-		port {
-			panel_in: endpoint {
-				remote-endpoint = <&ps8640_out>;
-			};
-		};
-	};
-
 	panel_fixed_3v3: regulator1 {
 		compatible = "regulator-fixed";
 		regulator-name = "PANEL_3V3";
@@ -282,6 +270,20 @@ ps8640_out: endpoint {
 				};
 			};
 		};
+
+		aux-bus {
+			panel {
+				compatible = "edp-panel";
+				power-supply = <&panel_fixed_3v3>;
+				backlight = <&backlight>;
+
+				port {
+					panel_in: endpoint {
+						remote-endpoint = <&ps8640_out>;
+					};
+				};
+			};
+		};
 	};
 };
 
-- 
2.36.1.124.g0e6072fb45-goog

