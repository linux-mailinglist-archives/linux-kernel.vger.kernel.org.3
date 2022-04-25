Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D284D50E381
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242544AbiDYOoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbiDYOoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:44:19 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48851CB03;
        Mon, 25 Apr 2022 07:41:14 -0700 (PDT)
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 466202C1DB4;
        Mon, 25 Apr 2022 14:41:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a217.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 77C052C26D2;
        Mon, 25 Apr 2022 14:41:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1650897665; a=rsa-sha256;
        cv=none;
        b=GYdyTQKUbDhCYxetgr2SjFaMCBXFLEZ+iIHZ7uI9DWrfwQbcRSorI2Ib49bOYkp+mnwZsX
        X1WQKnDY0xYXcXeXHHsfdq6KNYfDqPC4nRIKbYhWEpSBUsyD3O7Q2KT9/oyjILsv2TChiL
        oWPPXkv0yZgGgSjse7xnoil3FQWi+LkC8gEw/XA0uh/3zMD3mkaWFfdqYQrKAzse+cZA5d
        ZcdF3Ob9GfOY9ldcq0sEjyLpEk72O2glOzO5B+lWjlPyjK8cOKg/Qz5+XPuCC0yP84SG36
        d1er8+to8eyRvXLTQVBQXXbTsGq5p5RwmfUyelXsnNAB46WI9QT4w4SwWhr9Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1650897665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=+psUphEJW6Umr1LIo6q4QeNSaZlC5n4VwlbP0vJs6YU=;
        b=EvTx6N6gVhvdqjf2eB0p4I28h5WysRE8GY1lT1mai2M9EN/qORsZ62emRp+nKrk+LID5NS
        I/7CFqreKCkNEBXGaS9KAG3YnWSueNDCOxoKX1bUp/WPLqp9bajvwhj7+UVi7iDP45w8lM
        R4cz43Ucl0dAeyP0Kh2ClX8/zqd2qwnoV2D+jeehxT1cUiVznkMoYeTdHhE0mJtJ13+vdp
        fXad8TWYvrR8F/n54I7LvtosPASSZuczggXbhZYnTVKelAQ8TZxrchXctvI+wv5ERt0KvR
        1F6dzqKB0LmT5WXmGkFp+DMM2yy7Ovq+zDNGhWj2Vf9GVEEieAjyV5w8c9eKyw==
ARC-Authentication-Results: i=1;
        rspamd-67b64f579b-vgdqh;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Little-Skirt: 2d992c1b0486d142_1650897665962_903589680
X-MC-Loop-Signature: 1650897665962:279871743
X-MC-Ingress-Time: 1650897665961
Received: from pdx1-sub0-mail-a217.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.107.255.136 (trex/6.7.1);
        Mon, 25 Apr 2022 14:41:05 +0000
