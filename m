Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E214EE286
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241365AbiCaUVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiCaUVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:21:40 -0400
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23447C6ED6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:19:52 -0700 (PDT)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id a1Gln3Kfl9eePa1GmnadrV; Thu, 31 Mar 2022 22:19:49 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 31 Mar 2022 22:19:49 +0200
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: soc-pcm: use GFP_KERNEL when the code is sleepable
Date:   Thu, 31 Mar 2022 22:19:44 +0200
Message-Id: <e740f1930843060e025e3c0f17ec1393cfdafb26.1648757961.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the kzalloc() call in dpcm_be_connect(), there is no spin lock involved.
It's merely protected by card->pcm_mutex, instead.  The spinlock is applied
at the later call with snd_soc_pcm_stream_lock_irq() only for the list
manipulations.  (See it's *_irq(), not *_irqsave(); that means the context
being sleepable at that point.)  So, we can use GFP_KERNEL safely there.

This patch revert commit d8a9c6e1f676 ("ASoC: soc-pcm: use GFP_ATOMIC for
dpcm structure") which is no longer needed since commit b7898396f4bb
("ASoC: soc-pcm: Fix and cleanup DPCM locking").

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
See discussion in the thread at:
   https://lore.kernel.org/all/ed322b8821fa787907c1a4cce879564d1281b69d.1642331884.git.christophe.jaillet@wanadoo.fr/
---
 sound/soc/soc-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 9a954680d492..11c9853e9e80 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1214,7 +1214,7 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 		be_substream->pcm->nonatomic = 1;
 	}
 
-	dpcm = kzalloc(sizeof(struct snd_soc_dpcm), GFP_ATOMIC);
+	dpcm = kzalloc(sizeof(struct snd_soc_dpcm), GFP_KERNEL);
 	if (!dpcm)
 		return -ENOMEM;
 
-- 
2.32.0

