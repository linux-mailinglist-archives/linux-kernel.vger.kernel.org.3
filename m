Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D574D354B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbiCIQvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbiCIQnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:43:49 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE0626C8;
        Wed,  9 Mar 2022 08:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646843892; x=1678379892;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HQ/1ekkK2Glo5J9Tadu/4CMzDFw9pCNql8ud3BmoP9Y=;
  b=IOOPX+ILQ0aiBP1DchYlU8v3mhVGWlnfY5rn//rLI0CZy2wNJu0sD45D
   9wCFy+NujVkQbvfElaG8jw7m5g9p4KhrnLLcomQIj78HoNqw+wRYnsufh
   1XxhKWsHXk/CKINAz21CLHu2GFeQ18X+E2PHmgQSUJi4R2S1cqBHLLvCd
   sh9gsNuTgP6+yg+NP+iYJWDEHfe9NR3fPzR1p9MXj/6uUGAtMGzlMhxq4
   tBd9lloK7L6SI1oJGQdsZ5FVh9G03NXi9bG4luDG/MExxtdtyZvy+HNaz
   zr+y6god+2P5h11tbJ7DfRcM5u8Q/DpS0uYCZT9awCSJzaezLLCUG1yQN
   g==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643698800"; 
   d="scan'208";a="151431904"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Mar 2022 09:38:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Mar 2022 09:38:11 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 9 Mar 2022 09:38:05 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <jacopo@jmondi.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <claudiu.beznea@microchip.com>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v8 00/13] media: atmel: atmel-isc: implement media controller
Date:   Wed, 9 Mar 2022 18:37:45 +0200
Message-ID: <20220309163758.2672727-1-eugen.hristev@microchip.com>
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


This series is the v8 series that attempts to support media controller in the
atmel ISC and XISC drivers.
The CSI2DC driver was accepted thus removed from the patch series, together with
other patches.

Important note: this series applies on top of current media_staging tree, as it
relies on previous patches in the series which were accepted.

Thanks to everyone who reviewed my work !

Eugen

Changes in v8:
-> scaler: modified crop bounds to have the exact source size

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
 .../media/platform/atmel/atmel-isc-scaler.c   | 267 +++++++++
 drivers/media/platform/atmel/atmel-isc.h      |  58 +-
 .../media/platform/atmel/atmel-sama5d2-isc.c  |  87 +--
 .../media/platform/atmel/atmel-sama7g5-isc.c  |  93 ++--
 10 files changed, 754 insertions(+), 327 deletions(-)
 create mode 100644 drivers/media/platform/atmel/atmel-isc-scaler.c

-- 
2.25.1

