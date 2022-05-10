Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F71A5215EB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242002AbiEJMyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242046AbiEJMxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:53:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CC42AACD7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:49:52 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id j6so32698406ejc.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XtfJqDS+4XXgrs5gmHjTVbohIpUyumGa7vczR+1IPgQ=;
        b=MtwpI+2Y5HHkHJRTxU0bTMeMgxlQ89RWSAek/hDu5ToZQHYAkXe020B+GyXG2ogIKk
         LRkAQqDAZCAqhH18aLooifUpeBeuvyo2+Netpbe3chzAmzfNezno3p9nnKT5OFu9W66M
         TfAZjqoARfpu6x5SlEKyG5goXsAJCNTDslQQWZu3hPy+PMxBBRN/gpHXyHXO3tgu/rLb
         XMQsrwaPRBGG349iTOJAvZrZx5T/rTKyGUW99Tg+En1YYpFKdpN8BMIsb+PfBOOhdHjy
         eTALzE/XKmlAudm7xZ2+8FjlqpBGIOeRlUn0nzRizlo2+q87XZxIv8BYnT+tflS2tQ8u
         uJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XtfJqDS+4XXgrs5gmHjTVbohIpUyumGa7vczR+1IPgQ=;
        b=qxAO3+Q+vi6Yny0pf5sdK0TJPNXkTx+B0JopC6hQnf6CvwNISc48OuLxWNeQfu7eBl
         8fmLPOeQJyeGlQUyhxyGQ9vugGLh4YyaP2M4E2owf3iaskR4mh2WjqVurZKlVTMBX2eu
         0+D19H7KWL4tW88Rw/ldwsAAOa83K/2HWwwstfjqp6F3j4+FAxw94usjtcNWGgbEJ5wv
         fB3scctfmg97D7HsUFVIXY2eXmGRhSYpLHhNem1L48gVh5TQdTAqqi9lkv2LIokemkgs
         20mFIjScQohm0ZZag+DFzJd6CO5SFWbtUrZW8TsFX6vSiyUJSwCVXO7Qd04BhpFKS3wy
         S5XA==
X-Gm-Message-State: AOAM531zPy+gkmKYHJ3DMp9E8SAHtWUsHN97xwavNV14lCCORgrHsbco
        nIIOCcUTInFvy+qGG8+p1jIRUw==
X-Google-Smtp-Source: ABdhPJwY4NsSUB0SG/B2GLVRkNn53wLuF+nbmvKCJINUUfI9kskdAVTgJ7SQN1hLXtMMXsoZ++Xefw==
X-Received: by 2002:a17:906:a08b:b0:6cf:65bc:e7de with SMTP id q11-20020a170906a08b00b006cf65bce7demr20001419ejy.220.1652186991862;
        Tue, 10 May 2022 05:49:51 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-75-cbl.xnet.hr. [94.253.144.75])
        by smtp.googlemail.com with ESMTPSA id gz14-20020a170907a04e00b006f3ef214e62sm6094290ejc.200.2022.05.10.05.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 05:49:51 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, pali@kernel.org,
        marek.behun@nic.cz
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 11/11] arm64: dts: marvell: add support for Methode eDPU
Date:   Tue, 10 May 2022 14:49:29 +0200
Message-Id: <20220510124929.91000-11-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220510124929.91000-1-robert.marko@sartura.hr>
References: <20220510124929.91000-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Methode eDPU is an Armada 3720 powered board based on the Methode uDPU.

They feature the same CPU, RAM, and storage as well as the form factor.

However, eDPU only has one SFP slot plus a copper G.hn port.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Changes in v2:
* Make the DTS split a separate commit
---
 arch/arm64/boot/dts/marvell/Makefile             |  1 +
 arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 1c794cdcb8e6..104d7d7e8215 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Mvebu SoC Family
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-eDPU.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-emmc.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-ultra.dtb
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
new file mode 100644
index 000000000000..57fc698e55d0
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "armada-3720-uDPU.dtsi"
+
+/ {
+	model = "Methode eDPU Board";
+	compatible = "methode,edpu", "marvell,armada3720", "marvell,armada3710";
+};
+
+&eth0 {
+	phy-mode = "2500base-x";
+};
-- 
2.36.1

