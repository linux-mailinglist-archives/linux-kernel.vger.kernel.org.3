Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F8251D0AE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 07:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389181AbiEFFcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 01:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389173AbiEFFch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 01:32:37 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D755BF52
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 22:28:51 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D6C321211FE;
        Fri,  6 May 2022 05:28:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a243.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6575E121120;
        Fri,  6 May 2022 05:28:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1651814927; a=rsa-sha256;
        cv=none;
        b=HnhfW5+lKMeSd/UH4Ela1Gj/MveMqnij+LvcSLBHP0+JKID7TFLxltB2JLuDbL7vrwHQk5
        82M+rqjNbgLXxdiedockI02wgEXgXrpBpuvugNzjr0zgX+9MSH6exHbG44L5OHPP+JYIL7
        ARpa/MKLHPoXt/QjkMfx2YkxxlVKSOhm9va0X943JjYvoi6iISeL7D6mgzhfUM1bb2fbCu
        cRJolzwMO3xak0nNX2f7X22iitbsGGJMvsDQgcxXeVgANgDEuowS8NLW3mWCBYoq9TyR2Z
        4MGDEf0bSvMd+1obp1RK8B8zvnf2SquOF+inBnLtXKTP345x88Yd+prNzJnVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1651814927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=/ckalCvNl6F4Kl2uykHW7oKYj23W1otRNQdqndCFrTA=;
        b=qwAGhVmXbpmAwwra7YEm7XjdvoI/RifDGysAZ1c+XkHBHF6Kf8rflHD4Lj7j4jaN7rI4tj
        G74CPStoF61FVrnc/K+vB7K7Bzik4M18r6jbt6UQVTRWffja8kMMvx4Y4xdnyUNCT4fOr7
        aBhAWpKsTp10edyMHgJGFWT0CkyXNmf+NFygP+qQOxFAyenBxc78cG54Tq1B2vlu2brb63
        jH/aA79LgLsju2HIpTZjAQneGxA3gVeCEtoIEmguMIcJXz4girM/cF40fA35CzBJG/Gdoi
        v4kgZ6/hpXkESoRVq34G3pgSoalCgH0Hoi4EzcsDrRMhBH/YG73vZFmMxlHAqQ==
ARC-Authentication-Results: i=1;
        rspamd-fdd564cbf-x7f5k;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Cure-Bubble: 18c46c0059443605_1651814927747_4136452387
X-MC-Loop-Signature: 1651814927747:3359548958
X-MC-Ingress-Time: 1651814927747
Received: from pdx1-sub0-mail-a243.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.96.96.26 (trex/6.7.1);
        Fri, 06 May 2022 05:28:47 +0000
