Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018B14F98FD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbiDHPHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbiDHPHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:07:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B22031E5A7C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 08:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649430297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Nf3doDTjAQOJeXMo+td/oIn+T9zeQzKA6cjU7aYrP9I=;
        b=RJbv4h0Pbnil4Ii/WTd2EJEwqt9/Sr9vCV84XRnK7EhCnNxokArHoy9iDYklWypG/OVrbF
        19Rd+KNixzWpq7POBP7xztM2KXuc5QBsYKElaXFEuUjm01CjO6Y7+v9vzllP69pIKwhX4N
        iNKe5dlkFwJba8y5jY545MSwsvX/uR8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-tNJqkt45MUWuqfztnYAd0g-1; Fri, 08 Apr 2022 11:04:56 -0400
X-MC-Unique: tNJqkt45MUWuqfztnYAd0g-1
Received: by mail-qk1-f199.google.com with SMTP id c19-20020a05620a0cf300b005f17891c015so3774292qkj.18
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 08:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nf3doDTjAQOJeXMo+td/oIn+T9zeQzKA6cjU7aYrP9I=;
        b=DAhk+TFucQT/tIQBzZdTjPgeCSqRB+1BrMgIGJytqrmH2rHQLjYoRf78+VifgYrGwO
         HB9lhspn82OC6RdcW1myBNHV0yFKiPzZld2d5cR83hu5XbXrxl60FCM9qoIvE4CnbnHw
         4D1QV/3hd5hFDTwo/ePLcrYEHDk503EXsaffBM8DlUhkKR5TGH1R46LbaFzr88AEUTgt
         DWrZiLNh7EhmwtzP3/e3x2bNGEBqHkJrebb/vamMGCNTFqZWcNbGHFo/ONc9dwblVENa
         MOB16Jwxq6A6BOjvtqodF02nkcsxgnIxabRTynQBqKYnJ89bo8WMKM/+0XpdPlgURZHW
         dpgQ==
X-Gm-Message-State: AOAM531CpWqsoAYVX1X1bpiaO4QYFKvLIQ98gDcxTlTgKHQh436OQyae
        dw59PtS0b3yrLfGIcWRgeKjWIa6RKOjZWWImJ+ibbhBuGxIHpKEzBp1NpV0WjQlgSTUkqzJ4Azf
        buNxuvUWrzM8LMuCYGvGMsFY3
X-Received: by 2002:ad4:5d48:0:b0:440:ef43:3667 with SMTP id jk8-20020ad45d48000000b00440ef433667mr16347227qvb.110.1649430295310;
        Fri, 08 Apr 2022 08:04:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCVc7ORoGlnJj5uukafi+K7qBY9LttNX9++JT3/dAotS3gtzJ8mGW4F4g7a6PbpA5LgjzL4g==
X-Received: by 2002:ad4:5d48:0:b0:440:ef43:3667 with SMTP id jk8-20020ad45d48000000b00440ef433667mr16347198qvb.110.1649430295084;
        Fri, 08 Apr 2022 08:04:55 -0700 (PDT)
