Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D96655C24E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbiF0KKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 06:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiF0KKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:10:36 -0400
Received: from sdore.me (unknown [89.188.170.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8342640C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:10:20 -0700 (PDT)
Received: by sdore.me (Postfix, from userid 1000)
        id 1345287F24B; Mon, 27 Jun 2022 13:00:44 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sdore.me; s=SERV;
        t=1656324044; bh=kKwJ/1I7KEuxIoPLdrkYJiu2t+xD/W5dhB262nifPKM=;
        h=From:To:Cc:Subject:Date;
        b=WIhXfqDAx91WP3nGCo8vGywCXvG4UEmddWxUuntzVqr4lri9AV90m4V/jirYKZljg
         kMuzZeBlBFwamFWKlGJQ7wMzE6E6AWOQHF+ixm+PwJc1wXHVSyEM1uIsv/0jb4Q5xF
         m3pny5vNwEtc39npnLoAp99/Zi9Q/F5SuAuoYkJU=
From:   Egor Vorontsov <sdoregor@sdore.me>
Cc:     Egor Vorontsov <sdoregor@sdore.me>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jonas Hahnfeld <hahnjo@hahnjo.de>,
        William Overton <willovertonuk@gmail.com>,
        Brendan Grieve <brendan@grieve.com.au>,
        Alexander Tsoy <alexander@tsoy.me>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] ALSA: usb-audio: Add quirk for Fiero SC-01
Date:   Mon, 27 Jun 2022 13:00:34 +0300
Message-Id: <20220627100041.2861494-1-sdoregor@sdore.me>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fiero SC-01 is a USB sound card with two mono inputs and a single
stereo output. The inputs are composed into a single stereo stream.

The device uses a vendor-provided driver on Windows and does not work
at all without it. The driver mostly provides ASIO functionality, but
also alters the way the sound card is queried for sample rates and
clocks.

ALSA queries those failing with an EPIPE (same as Windows 10 does).
Presumably, the vendor-provided driver does not query it at all, simply
matching by VID:PID. Thus, I consider this a buggy firmware and adhere
to a set of fixed endpoint quirks instead.

The soundcard has an internal clock. Implicit feedback mode is required
for the playback.

I have updated my device to v1.1.0 from a Windows 10 VM using a vendor-
provided binary prior to the development, hoping for it to just begin
working. The device provides no obvious way to downgrade the firmware,
and regardless, there's no binary available for v1.0.0 anyway.

Thus, I will be getting another unit to extend the patch with support
for that. Expected to be a simple copy-paste of the existing one,
though.

There were no previous reports of that device in context of Linux
anywhere. Other issues have been reported though, but that's out of the
scope.

Signed-off-by: Egor Vorontsov <sdoregor@sdore.me>
---
 sound/usb/quirks-table.h | 68 ++++++++++++++++++++++++++++++++++++++++
 sound/usb/quirks.c       |  2 ++
 2 files changed, 70 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 4f56e1784932..c61445eb83d8 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -4119,6 +4119,74 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		}
 	}
 },
+{
+	/*
+	 * Fiero SC-01 (firmware v1.1.0)
+	 */
+	USB_DEVICE(0x2b53, 0x0031),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "Fiero",
+		.product_name = "SC-01",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = &(const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			/* Playback */
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 2,
+					.fmt_bits = 24,
+					.iface = 1,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x01,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						   USB_ENDPOINT_SYNC_ASYNC,
+					.rates = SNDRV_PCM_RATE_48000 |
+						 SNDRV_PCM_RATE_96000,
+					.rate_min = 48000,
+					.rate_max = 96000,
+					.nr_rates = 2,
+					.rate_table = (unsigned int[]) { 48000, 96000 },
+					.clock = 0x29
+				}
+			},
+			/* Capture */
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 2,
+					.fmt_bits = 24,
+					.iface = 2,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x82,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						   USB_ENDPOINT_SYNC_ASYNC |
+						   USB_ENDPOINT_USAGE_IMPLICIT_FB,
+					.rates = SNDRV_PCM_RATE_48000 |
+						 SNDRV_PCM_RATE_96000,
+					.rate_min = 48000,
+					.rate_max = 96000,
+					.nr_rates = 2,
+					.rate_table = (unsigned int[]) { 48000, 96000 },
+					.clock = 0x29
+				}
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
 
 #undef USB_DEVICE_VENDOR_SPEC
 #undef USB_AUDIO_DEVICE
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index e8468f9b007d..81bdd921a279 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1908,6 +1908,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_ALIGN_TRANSFER),
 	DEVICE_FLG(0x1224, 0x2a25, /* Jieli Technology USB PHY 2.0 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x2b53, 0x0031, /* Fiero SC-01 (firmware v1.1.0) */
+		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 
 	/* Vendor matches */
 	VENDOR_FLG(0x045e, /* MS Lifecam */
-- 
2.36.1

