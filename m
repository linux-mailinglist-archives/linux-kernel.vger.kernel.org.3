Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227734E44B4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239373AbiCVRJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237970AbiCVRJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:09:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7066371ECF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:07:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2B6DF1F38C;
        Tue, 22 Mar 2022 17:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647968867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7BHpLrva0gn3z4ug3sivlVXdf446dwWnsWltmnc0TZg=;
        b=lpqB+3ia31feVNsJ+xBeXoPm6qiplwLJhmVWhDZV/IyaXPbcHw3SGJXSzRSs4AC4A/GUng
        pBBP5SQ+ligtAPpdNJZTRXrE3fhB8LOcXqKJ7LFW4xGGBNLbjQpvNsX2O/aL9VemqGMYlB
        53hv0qnsSQn2sro/BM4Y8R47P1laEwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647968867;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7BHpLrva0gn3z4ug3sivlVXdf446dwWnsWltmnc0TZg=;
        b=DZNpQcmbWVN9G8MQ1OCIhMSCIW7VkpTffNB6yrufNEyRTH9rnv6dvK62Km/q4i3NvKX5TL
        dXqcSVcCEbXCNUDA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
        by relay2.suse.de (Postfix) with ESMTP id 25492A3B87;
        Tue, 22 Mar 2022 17:07:47 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     Hu Jiahui <kirin.say@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ALSA: pcm: Fix races among concurrent read/write and buffer changes
Date:   Tue, 22 Mar 2022 18:07:18 +0100
Message-Id: <20220322170720.3529-3-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220322170720.3529-1-tiwai@suse.de>
References: <20220322170720.3529-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current PCM design, the read/write syscalls (as well as the
equivalent ioctls) are allowed before the PCM stream is running, that
is, at PCM PREPARED state.  Meanwhile, we also allow to re-issue
hw_params and hw_free ioctl calls at the PREPARED state that may
change or free the buffers, too.  The problem is that there is no
protection against those mix-ups.

This patch applies the previously introduced runtime->buffer_mutex to
the read/write operations so that the concurrent hw_params or hw_free
call can no longer interfere during the operation.  The mutex is
unlocked before scheduling, so we don't take it too long.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_lib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index f2090025236b..a40a35e51fad 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1906,9 +1906,11 @@ static int wait_for_avail(struct snd_pcm_substream *substream,
 		if (avail >= runtime->twake)
 			break;
 		snd_pcm_stream_unlock_irq(substream);
+		mutex_unlock(&runtime->buffer_mutex);
 
 		tout = schedule_timeout(wait_time);
 
+		mutex_lock(&runtime->buffer_mutex);
 		snd_pcm_stream_lock_irq(substream);
 		set_current_state(TASK_INTERRUPTIBLE);
 		switch (runtime->status->state) {
@@ -2219,6 +2221,7 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 
 	nonblock = !!(substream->f_flags & O_NONBLOCK);
 
+	mutex_lock(&runtime->buffer_mutex);
 	snd_pcm_stream_lock_irq(substream);
 	err = pcm_accessible_state(runtime);
 	if (err < 0)
@@ -2310,6 +2313,7 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 	if (xfer > 0 && err >= 0)
 		snd_pcm_update_state(substream, runtime);
 	snd_pcm_stream_unlock_irq(substream);
+	mutex_unlock(&runtime->buffer_mutex);
 	return xfer > 0 ? (snd_pcm_sframes_t)xfer : err;
 }
 EXPORT_SYMBOL(__snd_pcm_lib_xfer);
-- 
2.31.1

