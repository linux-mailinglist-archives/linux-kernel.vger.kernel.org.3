Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB81464A40
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 09:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348102AbhLAJCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 04:02:37 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:59037 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348075AbhLAJCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:02:20 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=cuibixuan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Uz-4zV2_1638349134;
Received: from VM20210331-25.tbsite.net(mailfrom:cuibixuan@linux.alibaba.com fp:SMTPD_---0Uz-4zV2_1638349134)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 01 Dec 2021 16:58:58 +0800
From:   Bixuan Cui <cuibixuan@linux.alibaba.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     cuibixuan@linux.alibaba.com, perex@perex.cz, tiwai@suse.com
Subject: [PATCH -next] ALSA: oss: fix compile error when OSS_DEBUG is enabled
Date:   Wed,  1 Dec 2021 16:58:54 +0800
Message-Id: <1638349134-110369-1-git-send-email-cuibixuan@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix compile error when OSS_DEBUG is enabled:
    sound/core/oss/pcm_oss.c: In function 'snd_pcm_oss_set_trigger':
    sound/core/oss/pcm_oss.c:2055:10: error: 'substream' undeclared (first
    use in this function); did you mean 'csubstream'?
      pcm_dbg(substream->pcm, "pcm_oss: trigger = 0x%x\n", trigger);
              ^

Fixes: 61efcee8608c ("ALSA: oss: Use standard printk helpers")
Signed-off-by: Bixuan Cui <cuibixuan@linux.alibaba.com>
---
 sound/core/oss/pcm_oss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 82a8187..bb37665 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -2052,7 +2052,7 @@ static int snd_pcm_oss_set_trigger(struct snd_pcm_oss_file *pcm_oss_file, int tr
 	int err, cmd;
 
 #ifdef OSS_DEBUG
-	pcm_dbg(substream->pcm, "pcm_oss: trigger = 0x%x\n", trigger);
+	pr_debug("pcm_oss: trigger = 0x%x\n", trigger);
 #endif
 	
 	psubstream = pcm_oss_file->streams[SNDRV_PCM_STREAM_PLAYBACK];
-- 
1.8.3.1

