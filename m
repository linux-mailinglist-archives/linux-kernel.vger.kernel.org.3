Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53BE4DE4D0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 01:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241647AbiCSASI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 20:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiCSASG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 20:18:06 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4310C30A8BE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 17:16:47 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id x5-20020a637c05000000b003817f40e072so4035024pgc.17
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 17:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8kLMxs/CvqJZP0KCbxy42TuXckQwVilQVIyMYVLn0uY=;
        b=F+XzdVUPzB6Qc26IhOBE69o28h3KUC1mIIntciiBSN16f5Zu30B1nhsVBzQkgkxqER
         8YTzAhbFmtEiUqWJR+GHpfHSYoy5Z3NXa9rivOCVgtMCqFQISyLlEeV/QrA/t0RXlDYt
         3crVEvZt3bK2BWJG0sOdtdRTMDavbqjPTM7oTdOg6WWASczWA9nTBWiJq94R/SC+fzr/
         OKEf3RYLbZouPvrztTodm28GeVBvQGXtxhQ2CfqC/zCPvtsorHobvRBr0PzXANx5EBQo
         0sZcPuE4oVDCxmhikJvWaoeY+pilbeU3mgH+8llOnqJE8ThEt3hxnJGLCI/opc/Rxkqv
         8h1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8kLMxs/CvqJZP0KCbxy42TuXckQwVilQVIyMYVLn0uY=;
        b=DO9IQ0E4HIZUNw1rJPReaG2zRJNo30/qgbR3xtpHIY25PKgSlRipGvZZLWIHofIb15
         m7TZUR0DNmWCwj1n/RvuhoydsVVIbH2a5MwzwtOwDsg67HMumOGdEfXktAvsgpEi/yzp
         hMWbwD03dLOSl7/yadDpVa1zOkOrFXQd7mmOWVXV7k/aePko95TF+0B02N2H+RQefXtJ
         kQ6a121OGlAiekyZFrKp7IRpRNiA3I1/Mgr0a/yPXsCUQdysAKNI8a3d8rhnVPhe9qjm
         l83tdIdDY0pTUvBzXymmYz8CMtUyOw2git9XRbKwFToctg8/z91A0Z5W/qE0DwPLwCOn
         Pkjw==
X-Gm-Message-State: AOAM533OOxISPcUzKjQ5UutN76hzJxGF/plrIOuwNyzwhdLPiuWNraja
        D05Zu8JfEjB8zuQqTPvwH2ZBV/M/4VM=
X-Google-Smtp-Source: ABdhPJyw+5UCojVLuo2jkstLVsgWPSMq9PTXXa78BrdrS5rmZl+MtF4r1dvc4lwaR7/kd++jxGcD2lVXvho=
X-Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2cd:202:62b3:bbf6:1668:e469])
 (user=khazhy job=sendgmr) by 2002:a62:8c11:0:b0:4f6:e890:5be5 with SMTP id
 m17-20020a628c11000000b004f6e8905be5mr12629327pfd.19.1647649006753; Fri, 18
 Mar 2022 17:16:46 -0700 (PDT)
Date:   Fri, 18 Mar 2022 17:16:35 -0700
Message-Id: <20220319001635.4097742-1-khazhy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH RFC] nfsd: avoid recursive locking through fsnotify
From:   Khazhismel Kumykov <khazhy@google.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fsnotify_add_inode_mark may allocate with GFP_KERNEL, which may result
in recursing back into nfsd, resulting in deadlock. See below stack.

nfsd            D    0 1591536      2 0x80004080
Call Trace:
 __schedule+0x497/0x630
 schedule+0x67/0x90
 schedule_preempt_disabled+0xe/0x10
 __mutex_lock+0x347/0x4b0
 fsnotify_destroy_mark+0x22/0xa0
 nfsd_file_free+0x79/0xd0 [nfsd]
 nfsd_file_put_noref+0x7c/0x90 [nfsd]
 nfsd_file_lru_dispose+0x6d/0xa0 [nfsd]
 nfsd_file_lru_scan+0x57/0x80 [nfsd]
 do_shrink_slab+0x1f2/0x330
 shrink_slab+0x244/0x2f0
 shrink_node+0xd7/0x490
 do_try_to_free_pages+0x12f/0x3b0
 try_to_free_pages+0x43f/0x540
 __alloc_pages_slowpath+0x6ab/0x11c0
 __alloc_pages_nodemask+0x274/0x2c0
 alloc_slab_page+0x32/0x2e0
 new_slab+0xa6/0x8b0
 ___slab_alloc+0x34b/0x520
 kmem_cache_alloc+0x1c4/0x250
 fsnotify_add_mark_locked+0x18d/0x4c0
 fsnotify_add_mark+0x48/0x70
 nfsd_file_acquire+0x570/0x6f0 [nfsd]
 nfsd_read+0xa7/0x1c0 [nfsd]
 nfsd3_proc_read+0xc1/0x110 [nfsd]
 nfsd_dispatch+0xf7/0x240 [nfsd]
 svc_process_common+0x2f4/0x610 [sunrpc]
 svc_process+0xf9/0x110 [sunrpc]
 nfsd+0x10e/0x180 [nfsd]
 kthread+0x130/0x140
 ret_from_fork+0x35/0x40

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 fs/nfsd/filecache.c | 4 ++++
 1 file changed, 4 insertions(+)

Marking this RFC since I haven't actually had a chance to test this, we
we're seeing this deadlock for some customers.

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index fdf89fcf1a0c..a14760f9b486 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -121,6 +121,7 @@ nfsd_file_mark_find_or_create(struct nfsd_file *nf)
 	struct fsnotify_mark	*mark;
 	struct nfsd_file_mark	*nfm = NULL, *new;
 	struct inode *inode = nf->nf_inode;
+	unsigned int pflags;
 
 	do {
 		mutex_lock(&nfsd_file_fsnotify_group->mark_mutex);
@@ -149,7 +150,10 @@ nfsd_file_mark_find_or_create(struct nfsd_file *nf)
 		new->nfm_mark.mask = FS_ATTRIB|FS_DELETE_SELF;
 		refcount_set(&new->nfm_ref, 1);
 
+		/* fsnotify allocates, avoid recursion back into nfsd */
+		pflags = memalloc_nofs_save();
 		err = fsnotify_add_inode_mark(&new->nfm_mark, inode, 0);
+		memalloc_nofs_restore(pflags);
 
 		/*
 		 * If the add was successful, then return the object.
-- 
2.35.1.894.gb6a874cedc-goog

