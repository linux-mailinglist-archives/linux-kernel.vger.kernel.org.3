Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C2148BFA6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351501AbiALIOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351487AbiALIOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:14:16 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8BEC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:14:15 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id kc16so2143817qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iR0lUnzAD3Q4l81+MH9jHlQ80I7ebpkxiYExJYSnlE0=;
        b=gTzQAHAm6MZssV7h1/4i/QnrghPm6YFhsce53+RPOhbQVFNspioZ6cj9CjIKqp/aZF
         Xvae4avqdqM5aDrVvRXQcJP9qJD34QQ3G7esOhEf2wy0hXqf8wxY3V97Cno0kv0Bfh00
         UHwFgAq27v533l53NjVblm+vQVBzxd25GvEY4vnftwpMAy8hlLp2qdflyPObB0nfg7Uo
         bFt50AWQ48S9ckMac/y/mJMrGHSnaD0Q0OSuYk+HalBPEUuDvdetQUaYZa5VUrkY7NNL
         iGKiIBqpIlwbEhB0hE/qkcnvAYbDY93+zpnQZHv6lVf4dIbdlQMFRh1Fr8IGIhAfC5uM
         W1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iR0lUnzAD3Q4l81+MH9jHlQ80I7ebpkxiYExJYSnlE0=;
        b=LDSGxE7Xe7Giv4CVPpIXoDy5L6Qk6SYF/ugXhFOcN20zyxNuL0GUoPIylrf1maX+UN
         Bn51e03QsL6lz48C2t/t8/jVNWVU9wGp8EagUt0ng4VCItZc6tA62oHy8mVFEbYD7z/9
         MaSX7NOIeS4jc+Y2dY03f5S+YO5DGiYQeebwvF1sIKUxRFyydZ8Efau9btGxrfObJKD7
         6S+oM5L/qh4E3Re1YN5O2AKOhqWjn+hN7lsdNocD/XMyDbuSwEutlUJOfCz9lKKw9byE
         0nEBI+zenWzNluTN1jFpNO7Trn0uaXjeyvx/J1vSNbSOtnuyzto77PBk6VhHEcH7WQ3h
         i9ag==
X-Gm-Message-State: AOAM530EoYkTIMtMYLNB7ChtfL32CqAq8dhGcsaigHQU/hj/Yv/uJhqH
        3NmsPW9km3UxkZ2akQ2X7EuYJ9q+L8c=
X-Google-Smtp-Source: ABdhPJzOoaH7o0MsxeXn2LqP9mesagpesw1w3+gHERyG7I/2Jjen9r+pRgfBBbflphqx4ttLGAVLVw==
X-Received: by 2002:a05:6214:c45:: with SMTP id r5mr7010672qvj.111.1641975255148;
        Wed, 12 Jan 2022 00:14:15 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f9sm2701282qko.75.2022.01.12.00.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 00:14:14 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     mark@fasheh.com
Cc:     jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] fs/ocfs2: remove redundant ret variable
Date:   Wed, 12 Jan 2022 08:14:08 +0000
Message-Id: <20220112081408.667411-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from ocfs2_add_clusters_in_btree() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 fs/ocfs2/file.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index fc5f780fa235..9a46dcef448c 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -540,15 +540,11 @@ int ocfs2_add_inode_data(struct ocfs2_super *osb,
 			 struct ocfs2_alloc_context *meta_ac,
 			 enum ocfs2_alloc_restarted *reason_ret)
 {
-	int ret;
 	struct ocfs2_extent_tree et;
 
-	ocfs2_init_dinode_extent_tree(&et, INODE_CACHE(inode), fe_bh);
-	ret = ocfs2_add_clusters_in_btree(handle, &et, logical_offset,
+	return ocfs2_add_clusters_in_btree(handle, &et, logical_offset,
 					  clusters_to_add, mark_unwritten,
 					  data_ac, meta_ac, reason_ret);
-
-	return ret;
 }
 
 static int ocfs2_extend_allocation(struct inode *inode, u32 logical_start,
-- 
2.25.1

