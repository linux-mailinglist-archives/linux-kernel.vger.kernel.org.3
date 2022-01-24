Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B2D498425
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240935AbiAXQDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240900AbiAXQDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:03:16 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF2DC06173B;
        Mon, 24 Jan 2022 08:03:16 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id x11so50883986lfa.2;
        Mon, 24 Jan 2022 08:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ctuBSgnjTp0h/xxnaiN9/6IRGFp3kd6uhelw4DkXMLg=;
        b=Za/tb+7VG71Jko4HhFf6DhYMeUlx7XZF7QKlebw3k2gwZYkObllpj4S/mcS907m5TS
         XGQ3JnkmgNIYDxbGx4Fu8QVB/uG2K9DaIDlQzSX8mYeWSiyuIA/cPmR5mL6v4MhPr6Ym
         h6TOWqng3k2mxEXh7Nyy0lL29xrZISCZZuvGs3sUYeSaCwbAmV0umVqriVcggSMdQsZB
         7sR/DjVkA8KbSpmcyHZCySvocrjAN1AMojQwifCimpkGi2vXvELTvH8psXEcIAjbLrE4
         kn/HHpYqV6ct3PqGgLiD1Pu+0LG0BcvaZjBKUugWbMR41ibmbHeSKO87lJV3yRYoSxeZ
         Vtmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ctuBSgnjTp0h/xxnaiN9/6IRGFp3kd6uhelw4DkXMLg=;
        b=RLLdgM9KAMq5WRMXEkAVaeOvBsxIPaTK6BUKITLVCuxv+69BJ9cTsvzLKBlZR5Cbgj
         ukrcKt81Ae9h0sbvaVathH8ekDtF0fcyK8AUYMoe0f25ORM4DDVUvQQxxvvPA+JtvcEw
         ugIlYwDt5LWbk57Iu4fukSxqR0SK+H90lDwGdphKdkefmcWtoFMt6wm368X4gW09fPaE
         7SVkDSkbdoa2aj8dYTXiM8zzm2IKR12mMVJEbSdEEqm3wYOgHUdN2pAj/7FWrcr1PhaK
         O4KCL3xW3xLl06/3W0XH/Jqzz1o/280z2iUzGxWnudVydKDvfy4spk995S6X+NRIU551
         LeLQ==
X-Gm-Message-State: AOAM532Y0x26IT4MF90rVH8G3W9y1vqkxYz3zEyJrFQunyRpmirvNEP/
        SL8Jf16WgLUcIjiyWDpD9rE=
X-Google-Smtp-Source: ABdhPJyv79YN2uuThMFTQDTSpcs4BwkQtnRO1JU1cysB1134Xe2OL57Q0DwbYzNIcHd2IHtnhCN5Lg==
X-Received: by 2002:ac2:43cf:: with SMTP id u15mr5689802lfl.66.1643040194295;
        Mon, 24 Jan 2022 08:03:14 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id n21sm674187lji.18.2022.01.24.08.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 08:03:13 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 0/3] nvmem: allow specifying cells by just names in DT
Date:   Mon, 24 Jan 2022 17:02:57 +0100
Message-Id: <20220124160300.25131-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This is a simplified & cleaned up version of my:
[PATCH 0/5] nvmem: support more NVMEM cells variants

These changes will allow me to improve BCM5301X support with:

diff --git a/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts b/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts
index 24ae3c8a3..9efcb2424 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts
@@ -25,6 +25,9 @@ memory@0 {
 	nvram@1eff0000 {
 		compatible = "brcm,nvram";
 		reg = <0x1eff0000 0x10000>;
+
+		et0macaddr: et0macaddr {
+		};
 	};
 
 	leds {
@@ -72,6 +75,11 @@ restart {
 	};
 };
 
+&gmac0 {
+	nvmem-cells = <&et0macaddr>;
+	nvmem-cell-names = "mac-address";
+};
+
 &usb3 {
 	vcc-gpio = <&chipcommon 18 GPIO_ACTIVE_HIGH>;
 };

Rafał Miłecki (3):
  dt-bindings: nvmem: make "reg" property optional
  dt-bindings: nvmem: brcm,nvram: add NVMEM cell to example
  nvmem: core: add cell name based matching of DT cell nodes

 .../devicetree/bindings/nvmem/brcm,nvram.yaml |  7 +++--
 .../devicetree/bindings/nvmem/nvmem.yaml      |  3 ---
 drivers/nvmem/core.c                          | 27 +++++++++++++++++++
 3 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.31.1