Received: from localhost.localdomain (unknown [69.12.38.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a217.dreamhost.com (Postfix) with ESMTPSA id 4Kn7400g0jz1Rf;
        Mon, 25 Apr 2022 07:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1650897665;
        bh=+psUphEJW6Umr1LIo6q4QeNSaZlC5n4VwlbP0vJs6YU=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=tfwUCy6OL4WnEaOQKzkIvN6N7FsDWNVDd6JiqcC8Dibj43YrnKrtcAUhlLriMLIcr
         Aaz/VPkbNTLQGkhiKGzFVSxT6mgRPcqbAFzchUl05AIevUHGZIlAHRutPKV9JTUAEE
         aRhUOou6LjPYb5U1sC4/HoE/a+dJV9zoeM6emyns8qy3UvSSU+mjbJjxrfD7xwopzz
         uzAuSol1ZU/k9yifWLoanVWeHOj1cBMSPR4gjr7N2HXbddwkamo0Vhv0hi6LagnJYN
         tl0LssNYKFFR2I3G1sLa67EUD0HQKzT4IAZYDoR8pOXPjRnM5hydjoUskTyAvsq/25
         zQu0nQdPnF7fA==
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ian Cowan <ian@linux.cowan.aero>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2 3/4] staging: media: zoran: replace all pr_err() with zrdev_err()
Date:   Mon, 25 Apr 2022 10:40:50 -0400
Message-Id: <20220425144050.133104-1-ian@linux.cowan.aero>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This replaces all of the pr_err() calls to the preferred zrdev_err()
macro that calls the dev_dbg() macro.

Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
---
 drivers/staging/media/zoran/videocodec.c | 32 +++++++++++++-----------
 drivers/staging/media/zoran/zr36016.c    | 28 +++++++++++++--------
 drivers/staging/media/zoran/zr36050.c    |  5 ++--
 drivers/staging/media/zoran/zr36060.c    | 19 +++++++++-----
 4 files changed, 52 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/media/zoran/videocodec.c b/drivers/staging/media/zoran/videocodec.c
index 3af7d02bd910..cabb291d302c 100644
--- a/drivers/staging/media/zoran/videocodec.c
+++ b/drivers/staging/media/zoran/videocodec.c
@@ -47,20 +47,21 @@ static struct codec_list *codeclist_top;
 struct videocodec *videocodec_attach(struct videocodec_master *master)
 {
 	struct codec_list *h = codeclist_top;
+	struct zoran *zr = videocodec_master_to_zoran(master);
 	struct attached_list *a, *ptr;
 	struct videocodec *codec;
 	int res;
 
 	if (!master) {
-		pr_err("%s: no data\n", __func__);
+		zrdev_err(zr, "%s: no data\n", __func__);
 		return NULL;
 	}
 
-	dprintk(2, "%s: '%s', flags %lx, magic %lx\n", __func__,
-		master->name, master->flags, master->magic);
+	zrdev_dbg(zr, "%s: '%s', flags %lx, magic %lx\n", __func__,
+		  master->name, master->flags, master->magic);
 
 	if (!h) {
-		pr_err("%s: no device available\n", __func__);
+		zrdev_err(zr, "%s: no device available\n", __func__);
 		return NULL;
 	}
 
@@ -105,7 +106,7 @@ struct videocodec *videocodec_attach(struct videocodec_master *master)
 		h = h->next;
 	}
 
-	pr_err("%s: no codec found!\n", __func__);
+	zrdev_err(zr, "%s: no codec found!\n", __func__);
 	return NULL;
 
  out_kfree:
@@ -116,11 +117,12 @@ struct videocodec *videocodec_attach(struct videocodec_master *master)
 int videocodec_detach(struct videocodec *codec)
 {
 	struct codec_list *h = codeclist_top;
+	struct zoran *zr = videocodec_to_zoran(codec);
 	struct attached_list *a, *prev;
 	int res;
 
 	if (!codec) {
-		pr_err("%s: no data\n", __func__);
+		zrdev_err(zr, "%s: no data\n", __func__);
 		return -EINVAL;
 	}
 
@@ -128,7 +130,7 @@ int videocodec_detach(struct videocodec *codec)
 		codec->name, codec->type, codec->flags, codec->magic);
 
 	if (!h) {
-		pr_err("%s: no device left...\n", __func__);
+		zrdev_err(zr, "%s: no device left...\n", __func__);
 		return -ENXIO;
 	}
 
@@ -142,7 +144,7 @@ int videocodec_detach(struct videocodec *codec)
 					dprintk(3, "%s: '%s'\n", __func__, a->codec->name);
 					a->codec->master_data = NULL;
 				} else {
-					pr_err("%s: '%s'\n", __func__, a->codec->name);
+					zrdev_err(zr, "%s: '%s'\n", __func__, a->codec->name);
 					a->codec->master_data = NULL;
 				}
 				if (!prev) {
@@ -163,16 +165,17 @@ int videocodec_detach(struct videocodec *codec)
 		h = h->next;
 	}
 
