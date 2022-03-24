Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31434E5F37
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347307AbiCXHTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiCXHTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:19:39 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59876BC18
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:18:07 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x34so4525550ede.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NcKri3m11P7WbF3k4XxvhreVLKTikUOJvHg86WdsMjI=;
        b=eN99w+bfYfz8+qBinqZBIiNQvzPByv7RJCCjDn3mLOqN+5LK6QAtuIg23HPI8sWfFs
         T9K/9HSPbj66QzvSZtYUMM6tMls22Xw+lQ/81dKTlPQNX25bwLL4wF+GXNkaDjEeNJX0
         oalmYAbFj7zljqU9JbxrrrEhxPjSr/cRQT2Tb4IGx1cQrFqviQXrYa6WiMEcc5mNG4y8
         4qkVgEjyDufZOVR72fFgqVQ5c1xNj2JnDUOmNDXdfPHRT08zOngQT8zCDidBLiYLuU/3
         PICQitAx22A/O3OT3M491BPbNWEIEKAyzUTF3gPjxtAZJJ+agV6mo4HffqVOsnaYSTyu
         Bchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NcKri3m11P7WbF3k4XxvhreVLKTikUOJvHg86WdsMjI=;
        b=5USMnOjrHZ6+Y621UrEyi6XQt+xCgLiD3xHZhy2AqgJGugXWNA3KCkObp5oDQPoOJV
         TvFliRtKeCd+Fh9uHwLrkDoS+EaFnp5DJzQyh1WnmOoqRNFxYJWmEVoxEsQQa2u3rUSN
         F6FgFq+H5k+e3sai1PzcKvmQKpUEvcRPI5mZJ/V74zwoYsvVWplSd7H48n+tvLCnRbsS
         4Jf2xtDWVVjqDaOxApyxUZOTh76Dw9tsYOXqKFRS7kB8Z/4qqqFkAvZ92xoof6riTGJp
         n8OIx1+2SpFkKgGmgQ1pRZtdtmwGU5p4Jyu2+ou1MNUpLyIkkv+yFdOzoJRDu6bB/yWC
         HMMw==
X-Gm-Message-State: AOAM531sONSlfBV7MaOyRSoQpG2QYNKqdAlo263I7mYgomGJiM8WLjaR
        U5bNXr9BD5lOAB7pzzvLhGQ=
X-Google-Smtp-Source: ABdhPJwUAHAPfqmZQWcuO8+1Sm1hWXxk1ydFuPd49EbjGVbLWYY0lQVvBfppjMjTv2PQOi3eFFtmfg==
X-Received: by 2002:a05:6402:4407:b0:419:3859:697e with SMTP id y7-20020a056402440700b004193859697emr5067201eda.400.1648106285771;
        Thu, 24 Mar 2022 00:18:05 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm761727ejb.82.2022.03.24.00.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 00:18:05 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Mark Fasheh <mark@fasheh.com>
Cc:     Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] ocfs2: replace usage of found with dedicated list iterator variable
Date:   Thu, 24 Mar 2022 08:16:50 +0100
Message-Id: <20220324071650.61168-1-jakobkoschel@gmail.com>
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

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 fs/ocfs2/dlm/dlmunlock.c | 21 ++++++++++-----------
 fs/ocfs2/quota_local.c   | 10 +++++-----
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/ocfs2/dlm/dlmunlock.c b/fs/ocfs2/dlm/dlmunlock.c
index 61103b2d69fb..7318e4794ef9 100644
--- a/fs/ocfs2/dlm/dlmunlock.c
+++ b/fs/ocfs2/dlm/dlmunlock.c
@@ -392,9 +392,9 @@ int dlm_unlock_lock_handler(struct o2net_msg *msg, u32 len, void *data,
 	struct dlm_ctxt *dlm = data;
 	struct dlm_unlock_lock *unlock = (struct dlm_unlock_lock *)msg->buf;
 	struct dlm_lock_resource *res = NULL;
-	struct dlm_lock *lock = NULL;
+	struct dlm_lock *lock = NULL, *iter;
 	enum dlm_status status = DLM_NORMAL;
-	int found = 0, i;
+	int i;
 	struct dlm_lockstatus *lksb = NULL;
 	int ignore;
 	u32 flags;
@@ -437,7 +437,6 @@ int dlm_unlock_lock_handler(struct o2net_msg *msg, u32 len, void *data,
 	}
 
 	queue=&res->granted;
-	found = 0;
 	spin_lock(&res->spinlock);
 	if (res->state & DLM_LOCK_RES_RECOVERING) {
 		spin_unlock(&res->spinlock);
@@ -461,21 +460,21 @@ int dlm_unlock_lock_handler(struct o2net_msg *msg, u32 len, void *data,
 	}
 
 	for (i=0; i<3; i++) {
-		list_for_each_entry(lock, queue, list) {
-			if (lock->ml.cookie == unlock->cookie &&
-		    	    lock->ml.node == unlock->node_idx) {
-				dlm_lock_get(lock);
-				found = 1;
+		list_for_each_entry(iter, queue, list) {
+			if (iter->ml.cookie == unlock->cookie &&
+			    iter->ml.node == unlock->node_idx) {
+				dlm_lock_get(iter);
+				lock = iter;
 				break;
 			}
 		}
-		if (found)
+		if (lock)
 			break;
 		/* scan granted -> converting -> blocked queues */
 		queue++;
 	}
 	spin_unlock(&res->spinlock);
-	if (!found) {
+	if (!lock) {
 		status = DLM_IVLOCKID;
 		goto not_found;
 	}
@@ -505,7 +504,7 @@ int dlm_unlock_lock_handler(struct o2net_msg *msg, u32 len, void *data,
 	dlm_kick_thread(dlm, res);
 
 not_found:
-	if (!found)
+	if (!lock)
 		mlog(ML_ERROR, "failed to find lock to unlock! "
 			       "cookie=%u:%llu\n",
 		     dlm_get_lock_cookie_node(be64_to_cpu(unlock->cookie)),
diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index 0e4b16d4c037..38cc75bd3127 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -923,19 +923,19 @@ static struct ocfs2_quota_chunk *ocfs2_find_free_entry(struct super_block *sb,
 {
 	struct mem_dqinfo *info = sb_dqinfo(sb, type);
 	struct ocfs2_mem_dqinfo *oinfo = info->dqi_priv;
-	struct ocfs2_quota_chunk *chunk;
+	struct ocfs2_quota_chunk *chunk = NULL, *iter;
 	struct ocfs2_local_disk_chunk *dchunk;
 	int found = 0, len;
 
-	list_for_each_entry(chunk, &oinfo->dqi_chunk, qc_chunk) {
+	list_for_each_entry(iter, &oinfo->dqi_chunk, qc_chunk) {
 		dchunk = (struct ocfs2_local_disk_chunk *)
-						chunk->qc_headerbh->b_data;
+						iter->qc_headerbh->b_data;
 		if (le32_to_cpu(dchunk->dqc_free) > 0) {
-			found = 1;
+			chunk = iter;
 			break;
 		}
 	}
-	if (!found)
+	if (!chunk)
 		return NULL;
 
 	if (chunk->qc_num < oinfo->dqi_chunks - 1) {

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

