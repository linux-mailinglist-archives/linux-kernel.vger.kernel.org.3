Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A6151ACB6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376925AbiEDS2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376846AbiEDS2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:28:15 -0400
X-Greylist: delayed 406 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 May 2022 10:55:25 PDT
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457F47665;
        Wed,  4 May 2022 10:55:23 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout1.routing.net (Postfix) with ESMTP id 577BB40821;
        Wed,  4 May 2022 17:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1651686516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PkayX3cpIbN2bP4bEPk/mnWfaMveU0+7qkBXCgv/T9o=;
        b=X8Ma05sMwPyKXtQFp92ps0fLub1eRcX0Y+uUSE8mexg54j4iPrYokP+AtQbbzJWhrWfYTH
        2yMyGqqEbQGE6hGzq46fPL/EK9AHRUnX5CXVt2elxDimdn4ZP4OjsPiOM0FACB19oO8Wm2
        UAQGwaYG+sMSV2H7KMrztQ6W7TBSDDc=
Received: from localhost.localdomain (fttx-pool-80.245.79.168.bambit.de [80.245.79.168])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 85F0B3606E1;
        Wed,  4 May 2022 17:48:35 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-pm@vger.kernel.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RFC v1] opp: add config option for debug
Date:   Wed,  4 May 2022 19:48:23 +0200
Message-Id: <20220504174823.156709-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 65529973-93c8-4f73-bd71-4fb0c003dd48
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Currently OPP debug is enabled by DEBUG_DRIVER option. This is generic
driver debug and opp floods serial console. This is annoying if opp is
not needed so give it an additional config-key.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/base/Kconfig | 1 +
 drivers/opp/Kconfig  | 7 +++++++
 drivers/opp/Makefile | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 6f04b831a5c0..8ae826c95d5f 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -130,6 +130,7 @@ config DEV_COREDUMP
 config DEBUG_DRIVER
 	bool "Driver Core verbose debug messages"
 	depends on DEBUG_KERNEL
+	imply DEBUG_OPP
 	help
 	  Say Y here if you want the Driver core to produce a bunch of
 	  debug messages to the system log. Select this if you are having a
diff --git a/drivers/opp/Kconfig b/drivers/opp/Kconfig
index e8ce47b32735..6a2d2c6c1143 100644
--- a/drivers/opp/Kconfig
+++ b/drivers/opp/Kconfig
@@ -12,3 +12,10 @@ config PM_OPP
 	  representing individual voltage domains and provides SOC
 	  implementations a ready to use framework to manage OPPs.
 	  For more information, read <file:Documentation/power/opp.rst>
+
+menu "Operating Performance Points (OPP)"
+config DEBUG_OPP
+	bool "Debug Operating Performance Points"
+	help
+	  enable opp debugging
+endmenu
diff --git a/drivers/opp/Makefile b/drivers/opp/Makefile
index f65ed5985bb4..2589915eef95 100644
--- a/drivers/opp/Makefile
+++ b/drivers/opp/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ccflags-$(CONFIG_DEBUG_DRIVER)	:= -DDEBUG
+ccflags-$(CONFIG_DEBUG_OPP)	:= -DDEBUG
 obj-y				+= core.o cpu.o
 obj-$(CONFIG_OF)		+= of.o
 obj-$(CONFIG_DEBUG_FS)		+= debugfs.o
-- 
2.25.1

