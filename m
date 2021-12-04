Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE7F4686C0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 18:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385291AbhLDRtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 12:49:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43124 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhLDRtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 12:49:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9FB4B80D1B;
        Sat,  4 Dec 2021 17:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A7AC341C0;
        Sat,  4 Dec 2021 17:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638639965;
        bh=YhxLcJ2geY7ctl56mq7OCUWTi2CnEIueF/J1LTxlMwo=;
        h=From:To:Cc:Subject:Date:From;
        b=RaL7Xu0vDimthb7USQThs/dvlT7uV8pezeD8x9oGYJualOVplU3VV92N/IemAIj+v
         WEt3NRKunAdxEZxIkKZIt6sD3QDQgdGTH4dXIP0YzxZfsJIYzNPzjs0x+W9YT9F3W8
         vYSeGEl845zAgYkkZkJaKzSFW0GEGh/Q0jFl/l+6T87gHzUPp0x9vudue2LwTvtyXh
         ggrMhja5JeTbBBA8LXo6RZFBpnSnAy6UnajPMSZpsDpIfHi+u0eceVslHa/Nv3d7NZ
         48Zq0WNbZyhJzdLKhJFK7rUf6ib8dKIDXpDjWBotoFEJw0tfmQW6MPJ578sxGdizGC
         MT9ZCfqewRVyw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] media: staging: max96712: add V4L2 dependencies
Date:   Sat,  4 Dec 2021 18:45:48 +0100
Message-Id: <20211204174559.1146671-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Without the extra dependencies, I run into randconfig build failures:

WARNING: unmet direct dependencies detected for VIDEO_V4L2_SUBDEV_API
  Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=n] && MEDIA_CONTROLLER [=y]
  Selected by [y]:
  - VIDEO_MAX96712 [=y] && STAGING [=y] && STAGING_MEDIA [=y] && MEDIA_SUPPORT [=y] && I2C [=y] && OF_GPIO [=y]

aarch64-linux-ld: drivers/staging/media/max96712/max96712.o: in function `max96712_probe':
max96712.c:(.text+0x1b8): undefined reference to `v4l2_fwnode_endpoint_parse'
aarch64-linux-ld: max96712.c:(.text+0x374): undefined reference to `v4l2_ctrl_handler_init_class'
aarch64-linux-ld: max96712.c:(.text+0x3b0): undefined reference to `v4l2_ctrl_new_std'

Fixes: 5814f32fef13 ("media: staging: max96712: Add basic support for MAX96712 GMSL2 deserializer")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/media/max96712/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/media/max96712/Kconfig b/drivers/staging/media/max96712/Kconfig
index 258d47644cbd..62534110ca3b 100644
--- a/drivers/staging/media/max96712/Kconfig
+++ b/drivers/staging/media/max96712/Kconfig
@@ -3,6 +3,7 @@ config VIDEO_MAX96712
 	tristate "Maxim MAX96712 Quad GMSL2 Deserializer support"
 	depends on I2C
 	depends on OF_GPIO
+	depends on VIDEO_DEV && VIDEO_V4L2
 	select V4L2_FWNODE
 	select VIDEO_V4L2_SUBDEV_API
 	select MEDIA_CONTROLLER
-- 
2.29.2

