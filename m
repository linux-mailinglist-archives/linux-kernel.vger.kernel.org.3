Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E62C471594
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 20:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhLKTSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 14:18:33 -0500
Received: from out162-62-58-211.mail.qq.com ([162.62.58.211]:52907 "EHLO
        out162-62-58-211.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229560AbhLKTSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 14:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639250309;
        bh=p5n6NZ013xXHxvRMkqqySCKi6/eXKwLtJ9F70QGZc0o=;
        h=From:To:Cc:Subject:Date;
        b=r1Bld5GlqCMZVY7ZLGRCfTxxhQrWkrdRZacqtfdJjixAnIXiB17C1WHqT2UjkCpdX
         NdC91SrWeA721zdu8p0TqNq6tR7GCktBORqILXfIezaP063OTDmU2yDFhjqObOy264
         30kr9LIel7iP+1rxcP/kAJQUPBsPpkPb4VPfNQ6w=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrsza7.qq.com (NewEsmtp) with SMTP
        id 38E23CFB; Sun, 12 Dec 2021 01:14:14 +0800
X-QQ-mid: xmsmtpt1639242854tyvogz8ro
Message-ID: <tencent_3D368E118A8AF018A5B1FF16904166B2DC07@qq.com>
X-QQ-XMAILINFO: MgQY1K25Ph0m5cskmfXkJHT32Ic1Br3p3xihwpPCyouDYfrcqXKmOpkD63Sjx7
         JyAGlAGzvwR6jpDyiBKNosnXPC1dB3XyPG068Su9qs80c5yoGZh4zfBVW41hSlvbvIvctzAAiz8G
         E0SWDFjMFreEdLgrO5q1QKG21yk0ioYpxzI51MZVj94+SS4FmmtqQ6QkQVGy8hyOWi2KbhdcHRBC
         eyxyldjOaM1Uao7RMKEI9C+WIYIFt7aCBbf7MyZEk95+eXwzufIjfpz/TVuzoKH8SmIpzQ+I1aLE
         1m87OHjOqUUL8Gpxo0pXYb4bobFRIY+bzvETxKRPnXz/5RjXJtwNwfDcTnxTe8BdhOvv8WiClWjJ
         YB56GH6UpDlJP1eM583pB0r+QkZM/AqkT/ZiKcAW2SgXWw30kdBDXnI0R+b11WV7xYQikaGfaa89
         LXgOIlZzniQyUWkmu3qRov3TgDQPUZ7BkmetbCufQj6cWm+WEGEQoFAnLF2MDOZFwIDoVbW+5KoX
         Fe9DCtBtK/Hi9Go3MxqZW5/Ds11AJG3CEhCYtdfN47gppFes8qAv173/uD8G8yhsyjBE80W3gwRA
         6IjV+0m42G73ZifF7ldg92g17Df+Kid/oVnl8kVDBDR/aJCNB5VV/5VLHY5/4SFnxfZ4GEzsbElv
         DCb4M8BVSh3aT2J94kLVSd3BuASMI0qy67kN5cxUE18fQHiVsnfbpOh2mJHHS+2f5FbSSNR60whu
         AKJddfRfeiUj+wFTpCPu0NrgvmEmn8tT7418KKvqc/9TssniSNxBc6/7PdU2NVZEwDANYb87f46H
         N8FE9i2CSgdODnJEXEKq0s/zzCdsd8/cRS964oXgIXA/Ty8gkAZ617idelnZyVnfClR072LNt7Jw
         ==
From:   xkernel <xkernel.wang@foxmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        xkernel <xkernel.wang@foxmail.com>
Subject: [PATCH] ALSA: jack: Check the return value of kstrdup()
Date:   Sun, 12 Dec 2021 01:13:26 +0800
X-OQ-MSGID: <20211211171326.872-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kstrdup() can return NULL, it is better to check the return value of it.

Signed-off-by: xkernel <xkernel.wang@foxmail.com>
---
 sound/core/jack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/jack.c b/sound/core/jack.c
index 32350c6..5fd9954 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -509,6 +509,8 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 		return -ENOMEM;
 
 	jack->id = kstrdup(id, GFP_KERNEL);
+	if (jack->id == NULL)
+		return -ENOMEM;
 
 	/* don't creat input device for phantom jack */
 	if (!phantom_jack) {
-- 

