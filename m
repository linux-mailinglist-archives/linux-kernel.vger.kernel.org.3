Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5514840B8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiADLXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiADLXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:23:38 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1E6C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 03:23:37 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id g11-20020a17090a7d0b00b001b2c12c7273so1584383pjl.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 03:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/XPM4xmzU6z/jmJWUGiGhcxMGP7e6gFgpuiXCvJPjYE=;
        b=p/LvLWyL2DBc1SegCv5ozxuEqK3rvj4jmQUj9R72gQJcXVQEXIGTraaXZ6fgR2GSWx
         qBGfdFFDnvjZzhFiW0BD+BP/kkc1BLf9f6OzOJK918bmr1X4SyE089UFMVdr6eX3dSON
         GWPk6x6xNvwmYhYBxGApTjl76UbeeaVRo5VGqw6Z/AmSTWANLEiXApzj7HY+dAlDS4cH
         hbEWebpaC/CLpF2l9w8iD8iuru9AcXcn8HvOqsUlVxIltXUQN/i9iQbvQ6KD+1qpvqUr
         7mQWo5mLLDMt6cAz57w/79juoZjKrCNfjNOx2WHruSaerNAtKKsZPMMWhkTbjRihe9qP
         +1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/XPM4xmzU6z/jmJWUGiGhcxMGP7e6gFgpuiXCvJPjYE=;
        b=52SL1uiKYqTMJuNgkbdXWN949BamrQvP4+f9m5Srcjri//t67GP5DDeFZNZMcyYLcF
         kMIeStPAJX9taJj1X5J9Z6sB/tHQDRRal05e0eZIKUKPdT3V2Xj612jNb3bUCpG9b3PF
         pDmQfZFJj5Few4afH9GC+BVlyh4/vQI72xtvedHG3dOgtmvm0RWprEhAwu4pjIARz/Zu
         YzeIqlU3v4lkv7Iy5wI9Ul5wihdU1n5ICxd6vdBcCr7Um1npiY1Twco9hjU6HtpMpHrM
         zHcq6xXvEP4eE+bNfgyElnd0Nr/iXvWLeAMWJGZtgUduT2KjXB+3/EiqCpA35ca5TJRK
         l2mQ==
X-Gm-Message-State: AOAM533eL2mcGzRF8vEXvsSgThd39Ac+mXAwO+AQJheDtxVkZW3sC7+q
        g94GAw5OJwUVX2IvLNdS7OE=
X-Google-Smtp-Source: ABdhPJyRyPSmlDEHc/qWh50TRLHwgXRWbiCGC0JNXQusFRlL3WLDtgvzki2Cm8AOYDr8PDPY33bplA==
X-Received: by 2002:a17:90b:e87:: with SMTP id fv7mr59799149pjb.9.1641295417412;
        Tue, 04 Jan 2022 03:23:37 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u5sm43181453pfk.67.2022.01.04.03.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 03:23:37 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     mark@fasheh.com
Cc:     jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] fs/ocfs2: remove redundant ret variable
Date:   Tue,  4 Jan 2022 11:23:32 +0000
Message-Id: <20220104112332.601834-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from dlm_lock() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 fs/ocfs2/stack_user.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/ocfs2/stack_user.c b/fs/ocfs2/stack_user.c
index 85a47621e0c0..3027a6a05668 100644
--- a/fs/ocfs2/stack_user.c
+++ b/fs/ocfs2/stack_user.c
@@ -683,28 +683,23 @@ static int user_dlm_lock(struct ocfs2_cluster_connection *conn,
 			 void *name,
 			 unsigned int namelen)
 {
-	int ret;
-
 	if (!lksb->lksb_fsdlm.sb_lvbptr)
 		lksb->lksb_fsdlm.sb_lvbptr = (char *)lksb +
 					     sizeof(struct dlm_lksb);
 
-	ret = dlm_lock(conn->cc_lockspace, mode, &lksb->lksb_fsdlm,
+	return dlm_lock(conn->cc_lockspace, mode, &lksb->lksb_fsdlm,
 		       flags|DLM_LKF_NODLCKWT, name, namelen, 0,
 		       fsdlm_lock_ast_wrapper, lksb,
 		       fsdlm_blocking_ast_wrapper);
-	return ret;
 }
 
 static int user_dlm_unlock(struct ocfs2_cluster_connection *conn,
 			   struct ocfs2_dlm_lksb *lksb,
 			   u32 flags)
 {
-	int ret;
 
-	ret = dlm_unlock(conn->cc_lockspace, lksb->lksb_fsdlm.sb_lkid,
+	return dlm_unlock(conn->cc_lockspace, lksb->lksb_fsdlm.sb_lkid,
 			 flags, &lksb->lksb_fsdlm, lksb);
-	return ret;
 }
 
 static int user_dlm_lock_status(struct ocfs2_dlm_lksb *lksb)
-- 
2.25.1