Received: from localhost.localdomain (unknown [69.12.38.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a243.dreamhost.com (Postfix) with ESMTPSA id 4KvfHf3BHgz1Nh;
        Thu,  5 May 2022 22:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1651814927;
        bh=/ckalCvNl6F4Kl2uykHW7oKYj23W1otRNQdqndCFrTA=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=gEe9R7NmjlDDhbb3oCwY5QfUDl7dSW2cN7SmGlR4EM5yxAEql0q25RMBRbiG1KMDN
         7gWwsoCaIyuKQK+2EIGo/wv8jtDrAlK/8aUUERQEkRy4uNxWo9p7VpAaVnaFqLWFTk
         HRV/hidYPPKxGFn2eBljX5+3BhD19uaH/Yp31mThLzzJ8Obi2fb248+fVG3TC+S5Lz
         wgGKGhpuuWhCgi68pNE05Q7irfYjd6e0A/tFGyTwZTAAo8m/F/foFQqZHybCOyLxwn
         2bzEHtAjJnMGuOr/LDB1ld+CGw0yblWsGl9Y4raJBacJFpGY5LYN2fkNQwu4uS6eFL
         UeBoWS5ebh1lw==
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ian Cowan <ian@linux.cowan.aero>
Subject: [PATCH v3 3/4] staging: media: zoran: replace all pr_err with zrdev_err as appropriate
Date:   Fri,  6 May 2022 01:28:37 -0400
Message-Id: <20220506052837.192373-1-ian@linux.cowan.aero>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This replaces all of the pr_err calls to the preferred zrdev_err macro
that calls the dev_err macro. There are a few locations where the pr_err
is left because a zoran struct cannot be created. This is the result of
error handling for another struct's existence that is required to create
a zoran struct.

Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
---
 drivers/staging/media/zoran/videocodec.c | 25 +++++++++++++++-------
 drivers/staging/media/zoran/zr36016.c    | 27 ++++++++++++++++--------
 drivers/staging/media/zoran/zr36050.c    |  5 +++--
 drivers/staging/media/zoran/zr36060.c    | 19 +++++++++++------
 4 files changed, 51 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/media/zoran/videocodec.c b/drivers/staging/media/zoran/videocodec.c
index 3af7d02bd910..27fdecd2bebe 100644
--- a/drivers/staging/media/zoran/videocodec.c
+++ b/drivers/staging/media/zoran/videocodec.c
@@ -47,6 +47,7 @@ static struct codec_list *codeclist_top;
 struct videocodec *videocodec_attach(struct videocodec_master *master)
 {
 	struct codec_list *h = codeclist_top;
+	struct zoran *zr;
 	struct attached_list *a, *ptr;
 	struct videocodec *codec;
 	int res;
@@ -56,11 +57,13 @@ struct videocodec *videocodec_attach(struct videocodec_master *master)
 		return NULL;
 	}
 
+	zr = videocodec_master_to_zoran(master);
+
 	dprintk(2, "%s: '%s', flags %lx, magic %lx\n", __func__,
 		master->name, master->flags, master->magic);
 
 	if (!h) {
-		pr_err("%s: no device available\n", __func__);
+		zrdev_err(zr, "%s: no device available\n", __func__);
 		return NULL;
 	}
 
@@ -105,7 +108,7 @@ struct videocodec *videocodec_attach(struct videocodec_master *master)
 		h = h->next;
 	}
 
-	pr_err("%s: no codec found!\n", __func__);
+	zrdev_err(zr, "%s: no codec found!\n", __func__);
 	return NULL;
 
  out_kfree:
@@ -116,6 +119,7 @@ struct videocodec *videocodec_attach(struct videocodec_master *master)
 int videocodec_detach(struct videocodec *codec)
 {
 	struct codec_list *h = codeclist_top;
+	struct zoran *zr;
 	struct attached_list *a, *prev;
 	int res;
 
@@ -124,11 +128,13 @@ int videocodec_detach(struct videocodec *codec)
 		return -EINVAL;
 	}
 
+	zr = videocodec_to_zoran(codec);
+
 	dprintk(2, "%s: '%s', type: %x, flags %lx, magic %lx\n", __func__,
 		codec->name, codec->type, codec->flags, codec->magic);
 
 	if (!h) {
-		pr_err("%s: no device left...\n", __func__);
+		zrdev_err(zr, "%s: no device left...\n", __func__);
 		return -ENXIO;
 	}
 
@@ -142,7 +148,7 @@ int videocodec_detach(struct videocodec *codec)
 					dprintk(3, "%s: '%s'\n", __func__, a->codec->name);
 					a->codec->master_data = NULL;
 				} else {
-					pr_err("%s: '%s'\n", __func__, a->codec->name);
+					zrdev_err(zr, "%s: '%s'\n", __func__, a->codec->name);
 					a->codec->master_data = NULL;
 				}
 				if (!prev) {
@@ -163,7 +169,7 @@ int videocodec_detach(struct videocodec *codec)
 		h = h->next;
 	}
 
-	pr_err("%s: given codec not found!\n", __func__);
+	zrdev_err(zr, "%s: given codec not found!\n", __func__);
 	return -EINVAL;
 }
 
@@ -202,25 +208,28 @@ int videocodec_register(const struct videocodec *codec)
 int videocodec_unregister(const struct videocodec *codec)
 {
 	struct codec_list *prev = NULL, *h = codeclist_top;
+	struct zoran *zr;
 
 	if (!codec) {
 		pr_err("%s: no data!\n", __func__);
 		return -EINVAL;
 	}
 
+	zr = videocodec_to_zoran((struct videocodec *)codec);
+
 	dprintk(2,
 		"videocodec: unregister '%s', type: %x, flags %lx, magic %lx\n",
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
@@ -241,7 +250,7 @@ int videocodec_unregister(const struct videocodec *codec)
 		h = h->next;
 	}
 
-	pr_err("%s: given codec not found!\n", __func__);
+	zrdev_err(zr, "%s: given codec not found!\n", __func__);
 	return -EINVAL;
 }
 
