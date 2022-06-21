Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F16552E18
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346726AbiFUJTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbiFUJTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:19:07 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857991AD95
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:19:06 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so11485912pjm.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZvxtssIvtoFYupLWVv54BPyYcFNiA1KS9aQ8n/ctA2Q=;
        b=n3yhQ6//sI9yfp1kIIQmNjWtnyhxQuTa2xKTjM8m6xRI/oiBqkW31cHcqOC11Lhpqn
         ZR82ouc1zYSWgcx5ZRsGjxx4uU638SPXtbgBbBmzXY2S3rbqyJCOFiTQI7iNreAGmaCv
         jt/wSztc8LZ5TuZBgfzzKuxhRKWjgnJSLwoGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZvxtssIvtoFYupLWVv54BPyYcFNiA1KS9aQ8n/ctA2Q=;
        b=xfElYrsA1qj9fQ8z/Ewm6qzhfC4UPf4mJUEpLSSNCzkWGzOXtGh3qZNPH123J6e3Yz
         ZA2huWNGb4DnSMga4bE2h3iGtUbu82k2ZmYg9oKVkkJts7VOlGcjzavHnwYMlqnn2eqJ
         y0WR0Y2dRsjuNmTnZIEyuJCZpuXa+tLAR5geHu4Ac+RF0CG34eqFdCd7BRNdBfR0UB4p
         zfORTo/7/GmWk8oN9G+z5+y7NX137yE8u1OtfoPiXN9DVIZyqQzMY+kWeGTi2P97VgD3
         vyyqa++2+6uER34kyjgPTccqNsGFphgwZXARsJ/Mv6XrBZUzV52bthnj1+U+SEU1/h0s
         0rDg==
X-Gm-Message-State: AJIora/0R2s5KAZFO/ulgjtjUFAM4FpmijOVFpYPVh+akSW5vXpm7KQj
        xfjQwNCe3Olq38KY40Pw6GqxmQ==
X-Google-Smtp-Source: AGRyM1vipYtXDQ0CAyWWxu+6Zvss+Qgr3C2OF6dNknVLJ4sz55B3xVInH5siiLugsmdohehcRfEjfA==
X-Received: by 2002:a17:903:22c2:b0:16a:3039:adb1 with SMTP id y2-20020a17090322c200b0016a3039adb1mr5619291plg.28.1655803145681;
        Tue, 21 Jun 2022 02:19:05 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:88f:3824:fbf6:53ef])
        by smtp.gmail.com with ESMTPSA id v1-20020a62c301000000b00522c3f34362sm10609720pfg.215.2022.06.21.02.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 02:19:05 -0700 (PDT)
From:   Pin-Yen Lin <treapking@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        Pin-Yen Lin <treapking@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v3] arm64: dts: mt8173: Fix elm panel DT node
Date:   Tue, 21 Jun 2022 17:18:54 +0800
Message-Id: <20220621091854.1904372-1-treapking@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the panel DT node under `aux-bus` node, so it won't use the buggy
`ps8640_bridge_get_edid` to get the display modes. Also, change the
compatible string from "lg,lp120up1" to "edp-panel", so the panel-edp
driver gets the displays modes from the EDID instead of using the
predefined display mode (`lg_lp129qe_mode`) in the driver, which is
actually not working.

Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
---

Changes in v3:
- Include more details in the commit message.

Changes in v2:
- Remove the Fixes tag because this change is not compatible with the
  old kernel versions.

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
2.37.0.rc0.104.g0611611a94-goog

