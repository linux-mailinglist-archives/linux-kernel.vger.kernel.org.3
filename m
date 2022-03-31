Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8CF4EE3B7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242232AbiCaWEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240308AbiCaWEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:04:08 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAA223F3F2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:02:20 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h4so874964edr.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6f0oJeP6cPKgr/ko31ztKU+CVJ2YQLwk0JpTcyTaytg=;
        b=Ja71DbPeENZcLgfc/+4b9VMb/6B/258o9DtKgVYX7JjJfOFvWhUkBJNFSf+Qm64asn
         mIg8KnwZsqHGn04vB0HyapsjG8g2swq87qOIHhqkJDyR4QXXeq6UbL14z5pyFXtR4Lyd
         dl/PgVItGcbOSDL/Bg5rYfHf5usqtrJoRW9yuzDNMW6e8nOdeAIkg57ptq6RGiIIDtZR
         Y2TAIExn1cOWfTXSx4hvOSMCdUH7CcAxnok3v1oyeAqCOmXkjTYMldPXySbXZClK/3tk
         WGv1HXRoDuMy72sTNqo20akFSRYyOJ0l5O+vFDeygmoQC7TJaX6dEEYqDRyurXEjReyV
         gPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6f0oJeP6cPKgr/ko31ztKU+CVJ2YQLwk0JpTcyTaytg=;
        b=f3znJRtLYx6D77pujao5W9S4hgXrCdCzimc81JZSgF9/nNFCPiyQOzvkxMnVJx3hzm
         etsUfKps7j/f+NSX6LLTp3hoCEs52DbbiPvd96J9ZSwhh9UjcnBzy1qpIG9B1k0bhgMh
         lSpXTTIISPdkvajgMWxX3ux51mDsAq0hFHeHIcUgJDVjqiqL5LMwzNxJlpc7pWs3cTMm
         uFrPnGfqI3PFmuVQWfdMQDfKPqMM1YuishnbfkK4I2toJnYGWSpwZ/G8erGLQHNmNL+D
         +qeGExJTDOpt6gDETl2gywJdBR44PkrofyVe+cOT23H7z7zkAB9COm1YbPgr2t8lMSNP
         ZVEA==
X-Gm-Message-State: AOAM533rROE5P9X+BFtgHyyUO2pgAzkJ3Bsu/UQOPDooZdF0352sO8Qg
        TcmvM2VuZqXpJGlaMg4h8wU=
X-Google-Smtp-Source: ABdhPJzrJvU31t1SDNBcaMG4kzEqCtT28PM99lWZaLo/24NQM3zrfcIKGutesI0c+u3dMEtPiik3cg==
X-Received: by 2002:a05:6402:b15:b0:419:fb4:e2e4 with SMTP id bm21-20020a0564020b1500b004190fb4e2e4mr18233106edb.147.1648764139045;
        Thu, 31 Mar 2022 15:02:19 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id n21-20020a170906725500b006e10a7d6d03sm238050ejk.219.2022.03.31.15.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 15:02:18 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Christine Caulfield <ccaulfie@redhat.com>
