Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274AA5A1994
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243132AbiHYTdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiHYTdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:33:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F246B07EE
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 12:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661455987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eprgBqGlrPpTd92Aq6TLTj4xk0I2DQyl18wu2vfVrwU=;
        b=iAiAFNUJWDxDCBpPGt3onqPa8rCS4rgYfQdWiDDuoRkO1QKuGfpg+LbxrrneeNrBdNTn4S
        DUvXnPadXqH5cs3Lb2A4UjtRsWDIbgKzetl0O8OAuDGR3apTtwPiUpd1eJzrD04RxPWu4c
        ok2RRVWpJnyxzd0DUSEh+WrdJuYqiKY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-5tuGEuiuPA2FR80LyPxb0w-1; Thu, 25 Aug 2022 15:33:04 -0400
X-MC-Unique: 5tuGEuiuPA2FR80LyPxb0w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 833D080231E;
        Thu, 25 Aug 2022 19:33:03 +0000 (UTC)
Received: from madcap2.tricolour.com (unknown [10.22.48.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C997492CA2;
        Thu, 25 Aug 2022 19:33:02 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak138 v2 1/4] audit: audit_context pid unused, context enum comment fix
Date:   Thu, 25 Aug 2022 15:32:37 -0400
Message-Id: <f3653c1aebf95d206b0bcbdf59afe2498520cff2.1661449312.git.rgb@redhat.com>
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

The pid member of struct audit_context is never used.  Remove it.

The audit_reset_context() comment about unconditionally resetting
"ctx->state" should read "ctx->context".

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/audit.h   | 2 +-
 kernel/auditsc.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 58b66543b4d5..d6eb7b59c791 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -133,7 +133,7 @@ struct audit_context {
 	struct sockaddr_storage *sockaddr;
 	size_t sockaddr_len;
 				/* Save things to print about task_struct */
-	pid_t		    pid, ppid;
+	pid_t		    ppid;
 	kuid_t		    uid, euid, suid, fsuid;
 	kgid_t		    gid, egid, sgid, fsgid;
 	unsigned long	    personality;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 9226746dcf0a..21e50e6d0fc0 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -965,7 +965,7 @@ static void audit_reset_context(struct audit_context *ctx)
 	if (!ctx)
 		return;
 
-	/* if ctx is non-null, reset the "ctx->state" regardless */
+	/* if ctx is non-null, reset the "ctx->context" regardless */
 	ctx->context = AUDIT_CTX_UNUSED;
 	if (ctx->dummy)
 		return;
@@ -1002,7 +1002,7 @@ static void audit_reset_context(struct audit_context *ctx)
 	kfree(ctx->sockaddr);
 	ctx->sockaddr = NULL;
 	ctx->sockaddr_len = 0;
-	ctx->pid = ctx->ppid = 0;
+	ctx->ppid = 0;
 	ctx->uid = ctx->euid = ctx->suid = ctx->fsuid = KUIDT_INIT(0);
 	ctx->gid = ctx->egid = ctx->sgid = ctx->fsgid = KGIDT_INIT(0);
 	ctx->personality = 0;
-- 
2.27.0

