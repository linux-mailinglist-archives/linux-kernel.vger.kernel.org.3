Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39F7474765
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbhLNQRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbhLNQQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:16:51 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BB5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:16:50 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id z206so408088wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uoSsJQeMeV1S/aZ9+Qs931neAcHv5KnV5JpeQ9wVWNQ=;
        b=NNYQ5qKRBHiVUROM7zfHeFUyjM9pi4CEzhvUmxRUxTqNKA15SkhIeGUFY73oBhN1BJ
         Ya8SOx6ibFbPhn01ud/oZQcHvDGqCPZbW9yr/rkH9kZ/9ZCOHPA+2pDk6o4wK36zPzVK
         85pTVJMSVzuy5TcH02TU24QA+JTeVOe9GmMSH9iWPt8ZzyRmVHTux1aAqkUcIJiPAWZa
         vITHXDfLBAhbpUHIbGBr7nbhWIHL4qBrFxsm0njunwqYysGA+AUNLejRzfEYkPLPOfBp
         4uYls4zmiJYQqlHcbU1ELFH3LfDEpnwMs78D3KpSZtVJwFTlmk3g6x911diNAiCrIk0D
         hUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uoSsJQeMeV1S/aZ9+Qs931neAcHv5KnV5JpeQ9wVWNQ=;
        b=jylaPZ250lyrtH1pKFC/aSzZhAq4uEzQ6yQ/HD0mD9KS0KYRN1IAy7wJTPwUe3uM+x
         Z+sUtJhvFcyGJTYMDt19Few7E4xj40YZHqtqMWDWJjyij/UjLjjpljPXUMqNcL+mkf7V
         JwQHhEagPXgG4iQae/bM/bJGPNoPrKvpUrixtc5rqPJLvwP68ZMdZCGM2vQ7RZIOHBEE
         SsLWqjwO2S/6enF7pliIzFB4o4MMVNOf5BKAVlmtheqpxPeq9bUVUMzYuR91uXKUxLZ0
         EyFX+ASny2gpCGnV4a+9hEz7lmjORv/oyddHbUD88obyw4oobRsaB6zlVxROintUAMhD
         /RZQ==
X-Gm-Message-State: AOAM530LI4DLkP8WYwbrF6L9HZKMkxBpXzBa48Gow6F6xAKT99OKXapR
        A0QjmdGlXLiGBkp4TJRmzhXFvA==
X-Google-Smtp-Source: ABdhPJxiat8mqGQk0rzmDCTJ2P+wIrD4jaQUuNvztLW+VhHLOH/5Wduf2SjBu+iA3HIgB6sZD3Mlbg==
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr47272583wmg.67.1639498609517;
        Tue, 14 Dec 2021 08:16:49 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a9sm295116wrt.66.2021.12.14.08.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 08:16:49 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mjpeg-users@lists.sourceforge.net,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 10/18] staging: media: zoran: introduce zoran_i2c_init
Date:   Tue, 14 Dec 2021 16:16:28 +0000
Message-Id: <20211214161636.1886900-11-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214161636.1886900-1-clabbe@baylibre.com>
References: <20211214161636.1886900-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduces the size of the probe function by adding zoran_i2c_init/zoran_i2c_exit
functions.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zoran_card.c | 73 ++++++++++++++++++------
 1 file changed, 54 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/media/zoran/zoran_card.c b/drivers/staging/media/zoran/zoran_card.c
index 19eb3150074a..a00ad40244d0 100644
--- a/drivers/staging/media/zoran/zoran_card.c
+++ b/drivers/staging/media/zoran/zoran_card.c
@@ -931,6 +931,53 @@ static int zoran_init_video_devices(struct zoran *zr)
 	return err;
 }
 
