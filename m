Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC48A4D89B4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244108AbiCNQiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243186AbiCNQgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E48417AA5;
        Mon, 14 Mar 2022 09:35:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D00EC6144A;
        Mon, 14 Mar 2022 16:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E792C340FD;
        Mon, 14 Mar 2022 16:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275708;
        bh=jBJeALofxyF7wDmEF7BT7aEaZSzFiE4VafpaBW/hK5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tpan4HDTu+FzF27Yr6A6pLtjq9SKmyR7RHqk55Z2XI6jIEotpouHfBntWZTggG4J5
         423FvtnPVnQ0wTeQTd2BRfAlqWxeKC4MO78x6/ddo/xrOaoa+zZB/er166yP3eXrkv
         Cm9tv1F9MtQJsgw1JZoMeT+M6PezB9EdbGlN39HrD2MNunK3mwI4PaGq7z/QA3Hpy8
         nF+G5nwL7xfnpFkbqm6A30ckQ06pG+DV4jLC/nMKTolbSD9Zusycx0VMJD2yLiFhEs
         em9KiUpUPCT1K1ANtORY/AHHH61gaoL2eYVpepV6gSLRwZxpCmA2bedVBqPwzRsiKA
         4MZofaIOoBZeA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTnf0-001wye-9D; Mon, 14 Mar 2022 17:35:06 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v2 39/67] media: platform: Kconfig: place platform drivers on a submenu
Date:   Mon, 14 Mar 2022 17:34:34 +0100
Message-Id: <546823232933cf51ea91eb61f33352d809162ba0.1647274406.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647274406.git.mchehab@kernel.org>
References: <cover.1647274406.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like media bus drivers, place platform drivers on a
submenu, in order to better organize user-selection:

    Media drivers  --->
	    *** media drivers ***
	[*] Media USB Adapters  --->
	[*] Media PCI Adapters  --->
	-*- Radio Adapters  --->
	[*] Media platform devices  --->
	    *** MMC/SDIO DVB adapters ***
	< > Siano SMS1xxx based MDTV via SDIO interface
	[*] V4L test drivers  --->
	[*] DVB test drivers  --->
	    *** FireWire (IEEE 1394) Adapters ***
	<*> FireDTV and FloppyDTV
	    *** common driver options ***
	[ ] Enable Remote Controller support for Siano devices
	[ ] Enable debugfs for smsdvb

As this submenu depends on MEDIA_PLATFORM_DRIVERS and defaults to "y",
there's no need to change already-existing .config entries, nor touch
the several make *_defconfig.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

 drivers/media/Kconfig          |  8 +++++---
 drivers/media/platform/Kconfig | 10 ++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index f3f24c63536b..1a75058df374 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -216,13 +216,12 @@ menu "Media drivers"
 comment "Drivers filtered as selected at 'Filter media drivers'"
 	depends on MEDIA_SUPPORT_FILTER
 
+comment "Media drivers"
+
 source "drivers/media/usb/Kconfig"
 source "drivers/media/pci/Kconfig"
 source "drivers/media/radio/Kconfig"
 
-# Common driver options
-source "drivers/media/common/Kconfig"
-
 if MEDIA_PLATFORM_SUPPORT
 source "drivers/media/platform/Kconfig"
 source "drivers/media/mmc/Kconfig"
@@ -234,6 +233,9 @@ endif
 
 source "drivers/media/firewire/Kconfig"
 
+# Common driver options
+source "drivers/media/common/Kconfig"
+
 endmenu
 
 #
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index e3316fa37a8f..721f27ef0130 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -3,6 +3,14 @@
 # Platform drivers
 #	Most drivers here are currently for webcam support
 
+menuconfig MEDIA_PLATFORM_DRIVERS
+	bool "Media platform devices"
+	default "y"
+	help
+	  Say Y here to enable support for platform-specific media drivers.
+
+if MEDIA_PLATFORM_DRIVERS
+
 config V4L_PLATFORM_DRIVERS
 	bool "V4L platform devices"
 	help
@@ -91,3 +99,5 @@ source "drivers/media/platform/tegra/vde/Kconfig"
 source "drivers/media/platform/ti-vpe/Kconfig"
 source "drivers/media/platform/via/Kconfig"
 source "drivers/media/platform/xilinx/Kconfig"
+
+endif # MEDIA_PLATFORM_DRIVERS
-- 
2.35.1

