Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4CA565A1E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbiGDPnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbiGDPnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:43:02 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0BE1180D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:42:59 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s1so14014205wra.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 08:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=46SlzW74GIiHvhVWuQrLRhWnlm69Aurjg5UhCuYh8/k=;
        b=tJ2R8cV0GXu4lJJxtQOskBniE5SCBOJmzYLF6g+YoBM/ND2oaDYMEI12eU1iSR9CB4
         kvtjlQ03jzaTxrEoYN5/aNfDr9XavyViWb20b4VFUAS1XHWfqzfjyD3z4r1SOkuUNaRa
         bUOxuErvNKBqRfHNwhbnwp/3s6uOUsjcdmyHa0gEXTAKzsdvaP4kl1mQGd23V9us2mVH
         EuT1SuhwPAymWdXQk6BOZS0MMf9sNso2+l5EI3Z2JSeaGtNQguYinMWTXHrrB61ExiTv
         qh89lVbfcWz3YjCTsfxfOmEB52+iQwYUyRvDWrFUXJAv3tszFTd7YeARbSapGoQsKudK
         /LBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=46SlzW74GIiHvhVWuQrLRhWnlm69Aurjg5UhCuYh8/k=;
        b=Rmk8U8PzJpTsSUCIcqOnjNuXDUXMaFUq1OcDHpQG/fkUPzeTbBiaSwODrfyrtsQhNO
         jtBHRiSxuTD0wcd4RS5pPTwZ74IhqnrqhBupsvnchBFyOR1AU5IVozjKP2F26kwchsjZ
         RhwKWCJzZF/XDdY4DMveAqRDp5jE+tdze4ZKaAxLvGTdo3jqX/28gP5Hj4NXdqgC2mP9
         Tv3Kvt0wkcp6RCzB3jw70xCZThoRANouhDTecNnLuaGuNv/DdmpIPXv+a8T4BYKU4Fqe
         HjZSRJMZWQIPUssE/sKTzjZ1S0xqKB2OSDXXScJ8sEssC0Sr3mzz9Vdlxu1XGrPAuOg8
         yWUA==
X-Gm-Message-State: AJIora8I55E5Aq1WIrq+ABTeTFl+LbvgBndN5iQBAvWbPTwE0+53bOE4
        2IySQmZw8DLAUbyyY840TJkDYA==
X-Google-Smtp-Source: AGRyM1s/hggudqgbsLZO5A9418cfpoWQrC3JDVJB1TU5WdQcG/6N+DuyzVdbMA7ftjSlm+QVDzET6g==
X-Received: by 2002:adf:d1c2:0:b0:21b:e465:1e36 with SMTP id b2-20020adfd1c2000000b0021be4651e36mr28864769wrd.271.1656949377791;
        Mon, 04 Jul 2022 08:42:57 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:a9e8:9fdd:fa2d:1c72])
        by smtp.gmail.com with ESMTPSA id j6-20020adfff86000000b0021d6b851ca1sm2763749wrr.111.2022.07.04.08.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 08:42:57 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        leo.yan@linaro.org, acme@kernel.org, james.clark@arm.com,
        Mike Leach <mike.leach@linaro.org>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 7/7] configfs: Fix LOCKDEP nesting issues with fragment semaphores
Date:   Mon,  4 Jul 2022 16:42:49 +0100
Message-Id: <20220704154249.11501-8-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220704154249.11501-1-mike.leach@linaro.org>
References: <20220704154249.11501-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CoreSight uses configfs to represent the user interface to programmed
configurations, which can be loaded and unloaded dynamically via configfs.

These add and remove configurations using register/unregister group
calls.

It has been found that if CONFIG_LOCKDEP is enabled, then it appears to
be confused by the nesting inherent in the fragment semaphores used
by groups and the underlying subsystem.

This patch sets up a mechanism to use separate classes for the fragment
semaphores, in a similar way to that already in place to fix nesting
issues with the i_mutexes.

