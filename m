Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C89253B43F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 09:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiFBHTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 03:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiFBHTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:19:45 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE0E132A24
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 00:19:44 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t2so3821590pld.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 00:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i016zQuKMb81+Y+xJdKA11NT4Jd4+/bBSHrF2+dgzts=;
        b=U7qhAoU37DunMr9kz0ZdppXkRzBWVe/lykrRpYM7PtCuPHRXtxRW8b2PIjBqCkit9M
         VUdSjAiykM/DrTOiePK9drK2v2cmm0QHghgBLbXG6e4DKi3K1TL0q0Jd/5RloC9gstn0
         LttIjwAla5xW1AtrFPBu2wiGlCTAmBcqsFmiW+Dx2xBF7tLiqJiPh4DRNVeZ+KrImGzf
         0UcVOj6CsfvL0RwP3ICgGFdZTyLWvd++kH8pC38jhomaEE3fJffiZE2Tp7IvmuUxMx6L
         qJeMEyEHFe4jWVzICUcx96J+x8WMM0UtEZxL/CRTWiwbyPu+Z0vOtCDHNkxEJ09s1XuU
         C6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i016zQuKMb81+Y+xJdKA11NT4Jd4+/bBSHrF2+dgzts=;
        b=QjdPv492ymzSBruMi9FSBSy8T7FvEk9vm+40fDT7eOPeUAx3KMN0x3lxj6XrT/M75o
         blRPU6i/WrhmJc9Oz2nSLpxkKkOJVnnLqwgb7r/pHALq6IyUXS8z275ccP/v33gqo7yd
         XTvuw1qNDodVWszcWtLTf5BcynTo7dlNz/Xpg/6yo6oxWVTQDO7MKlyMXj/Msr+rUxoo
         9wOo24TCxYVLdf8HgRezzvzZAlDbx9gCv7VyqeOB3T6yLJk1SY0Z7msiHiPrjjWyvIPx
         l3LJKXYOkTVBAAqklSRq7lA/PqC4tJBoF3I2ICIhHAS7s7Msrud3JuOcrSXLa217DI61
         bQjg==
X-Gm-Message-State: AOAM530vFTCL9yb88/7er5f11cDo1Sp4ACzFzR7shm3FThd+fvWARD1L
        /c6zMj4Yq99rEJgfKg+qGqQ=
X-Google-Smtp-Source: ABdhPJwvbtpttKvPPVIECKgAyPlw86lt/qMJJOYUmGPl/yvP7coxrd3KUek52ouDEvS5mDD6i7CqYA==
X-Received: by 2002:a17:90a:2807:b0:1e6:7eef:8e9d with SMTP id e7-20020a17090a280700b001e67eef8e9dmr3455288pjd.109.1654154383633;
        Thu, 02 Jun 2022 00:19:43 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s8-20020a056a001c4800b005183cf12184sm2647547pfw.133.2022.06.02.00.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 00:19:43 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     rpeterso@redhat.com
Cc:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] gfs2: Remove redundant NULL check before kfree
Date:   Thu,  2 Jun 2022 07:19:39 +0000
Message-Id: <20220602071939.278344-1-chi.minghao@zte.com.cn>
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

kfree on NULL pointer is a no-op.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 fs/gfs2/file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 2cceb193dcd8..d8f1239344c1 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1066,8 +1066,7 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
 		gfs2_glock_dq(gh);
 out_uninit:
 	gfs2_holder_uninit(gh);
-	if (statfs_gh)
-		kfree(statfs_gh);
+	kfree(statfs_gh);
 	from->count = orig_count - written;
 	return written ? written : ret;
 }
-- 
2.25.1


