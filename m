Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96D14CFDA7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbiCGMF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237738AbiCGMFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:05:52 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FF46EB28;
        Mon,  7 Mar 2022 04:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646654696; x=1678190696;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ADxjblmvouljyvbG8C2f+H370jdyVZUvau7Hsxu26P0=;
  b=tO9F8QVh1vXtum4W/IENiiLhvtypfcB3i5o1FPYWTbIZ2Q2qRg644Ubc
   02DpAvKdZ1HPCLx7+ow9seukQLHZAeFvEVN7tGALuoMT8/xBoviCfjdtY
   ZMQAN4PxwKjPGzsvCp61P6eahF809Q/vFfGafzBi4CPr5rFwsmFXt9wUX
   nH1x89WOXS2iKyg7LAiGTARrLGSgAFG1dcIOo2M1WSmYV0YGTOn91S7ox
   GAQ/YgL5CMImAsCPFpr+c3Aa4dYjVZW/EFitqVuLrd2TZbG2mzGKU3Swq
   F4uhcdhrzu5oqFzD3PTcE+Sh5/h9ckmuCg5V5mtQJiCdEQFJR2ZBNfXgw
   A==;
X-IronPort-AV: E=Sophos;i="5.90,162,1643698800"; 
   d="scan'208";a="164765120"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2022 05:04:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 05:04:56 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 7 Mar 2022 05:04:50 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <jacopo@jmondi.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <claudiu.beznea@microchip.com>, <hverkuil-cisco@xs4all.nl>,
        <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v7 00/13] media: atmel: atmel-isc: implement media controller
Date:   Mon, 7 Mar 2022 14:04:10 +0200
Message-ID: <20220307120423.2427631-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
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


This series is the v7 series that attempts to support media controller in the
atmel ISC and XISC drivers.
The CSI2DC driver was accepted thus removed from the patch series, together with
other patches.

Important note: this series applies on top of current media_staging tree, as it
relies on previous patches in the series which were accepted.

Thanks to everyone who reviewed my work !

Eugen

Changes in v7:
-> scaler: modified crop bounds to have maximum isc size
-> format propagation: did small changes as per Jacopo review


Changes in v6:
-> worked a bit on scaler, added try crop and other changes as per Jacopo review
-> worked on isc-base enum_fmt , reworked as per Jacopo review

Changes in v5:
-> removed patch that removed the 'stop' variable as it was still required
-> added two new trivial patches
-> reworked some parts of the scaler and format propagation after discussions with Jacopo


Changes in v4:
-> as reviewed by Hans, added new patch to remove the 'stop' variable and reworked
one patch that was using it
-> as reviewed by Jacopo, reworked some parts of the media controller implementation


Changes in v3:
- change in bindings, small fixes in csi2dc driver and conversion to mc
for the isc-base.
- removed some MAINTAINERS patches and used patterns in MAINTAINERS

Changes in v2:
- integrated many changes suggested by Jacopo in the review of the v1 series.
- add a few new patches


Eugen Hristev (13):
  media: atmel: atmel-isc-base: use streaming status when queueing
    buffers
  media: atmel: atmel-isc-base: replace is_streaming call in
    s_fmt_vid_cap
  media: atmel: atmel-isc: remove redundant comments
  media: atmel: atmel-isc: implement media controller
  media: atmel: atmel-sama5d2-isc: fix wrong mask in YUYV format check
  media: atmel: atmel-isc-base: use mutex to lock awb workqueue from
    streaming
  media: atmel: atmel-isc: compact the controller formats list
  media: atmel: atmel-isc: change format propagation to subdev into only
    verification
  media: atmel: atmel-sama7g5-isc: remove stray line
  dt-bindings: media: microchip,xisc: add bus-width of 14
  ARM: dts: at91: sama7g5: add nodes for video capture
  ARM: configs: at91: sama7: add xisc and csi2dc
  ARM: multi_v7_defconfig: add atmel video pipeline modules

 .../bindings/media/microchip,xisc.yaml        |   2 +-
 arch/arm/boot/dts/sama7g5.dtsi                |  49 ++
 arch/arm/configs/multi_v7_defconfig           |   3 +
 arch/arm/configs/sama7_defconfig              |   2 +
 drivers/media/platform/atmel/Makefile         |   2 +-
 drivers/media/platform/atmel/atmel-isc-base.c | 518 ++++++++++--------
 .../media/platform/atmel/atmel-isc-scaler.c   | 276 ++++++++++
 drivers/media/platform/atmel/atmel-isc.h      |  58 +-
 .../media/platform/atmel/atmel-sama5d2-isc.c  |  87 +--
 .../media/platform/atmel/atmel-sama7g5-isc.c  |  93 ++--
 10 files changed, 763 insertions(+), 327 deletions(-)
 create mode 100644 drivers/media/platform/atmel/atmel-isc-scaler.c

-- 
2.25.1

