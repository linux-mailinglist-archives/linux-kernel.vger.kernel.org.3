Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1684BE5FE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377262AbiBUOCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:02:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377250AbiBUOCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:02:01 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D723F1116F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:01:37 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id 2B5871F4362A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645452096;
        bh=RAvqTkh/51DvyDlo5krZpdFr0erWfey6ZCFejve0pWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ELrS/4IDHoxtwgpKtPaCfOFE7hZCUeGa5vGNfh+YDiWkAE11yOiDRXeh+DO7qrI3w
         +xbqhG9MvMkmMBZc3A+s4QsXRH7fwNxsepcotgqvNdUrfkyI7t5UjOI2PMNBYggfuR
         bXimEZdkbyGTNX95VSIcexCwf7MkokPVYAyUkFTLoj4hwcblixbhd1wi3aIrTMPa42
         hrVeJ/cC+iKu4fG7KN5kyFLPS3U9uxigi3gOwqAUMCGS65DRjTSuNyzSTlNC8JjhaJ
         7UOvCYlbTMjuv2CvX7csXnKZG2wPu5nURCMctbP3tYLo57k+nagkI+V+dzs6G8Ffo0
         r3vZMRvBzFDcA==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Detlev Casanova <detlev.casanova@collabora.com>
Subject: [RFC PATCH v2 2/3] of: Add support for -@ when compiling overlays
Date:   Mon, 21 Feb 2022 09:01:16 -0500
Message-Id: <20220221140117.90284-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221140117.90284-1-detlev.casanova@collabora.com>
References: <20220221140117.90284-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds an option to compile all device trees with -@ to add the
symbol table to the Device Tree Blobs.

It prepares the introduction of device tree overlays that are
not applied on device trees at compile time (dtbo files.)

These device tree overlays will be used by either a bootloader or a
linux userspace tool to extend the base device tree.

This is used e.g. for drivers that need device tree nodes for optional
non plug and play devices, like an external DSI touchscreen panel that
embeds different i2c devices to control it.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/of/Kconfig   | 8 ++++++++
 scripts/Makefile.lib | 9 +++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 80b5fd44ab1c..28cf8d18ac45 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -76,11 +76,19 @@ config OF_RESERVED_MEM
 config OF_RESOLVE
 	bool
 
+config OF_SYMBOLS
+	bool "Include device tree symbols"
+	help
+	  Loading a device tree overlay dynamically can require the base
+	  device tree symbols to be present.
+	  If this is enabled, the device tree blobs will be bigger.
+
 config OF_OVERLAY
 	bool "Device Tree overlays"
 	select OF_DYNAMIC
 	select OF_FLATTREE
 	select OF_RESOLVE
+	select OF_SYMBOLS
 	help
 	  Overlays are a method to dynamically modify part of the kernel's
 	  device tree with dynamically loaded data.
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 79be57fdd32a..4c330e565297 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -319,8 +319,13 @@ endif
 
 DTC_FLAGS += $(DTC_FLAGS_$(basetarget))
 
-# Set -@ if the target is a base DTB that overlay is applied onto
-DTC_FLAGS += $(if $(filter $(patsubst $(obj)/%,%,$@), $(base-dtb-y)), -@)
+ifeq ($(CONFIG_OF_SYMBOLS),y)
+	# Add symbols in all devicetrees
+	DTC_FLAGS += -@
+else
+	# Set -@ if the target is a base DTB that overlay is applied onto
+	DTC_FLAGS += $(if $(filter $(patsubst $(obj)/%,%,$@), $(base-dtb-y)), -@)
+endif
 
 # Generate an assembly file to wrap the output of the device tree compiler
 quiet_cmd_dt_S_dtb= DTB     $@
-- 
2.35.1