+/*
+ * v4l2_device_unregister() will care about removing zr->encoder/zr->decoder
+ * via v4l2_i2c_subdev_unregister()
+ */
+static int zoran_i2c_init(struct zoran *zr)
+{
+	int err;
+
+	pci_info(zr->pci_dev, "Initializing i2c bus...\n");
+
+	err = zoran_register_i2c(zr);
+	if (err) {
+		pci_err(zr->pci_dev, "%s - cannot initialize i2c bus\n", __func__);
+		return err;
+	}
+
+	zr->decoder = v4l2_i2c_new_subdev(&zr->v4l2_dev, &zr->i2c_adapter,
+					  zr->card.i2c_decoder, 0,
+					  zr->card.addrs_decoder);
+	if (!zr->decoder) {
+		pci_err(zr->pci_dev, "Fail to get decoder %s\n", zr->card.i2c_decoder);
+		err = -EINVAL;
+		goto error_decoder;
+	}
+
+	if (zr->card.i2c_encoder) {
+		zr->encoder = v4l2_i2c_new_subdev(&zr->v4l2_dev, &zr->i2c_adapter,
+						  zr->card.i2c_encoder, 0,
+						  zr->card.addrs_encoder);
+		if (!zr->encoder) {
+			pci_err(zr->pci_dev, "Fail to get encoder %s\n", zr->card.i2c_encoder);
+			err = -EINVAL;
+			goto error_decoder;
+		}
+	}
+	return 0;
+
+error_decoder:
+	zoran_unregister_i2c(zr);
+	return err;
+}
+
+static void zoran_i2c_exit(struct zoran *zr)
+{
+	zoran_unregister_i2c(zr);
+}
+
 void zoran_open_init_params(struct zoran *zr)
 {
 	int i;
@@ -1059,7 +1106,7 @@ static void zoran_remove(struct pci_dev *pdev)
 	videocodec_exit(zr);
 
 	/* unregister i2c bus */
-	zoran_unregister_i2c(zr);
+	zoran_i2c_exit(zr);
 	/* disable PCI bus-mastering */
 	zoran_set_pci_master(zr, 0);
 	/* put chip into reset */
@@ -1340,22 +1387,10 @@ static int zoran_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	zr36057_restart(zr);
-	/* i2c */
-	pci_info(zr->pci_dev, "Initializing i2c bus...\n");
 
-	if (zoran_register_i2c(zr) < 0) {
-		pci_err(pdev, "%s - can't initialize i2c bus\n", __func__);
+	err = zoran_i2c_init(zr);
+	if (err)
 		goto zr_free_irq;
-	}
-
-	zr->decoder = v4l2_i2c_new_subdev(&zr->v4l2_dev, &zr->i2c_adapter,
-					  zr->card.i2c_decoder, 0,
-					  zr->card.addrs_decoder);
-
-	if (zr->card.i2c_encoder)
-		zr->encoder = v4l2_i2c_new_subdev(&zr->v4l2_dev, &zr->i2c_adapter,
-						  zr->card.i2c_encoder, 0,
-						  zr->card.addrs_encoder);
 
 	pci_info(zr->pci_dev, "Initializing videocodec bus...\n");
 	err = videocodec_init(zr);
@@ -1370,15 +1405,15 @@ static int zoran_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (zr->card.video_codec != 0) {
 		master_codec = zoran_setup_videocodec(zr, zr->card.video_codec);
 		if (!master_codec)
-			goto zr_unreg_i2c;
+			goto zr_unreg_videocodec;
 		zr->codec = videocodec_attach(master_codec);
 		if (!zr->codec) {
 			pci_err(pdev, "%s - no codec found\n", __func__);
-			goto zr_unreg_i2c;
+			goto zr_unreg_videocodec;
 		}
 		if (zr->codec->type != zr->card.video_codec) {
 			pci_err(pdev, "%s - wrong codec\n", __func__);
-			goto zr_detach_codec;
+			goto zr_unreg_videocodec;
 		}
 	}
 	if (zr->card.video_vfe != 0) {
@@ -1417,7 +1452,7 @@ static int zoran_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 zr_unreg_videocodec:
 	videocodec_exit(zr);
 zr_unreg_i2c:
-	zoran_unregister_i2c(zr);
+	zoran_i2c_exit(zr);
 zr_free_irq:
 	btwrite(0, ZR36057_SPGPPCR);
 	pci_free_irq(zr->pci_dev, 0, zr);
-- 
2.32.0

