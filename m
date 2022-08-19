Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C1859A72C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 22:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351785AbiHSUt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 16:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351367AbiHSUtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:49:12 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7979B3B36
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:49:07 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c9so2966832qkk.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=yBV3vkCTgPe3Ul1W4jUUwZZjvExObdYpbC/MGzFj//E=;
        b=ZGz05HeG9rIUBCpyhoDA37RYMUY14Ci8MukMO2MctVw3Xe1BHKtAeXAY/niZLnMPjS
         kfEHlgOt7DV+W//bFQCWm5EdkDghGTOByuPu2baAjLmzD+cP4LBHlsZImjWVz5uc+rv9
         dnTxHzcVSJVgKwx3nMaXnp1JsnLcEBTO949lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=yBV3vkCTgPe3Ul1W4jUUwZZjvExObdYpbC/MGzFj//E=;
        b=ObbohkXM/0jxzn4gFkJt2CPzX5AtQlSt5FzW/QQgM8+pMUi+F12SVIHEBolIy7b4zP
         MvAwggTiKyGu85eczyePpM8Jgp7YBH1LkzB6IM3cXyrnY1fTb0RgSTsuRkRHwRh6o4MI
         E/8DoGWMH9rjDg65lvmqdP+IgooFnie8GVQz0NklZW9pfFud1f07m1hMan55V32lrgyj
         jnSaacvY5+tG1KulTI2KPU90fb3G4DqFo9V6pOL8HeTZYaC8EaE7TlioP6jDaWguWRD1
         ksQCwx/04r1sQTth09iH6nLpcr1BJyGfbnLdFnD8shaSbeSW4qOlDmPggYM5foUH/r33
         aDMA==
X-Gm-Message-State: ACgBeo0N5iPLi0cnxuNZZcITQBI0cDB7ey2L721yE8lPfztkVhD1V+vc
        d+ulIS+iTpYbgthNZ2xS1YiqQyDco5wTMQ==
X-Google-Smtp-Source: AA6agR5ZBW9PkeFmvrVxxY7HxjpUWeF/w6JpG0gJ82bEIn1XL0g30W+QVZyeOAN1ZVNeLdLYknEEgg==
X-Received: by 2002:a05:620a:25c8:b0:6ae:ba71:ea7d with SMTP id y8-20020a05620a25c800b006aeba71ea7dmr6443457qko.547.1660942146948;
        Fri, 19 Aug 2022 13:49:06 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a258800b006b9a89d408csm4377123qko.100.2022.08.19.13.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:49:06 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@kernel.org,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, vineeth@bitbyteword.org
Subject: [PATCH v4 04/14] fs: Move call_rcu() to call_rcu_lazy() in some paths
Date:   Fri, 19 Aug 2022 20:48:47 +0000
Message-Id: <20220819204857.3066329-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
In-Reply-To: <20220819204857.3066329-1-joel@joelfernandes.org>
References: <20220819204857.3066329-1-joel@joelfernandes.org>
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
2.37.2.609.g9ff673ca1a-goog

