Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46547512209
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiD0TGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbiD0TGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:06:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4614B7179;
        Wed, 27 Apr 2022 11:53:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id 7E0CF1F44C83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651085593;
        bh=8vjtK1UfLIB91ege1gKuJlUretQNYk9Byb8qSHjd5g4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NhAkP6uyhRJ4v5WhCw8JWL+LAjgyXnc+JlM6riExVJGIPUyFsnm/LwDosb9lRaFZd
         OkHdx6rZkTg4icDQ1U+K9ELRLcS7X4ZhQseEDMsuN0nAfYMLAeZaUuAd8DMhTK9YZv
         jRhEANnLzzQ4bApObZTxTFKMrNxc6cUZW4J2A4geRuWJSY9xTznd/k+8XDrC9fKjaQ
         uJhPZnEiZEkxpNSPZec/75xvoakHcgVPG+sYHvHB4E9r8i9ROPioWFgmCz0y+DsNB0
         ly4VDnhlNI2wAYvBDxj5MvetotNfjn5LpmGJCiYdA4iQKNfkbFtl6gTbj1m7dw9hlK
         Z1ddu3h+LIb/Q==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, bcm-kernel-feedback-list@broadcom.com,
        devicetree@vger.kernel.org, f.fainelli@gmail.com,
        frowand.list@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com,
        nsaenz@kernel.org, olof@lixom.net, rjui@broadcom.com,
        robh+dt@kernel.org, sbranden@broadcom.com, soc@kernel.org,
        stefan.wahren@i2se.com,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [RFC PATCH v2 2/3] of: Add support for -@ when compiling overlays
Date:   Wed, 27 Apr 2022 14:52:42 -0400
Message-Id: <20220427185243.173594-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220427185243.173594-1-detlev.casanova@collabora.com>
References: <20220427185243.173594-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
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
2.36.0