diff --git a/drivers/staging/media/zoran/zr36016.c b/drivers/staging/media/zoran/zr36016.c
index 26c7c32b6bc0..953d93ccc897 100644
--- a/drivers/staging/media/zoran/zr36016.c
+++ b/drivers/staging/media/zoran/zr36016.c
@@ -43,12 +43,13 @@ MODULE_PARM_DESC(zr36016_debug, "Debug level (0-4)");
 static u8 zr36016_read(struct zr36016 *ptr, u16 reg)
 {
 	u8 value = 0;
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 
 	/* just in case something is wrong... */
 	if (ptr->codec->master_data->readreg)
 		value = (ptr->codec->master_data->readreg(ptr->codec, reg)) & 0xFF;
 	else
-		pr_err("%s: invalid I/O setup, nothing read!\n", ptr->name);
+		zrdev_err(zr, "%s: invalid I/O setup, nothing read!\n", ptr->name);
 
 	dprintk(4, "%s: reading from 0x%04x: %02x\n", ptr->name, reg, value);
 
@@ -57,13 +58,15 @@ static u8 zr36016_read(struct zr36016 *ptr, u16 reg)
 
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
@@ -72,13 +75,14 @@ static void zr36016_write(struct zr36016 *ptr, u16 reg, u8 value)
 static u8 zr36016_readi(struct zr36016 *ptr, u16 reg)
 {
 	u8 value = 0;
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 
 	/* just in case something is wrong... */
 	if ((ptr->codec->master_data->writereg) && (ptr->codec->master_data->readreg)) {
 		ptr->codec->master_data->writereg(ptr->codec, ZR016_IADDR, reg & 0x0F);	// ADDR
 		value = (ptr->codec->master_data->readreg(ptr->codec, ZR016_IDATA)) & 0xFF;	// DATA
 	} else {
-		pr_err("%s: invalid I/O setup, nothing read (i)!\n", ptr->name);
+		zrdev_err(zr, "%s: invalid I/O setup, nothing read (i)!\n", ptr->name);
 	}
 
 	dprintk(4, "%s: reading indirect from 0x%04x: %02x\n", ptr->name, reg, value);
@@ -87,6 +91,8 @@ static u8 zr36016_readi(struct zr36016 *ptr, u16 reg)
 
 static void zr36016_writei(struct zr36016 *ptr, u16 reg, u8 value)
 {
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
+
 	dprintk(4, "%s: writing indirect 0x%02x to 0x%04x\n", ptr->name,
 		value, reg);
 
@@ -95,7 +101,7 @@ static void zr36016_writei(struct zr36016 *ptr, u16 reg, u8 value)
 		ptr->codec->master_data->writereg(ptr->codec, ZR016_IADDR, reg & 0x0F);	// ADDR
 		ptr->codec->master_data->writereg(ptr->codec, ZR016_IDATA, value & 0x0FF);	// DATA
 	} else {
-		pr_err("%s: invalid I/O setup, nothing written (i)!\n", ptr->name);
+		zrdev_err(zr, "%s: invalid I/O setup, nothing written (i)!\n", ptr->name);
 	}
 }
 
@@ -120,6 +126,8 @@ static u8 zr36016_read_version(struct zr36016 *ptr)
 
 static int zr36016_basic_test(struct zr36016 *ptr)
 {
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
+
 	if (zr36016_debug) {
 		int i;
 
@@ -133,19 +141,19 @@ static int zr36016_basic_test(struct zr36016 *ptr)
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
 
@@ -352,12 +360,13 @@ static int zr36016_unset(struct videocodec *codec)
 static int zr36016_setup(struct videocodec *codec)
 {
 	struct zr36016 *ptr;
+	struct zoran *zr = videocodec_to_zoran(codec);
 	int res;
 
 	dprintk(2, "zr36016: initializing VFE subsystem #%d.\n", zr36016_codecs);
 
 	if (zr36016_codecs == MAX_CODECS) {
-		pr_err("zr36016: Can't attach more codecs!\n");
+		zrdev_err(zr, "zr36016: Can't attach more codecs!\n");
 		return -ENOSPC;
 	}
 	//mem structure init
diff --git a/drivers/staging/media/zoran/zr36050.c b/drivers/staging/media/zoran/zr36050.c
index 38f7021e7b06..4a14fc3bffba 100644
--- a/drivers/staging/media/zoran/zr36050.c
+++ b/drivers/staging/media/zoran/zr36050.c
@@ -387,6 +387,7 @@ static void zr36050_init(struct zr36050 *ptr)
 {
 	int sum = 0;
 	long bitcnt, tmp;
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 
 	if (ptr->mode == CODEC_DO_COMPRESSION) {
 		dprintk(2, "%s: COMPRESSION SETUP\n", ptr->name);
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
index d0c369e31c81..8dc3d4a98c47 100644
--- a/drivers/staging/media/zoran/zr36060.c
+++ b/drivers/staging/media/zoran/zr36060.c
@@ -51,25 +51,28 @@ MODULE_PARM_DESC(zr36060_debug, "Debug level (0-4)");
 static u8 zr36060_read(struct zr36060 *ptr, u16 reg)
 {
 	u8 value = 0;
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 
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
 
@@ -321,6 +326,7 @@ static void zr36060_init(struct zr36060 *ptr)
 {
 	int sum = 0;
 	long bitcnt, tmp;
+	struct zoran *zr = videocodec_to_zoran(ptr->codec);
 
 	if (ptr->mode == CODEC_DO_COMPRESSION) {
 		dprintk(2, "%s: COMPRESSION SETUP\n", ptr->name);
@@ -444,7 +450,7 @@ static void zr36060_init(struct zr36060 *ptr)
 	dprintk(2, "%s: Status after table preload: 0x%02x\n", ptr->name, ptr->status);
 
 	if (ptr->status & ZR060_CFSR_BUSY) {
-		pr_err("%s: init aborted!\n", ptr->name);
+		zrdev_err(zr, "%s: init aborted!\n", ptr->name);
 		return;		// something is wrong, its timed out!!!!
 	}
 }
@@ -778,12 +784,13 @@ static int zr36060_unset(struct videocodec *codec)
 static int zr36060_setup(struct videocodec *codec)
 {
 	struct zr36060 *ptr;
+	struct zoran *zr = videocodec_to_zoran(codec);
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

