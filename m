Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29530474760
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbhLNQQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbhLNQQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:16:48 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC43C061748
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:16:48 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id z8-20020a05600c220800b0034565e837b6so100923wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=flIdsS0epokCC1Fa2U8TWwSIjl6RXHfFR0T9jD6BkKs=;
        b=M0Zdj53y+pvGXE+r1pQU/NT/NCMxIPMYRCKz2kUtHku4VCRhBAbcAKaVX2ztzjvS3j
         AU7ALThAmXR2VPfpZt1mGybjwveWwQvhNh9EsoRM63gAswQqFSFfphnj83ceYn/Two3C
         0TtBK/yAdpKWiNtmGwBcygIz756mBhXZNKJuGaN9AGEM6tGgN9lJmpLqqiTPNhKsKUdb
         JYq6NjGWuFvSoq2ruR6h5GOnDhLRzHLjjrJcGJUEE4G36jOLjdp7ERCgLXyIn8lzxAWx
         BKGPFsJHFt33emNge0F34vVVQVWRdIgD6MdjVRjbrSR0JYMuLDZhDfKLWLhAtAe+sCtU
         YASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=flIdsS0epokCC1Fa2U8TWwSIjl6RXHfFR0T9jD6BkKs=;
        b=NLGBw8xjEmc1ZwAUPK0EzPn9VmghKpbhjPykR1fcNj/tjQ7lkcV89QY8y7jc8h9MGp
         PemPotCNSORClgwMYqbG5O5NYOuUnOOGIasWvPZtjKl7ouax7JO76umgU8B3vergfV9/
         4TexbXs9tPhVy6GdelWLXufcdhjffbm2R91zI3ygOYvQ5YzPSqcTQMa1mx3c/W/HO075
         FDX+H7CzEVmcKrT1eXF0PsgaPiLpVp/0nw7p7zMF6XdYCIyl9hCPJwhBVgvcKHvUBBA6
         jWgaacxUTtLg5mowtNtLthnfcCYh5N5yLHZgJAMwwYnny765lL3V3FUyGTZdvbPBqogB
         g7iw==
X-Gm-Message-State: AOAM531HQRrji7B4v92xKg3yRjZDpJJs9+D9OOou7wVX7NYVlBymxtnx
        Vrsb3Om8Wsgtgne715TDFDz0i/f88jCp5lG5
X-Google-Smtp-Source: ABdhPJynmLtLApXFsbS+kAMwy1Yefq6f5/LuMM27GbzFftzvwERUexCVl8Rh78mf2k51TgS2i6h9Bg==
X-Received: by 2002:a05:600c:4408:: with SMTP id u8mr24131492wmn.177.1639498606480;
        Tue, 14 Dec 2021 08:16:46 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a9sm295116wrt.66.2021.12.14.08.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 08:16:46 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mjpeg-users@lists.sourceforge.net,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 06/18] staging: media: zoran: merge all modules
Date:   Tue, 14 Dec 2021 16:16:24 +0000
Message-Id: <20211214161636.1886900-7-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214161636.1886900-1-clabbe@baylibre.com>
References: <20211214161636.1886900-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zoran driver is split in many modules, but this lead to some
problems.
One of them is that load order is incorrect when everything is built-in.

Having more than one module is useless, so merge all zoran modules in
one.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/Kconfig      |  14 +--
 drivers/staging/media/zoran/Makefile     |   8 +-
 drivers/staging/media/zoran/videocodec.c |  36 +------
 drivers/staging/media/zoran/videocodec.h |   1 -
 drivers/staging/media/zoran/zoran_card.c | 119 +++++++++++++++++++----
 drivers/staging/media/zoran/zr36016.c    |  13 +--
 drivers/staging/media/zoran/zr36016.h    |   2 +
 drivers/staging/media/zoran/zr36050.c    |  16 +--
 drivers/staging/media/zoran/zr36050.h    |   2 +
 drivers/staging/media/zoran/zr36060.c    |  14 +--
 drivers/staging/media/zoran/zr36060.h    |   2 +
 11 files changed, 125 insertions(+), 102 deletions(-)

