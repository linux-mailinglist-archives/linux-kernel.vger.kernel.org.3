Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BE04D7392
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 08:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbiCMHZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 03:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbiCMHXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 03:23:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BC91945D1;
        Sat, 12 Mar 2022 23:21:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CEBC60F8A;
        Sun, 13 Mar 2022 07:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6037C341D5;
        Sun, 13 Mar 2022 07:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647156114;
        bh=/ogxKzZ0m6khAgDWEbqpQVa3n5tf3pCSQuh7JVzkivY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XH6gg3RXqCBOWOOYQZt6g4I62KabpJA9CBhlooEMj9nCldin+E9DX1q7qCqm4BlI5
         0n9zeTdPJezGNvbwWIyl2REB7mhf2kOGBn+29l8VD/qhB165HfFCSckqXTIGIFKlmg
         g9dIEaMpb6dgTtE0lwvHOhq0R6sdGkS9qM+F4H0fHldzZVhQzUFOHrtehl9T7oIpR1
         rWylN7mKqkxeh3UKoGR4CITQdcOrqPJqigMvqrVYFBOfJz3roJuNP897GQr+VrXGP0
         8qAxd7a5uNuUnK2il2expLRL0ORsb1mj6oC0VsyQAn/GUsjI/Id9Ge8DUzg8d1pi7H
         /dFekLlRoH14Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTIY4-0012xk-GN; Sun, 13 Mar 2022 08:21:52 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ming Qian <ming.qian@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v3 35/39] media: platform: s5p-mfc: move config to its own file
Date:   Sun, 13 Mar 2022 08:21:44 +0100
Message-Id: <a2a4db642a19b66cdef1a2f0dabd39cdc370a6cf.1647155572.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647155572.git.mchehab@kernel.org>
References: <cover.1647155572.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to better organize the platform/Kconfig, place
s5p-mfc-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/39] at: https://lore.kernel.org/all/cover.1647155572.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig         | 9 +--------
 drivers/media/platform/s5p-mfc/Kconfig | 9 +++++++++
 2 files changed, 10 insertions(+), 8 deletions(-)
 create mode 100644 drivers/media/platform/s5p-mfc/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 2069eee801af..fd6b18ac0c7c 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -113,14 +113,7 @@ config VIDEO_SAMSUNG_S5P_JPEG
 	  This is a v4l2 driver for Samsung S5P, EXYNOS3250
 	  and EXYNOS4 JPEG codec
 
-config VIDEO_SAMSUNG_S5P_MFC
-	tristate "Samsung S5P MFC Video Codec"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
-	select VIDEOBUF2_DMA_CONTIG
-	help
-	    MFC 5.1 and 6.x driver for V4L2
+source "drivers/media/platform/s5p-mfc/Kconfig"
 
 source "drivers/media/platform/sti/bdisp/Kconfig"
 
diff --git a/drivers/media/platform/s5p-mfc/Kconfig b/drivers/media/platform/s5p-mfc/Kconfig
new file mode 100644
index 000000000000..34b52b0de304
--- /dev/null
+++ b/drivers/media/platform/s5p-mfc/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_SAMSUNG_S5P_MFC
+	tristate "Samsung S5P MFC Video Codec"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
+	select VIDEOBUF2_DMA_CONTIG
+	help
+	    MFC 5.1 and 6.x driver for V4L2
-- 
2.35.1

