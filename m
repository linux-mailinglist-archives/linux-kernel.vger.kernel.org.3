Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2268E51D0B1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 07:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389178AbiEFFdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 01:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389171AbiEFFcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 01:32:51 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D731DEEB;
        Thu,  5 May 2022 22:29:07 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E7B7921698;
        Fri,  6 May 2022 05:29:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a243.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 432622130F;
        Fri,  6 May 2022 05:29:06 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1651814946; a=rsa-sha256;
        cv=none;
        b=aG6cu4uqPVkvtCT6SW4YFK9PqmV0YhFo+uRNqRuzt2ki5qEJYCx81qUGhtTGD1G6Y+zlw5
        iMl0RF+SG2ftjng8M01SxXIUn8/fuEurlpusmQIn3MhMN8Ftz+HqUmJVHpYzgeVhW2bz41
        7Lm5mtlqYQ+d012GdTS/WgVkgpdOX7vl0W1MWNmQtK2qCcRfGwvasxdFiawd3efsINU5Pu
        fltcswQMzTXpyQa0tsdZFQiVMuVFvL8qhsaZ1ucnwdQZGyH1r8pBLtFcF8LlNJ4cwBnk/9
        of63RTlNxG5z9DpbYULc47xQPSfufThKKTASytHKTJySVyjO8FtdPQRlOgwA3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1651814946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=UvjmCA2tjg0QIc8lFVAb9904tB15YqiWxDu5r4yN82o=;
        b=xd/SO9NWbv22t3SwaE64jbyrsbCghpj5ED8cUiyj/qFEdKtBKJ7evg1JvDCvlMrg/t36Xt
        vadTIijsRl+8IZZ4ekXAYKKKiGs2iOB8j6OMJCj/vBfst8+8SBDi5zFX1qJuPrQe2lfJLd
        SAYlm8XmK0K5OAzAfL4KZPfzW7Qxy3j9CnlNfhv2NQCqJupqLhWOSwuUOfHThX2Mn2Z62G
        vJpZDbEgZHCaJRw7nyy9U7mEVMq4nD422CR9iU0rk1FkIXe6mku+JlFqLy0qi9IZTuaL4C
        QDfM7TSz2gBr820yzV9ge9WIGTQUNpWANEcLEFbkc3l/F+aGG+K/KPTf5XRSbg==
ARC-Authentication-Results: i=1;
        rspamd-fdd564cbf-flc6x;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Fumbling-Harbor: 51e7c2633cf42a7e_1651814946641_252179725
X-MC-Loop-Signature: 1651814946641:1086089919
X-MC-Ingress-Time: 1651814946641
Received: from pdx1-sub0-mail-a243.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.96.96.26 (trex/6.7.1);
        Fri, 06 May 2022 05:29:06 +0000