diff --git a/drivers/staging/media/zoran/Kconfig b/drivers/staging/media/zoran/Kconfig
index 6d6e4c93f873..4067fa93d44d 100644
--- a/drivers/staging/media/zoran/Kconfig
+++ b/drivers/staging/media/zoran/Kconfig
@@ -15,7 +15,7 @@ config VIDEO_ZORAN
 	  module will be called zr36067.
 
 config VIDEO_ZORAN_DC30
-	tristate "Pinnacle/Miro DC30(+) support"
+	bool "Pinnacle/Miro DC30(+) support"
 	depends on VIDEO_ZORAN
 	select VIDEO_ADV7175 if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_VPX3220 if MEDIA_SUBDRV_AUTOSELECT
@@ -25,7 +25,7 @@ config VIDEO_ZORAN_DC30
 	  zr36050 MJPEG codec and zr36016 VFE.
 
 config VIDEO_ZORAN_ZR36060
-	tristate "Zoran ZR36060"
+	bool "Zoran ZR36060"
 	depends on VIDEO_ZORAN
 	help
 	  Say Y to support Zoran boards based on 36060 chips.
@@ -33,7 +33,7 @@ config VIDEO_ZORAN_ZR36060
 	  and 33 R10 and AverMedia 6 boards.
 
 config VIDEO_ZORAN_BUZ
-	tristate "Iomega Buz support"
+	bool "Iomega Buz support"
 	depends on VIDEO_ZORAN_ZR36060
 	select VIDEO_SAA711X if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_SAA7185 if MEDIA_SUBDRV_AUTOSELECT
@@ -41,7 +41,7 @@ config VIDEO_ZORAN_BUZ
 	  Support for the Iomega Buz MJPEG capture/playback card.
 
 config VIDEO_ZORAN_DC10
-	tristate "Pinnacle/Miro DC10(+) support"
+	bool "Pinnacle/Miro DC10(+) support"
 	depends on VIDEO_ZORAN_ZR36060
 	select VIDEO_SAA7110 if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_ADV7175 if MEDIA_SUBDRV_AUTOSELECT
@@ -50,7 +50,7 @@ config VIDEO_ZORAN_DC10
 	  card.
 
 config VIDEO_ZORAN_LML33
-	tristate "Linux Media Labs LML33 support"
+	bool "Linux Media Labs LML33 support"
 	depends on VIDEO_ZORAN_ZR36060
 	select VIDEO_BT819 if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_BT856 if MEDIA_SUBDRV_AUTOSELECT
@@ -59,7 +59,7 @@ config VIDEO_ZORAN_LML33
 	  card.
 
 config VIDEO_ZORAN_LML33R10
-	tristate "Linux Media Labs LML33R10 support"
+	bool "Linux Media Labs LML33R10 support"
 	depends on VIDEO_ZORAN_ZR36060
 	select VIDEO_SAA711X if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_ADV7170 if MEDIA_SUBDRV_AUTOSELECT
@@ -68,7 +68,7 @@ config VIDEO_ZORAN_LML33R10
 	  card.
 
 config VIDEO_ZORAN_AVS6EYES
-	tristate "AverMedia 6 Eyes support"
+	bool "AverMedia 6 Eyes support"
 	depends on VIDEO_ZORAN_ZR36060
 	select VIDEO_BT856 if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_BT866 if MEDIA_SUBDRV_AUTOSELECT
diff --git a/drivers/staging/media/zoran/Makefile b/drivers/staging/media/zoran/Makefile
index 7023158e3892..9603bac0195c 100644
--- a/drivers/staging/media/zoran/Makefile
+++ b/drivers/staging/media/zoran/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 zr36067-objs	:=	zoran_device.o \
-			zoran_driver.o zoran_card.o
+			zoran_driver.o zoran_card.o videocodec.o
 
-obj-$(CONFIG_VIDEO_ZORAN) += zr36067.o videocodec.o
-obj-$(CONFIG_VIDEO_ZORAN_DC30) += zr36050.o zr36016.o
-obj-$(CONFIG_VIDEO_ZORAN_ZR36060) += zr36060.o
+obj-$(CONFIG_VIDEO_ZORAN) += zr36067.o
+zr36067-$(CONFIG_VIDEO_ZORAN_DC30) += zr36050.o zr36016.o
+zr36067-$(CONFIG_VIDEO_ZORAN_ZR36060) += zr36060.o
diff --git a/drivers/staging/media/zoran/videocodec.c b/drivers/staging/media/zoran/videocodec.c
index 5bab7ba56257..3af7d02bd910 100644
--- a/drivers/staging/media/zoran/videocodec.c
+++ b/drivers/staging/media/zoran/videocodec.c
@@ -8,8 +8,6 @@
  * (c) 2002 Wolfgang Scherr <scherr@net4you.at>
  */
 
