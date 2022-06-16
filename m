Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CC054DDAA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376374AbiFPIzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376717AbiFPIyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:54:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBD931F;
        Thu, 16 Jun 2022 01:53:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E1EE60A52;
        Thu, 16 Jun 2022 08:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC38C34114;
        Thu, 16 Jun 2022 08:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655369586;
        bh=D+RdnsGxCjpna2nFhDsPH8yn1kQWXeuteyiCbSjG4Ok=;
        h=From:To:Cc:Subject:Date:From;
        b=Cyn9DqW2Bo3mTonREJvlbSy94eHhheJutfKkKp95w8UonnXD/cBAVYT49zitJOw0h
         Njb5JNPyai8ZEzJ2wsmM/OeHwfADxJrgtU4ktEFJIhuxjlHbjIge6BTgah+IppHcJ9
         +RZii4ZnqzTrJbAcOhsNBrcxK/OwbQy3+gXUa9jbNQnJzL3bQXwatqRIrhgi6l/kAc
         mtHG21XDf9NbXqpe8SWE2LEf3NT31JizOozm0/7vv9XQWcizJdDc9EzTpKDGDXjN2U
         VuACe89/ZSQJKOhPijA0LeXaoEmnyMOM4y2EGre4RrjwA/fJhAZtfRTgi6byfPeltp
         Iry4eYOCNY6gw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Federico Vaga <federico.vaga@gmail.com>,
        Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: sta2x11: remove VIRT_TO_BUS dependency
Date:   Thu, 16 Jun 2022 10:52:42 +0200
Message-Id: <20220616085254.2275372-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This driver does not use the virt_to_bus() function, though it
depends on x86 specific fixups in the swiotlb code, which was
last rewritten in commit e380a0394c36 ("x86/PCI: sta2x11: use
default DMA address translation").

It is possible that the driver still fails to build on some
architectures that are missing CONFIG_VIRT_TO_BUS, but it is
always set on x86 machines with the STA2X11 platform enabled.

More likely though is that it was never meant to depend on
CONFIG_VIRT_TO_BUS, and the Kconfig dependency was kept from
an out-of-tree version when the driver was originally merged.

Fixes: efeb98b4e2b2 ("[media] STA2X11 VIP: new V4L2 driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/pci/sta2x11/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/sta2x11/Kconfig b/drivers/media/pci/sta2x11/Kconfig
index a96e170ab04e..118b922c08c3 100644
--- a/drivers/media/pci/sta2x11/Kconfig
+++ b/drivers/media/pci/sta2x11/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config STA2X11_VIP
 	tristate "STA2X11 VIP Video For Linux"
-	depends on PCI && VIDEO_DEV && VIRT_TO_BUS && I2C
+	depends on PCI && VIDEO_DEV && I2C
 	depends on STA2X11 || COMPILE_TEST
 	select GPIOLIB if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_ADV7180 if MEDIA_SUBDRV_AUTOSELECT
-- 
2.29.2

