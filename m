Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2BC52369D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245563AbiEKPCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245517AbiEKPB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:01:27 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3517613CF1;
        Wed, 11 May 2022 08:01:25 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id h3so2181158qtn.4;
        Wed, 11 May 2022 08:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/p0jhonpzsgi74YqARQEXL9lrrKHBla95qJazaJgr3s=;
        b=BJmy2dB+d2RHnTR/+SRqn1ptD74kwKMdN6sSgOFZsfJjuf5/PVYosyUm3LlOCPlMFR
         xBDCyeIY99K1xAddubsk741JQCN3hourJw6iG275BFJrerTRQdQVUxLS69HhY/SI9NAz
         FLVstBCzDJThwbkKWybmR/RdX3ppIX2OxD7tLy87+uSpvovuMjL87t9S1zyCBlzmMCJv
         gviYJnwsedSZQE0tgwYEXxlQVtXloqUBua6QfLj+0dAuKe+Qf+mVmKC8hYk4uRRuZufu
         O+HGfMwPMaYPnuo2fJerulgU/Ah46NryDCdYkWs4/B6EChNLZnnFTNWBijbEUrcGOKEw
         X/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/p0jhonpzsgi74YqARQEXL9lrrKHBla95qJazaJgr3s=;
        b=Xoz7V3L7dXQM6Pywfp7Lm+X681R797dBerMhtGlMf4OLE5pMQKNGLp3Aq+5vMZbKJS
         evkrABhTSgy6PwVV285oIaaKwUd8Z74qs3k8dXs5iwUkvt+82To8ca4LZrC+j7nD6avA
         qv7i6yPZJrvmV9El5TRgewcCqX/yFoIELID+YqBEYLfdo+IRfd0nknlt1Bt3J5RAUq0Q
         jz03YuNd3Inyla2gTgCJU6eRH1UO3CzmFfnolFoGDM3X4jHi6BiKIrNUHAp+RvDiwTnj
         gM3it1G55/5e0Jvq//S9KAExT/lzatPUYifHW/A+Em3bycQ9qK9gQmyuLHVMGZsE1k26
         MWcw==
X-Gm-Message-State: AOAM533o3FPAms/vbyQX9TXcQaJb7wSgucJhKtPXWqWdigLjAsPcvMRf
        6U9cq/YS3pv5nJ2FUZ84EMQLx0vLl9qRgg==
X-Google-Smtp-Source: ABdhPJx7y9paqwB+ewp1H9nKH7hMjdilX7MzvMntMscQO9+8ooGtPXzRO592Y2gkVK+bnXkFE5M7tQ==
X-Received: by 2002:a05:622a:1793:b0:2e1:ba41:ed2 with SMTP id s19-20020a05622a179300b002e1ba410ed2mr24321265qtk.238.1652281284233;
        Wed, 11 May 2022 08:01:24 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id h1-20020a05620a244100b0069fc6484c06sm1487134qkn.23.2022.05.11.08.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 08:01:24 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v1 4/6] arm64: dts: rockchip: add Quartz64-A fan pinctrl
Date:   Wed, 11 May 2022 11:01:15 -0400
Message-Id: <20220511150117.113070-5-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511150117.113070-1-pgwipeout@gmail.com>
References: <20220511150117.113070-1-pgwipeout@gmail.com>
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

The Quartz64 Model A fan is bound to a single gpio. Prevent pinctrl
issues in the future by binding the pinctrl assignment for the gpio.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index ca0b92795d95..991b7b1b8443 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -32,6 +32,8 @@ fan: gpio_fan {
 		gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
 		gpio-fan,speed-map = <0    0
 				      4500 1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&fan_en_h>;
 		#cooling-cells = <2>;
 	};
 
@@ -510,6 +512,12 @@ bt_wake_l: bt-wake-l {
 		};
 	};
 
+	fan {
+		fan_en_h: fan-en-h {
+			rockchip,pins = <0 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	leds {
 		work_led_enable_h: work-led-enable-h {
 			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.25.1

