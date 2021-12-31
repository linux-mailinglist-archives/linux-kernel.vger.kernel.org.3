Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F662482426
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 14:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhLaNTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 08:19:04 -0500
Received: from cae.in-ulm.de ([217.10.14.231]:44878 "EHLO cae.in-ulm.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhLaNTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 08:19:03 -0500
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Dec 2021 08:19:03 EST
Received: by cae.in-ulm.de (Postfix, from userid 1000)
        id DE23114042E; Fri, 31 Dec 2021 14:12:21 +0100 (CET)
Date:   Fri, 31 Dec 2021 14:12:21 +0100
From:   "Christian A. Ehrhardt" <lk@c--e.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Subject: hda/cs8409: Fix internal speaker detection
Message-ID: <20211231131221.itwotyfk5qomn7n6@cae.in-ulm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have a DELL Inspirion 3501 laptop with a cirrus cs8904 HDA codec.
With more recent kernels the internal speakers stopped working.
I bisected the issue and tracked it down to this commit 

| commit c8b4f0865e82c14924c69c07d985af3ee9133316
| Author: Stefan Binding <sbinding@opensource.cirrus.com>
| Date:   Wed Aug 11 19:56:52 2021 +0100
|
|     ALSA: hda/cs8409: Remove unnecessary delays
        
After a bit of experimenting with the timeouts I came
up with the patch below that fixes the issue for me.

However, I don't have the specs for the chip, i.e. I don't
know what a theoretically correct value would be.

Suggested patch below, please consider inclusion.

     regards   Christian

From 9c796d221171c6d12fd84ae4f5c8315030c8c4ca Mon Sep 17 00:00:00 2001
From: "Christian A. Ehrhardt" <lk@c--e.de>
Date: Fri, 31 Dec 2021 10:33:19 +0100
Subject: [PATCH 1/2] ALSA: hda/cs8409: Increase delay during jack detection

Commit c8b4f0865e82 reduced delays related to cs42l42 jack
detection. However, the change was too aggressive. As a result
internal speakers on DELL Inspirion 3501 ac8b4f0865e82re not detected.

Increase the delay in cs42l42_run_jack_detect() a bit.

Fixes: c8b4f0865e82 ("ALSA: hda/cs8409: Remove unnecessary delays")
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 sound/pci/hda/patch_cs8409.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 039b9f2f8e94..bf5d7f0c6ba5 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -628,8 +628,8 @@ static void cs42l42_run_jack_detect(struct sub_codec *cs42l42)
 	cs8409_i2c_write(cs42l42, 0x1b74, 0x07);
 	cs8409_i2c_write(cs42l42, 0x131b, 0xFD);
 	cs8409_i2c_write(cs42l42, 0x1120, 0x80);
-	/* Wait ~100us*/
-	usleep_range(100, 200);
+	/* Wait ~20ms*/
+	usleep_range(20000, 25000);
 	cs8409_i2c_write(cs42l42, 0x111f, 0x77);
 	cs8409_i2c_write(cs42l42, 0x1120, 0xc0);
 }
-- 
2.32.0


