Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B379848CEB4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 00:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbiALXEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 18:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbiALXEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 18:04:14 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57580C06173F;
        Wed, 12 Jan 2022 15:04:14 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id k30so6893326wrd.9;
        Wed, 12 Jan 2022 15:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JPJblGojv68qXHEOlkKW58+4JrhFqdhCrhqhESY/HD8=;
        b=SNg2sho5IfNYgbCB1xjM7OU0QW/XXzdGkG91d1s3K8i/BZdXb/7ynPl0xsu8gc5Fze
         OsOs3f0ljlyOF8CKxhZEJGTP8tw6cFiYkLDJkHd9o8QtMM6wKIvwCLMeKLk5RbW7hqF1
         vwtc8H0ZiX50S+ydlSu3wqtd+8iYRmItAhrXoM/huli9jx6Pe8HD80VQ8FZloXOJ1aas
         KVga/aKcn0i+V80DoR/aQIeLiIoqS9wEtyUgkl2XLdvR4KLrF6+F/EvNdPF1Yudu2iWu
         sNVk9efUgltg7Gtc7FwQkGOO1+RmyF/NWeeSgdx78q7QPGZo3vAvxCw6jayQk/cltldR
         iLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JPJblGojv68qXHEOlkKW58+4JrhFqdhCrhqhESY/HD8=;
        b=XYxFbydNVRXJCi+kSMT6sFXwP+EqdxA3+z5Vfby5LwJsYdZuiRLcnbiEnEFLI5ZPtN
         UB2NF8vHUrrKtISfQk/U0FIDvtop35sQR6KX76bCdh8KKXjsA4soSGXUjyC40ODNmT87
         +BkrWwQ6svvwr+P7J/eZ7Q2SEEqOFHbiJTAfz4JRB895KGTQ4DrQUc6YuwamEmDBuyBR
         nGli1ruJ6sz3rfSALsELmL0uSsTNLwwQPTSlS3C/840eI4U+8aoKcAskHFz88/Om60cE
         KKaIMzkg/3t35AzRQ2VHx/rpj8o/ldWsaq3aFrDTI03bc8kOpRaa2+wqbchmjFBo3i8I
         p02A==
X-Gm-Message-State: AOAM533Jpq8++ZtTBrn05w1VB6dOHopW+cBRMyxLzRNeW3VpqTKVk5jU
        k4icrxPvCw1GOxYMj2oIYOrWNfizb+7EK9cn
X-Google-Smtp-Source: ABdhPJwLUWRwU/yurVO2wcN8frae9XRxsB3mD9pZLrIi6BlQpko2UABoU6oUiG1e2dzTUOGkQ78erA==
X-Received: by 2002:a05:6000:18cd:: with SMTP id w13mr1604727wrq.199.1642028652961;
        Wed, 12 Jan 2022 15:04:12 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id c7sm1294974wri.21.2022.01.12.15.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 15:04:12 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ocfs2: remove redundant assignment to variable free_space
Date:   Wed, 12 Jan 2022 23:04:11 +0000
Message-Id: <20220112230411.1090761-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable free_space is being initialized with a value that is not read,
it is being re-assigned later in the two paths of an if statement. The
early initialization is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/ocfs2/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index bd8d534f11cb..f2cc1ff29e6d 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -3343,7 +3343,7 @@ static int ocfs2_find_dir_space_id(struct inode *dir, struct buffer_head *di_bh,
 	struct ocfs2_dir_entry *de, *last_de = NULL;
 	char *de_buf, *limit;
 	unsigned long offset = 0;
-	unsigned int rec_len, new_rec_len, free_space = dir->i_sb->s_blocksize;
+	unsigned int rec_len, new_rec_len, free_space;
 
 	/*
 	 * This calculates how many free bytes we'd have in block zero, should
-- 
2.33.1