Received: from fedora.hitronhub.home (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id g9-20020a05620a108900b0067b13036bd5sm13700748qkk.52.2022.04.08.08.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 08:04:54 -0700 (PDT)
From:   Adrien Thierry <athierry@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc:     Adrien Thierry <athierry@redhat.com>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: bcm2835-audio: remove compat ALSA card
Date:   Fri,  8 Apr 2022 11:03:58 -0400
Message-Id: <20220408150359.26661-1-athierry@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove compat ALSA card, which has overlapping functionality with the
two other cards described by the driver (HDMI and headphones)

This handles TODO item "Revisit multi-cards options and PCM route mixer
control".

Move the S/PDIF device that was part of the compat ALSA card to the HDMI
card.

Only enable headphones card by default, because HDMI breaks when using
both vc4 and bcm2835-audio with HDMI card enabled.

Signed-off-by: Adrien Thierry <athierry@redhat.com>
---

I was able to test PCM output on 3.5mm and HDMI on a Raspberry Pi 4.
However, I couldn't test the HDMI S/PDIF device since I don't own a S/PDIF
capable speaker.

 .../vc04_services/bcm2835-audio/bcm2835-ctl.c | 86 ++-----------------
 .../vc04_services/bcm2835-audio/bcm2835.c     | 33 ++-----
 2 files changed, 15 insertions(+), 104 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
index 3703409715da..1c1f040122d7 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
@@ -117,15 +117,6 @@ static const struct snd_kcontrol_new snd_bcm2835_ctl[] = {
 		.get = snd_bcm2835_ctl_get,
 		.put = snd_bcm2835_ctl_put,
 	},
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "PCM Playback Route",
-		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
-		.private_value = PCM_PLAYBACK_DEVICE,
-		.info = snd_bcm2835_ctl_info,
-		.get = snd_bcm2835_ctl_get,
-		.put = snd_bcm2835_ctl_put,
-	},
 };
 
 static int snd_bcm2835_spdif_default_info(struct snd_kcontrol *kcontrol,
@@ -220,7 +211,14 @@ static int create_ctls(struct bcm2835_chip *chip, size_t size,
 	return 0;
 }
 
-int snd_bcm2835_new_ctl(struct bcm2835_chip *chip)
+int snd_bcm2835_new_headphones_ctl(struct bcm2835_chip *chip)
+{
+	strscpy(chip->card->mixername, "Broadcom Mixer", sizeof(chip->card->mixername));
+	return create_ctls(chip, ARRAY_SIZE(snd_bcm2835_ctl),
+			   snd_bcm2835_ctl);
+}
+
+int snd_bcm2835_new_hdmi_ctl(struct bcm2835_chip *chip)
 {
 	int err;
 
@@ -232,71 +230,3 @@ int snd_bcm2835_new_ctl(struct bcm2835_chip *chip)
 			   snd_bcm2835_spdif);
 }
 
-static const struct snd_kcontrol_new snd_bcm2835_headphones_ctl[] = {
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Headphone Playback Volume",
-		.index = 0,
-		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
-			  SNDRV_CTL_ELEM_ACCESS_TLV_READ,
-		.private_value = PCM_PLAYBACK_VOLUME,
-		.info = snd_bcm2835_ctl_info,
-		.get = snd_bcm2835_ctl_get,
-		.put = snd_bcm2835_ctl_put,
-		.count = 1,
-		.tlv = {.p = snd_bcm2835_db_scale}
-	},
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Headphone Playback Switch",
-		.index = 0,
-		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
-		.private_value = PCM_PLAYBACK_MUTE,
-		.info = snd_bcm2835_ctl_info,
-		.get = snd_bcm2835_ctl_get,
-		.put = snd_bcm2835_ctl_put,
-		.count = 1,
-	}
-};
-
-int snd_bcm2835_new_headphones_ctl(struct bcm2835_chip *chip)
-{
-	strscpy(chip->card->mixername, "Broadcom Mixer", sizeof(chip->card->mixername));
-	return create_ctls(chip, ARRAY_SIZE(snd_bcm2835_headphones_ctl),
-			   snd_bcm2835_headphones_ctl);
-}
-
-static const struct snd_kcontrol_new snd_bcm2835_hdmi[] = {
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "HDMI Playback Volume",
-		.index = 0,
-		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
-			  SNDRV_CTL_ELEM_ACCESS_TLV_READ,
-		.private_value = PCM_PLAYBACK_VOLUME,
-		.info = snd_bcm2835_ctl_info,
-		.get = snd_bcm2835_ctl_get,
-		.put = snd_bcm2835_ctl_put,
-		.count = 1,
-		.tlv = {.p = snd_bcm2835_db_scale}
-	},
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "HDMI Playback Switch",
-		.index = 0,
-		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
-		.private_value = PCM_PLAYBACK_MUTE,
-		.info = snd_bcm2835_ctl_info,
-		.get = snd_bcm2835_ctl_get,
-		.put = snd_bcm2835_ctl_put,
-		.count = 1,
-	}
-};
-
-int snd_bcm2835_new_hdmi_ctl(struct bcm2835_chip *chip)
-{
-	strscpy(chip->card->mixername, "Broadcom Mixer", sizeof(chip->card->mixername));
-	return create_ctls(chip, ARRAY_SIZE(snd_bcm2835_hdmi),
-			   snd_bcm2835_hdmi);
-}
-
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index 628732d7bf6a..00bc898b0189 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -10,17 +10,13 @@
 #include "bcm2835.h"
 
 static bool enable_hdmi;
