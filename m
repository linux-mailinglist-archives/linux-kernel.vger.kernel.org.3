Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1455350AA26
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392498AbiDUUlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392464AbiDUUkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:40:51 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A076F4DF7B;
        Thu, 21 Apr 2022 13:37:58 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23LKbl9D086295;
        Thu, 21 Apr 2022 15:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650573467;
        bh=fiIGiZ2hCyION5BKmzCgCDBVNqXIdGRylYKYLQZ5tjg=;
        h=From:To:CC:Subject:Date;
        b=tdQQwhBMXubbrpNpRi5aup6zXYw77wXf43qAwE1c62V00dPpRsZoww+ETAF8FRRXZ
         c0z5iNuW9a1W3molTOqcKvFn/h4F3w8O8+rOdNuIFa1iSqmoc57zctuXDGPZv0IMqO
         tR2PeBYSfDtYkGZdX0n2a9zRaxiEc5UtqC2gisU8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23LKblZC003126
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Apr 2022 15:37:47 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 21
 Apr 2022 15:37:46 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 21 Apr 2022 15:37:46 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23LKbka2012875;
        Thu, 21 Apr 2022 15:37:46 -0500
From:   Dave Gerlach <d-gerlach@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 0/6] firmware: ti_sci: Introduce system suspend support
Date:   Thu, 21 Apr 2022 15:36:53 -0500
Message-ID: <20220421203659.27853-1-d-gerlach@ti.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series introduces necessary ti_sci driver functionality in
preparation of supporting DeepSleep mode for suspend to mem on TI K3
AM62 [1]. This series applies on top of [2], which is also required for
proper system suspend operation.

Deep Sleep mode is described in section "5.2.4.4 DeepSleep" of the AM62
Technical Reference Manual: https://www.ti.com/lit/pdf/spruiv7

The kernel triggers entry to Deep Sleep mode through the mem suspend
transition with the following:

* Use a TF-A binary that supports PSCI_SYSTEM_SUSPEND call, which is
  enabled by the pending patches here [3]. This causes system to use
  PSCI system suspend as last step of mem sleep.

* The firmware requires that the OS sends a TISCI_MSG_PREPARE_SLEEP
  message in order to provide details about suspend, so we must add the
  ability to send this message. (Patch 3)

* A memory carveout address must be provided to the firmware using
  the above message, which is passed through device tree to the
  driver. (Patches 1 and 4)

* System must load firmware to a specific location before Deep Sleep is
  entered, and this is accomplished using an lpm memory region in device
  tree to indicate where this firmware should be loaded, and also a
  "ti,lpm-firmware-name" property to indicate the name of the firmware
  to load. The ti_sci driver checks in its suspend handler to see if
  the firmware has been loaded and if not, loads it. (Patches 2 and 5)

* Finally, the ti_sci driver must actually send TISCI_MSG_PREPARE_SLEEP
  message to firmware with the above information included, which it
  does during the driver suspend handler when PM_MEM_SUSPEND is the
  determined state being entered. (Patch 6)

This is tested on am625-sk using a ramdisk with all devices disabled
apart from cpu0, main_uart0, dmsc, and secure_proxy_main.

Regards,
Dave

[1] https://lore.kernel.org/lkml/20220225120239.1303821-1-vigneshr@ti.com/
[2] https://lore.kernel.org/lkml/20220412192138.31189-1-d-gerlach@ti.com/
[3] https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/14714/3

Dave Gerlach (6):
  dt-bindings: ti,sci: Add ti,ctx-memory-region property
  dt-bindings: ti,sci: Add lpm region and ti,lpm-firmware-name
  firmware: ti_sci: Introduce Power Management Ops
  firmware: ti_sci: Introduce ti,ctx-memory-region for reserved LPM
    memory
  firmware: ti_sci: Use dt provided fw name and address to load at
    suspend time
  firmware: ti_sci: Introduce prepare system suspend call

 .../bindings/arm/keystone/ti,sci.yaml         |  30 ++-
 drivers/firmware/ti_sci.c                     | 207 +++++++++++++++++-
 drivers/firmware/ti_sci.h                     |  32 ++-
 include/linux/soc/ti/ti_sci_protocol.h        |   6 +
 4 files changed, 269 insertions(+), 6 deletions(-)

-- 
2.35.0

