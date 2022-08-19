Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B3D599757
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346931AbiHSIUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347196AbiHSITu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:19:50 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2991AE9929
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:19:31 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y127so748709pfy.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=RuMVV0Swr5SW+ZHaDaHXBhfUduTzHJMehYOO/a+7WyY=;
        b=dOYkk1gL/QOKpZ+hnFV5KBP8XciuGKV2inLdnun66Tuo8nYz3J+/4x+FKe8amedjM8
         5js49dEWYdAsc0/70owNYaPXoRoiRGxrXRHYH1MrRUnNJq9XeYU7505aXG8wFlGGeJVx
         WsO95sDNl7dbdk2l11szX0xxhkbKjoR+zP7GDfkPb9BVol28CawJO2qRKgIz/CC1N29F
         mMFNWNK4ER1yBbH/Rgsuh4I3prYez8gs7p7CT4GAI7C616CKKbKULB3CG/YzvMzphIVj
         SFliNg006tgb0BndqPFjYtX1/XnsuUIeaK9uRFIm7ShOYKmt98xa2KeN3cLJeNudX/Ha
         /irA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=RuMVV0Swr5SW+ZHaDaHXBhfUduTzHJMehYOO/a+7WyY=;
        b=0HvwPW+kJlEYvRfLkSEjeJanluF3ebaytV1W46SjIpDU3kqra79WtkpmfFw+gU/j/s
         8NGo/8huiJccxs+MbrAKwdNyV+GOLKIvJ/CNoXrIwXX9CNwOXdptux7fFNMPrVhYQGVA
         6sikTuRKf7PRaKRFDfH9sy6cSjUSDG7wKB0u58bMWCznHwDVcHhF0dLcagBA2X9Z2KWX
         dKQMiEsqvM3TG/pat4ZoXsUUlXzfYFW8Pqgf64FupNDMygsURD+mYPkFcYWEDaXrykJb
         NubnMOTwdYfBRyZO7Q0x1ETHL2Erxni1DJWHKguS4k+tQIWcUdlJdmcWVt1c755l8ewo
         eJyw==
X-Gm-Message-State: ACgBeo30THgMNONXAe3UTwgtvf7wy9vJbwcHbhseT6yfb1ZYLPpjyuDr
        hxE4/23RUH/aAsiU/0UpsSCPBLXOAPw=
X-Google-Smtp-Source: AA6agR6wvLaAGqDxhaSKrE6oFbfgblhdusz99N51zlsluGom1tBwcZtMicKnGrxi06obrr6WoaDN3w==
X-Received: by 2002:a05:6a00:24d6:b0:52f:20d6:e9c9 with SMTP id d22-20020a056a0024d600b0052f20d6e9c9mr6781508pfv.66.1660897170888;
        Fri, 19 Aug 2022 01:19:30 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p4-20020a17090a2c4400b001eafa265869sm4746570pjm.56.2022.08.19.01.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:19:30 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     chi.minghao@zte.com.cn
Cc:     linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] fs/isofs: delete unnecessary checks before brelse()
Date:   Fri, 19 Aug 2022 08:19:27 +0000
Message-Id: <20220819081927.96413-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

The brelse() function tests whether its argument is NULL
and then returns immediately.
Thus remove the tests which are not needed around the shown calls.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 fs/isofs/dir.c    | 3 +--
 fs/isofs/export.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index eb2f8273e6f1..e90fc2d87bb4 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -236,8 +236,7 @@ static int do_isofs_readdir(struct inode *inode, struct file *file,
 		}
 		ctx->pos += de_len;
 	}
-	if (bh)
-		brelse(bh);
+	brelse(bh);
 	return 0;
 }
 
diff --git a/fs/isofs/export.c b/fs/isofs/export.c
index 35768a63fb1d..11bf964f4886 100644
--- a/fs/isofs/export.c
+++ b/fs/isofs/export.c
@@ -102,8 +102,7 @@ static struct dentry *isofs_export_get_parent(struct dentry *child)
 	rv = d_obtain_alias(isofs_iget(child_inode->i_sb, parent_block,
 				     parent_offset));
  out:
-	if (bh)
-		brelse(bh);
+	brelse(bh);
 	return rv;
 }
 
-- 
2.25.1
