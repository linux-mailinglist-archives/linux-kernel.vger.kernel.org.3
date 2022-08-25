Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D054F5A1998
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243376AbiHYTdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242828AbiHYTdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:33:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C547B2491
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 12:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661455991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=spPaKdcJ4d7hVdg+DysF8A+ZluqEE+lejEA2QmWo0UM=;
        b=eJHd5f0DozwdCaZmW/dIJ4iwOlcFvO2dngu3A67fyRrarIqFm+PwQoQnpTc6EkdD1DyVG0
        e8fOwBYlvhzTZpwP4jgXi5Znn8GPcl9AZpk/YPm4JXnjWOo83riF9PGEMvMvJ2lKmfvyee
        QMqrmySP7tWUwnoeBVepbRooeQXQOBE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-K_7iAb7zOhyThQcg6ypqhA-1; Thu, 25 Aug 2022 15:33:08 -0400
X-MC-Unique: K_7iAb7zOhyThQcg6ypqhA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C17631818341;
        Thu, 25 Aug 2022 19:33:07 +0000 (UTC)
Received: from madcap2.tricolour.com (unknown [10.22.48.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7988B492C3B;
        Thu, 25 Aug 2022 19:33:06 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>, scorreia@redhat.com,
        omosnace@redhat.com, omoris@redhat.com
Subject: [PATCH ghak138 v2 4/4] audit: move audit_return_fixup before the filters
Date:   Thu, 25 Aug 2022 15:32:40 -0400
Message-Id: <0129ccc2378a772a7c38090ce2cea0fda44c8479.1661449312.git.rgb@redhat.com>
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

The success and return_code are needed by the filters.  Move
audit_return_fixup() before the filters.  This was causing syscall
auditing events to be missed.

Link: https://github.com/linux-audit/audit-kernel/issues/138
Fixes: 12c5e81d3fd0 ("audit: prepare audit_context for use in calling contexts beyond syscalls")
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/auditsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 280b4720c7a0..9f8c05228d6d 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1940,6 +1940,7 @@ void __audit_uring_exit(int success, long code)
 		goto out;
 	}
 
+	audit_return_fixup(ctx, success, code);
 	if (ctx->context == AUDIT_CTX_SYSCALL) {
 		/*
 		 * NOTE: See the note in __audit_uring_entry() about the case
@@ -1981,7 +1982,6 @@ void __audit_uring_exit(int success, long code)
 	audit_filter_inodes(current, ctx);
 	if (ctx->current_state != AUDIT_STATE_RECORD)
 		goto out;
-	audit_return_fixup(ctx, success, code);
 	audit_log_exit();
 
 out:
@@ -2065,13 +2065,13 @@ void __audit_syscall_exit(int success, long return_code)
 	if (!list_empty(&context->killed_trees))
 		audit_kill_trees(context);
 
+	audit_return_fixup(context, success, return_code);
 	/* run through both filters to ensure we set the filterkey properly */
 	audit_filter_syscall(current, context);
 	audit_filter_inodes(current, context);
 	if (context->current_state != AUDIT_STATE_RECORD)
 		goto out;
 
-	audit_return_fixup(context, success, return_code);
 	audit_log_exit();
 
 out:
-- 
2.27.0

