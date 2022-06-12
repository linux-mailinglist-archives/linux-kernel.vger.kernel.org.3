Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AE2547AC0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 17:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237452AbiFLP0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 11:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiFLP0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 11:26:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CF5E0C8;
        Sun, 12 Jun 2022 08:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655047571; x=1686583571;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Q0onuyl5eTrkYqFlMMv+/M78rN5v5VPQYnAPHZB5rCM=;
  b=hNhS8io2Jt1g6wJG0d0Df4uOYMkEgpquUUWMD22X+rHtx3ytuvkJjg+n
   PKe0oYCBkydT4EbKyqnCdYNFU43M0AZA/yJtOw0oWTYn/hqF0htBXPVAd
   ldYaGD57PdFbpBuyk6cxGd/mEDzYuWxaRuG6S6T3nS5g72yctPungppT0
   vqDLWVfzfaZrzqe6b6p1rHopVIvyVhaoZEmIifDLeBk7zK7boN+yetjEm
   5cyvKVLLY9ZtLwa68LgeRVlEsbdLXZVddGxKa02OQDa7GlscGmjmy/OLa
   TQpFKfpxcCN5P0WApuGiHjsSIP5uQlLRgxUnoayEawrO/e1Swx0p5qu7u
   g==;
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="99654529"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jun 2022 08:26:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 12 Jun 2022 08:26:10 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Sun, 12 Jun 2022 08:26:06 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <UNGLinuxDriver@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>
Subject: [PATCH v3 0/3] Add support for lan966x flexcom chip-select configuration
Date:   Sun, 12 Jun 2022 20:56:01 +0530
Message-ID: <20220612152604.24280-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series converts atmel-flexcom bindings into json-schema format.
Adds support for lan966x flexcom chip-select configurations and its
DT bindings.

v2 -> v3:
 - changed IRQ flag in dt-bindings example.
 - added reg property specific to lan66x which is missed in v2.
 - used goto label for clk_disable in error cases.

v1 -> v2:
 - minor fix in title of dt-bindings.
 - Modified new dt properties usage in atmel,flexcom.yaml.
 - Used GENMASK and macros for maximum allowed values.
 - Use u32 values for flexcom chipselects instead of strings.
 - disable clock in case of errors.

Kavyasree Kotagiri (3):
  dt-bindings: mfd: atmel,flexcom: Convert to json-schema
  dt-bindings: mfd: atmel,flexcom: Add new compatible string for lan966x
  mfd: atmel-flexcom: Add support for lan966x flexcom chip-select
    configuration

 .../bindings/mfd/atmel,flexcom.yaml           | 174 ++++++++++++++++++
 .../devicetree/bindings/mfd/atmel-flexcom.txt |  63 -------
 drivers/mfd/atmel-flexcom.c                   |  94 +++++++++-
 3 files changed, 267 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt

-- 
2.17.1

