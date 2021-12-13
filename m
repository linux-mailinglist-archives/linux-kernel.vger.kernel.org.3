Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8183472ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhLMLAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:00:47 -0500
Received: from out162-62-57-137.mail.qq.com ([162.62.57.137]:37579 "EHLO
        out162-62-57-137.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232749AbhLMLAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639393238;
        bh=u1lc4/21RdKYP+fM/Qi93hsRzybEub1fMzz15gjnxfk=;
        h=From:To:Cc:Subject:Date;
        b=p+uttOmcZYoV/p6H+FPmYISAI5cMm0SzFm4A1t3O+8QdqdGgEaZ2EbBPuVma5Zxgt
         r7XIl4YBS2S2lhfosFVfmcx5//f/5xFemKHac4AxkHGMOOBr/uqSu/UJZAnWP+fOWL
         gSxLKaLym3DrNKcmtcQb8osDnnXjJch3WHQoIfuE=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrsza7.qq.com (NewEsmtp) with SMTP
        id D3130477; Mon, 13 Dec 2021 18:52:49 +0800
X-QQ-mid: xmsmtpt1639392769trvav6rqp
Message-ID: <tencent_1E3950293AC22395ACFE99404C985D738309@qq.com>
X-QQ-XMAILINFO: MmWQdRkIb8niVI+ZUP/cjeYl0mj3kIryaWYG8J1BmJSztV9ztwQoOc4xjAK1/s
         W6if+2yi0jx1j1ZaDcJSg14N/vegmwvdAbefeLI7kd5zPkfBT1F8u7q4+LHDiwHcbJiQPvM7eP1b
         SWhZ20rKiPi0gFqg/wNMXhy92ev3S9mO0+bG1YmSotrcHeBqz2pKidpTQSlcTavsAWy807sRKYcA
         tWFJnvVldyAlIOrWfKCD+nFqF4OC0lkmT4DhN/Vb+wkn8Ae+u424O0wCJawuMRD/py+bhy/iriYX
         egzN69m+p2OwUCRSlHoON3Ur+v82nqRJOGcc3p1jpUmwENL9GaZGu/9Uvb7yUj+P29WJdFOiVvq3
         gp2i4+LHtshtyBK+DnY+zBek4bZLliIl6LDD6hM4QXYnJT8Jy0ksPmTkExUlnHh4Z7FJa3uXTJmX
         8m1YTCCQkkioyNodguHq0wkMklgGXMChDr+9VeLbtufaA1P6xz0T0t7+9HqZR88PS/KoADVLrQR6
         ZJCRdc4xTUZpSvbiO9ByorPI0vQS1O7g+53tp29xhDHaCt8Ut6U/2I7RuHH78OOzd6o8RQiuRt7S
         nWFgx5eqc1IgMrwXZw5BS8Q+/L7aid4bKEeyu378yYkPPP4XyUuSAVY9wwI8XnLVEofDRBP/ySkD
         m3qD5a0+iCCUdtsh0iOTZLaBk/1GHJO7y9WoTYpWyNRICxtjIXhZkfhP6bMgCovCvO4C0f4ZGrSq
         GN0w1/+wg628GwPTHx4bjcajZcS5EFb5zAtUjDEwKl9Hm8kpXoM2A7GPv5xTFZ2YhuqsvxopB9z+
         M1HblEGmW/aJY+fXHbtp/7FmJFMq8KT4EEb5i3LdwDOHg5Taifenq3BK9SWx9Ap2Qp6kvzS7x2VA
         pcDpsyiiHL
From:   Xiaoke Wang <xkernel.wang@foxmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v2] ALSA: sound/isa/gus: check the return value of kstrdup()
Date:   Mon, 13 Dec 2021 18:52:32 +0800
X-OQ-MSGID: <20211213105232.1052-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kstrdup() returns NULL when some internal memory errors happen, it is
better to check the return value of it. Otherwise, we may not to be able
to catch some memory errors in time.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
Changes in v2:
 - add the proper error handling.
Thanks for the suggestions from Takashi Iwai. In the future, I'll pay 
more attention to what he mentioned.
---
sound/isa/gus/gus_mem.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/isa/gus/gus_mem.c b/sound/isa/gus/gus_mem.c
index ff9480f..4c691db 100644
--- a/sound/isa/gus/gus_mem.c
+++ b/sound/isa/gus/gus_mem.c
@@ -199,6 +199,10 @@ struct snd_gf1_mem_block *snd_gf1_mem_alloc(struct snd_gf1_mem * alloc, int owne
 		memcpy(&block.share_id, share_id, sizeof(block.share_id));
 	block.owner = owner;
 	block.name = kstrdup(name, GFP_KERNEL);
+	if (block.name == NULL) {
+		snd_gf1_mem_lock(alloc, 1);
+		return NULL;
+	}
 	nblock = snd_gf1_mem_xalloc(alloc, &block);
 	snd_gf1_mem_lock(alloc, 1);
 	return nblock;
@@ -237,13 +241,13 @@ int snd_gf1_mem_init(struct snd_gus_card * gus)
 		block.ptr = 0;
 		block.size = 1024;
 		block.name = kstrdup("InterWave LFOs", GFP_KERNEL);
-		if (snd_gf1_mem_xalloc(alloc, &block) == NULL)
+		if (block.name == NULL || snd_gf1_mem_xalloc(alloc, &block) == NULL)
 			return -ENOMEM;
 	}
 	block.ptr = gus->gf1.default_voice_address;
 	block.size = 4;
 	block.name = kstrdup("Voice default (NULL's)", GFP_KERNEL);
-	if (snd_gf1_mem_xalloc(alloc, &block) == NULL)
+	if (block.name == NULL || snd_gf1_mem_xalloc(alloc, &block) == NULL)
 		return -ENOMEM;
 #ifdef CONFIG_SND_DEBUG
 	snd_card_ro_proc_new(gus->card, "gusmem", gus, snd_gf1_mem_info_read);
-- 
