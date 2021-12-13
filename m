Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F0647221A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhLMIHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:07:22 -0500
Received: from out162-62-58-211.mail.qq.com ([162.62.58.211]:53907 "EHLO
        out162-62-58-211.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232723AbhLMIHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639382835;
        bh=dpszwiQZqvjXUNdTHYC3Hj9j2IbSuRh/whKWdQwGCXE=;
        h=From:To:Cc:Subject:Date;
        b=UGeolYMPYNWI/1qZo7soz6aTtPmIo0m53HgKPdc3EwOxwSR/+9Qxb99Yn5Kj2Jn+l
         lA/lU3MqCsKurBKEqjpss77JA99e/LdO+M+KqcLHVPbbWrvLFYSBlAj70/IT1ps1tD
         HlTmyawJgaRCrPJf2rrUV6EWZMJErAejrSHhMU0A=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrsza23.qq.com (NewEsmtp) with SMTP
        id 1CC880C7; Mon, 13 Dec 2021 16:07:12 +0800
X-QQ-mid: xmsmtpt1639382832tpsk5pue2
Message-ID: <tencent_62C8C2B79490FE8D4000985D724D38842809@qq.com>
X-QQ-XMAILINFO: M+SXJ71vgvoOlbkb9tPfLUTj/yyxefpbY9PXk7f1W1n+rbfnJRjzZ2Bu9MUaE3
         +O4QaojLa9nG1oue46hB1s4BFJMNFjuamDygSetje132Kj45Gw4sQzn8XqODLiaGIv01Aqkh5Yc+
         4QFSmSZmC6J00OvKFLmRmczVU3pi71eHh+HIk/hxMOXNd0Uga2GTJcEhPk7nmsl/Ud4CBgGM3/SP
         PkFpjokBcVXs903bh7gIdVBMqfdCOcYpE8PI62YgEE+ejzaoT/5nebQtCjgBD4SS2El6noD5s4WJ
         uUvxFc4YnnlBggYgyIyZtsEn1xzmW/pO5pVlnStmjVwsfE5tcaSwRYcl1Fv8XChG3L2QUVJXMHid
         pR7IqvO3vPhsMBuTnkFLKhQPEUXO/mOYy5rLJ0bQ2Ji56rXr3mS8QnLxdwYm+mvJnZRLoI00F0xW
         ygvvn7XsS1lH4VDtsLotfqIoTpkbkDf4uT1R80LOkuLDVH2KRQcNYbsrdo3+r4BqKJi9lc4VnGze
         jAnOtoLxhv/4goTluoBhc7QH5fVyD59rfSez23yO3aUc1+VjOSqcPv+C0Pgx+ETN+N4HcnVxxgto
         x3NQV0O7i6UedbimCEryXwFu/zuNtYr+bkaWlWEDEZKKkDIgoZ/Tmn3JXeouE2Cc4w4X6g4NH5j1
         LbDHZrsHEql7s/uMbwmU/4OKaPqBm6JzbFhw2Va5m8xFmiI6TevbCBblRFDHTkoobIM45OZuNy47
         vbYSKVAqL2pQf41YLexgF6l2X8IeuElSgzJkkRTOi/t7xp7MfZg7e9fECR4R9Gh3y5DPGdmPXad4
         3kfpunOOZCd5ILLwG3r9uwg3Fc0Rwli60+DsShXO709P6ndqu4PS6IjoeK5kYeWZyjYzivU+4ROV
         nYziPN+N7LLTWP7rnD3uH8BkheYSwnvp1B4ifUgwgNgMrubgdNlqj9g+O+/9I0Jb5cSMvdeVTl
From:   Xiaoke Wang <xkernel.wang@foxmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: Re: [PATCH] ALSA: sound/isa/gus: check the return value of kstrdup()
Date:   Mon, 13 Dec 2021 16:06:47 +0800
X-OQ-MSGID: <20211213080647.4359-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: Compare with the last email, this one is using my full name.
kstrdup() returns NULL when some internal memory errors happen, it is
better to check the return value of it. Otherwise, we may not to be able
to catch some memory errors in time.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
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
