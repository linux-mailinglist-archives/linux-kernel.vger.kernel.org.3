Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026DE595FB7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbiHPP5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236051AbiHPP4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:56:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374004F19D
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660665251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wc75QDZmoqU4tngYOXTJ1UEFnoUp6ValOTF1RnYHjOw=;
        b=Q4TNyYdW02EwXllU4sMfEAphJny0hhUP24avas/c41bghChKKm5OXfN7G/ouCZ6ucJE5ps
        fQYUvZ8mjijn37ARSsn/hmb9EZJtW8OP3qRbhoNK5wMb2mIHbCCbDtuc7WNpPzCuftpuTb
        l2MtDILPo8SZg79ev2laHqel/pN4PJk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-sDHnsVQsN6GOLHi8VONN6A-1; Tue, 16 Aug 2022 11:54:07 -0400
X-MC-Unique: sDHnsVQsN6GOLHi8VONN6A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F6643C025AF;
        Tue, 16 Aug 2022 15:54:07 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.32.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79CE32166B26;
        Tue, 16 Aug 2022 15:54:07 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, geraldsc@de.ibm.com
Subject: [PATCH] s390: fix double free of GS and RI CBs on fork() failure
Date:   Tue, 16 Aug 2022 11:54:07 -0400
Message-Id: <20220816155407.537372-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointers for guarded storage and runtime instrumentation control
blocks are stored in the thread_struct of the associated task. These
pointers are initially copied on fork() via arch_dup_task_struct()
and then cleared via copy_thread() before fork() returns. If fork()
happens to fail after the initial task dup and before copy_thread(),
the newly allocated task and associated thread_struct memory are
freed via free_task() -> arch_release_task_struct(). This results in
a double free of the guarded storage and runtime info structs
because the fields in the failed task still refer to memory
associated with the source task.

This problem can manifest as a BUG_ON() in set_freepointer() (with
CONFIG_SLAB_FREELIST_HARDENED enabled) or KASAN splat (if enabled)
when running trinity syscall fuzz tests on s390x. To avoid this
problem, clear the associated pointer fields in
arch_dup_task_struct() immediately after the new task is copied.
Note that the RI flag is still cleared in copy_thread() because it
resides in thread stack memory and that is where stack info is
copied.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---

Hi all,

Note that I'm not subscribed to the list so please CC on reply. Further,
I'm not terribly familiar with these associated features and so have not
run any kind of functional testing here. My testing was purely around
producing/preventing the double free issue. Any thoughts, reviews or
further testing is appreciated. Thanks.

Brian

 arch/s390/kernel/process.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 89949b9f3cf8..d5119e039d85 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -91,6 +91,18 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 
 	memcpy(dst, src, arch_task_struct_size);
 	dst->thread.fpu.regs = dst->thread.fpu.fprs;
+
+	/*
+	 * Don't transfer over the runtime instrumentation or the guarded
+	 * storage control block pointers. These fields are cleared here instead
+	 * of in copy_thread() to avoid premature freeing of associated memory
+	 * on fork() failure. Wait to clear the RI flag because ->stack still
+	 * refers to the source thread.
+	 */
+	dst->thread.ri_cb = NULL;
+	dst->thread.gs_cb = NULL;
+	dst->thread.gs_bc_cb = NULL;
+
 	return 0;
 }
 
@@ -150,13 +162,11 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	frame->childregs.flags = 0;
 	if (new_stackp)
 		frame->childregs.gprs[15] = new_stackp;
-
-	/* Don't copy runtime instrumentation info */
-	p->thread.ri_cb = NULL;
+	/*
+	 * Clear the runtime instrumentation flag after the above childregs
+	 * copy. The CB pointer was already cleared in arch_dup_task_struct().
+	 */
 	frame->childregs.psw.mask &= ~PSW_MASK_RI;
-	/* Don't copy guarded storage control block */
-	p->thread.gs_cb = NULL;
-	p->thread.gs_bc_cb = NULL;
 
 	/* Set a new TLS ?  */
 	if (clone_flags & CLONE_SETTLS) {
-- 
2.37.1

