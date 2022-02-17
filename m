Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D28E4BA226
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241423AbiBQN5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:57:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbiBQN5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:57:42 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D58817C117;
        Thu, 17 Feb 2022 05:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645106247; x=1676642247;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sN39M8C1hByXCcSuR9JDCKDgWrEOxcLMqTAc2PYXXgA=;
  b=Qy3u9Q/6R2Ki1uwlG1f5Ru5osbnYC3BFq4F2ICnq8TUtWPmzx9ND7RXB
   FK11tluoKWBciMaEL/1PA+sb8wOeiXmz2Amu5x808Ao92yAZi7+gFI01I
   zgRXHwbinjRP1TPfqww9HKLvcwJ73rV5wUfjuBkOkHMOsByUU/mTjIlMJ
   BMNl1IBjYkktBGKPxX3TJk6DkuwWkNivwLtd9MjMpClN2fwWDuf7PVMM1
   kU5ap/QOOSWQBHCgs0mfajNHeCnmItFn7LNOTF/mVGEW26SUuSbP4N5j/
   NRiVlKCwFo9/+TAihOXBslyLEpS/REF5gU26AR18uzIoIO3jqjSkRMOql
   A==;
IronPort-SDR: L7eH1QBIn7rh3QBeJlnrFzo1mHsiNU+D4XcYKKhxpijKdw1FXfyxj6p1g+ix4IcKR4kEEfYdkw
 fL/et5G9qXuNW2dqqPXanXcFLTWbV7qPLWXKKbM0Iv+2dK+OHzEFT3Sd9Xwg2rSM4poMPpIMW6
 incycCTolxX3D78GuiuVKmubq0XM02Oa+u6h2hpS+7mqCIKQfTfYX7zSJQNNjDGJmcs+jAW60y
 f6ttkZ4Gx1DQVb8mo9/CWke2lOGYi8A3BBPsf9Jbp2Z/MFWg5NpvF6qev953hBEwiiaWMrDrmm
 Wxk=
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="153942547"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2022 06:57:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 17 Feb 2022 06:57:24 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 17 Feb 2022 06:57:04 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <jacopo@jmondi.org>,
        <hverkuil-cisco@xs4all.nl>, <nicolas.ferre@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <claudiu.beznea@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v5 00/13] media: atmel: atmel-isc: implement media controller
Date:   Thu, 17 Feb 2022 15:56:32 +0200
Message-ID: <20220217135645.1427466-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is the v5 series that attempts to support media controller in the
atmel ISC and XISC drivers.
The CSI2DC driver was accepted thus removed from the patch series, together with
other patches.

Important note: this series applies on top of current media_staging tree, as it
relies on previous patches in the series which were accepted.

Thanks to everyone who reviewed my work !

Eugen

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
 drivers/media/platform/atmel/atmel-isc-base.c | 531 ++++++++++--------
 .../media/platform/atmel/atmel-isc-scaler.c   | 266 +++++++++
 drivers/media/platform/atmel/atmel-isc.h      |  61 +-
 .../media/platform/atmel/atmel-sama5d2-isc.c  |  87 +--
 .../media/platform/atmel/atmel-sama7g5-isc.c  |  93 +--
 10 files changed, 762 insertions(+), 334 deletions(-)
 create mode 100644 drivers/media/platform/atmel/atmel-isc-scaler.c

-- 
2.25.1

