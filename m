Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382684EE449
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242585AbiCaWmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiCaWmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:42:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AA31C4B17
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:40:29 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b24so921658edu.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K4PijKfHqVSR8jpN9OjGMTbj1kKE70x0H0mGmScT4hA=;
        b=bObT5oqHf4n/hmFYQrjTw07HesIgxEpuwzQEoZjAsR2vmNnWH4/vyXgbkQEqGkPAHs
         3VxYMLaAFnY9ZCmfl8VmxwtGdyy0OTiAvSj3yOEgbpRZUcLbuF7oz+wlPQoWARVxxP4p
         HH72I8ogwIGF3MHMEulpA7YeufSqKNLKNwBZgGhZnKiyZMohlgWQQXyRfM5jvFnDJhGn
         HZSaR9TcNMY1PIkpdajxietHBWEunOzWPWbwrMxWoOND1iWgDNd6zNF3bTcnwL61JbFK
         Cy+sQVwaseL7BTgRHzt8TggcKsk8ysrjHT5sEyjAFPvqbkONl1DHMyKPFbVjlQrTpDb9
         dWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K4PijKfHqVSR8jpN9OjGMTbj1kKE70x0H0mGmScT4hA=;
        b=x8sScEAFx/4KBOHyC/QBSM0sDURW/lRT3TWsVyhvyRnZrK4bNuzvuS/6kCoQ2nfAXX
         mnvhPEvajsZyVTviObWzsoWNGse/ClTaC+egiW8A7W9UvHtK1QVxRki2zrgv6Kd7C1AH
         z93pxFdm0jP3+Fulvib/pc3IcpHSSxxkmdTK3c3MP0Myy0V4INihK2qR5IJcb0+6ex0Q
         EUxEz1ai8CWZdBWsTkbeWlyeqfDg3BkDiGRKCz1ubb+LU7ouGV3/6eEA++ww74mu8Aha
         i5JQGheYYTJZeQMItWfbfB6LJqbItC6mX0jaSe+ABkDHLkF1/7yUP7G7zxICHNHpJY0Q
         qATA==
X-Gm-Message-State: AOAM530TnFpPlvPVNWyIjqfTyIX1gc4M6uSIMIPTmHBEQgd1oviSb+3E
        HOG5cKirLWt+RvjVwbmlLAw=
X-Google-Smtp-Source: ABdhPJziH3omYLkme2QH6lxqgk+xvHYZw5BgMrkqY/Y8acIgiYDBiMIm8SAS0sCsvtXhCWey1za7sg==
X-Received: by 2002:aa7:d682:0:b0:419:3b78:e489 with SMTP id d2-20020aa7d682000000b004193b78e489mr18676652edr.372.1648766428107;
        Thu, 31 Mar 2022 15:40:28 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id j21-20020a170906255500b006e08c4862ccsm278505ejb.96.2022.03.31.15.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 15:40:27 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Bob Peterson <rpeterso@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH 2/2] gfs2: replace usage of found with dedicated list iterator variable
Date:   Fri,  1 Apr 2022 00:38:57 +0200
Message-Id: <20220331223857.902911-2-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220331223857.902911-1-jakobkoschel@gmail.com>
References: <20220331223857.902911-1-jakobkoschel@gmail.com>
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
 fs/gfs2/quota.c    | 13 ++++++-------
 fs/gfs2/recovery.c | 22 ++++++++++------------
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index be0997e24d60..dafd04fb9164 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -443,7 +443,7 @@ static int qd_check_sync(struct gfs2_sbd *sdp, struct gfs2_quota_data *qd,
 
 static int qd_fish(struct gfs2_sbd *sdp, struct gfs2_quota_data **qdp)
 {
-	struct gfs2_quota_data *qd = NULL;
+	struct gfs2_quota_data *qd = NULL, *iter;
 	int error;
 	int found = 0;
 
@@ -454,15 +454,14 @@ static int qd_fish(struct gfs2_sbd *sdp, struct gfs2_quota_data **qdp)
 
 	spin_lock(&qd_lock);
 
-	list_for_each_entry(qd, &sdp->sd_quota_list, qd_list) {
-		found = qd_check_sync(sdp, qd, &sdp->sd_quota_sync_gen);
-		if (found)
+	list_for_each_entry(iter, &sdp->sd_quota_list, qd_list) {
+		found = qd_check_sync(sdp, iter, &sdp->sd_quota_sync_gen);
+		if (found) {
+			qd = iter;
 			break;
+		}
 	}
 
-	if (!found)
-		qd = NULL;
-
 	spin_unlock(&qd_lock);
 
 	if (qd) {
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 016ed1b2ca1d..2bb085a72e8e 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -55,17 +55,16 @@ int gfs2_replay_read_block(struct gfs2_jdesc *jd, unsigned int blk,
 int gfs2_revoke_add(struct gfs2_jdesc *jd, u64 blkno, unsigned int where)
 {
 	struct list_head *head = &jd->jd_revoke_list;
-	struct gfs2_revoke_replay *rr;
-	int found = 0;
+	struct gfs2_revoke_replay *rr = NULL, *iter;
 
-	list_for_each_entry(rr, head, rr_list) {
-		if (rr->rr_blkno == blkno) {
-			found = 1;
+	list_for_each_entry(iter, head, rr_list) {
+		if (iter->rr_blkno == blkno) {
+			rr = iter;
 			break;
 		}
 	}
 
-	if (found) {
+	if (rr) {
 		rr->rr_where = where;
 		return 0;
 	}
@@ -83,18 +82,17 @@ int gfs2_revoke_add(struct gfs2_jdesc *jd, u64 blkno, unsigned int where)
 
 int gfs2_revoke_check(struct gfs2_jdesc *jd, u64 blkno, unsigned int where)
 {
-	struct gfs2_revoke_replay *rr;
+	struct gfs2_revoke_replay *rr = NULL, *iter;
 	int wrap, a, b, revoke;
-	int found = 0;
 
-	list_for_each_entry(rr, &jd->jd_revoke_list, rr_list) {
-		if (rr->rr_blkno == blkno) {
-			found = 1;
+	list_for_each_entry(iter, &jd->jd_revoke_list, rr_list) {
+		if (iter->rr_blkno == blkno) {
+			rr = iter;
 			break;
 		}
 	}
 
-	if (!found)
+	if (!rr)
 		return 0;
 
 	wrap = (rr->rr_where < jd->jd_replay_tail);
-- 
2.25.1