-static bool enable_headphones;
-static bool enable_compat_alsa = true;
+static bool enable_headphones = true;
 static int num_channels = MAX_SUBSTREAMS;
 
 module_param(enable_hdmi, bool, 0444);
 MODULE_PARM_DESC(enable_hdmi, "Enables HDMI virtual audio device");
 module_param(enable_headphones, bool, 0444);
 MODULE_PARM_DESC(enable_headphones, "Enables Headphones virtual audio device");
-module_param(enable_compat_alsa, bool, 0444);
-MODULE_PARM_DESC(enable_compat_alsa,
-		 "Enables ALSA compatibility virtual audio device");
 module_param(num_channels, int, 0644);
 MODULE_PARM_DESC(num_channels, "Number of audio channels (default: 8)");
 
@@ -63,19 +59,20 @@ struct bcm2835_audio_driver {
 	enum snd_bcm2835_route route;
 };
 
-static int bcm2835_audio_alsa_newpcm(struct bcm2835_chip *chip,
+static int bcm2835_audio_dual_newpcm(struct bcm2835_chip *chip,
 				     const char *name,
 				     enum snd_bcm2835_route route,
 				     u32 numchannels)
 {
 	int err;
 
-	err = snd_bcm2835_new_pcm(chip, "bcm2835 ALSA", 0, AUDIO_DEST_AUTO,
-				  numchannels - 1, false);
+	err = snd_bcm2835_new_pcm(chip, name, 0, route,
+				  numchannels, false);
+
 	if (err)
 		return err;
 
-	err = snd_bcm2835_new_pcm(chip, "bcm2835 IEC958/HDMI", 1, 0, 1, true);
+	err = snd_bcm2835_new_pcm(chip, "IEC958", 1, route, 1, true);
 	if (err)
 		return err;
 
@@ -90,18 +87,6 @@ static int bcm2835_audio_simple_newpcm(struct bcm2835_chip *chip,
 	return snd_bcm2835_new_pcm(chip, name, 0, route, numchannels, false);
 }
 
-static struct bcm2835_audio_driver bcm2835_audio_alsa = {
-	.driver = {
-		.name = "bcm2835_alsa",
-		.owner = THIS_MODULE,
-	},
-	.shortname = "bcm2835 ALSA",
-	.longname  = "bcm2835 ALSA",
-	.minchannels = 2,
-	.newpcm = bcm2835_audio_alsa_newpcm,
-	.newctl = snd_bcm2835_new_ctl,
-};
-
 static struct bcm2835_audio_driver bcm2835_audio_hdmi = {
 	.driver = {
 		.name = "bcm2835_hdmi",
@@ -110,7 +95,7 @@ static struct bcm2835_audio_driver bcm2835_audio_hdmi = {
 	.shortname = "bcm2835 HDMI",
 	.longname  = "bcm2835 HDMI",
 	.minchannels = 1,
-	.newpcm = bcm2835_audio_simple_newpcm,
+	.newpcm = bcm2835_audio_dual_newpcm,
 	.newctl = snd_bcm2835_new_hdmi_ctl,
 	.route = AUDIO_DEST_HDMI
 };
@@ -134,10 +119,6 @@ struct bcm2835_audio_drivers {
 };
 
 static struct bcm2835_audio_drivers children_devices[] = {
-	{
-		.audio_driver = &bcm2835_audio_alsa,
-		.is_enabled = &enable_compat_alsa,
-	},
 	{
 		.audio_driver = &bcm2835_audio_hdmi,
 		.is_enabled = &enable_hdmi,

base-commit: 1831fed559732b132aef0ea8261ac77e73f7eadf
-- 
2.35.1

