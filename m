Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F75E4CFBC2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbiCGKre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241257AbiCGKrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:47:03 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283CF9EBB9;
        Mon,  7 Mar 2022 02:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646647641; x=1678183641;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g+E2cqWn9Vq/Ut2H92s1dRBvdhhumC0Wle7tlrJx1G8=;
  b=Pt1N+1YK1sd6WURzSE584reeqpWO5RzrfLjNVPvslZzORjR81gcnj/ps
   cc5LIMSrN1CuCVt4qyvBh4RP6BKbpC58tAQXm3oIh8mGna/wNKv1vcXCX
   3zgjtHkpe+8mAn77q2+HLzpYi1opZbCcAdrFyIZC29eVFHSpvxXhzKH3/
   qMUq+BqMopigmktbR9Q71eLuWHsZ/nrMWdpfygo9SMUFRWxscsiN5L4IV
   AIK0kynBRbN+M+Wn6D3rQnRgcXkJOulfwZFGcSgB2z9c3jLe3L7zzjvlS
   hdSq8heIHKLQuozplPTGTU5hISG0YEkFQMAAF0eU06EAJCaS1NJLIzXU9
   A==;
X-IronPort-AV: E=Sophos;i="5.90,161,1643698800"; 
   d="scan'208";a="88045514"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2022 03:06:07 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 03:05:56 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 7 Mar 2022 03:05:53 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lars@metafoo.de>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH v2 0/6] Add driver for SAMA7G5's PDMC
Date:   Mon, 7 Mar 2022 12:04:22 +0200
Message-ID: <20220307100428.2227511-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Pulse Density Microphone Controller
(PDMC), present on Microchip's SAMA7G5.
The PDMC interfaces up to 4 digital microphones having Pulse Density
Modulated (PDM) outputs. It generates a single clock line and samples 1 or
2 data lines. The signal path includes an audio grade programmable
decimation filter and outputs 24-bit audio words.
The source of each channel can be independently defined as PDMC_DS0 or
PDMC_DS1, sampled at the rising or falling edge of PDMC_CLK.

The patch series starts with a fix on the ASoC DMA engine support. Then
continues with the bindings and the driver of PDMC. It is followed by the
DT nodes for SAMA7G5 and SAMA7G5-EK. In the end, the drivers for PDMC
and PDM microphones are enabled in sama7_defconfig.

Changes in v2:
 - addressed comments from Krzysztof Kozlowski

Codrin Ciubotariu (6):
  ASoC: dmaengine: do not use a NULL prepare_slave_config() callback
  ASoC: dt-bindings: Document Microchip's PDMC
  ASoC: atmel: mchp-pdmc: add PDMC driver
  ARM: dts: at91: sama7g5: add nodes for PDMC
  ARM: dts: at91: sama7g5ek: add node for PDMC0
  ARM: configs: at91: sama7_defconfig: add MCHP PDMC and DMIC drivers

 .../bindings/sound/microchip,pdmc.yaml        |   99 ++
 arch/arm/boot/dts/at91-sama7g5ek.dts          |   21 +-
 arch/arm/boot/dts/sama7g5.dtsi                |   24 +
 arch/arm/configs/sama7_defconfig              |    2 +
 include/dt-bindings/sound/microchip,pdmc.h    |   13 +
 sound/soc/atmel/Kconfig                       |   16 +
 sound/soc/atmel/Makefile                      |    2 +
 sound/soc/atmel/mchp-pdmc.c                   | 1084 +++++++++++++++++
 sound/soc/soc-generic-dmaengine-pcm.c         |    6 +-
 9 files changed, 1263 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/microchip,pdmc.yaml
 create mode 100644 include/dt-bindings/sound/microchip,pdmc.h
 create mode 100644 sound/soc/atmel/mchp-pdmc.c

-- 
2.32.0

