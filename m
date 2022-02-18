Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E0B4BB2E4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 08:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiBRHIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 02:08:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiBRHIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 02:08:06 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068681B8FFF;
        Thu, 17 Feb 2022 23:07:48 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id n24so2931920ljj.10;
        Thu, 17 Feb 2022 23:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ICMLJs7yPoKc8MCz0/dC/mtrrtYtdLA6CC0pkOG32RQ=;
        b=BDpIv2CAmYd+U0FlLnhIZ+vZwZZviZrE6dKK7nTp8bd4xKfxKHXtrD9oTS0TE755w8
         4xPAShEMGRNfljcLHO+7VbC6rjQ2PdRH8Iu0C1j+ZJzL+EIKYGZaE+wZEW7n2SR+pziA
         DjTfMVPjOTy/3+/Q9i9kfLoo2PCPMA+k7h7PfY3s9H46BDTDP8LWCM6F8IfAcuA19oOX
         SM7iVF1VoPI11Bi0YPoT8KN59vchuVtpW1lV0rYnOxQsd58mG2E+2lcNXRn+7I7djGWA
         wCf/fkbINDBzkc1sJawuLkpgYX+difvaTYuNR4nciV4VNkux/vuxKzQc4XHg3BXSfcBf
         cgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ICMLJs7yPoKc8MCz0/dC/mtrrtYtdLA6CC0pkOG32RQ=;
        b=HgPMeXHHkk0OKfR3nfYxWE5e077i+cWPn3NvBVGyOYntSheXZjZ58PLVgPnLfw9hKW
         45zpBtJhWFxIswehLkVNCAU73nAx8kVAVxf8PQ2cvfCjZqQear4gDpP/EVZgo0PuFtjL
         4uZhSJgZyyOq/XtuN9mWmpP6Fb4WiCM0ursCpvYrKaAML7AOADHB5MDwrm1EhG8B0eQf
         tXbZRVvp1TDKHvcZokHHhG3dQzpcS6hW6PuS2lQI1KLWuuJMq0pvHfWfT8PYH92HP+3d
         Nx8UjA5InETtDwuNFPJGXotpAoazPpuDCp7ZbCq3clr92xzO9bY2ays9gEruNRxWBE0Z
         zmOA==
X-Gm-Message-State: AOAM5325oZe2fCyArWgJ8lcJhntoVMUf53rT6G3RXtKv07qtCInd+KIG
        qevOXXBC24/XleP1OVgv+bQ=
X-Google-Smtp-Source: ABdhPJxfp4d9yi1hni/SD8KV1ziHSHBtA9uEDn+qWZDTbZL1oUpkV0Ewf9vhTMDPgM5kx1YsHnYlIQ==
X-Received: by 2002:a2e:8045:0:b0:23a:ee87:6849 with SMTP id p5-20020a2e8045000000b0023aee876849mr4845356ljg.248.1645168066219;
        Thu, 17 Feb 2022 23:07:46 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id f2sm216321ljn.11.2022.02.17.23.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 23:07:45 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V3 0/3] nvmem: allow specifying cells by just names in DT
Date:   Fri, 18 Feb 2022 08:07:26 +0100
Message-Id: <20220218070729.3256-1-zajec5@gmail.com>
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
  dt-bindings: nvmem: brcm,nvram: add basic NVMEM cells
  nvmem: core: add cell name based matching of DT cell nodes

 .../devicetree/bindings/nvmem/brcm,nvram.yaml | 25 +++++++++++++++--
 .../devicetree/bindings/nvmem/nvmem.yaml      |  3 ---
 drivers/nvmem/core.c                          | 27 +++++++++++++++++++
 3 files changed, 50 insertions(+), 5 deletions(-)

-- 
2.34.1