-#define VIDEOCODEC_VERSION "v0.2"
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -72,12 +70,9 @@ struct videocodec *videocodec_attach(struct videocodec_master *master)
 		if ((master->flags & h->codec->flags) == master->flags) {
 			dprintk(4, "%s: try '%s'\n", __func__, h->codec->name);
 
-			if (!try_module_get(h->codec->owner))
-				return NULL;
-
 			codec = kmemdup(h->codec, sizeof(struct videocodec), GFP_KERNEL);
 			if (!codec)
-				goto out_module_put;
+				goto out_kfree;
 
 			res = strlen(codec->name);
 			snprintf(codec->name + res, sizeof(codec->name) - res, "[%d]", h->attached);
@@ -113,13 +108,10 @@ struct videocodec *videocodec_attach(struct videocodec_master *master)
 	pr_err("%s: no codec found!\n", __func__);
 	return NULL;
 
- out_module_put:
-	module_put(h->codec->owner);
  out_kfree:
 	kfree(codec);
 	return NULL;
 }
-EXPORT_SYMBOL(videocodec_attach);
 
 int videocodec_detach(struct videocodec *codec)
 {
@@ -160,7 +152,6 @@ int videocodec_detach(struct videocodec *codec)
 					prev->next = a->next;
 					dprintk(4, "videocodec: delete middle\n");
 				}
-				module_put(a->codec->owner);
 				kfree(a->codec);
 				kfree(a);
 				h->attached -= 1;
@@ -175,7 +166,6 @@ int videocodec_detach(struct videocodec *codec)
 	pr_err("%s: given codec not found!\n", __func__);
 	return -EINVAL;
 }
-EXPORT_SYMBOL(videocodec_detach);
 
 int videocodec_register(const struct videocodec *codec)
 {
@@ -208,7 +198,6 @@ int videocodec_register(const struct videocodec *codec)
 
 	return 0;
 }
-EXPORT_SYMBOL(videocodec_register);
 
 int videocodec_unregister(const struct videocodec *codec)
 {
@@ -255,7 +244,6 @@ int videocodec_unregister(const struct videocodec *codec)
 	pr_err("%s: given codec not found!\n", __func__);
 	return -EINVAL;
 }
-EXPORT_SYMBOL(videocodec_unregister);
 
 int videocodec_debugfs_show(struct seq_file *m)
 {
@@ -284,25 +272,3 @@ int videocodec_debugfs_show(struct seq_file *m)
 
 	return 0;
 }
-
-/* ===================== */
-/* hook in driver module */
-/* ===================== */
-static int __init videocodec_init(void)
-{
-	pr_info("Linux video codec intermediate layer: %s\n", VIDEOCODEC_VERSION);
-
-	return 0;
-}
-
-static void __exit videocodec_exit(void)
-{
-}
-
-module_init(videocodec_init);
-module_exit(videocodec_exit);
-
-MODULE_AUTHOR("Wolfgang Scherr <scherr@net4you.at>");
-MODULE_DESCRIPTION("Intermediate API module for video codecs "
-		   VIDEOCODEC_VERSION);
-MODULE_LICENSE("GPL");
diff --git a/drivers/staging/media/zoran/videocodec.h b/drivers/staging/media/zoran/videocodec.h
index 3a508d326049..9dea348fee40 100644
--- a/drivers/staging/media/zoran/videocodec.h
+++ b/drivers/staging/media/zoran/videocodec.h
@@ -234,7 +234,6 @@ struct jpeg_app_marker {
 };
 
 struct videocodec {
-	struct module *owner;
 	/* -- filled in by slave device during register -- */
 	char name[32];
 	unsigned long magic;	/* may be used for client<->master attaching */
diff --git a/drivers/staging/media/zoran/zoran_card.c b/drivers/staging/media/zoran/zoran_card.c
index 28a3363a8838..a7750442ef9e 100644
--- a/drivers/staging/media/zoran/zoran_card.c
+++ b/drivers/staging/media/zoran/zoran_card.c
@@ -29,6 +29,9 @@
 #include "zoran.h"
 #include "zoran_card.h"
 #include "zoran_device.h"
+#include "zr36016.h"
+#include "zr36050.h"
+#include "zr36060.h"
 
 extern const struct zoran_format zoran_formats[];
 
@@ -266,6 +269,96 @@ static const char *codecid_to_modulename(u16 codecid)
 	return name;
 }
 
