Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAD44B9CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239011AbiBQKLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:11:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239006AbiBQKLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:11:11 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0A92AB516
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 02:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645092656; x=1676628656;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NQqZJsnPwqJ522IRxbLNyRT+v0Qc32ocxAdMD2J077g=;
  b=Yepg7tpqNQ4D0IINwgoOV3J1S7yVgqsXrR+1As2nvQT7A0BisB9SN8/q
   nmysDY3FVuBiQJ21tv4kcCpZClBnTo6xekjiFtvl9jbay3Jd/fHRGVrWn
   PBM/S+ToqtiU5MFwngNcRsDQz8UErXs4Hyfpsuf+ljgnNAuy1moWIHMps
   qf5e3dxIDaewAfKv1wZz7MWoiPg1NJEZx/iiM4A8zj+o6QsWVv02J3afV
   fCGJsHnuMmkHJhKzh8IgYppdfIVKcUJE0qn60A/4Xzht0wgVC21bjU25A
   E1Xb4CSws04hFzDxb4YtKnfj6n00KZShKNB/Vi5W/0/b4MudW/6eQctG9
   w==;
IronPort-SDR: TBFQyPHCCyv4ULomJcGXTfJNKO3CdjfQdAkLdWuHeS4sD3oJOP1MzsCY7JSUuu4jgxKAzn4Ty6
 LUHXi7DVaqhCq+ZNSnZw+gA+BOTPoZ+oEcDS4ufAaCTA2wIa9fwSR2c8XO/AytUxGf45o2pU93
 rxCFc5TF9WclH25AHtGixinTD1UqNsKlnR+R3KiI+igzRP7LSxTiwlIQJudpcbwtFn4deTOlwY
 8TRTVVk+GksDgyVYKMcLKklyEo8JvBQoUtEP0HtiVVDHS6wCQibGi3G2PfYNwASKN3hWZFA1kE
 hRhhEGtq86EDXg88nK03Bz8l
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="153919206"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2022 03:10:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 17 Feb 2022 03:10:55 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 17 Feb 2022 03:10:50 -0700
From:   <conor.dooley@microchip.com>
To:     <aou@eecs.berkeley.edu>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <arnd@arndb.de>, <olof@lixom.net>,
        <linux-riscv@lists.infradead.org>
CC:     <robh+dt@kernel.org>, <cyril.jean@microchip.com>,
        <daire.mcnamara@microchip.com>, <lewis.hanly@microchip.com>,
        <jassisinghbrar@gmail.com>, <j.neuschaefer@gmx.net>,
        <sfr@canb.auug.org.au>, <damien.lemoal@wdc.com>,
        <atishp@atishpatra.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <claudiu.beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Conor Dooley" <conor.dooley@microchip.com>
Subject: [PATCH v4 0/1] soc: add microchip polarfire soc system controller
Date:   Thu, 17 Feb 2022 10:13:49 +0000
Message-ID: <20220217101349.2374873-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.1
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

From: Conor Dooley <conor.dooley@microchip.com>

Since I submitted version 1 of this driver, I attempted to upstream
bindings for devices dependant on the system controller [0]. In that
process, Rob said that since they were devices with no resources,
other than a reference to the system controller, the devices should
not be in the device tree & instead they should be created by the
system controller (which it now does).

Since the sub devices using mpfs_sys_controller_get will now have the
system controller as their parent, this function now just checks if the
parent device is compatible. If the parent is compatible, the sub-
device then attempts to register as a consumer of the system controller

@Arnd Hopefully this clears up the issues you had with reference
counting & the lack of checks as to whether the device found by
mpfs_sys_controller_get was in fact a system controller.

Depends on [0] to change the compatible string in the dt-binding.
Thanks,
Conor.

Changes since v3:
- switch to devm_kzalloc in probe
- unify exports to use the non GPL version

Changes since v2:
- system controller is no longer an mfd, system controller now creates
  sub devices for itself.
- specify that a mpfs_mss_msg is used in mpfs_blocking_transaction
  rather than using a void pointer.
- as the subdevices are now all created by the system controller, the
  get() function now checks that the requesting device's parent is
  compatible.
- mpfs_sys_controller_get now passes a pointer to the device that is
  trying to register as a consumer rather than a device node.

Changes since v1:
- system controller is now an mfd
- parentage is now used to get the device node on the system controller
- mpfs_sys_controller_get() now updates the reference count
- "polarfire-soc" in compat string changed to "mpfs"

[0] https://lore.kernel.org/linux-riscv/20220214135840.168236-1-conor.dooley@microchip.com/

Conor Dooley (1):
  soc: add microchip polarfire soc system controller

 drivers/soc/Kconfig                         |   1 +
 drivers/soc/Makefile                        |   1 +
 drivers/soc/microchip/Kconfig               |  10 +
 drivers/soc/microchip/Makefile              |   1 +
 drivers/soc/microchip/mpfs-sys-controller.c | 194 ++++++++++++++++++++
 include/soc/microchip/mpfs.h                |   4 +-
 6 files changed, 209 insertions(+), 2 deletions(-)
 create mode 100644 drivers/soc/microchip/Kconfig
 create mode 100644 drivers/soc/microchip/Makefile
 create mode 100644 drivers/soc/microchip/mpfs-sys-controller.c

-- 
2.35.1

