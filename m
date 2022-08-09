Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB0758D271
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 05:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiHIDpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 23:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbiHIDpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 23:45:30 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECD3F2C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 20:45:26 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id j11so7717863qvt.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 20:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=79M25MWR38hIwNzB4pc/QQCfMvwV2bxODQRXrcGwFU0=;
        b=g3RxAkVgiKl0CSfhHsB+k7kFQuj0x+rUuKnYD76+0f9Ygy9kyCF9wbkAR9l0f2yxaY
         oyFOmLSB1kme/H7HQMMb5wVP0Iv3+4NAGZg+AeUEsSjfw6UaX8wtqmtnM+VKYX/GHu46
         tV9iq3HgqRMGX9BCtXUD1cx4cZP73Kcgt986M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=79M25MWR38hIwNzB4pc/QQCfMvwV2bxODQRXrcGwFU0=;
        b=7uf/9NlBtTzYXbl5XMwXvwcdq4M8vpb3LR3XplnRWVf+GirjCLtRhZcc+bWE2gxgWl
         uRnSKiXUJRnefOEl2X3B0JFtrDw710rU4iGnl+HikNS0hYLTAR4P0/g39UjBiK/E9ISU
         KCBh7wxCde3ax6PSzmHt1IUXHXi3mk3sEGx/DMiSkjbS3n+pQKmLxmwFIETnQjEwQ2I5
         W1VzDvPc+M8+jBzvWk80pcSq0GAxT4HQvLNiDgvX4UgPzePnzxvv4gcOs3cSBKEWzbfq
         LwLoo1AIDF56AAEvBcnr5tMSlQ8ChBtaqnpCVAuh0XfC88UQ8OSp3CDLduuiGIEER9Fg
         F7ow==
X-Gm-Message-State: ACgBeo0wSisiazK9B/Sp+ICVWjESvCSbePAglobWR5kuxkuKvJAI2RPj
        AUFsjTai6bjO1GCIgntwha5ExyetkRpJsw==
X-Google-Smtp-Source: AA6agR4rCqZqlEj5g79Z1AokQt/3xKmmsG9dVVl2MU0A2ZqjbQLET9iyJIwV8cudoBdMzHi7pXW1rQ==
X-Received: by 2002:a05:6214:226e:b0:474:9a8b:3853 with SMTP id gs14-20020a056214226e00b004749a8b3853mr18230624qvb.85.1660016725836;
        Mon, 08 Aug 2022 20:45:25 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id ca8-20020a05622a1f0800b0031f0b43629dsm9170979qtb.23.2022.08.08.20.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 20:45:25 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org, rcu@vger.kernel.org
Subject: [PATCH v3 resend 4/6] fs: Move call_rcu() to call_rcu_lazy() in some paths
Date:   Tue,  9 Aug 2022 03:45:15 +0000
Message-Id: <20220809034517.3867176-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
In-Reply-To: <20220809034517.3867176-1-joel@joelfernandes.org>
References: <20220809034517.3867176-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
index 93f4f5ee07bf..7f51bac390c8 100644
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
index 971f98af48ff..57b3f781760c 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -729,7 +729,7 @@ static int ep_remove(struct eventpoll *ep, struct epitem *epi)
 	 * ep->mtx. The rcu read side, reverse_path_check_proc(), does not make
 	 * use of the rbn field.
 	 */
-	call_rcu(&epi->rcu, epi_rcu_free);
+	call_rcu_lazy(&epi->rcu, epi_rcu_free);
 
 	percpu_counter_dec(&ep->user->epoll_watches);
 
diff --git a/fs/file_table.c b/fs/file_table.c
index 5424e3a8df5f..417f57e9cb30 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -56,7 +56,7 @@ static inline void file_free(struct file *f)
 	security_file_free(f);
 	if (!(f->f_mode & FMODE_NOACCOUNT))
 		percpu_counter_dec(&nr_files);
-	call_rcu(&f->f_u.fu_rcuhead, file_free_rcu);
+	call_rcu_lazy(&f->f_u.fu_rcuhead, file_free_rcu);
 }
 
 /*
diff --git a/fs/inode.c b/fs/inode.c
index bd4da9c5207e..38fe040ddbd6 100644
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
2.37.1.559.g78731f0fdb-goog