Received: from localhost.localdomain (unknown [69.12.38.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a243.dreamhost.com (Postfix) with ESMTPSA id 4KvfJ11ns4z2M;
        Thu,  5 May 2022 22:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1651814946;
        bh=UvjmCA2tjg0QIc8lFVAb9904tB15YqiWxDu5r4yN82o=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=Qxl41yK2TCfrp9AKf3YPn6tx47ThvkisbL/358VK/uoc1E24kkCyDIFyN8ey3M6N3
         +QO8X9y7srHhAohZVl2eHBcecECBrf6IHX8LBq946kL3U+UIMuBQV/FhwVMd8gEt47
         Of8xiKXHfwn8s9L4hNJBu1bWJwS1dLQuIN4Cv0s5CZKzKnuDawQWBt0Rd9l9smK7Qw
         KXbnvJs1WepNvrQ6N8MHB+F8xkM2UWZqk5Lxd8oUgds2pJlNMmy+zMwp20JVRE3pMm
         ZcYXceCBmMhgfJsOHr2548bbwPsi11L+HVVg0Pw+dF3QqdsNI29DT85uoSn/l1t7Sr
         3xnUDnGx6cgUQ==
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ian Cowan <ian@linux.cowan.aero>
Subject: [PATCH v3 4/4] staging: media: zoran: replace dprintk with new debugging macros
Date:   Fri,  6 May 2022 01:28:56 -0400
Message-Id: <20220506052856.192600-1-ian@linux.cowan.aero>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This replaces all of the dprintk macro calls with the zrdev_dbg,
zrdev_info, or zrdev_err calls as appropriate. This allows for the
removal of the dprintk macro from each file it is defined in, along with
the removal of module params that track the debugging level.

In the case that the debugging level was used in a comparison, this has
been replaced with checking the console level debugging and making a
decision from there. If the console debugging level is at least the
KERN_ debugging level equivalent, then the comparison will evaluate as
true.

There are a few instances where pr_debug must be used over the
zrdev_dbg. These occur in the module cleanup functions because there
should be no devices defined once we get here, so we don't have a device
to pass to zrdev_dbg.

Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
---
 drivers/staging/media/zoran/videocodec.c |  70 ++++++------
 drivers/staging/media/zoran/zr36016.c    |  64 +++++------
 drivers/staging/media/zoran/zr36050.c    | 139 +++++++++++------------
 drivers/staging/media/zoran/zr36060.c    |  78 ++++++-------
 4 files changed, 170 insertions(+), 181 deletions(-)

diff --git a/drivers/staging/media/zoran/videocodec.c b/drivers/staging/media/zoran/videocodec.c
index 27fdecd2bebe..a0c8bde5ec11 100644
--- a/drivers/staging/media/zoran/videocodec.c
+++ b/drivers/staging/media/zoran/videocodec.c
@@ -16,16 +16,6 @@
 
 #include "videocodec.h"
 
-static int videocodec_debug;
-module_param(videocodec_debug, int, 0);
-MODULE_PARM_DESC(videocodec_debug, "Debug level (0-4)");
-
-#define dprintk(num, format, args...) \
-	do { \
-		if (videocodec_debug >= num) \
-			printk(format, ##args); \
-	} while (0)
-
 struct attached_list {
 	struct videocodec *codec;
 	struct attached_list *next;
@@ -59,8 +49,8 @@ struct videocodec *videocodec_attach(struct videocodec_master *master)
 
 	zr = videocodec_master_to_zoran(master);
 
-	dprintk(2, "%s: '%s', flags %lx, magic %lx\n", __func__,
-		master->name, master->flags, master->magic);
+	zrdev_dbg(zr, "%s: '%s', flags %lx, magic %lx\n", __func__,
+		  master->name, master->flags, master->magic);
 
 	if (!h) {
 		zrdev_err(zr, "%s: no device available\n", __func__);
@@ -71,7 +61,7 @@ struct videocodec *videocodec_attach(struct videocodec_master *master)
 		// attach only if the slave has at least the flags
 		// expected by the master
 		if ((master->flags & h->codec->flags) == master->flags) {
-			dprintk(4, "%s: try '%s'\n", __func__, h->codec->name);
+			zrdev_dbg(zr, "%s: try '%s'\n", __func__, h->codec->name);
 
 			codec = kmemdup(h->codec, sizeof(struct videocodec), GFP_KERNEL);
 			if (!codec)
@@ -82,7 +72,7 @@ struct videocodec *videocodec_attach(struct videocodec_master *master)
 			codec->master_data = master;
 			res = codec->setup(codec);
 			if (res == 0) {
-				dprintk(3, "%s: '%s'\n", __func__, codec->name);
+				zrdev_dbg(zr, "%s: '%s'\n", __func__, codec->name);
 				ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
 				if (!ptr)
 					goto out_kfree;
@@ -91,12 +81,13 @@ struct videocodec *videocodec_attach(struct videocodec_master *master)
 				a = h->list;
 				if (!a) {
 					h->list = ptr;
-					dprintk(4, "videocodec: first element\n");
+					zrdev_dbg(zr, "videocodec: first element\n");
 				} else {
 					while (a->next)
 						a = a->next;	// find end
 					a->next = ptr;
-					dprintk(4, "videocodec: in after '%s'\n", h->codec->name);
+					zrdev_dbg(zr, "videocodec: in after '%s'\n",
+						  h->codec->name);
 				}
 
 				h->attached += 1;
@@ -130,8 +121,8 @@ int videocodec_detach(struct videocodec *codec)
 
 	zr = videocodec_to_zoran(codec);
 
-	dprintk(2, "%s: '%s', type: %x, flags %lx, magic %lx\n", __func__,
-		codec->name, codec->type, codec->flags, codec->magic);
+	zrdev_dbg(zr, "%s: '%s', type: %x, flags %lx, magic %lx\n", __func__,
+		  codec->name, codec->type, codec->flags, codec->magic);
 
 	if (!h) {
 		zrdev_err(zr, "%s: no device left...\n", __func__);
@@ -145,7 +136,8 @@ int videocodec_detach(struct videocodec *codec)
 			if (codec == a->codec) {
 				res = a->codec->unset(a->codec);
 				if (res >= 0) {
-					dprintk(3, "%s: '%s'\n", __func__, a->codec->name);
+					zrdev_dbg(zr, "%s: '%s'\n", __func__,
+						  a->codec->name);
 					a->codec->master_data = NULL;
 				} else {
 					zrdev_err(zr, "%s: '%s'\n", __func__, a->codec->name);
@@ -153,10 +145,10 @@ int videocodec_detach(struct videocodec *codec)
 				}
 				if (!prev) {
 					h->list = a->next;
-					dprintk(4, "videocodec: delete first\n");
+					zrdev_dbg(zr, "videocodec: delete first\n");
 				} else {
 					prev->next = a->next;
-					dprintk(4, "videocodec: delete middle\n");
+					zrdev_dbg(zr, "videocodec: delete middle\n");
 				}
 				kfree(a->codec);
 				kfree(a);
@@ -176,15 +168,18 @@ int videocodec_detach(struct videocodec *codec)
 int videocodec_register(const struct videocodec *codec)
 {
 	struct codec_list *ptr, *h = codeclist_top;
+	struct zoran *zr;
 
 	if (!codec) {
 		pr_err("%s: no data!\n", __func__);
 		return -EINVAL;
 	}
 
-	dprintk(2,
-		"videocodec: register '%s', type: %x, flags %lx, magic %lx\n",
-		codec->name, codec->type, codec->flags, codec->magic);
+	zr = videocodec_to_zoran((struct videocodec *)codec);
+
+	zrdev_dbg(zr,
+		  "videocodec: register '%s', type: %x, flags %lx, magic %lx\n",
+		  codec->name, codec->type, codec->flags, codec->magic);
 
 	ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)
@@ -193,13 +188,13 @@ int videocodec_register(const struct videocodec *codec)
 
 	if (!h) {
 		codeclist_top = ptr;
-		dprintk(4, "videocodec: hooked in as first element\n");
+		zrdev_dbg(zr, "videocodec: hooked in as first element\n");
 	} else {
 		while (h->next)
 			h = h->next;	// find the end
 		h->next = ptr;
-		dprintk(4, "videocodec: hooked in after '%s'\n",
-			h->codec->name);
+		zrdev_dbg(zr, "videocodec: hooked in after '%s'\n",
+			  h->codec->name);
 	}
 
 	return 0;
@@ -217,9 +212,9 @@ int videocodec_unregister(const struct videocodec *codec)
 
 	zr = videocodec_to_zoran((struct videocodec *)codec);
 
-	dprintk(2,
-		"videocodec: unregister '%s', type: %x, flags %lx, magic %lx\n",
-		codec->name, codec->type, codec->flags, codec->magic);
+	zrdev_dbg(zr,
+		  "videocodec: unregister '%s', type: %x, flags %lx, magic %lx\n",
+		  codec->name, codec->type, codec->flags, codec->magic);
 
 	if (!h) {
 		zrdev_err(zr, "%s: no device left...\n", __func__);
@@ -229,19 +224,20 @@ int videocodec_unregister(const struct videocodec *codec)
 	while (h) {
 		if (codec == h->codec) {
 			if (h->attached) {
-				zrdev_err(zr, "videocodec: '%s' is used\n", h->codec->name);
+				zrdev_err(zr, "videocodec: '%s' is used\n",
+					  h->codec->name);
 				return -EBUSY;
 			}
-			dprintk(3, "videocodec: unregister '%s' is ok.\n",
-				h->codec->name);
+			zrdev_dbg(zr, "videocodec: unregister '%s' is ok.\n",
+				  h->codec->name);
 			if (!prev) {
 				codeclist_top = h->next;
-				dprintk(4,
-					"videocodec: delete first element\n");
+				zrdev_dbg(zr,
+					  "videocodec: delete first element\n");
 			} else {
 				prev->next = h->next;
-				dprintk(4,
-					"videocodec: delete middle element\n");
+				zrdev_dbg(zr,
+					  "videocodec: delete middle element\n");
 			}
 			kfree(h);
 			return 0;
diff --git a/drivers/staging/media/zoran/zr36016.c b/drivers/staging/media/zoran/zr36016.c
index 953d93ccc897..0e0532537a3e 100644
--- a/drivers/staging/media/zoran/zr36016.c
+++ b/drivers/staging/media/zoran/zr36016.c
@@ -22,17 +22,6 @@
 /* amount of chips attached via this driver */
 static int zr36016_codecs;
 
-static int zr36016_debug;
-module_param(zr36016_debug, int, 0);
-MODULE_PARM_DESC(zr36016_debug, "Debug level (0-4)");
-
-
-#define dprintk(num, format, args...) \
-	do { \
-		if (zr36016_debug >= num) \
-			printk(format, ##args); \
-	} while (0)
-
 /* =========================================================================
    Local hardware I/O functions:
 
@@ -51,7 +40,7 @@ static u8 zr36016_read(struct zr36016 *ptr, u16 reg)
 	else
 		zrdev_err(zr, "%s: invalid I/O setup, nothing read!\n", ptr->name);
 
-	dprintk(4, "%s: reading from 0x%04x: %02x\n", ptr->name, reg, value);
+	zrdev_dbg(zr, "%s: reading from 0x%04x: %02x\n", ptr->name, reg, value);
 
 	return value;
 }
@@ -60,7 +49,7 @@ static void zr36016_write(struct zr36016 *ptr, u16 reg, u8 value)
 {
 	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 
-	dprintk(4, "%s: writing 0x%02x to 0x%04x\n", ptr->name, value, reg);
+	zrdev_dbg(zr, "%s: writing 0x%02x to 0x%04x\n", ptr->name, value, reg);
 
 	// just in case something is wrong...
 	if (ptr->codec->master_data->writereg)
@@ -85,7 +74,8 @@ static u8 zr36016_readi(struct zr36016 *ptr, u16 reg)
 		zrdev_err(zr, "%s: invalid I/O setup, nothing read (i)!\n", ptr->name);
 	}
 
-	dprintk(4, "%s: reading indirect from 0x%04x: %02x\n", ptr->name, reg, value);
+	zrdev_dbg(zr, "%s: reading indirect from 0x%04x: %02x\n",
+		  ptr->name, reg, value);
 	return value;
 }
 
@@ -93,8 +83,8 @@ static void zr36016_writei(struct zr36016 *ptr, u16 reg, u8 value)
 {
 	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 
-	dprintk(4, "%s: writing indirect 0x%02x to 0x%04x\n", ptr->name,
-		value, reg);
+	zrdev_dbg(zr, "%s: writing indirect 0x%02x to 0x%04x\n", ptr->name,
+		  value, reg);
 
 	/* just in case something is wrong... */
 	if (ptr->codec->master_data->writereg) {
@@ -128,14 +118,14 @@ static int zr36016_basic_test(struct zr36016 *ptr)
 {
 	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 
-	if (zr36016_debug) {
+	if (*KERN_INFO <= CONSOLE_LOGLEVEL_DEFAULT) {
 		int i;
 
 		zr36016_writei(ptr, ZR016I_PAX_LO, 0x55);
-		dprintk(1, KERN_INFO "%s: registers: ", ptr->name);
+		zrdev_dbg(zr, "%s: registers: ", ptr->name);
 		for (i = 0; i <= 0x0b; i++)
-			dprintk(1, "%02x ", zr36016_readi(ptr, i));
-		dprintk(1, "\n");
+			zrdev_dbg(zr, "%02x ", zr36016_readi(ptr, i));
+		zrdev_dbg(zr, "\n");
 	}
 	// for testing just write 0, then the default value to a register and read
 	// it back in both cases
@@ -172,10 +162,11 @@ static int zr36016_pushit(struct zr36016 *ptr,
 			   u16             len,
 			   const char     *data)
 {
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 	int i = 0;
 
-	dprintk(4, "%s: write data block to 0x%04x (len=%d)\n",
-		ptr->name, startreg, len);
+	zrdev_dbg(zr, "%s: write data block to 0x%04x (len=%d)\n",
+		  ptr->name, startreg, len);
 	while (i < len) {
 		zr36016_writei(ptr, startreg++,  data[i++]);
 	}
@@ -233,8 +224,9 @@ static void zr36016_init(struct zr36016 *ptr)
 static int zr36016_set_mode(struct videocodec *codec, int mode)
 {
 	struct zr36016 *ptr = (struct zr36016 *)codec->data;
+	struct zoran *zr = videocodec_to_zoran(codec);
 
-	dprintk(2, "%s: set_mode %d call\n", ptr->name, mode);
+	zrdev_dbg(zr, "%s: set_mode %d call\n", ptr->name, mode);
 
 	if ((mode != CODEC_DO_EXPANSION) && (mode != CODEC_DO_COMPRESSION))
 		return -EINVAL;
@@ -250,11 +242,12 @@ static int zr36016_set_video(struct videocodec *codec, const struct tvnorm *norm
 			     struct vfe_settings *cap, struct vfe_polarity *pol)
 {
 	struct zr36016 *ptr = (struct zr36016 *)codec->data;
+	struct zoran *zr = videocodec_to_zoran(codec);
 
-	dprintk(2, "%s: set_video %d.%d, %d/%d-%dx%d (0x%x) call\n",
-		ptr->name, norm->h_start, norm->v_start,
-		cap->x, cap->y, cap->width, cap->height,
-		cap->decimation);
+	zrdev_dbg(zr, "%s: set_video %d.%d, %d/%d-%dx%d (0x%x) call\n",
+		  ptr->name, norm->h_start, norm->v_start,
+		  cap->x, cap->y, cap->width, cap->height,
+		  cap->decimation);
 
 	/* if () return -EINVAL;
 	 * trust the master driver that it knows what it does - so
@@ -284,9 +277,11 @@ static int zr36016_set_video(struct videocodec *codec, const struct tvnorm *norm
 static int zr36016_control(struct videocodec *codec, int type, int size, void *data)
 {
 	struct zr36016 *ptr = (struct zr36016 *)codec->data;
+	struct zoran *zr = videocodec_to_zoran(codec);
 	int *ival = (int *)data;
 
-	dprintk(2, "%s: control %d call with %d byte\n", ptr->name, type, size);
+	zrdev_dbg(zr, "%s: control %d call with %d byte\n",
+		  ptr->name, type, size);
 
 	switch (type) {
 	case CODEC_G_STATUS:	/* get last status - we don't know it ... */
@@ -333,11 +328,12 @@ static int zr36016_control(struct videocodec *codec, int type, int size, void *d
 static int zr36016_unset(struct videocodec *codec)
 {
 	struct zr36016 *ptr = codec->data;
+	struct zoran *zr = videocodec_to_zoran(codec);
 
 	if (ptr) {
 		/* do wee need some codec deinit here, too ???? */
 
-		dprintk(1, "%s: finished codec #%d\n", ptr->name, ptr->num);
+		zrdev_dbg(zr, "%s: finished codec #%d\n", ptr->name, ptr->num);
 		kfree(ptr);
 		codec->data = NULL;
 
@@ -363,7 +359,7 @@ static int zr36016_setup(struct videocodec *codec)
 	struct zoran *zr = videocodec_to_zoran(codec);
 	int res;
 
-	dprintk(2, "zr36016: initializing VFE subsystem #%d.\n", zr36016_codecs);
+	zrdev_dbg(zr, "zr36016: initializing VFE subsystem #%d.\n", zr36016_codecs);
 
 	if (zr36016_codecs == MAX_CODECS) {
 		zrdev_err(zr, "zr36016: Can't attach more codecs!\n");
@@ -393,7 +389,8 @@ static int zr36016_setup(struct videocodec *codec)
 	ptr->ydec = 0;
 	zr36016_init(ptr);
 
-	dprintk(1, KERN_INFO "%s: codec v%d attached and running\n", ptr->name, ptr->version);
+	zrdev_dbg(zr, "%s: codec v%d attached and running\n",
+		  ptr->name, ptr->version);
 
 	return 0;
 }
@@ -426,9 +423,8 @@ int zr36016_init_module(void)
 void zr36016_cleanup_module(void)
 {
 	if (zr36016_codecs) {
-		dprintk(1,
-			"zr36016: something's wrong - %d codecs left somehow.\n",
-			zr36016_codecs);
+		pr_debug("zr36016: something's wrong - %d codecs left somehow.\n",
+			 zr36016_codecs);
 	}
 	videocodec_unregister(&zr36016_codec);
 }
diff --git a/drivers/staging/media/zoran/zr36050.c b/drivers/staging/media/zoran/zr36050.c
index 4a14fc3bffba..6a7ef28d996c 100644
--- a/drivers/staging/media/zoran/zr36050.c
+++ b/drivers/staging/media/zoran/zr36050.c
@@ -29,17 +29,6 @@
 /* amount of chips attached via this driver */
 static int zr36050_codecs;
 
-/* debugging is available via module parameter */
-static int zr36050_debug;
-module_param(zr36050_debug, int, 0);
-MODULE_PARM_DESC(zr36050_debug, "Debug level (0-4)");
-
-#define dprintk(num, format, args...) \
-	do { \
-		if (zr36050_debug >= num) \
-			printk(format, ##args); \
-	} while (0)
-
 /* =========================================================================
    Local hardware I/O functions:
 
@@ -49,32 +38,32 @@ MODULE_PARM_DESC(zr36050_debug, "Debug level (0-4)");
 /* read and write functions */
 static u8 zr36050_read(struct zr36050 *ptr, u16 reg)
 {
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 	u8 value = 0;
 
 	/* just in case something is wrong... */
 	if (ptr->codec->master_data->readreg)
 		value = (ptr->codec->master_data->readreg(ptr->codec, reg)) & 0xFF;
 	else
-		dprintk(1,
-			KERN_ERR "%s: invalid I/O setup, nothing read!\n", ptr->name);
+		zrdev_err(zr, "%s: invalid I/O setup, nothing read!\n", ptr->name);
 
-	dprintk(4, "%s: reading from 0x%04x: %02x\n", ptr->name, reg, value);
+	zrdev_dbg(zr, "%s: reading from 0x%04x: %02x\n", ptr->name, reg, value);
 
 	return value;
 }
 
 static void zr36050_write(struct zr36050 *ptr, u16 reg, u8 value)
 {
-	dprintk(4, "%s: writing 0x%02x to 0x%04x\n", ptr->name, value, reg);
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
+
+	zrdev_dbg(zr, "%s: writing 0x%02x to 0x%04x\n", ptr->name, value, reg);
 
 	/* just in case something is wrong... */
 	if (ptr->codec->master_data->writereg)
 		ptr->codec->master_data->writereg(ptr->codec, reg, value);
 	else
-		dprintk(1,
-			KERN_ERR
-			"%s: invalid I/O setup, nothing written!\n",
-			ptr->name);
+		zrdev_err(zr, "%s: invalid I/O setup, nothing written!\n",
+			  ptr->name);
 }
 
 /* =========================================================================
@@ -117,14 +106,15 @@ static u16 zr36050_read_scalefactor(struct zr36050 *ptr)
 
 static void zr36050_wait_end(struct zr36050 *ptr)
 {
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 	int i = 0;
 
 	while (!(zr36050_read_status1(ptr) & 0x4)) {
 		udelay(1);
 		if (i++ > 200000) {	// 200ms, there is for sure something wrong!!!
-			dprintk(1,
-				"%s: timeout at wait_end (last status: 0x%02x)\n",
-				ptr->name, ptr->status1);
+			zrdev_err(zr,
+				  "%s: timeout at wait_end (last status: 0x%02x)\n",
+				  ptr->name, ptr->status1);
 			break;
 		}
 	}
@@ -138,33 +128,32 @@ static void zr36050_wait_end(struct zr36050 *ptr)
 
 static int zr36050_basic_test(struct zr36050 *ptr)
 {
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
+
 	zr36050_write(ptr, ZR050_SOF_IDX, 0x00);
 	zr36050_write(ptr, ZR050_SOF_IDX + 1, 0x00);
 	if ((zr36050_read(ptr, ZR050_SOF_IDX) |
 	     zr36050_read(ptr, ZR050_SOF_IDX + 1)) != 0x0000) {
-		dprintk(1,
-			KERN_ERR
-			"%s: attach failed, can't connect to jpeg processor!\n",
-			ptr->name);
+		zrdev_err(zr,
+			  "%s: attach failed, can't connect to jpeg processor!\n",
+			  ptr->name);
 		return -ENXIO;
 	}
 	zr36050_write(ptr, ZR050_SOF_IDX, 0xff);
 	zr36050_write(ptr, ZR050_SOF_IDX + 1, 0xc0);
 	if (((zr36050_read(ptr, ZR050_SOF_IDX) << 8) |
 	     zr36050_read(ptr, ZR050_SOF_IDX + 1)) != 0xffc0) {
-		dprintk(1,
-			KERN_ERR
-			"%s: attach failed, can't connect to jpeg processor!\n",
-			ptr->name);
+		zrdev_err(zr,
+			  "%s: attach failed, can't connect to jpeg processor!\n",
+			  ptr->name);
 		return -ENXIO;
 	}
 
 	zr36050_wait_end(ptr);
 	if ((ptr->status1 & 0x4) == 0) {
-		dprintk(1,
-			KERN_ERR
-			"%s: attach failed, jpeg processor failed (end flag)!\n",
-			ptr->name);
+		zrdev_err(zr,
+			  "%s: attach failed, jpeg processor failed (end flag)!\n",
+			  ptr->name);
 		return -EBUSY;
 	}
 
@@ -179,10 +168,11 @@ static int zr36050_basic_test(struct zr36050 *ptr)
 
 static int zr36050_pushit(struct zr36050 *ptr, u16 startreg, u16 len, const char *data)
 {
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 	int i = 0;
 
-	dprintk(4, "%s: write data block to 0x%04x (len=%d)\n", ptr->name,
-		startreg, len);
+	zrdev_dbg(zr, "%s: write data block to 0x%04x (len=%d)\n", ptr->name,
+		  startreg, len);
 	while (i < len)
 		zr36050_write(ptr, startreg++, data[i++]);
 
@@ -305,11 +295,12 @@ static const char zr36050_decimation_v[8] = { 1, 1, 1, 0, 0, 0, 0, 0 };
 
 static int zr36050_set_sof(struct zr36050 *ptr)
 {
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 	char sof_data[34];	// max. size of register set
 	int i;
 
-	dprintk(3, "%s: write SOF (%dx%d, %d components)\n", ptr->name,
-		ptr->width, ptr->height, NO_OF_COMPONENTS);
+	zrdev_dbg(zr, "%s: write SOF (%dx%d, %d components)\n", ptr->name,
+		  ptr->width, ptr->height, NO_OF_COMPONENTS);
 	sof_data[0] = 0xff;
 	sof_data[1] = 0xc0;
 	sof_data[2] = 0x00;
@@ -336,10 +327,11 @@ static int zr36050_set_sof(struct zr36050 *ptr)
 
 static int zr36050_set_sos(struct zr36050 *ptr)
 {
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 	char sos_data[16];	// max. size of register set
 	int i;
 
-	dprintk(3, "%s: write SOS\n", ptr->name);
+	zrdev_dbg(zr, "%s: write SOS\n", ptr->name);
 	sos_data[0] = 0xff;
 	sos_data[1] = 0xda;
 	sos_data[2] = 0x00;
@@ -363,9 +355,10 @@ static int zr36050_set_sos(struct zr36050 *ptr)
 
 static int zr36050_set_dri(struct zr36050 *ptr)
 {
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 	char dri_data[6];	// max. size of register set
 
-	dprintk(3, "%s: write DRI\n", ptr->name);
+	zrdev_dbg(zr, "%s: write DRI\n", ptr->name);
 	dri_data[0] = 0xff;
 	dri_data[1] = 0xdd;
 	dri_data[2] = 0x00;
@@ -390,7 +383,7 @@ static void zr36050_init(struct zr36050 *ptr)
 	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 
 	if (ptr->mode == CODEC_DO_COMPRESSION) {
-		dprintk(2, "%s: COMPRESSION SETUP\n", ptr->name);
+		zrdev_dbg(zr, "%s: COMPRESSION SETUP\n", ptr->name);
 
 		/* 050 communicates with 057 in master mode */
 		zr36050_write(ptr, ZR050_HARDWARE, ZR050_HW_MSTR);
@@ -420,7 +413,7 @@ static void zr36050_init(struct zr36050 *ptr)
 
 		/* setup the fixed jpeg tables - maybe variable, though -
 		 * (see table init section above) */
-		dprintk(3, "%s: write DQT, DHT, APP\n", ptr->name);
+		zrdev_dbg(zr, "%s: write DQT, DHT, APP\n", ptr->name);
 		sum += zr36050_pushit(ptr, ZR050_DQT_IDX,
 				      sizeof(zr36050_dqt), zr36050_dqt);
 		sum += zr36050_pushit(ptr, ZR050_DHT_IDX,
@@ -443,8 +436,8 @@ static void zr36050_init(struct zr36050 *ptr)
 
 		zr36050_write(ptr, ZR050_GO, 1);	// launch codec
 		zr36050_wait_end(ptr);
-		dprintk(2, "%s: Status after table preload: 0x%02x\n",
-			ptr->name, ptr->status1);
+		zrdev_dbg(zr, "%s: Status after table preload: 0x%02x\n",
+			  ptr->name, ptr->status1);
 
 		if ((ptr->status1 & 0x4) == 0) {
 			zrdev_err(zr, "%s: init aborted!\n", ptr->name);
@@ -458,9 +451,9 @@ static void zr36050_init(struct zr36050 *ptr)
 		bitcnt = sum << 3;	/* need the size in bits */
 
 		tmp = bitcnt >> 16;
-		dprintk(3,
-			"%s: code: csize=%d, tot=%d, bit=%ld, highbits=%ld\n",
-			ptr->name, sum, ptr->real_code_vol, bitcnt, tmp);
+		zrdev_dbg(zr,
+			  "%s: code: csize=%d, tot=%d, bit=%ld, highbits=%ld\n",
+			  ptr->name, sum, ptr->real_code_vol, bitcnt, tmp);
 		zr36050_write(ptr, ZR050_TCV_NET_HI, tmp >> 8);
 		zr36050_write(ptr, ZR050_TCV_NET_MH, tmp & 0xff);
 		tmp = bitcnt & 0xffff;
@@ -471,8 +464,8 @@ static void zr36050_init(struct zr36050 *ptr)
 		bitcnt -= ((bitcnt * 5) >> 6);	// bits without eob
 
 		tmp = bitcnt >> 16;
-		dprintk(3, "%s: code: nettobit=%ld, highnettobits=%ld\n",
-			ptr->name, bitcnt, tmp);
+		zrdev_dbg(zr, "%s: code: nettobit=%ld, highnettobits=%ld\n",
+			  ptr->name, bitcnt, tmp);
 		zr36050_write(ptr, ZR050_TCV_DATA_HI, tmp >> 8);
 		zr36050_write(ptr, ZR050_TCV_DATA_MH, tmp & 0xff);
 		tmp = bitcnt & 0xffff;
@@ -490,7 +483,7 @@ static void zr36050_init(struct zr36050 *ptr)
 			      ((ptr->app.len > 0) ? ZR050_ME_APP : 0) |
 			      ((ptr->com.len > 0) ? ZR050_ME_COM : 0));
 	} else {
-		dprintk(2, "%s: EXPANSION SETUP\n", ptr->name);
+		zrdev_dbg(zr, "%s: EXPANSION SETUP\n", ptr->name);
 
 		/* 050 communicates with 055 in master mode */
 		zr36050_write(ptr, ZR050_HARDWARE,
@@ -503,7 +496,7 @@ static void zr36050_init(struct zr36050 *ptr)
 		zr36050_write(ptr, ZR050_INT_REQ_0, 0);
 		zr36050_write(ptr, ZR050_INT_REQ_1, 3);	// low 2 bits always 1
 
-		dprintk(3, "%s: write DHT\n", ptr->name);
+		zrdev_dbg(zr, "%s: write DHT\n", ptr->name);
 		zr36050_pushit(ptr, ZR050_DHT_IDX, sizeof(zr36050_dht),
 			       zr36050_dht);
 
@@ -512,8 +505,8 @@ static void zr36050_init(struct zr36050 *ptr)
 
 		zr36050_write(ptr, ZR050_GO, 1);	// launch codec
 		zr36050_wait_end(ptr);
-		dprintk(2, "%s: Status after table preload: 0x%02x\n",
-			ptr->name, ptr->status1);
+		zrdev_dbg(zr, "%s: Status after table preload: 0x%02x\n",
+			  ptr->name, ptr->status1);
 
 		if ((ptr->status1 & 0x4) == 0) {
 			zrdev_err(zr, "%s: init aborted!\n", ptr->name);
@@ -540,8 +533,9 @@ static void zr36050_init(struct zr36050 *ptr)
 static int zr36050_set_mode(struct videocodec *codec, int mode)
 {
 	struct zr36050 *ptr = (struct zr36050 *)codec->data;
+	struct zoran *zr = videocodec_to_zoran(codec);
 
-	dprintk(2, "%s: set_mode %d call\n", ptr->name, mode);
+	zrdev_dbg(zr, "%s: set_mode %d call\n", ptr->name, mode);
 
 	if ((mode != CODEC_DO_EXPANSION) && (mode != CODEC_DO_COMPRESSION))
 		return -EINVAL;
@@ -557,12 +551,13 @@ static int zr36050_set_video(struct videocodec *codec, const struct tvnorm *norm
 			     struct vfe_settings *cap, struct vfe_polarity *pol)
 {
 	struct zr36050 *ptr = (struct zr36050 *)codec->data;
+	struct zoran *zr = videocodec_to_zoran(codec);
 	int size;
 
-	dprintk(2, "%s: set_video %d.%d, %d/%d-%dx%d (0x%x) q%d call\n",
-		ptr->name, norm->h_start, norm->v_start,
-		cap->x, cap->y, cap->width, cap->height,
-		cap->decimation, cap->quality);
+	zrdev_dbg(zr, "%s: set_video %d.%d, %d/%d-%dx%d (0x%x) q%d call\n",
+		  ptr->name, norm->h_start, norm->v_start,
+		  cap->x, cap->y, cap->width, cap->height,
+		  cap->decimation, cap->quality);
 	/* if () return -EINVAL;
 	 * trust the master driver that it knows what it does - so
 	 * we allow invalid startx/y and norm for now ... */
@@ -595,10 +590,11 @@ static int zr36050_set_video(struct videocodec *codec, const struct tvnorm *norm
 static int zr36050_control(struct videocodec *codec, int type, int size, void *data)
 {
 	struct zr36050 *ptr = (struct zr36050 *)codec->data;
+	struct zoran *zr = videocodec_to_zoran(codec);
 	int *ival = (int *)data;
 
-	dprintk(2, "%s: control %d call with %d byte\n", ptr->name, type,
-		size);
+	zrdev_dbg(zr, "%s: control %d call with %d byte\n", ptr->name, type,
+		  size);
 
 	switch (type) {
 	case CODEC_G_STATUS:	/* get last status */
@@ -714,12 +710,13 @@ static int zr36050_control(struct videocodec *codec, int type, int size, void *d
 static int zr36050_unset(struct videocodec *codec)
 {
 	struct zr36050 *ptr = codec->data;
+	struct zoran *zr = videocodec_to_zoran(codec);
 
 	if (ptr) {
 		/* do wee need some codec deinit here, too ???? */
 
-		dprintk(1, "%s: finished codec #%d\n", ptr->name,
-			ptr->num);
+		zrdev_dbg(zr, "%s: finished codec #%d\n", ptr->name,
+			  ptr->num);
 		kfree(ptr);
 		codec->data = NULL;
 
@@ -742,14 +739,15 @@ static int zr36050_unset(struct videocodec *codec)
 static int zr36050_setup(struct videocodec *codec)
 {
 	struct zr36050 *ptr;
+	struct zoran *zr = videocodec_to_zoran(codec);
 	int res;
 
-	dprintk(2, "zr36050: initializing MJPEG subsystem #%d.\n",
-		zr36050_codecs);
+	zrdev_dbg(zr, "zr36050: initializing MJPEG subsystem #%d.\n",
+		  zr36050_codecs);
 
 	if (zr36050_codecs == MAX_CODECS) {
-		dprintk(1,
-			KERN_ERR "zr36050: Can't attach more codecs!\n");
+		zrdev_err(zr,
+			  "zr36050: Can't attach more codecs!\n");
 		return -ENOSPC;
 	}
 	//mem structure init
@@ -790,8 +788,8 @@ static int zr36050_setup(struct videocodec *codec)
 
 	zr36050_init(ptr);
 
-	dprintk(1, KERN_INFO "%s: codec attached and running\n",
-		ptr->name);
+	zrdev_info(zr, "%s: codec attached and running\n",
+		   ptr->name);
 
 	return 0;
 }
@@ -824,9 +822,8 @@ int zr36050_init_module(void)
 void zr36050_cleanup_module(void)
 {
 	if (zr36050_codecs) {
-		dprintk(1,
-			"zr36050: something's wrong - %d codecs left somehow.\n",
-			zr36050_codecs);
+		pr_debug("zr36050: something's wrong - %d codecs left somehow.\n",
+			 zr36050_codecs);
 	}
 	videocodec_unregister(&zr36050_codec);
 }
diff --git a/drivers/staging/media/zoran/zr36060.c b/drivers/staging/media/zoran/zr36060.c
index 8dc3d4a98c47..7798016f1f96 100644
--- a/drivers/staging/media/zoran/zr36060.c
+++ b/drivers/staging/media/zoran/zr36060.c
@@ -32,16 +32,6 @@ static bool low_bitrate;
 module_param(low_bitrate, bool, 0);
 MODULE_PARM_DESC(low_bitrate, "Buz compatibility option, halves bitrate");
 
-static int zr36060_debug;
-module_param(zr36060_debug, int, 0);
-MODULE_PARM_DESC(zr36060_debug, "Debug level (0-4)");
-
-#define dprintk(num, format, args...) \
-	do { \
-		if (zr36060_debug >= num) \
-			printk(format, ##args); \
-	} while (0)
-
 /* =========================================================================
  * Local hardware I/O functions:
  * read/write via codec layer (registers are located in the master device)
@@ -66,7 +56,7 @@ static void zr36060_write(struct zr36060 *ptr, u16 reg, u8 value)
 {
 	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 
-	dprintk(4, "0x%02x @0x%04x\n", value, reg);
+	zrdev_dbg(zr, "0x%02x @0x%04x\n", value, reg);
 
 	// just in case something is wrong...
 	if (ptr->codec->master_data->writereg)
@@ -104,14 +94,15 @@ static u16 zr36060_read_scalefactor(struct zr36060 *ptr)
 /* wait if codec is ready to proceed (end of processing) or time is over */
 static void zr36060_wait_end(struct zr36060 *ptr)
 {
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 	int i = 0;
 
 	while (zr36060_read_status(ptr) & ZR060_CFSR_BUSY) {
 		udelay(1);
 		if (i++ > 200000) {	// 200ms, there is for sure something wrong!!!
-			dprintk(1,
-				"%s: timeout at wait_end (last status: 0x%02x)\n",
-				ptr->name, ptr->status);
+			zrdev_dbg(zr,
+				  "%s: timeout at wait_end (last status: 0x%02x)\n",
+				  ptr->name, ptr->status);
 			break;
 		}
 	}
@@ -140,10 +131,11 @@ static int zr36060_basic_test(struct zr36060 *ptr)
 /* simple loop for pushing the init datasets */
 static int zr36060_pushit(struct zr36060 *ptr, u16 startreg, u16 len, const char *data)
 {
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 	int i = 0;
 
-	dprintk(4, "%s: write data block to 0x%04x (len=%d)\n", ptr->name,
-		startreg, len);
+	zrdev_dbg(zr, "%s: write data block to 0x%04x (len=%d)\n", ptr->name,
+		  startreg, len);
 	while (i < len)
 		zr36060_write(ptr, startreg++, data[i++]);
 
@@ -254,11 +246,12 @@ static const char zr36060_decimation_v[8] = { 1, 1, 1, 0, 0, 0, 0, 0 };
 /* SOF (start of frame) segment depends on width, height and sampling ratio of each color component */
 static int zr36060_set_sof(struct zr36060 *ptr)
 {
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 	char sof_data[34];	// max. size of register set
 	int i;
 
-	dprintk(3, "%s: write SOF (%dx%d, %d components)\n", ptr->name,
-		ptr->width, ptr->height, NO_OF_COMPONENTS);
+	zrdev_dbg(zr, "%s: write SOF (%dx%d, %d components)\n", ptr->name,
+		  ptr->width, ptr->height, NO_OF_COMPONENTS);
 	sof_data[0] = 0xff;
 	sof_data[1] = 0xc0;
 	sof_data[2] = 0x00;
@@ -282,10 +275,11 @@ static int zr36060_set_sof(struct zr36060 *ptr)
 /* SOS (start of scan) segment depends on the used scan components of each color component */
 static int zr36060_set_sos(struct zr36060 *ptr)
 {
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 	char sos_data[16];	// max. size of register set
 	int i;
 
-	dprintk(3, "%s: write SOS\n", ptr->name);
+	zrdev_dbg(zr, "%s: write SOS\n", ptr->name);
 	sos_data[0] = 0xff;
 	sos_data[1] = 0xda;
 	sos_data[2] = 0x00;
@@ -307,9 +301,10 @@ static int zr36060_set_sos(struct zr36060 *ptr)
 /* DRI (define restart interval) */
 static int zr36060_set_dri(struct zr36060 *ptr)
 {
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 	char dri_data[6];	// max. size of register set
 
-	dprintk(3, "%s: write DRI\n", ptr->name);
+	zrdev_dbg(zr, "%s: write DRI\n", ptr->name);
 	dri_data[0] = 0xff;
 	dri_data[1] = 0xdd;
 	dri_data[2] = 0x00;
@@ -329,7 +324,7 @@ static void zr36060_init(struct zr36060 *ptr)
 	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 
 	if (ptr->mode == CODEC_DO_COMPRESSION) {
-		dprintk(2, "%s: COMPRESSION SETUP\n", ptr->name);
+		zrdev_dbg(zr, "%s: COMPRESSION SETUP\n", ptr->name);
 
 		zr36060_write(ptr, ZR060_LOAD, ZR060_LOAD_SYNC_RST);
 
@@ -382,9 +377,9 @@ static void zr36060_init(struct zr36060 *ptr)
 		bitcnt = sum << 3;	/* need the size in bits */
 
 		tmp = bitcnt >> 16;
-		dprintk(3,
-			"%s: code: csize=%d, tot=%d, bit=%ld, highbits=%ld\n",
-			ptr->name, sum, ptr->real_code_vol, bitcnt, tmp);
+		zrdev_dbg(zr,
+			  "%s: code: csize=%d, tot=%d, bit=%ld, highbits=%ld\n",
+			  ptr->name, sum, ptr->real_code_vol, bitcnt, tmp);
 		zr36060_write(ptr, ZR060_TCV_NET_HI, tmp >> 8);
 		zr36060_write(ptr, ZR060_TCV_NET_MH, tmp & 0xff);
 		tmp = bitcnt & 0xffff;
@@ -395,8 +390,8 @@ static void zr36060_init(struct zr36060 *ptr)
 		bitcnt -= ((bitcnt * 5) >> 6);	// bits without eob
 
 		tmp = bitcnt >> 16;
-		dprintk(3, "%s: code: nettobit=%ld, highnettobits=%ld\n",
-			ptr->name, bitcnt, tmp);
+		zrdev_dbg(zr, "%s: code: nettobit=%ld, highnettobits=%ld\n",
+			  ptr->name, bitcnt, tmp);
 		zr36060_write(ptr, ZR060_TCV_DATA_HI, tmp >> 8);
 		zr36060_write(ptr, ZR060_TCV_DATA_MH, tmp & 0xff);
 		tmp = bitcnt & 0xffff;
@@ -414,7 +409,7 @@ static void zr36060_init(struct zr36060 *ptr)
 		zr36060_write(ptr, ZR060_VCR, ZR060_VCR_RANGE);
 
 	} else {
-		dprintk(2, "%s: EXPANSION SETUP\n", ptr->name);
+		zrdev_dbg(zr, "%s: EXPANSION SETUP\n", ptr->name);
 
 		zr36060_write(ptr, ZR060_LOAD, ZR060_LOAD_SYNC_RST);
 
@@ -447,7 +442,8 @@ static void zr36060_init(struct zr36060 *ptr)
 	/* Load the tables */
 	zr36060_write(ptr, ZR060_LOAD, ZR060_LOAD_SYNC_RST | ZR060_LOAD_LOAD);
 	zr36060_wait_end(ptr);
-	dprintk(2, "%s: Status after table preload: 0x%02x\n", ptr->name, ptr->status);
+	zrdev_dbg(zr, "%s: Status after table preload: 0x%02x\n",
+		  ptr->name, ptr->status);
 
 	if (ptr->status & ZR060_CFSR_BUSY) {
 		zrdev_err(zr, "%s: init aborted!\n", ptr->name);
@@ -467,8 +463,9 @@ static void zr36060_init(struct zr36060 *ptr)
 static int zr36060_set_mode(struct videocodec *codec, int mode)
 {
 	struct zr36060 *ptr = (struct zr36060 *)codec->data;
+	struct zoran *zr = videocodec_to_zoran(codec);
 
-	dprintk(2, "%s: set_mode %d call\n", ptr->name, mode);
+	zrdev_dbg(zr, "%s: set_mode %d call\n", ptr->name, mode);
 
 	if (mode != CODEC_DO_EXPANSION && mode != CODEC_DO_COMPRESSION)
 		return -EINVAL;
@@ -484,11 +481,12 @@ static int zr36060_set_video(struct videocodec *codec, const struct tvnorm *norm
 			     struct vfe_settings *cap, struct vfe_polarity *pol)
 {
 	struct zr36060 *ptr = (struct zr36060 *)codec->data;
+	struct zoran *zr = videocodec_to_zoran(codec);
 	u32 reg;
 	int size;
 
-	dprintk(2, "%s: set_video %d/%d-%dx%d (%%%d) call\n", ptr->name,
-		cap->x, cap->y, cap->width, cap->height, cap->decimation);
+	zrdev_dbg(zr, "%s: set_video %d/%d-%dx%d (%%%d) call\n", ptr->name,
+		  cap->x, cap->y, cap->width, cap->height, cap->decimation);
 
 	/* if () return -EINVAL;
 	 * trust the master driver that it knows what it does - so
@@ -643,10 +641,11 @@ static int zr36060_set_video(struct videocodec *codec, const struct tvnorm *norm
 static int zr36060_control(struct videocodec *codec, int type, int size, void *data)
 {
 	struct zr36060 *ptr = (struct zr36060 *)codec->data;
+	struct zoran *zr = videocodec_to_zoran(codec);
 	int *ival = (int *)data;
 
-	dprintk(2, "%s: control %d call with %d byte\n", ptr->name, type,
-		size);
+	zrdev_dbg(zr, "%s: control %d call with %d byte\n", ptr->name, type,
+		  size);
 
 	switch (type) {
 	case CODEC_G_STATUS:	/* get last status */
@@ -759,11 +758,12 @@ static int zr36060_control(struct videocodec *codec, int type, int size, void *d
 static int zr36060_unset(struct videocodec *codec)
 {
 	struct zr36060 *ptr = codec->data;
+	struct zoran *zr = videocodec_to_zoran(codec);
 
 	if (ptr) {
 		/* do wee need some codec deinit here, too ???? */
 
-		dprintk(1, "%s: finished codec #%d\n", ptr->name, ptr->num);
+		zrdev_dbg(zr, "%s: finished codec #%d\n", ptr->name, ptr->num);
 		kfree(ptr);
 		codec->data = NULL;
 
@@ -787,7 +787,8 @@ static int zr36060_setup(struct videocodec *codec)
 	struct zoran *zr = videocodec_to_zoran(codec);
 	int res;
 
-	dprintk(2, "zr36060: initializing MJPEG subsystem #%d.\n", zr36060_codecs);
+	zrdev_dbg(zr, "zr36060: initializing MJPEG subsystem #%d.\n",
+		  zr36060_codecs);
 
 	if (zr36060_codecs == MAX_CODECS) {
 		zrdev_err(zr, "zr36060: Can't attach more codecs!\n");
@@ -830,7 +831,7 @@ static int zr36060_setup(struct videocodec *codec)
 
 	zr36060_init(ptr);
 
-	dprintk(1, KERN_INFO "%s: codec attached and running\n", ptr->name);
+	zrdev_info(zr, "%s: codec attached and running\n", ptr->name);
 
 	return 0;
 }
@@ -859,9 +860,8 @@ int zr36060_init_module(void)
 void zr36060_cleanup_module(void)
 {
 	if (zr36060_codecs) {
-		dprintk(1,
-			"zr36060: something's wrong - %d codecs left somehow.\n",
-			zr36060_codecs);
+		pr_debug("zr36060: something's wrong - %d codecs left somehow.\n",
+			 zr36060_codecs);
 	}
 
 	/* however, we can't just stay alive */
-- 
2.35.1

