Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D785F471B82
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 17:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhLLQPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 11:15:42 -0500
Received: from out162-62-57-49.mail.qq.com ([162.62.57.49]:52123 "EHLO
        out162-62-57-49.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231533AbhLLQPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 11:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639325738;
        bh=+MGgQBi4hhhEZS4kFqjecsTC/3bTE6ObWs6UftGMrWs=;
        h=From:To:Cc:Subject:Date;
        b=BS2TajBsTT7+gvzfGLMrA7dHNW7vGZzBxu8cD1tTb+LDQwKG8OXoqhRKbuD1qe1aT
         HlnD4Csau5xznZhjSVD9dGz9l/3TKDOaSdirqdZtm1GGtjQ7ASIfqUcXZQ9Te3ETJH
         qJolmOTNeu3gsShruo2qeYc3jG1ANIr18UnPIizw=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc9.qq.com (NewEsmtp) with SMTP
        id 373A80BB; Mon, 13 Dec 2021 00:13:51 +0800
X-QQ-mid: xmsmtpt1639325631t325okpgz
Message-ID: <tencent_FB2FE472710C51BC87E7288DFF4380EC320A@qq.com>
X-QQ-XMAILINFO: MAMW4dxoxFytHlFp/K3w5rC1cM/YYuaCgK6GW8f1bs4CY6EVtHDdwucDyZdjnD
         4gc1xLDUJQLKLpPxqsVr0b55zNxdiGMDbUgLJhlTDPO133K8EuAGIEULW0HfMM/dQd/33mN6kcDU
         9F4y1PsoH4W4ezl/XMg2c7yO5cSJPjT1aa3+UmgK+THV84+0FSJmsibnu33kY1WnklMcm8PhFd+Z
         KB9yRQcLPIIb53vFjgXGFckArk3QV6Q3gS9S9OBqKM4ojg8vdptFelnetpRndAX0rwDMNXTAuBOg
         QxF6vCxlVRlIQOjHBD189E8nUiiMyrNQ2uEnVTIHX9Tar1bvrWb/Fp982PN7E65eVxsRvYHw8ciR
         KV2I0Ppzeq3QirjJbCArDzXaMy6oBIKqaevuRnytnUOLFgOR3ygFmK5iaE+l/4pI0ThOKjsot1tC
         rvHy5qOYMfr6+sosYDocpBGW+FwuE6utKSLDznUR+W6lh/Xks5SOF8O1MmDgLEdUsqf0yT3RyTlf
         FSOf6s7347MMsfzQ3JHplNcZ8Y4SOWlEjcFLlxWLUCkYY1Dwp0SLTMSQYED1sB9AulnLmvYvHO4o
         Reh+T4CGqydizVUKVf8BNnj0eEtFkQ38QPvwKAbELTq2wRxQF+NrMpG/lZK/tMm7pB6AnFIZRych
         5MXPBIZofBG7V24ZtoJ+JVSJ4efH2HDcRYMJN3lyhNK2/s0x0r58vaaKne7fRtcHnAeM8tSmi4St
         SJLmO6dJgLmdImjEfEPQi5mmaxjLA6NtD6UH37WVoCCNmLFg7hm/FCKfgl9OIrNVIda48LoreXiG
         GCLsXoPum7/AsuURlHSDvViEekHVnBs3m1XYhsUjIK+qkU9WrpVv8RKPy1R5mMlGC/gDfGIskLHg
         ==
From:   xkernel <xkernel.wang@foxmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        xkernel <xkernel.wang@foxmail.com>
Subject: [PATCH] ALSA: sound/isa/gus: check the return value of kstrdup()
Date:   Mon, 13 Dec 2021 00:13:05 +0800
X-OQ-MSGID: <20211212161305.2484-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kstrdup() returns NULL when some internal memory errors happen, it is
better to check the return value of it. Otherwise, we may not to be able
to catch some memory errors in time.

Signed-off-by: xkernel <xkernel.wang@foxmail.com>
---
 sound/isa/gus/gus_mem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/isa/gus/gus_mem.c b/sound/isa/gus/gus_mem.c
index ff9480f..f8d915f 100644
--- a/sound/isa/gus/gus_mem.c
+++ b/sound/isa/gus/gus_mem.c
@@ -199,6 +199,8 @@ struct snd_gf1_mem_block *snd_gf1_mem_alloc(struct snd_gf1_mem * alloc, int owne
 		memcpy(&block.share_id, share_id, sizeof(block.share_id));
 	block.owner = owner;
 	block.name = kstrdup(name, GFP_KERNEL);
+	if (block.name == NULL)
+		return NULL;
 	nblock = snd_gf1_mem_xalloc(alloc, &block);
 	snd_gf1_mem_lock(alloc, 1);
 	return nblock;
@@ -237,13 +239,13 @@ int snd_gf1_mem_init(struct snd_gus_card * gus)
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
