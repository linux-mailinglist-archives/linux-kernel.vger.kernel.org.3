Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BEB50A8BE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391764AbiDUTJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391759AbiDUTI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:08:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B6354C792
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650567962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rCckTxEGpZ1EVMsAo2ha3TZ2uY37q9vb0mlqr9I+LWs=;
        b=FB5Tb6boPNqXUKYuHnZpGLu6z8cC9qudBf/Tkg0Y6aGpO2nXuIZ1rCcAUgN5e1DNOyyHSg
        OMvbdETlAnKmuI0OszGBMAB9AEk8eZfpUSwFEHyQ6N3ksH2Ua8XE4WaEWJE4+mG7iAO2ec
        3V5BKxKkI0J0FmH66+HpMwSYaGz+n+U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-RCwAzGfcNrObe1TDu-_vuA-1; Thu, 21 Apr 2022 15:05:53 -0400
X-MC-Unique: RCwAzGfcNrObe1TDu-_vuA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61D49811E9B;
        Thu, 21 Apr 2022 19:05:50 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.22.16.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04D7EC27E81;
        Thu, 21 Apr 2022 19:05:48 +0000 (UTC)
From:   Nico Pache <npache@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [RFC 3/3] exit: Check for MMF_OOM_SKIP in exit_mmap
Date:   Thu, 21 Apr 2022 15:05:33 -0400
Message-Id: <20220421190533.1601879-4-npache@redhat.com>
In-Reply-To: <20220421190533.1601879-1-npache@redhat.com>
References: <20220421190533.1601879-1-npache@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MMF_OOM_SKIP bit is used to indicate weather a mm_struct can not be
invalided or has already been invalided. exit_mmap currently calls
__oom_reap_task_mm unconditionally despite the fact that the oom reaper
may have already called this.

Add a check for the MMF_OOM_SKIP bit being set in exit_mmap to avoid
unnessary calls to the invalidate code.

A slight race can occur on the MMF_OOM_SKIP bit that will still allow
this to run twice. My testing has shown an ~66% decrease in double calls
to _oom_reap_task_mm.

Fixes: 27ae357fa82b ("mm, oom: fix concurrent munlock and oom reaper unmap, v3")
Cc: David Rientjes <rientjes@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/mmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index a2968669fd4e..b867f408dacd 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3113,7 +3113,8 @@ void exit_mmap(struct mm_struct *mm)
 	/* mm's last user has gone, and its about to be pulled down */
 	mmu_notifier_release(mm);
 
-	if (unlikely(mm_is_oom_victim(mm))) {
+	if (unlikely(mm_is_oom_victim(mm)) &&
+			!test_bit(MMF_OOM_SKIP, &mm->flags)) {
 		/*
 		 * Manually reap the mm to free as much memory as possible.
 		 * Then, as the oom reaper does, set MMF_OOM_SKIP to disregard
-- 
2.35.1