Cc:     David Teigland <teigland@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH 2/2] dlm: replace usage of found with dedicated list iterator variable
Date:   Fri,  1 Apr 2022 00:00:13 +0200
Message-Id: <20220331220013.884633-2-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220331220013.884633-1-jakobkoschel@gmail.com>
References: <20220331220013.884633-1-jakobkoschel@gmail.com>
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
 fs/dlm/lock.c    | 53 +++++++++++++++++++++++-------------------------
 fs/dlm/plock.c   | 25 ++++++++++++-----------
 fs/dlm/recover.c | 35 ++++++++++++++++----------------
 3 files changed, 55 insertions(+), 58 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 66e92617d7ea..729c1ca8824f 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1870,7 +1870,7 @@ static void del_timeout(struct dlm_lkb *lkb)
 void dlm_scan_timeout(struct dlm_ls *ls)
 {
 	struct dlm_rsb *r;
-	struct dlm_lkb *lkb;
+	struct dlm_lkb *lkb = NULL, *iter;
 	int do_cancel, do_warn;
 	s64 wait_us;
 
@@ -1881,27 +1881,28 @@ void dlm_scan_timeout(struct dlm_ls *ls)
 		do_cancel = 0;
 		do_warn = 0;
 		mutex_lock(&ls->ls_timeout_mutex);
-		list_for_each_entry(lkb, &ls->ls_timeout, lkb_time_list) {
+		list_for_each_entry(iter, &ls->ls_timeout, lkb_time_list) {
 
 			wait_us = ktime_to_us(ktime_sub(ktime_get(),
-					      		lkb->lkb_timestamp));
+					      iter->lkb_timestamp));
 
-			if ((lkb->lkb_exflags & DLM_LKF_TIMEOUT) &&
-			    wait_us >= (lkb->lkb_timeout_cs * 10000))
+			if ((iter->lkb_exflags & DLM_LKF_TIMEOUT) &&
+			    wait_us >= (iter->lkb_timeout_cs * 10000))
 				do_cancel = 1;
 
-			if ((lkb->lkb_flags & DLM_IFL_WATCH_TIMEWARN) &&
+			if ((iter->lkb_flags & DLM_IFL_WATCH_TIMEWARN) &&
 			    wait_us >= dlm_config.ci_timewarn_cs * 10000)
 				do_warn = 1;
 
 			if (!do_cancel && !do_warn)
 				continue;
-			hold_lkb(lkb);
+			hold_lkb(iter);
+			lkb = iter;
 			break;
 		}
 		mutex_unlock(&ls->ls_timeout_mutex);
 
-		if (!do_cancel && !do_warn)
+		if (!lkb)
 			break;
 
 		r = lkb->lkb_resource;
@@ -5261,21 +5262,18 @@ void dlm_recover_waiters_pre(struct dlm_ls *ls)
 
 static struct dlm_lkb *find_resend_waiter(struct dlm_ls *ls)
 {
-	struct dlm_lkb *lkb;
-	int found = 0;
+	struct dlm_lkb *lkb = NULL, *iter;
 
 	mutex_lock(&ls->ls_waiters_mutex);
-	list_for_each_entry(lkb, &ls->ls_waiters, lkb_wait_reply) {
-		if (lkb->lkb_flags & DLM_IFL_RESEND) {
-			hold_lkb(lkb);
-			found = 1;
+	list_for_each_entry(iter, &ls->ls_waiters, lkb_wait_reply) {
+		if (iter->lkb_flags & DLM_IFL_RESEND) {
+			hold_lkb(iter);
+			lkb = iter;
 			break;
 		}
 	}
 	mutex_unlock(&ls->ls_waiters_mutex);
 
-	if (!found)
-		lkb = NULL;
 	return lkb;
 }
 
@@ -5929,37 +5927,36 @@ int dlm_user_adopt_orphan(struct dlm_ls *ls, struct dlm_user_args *ua_tmp,
 		     int mode, uint32_t flags, void *name, unsigned int namelen,
 		     unsigned long timeout_cs, uint32_t *lkid)
 {
-	struct dlm_lkb *lkb;
+	struct dlm_lkb *lkb = NULL, *iter;
 	struct dlm_user_args *ua;
 	int found_other_mode = 0;
-	int found = 0;
 	int rv = 0;
 
 	mutex_lock(&ls->ls_orphans_mutex);
-	list_for_each_entry(lkb, &ls->ls_orphans, lkb_ownqueue) {
-		if (lkb->lkb_resource->res_length != namelen)
+	list_for_each_entry(iter, &ls->ls_orphans, lkb_ownqueue) {
+		if (iter->lkb_resource->res_length != namelen)
 			continue;
-		if (memcmp(lkb->lkb_resource->res_name, name, namelen))
+		if (memcmp(iter->lkb_resource->res_name, name, namelen))
 			continue;
-		if (lkb->lkb_grmode != mode) {
+		if (iter->lkb_grmode != mode) {
 			found_other_mode = 1;
 			continue;
 		}
 
-		found = 1;
-		list_del_init(&lkb->lkb_ownqueue);
-		lkb->lkb_flags &= ~DLM_IFL_ORPHAN;
-		*lkid = lkb->lkb_id;
+		lkb = iter;
+		list_del_init(&iter->lkb_ownqueue);
+		iter->lkb_flags &= ~DLM_IFL_ORPHAN;
+		*lkid = iter->lkb_id;
 		break;
 	}
 	mutex_unlock(&ls->ls_orphans_mutex);
 
-	if (!found && found_other_mode) {
+	if (!lkb && found_other_mode) {
 		rv = -EAGAIN;
 		goto out;
 	}
 
-	if (!found) {
+	if (!lkb) {
 		rv = -ENOENT;
 		goto out;
 	}
diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index c38b2b8ffd1d..c7ac0377822c 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -419,8 +419,8 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 			 loff_t *ppos)
 {
 	struct dlm_plock_info info;
-	struct plock_op *op;
-	int found = 0, do_callback = 0;
+	struct plock_op *op = NULL, *iter;
+	int do_callback = 0;
 
 	if (count != sizeof(info))
 		return -EINVAL;
@@ -432,24 +432,25 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 		return -EINVAL;
 
 	spin_lock(&ops_lock);
-	list_for_each_entry(op, &recv_list, list) {
-		if (op->info.fsid == info.fsid &&
-		    op->info.number == info.number &&
-		    op->info.owner == info.owner) {
-			struct plock_xop *xop = (struct plock_xop *)op;
-			list_del_init(&op->list);
-			memcpy(&op->info, &info, sizeof(info));
+	list_for_each_entry(iter, &recv_list, list) {
+		if (iter->info.fsid == info.fsid &&
+		    iter->info.number == info.number &&
+		    iter->info.owner == info.owner) {
+			struct plock_xop *xop = (struct plock_xop *)iter;
+
+			list_del_init(&iter->list);
+			memcpy(&iter->info, &info, sizeof(info));
 			if (xop->callback)
 				do_callback = 1;
 			else
-				op->done = 1;
-			found = 1;
+				iter->done = 1;
+			op = iter;
 			break;
 		}
 	}
 	spin_unlock(&ops_lock);
 
-	if (found) {
+	if (op) {
 		if (do_callback)
 			dlm_plock_callback(op);
 		else
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index 8928e99dfd47..15ad5c2c9dfc 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -732,10 +732,9 @@ void dlm_recovered_lock(struct dlm_rsb *r)
 
 static void recover_lvb(struct dlm_rsb *r)
 {
-	struct dlm_lkb *lkb, *high_lkb = NULL;
+	struct dlm_lkb *lkb = NULL, *iter, *high_lkb = NULL;
 	uint32_t high_seq = 0;
 	int lock_lvb_exists = 0;
-	int big_lock_exists = 0;
 	int lvblen = r->res_ls->ls_lvblen;
 
 	if (!rsb_flag(r, RSB_NEW_MASTER2) &&
@@ -751,37 +750,37 @@ static void recover_lvb(struct dlm_rsb *r)
 	/* we are the new master, so figure out if VALNOTVALID should
 	   be set, and set the rsb lvb from the best lkb available. */
 
-	list_for_each_entry(lkb, &r->res_grantqueue, lkb_statequeue) {
-		if (!(lkb->lkb_exflags & DLM_LKF_VALBLK))
+	list_for_each_entry(iter, &r->res_grantqueue, lkb_statequeue) {
+		if (!(iter->lkb_exflags & DLM_LKF_VALBLK))
 			continue;
 
 		lock_lvb_exists = 1;
 
-		if (lkb->lkb_grmode > DLM_LOCK_CR) {
-			big_lock_exists = 1;
+		if (iter->lkb_grmode > DLM_LOCK_CR) {
+			lkb = iter;
 			goto setflag;
 		}
 
-		if (((int)lkb->lkb_lvbseq - (int)high_seq) >= 0) {
-			high_lkb = lkb;
-			high_seq = lkb->lkb_lvbseq;
+		if (((int)iter->lkb_lvbseq - (int)high_seq) >= 0) {
+			high_lkb = iter;
+			high_seq = iter->lkb_lvbseq;
 		}
 	}
 
-	list_for_each_entry(lkb, &r->res_convertqueue, lkb_statequeue) {
-		if (!(lkb->lkb_exflags & DLM_LKF_VALBLK))
+	list_for_each_entry(iter, &r->res_convertqueue, lkb_statequeue) {
+		if (!(iter->lkb_exflags & DLM_LKF_VALBLK))
 			continue;
 
 		lock_lvb_exists = 1;
 
-		if (lkb->lkb_grmode > DLM_LOCK_CR) {
-			big_lock_exists = 1;
+		if (iter->lkb_grmode > DLM_LOCK_CR) {
+			lkb = iter;
 			goto setflag;
 		}
 
-		if (((int)lkb->lkb_lvbseq - (int)high_seq) >= 0) {
-			high_lkb = lkb;
-			high_seq = lkb->lkb_lvbseq;
+		if (((int)iter->lkb_lvbseq - (int)high_seq) >= 0) {
+			high_lkb = iter;
+			high_seq = iter->lkb_lvbseq;
 		}
 	}
 
@@ -790,7 +789,7 @@ static void recover_lvb(struct dlm_rsb *r)
 		goto out;
 
 	/* lvb is invalidated if only NL/CR locks remain */
-	if (!big_lock_exists)
+	if (!lkb)
 		rsb_set_flag(r, RSB_VALNOTVALID);
 
 	if (!r->res_lvbptr) {
@@ -799,7 +798,7 @@ static void recover_lvb(struct dlm_rsb *r)
 			goto out;
 	}
 
-	if (big_lock_exists) {
+	if (lkb) {
 		r->res_lvbseq = lkb->lkb_lvbseq;
 		memcpy(r->res_lvbptr, lkb->lkb_lvbptr, lvblen);
 	} else if (high_lkb) {
-- 
2.25.1

