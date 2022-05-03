Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8A1517FF1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 10:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbiECIs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 04:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiECIsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 04:48:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470A535246;
        Tue,  3 May 2022 01:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651567491; x=1683103491;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7CH/R3WDM/KsLTRssfD9TcF5wFee3Th1OHNU9w2o+gw=;
  b=I2gxO1yNnSdFtxEIDIbnvmbZV2/9FKqkqhLrmTdz3hotRyvRh+qlqX5s
   k3zji1yMYoIi7DHwBcc5B7RLzqQyllc4/oIFO/N2QHN7v5zz0gqthOEA8
   xRKVmXnK7B6izV6w7sUDiAEqZTQbpgGufrRP1x8MN0kN/yUPEKn6npbcp
   2zLxbMTopEv86o3QhCmJGGxIbudS/geAFfwrLo2G91jiLkaymRW6CjRYx
   2QDmSKQSuYf77eLfI33KdHKroS9X9HP+l3ZrQNltZL0X/YTbqMTLRFENt
   alNmtj+kjoQga8odZOLRv278/i7GBSz69kTRQI5EU9URWY6AFA6HYNBjh
   A==;
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="171742551"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 May 2022 01:44:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 3 May 2022 01:44:48 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 3 May 2022 01:44:42 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <hverkuil@xs4all.nl>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jacopo@jmondi.org>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v10 0/8] media: atmel: atmel-isc: various fixes
Date:   Tue, 3 May 2022 11:44:13 +0300
Message-ID: <20220503084421.40682-1-eugen.hristev@microchip.com>
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
and it includes only the fixes patches, as requested by Hans.
The media controller part will be sent in a subsequent series.

Full series history:

Changes in v10:
-> split the series into this first fixes part.
-> changed patch
 [PATCH v9 06/13] media: atmel: atmel-isc-base: use mutex to lock awb workqueue from streaming
 added a missing mutex_lock , and edited commit message.

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



Eugen Hristev (8):
  media: atmel: atmel-isc-base: use streaming status when queueing
    buffers
  media: atmel: atmel-isc-base: replace is_streaming call in
    s_fmt_vid_cap
  media: atmel: atmel-isc: remove redundant comments
  media: atmel: atmel-sama5d2-isc: fix wrong mask in YUYV format check
  media: atmel: atmel-isc-base: use mutex to lock awb workq from
    streaming
  media: atmel: atmel-isc: compact the controller formats list
  media: atmel: atmel-sama7g5-isc: remove stray line
  dt-bindings: media: microchip,xisc: add bus-width of 14

 .../bindings/media/microchip,xisc.yaml        |  2 +-
 drivers/media/platform/atmel/atmel-isc-base.c | 34 +++++++++--
 drivers/media/platform/atmel/atmel-isc.h      |  8 ++-
 .../media/platform/atmel/atmel-sama5d2-isc.c  | 53 ++++++----------
 .../media/platform/atmel/atmel-sama7g5-isc.c  | 61 ++++++-------------
 5 files changed, 72 insertions(+), 86 deletions(-)

-- 
2.25.1

