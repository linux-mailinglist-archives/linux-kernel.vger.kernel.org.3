Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079AD5181AB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiECJza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiECJz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:55:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E97D34670;
        Tue,  3 May 2022 02:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651571513; x=1683107513;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uPay5kgoSMqOclQHBORZW0OUgefZ39Uk8nB9oB+h8v0=;
  b=bABkIZFeYjKKVyQcPYSM/RAD/9KW2T4BemdOp262ZORcVrSb95kozXz8
   RrSdbOGdOdL/+1cFALWuotaiSeQVxt/O+FM7SfHDWUGIzGfQefwq+7mnh
   quuM9x/bzjQhYjrIiN0YkDlXzQkESatePXI1LeQFG36QEc3rbvaqKN/Fd
   YPVw3h90FTj7Lu3NxYK/q1Czy3VSfSwQoqwcmlUfvLAVOlZxa2QYk5qsq
   RnALArNVxb34E0+23cE0cpj6Q1oNiwUSEVFRyRReeALgzgYSI4s0UN93U
   IUz7PzwaDRr6w7uniT1k1M/5in1nxrmVDg9ylssOAYUTQO8zxl5T9RSHa
   w==;
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="162530880"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 May 2022 02:51:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 3 May 2022 02:51:51 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 3 May 2022 02:51:40 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <hverkuil@xs4all.nl>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <claudiu.beznea@microchip.com>, <nicolas.ferre@microchip.com>,
        <jacopo@jmondi.org>, Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v10 0/5] media: atmel: atmel-isc: implement media controller
Date:   Tue, 3 May 2022 12:51:22 +0300
Message-ID: <20220503095127.48710-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a split from the series :
[PATCH v9 00/13] media: atmel: atmel-isc: implement media controller
and it includes the media controller part.
previous fixes were sent on a different patch series.

As discussed on the ML, moving forward with having the media link validate at
start/stop streaming call.
I will test the patch :
[RFC PATCHv2] vb2: add support for (un)prepare_streaming queue ops
afterwards, but that patch requires moving my logic to the new vb2 callbacks.

Full series history:

Changes in v10:
-> split the series into this first fixes part.
-> moved IO_MC addition from first patch to the second patch on the driver changes
-> edited commit messages
-> DT nodes now disabled by default.

Changes in v9:
-> kernel robot reported isc_link_validate is not static, changed to static.

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

Eugen Hristev (5):
  media: atmel: atmel-isc: prepare for media controller support
  media: atmel: atmel-isc: implement media controller
  ARM: dts: at91: sama7g5: add nodes for video capture
  ARM: configs: at91: sama7: add xisc and csi2dc
  ARM: multi_v7_defconfig: add atmel video pipeline modules

 arch/arm/boot/dts/sama7g5.dtsi                |  51 ++
 arch/arm/configs/multi_v7_defconfig           |   3 +
 arch/arm/configs/sama7_defconfig              |   2 +
 drivers/media/platform/atmel/Makefile         |   2 +-
 drivers/media/platform/atmel/atmel-isc-base.c | 485 +++++++++---------
 .../media/platform/atmel/atmel-isc-scaler.c   | 267 ++++++++++
 drivers/media/platform/atmel/atmel-isc.h      |  50 +-
 .../media/platform/atmel/atmel-sama5d2-isc.c  |  34 +-
 .../media/platform/atmel/atmel-sama7g5-isc.c  |  32 +-
 9 files changed, 685 insertions(+), 241 deletions(-)
 create mode 100644 drivers/media/platform/atmel/atmel-isc-scaler.c

-- 
2.25.1

