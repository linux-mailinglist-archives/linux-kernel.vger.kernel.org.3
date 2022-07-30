Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A31585A47
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 13:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiG3LqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 07:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiG3LqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 07:46:10 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C89717E0F
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 04:46:09 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id bh13so5919480pgb.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 04:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=styzkenOeqf5qc9bxBJ7dgDvmeZrbcokR+YC5je8YLc=;
        b=oAPknW93Ck0yOHpxSeCkDGLraImV4G12racNx/YfFtTcNctn07zrj/W9FlLjYxP8xF
         nf2H6UuZNbGJ17+ikYY6n7X5Slb5sGrr+RnvPEpKBCFhdbBevEhrf4t7dVEgu8lpqvFT
         wjwnGReGu6TUFkhtHd17tBfCCxkqCeZbzquESWjq+/10WlFX0qdk+JouTmexKkjdfDBX
         0X2T07R6MM6ku1zl7swuTwWTAAwLMkGdAZogm1czq3RdDpExBO8C5JbRHXPdG+ZIg8Jd
         EQ36hhfxqhqtc7EKPioxThmEcIAWC5tZjw+EaH5T3ozOyA56o01yAbYTAI86CVHuR4NE
         DZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=styzkenOeqf5qc9bxBJ7dgDvmeZrbcokR+YC5je8YLc=;
        b=ldYfKILm1RBiXa52sEahILefXZMjGfgC5G/1Uxs5iSSY3zespZuY8LZXkGuSb9biMM
         8e/ES2tqZdXp+sOffKOEDPfRWBTlpAKaQmMXf3PUyMYF7OhRDsRU6wkXo5qhx62DDYrh
         +dhrmq+7ffUfiRzTN5RAfGGHaY/E/gTs8P0GSfetibf4DqrCJ87h+3rvxdApbyjrKNnk
         35cOtxizKtc+3xK1IkAmgB8t4otUiuvKqyX4BiKtc1xtdqT0ww0U3LAPoXFCwFYOJGYT
         /eBLIstA/sBfmI6SevHWlpcsoZzI7+MrFH4athI5UnjTlP+DjtV6tIvN9C0pCpnPM6bG
         Oy1A==
X-Gm-Message-State: AJIora/Gij22gSsWgfl76UQ4h7a/450fbI8qWJFzdqOa2xWHleL1+kj2
        RrHDH0tGZR2+gO/Ej801BFxSJuzApvE=
X-Google-Smtp-Source: AGRyM1t180hITPVu7N3GJCw3O1RHTbLRqD7FM1XxJ+RJ1OvxD6zdUB23g1/5TZzmt0CZ7uGpH0IY1g==
X-Received: by 2002:aa7:8e86:0:b0:528:c755:1d96 with SMTP id a6-20020aa78e86000000b00528c7551d96mr7832102pfr.30.1659181568842;
        Sat, 30 Jul 2022 04:46:08 -0700 (PDT)
Received: from fedora.. ([103.230.104.28])
        by smtp.gmail.com with ESMTPSA id x5-20020aa79a45000000b0052b4f4c6a8fsm4612336pfj.209.2022.07.30.04.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 04:46:08 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     syzbot+14b0e8f3fd1612e35350@syzkaller.appspotmail.com
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Khalid Masum <khalid.masum.92@gmail.com>
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Write in imageblit (2)
Date:   Sat, 30 Jul 2022 17:45:47 +0600
Message-Id: <20220730114547.5790-1-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <000000000000bbdd0405d120c155@google.com>
References: <000000000000bbdd0405d120c155@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz-test: https://github.com/torvalds/linux.git e0dccc3b76fb 

---
 drivers/video/fbdev/core/fbcon.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 1a9aa12cf886..d026f3845b60 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2591,14 +2591,13 @@ static unsigned long fbcon_getxy(struct vc_data *vc, unsigned long pos,
 {
 	unsigned long ret;
 	int x, y;
+	unsigned long offset = (pos - vc->vc_origin) / 2;
+	x = offset % vc->vc_cols;
+	y = offset / vc->vc_cols;
+	ret = pos + (vc->vc_cols - x) * 2;
 
-	if (pos >= vc->vc_origin && pos < vc->vc_scr_end) {
-		unsigned long offset = (pos - vc->vc_origin) / 2;
-
-		x = offset % vc->vc_cols;
-		y = offset / vc->vc_cols;
-		ret = pos + (vc->vc_cols - x) * 2;
-	} else {
+	if (!pos >= vc->vc_origin || !pos < vc->vc_scr_end ||
+	    !ret >= vc->vc_origin || !ret < vc->vc_scr_end) {
 		/* Should not happen */
 		x = y = 0;
 		ret = vc->vc_origin;
-- 
2.36.1

