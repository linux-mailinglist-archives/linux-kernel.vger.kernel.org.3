Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605CC476FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbhLPLNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236597AbhLPLNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:13:37 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766B3C06173E;
        Thu, 16 Dec 2021 03:13:35 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id e128so34674757iof.1;
        Thu, 16 Dec 2021 03:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ngy9rc2lnHFALnsut5yFmaAU5ic1KlzWDnYFN5A5oo=;
        b=Dne/SpwcvjpRKm5srJeQ9Ar04r7jqdyMJ2ZZiIKRABnZOfi+3qHSXgwn4U8lY3PBJm
         rOsGdzjeaWcJamkIFtSx163EgpBWtJXhFktPFJ1gMkwyLZd375N3WUtX5XU6B2oTC8vm
         1f0mE5+OHgCATmoATBClF6xJeaUsrQVnSy8AeduBIzS0Q27jIaK/1IStA0HHgxrU3frn
         zBqojD0G5cXfISEISthE2vxn7kpc7nJSheLaVNA1FhzzJ9AxSWf5iXLp78rRBAmWWVyi
         CStbtXPejxNat95kOl936dDpyKoo3fjqakYuZa8jlNDWHNETWzY1ym8pmMJarwu5SPlY
         TwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ngy9rc2lnHFALnsut5yFmaAU5ic1KlzWDnYFN5A5oo=;
        b=ii5R0rifrN4izvVDHhQLLHw/VGJuuIStXwWz6H/4yJoUoyYfrFzYn1AcBjjA8bg0NQ
         zPOf5HqBRcJLkxKKqgGPO0WBb0FiD8F+r86DAhgtOLF50sIfis4h/+2CdXiLA9AAKIA7
         BwPcd+I2IoC0R2gL/zvBax4XbLUlrusnNU0VlCbFclfVJ/TREatHheER06uigHNYmOny
         GyxQijd3yVWFxEG7pR4wDGUh6+ZCUjPeAw5g8n2mILRgEATIQtnX3on5VpaeMD6YMK7c
         0uWsA9GskLDdnvXgQD0EPj87LBEQcjr1eDgRRV11uWno/QXirIwacIw8ypQmjwUlQLJR
         6RqA==
X-Gm-Message-State: AOAM532ZhvDbDy9H0NsaKNd8OQ7n/X822tjvZRmRRQXjrpoeLKb3P/4x
        pRmyJQ6IOpogC4p3wPLyDexv8eWvHOmdPVw2
X-Google-Smtp-Source: ABdhPJxp63NTtIzWmw3lwPxLVW9gaysSC0gL0ZZVedy//NMXJfPGRMsPn0mRZLr44Ui/BF0Bw/yQVA==
X-Received: by 2002:a5d:9f44:: with SMTP id u4mr8904307iot.163.1639653214508;
        Thu, 16 Dec 2021 03:13:34 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:fe22:1652:55f7:5197])
        by smtp.gmail.com with ESMTPSA id h1sm3090946iow.31.2021.12.16.03.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 03:13:33 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     abel.vesa@nxp.com, aford@beaconembedded.com,
        benjamin.gaignard@collabora.com, hverkuil-cisco@xs4all.nl,
        Adam Ford <aford173@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH V2 08/10] dt-bindings: media: nxp,imx8mq-vpu: Add support for G1 and G2 on imx8mm
Date:   Thu, 16 Dec 2021 05:12:53 -0600
Message-Id: <20211216111256.2362683-9-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211216111256.2362683-1-aford173@gmail.com>
References: <20211216111256.2362683-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M mini appears to have a similar G1 and G2 decoder but the
post-procesing isn't present, so different compatible flags are requred.
Since all the other parameters are the same with imx8mq, just add
the new compatible flags to nxp,imx8mq-vpu.yaml.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
index c1e157251de7..b1f24c48c73b 100644
--- a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
+++ b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
@@ -5,7 +5,7 @@
 $id: "http://devicetree.org/schemas/media/nxp,imx8mq-vpu.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: Hantro G1/G2 VPU codecs implemented on i.MX8MQ SoCs
+title: Hantro G1/G2 VPU codecs implemented on i.MX8MQ/i.MX8MM SoCs
 
 maintainers:
   - Philipp Zabel <p.zabel@pengutronix.de>
@@ -20,6 +20,8 @@ properties:
         deprecated: true
       - const: nxp,imx8mq-vpu-g1
       - const: nxp,imx8mq-vpu-g2
+      - const: nxp,imx8mm-vpu-g1
+      - const: nxp,imx8mm-vpu-g2
 
   reg:
     maxItems: 1
@@ -66,3 +68,27 @@ examples:
                 clocks = <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
                 power-domains = <&vpu_blk_ctrl IMX8MQ_VPUBLK_PD_G2>;
         };
+  - |
+        #include <dt-bindings/clock/imx8mm-clock.h>
+        #include <dt-bindings/power/imx8mm-power.h>
+        #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+        vpu_g1: video-codec@38300000 {
+                compatible = "nxp,imx8mm-vpu-g1";
+                reg = <0x38300000 0x10000>;
+                interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&clk IMX8MM_CLK_VPU_G1_ROOT>;
+                power-domains = <&vpu_blk_ctrl IMX8MM_VPUBLK_PD_G1>;
+        };
+  - |
+        #include <dt-bindings/clock/imx8mm-clock.h>
+        #include <dt-bindings/power/imx8mm-power.h>
+        #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+        vpu_g2: video-codec@38300000 {
+                compatible = "nxp,imx8mm-vpu-g2";
+                reg = <0x38310000 0x10000>;
+                interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&clk IMX8MM_CLK_VPU_G2_ROOT>;
+                power-domains = <&vpu_blk_ctrl IMX8MM_VPUBLK_PD_G2>;
+        };
-- 
2.32.0