+static int codec_init(struct zoran *zr, u16 codecid)
+{
+	switch (codecid) {
+	case CODEC_TYPE_ZR36060:
+#ifdef CONFIG_VIDEO_ZORAN_ZR36060
+		return zr36060_init_module();
+#else
+		pci_err(zr->pci_dev, "ZR36060 support is not enabled\n");
+		return -EINVAL;
+#endif
+		break;
+	case CODEC_TYPE_ZR36050:
+#ifdef CONFIG_VIDEO_ZORAN_DC30
+		return zr36050_init_module();
+#else
+		pci_err(zr->pci_dev, "ZR36050 support is not enabled\n");
+		return -EINVAL;
+#endif
+		break;
+	case CODEC_TYPE_ZR36016:
+#ifdef CONFIG_VIDEO_ZORAN_DC30
+		return zr36016_init_module();
+#else
+		pci_err(zr->pci_dev, "ZR36016 support is not enabled\n");
+		return -EINVAL;
+#endif
+		break;
+	}
+
+	pci_err(zr->pci_dev, "unknown codec id %x\n", codecid);
+	return -EINVAL;
+}
+
+static void codec_exit(struct zoran *zr, u16 codecid)
+{
+	switch (codecid) {
+	case CODEC_TYPE_ZR36060:
+#ifdef CONFIG_VIDEO_ZORAN_ZR36060
+		zr36060_cleanup_module();
+#endif
+		break;
+	case CODEC_TYPE_ZR36050:
+#ifdef CONFIG_VIDEO_ZORAN_DC30
+		zr36050_cleanup_module();
+#endif
+		break;
+	case CODEC_TYPE_ZR36016:
+#ifdef CONFIG_VIDEO_ZORAN_DC30
+		zr36016_cleanup_module();
+#endif
+		break;
+	}
+}
+
+static int videocodec_init(struct zoran *zr)
+{
+	const char *codec_name, *vfe_name;
+	int result;
+
+	codec_name = codecid_to_modulename(zr->card.video_codec);
+	if (codec_name) {
+		result = codec_init(zr, zr->card.video_codec);
+		if (result < 0) {
+			pci_err(zr->pci_dev, "failed to load video codec %s: %d\n",
+				codec_name, result);
+			return result;
+		}
+	}
+	vfe_name = codecid_to_modulename(zr->card.video_vfe);
+	if (vfe_name) {
+		result = codec_init(zr, zr->card.video_vfe);
+		if (result < 0) {
+			pci_err(zr->pci_dev, "failed to load video vfe %s: %d\n",
+				vfe_name, result);
+			if (codec_name)
+				codec_exit(zr, zr->card.video_codec);
+			return result;
+		}
+	}
+	return 0;
+}
+
+static void videocodec_exit(struct zoran *zr)
+{
+	if (zr->card.video_codec != CODEC_TYPE_NONE)
+		codec_exit(zr, zr->card.video_codec);
+	if (zr->card.video_vfe != CODEC_TYPE_NONE)
+		codec_exit(zr, zr->card.video_vfe);
+}
+
 // struct tvnorm {
 //      u16 wt, wa, h_start, h_sync_start, ht, ha, v_start;
 // };
@@ -954,6 +1047,7 @@ static void zoran_remove(struct pci_dev *pdev)
 		videocodec_detach(zr->codec);
 	if (zr->vfe)
 		videocodec_detach(zr->vfe);
+	videocodec_exit(zr);
 
 	/* unregister i2c bus */
 	zoran_unregister_i2c(zr);
@@ -1079,6 +1173,8 @@ static int zoran_debugfs_show(struct seq_file *seq, void *v)
 
 	seq_printf(seq, "Prepared %u\n", zr->prepared);
 	seq_printf(seq, "Queued %u\n", zr->queued);
+
+	videocodec_debugfs_show(seq);
 	return 0;
 }
 
@@ -1096,7 +1192,6 @@ static int zoran_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct videocodec_master *master_vfe = NULL;
 	struct videocodec_master *master_codec = NULL;
 	int card_num;
