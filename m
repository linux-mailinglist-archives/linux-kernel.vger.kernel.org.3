Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1085AA2C5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbiIAWTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbiIAWST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:18:19 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B0B5A8BE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:18:06 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id c20so221190qtw.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 15:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=GmZL9QRJG3JGAUAVfGfSTA34gmVVbLMug2meh+hLHJM=;
        b=dWo8eLEyEw5jcTSOIhe0J42iN+xFaer3fDsss15lmAIIREY+MawFShJoU5lQXs152W
         5bBsVEo8OeqyIN1jsIXSjKgdCCZW0EZC9yD75V/Uy2UCsKQA1A2x2/RnRq2779uXc7NO
         fuaowWwCJUf5JBRU4sL3dTWtVU2pKz7JGf3F4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=GmZL9QRJG3JGAUAVfGfSTA34gmVVbLMug2meh+hLHJM=;
        b=5cd18HgW2qVVt4ENrpZtH6OU04mw3Ox4fz4FehfRL3HeOy/Gbj91ETvdsmbKTOcYDF
         QHBK0brzAnWc11Qr6uoTqlXOsKxNX8swIazEdMDae3bg9wT/u4wfNuPgEJD+V1UVrjrT
         EG/pH9dWLq2X9n+x9JKtJccv7ifkHY3tfbFkcdDw1sQvv3W8iMn3sy+QhofvxZv5Y4tg
         B+3MDs27yfO5L/hzHEHRSr/s0+8vg/RKGBtoriuK2hg8BMExN2EcbDYhOgJn4vW24X8n
         rIVRUJzjpHj3CD9tF4E6PSl/QUAd4ZibWFqPDaC8ydQv4jPaBCA6Php9jFP2Zj3ayEj1
         ilDA==
X-Gm-Message-State: ACgBeo0F1sRDGf6XtIKYVr4ysyju6PE89fSsazmAokwDmWVCKVzp2k5x
        gl0V67nVYmCrstrgRyHfYSQldA==
X-Google-Smtp-Source: AA6agR5d0+TO4TcTHxSbXssriWeXw2oFTaGpGLqzcaqhAOpXB66/FUakNqneNIoAQAkF8kDVHuirhQ==
X-Received: by 2002:a05:622a:3d0:b0:343:58db:d5c7 with SMTP id k16-20020a05622a03d000b0034358dbd5c7mr25537687qtx.21.1662070685069;
        Thu, 01 Sep 2022 15:18:05 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm11060794qtn.83.2022.09.01.15.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:18:04 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v5 11/18] fs: Move call_rcu() to call_rcu_lazy() in some paths
Date:   Thu,  1 Sep 2022 22:17:13 +0000
Message-Id: <20220901221720.1105021-12-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220901221720.1105021-1-joel@joelfernandes.org>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required to prevent callbacks triggering RCU machinery too
quickly and too often, which adds more power to the system.

When testing, we found that these paths were invoked often when the
system is not doing anything (screen is ON but otherwise idle).

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 fs/dcache.c     | 4 ++--
 fs/eventpoll.c  | 2 +-
 fs/file_table.c | 2 +-
 fs/inode.c      | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c5dc32a59c76..28a159a7e460 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -366,7 +366,7 @@ static void dentry_free(struct dentry *dentry)
 	if (unlikely(dname_external(dentry))) {
 		struct external_name *p = external_name(dentry);
 		if (likely(atomic_dec_and_test(&p->u.count))) {
-			call_rcu(&dentry->d_u.d_rcu, __d_free_external);
+			call_rcu_lazy(&dentry->d_u.d_rcu, __d_free_external);
 			return;
 		}
 	}
@@ -374,7 +374,7 @@ static void dentry_free(struct dentry *dentry)
 	if (dentry->d_flags & DCACHE_NORCU)
 		__d_free(&dentry->d_u.d_rcu);
 	else
-		call_rcu(&dentry->d_u.d_rcu, __d_free);
+		call_rcu_lazy(&dentry->d_u.d_rcu, __d_free);
 }
 
 /*
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 8b56b94e2f56..530e62538d3d 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -728,7 +728,7 @@ static int ep_remove(struct eventpoll *ep, struct epitem *epi)
 	 * ep->mtx. The rcu read side, reverse_path_check_proc(), does not make
 	 * use of the rbn field.
 	 */
-	call_rcu(&epi->rcu, epi_rcu_free);
+	call_rcu_lazy(&epi->rcu, epi_rcu_free);
 
 	percpu_counter_dec(&ep->user->epoll_watches);
 
diff --git a/fs/file_table.c b/fs/file_table.c
index 99c6796c9f28..36b3de669771 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -56,7 +56,7 @@ static inline void file_free(struct file *f)
 	security_file_free(f);
 	if (!(f->f_mode & FMODE_NOACCOUNT))
 		percpu_counter_dec(&nr_files);
-	call_rcu(&f->f_rcuhead, file_free_rcu);
+	call_rcu_lazy(&f->f_rcuhead, file_free_rcu);
 }
 
 /*
diff --git a/fs/inode.c b/fs/inode.c
index 6462276dfdf0..7d1573cf3a97 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -312,7 +312,7 @@ static void destroy_inode(struct inode *inode)
 			return;
 	}
 	inode->free_inode = ops->free_inode;
-	call_rcu(&inode->i_rcu, i_callback);
+	call_rcu_lazy(&inode->i_rcu, i_callback);
 }
 
 /**
-- 
2.37.2.789.g6183377224-goog

