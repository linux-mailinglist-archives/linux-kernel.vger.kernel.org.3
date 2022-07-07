Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA70569E53
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbiGGJLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiGGJLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:11:35 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506102656F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 02:11:35 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id o12so4589419pfp.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 02:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rLwmhSdpdM0C2SVR68sGMkumfQBnYqE+SwvxgblZSQI=;
        b=Ht68Liz/PdKg9Ry0GeqLbp2oQCcabi48+LILOgsPbOxMLrLNZ2oi07LBiAGB82ZTu8
         pgWiMu6T+6H7vmy3j4gbQ9bxxbq26fco8Z2Vd/VVo3BfSUf+U7BkTBAcY63cQPvQqSIj
         7nEh8qwkng2wdUG/xIbq3AWa0Co1kd24lKfq+AOUTMR8/mW9LyF6cyMXxdo57Hjys6Gq
         JqyrBdPjyMUW1Vc0s7+sIiHGMM8z6e5zHpdTTRpsQFRPPftmdQTKKn1uNyTkZKJE8rfK
         cHrYk7TEWI8Yun0/8p5X8oQob/Tjdxk8oJOj3fcbFZQzEtlGX4yZYh31NbK7DcMKxM7k
         da4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rLwmhSdpdM0C2SVR68sGMkumfQBnYqE+SwvxgblZSQI=;
        b=QEs9dVB/wfX7JBbpZ3gEQ4n2d5JO2/n+O67Gk/nyIJlhzN9GV8mkTahzUqY0NXecMN
         PdQwVeiCj9BQCoWEVwYrSpfcR3UM78MPEnyLNpfh9u37uFcx1bx3wX0MCj0aptpWNMeM
         uCcARzsINZBw0ZEicPS//vj/HHp9wWa44yFbmV4R9Q6Hal9wTnNvxcryjpNSA/Rlzj0g
         vI9dFndYaY47eHCplOdw/GHuNzIzxNWG1m/2vjwncVF1KBsbHFpOWbiqmlvQu46bncNv
         PhaORAeQwSUV1okXB03yvF0ChFLztgBwX9hpyrOXdnnpGtWGLMGNBMuK186rurOALm4/
         3+Nw==
X-Gm-Message-State: AJIora9Jv0wJA2knPoB6Bn1IvOFC9Q6RUZp1SJYqjfn6Zmli7Fedh/vh
        2/tKU0MvgG1D/Is2w9GQTqBMkjOLj8aOEg==
X-Google-Smtp-Source: AGRyM1vbSbhepsSwLUQImCVGxM/MHJn8HE8BrF2aXTsRMMIPVGnwRPzoKRTvrhNWq7cjprjGU4/Ufw==
X-Received: by 2002:a17:902:e5c3:b0:16a:67e7:d999 with SMTP id u3-20020a170902e5c300b0016a67e7d999mr49837459plf.32.1657185094633;
        Thu, 07 Jul 2022 02:11:34 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id m7-20020a17090a34c700b001ef8dd1315esm7788617pjf.27.2022.07.07.02.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 02:11:34 -0700 (PDT)
From:   Chao Liu <chaoliu719@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Chao Liu <liuchao@coolpad.com>
Subject: [PATCH v2] f2fs: allow compression of files without blocks
Date:   Thu,  7 Jul 2022 17:09:24 +0800
Message-Id: <20220707090924.4183376-1-chaoliu719@gmail.com>
X-Mailer: git-send-email 2.36.1
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

From: Chao Liu <liuchao@coolpad.com>

Files created by truncate(1) have a size but no blocks, so
they can be allowed to enable compression.

Signed-off-by: Chao Liu <liuchao@coolpad.com>
---
v2:
 - update commit message: truncate -> truncate(1)

 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0f29af7876a6..f7a82858486a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1879,7 +1879,7 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 		if (iflags & F2FS_COMPR_FL) {
 			if (!f2fs_may_compress(inode))
 				return -EINVAL;
-			if (S_ISREG(inode->i_mode) && inode->i_size)
+			if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
 				return -EINVAL;

 			set_compress_context(inode);
--
2.36.1
