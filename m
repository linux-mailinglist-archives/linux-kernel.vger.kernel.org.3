Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2694482443
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 14:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhLaNyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 08:54:03 -0500
Received: from cae.in-ulm.de ([217.10.14.231]:44896 "EHLO cae.in-ulm.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhLaNyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 08:54:02 -0500
X-Greylist: delayed 569 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Dec 2021 08:54:02 EST
Received: by cae.in-ulm.de (Postfix, from userid 1000)
        id 4E7AA14042E; Fri, 31 Dec 2021 14:44:32 +0100 (CET)
Date:   Fri, 31 Dec 2021 14:44:32 +0100
From:   "Christian A. Ehrhardt" <cae@familie-ehrhardt.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Subject: hda/cs8904: Fix jack detection after resume
Message-ID: <20211231134432.atwmuzeceqiklcoa@cae.in-ulm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

while debugging something different, I found the following
jack detection related bug in the cs8904 driver on my DELL
Inspirion 3501:
- Plug in a headset, play some sound to make sure that
  the headset is detected.
- Stop the sound, wait for the codec to go into suspend (30s
  should be plenty enough time)
- Unplug the headset while the codec is in suspend.
- Try to play sound on the internal speakers. Notice that
  the the driver still thinks the headset is connected. As a result
  there is no sound on the internal speakers.

AFAICS the bug was introduced by the following commit:
| commit 424e531b47f83da87490464c5bf633dfb624fe6a
| Author: Stefan Binding <sbinding@opensource.cirrus.com>
| Date:   Fri Aug 27 12:02:51 2021 +0100
| 
|     ALSA: hda/cs8409: Ensure Type Detection is only run on startup when
|     necessary

The bug is with the hp_jack_in and mic_jack_in flags that are used
to determine if jack detection should be run etc. These flags
are cleared in the suspend path. This prevents a status change from
being detected after resume as hp_jack_in is cleared by suspend and
there is no jack due to the unplug of the headset.

This status change was never reported to the HDA core, though.
On suspend this is not done, only hd_jack_in is cleared and on
resume the driver thinks that there is no change the needs reporting.

Proposed fix below, please consider inclusion.

     regards   Christian

From 1dcf34c1d1c6c4852a86ec3ae189afa5d90ea09c Mon Sep 17 00:00:00 2001
From: "Christian A. Ehrhardt" <lk@c--e.de>
Date: Fri, 31 Dec 2021 12:13:48 +0100
Subject: [PATCH 2/2] ALSA: hda/cs8409: Fix Jack detection after resume

The suspend code unconditionally sets ->hp_jack_in and ->mic_jack_in
to zero but without reporting this status change to the HDA core.
To compensate for this, always assume a status change on the
first unsol event after boot or resume.

Fixes:	424e531b47f8 ("ALSA: hda/cs8409: Ensure Type Detection is only run on startup when necessary")
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 sound/pci/hda/patch_cs8409-tables.c | 3 +++
 sound/pci/hda/patch_cs8409.c        | 5 ++++-
 sound/pci/hda/patch_cs8409.h        | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_cs8409-tables.c b/sound/pci/hda/patch_cs8409-tables.c
index 0fb0a428428b..df0b4522babf 100644
--- a/sound/pci/hda/patch_cs8409-tables.c
+++ b/sound/pci/hda/patch_cs8409-tables.c
@@ -252,6 +252,7 @@ struct sub_codec cs8409_cs42l42_codec = {
 	.init_seq_num = ARRAY_SIZE(cs42l42_init_reg_seq),
 	.hp_jack_in = 0,
 	.mic_jack_in = 0,
+	.force_status_change = 1,
 	.paged = 1,
 	.suspended = 1,
 	.no_type_dect = 0,
@@ -443,6 +444,7 @@ struct sub_codec dolphin_cs42l42_0 = {
 	.init_seq_num = ARRAY_SIZE(dolphin_c0_init_reg_seq),
 	.hp_jack_in = 0,
 	.mic_jack_in = 0,
+	.force_status_change = 1,
 	.paged = 1,
 	.suspended = 1,
 	.no_type_dect = 0,
@@ -456,6 +458,7 @@ struct sub_codec dolphin_cs42l42_1 = {
 	.init_seq_num = ARRAY_SIZE(dolphin_c1_init_reg_seq),
 	.hp_jack_in = 0,
 	.mic_jack_in = 0,
+	.force_status_change = 1,
 	.paged = 1,
 	.suspended = 1,
 	.no_type_dect = 1,
diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index bf5d7f0c6ba5..aff2b5abb81e 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -636,7 +636,9 @@ static void cs42l42_run_jack_detect(struct sub_codec *cs42l42)
 
 static int cs42l42_handle_tip_sense(struct sub_codec *cs42l42, unsigned int reg_ts_status)
 {
-	int status_changed = 0;
+	int status_changed = cs42l42->force_status_change;
+
+	cs42l42->force_status_change = 0;
 
 	/* TIP_SENSE INSERT/REMOVE */
 	switch (reg_ts_status) {
@@ -791,6 +793,7 @@ static void cs42l42_suspend(struct sub_codec *cs42l42)
 	cs42l42->last_page = 0;
 	cs42l42->hp_jack_in = 0;
 	cs42l42->mic_jack_in = 0;
+	cs42l42->force_status_change = 1;
 
 	/* Put CS42L42 into Reset */
 	gpio_data = snd_hda_codec_read(codec, CS8409_PIN_AFG, 0, AC_VERB_GET_GPIO_DATA, 0);
diff --git a/sound/pci/hda/patch_cs8409.h b/sound/pci/hda/patch_cs8409.h
index ade2b838590c..d0b725c7285b 100644
--- a/sound/pci/hda/patch_cs8409.h
+++ b/sound/pci/hda/patch_cs8409.h
@@ -305,6 +305,7 @@ struct sub_codec {
 
 	unsigned int hp_jack_in:1;
 	unsigned int mic_jack_in:1;
+	unsigned int force_status_change:1;
 	unsigned int suspended:1;
 	unsigned int paged:1;
 	unsigned int last_page;
-- 
2.32.0

