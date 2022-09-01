Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D93C5A9AB1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbiIAOms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiIAOmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:42:45 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC80776976
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:42:41 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s206so16588653pgs.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 07:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=fbvLaxBSrUU1twip21pfwSPLgyOYXUmDr/PBKjQl9Hk=;
        b=iBNu0BAJj/GpEUqQRjnaHH1UAVKM0yqNr+vLtcPE94fECJjuF6vBMeoGPa5BqbF31d
         aCdf1DE9mIPgnNBkJCcVS5e9oT+mAhFu6N85WXBEU4D42jTaTdR/FTe9a9R/l5c16W96
         x8Ps2dkMZ/jFStSqosO9ss1JRD7GN2Nvz6GjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=fbvLaxBSrUU1twip21pfwSPLgyOYXUmDr/PBKjQl9Hk=;
        b=5GlVfrP5ppBdWJtSB7QrjYsiDX/nSjTrznKSrptwalwJiHOHUCHVhWoZVKDhPQIu2Q
         +Pz7mVx7erdXmv0w6PsMfz/6Ey0d7v9QqeMgtjn5xdEqfxQ0diQuM441qSY7gMMo5eUx
         ZgthUEewH46xV9On9sKZqamasq3oyfT6HtCKeoj1N74pMaV0xQbcJ8OmAABkbRnpjv3V
         Or9FO0JnYzEaoG/NCFzm3kyChify5sWhOBIUPRHBpkBJuyKuEhCGbfLIE+3Ms1xp2mGH
         sW/9w5Wm4BUuRf/plgPCPQpJDRUcY3v8ZRaoo2JBBbzf2m4d0kqei4phxdw0M1rv+dsf
         TtVQ==
X-Gm-Message-State: ACgBeo2Bz+uKEwNXkHS4vp4eEzXnTQSKGP5LpGKbdIpMrQuG/geW+ZUI
        jwDWXrsTwsrB3+/c0gnpauJVUQnFSZHQghY+
X-Google-Smtp-Source: AA6agR6BfX/F1wz6XflLFLFd19euXTh7VtM19NzJrOeQTVd832Lr0ExH5kSESTiAQwpUNn2ABOJ4Wg==
X-Received: by 2002:a63:1a46:0:b0:42c:414a:95ee with SMTP id a6-20020a631a46000000b0042c414a95eemr14901158pgm.386.1662043361169;
        Thu, 01 Sep 2022 07:42:41 -0700 (PDT)
Received: from pteerapong.c.googlers.com.com (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with ESMTPSA id z18-20020a170903019200b001709b9d292esm4238112plg.268.2022.09.01.07.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 07:42:40 -0700 (PDT)
From:   Pattara Teerapong <pteerapong@chromium.org>
To:     alsa-devel@alsa-project.org
Cc:     Pattara Teerapong <pteerapong@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: aloop: Fix random zeros in capture data when using jiffies timer
Date:   Thu,  1 Sep 2022 14:40:36 +0000
Message-Id: <20220901144036.4049060-1-pteerapong@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In loopback_jiffies_timer_pos_update(), we are getting jiffies twice.
First time for playback, second time for capture. Jiffies can be updated
between these two calls and if the capture jiffies is larger, extra zeros
will be filled in the capture buffer.

Change to get jiffies once and use it for both playback and capture.

Signed-off-by: Pattara Teerapong <pteerapong@chromium.org>
---

 sound/drivers/aloop.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 9b4a7cdb103a..12f12a294df5 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -605,17 +605,18 @@ static unsigned int loopback_jiffies_timer_pos_update
 			cable->streams[SNDRV_PCM_STREAM_PLAYBACK];
 	struct loopback_pcm *dpcm_capt =
 			cable->streams[SNDRV_PCM_STREAM_CAPTURE];
-	unsigned long delta_play = 0, delta_capt = 0;
+	unsigned long delta_play = 0, delta_capt = 0, cur_jiffies;
 	unsigned int running, count1, count2;
 
+	cur_jiffies = jiffies;
 	running = cable->running ^ cable->pause;
 	if (running & (1 << SNDRV_PCM_STREAM_PLAYBACK)) {
-		delta_play = jiffies - dpcm_play->last_jiffies;
+		delta_play = cur_jiffies - dpcm_play->last_jiffies;
 		dpcm_play->last_jiffies += delta_play;
 	}
 
 	if (running & (1 << SNDRV_PCM_STREAM_CAPTURE)) {
-		delta_capt = jiffies - dpcm_capt->last_jiffies;
+		delta_capt = cur_jiffies - dpcm_capt->last_jiffies;
 		dpcm_capt->last_jiffies += delta_capt;
 	}
 
-- 
2.37.2.789.g6183377224-goog