-	const char *codec_name, *vfe_name;
 	unsigned int nr;
 	int err;
 
@@ -1258,23 +1353,9 @@ static int zoran_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 						  zr->card.addrs_encoder);
 
 	pci_info(zr->pci_dev, "Initializing videocodec bus...\n");
-
-	if (zr->card.video_codec) {
-		codec_name = codecid_to_modulename(zr->card.video_codec);
-		if (codec_name) {
-			result = request_module(codec_name);
-			if (result)
-				pci_err(pdev, "failed to load modules %s: %d\n", codec_name, result);
-		}
-	}
-	if (zr->card.video_vfe) {
-		vfe_name = codecid_to_modulename(zr->card.video_vfe);
-		if (vfe_name) {
-			result = request_module(vfe_name);
-			if (result < 0)
-				pci_err(pdev, "failed to load modules %s: %d\n", vfe_name, result);
-		}
-	}
+	err = videocodec_init(zr);
+	if (err)
+		goto zr_unreg_i2c;
 
 	/* reset JPEG codec */
 	jpeg_codec_sleep(zr, 1);
@@ -1328,6 +1409,8 @@ static int zoran_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	videocodec_detach(zr->vfe);
 zr_detach_codec:
 	videocodec_detach(zr->codec);
+zr_unreg_videocodec:
+	videocodec_exit(zr);
 zr_unreg_i2c:
 	zoran_unregister_i2c(zr);
 zr_free_irq:
diff --git a/drivers/staging/media/zoran/zr36016.c b/drivers/staging/media/zoran/zr36016.c
index 50605460a44b..26c7c32b6bc0 100644
--- a/drivers/staging/media/zoran/zr36016.c
+++ b/drivers/staging/media/zoran/zr36016.c
@@ -390,7 +390,6 @@ static int zr36016_setup(struct videocodec *codec)
 }
 
 static const struct videocodec zr36016_codec = {
-	.owner = THIS_MODULE,
 	.name = "zr36016",
 	.magic = 0L,		/* magic not used */
 	.flags =
@@ -409,14 +408,13 @@ static const struct videocodec zr36016_codec = {
    HOOK IN DRIVER AS KERNEL MODULE
    ========================================================================= */
 
-static int __init zr36016_init_module(void)
+int zr36016_init_module(void)
 {
-	//dprintk(1, "ZR36016 driver %s\n",ZR016_VERSION);
 	zr36016_codecs = 0;
 	return videocodec_register(&zr36016_codec);
 }
 
-static void __exit zr36016_cleanup_module(void)
+void zr36016_cleanup_module(void)
 {
 	if (zr36016_codecs) {
 		dprintk(1,
@@ -425,10 +423,3 @@ static void __exit zr36016_cleanup_module(void)
 	}
 	videocodec_unregister(&zr36016_codec);
 }
-
-module_init(zr36016_init_module);
-module_exit(zr36016_cleanup_module);
-
-MODULE_AUTHOR("Wolfgang Scherr <scherr@net4you.at>");
-MODULE_DESCRIPTION("Driver module for ZR36016 video frontends");
-MODULE_LICENSE("GPL");
diff --git a/drivers/staging/media/zoran/zr36016.h b/drivers/staging/media/zoran/zr36016.h
index 1475f971cc24..04afba35669d 100644
--- a/drivers/staging/media/zoran/zr36016.h
+++ b/drivers/staging/media/zoran/zr36016.h
@@ -89,4 +89,6 @@ struct zr36016 {
 #define ZR016_SIGN           0x02
 #define ZR016_YMCS           0x01
 
+int zr36016_init_module(void);
+void zr36016_cleanup_module(void);
 #endif				/*fndef ZR36016_H */
diff --git a/drivers/staging/media/zoran/zr36050.c b/drivers/staging/media/zoran/zr36050.c
index 4dc7927fefc3..38f7021e7b06 100644
--- a/drivers/staging/media/zoran/zr36050.c
+++ b/drivers/staging/media/zoran/zr36050.c
@@ -5,8 +5,6 @@
  * Copyright (C) 2001 Wolfgang Scherr <scherr@net4you.at>
  */
 
-#define ZR050_VERSION "v0.7.1"
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -798,7 +796,6 @@ static int zr36050_setup(struct videocodec *codec)
 }
 
 static const struct videocodec zr36050_codec = {
-	.owner = THIS_MODULE,
 	.name = "zr36050",
 	.magic = 0L,		// magic not used
 	.flags =
@@ -817,14 +814,13 @@ static const struct videocodec zr36050_codec = {
    HOOK IN DRIVER AS KERNEL MODULE
    ========================================================================= */
 
-static int __init zr36050_init_module(void)
+int zr36050_init_module(void)
 {
-	//dprintk(1, "ZR36050 driver %s\n",ZR050_VERSION);
 	zr36050_codecs = 0;
 	return videocodec_register(&zr36050_codec);
 }
 
-static void __exit zr36050_cleanup_module(void)
+void zr36050_cleanup_module(void)
 {
 	if (zr36050_codecs) {
 		dprintk(1,
@@ -833,11 +829,3 @@ static void __exit zr36050_cleanup_module(void)
 	}
 	videocodec_unregister(&zr36050_codec);
 }
-
-module_init(zr36050_init_module);
-module_exit(zr36050_cleanup_module);
-
-MODULE_AUTHOR("Wolfgang Scherr <scherr@net4you.at>");
-MODULE_DESCRIPTION("Driver module for ZR36050 jpeg processors "
-		   ZR050_VERSION);
-MODULE_LICENSE("GPL");
diff --git a/drivers/staging/media/zoran/zr36050.h b/drivers/staging/media/zoran/zr36050.h
index 8f972d045b58..f9b58f4c77b9 100644
--- a/drivers/staging/media/zoran/zr36050.h
+++ b/drivers/staging/media/zoran/zr36050.h
@@ -160,4 +160,6 @@ struct zr36050 {
 #define ZR050_U_COMPONENT         1
 #define ZR050_V_COMPONENT         2
 
+int zr36050_init_module(void);
+void zr36050_cleanup_module(void);
 #endif				/*fndef ZR36050_H */
diff --git a/drivers/staging/media/zoran/zr36060.c b/drivers/staging/media/zoran/zr36060.c
index 7904d5b1f402..d0c369e31c81 100644
--- a/drivers/staging/media/zoran/zr36060.c
+++ b/drivers/staging/media/zoran/zr36060.c
@@ -5,8 +5,6 @@
  * Copyright (C) 2002 Laurent Pinchart <laurent.pinchart@skynet.be>
  */
 
-#define ZR060_VERSION "v0.7"
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -831,7 +829,6 @@ static int zr36060_setup(struct videocodec *codec)
 }
 
 static const struct videocodec zr36060_codec = {
-	.owner = THIS_MODULE,
 	.name = "zr36060",
 	.magic = 0L,		// magic not used
 	.flags =
@@ -846,13 +843,13 @@ static const struct videocodec zr36060_codec = {
 	// others are not used
 };
 
-static int __init zr36060_init_module(void)
+int zr36060_init_module(void)
 {
 	zr36060_codecs = 0;
 	return videocodec_register(&zr36060_codec);
 }
 
-static void __exit zr36060_cleanup_module(void)
+void zr36060_cleanup_module(void)
 {
 	if (zr36060_codecs) {
 		dprintk(1,
@@ -863,10 +860,3 @@ static void __exit zr36060_cleanup_module(void)
 	/* however, we can't just stay alive */
 	videocodec_unregister(&zr36060_codec);
 }
-
-module_init(zr36060_init_module);
-module_exit(zr36060_cleanup_module);
-
-MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart@skynet.be>");
-MODULE_DESCRIPTION("Driver module for ZR36060 jpeg processors " ZR060_VERSION);
-MODULE_LICENSE("GPL");
diff --git a/drivers/staging/media/zoran/zr36060.h b/drivers/staging/media/zoran/zr36060.h
index d2cdc26bf625..fbf5429534ac 100644
--- a/drivers/staging/media/zoran/zr36060.h
+++ b/drivers/staging/media/zoran/zr36060.h
@@ -198,4 +198,6 @@ struct zr36060 {
 #define ZR060_SR_H_SCALE2		 BIT(0)
 #define ZR060_SR_H_SCALE4		(2 << 0)
 
+int zr36060_init_module(void);
+void zr36060_cleanup_module(void);
 #endif				/*fndef ZR36060_H */
-- 
2.32.0