Cc: Joel Becker <jlbec@evilplan.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 fs/configfs/configfs_internal.h |  3 +++
 fs/configfs/dir.c               | 45 +++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index c0395363eab9..736c74ec4b7a 100644
--- a/fs/configfs/configfs_internal.h
+++ b/fs/configfs/configfs_internal.h
@@ -22,6 +22,9 @@ struct configfs_fragment {
 	atomic_t frag_count;
 	struct rw_semaphore frag_sem;
 	bool frag_dead;
+#ifdef CONFIG_LOCKDEP
+	int frag_depth;
+#endif
 };
 
 void put_fragment(struct configfs_fragment *);
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index d1f9d2632202..6ecd8961afc3 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -133,6 +133,41 @@ configfs_adjust_dir_dirent_depth_after_populate(struct configfs_dirent *sd)
 	sd->s_depth = -1;
 }
 
+/* fragment semaphore needs some lockdep handling */
+static struct lock_class_key default_frag_class[MAX_LOCK_DEPTH];
+
+/*
+ * Set the lockdep depth for a new fragment based on the parent frag depth.
+ * Called from register_subsystem() with NULL parent group to set root subsystem
+ * depth which defaults to 0 in a new fragment, and from register_group() with the
+ * parent group to set a new group fragment based on the parent fragment depth.
+ *
+ * Prevents lockdep getting upset on the unregister_group() call if it cannot
+ * understand the hierarchy of fragments.
+ */
+static void configfs_adjust_frag_depth(struct configfs_fragment *frag,
+				       struct config_group *parent_group)
+{
+	struct configfs_dirent *parent_dirent;
+
+	if (parent_group) {
+		// find parent frag
+		parent_dirent = parent_group->cg_item.ci_dentry->d_fsdata;
+		frag->frag_depth = parent_dirent->s_frag->frag_depth + 1;
+	}
+
+	if (frag->frag_depth < ARRAY_SIZE(default_frag_class)) {
+		lockdep_set_class(&frag->frag_sem,
+				  &default_frag_class[frag->frag_depth]);
+	} else {
+		/*
+		 * In practice the maximum level of locking depth is
+		 * already reached. Just inform about possible reasons.
+		 */
+		pr_info("Too many levels of fragments for the locking correctness validator.\n");
+	}
+}
+
 #else /* CONFIG_LOCKDEP */
 
 static void configfs_init_dirent_depth(struct configfs_dirent *sd)
@@ -154,6 +189,11 @@ configfs_adjust_dir_dirent_depth_after_populate(struct configfs_dirent *sd)
 {
 }
 
+static void configfs_adjust_frag_depth(struct configfs_fragment *frag,
+				       struct config_group *parent_group)
+{
+}
+
 #endif /* CONFIG_LOCKDEP */
 
 static struct configfs_fragment *new_fragment(void)
@@ -165,6 +205,9 @@ static struct configfs_fragment *new_fragment(void)
 		atomic_set(&p->frag_count, 1);
 		init_rwsem(&p->frag_sem);
 		p->frag_dead = false;
+#ifdef CONFIG_LOCKDEP
+		p->frag_depth = 0;
+#endif
 	}
 	return p;
 }
@@ -1742,6 +1785,7 @@ int configfs_register_group(struct config_group *parent_group,
 	parent = parent_group->cg_item.ci_dentry;
 
 	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
+	configfs_adjust_frag_depth(frag, parent_group);
 	ret = create_default_group(parent_group, group, frag);
 	if (ret)
 		goto err_out;
@@ -1872,6 +1916,7 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 	mutex_unlock(&configfs_subsystem_mutex);
 
 	inode_lock_nested(d_inode(root), I_MUTEX_PARENT);
+	configfs_adjust_frag_depth(frag, NULL);
 
 	err = -ENOMEM;
 	dentry = d_alloc_name(root, group->cg_item.ci_name);
-- 
2.17.1

