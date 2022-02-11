Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC964B26BD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 14:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350397AbiBKNGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 08:06:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiBKNGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:06:11 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D87F05;
        Fri, 11 Feb 2022 05:06:06 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id k18so12370972lji.12;
        Fri, 11 Feb 2022 05:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P7IUs3Q1CP/C1WCkBXEDh6yMSHr4MEVXFUu5X7UWtPk=;
        b=QYrFmho/NvhXGCt33P01M3Z22kcs8vlR96aMeznYN6XLJoShr3K/U3Fd5BEXFz1JWH
         PPhVGL+3jMX/Rfu95nXqf8ZO241M8tNgv04Kj8mIptU6iqHNFAk+9EJ0dOI7MnP3qzl0
         pm/pCrHF13vHP9EOIOLJEm6AH02Ub/BISDtioARRFYGp0O7Gi6rT759wKw3uQdAfYmU+
         3a9EhFoW2SAH9eMzXcrUtMr8YFbEpJi2N6WIrg4+6fwKUmpD8NKCjezwt8qBxNlWKEcl
         TIEVFd3DnU9eaAjGW9k4DxjXcpDfWsmXUQHbucWe7COAGntI9hyIFW3M5efyE0+ke2HT
         KYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P7IUs3Q1CP/C1WCkBXEDh6yMSHr4MEVXFUu5X7UWtPk=;
        b=xOlGro/UFB75C3dM+MyHgyi+yxF4P/v6/f6Ijz5exbGLz9U1to5sLAiUE2WiioITXf
         9GN2Xh+s31a+N2IL1M/ockDBslnyN2+S1OSPN/KavdoN00z0cdwtK9KannzZWbcwaJNt
         EDIg00UCQD5n50804nxDvQsHGaJ09B6qjjMQtEVQocXOCLIMvhewOjjvzmpXieHAbzqW
         Z0HD5ZcQRf/+Hkk5spZIHS1Y1xtDNNYhExqEOQA+54+xusYAqwpHVexLajIXgD+rOSIr
         /tqla9z/3hwPm6gI46JfixMHDg3lFntduBusscyume2uhWSGXcpi63ADN3wACee4P7dC
         Zfog==
X-Gm-Message-State: AOAM532c4K3FZi+is6VU7GN664gwEIPH9uzs/XQ1QTBF+UUV+y7x8qTm
        LxDIUkndPVRUrxBOiBlBiXM=
X-Google-Smtp-Source: ABdhPJyJKyx7GAZU/4P6zTIXMpXFDR44aeYVnY/2VLW1yR/GQ1g8EMAuaGYohoHKGJIR5e8fEshzDg==
X-Received: by 2002:a2e:3512:: with SMTP id z18mr988258ljz.465.1644584765147;
        Fri, 11 Feb 2022 05:06:05 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id b13sm3111094lfv.175.2022.02.11.05.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 05:06:04 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 0/3] nvmem: allow specifying cells by just names in DT
Date:   Fri, 11 Feb 2022 14:05:51 +0100
Message-Id: <20220211130554.13062-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124160300.25131-1-zajec5@gmail.com>
References: <20220124160300.25131-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This is V2 of my:
[PATCH 0/3] nvmem: allow specifying cells by just names in DT

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

 .../devicetree/bindings/nvmem/brcm,nvram.yaml | 16 +++++++++--
 .../devicetree/bindings/nvmem/nvmem.yaml      |  3 ---
 drivers/nvmem/core.c                          | 27 +++++++++++++++++++
 3 files changed, 41 insertions(+), 5 deletions(-)

-- 
2.34.1

