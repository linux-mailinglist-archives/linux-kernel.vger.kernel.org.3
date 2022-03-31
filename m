Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A2A4EE38A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241364AbiCaV5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241964AbiCaV5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:57:17 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE0B18DABF;
        Thu, 31 Mar 2022 14:55:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g20so844594edw.6;
        Thu, 31 Mar 2022 14:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mYiZAp5crj7zt20kQFORzQKCa+U0blAAcUxyywZ7Mv8=;
        b=FeDPCQZjyeIkpTap9miz9tGPpK/F/w/H1LCEO8grfFLTe6SLOu1s5zfdmVJShgvbVg
         FGjopJ+R714TuXT/kjfaEhOeDZSF6UPVTe6uHA3qfOowDqaEmZZYLSac73rBQngFEJk7
         7v8MZaCqH06FkphCof1WJhye69+K7hHpzgBDRqjYRG70jKrz0sgLElQZeA9khOEdDBnR
         XGjpX3a2sEKW+IAW0xKMZmlyI4g2oukOxIIZ9KKeOCGpE2vbGtTt2EWWyql4nSYgNB2C
         d76CC3mfbiUq4J7rxIS8ZSweerHEI+Tv2UY/1G8iSrg1+aK07JFqwXhzqSVWCPz27bGY
         tB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mYiZAp5crj7zt20kQFORzQKCa+U0blAAcUxyywZ7Mv8=;
        b=SVRoNmal/PQ3pewhDwYE/aly6EktRomYjV66hATkGVdVXR2jx/4gMkG1aitNmqM09k
         0m4f+b8pP09DmVTYCHI+z55DSmjSIePdr9ZIX5IcU7iNg1NYSZ+mUATDALdTdBLGiImO
         Na+3LaQkSS7bcEQfZHmGxGavzaSfGKVjxRE8tq60yaDMVUo9dqrYLDfU3QniUzD6MZPZ
         pZVR/ccjKFmMMM4l3dwqqhI0yXkIzQjngsTWpv4JqPhkD+wKdmtxA10jUicAStTkvuwI
         ARRqZXQfCWE2QABYpXLQYSdnAXZ1eiH6xZ3D+l8SHmL6iB/A/fxvw70f9pv1lgAJK2rZ
         GZmw==
X-Gm-Message-State: AOAM531BId/JKBh6Bjts7uhgG5yt+60BoEQJ7tMEKn+7YCP9jWOk0+gN
        GxPlmdBhXQn3WtfBB5EN9A4=
X-Google-Smtp-Source: ABdhPJzSMFwlIFnb556Q9mISFt2nb2tAY1LA0KsgAjFx85IkCSwDVTa5KYy+BghgOopuELEXbPmVrw==
X-Received: by 2002:a05:6402:2688:b0:419:5dde:4700 with SMTP id w8-20020a056402268800b004195dde4700mr18672096edd.124.1648763727032;
        Thu, 31 Mar 2022 14:55:27 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id r11-20020aa7cfcb000000b0041902ac4c6asm307950edy.1.2022.03.31.14.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 14:55:26 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH 2/2] ceph: replace usage of found with dedicated list iterator variable
Date:   Thu, 31 Mar 2022 23:53:29 +0200
Message-Id: <20220331215329.882411-2-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220331215329.882411-1-jakobkoschel@gmail.com>
References: <20220331215329.882411-1-jakobkoschel@gmail.com>
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

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 fs/ceph/caps.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 519750bc5a1a..70f9c5ffa9b7 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3179,10 +3179,9 @@ void ceph_put_wrbuffer_cap_refs(struct ceph_inode_info *ci, int nr,
 				struct ceph_snap_context *snapc)
 {
 	struct inode *inode = &ci->vfs_inode;
-	struct ceph_cap_snap *capsnap = NULL;
+	struct ceph_cap_snap *capsnap = NULL, *iter;
 	int put = 0;
 	bool last = false;
-	bool found = false;
 	bool flush_snaps = false;
 	bool complete_capsnap = false;
 
@@ -3209,14 +3208,14 @@ void ceph_put_wrbuffer_cap_refs(struct ceph_inode_info *ci, int nr,
 		     ci->i_wrbuffer_ref, ci->i_wrbuffer_ref_head,
 		     last ? " LAST" : "");
 	} else {
-		list_for_each_entry(capsnap, &ci->i_cap_snaps, ci_item) {
-			if (capsnap->context == snapc) {
-				found = true;
+		list_for_each_entry(iter, &ci->i_cap_snaps, ci_item) {
+			if (iter->context == snapc) {
+				capsnap = iter;
 				break;
 			}
 		}
 
-		if (!found) {
+		if (!capsnap) {
 			/*
 			 * The capsnap should already be removed when removing
 			 * auth cap in the case of a forced unmount.
@@ -3766,8 +3765,7 @@ static void handle_cap_flushsnap_ack(struct inode *inode, u64 flush_tid,
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
 	u64 follows = le64_to_cpu(m->snap_follows);
-	struct ceph_cap_snap *capsnap;
-	bool flushed = false;
+	struct ceph_cap_snap *capsnap = NULL, *iter;
 	bool wake_ci = false;
 	bool wake_mdsc = false;
 
@@ -3775,26 +3773,26 @@ static void handle_cap_flushsnap_ack(struct inode *inode, u64 flush_tid,
 	     inode, ci, session->s_mds, follows);
 
 	spin_lock(&ci->i_ceph_lock);
-	list_for_each_entry(capsnap, &ci->i_cap_snaps, ci_item) {
-		if (capsnap->follows == follows) {
-			if (capsnap->cap_flush.tid != flush_tid) {
+	list_for_each_entry(iter, &ci->i_cap_snaps, ci_item) {
+		if (iter->follows == follows) {
+			if (iter->cap_flush.tid != flush_tid) {
 				dout(" cap_snap %p follows %lld tid %lld !="
-				     " %lld\n", capsnap, follows,
-				     flush_tid, capsnap->cap_flush.tid);
+				     " %lld\n", iter, follows,
+				     flush_tid, iter->cap_flush.tid);
 				break;
 			}
-			flushed = true;
+			capsnap = iter;
 			break;
 		} else {
 			dout(" skipping cap_snap %p follows %lld\n",
-			     capsnap, capsnap->follows);
+			     iter, iter->follows);
 		}
 	}
-	if (flushed)
+	if (capsnap)
 		ceph_remove_capsnap(inode, capsnap, &wake_ci, &wake_mdsc);
 	spin_unlock(&ci->i_ceph_lock);
 
-	if (flushed) {
+	if (capsnap) {
 		ceph_put_snap_context(capsnap->context);
 		ceph_put_cap_snap(capsnap);
 		if (wake_ci)
-- 
2.25.1

