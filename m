Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406BB5A27D3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 14:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344187AbiHZM1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 08:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344219AbiHZM1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:27:46 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29D3D9E8C
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 05:27:41 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u22so1446239plq.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 05:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=zlRI7MHuxcKJrlwJU4skU3ScXG9/sHKteMJGmZrxqd0=;
        b=N+A12VueOxJN+5/X9mzcDMYm5bkExVHiU1H/V3RV1jYZ2Ax6ewhnxaKtN4tr4Tk4Sk
         +QHt7ASkTaLWLcPdJf/B1BDjcb3DyB+pWdBMMncu9VwbiulJtVZXOuOoBLGg6nSzUYdM
         BNmK/6EE8ViaclHLMXSADsaHZ9G7PgAd/SQGBAOyL2QLD5jMsX5mFZwDXakI1HfbKjY1
         9Za4rJ5mQrsVrSyV8rh86US2ATlPcBLKG7vQ3FQW8WLDm2NWQHmJ94fYENxAJsE5eJX8
         Y9vmF9vcoSloZ22C462vHxO3IeiCX5tolWud0y7Ki0iYsgWG1GSvnI/78dxWwNz/zWRG
         F08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=zlRI7MHuxcKJrlwJU4skU3ScXG9/sHKteMJGmZrxqd0=;
        b=vI7z4arHdWOAZhxaIozJ7sMjgXBHaTwPvxfmZ8xDRVS1dzhhvZ9XWeTpAyC1a2Wk3V
         sJI/KFNY0NssnbiFnHn2rwDC1E0fYY20MOxMgzMmILbjbgopHglzgMtuu5YFiLt+95hK
         XGf+jSxqVIOrET3mZg3vLjovuzjNnld35yMsCaRoUph6D5/iWcpcYg/hZjjc3wN2BH2F
         b1v31KdjvNr9nMhe1P/X6ft4UGWDlEuQnXKF/wDTPuO5slteuWYSZ9H3Nk/jPVmW5DOX
         XxuAWmC3MUM/JB2urwrDvdFQPglrDviqaFoAIu2h87vz0iuKqvpfZAltX+D40rWhEm0k
         +Edg==
X-Gm-Message-State: ACgBeo0OR4cQ05TGwzCFfWbzyoCxq7RvsY6/z1sUcX6EF7e3EWTsI6Jp
        J7BwLHDvlp0uQOCXnVYxpXg=
X-Google-Smtp-Source: AA6agR5HVe41UWjwyIpTMWyscRlQ/lPdKyP72R/T0Ha0KxwN3XsaGCpiLG+NlsvNoMpA8cZ9eu7X+A==
X-Received: by 2002:a17:90b:1bc6:b0:1f5:313a:de4b with SMTP id oa6-20020a17090b1bc600b001f5313ade4bmr4223148pjb.4.1661516861461;
        Fri, 26 Aug 2022 05:27:41 -0700 (PDT)
Received: from localhost ([36.112.195.70])
        by smtp.gmail.com with ESMTPSA id j16-20020a170902da9000b0016d2e8c2228sm1456405plx.238.2022.08.26.05.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 05:27:41 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com,
        Anton Altaparmakov <anton@tuxera.com>
Cc:     akpm@linux-foundation.org, chenxiaosong2@huawei.com,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com
Subject: [PATCH] ntfs: change check order in ntfs_attr_find
Date:   Fri, 26 Aug 2022 20:27:34 +0800
Message-Id: <20220826122735.2690-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0000000000006886bd05e714ec18@google.com>
References: <0000000000006886bd05e714ec18@google.com>
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

syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Looks like it is improper check order that causes this bug.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 fs/ntfs/attrib.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 52615e6090e1..6480cd2d371d 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -594,10 +594,11 @@ static int ntfs_attr_find(const ATTR_TYPE type, const ntfschar *name,
 	for (;;	a = (ATTR_RECORD*)((u8*)a + le32_to_cpu(a->length))) {
 		u8 *mrec_end = (u8 *)ctx->mrec +
 		               le32_to_cpu(ctx->mrec->bytes_allocated);
+		if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end)
+			break;
 		u8 *name_end = (u8 *)a + le16_to_cpu(a->name_offset) +
 			       a->name_length * sizeof(ntfschar);
-		if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end ||
-		    name_end > mrec_end)
+		if (name_end > mrec_end)
 			break;
 		ctx->attr = a;
 		if (unlikely(le32_to_cpu(a->type) > le32_to_cpu(type) ||
-- 
2.25.1

