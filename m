Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DA65237C5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344040AbiEKPxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiEKPxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:53:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1C96FD21;
        Wed, 11 May 2022 08:53:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dk23so4927474ejb.8;
        Wed, 11 May 2022 08:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ChBlo8JgQztQyDOjW7CP34CCFtQT8Hz2+dkYQmQof/E=;
        b=nS/TpcRwwFbflyet94bFc5CcjxVk6t+j5NOxzBIdlm7hFfnejEQ8BOzTywqf4YVfAu
         m2A/gL/WWUrYgsduw7j6fczHanwiY8cEZorN6VhHQ1fGKx1ZBrZ6I1LcwYufNn7CqR8U
         /HHJQrGPO9Lx/xcdmPoGwbKUtbcZ1V+ToVFnBHHq75nGjZ6s1oF4fH4WUS0G+AmFOCub
         pD1qQCaNC2yCwS2gSNfVTvr70v98+/W58T4G9hQajqW70Gnj5ivXCs650AtLPwoZxLSA
         S1pspjYl3XFJsIxwdmGD115D0QyHJIjAmb4dDTUFlkZ+ov8Q1w+7zOUBOdxKUHl6sznT
         20uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ChBlo8JgQztQyDOjW7CP34CCFtQT8Hz2+dkYQmQof/E=;
        b=xWcrVYJezqIA84/PP4JXm7wzuA+mG7RLSyQroaSbhaY0BWoY3iTq6qP6KX5Z8aiLVY
         +CVk+z1jrxkYoRLkY47wZ7YwRSqLWrIinNv9o52w0bnqegBLM/ZlSFSp7g/gwXVuAyAL
         pwznuivZ4QeUBhpgldtuSVp5XeNb6TDt4fRzsruPygCPnHDStb2t528NvMGbWmz+zi5/
         7r3t0r2J66ySBsyFdO8mJRzISmoINef/Tz4C9k52DbSFKWVK+wgfSgWF/R9MeNewi2yF
         dxb2huarOY8gQRK9AIW1OvXwfuaK4U4iX6aQh9RjRiedelKaYfbScZkC5ST3UkOE1mI+
         2XAg==
X-Gm-Message-State: AOAM531Cbm5P8H1WGhy+1X2JrFl2wMQTB1dc82KvVq1WqvmIEBLc5LuR
        7oEBX6zFc2Jk1LQ7H31FCC0=
X-Google-Smtp-Source: ABdhPJx+gLv9qZMLtZ6TZVHw/+QL36jRAthkyIcW+H3mR5CsVPUeHqXkxzrfYIjIcR+1soMD/SYmlQ==
X-Received: by 2002:a17:906:4313:b0:6b8:b3e5:a46 with SMTP id j19-20020a170906431300b006b8b3e50a46mr24525324ejm.417.1652284408880;
        Wed, 11 May 2022 08:53:28 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id fb21-20020a1709073a1500b006f3ef214e1fsm1072458ejc.133.2022.05.11.08.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 08:53:28 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Liang Chen <cl@rock-chips.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v3 0/3] Enable JPEG Encoder on RK3566/RK3568
Date:   Wed, 11 May 2022 17:53:05 +0200
Message-Id: <20220511155309.2637-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Hello,

the following series adds support for and enables one of the hardware
video encoders on the RK3566 and RK3568 line of SoCs by Rockchip,
initially just for the JPEG format in line with what the kernel supports.

The encoder block is separate from the Hantro decoder instance, as they
are in different power domains and have wildly different memory addresses
as well.

The encoder hardware seemingly also supports VP8 and H.264 in addition
to just JPEG, as is evident from both the downstream vendor stack and the
register listing in the TRM. The hantro driver in Linux, however, does
not yet support encoding these formats.

The first patch modifies the bindings with a new compatible, and adds
the ability to just have a vepu interrupt without a vdpu interrupt.

The second patch makes the actual driver changes to support this variant.

The third and final patch makes the necessary device tree changes for
the rk356x device tree file to add both the node for the encoder and
its MMU.

The series has been tested on a PINE64 Quartz64 Model A with an RK3566
SoC using GStreamer.

Below you'll also find an interdiff against V2.

Regards,
Nicolas Frattaroli

Changes in v3:
 - bindings: change consts to an enum
 - bindings: add check to make sure devices with a -vepu compatible only
   have the vepu interrupt

Changes in v2:
 - rename compatible as it's not JPEG only
 - rename device tree nodes as it's not JPEG only
 - reword commits as it's not JPEG only
 - get rid of a whole bunch of redundant struct definitions, as, you
   guessed it, it's not JPEG only

Nicolas Frattaroli (3):
  dt-bindings: media: rockchip-vpu: Add RK3568 VEPU compatible
  media: hantro: Add support for RK356x encoder
  arm64: dts: rockchip: Add Hantro encoder node to rk356x

 .../bindings/media/rockchip-vpu.yaml          | 17 ++++++++++++-
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 21 ++++++++++++++++
 drivers/staging/media/hantro/hantro_drv.c     |  1 +
 drivers/staging/media/hantro/hantro_hw.h      |  1 +
 .../staging/media/hantro/rockchip_vpu_hw.c    | 25 +++++++++++++++++++
 5 files changed, 64 insertions(+), 1 deletion(-)

Interdiff against v2:
diff --git a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
index 4045f107ca4e..965ca80b5cea 100644
--- a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
@@ -40,8 +40,9 @@ properties:
 
   interrupt-names:
     oneOf:
-      - const: vdpu
-      - const: vepu
+      - enum:
+          - vdpu
+          - vepu
       - items:
           - const: vepu
           - const: vdpu
@@ -78,6 +79,18 @@ required:
 
 additionalProperties: false
 
+allOf:
+  # compatibles that end in -vepu should only have the vepu interrupt
+  - if:
+      properties:
+        compatible:
+          contains:
+            pattern: "^[a-zA-Z0-9\\-,_.]+\\-vepu$"
+    then:
+      properties:
+        interrupt-names:
+          const: vepu
+
 examples:
   - |
         #include <dt-bindings/clock/rk3288-cru.h>
-- 
2.36.1

