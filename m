Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90BA4E2720
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347619AbiCUNCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347628AbiCUNCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE4EE141D96
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647867666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vyCwznJa6TjTPjpCrpE02a2kKUtp5ybHGb6C5NGiBxo=;
        b=V6IT4pPwkYQCnodKXjGRo1f8SpHBU6jDdx3cQN94BHn6pIEdQFrxkt/Kb80QyZY+tq15Ml
        w9AyMdkLJ7hKMHQUaplK1Mc0q291N2bPfUe2JuWyKsWExpdw7b+ntOx6PWKUuPphswvDa7
        si+Iuff/f/eJawkdr5YFyAWOhldTtVk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-348-khI6kUuVOWm_Iwiqva_VUg-1; Mon, 21 Mar 2022 09:01:02 -0400
X-MC-Unique: khI6kUuVOWm_Iwiqva_VUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 247721066559;
        Mon, 21 Mar 2022 13:01:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C2B240CF8FB;
        Mon, 21 Mar 2022 13:01:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/2] watch_queue: Actually free the watch
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, fmdefrancesco@gmail.com, jannh@google.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 21 Mar 2022 13:00:59 +0000
Message-ID: <164786765966.1025645.8928727872789382885.stgit@warthog.procyon.org.uk>
In-Reply-To: <164786764630.1025645.12332376420230352947.stgit@warthog.procyon.org.uk>
References: <164786764630.1025645.12332376420230352947.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free_watch() does everything barring actually freeing the watch object.  Fix
this by adding the missing kfree.

kmemleak produces a report something like the following.  Note that as an
address can be seen in the first word, the watch would appear to have gone
through call_rcu().

BUG: memory leak
unreferenced object 0xffff88810ce4a200 (size 96):
  comm "syz-executor352", pid 3605, jiffies 4294947473 (age 13.720s)
  hex dump (first 32 bytes):
    e0 82 48 0d 81 88 ff ff 00 00 00 00 00 00 00 00  ..H.............
    80 a2 e4 0c 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8214e6cc>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8214e6cc>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8214e6cc>] keyctl_watch_key+0xec/0x2e0 security/keys/keyctl.c:1800
    [<ffffffff8214ec84>] __do_sys_keyctl+0x3c4/0x490 security/keys/keyctl.c:2016
    [<ffffffff84493a25>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84493a25>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

Fixes: c73be61cede5 ("pipe: Add general notification queue support")
Reported-and-tested-by: syzbot+6e2de48f06cdb2884bfc@syzkaller.appspotmail.com
Signed-off-by: David Howells <dhowells@redhat.com>
---

 kernel/watch_queue.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 5848d4795816..3990e4df3d7b 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -395,6 +395,7 @@ static void free_watch(struct rcu_head *rcu)
 	put_watch_queue(rcu_access_pointer(watch->queue));
 	atomic_dec(&watch->cred->user->nr_watches);
 	put_cred(watch->cred);
+	kfree(watch);
 }
 
 static void __put_watch(struct kref *kref)