-	pr_err("%s: given codec not found!\n", __func__);
+	zrdev_err(zr, "%s: given codec not found!\n", __func__);
 	return -EINVAL;
 }
 
 int videocodec_register(const struct videocodec *codec)
 {
 	struct codec_list *ptr, *h = codeclist_top;
+	struct zoran *zr = videocodec_to_zoran((struct videocodec *)codec);
 
 	if (!codec) {
-		pr_err("%s: no data!\n", __func__);
+		zrdev_err(zr, "%s: no data!\n", __func__);
 		return -EINVAL;
 	}
 
@@ -202,9 +205,10 @@ int videocodec_register(const struct videocodec *codec)
 int videocodec_unregister(const struct videocodec *codec)
 {
 	struct codec_list *prev = NULL, *h = codeclist_top;
+	struct zoran *zr = videocodec_to_zoran((struct videocodec *)codec);
 
 	if (!codec) {
-		pr_err("%s: no data!\n", __func__);
+		zrdev_err(zr, "%s: no data!\n", __func__);
 		return -EINVAL;
 	}
 
@@ -213,14 +217,14 @@ int videocodec_unregister(const struct videocodec *codec)
 		codec->name, codec->type, codec->flags, codec->magic);
 
 	if (!h) {
-		pr_err("%s: no device left...\n", __func__);
+		zrdev_err(zr, "%s: no device left...\n", __func__);
 		return -ENXIO;
 	}
 
 	while (h) {
 		if (codec == h->codec) {
 			if (h->attached) {
-				pr_err("videocodec: '%s' is used\n", h->codec->name);
+				zrdev_err(zr, "videocodec: '%s' is used\n", h->codec->name);
 				return -EBUSY;
 			}
 			dprintk(3, "videocodec: unregister '%s' is ok.\n",
@@ -241,7 +245,7 @@ int videocodec_unregister(const struct videocodec *codec)
 		h = h->next;
 	}
 
-	pr_err("%s: given codec not found!\n", __func__);
+	zrdev_err(zr, "%s: given codec not found!\n", __func__);
 	return -EINVAL;
 }
 
diff --git a/drivers/staging/media/zoran/zr36016.c b/drivers/staging/media/zoran/zr36016.c
index 26c7c32b6bc0..3e3376af0cfa 100644
--- a/drivers/staging/media/zoran/zr36016.c
+++ b/drivers/staging/media/zoran/zr36016.c
@@ -26,7 +26,6 @@ static int zr36016_debug;
 module_param(zr36016_debug, int, 0);
 MODULE_PARM_DESC(zr36016_debug, "Debug level (0-4)");
 
-
 #define dprintk(num, format, args...) \
 	do { \
 		if (zr36016_debug >= num) \
@@ -42,13 +41,14 @@ MODULE_PARM_DESC(zr36016_debug, "Debug level (0-4)");
 /* read and write functions */
 static u8 zr36016_read(struct zr36016 *ptr, u16 reg)
 {
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 	u8 value = 0;
 
 	/* just in case something is wrong... */
 	if (ptr->codec->master_data->readreg)
 		value = (ptr->codec->master_data->readreg(ptr->codec, reg)) & 0xFF;
 	else
-		pr_err("%s: invalid I/O setup, nothing read!\n", ptr->name);
+		zrdev_err(zr, "%s: invalid I/O setup, nothing read!\n", ptr->name);
 
 	dprintk(4, "%s: reading from 0x%04x: %02x\n", ptr->name, reg, value);
 
@@ -57,13 +57,15 @@ static u8 zr36016_read(struct zr36016 *ptr, u16 reg)
 
 static void zr36016_write(struct zr36016 *ptr, u16 reg, u8 value)
 {
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
+
 	dprintk(4, "%s: writing 0x%02x to 0x%04x\n", ptr->name, value, reg);
 
 	// just in case something is wrong...
 	if (ptr->codec->master_data->writereg)
 		ptr->codec->master_data->writereg(ptr->codec, reg, value);
 	else
-		pr_err("%s: invalid I/O setup, nothing written!\n", ptr->name);
+		zrdev_err(zr, "%s: invalid I/O setup, nothing written!\n", ptr->name);
 }
 
 /* indirect read and write functions */
@@ -71,6 +73,7 @@ static void zr36016_write(struct zr36016 *ptr, u16 reg, u8 value)
  * writing it all time cost not much and is safer... */
 static u8 zr36016_readi(struct zr36016 *ptr, u16 reg)
 {
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 	u8 value = 0;
 
 	/* just in case something is wrong... */
@@ -78,7 +81,7 @@ static u8 zr36016_readi(struct zr36016 *ptr, u16 reg)
 		ptr->codec->master_data->writereg(ptr->codec, ZR016_IADDR, reg & 0x0F);	// ADDR
 		value = (ptr->codec->master_data->readreg(ptr->codec, ZR016_IDATA)) & 0xFF;	// DATA
 	} else {
-		pr_err("%s: invalid I/O setup, nothing read (i)!\n", ptr->name);
+		zrdev_err(zr, "%s: invalid I/O setup, nothing read (i)!\n", ptr->name);
 	}
 
 	dprintk(4, "%s: reading indirect from 0x%04x: %02x\n", ptr->name, reg, value);
@@ -87,6 +90,8 @@ static u8 zr36016_readi(struct zr36016 *ptr, u16 reg)
 
 static void zr36016_writei(struct zr36016 *ptr, u16 reg, u8 value)
 {
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
+
 	dprintk(4, "%s: writing indirect 0x%02x to 0x%04x\n", ptr->name,
 		value, reg);
 
@@ -95,7 +100,7 @@ static void zr36016_writei(struct zr36016 *ptr, u16 reg, u8 value)
 		ptr->codec->master_data->writereg(ptr->codec, ZR016_IADDR, reg & 0x0F);	// ADDR
 		ptr->codec->master_data->writereg(ptr->codec, ZR016_IDATA, value & 0x0FF);	// DATA
 	} else {
-		pr_err("%s: invalid I/O setup, nothing written (i)!\n", ptr->name);
+		zrdev_err(zr, "%s: invalid I/O setup, nothing written (i)!\n", ptr->name);
 	}
 }
 
@@ -120,6 +125,8 @@ static u8 zr36016_read_version(struct zr36016 *ptr)
 
 static int zr36016_basic_test(struct zr36016 *ptr)
 {
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
+
 	if (zr36016_debug) {
 		int i;
 
@@ -133,19 +140,19 @@ static int zr36016_basic_test(struct zr36016 *ptr)
 	// it back in both cases
 	zr36016_writei(ptr, ZR016I_PAX_LO, 0x00);
 	if (zr36016_readi(ptr, ZR016I_PAX_LO) != 0x0) {
-		pr_err("%s: attach failed, can't connect to vfe processor!\n", ptr->name);
+		zrdev_err(zr, "%s: attach failed, can't connect to vfe processor!\n", ptr->name);
 		return -ENXIO;
 	}
 	zr36016_writei(ptr, ZR016I_PAX_LO, 0x0d0);
 	if (zr36016_readi(ptr, ZR016I_PAX_LO) != 0x0d0) {
-		pr_err("%s: attach failed, can't connect to vfe processor!\n", ptr->name);
+		zrdev_err(zr, "%s: attach failed, can't connect to vfe processor!\n", ptr->name);
 		return -ENXIO;
 	}
 	// we allow version numbers from 0-3, should be enough, though
 	zr36016_read_version(ptr);
 	if (ptr->version & 0x0c) {
-		pr_err("%s: attach failed, suspicious version %d found...\n", ptr->name,
-		       ptr->version);
+		zrdev_err(zr, "%s: attach failed, suspicious version %d found...\n", ptr->name,
+			  ptr->version);
 		return -ENXIO;
 	}
 
@@ -351,13 +358,14 @@ static int zr36016_unset(struct videocodec *codec)
 
 static int zr36016_setup(struct videocodec *codec)
 {
+	struct zoran *zr = videocodec_to_zoran(codec);
 	struct zr36016 *ptr;
 	int res;
 
 	dprintk(2, "zr36016: initializing VFE subsystem #%d.\n", zr36016_codecs);
 
 	if (zr36016_codecs == MAX_CODECS) {
-		pr_err("zr36016: Can't attach more codecs!\n");
+		zrdev_err(zr, "zr36016: Can't attach more codecs!\n");
 		return -ENOSPC;
 	}
 	//mem structure init
diff --git a/drivers/staging/media/zoran/zr36050.c b/drivers/staging/media/zoran/zr36050.c
index 38f7021e7b06..950dd79f5c81 100644
--- a/drivers/staging/media/zoran/zr36050.c
+++ b/drivers/staging/media/zoran/zr36050.c
@@ -385,6 +385,7 @@ static int zr36050_set_dri(struct zr36050 *ptr)
    ========================================================================= */
 static void zr36050_init(struct zr36050 *ptr)
 {
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 	int sum = 0;
 	long bitcnt, tmp;
 
@@ -446,7 +447,7 @@ static void zr36050_init(struct zr36050 *ptr)
 			ptr->name, ptr->status1);
 
 		if ((ptr->status1 & 0x4) == 0) {
-			pr_err("%s: init aborted!\n", ptr->name);
+			zrdev_err(zr, "%s: init aborted!\n", ptr->name);
 			return;	// something is wrong, its timed out!!!!
 		}
 
@@ -515,7 +516,7 @@ static void zr36050_init(struct zr36050 *ptr)
 			ptr->name, ptr->status1);
 
 		if ((ptr->status1 & 0x4) == 0) {
-			pr_err("%s: init aborted!\n", ptr->name);
+			zrdev_err(zr, "%s: init aborted!\n", ptr->name);
 			return;	// something is wrong, its timed out!!!!
 		}
 
diff --git a/drivers/staging/media/zoran/zr36060.c b/drivers/staging/media/zoran/zr36060.c
index d0c369e31c81..c09910669585 100644
--- a/drivers/staging/media/zoran/zr36060.c
+++ b/drivers/staging/media/zoran/zr36060.c
@@ -50,26 +50,29 @@ MODULE_PARM_DESC(zr36060_debug, "Debug level (0-4)");
 
 static u8 zr36060_read(struct zr36060 *ptr, u16 reg)
 {
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 	u8 value = 0;
 
 	// just in case something is wrong...
 	if (ptr->codec->master_data->readreg)
 		value = (ptr->codec->master_data->readreg(ptr->codec, reg)) & 0xff;
 	else
-		pr_err("%s: invalid I/O setup, nothing read!\n", ptr->name);
+		zrdev_err(zr, "%s: invalid I/O setup, nothing read!\n", ptr->name);
 
 	return value;
 }
 
 static void zr36060_write(struct zr36060 *ptr, u16 reg, u8 value)
 {
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
+
 	dprintk(4, "0x%02x @0x%04x\n", value, reg);
 
 	// just in case something is wrong...
 	if (ptr->codec->master_data->writereg)
 		ptr->codec->master_data->writereg(ptr->codec, reg, value);
 	else
-		pr_err("%s: invalid I/O setup, nothing written!\n", ptr->name);
+		zrdev_err(zr, "%s: invalid I/O setup, nothing written!\n", ptr->name);
 }
 
 /* =========================================================================
@@ -117,15 +120,17 @@ static void zr36060_wait_end(struct zr36060 *ptr)
 /* Basic test of "connectivity", writes/reads to/from memory the SOF marker */
 static int zr36060_basic_test(struct zr36060 *ptr)
 {
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
+
 	if ((zr36060_read(ptr, ZR060_IDR_DEV) != 0x33) &&
 	    (zr36060_read(ptr, ZR060_IDR_REV) != 0x01)) {
-		pr_err("%s: attach failed, can't connect to jpeg processor!\n", ptr->name);
+		zrdev_err(zr, "%s: attach failed, can't connect to jpeg processor!\n", ptr->name);
 		return -ENXIO;
 	}
 
 	zr36060_wait_end(ptr);
 	if (ptr->status & ZR060_CFSR_BUSY) {
-		pr_err("%s: attach failed, jpeg processor failed (end flag)!\n", ptr->name);
+		zrdev_err(zr, "%s: attach failed, jpeg processor failed (end flag)!\n", ptr->name);
 		return -EBUSY;
 	}
 
@@ -319,6 +324,7 @@ static int zr36060_set_dri(struct zr36060 *ptr)
  */
 static void zr36060_init(struct zr36060 *ptr)
 {
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 	int sum = 0;
 	long bitcnt, tmp;
 
@@ -444,7 +450,7 @@ static void zr36060_init(struct zr36060 *ptr)
 	dprintk(2, "%s: Status after table preload: 0x%02x\n", ptr->name, ptr->status);
 
 	if (ptr->status & ZR060_CFSR_BUSY) {
-		pr_err("%s: init aborted!\n", ptr->name);
+		zrdev_err(zr, "%s: init aborted!\n", ptr->name);
 		return;		// something is wrong, its timed out!!!!
 	}
 }
@@ -777,13 +783,14 @@ static int zr36060_unset(struct videocodec *codec)
  */
 static int zr36060_setup(struct videocodec *codec)
 {
+	struct zoran *zr = videocodec_to_zoran(codec);
 	struct zr36060 *ptr;
 	int res;
 
 	dprintk(2, "zr36060: initializing MJPEG subsystem #%d.\n", zr36060_codecs);
 
 	if (zr36060_codecs == MAX_CODECS) {
-		pr_err("zr36060: Can't attach more codecs!\n");
+		zrdev_err(zr, "zr36060: Can't attach more codecs!\n");
 		return -ENOSPC;
 	}
 	//mem structure init
-- 
2.35.1

