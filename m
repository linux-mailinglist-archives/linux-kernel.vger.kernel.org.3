Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF4E5A1996
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243251AbiHYTdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242525AbiHYTdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:33:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FCEB07EE
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 12:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661455990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EIdbfWd1sKX9JUPJDOOBAKIuprdL4FZ8A9NVF7O7IA4=;
        b=IVzMlPCL6sZUoV+UW1s3dgqnzZ+sZ2LlCgP7pm4q1OgR+lqPzfESndzpTk5CSH2wO0Br/v
        hpuMW3LuIQYuyMKuJvBaO7ISsIE7spmDcIH7C6FDysVFq2jAaECY2Er0aTa5tksoYJ/hMA
        z0maZJxAzezUJ9FQukqx9kl53Wba/EA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-jUpE9SspMOugMhkyE7h43w-1; Thu, 25 Aug 2022 15:33:06 -0400
X-MC-Unique: jUpE9SspMOugMhkyE7h43w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 463008032F6;
        Thu, 25 Aug 2022 19:33:06 +0000 (UTC)
Received: from madcap2.tricolour.com (unknown [10.22.48.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D87A492C3B;
        Thu, 25 Aug 2022 19:33:05 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>, omosnace@redhat.com
Subject: [PATCH ghak138 v2 3/4] audit: free audit_proctitle only on task exit
Date:   Thu, 25 Aug 2022 15:32:39 -0400
Message-Id: <c925257a4e99a76f8a8efef014a58ca7af40d537.1661449312.git.rgb@redhat.com>
In-Reply-To: <cover.1661449312.git.rgb@redhat.com>
References: <cover.1661449312.git.rgb@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since audit_proctitle is generated at syscall exit time, its value is
used immediately and cached for the next syscall.  Since this is the
case, then only clear it at task exit time.  Otherwise, there is no
point in caching the value OR bearing the overhead of regenerating it.

Fixes: 12c5e81d3fd0 ("audit: prepare audit_context for use in calling contexts beyond syscalls")
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/auditsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index d77c9805c6b1..280b4720c7a0 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1016,7 +1016,6 @@ static void audit_reset_context(struct audit_context *ctx)
 	WARN_ON(!list_empty(&ctx->killed_trees));
 	audit_free_module(ctx);
 	ctx->fds[0] = -1;
-	audit_proctitle_free(ctx);
 	ctx->type = 0; /* reset last for audit_free_*() */
 }
 
@@ -1077,6 +1076,7 @@ static inline void audit_free_context(struct audit_context *context)
 {
 	/* resetting is extra work, but it is likely just noise */
 	audit_reset_context(context);
+	audit_proctitle_free(context);
 	free_tree_refs(context);
 	kfree(context->filterkey);
 	kfree(context);
-- 
2.27.0

