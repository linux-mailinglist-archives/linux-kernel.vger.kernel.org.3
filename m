Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB49471BDA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 18:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhLLRUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 12:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhLLRU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 12:20:29 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7316C061714;
        Sun, 12 Dec 2021 09:20:28 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a18so23391100wrn.6;
        Sun, 12 Dec 2021 09:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=70CgJ9RKaeuujO3f4MTS8HwBDoID9iAqD2HNuMNQGgc=;
        b=Vk4M6zc/V03u8SMNQp3AmcUN2udBSD6jv++9AYTr/xVgE1RSdJ44izCc8ZPDn63CHg
         2uRQiILu5UoP9BUwHY2KC8oKeVqYZC78q8A07HtI4TrPi6hapgEg7xbAPBQUlOtuRrNZ
         AC/2uL5rm9VY7Wwbjuxp+qcSaWivHcWKxQFxzULW+2zublISMut+4V50jVcw9jhLfluC
         ELnV0P5ilzsforioqQ5REMrozofxFsBoYVwbKxLbnHfESjMz50DTRypNwt0FcH+xixlS
         L59abvgW7pNTN8jB8MvOBV4ZsrCzgrGqSBoBwG1tcylmDcrWcme0gRubd2vIg8bVT+Hi
         uMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=70CgJ9RKaeuujO3f4MTS8HwBDoID9iAqD2HNuMNQGgc=;
        b=Zwtp/wUcV/ISDUTHJiGTTj0AC7O6M+Uxf3fgE0mx5BAgN6mcNgwekHVyLEn19owOGI
         iHdF3BAV6a5Pb9W51mF3Xxty8ZmzHXZfDoP6MX1avoGQVGGZNqOD+os618YrBJTrL5tm
         72NjlBDslkIhgdywj+C52bTxNPf1XFzElsffMjRBrn5/iai6YEHAXtvxKII7nohQxz24
         5d8v47zPUOdnLn+TloRl1us+6HEr9jbwWzJ8N25oyGXvRRr8Wp2OCClJRXyRAE853toz
         Dze0EUcESwpXvzlfNcK/9mcukxC1RcyXa48c2wczcdxL7VVr0KcTUGEvyj0vU6vYMS4i
         /6qw==
X-Gm-Message-State: AOAM531Uqh8QZK+N9r3HqmvLUaxLGH+ayGeKQQn3iPxSb+yjW3S3A5is
        dpLRCNiDK6hBS7qwKCAaDYk=
X-Google-Smtp-Source: ABdhPJzJYIQf5+kNr6J5UeKg6XdZX5uI3o2BtWMQr8PWKwxgC3oj7S4QiAP68BE5vI2UQsbV1oBk7A==
X-Received: by 2002:a5d:648d:: with SMTP id o13mr11600499wri.637.1639329627200;
        Sun, 12 Dec 2021 09:20:27 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id t17sm4757529wmq.15.2021.12.12.09.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 09:20:26 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: drivers: opl3: Fix incorrect use of vp->state
Date:   Sun, 12 Dec 2021 17:20:25 +0000
Message-Id: <20211212172025.470367-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static analysis with scan-build has found an assignment to vp2 that is
never used. It seems that the check on vp->state > 0 should be actually
on vp2->state instead. Fix this.

This dates back to 2002, I found the offending commit from the git
history git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git,
commit 91e39521bbf6 ("[PATCH] ALSA patch for 2.5.4")

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/drivers/opl3/opl3_midi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/drivers/opl3/opl3_midi.c b/sound/drivers/opl3/opl3_midi.c
index e1b69c65c3c8..e2b7be67f0e3 100644
--- a/sound/drivers/opl3/opl3_midi.c
+++ b/sound/drivers/opl3/opl3_midi.c
@@ -397,7 +397,7 @@ void snd_opl3_note_on(void *p, int note, int vel, struct snd_midi_channel *chan)
 	}
 	if (instr_4op) {
 		vp2 = &opl3->voices[voice + 3];
-		if (vp->state > 0) {
+		if (vp2->state > 0) {
 			opl3_reg = reg_side | (OPL3_REG_KEYON_BLOCK +
 					       voice_offset + 3);
 			reg_val = vp->keyon_reg & ~OPL3_KEYON_BIT;
-- 
2.33.1

