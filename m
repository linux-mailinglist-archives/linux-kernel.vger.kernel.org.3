Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87FB59F4DE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbiHXIRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbiHXIRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:17:18 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6808037E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:17:17 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x19so15025794plc.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ozY6u65Wi+tb61B+PChTsXWw55lG3sk+g53XzCkY8H8=;
        b=adyUncsaZuyugIqkgE+MiXTuAYgrLURFpzhiOdHp5Linka3Yr0Y467uxQ0WUvLXnp4
         3ruxQKf3TzItSDkp6T+24017+iGgltSAqABJTCfD1x/KMC7NVrv3eb56rjVRr4cDHmhK
         +iGt4a40f5kWEz3+o1WDZ6SRlaZhyt4ezP0Sht9IvbK2bf9gjrOyOulPROdjN2pQ8kMc
         PrCSJk+se4jBDgWrX91IqlXOIp7V2JpK7IX/wmEycjshQSPUT1+AA8U40mnz1e/I7xw5
         ea+xIisJifimHPSi7vEWpPGCgo2Ljew7gH9UDTaBthdbEVOtKkKrud6CUBPdQDXHgyQB
         RGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ozY6u65Wi+tb61B+PChTsXWw55lG3sk+g53XzCkY8H8=;
        b=wAUWdGPDLw0lsP3YUl0YM84TT7Zm3ELmwKeHMAqhnmbTNsTm22STn4HAQg4cJxbsL5
         C6iuxGz9XG2Mwh221ZqWB0yzpFOzku1COl16znDhuA2oTGNju/0vVp7+z39o7WgS2YWl
         m/loh0O9usRhCxcAIqjvaH6Yo/DWM+0L7twrpG2l9cFAmzmgNp0TOCQkUqW2hn0vaA12
         nqYemnjAgt1puo7Cjkc0Io39SfujbM/yzqLX3vl1uAk4NsZZSBBRrye5MZ+nltwOwbLS
         6VjeMBVDFmvHaYX2lDss0ORAD+A5J0Gkfu7TPJVtrKQecefQTFoPpnQHeLTOnSTE0pm9
         29AA==
X-Gm-Message-State: ACgBeo0XY4HJ7gQg1MuWV/om9yRYbRTbu2G+FznLNFTQI9x2IBlThE08
        s9YKoc61tPTQyQL+booL2PK7VIcJD47p56Y=
X-Google-Smtp-Source: AA6agR6rjNVqUfcFvWmii8TDq32o5AzK/lk3X020Lbxg7Jc9EA12wtGdXpulliMTcEUWMN6OiPG+zA==
X-Received: by 2002:a17:903:1ce:b0:16f:145c:a842 with SMTP id e14-20020a17090301ce00b0016f145ca842mr27483329plh.83.1661329037147;
        Wed, 24 Aug 2022 01:17:17 -0700 (PDT)
Received: from localhost.localdomain ([166.111.133.51])
        by smtp.gmail.com with ESMTPSA id j2-20020a63fc02000000b0041a615381d5sm10508288pgi.4.2022.08.24.01.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 01:17:16 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Zheyu Ma <zheyuma97@gmail.com>, Takashi Iwai <tiwai@suse.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: control: Fix an out-of-bounds bug in get_ctl_id_hash()
Date:   Wed, 24 Aug 2022 16:16:54 +0800
Message-Id: <20220824081654.3767739-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the user can control the arguments provided to the kernel by the
ioctl() system call, an out-of-bounds bug occurs when the 'id->name'
provided by the user does not end with '\0'.

The following log can reveal it:

[    10.002313] BUG: KASAN: stack-out-of-bounds in snd_ctl_find_id+0x36c/0x3a0
[    10.002895] Read of size 1 at addr ffff888109f5fe28 by task snd/439
[    10.004934] Call Trace:
[    10.007140]  snd_ctl_find_id+0x36c/0x3a0
[    10.007489]  snd_ctl_ioctl+0x6cf/0x10e0

Fix this by checking the bound of 'id->name' in the loop.

Fixes: c27e1efb61c5 ("ALSA: control: Use xarray for faster lookups")
Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 sound/core/control.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index f3e893715369..e8fc4c511e5f 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -385,14 +385,14 @@ static bool elem_id_matches(const struct snd_kcontrol *kctl,
 #define MULTIPLIER	37
 static unsigned long get_ctl_id_hash(const struct snd_ctl_elem_id *id)
 {
+	int i;
 	unsigned long h;
-	const unsigned char *p;
 
 	h = id->iface;
 	h = MULTIPLIER * h + id->device;
 	h = MULTIPLIER * h + id->subdevice;
-	for (p = id->name; *p; p++)
-		h = MULTIPLIER * h + *p;
+	for (i = 0; id->name[i] && i < SNDRV_CTL_ELEM_ID_NAME_MAXLEN; i++)
+		h = MULTIPLIER * h + id->name[i];
 	h = MULTIPLIER * h + id->index;
 	h &= LONG_MAX;
 	return h;
-- 
2.25.1

