Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E784A01D8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 21:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351185AbiA1U3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 15:29:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24813 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351175AbiA1U3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643401760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tcZWR2ltT9IDLZDOmiJU7QFW5/KRxJtDJKHmdv9rpsw=;
        b=LIYRhzGQMO93ZX1yRXV9S93Dhbv7WokfbQT7eE2P5U26vRjWjt5x6JinzgRb8XYvfpMV0T
        Q3OxRQ8JuRsINc3+TbmRo44ChbqTLT/0Hx4/DYhKuQa2kQa2DtEAWsIPkSbYzWtFQDTemz
        dFgktNeaD/E7KpgdHe42fRaQ+uu8jW0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-DMWCd-ppN0i23JUeM4LERA-1; Fri, 28 Jan 2022 15:29:17 -0500
X-MC-Unique: DMWCd-ppN0i23JUeM4LERA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4DAC190B2A0;
        Fri, 28 Jan 2022 20:29:15 +0000 (UTC)
Received: from vbendel-laptop-2020.redhat.com (unknown [10.40.195.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4C395E26B;
        Fri, 28 Jan 2022 20:29:13 +0000 (UTC)
From:   vbendel@redhat.com
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     omosnace@redhat.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vratislav Bendel <vbendel@redhat.com>
Subject: [PATCH 3/3] selinux: remove duplicate cond_list clean up calls
Date:   Fri, 28 Jan 2022 21:28:58 +0100
Message-Id: <20220128202858.96935-4-vbendel@redhat.com>
In-Reply-To: <20220128202858.96935-1-vbendel@redhat.com>
References: <20220128202858.96935-1-vbendel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vratislav Bendel <vbendel@redhat.com>

On error path from cond_read_list() and duplicate_policydb_cond_list()
the *_destroy() functions get called a second time in caller functions.
Remove the first calls and let the callers clean it.

Suggested-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Vratislav Bendel <vbendel@redhat.com>
---
 security/selinux/ss/conditional.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 8bc16ad3af9e..c333daaeceab 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -432,19 +432,16 @@ int cond_read_list(struct policydb *p, void *fp)
 
 	rc = avtab_alloc(&(p->te_cond_avtab), p->te_avtab.nel);
 	if (rc)
-		goto err;
+		return rc;
 
 	p->cond_list_len = len;
 
 	for (i = 0; i < len; i++) {
 		rc = cond_read_node(p, &p->cond_list[i], fp);
 		if (rc)
-			goto err;
+			return rc;
 	}
 	return 0;
-err:
-	cond_list_destroy(p);
-	return rc;
 }
 
 int cond_write_bool(void *vkey, void *datum, void *ptr)
@@ -643,7 +640,7 @@ static int duplicate_policydb_cond_list(struct policydb *newp,
 				sizeof(*newp->cond_list),
 				GFP_KERNEL);
 	if (!newp->cond_list)
-		goto error;
+		return -ENOMEM;
 
 	for (i = 0; i < origp->cond_list_len; i++) {
 		struct cond_node *newn = &newp->cond_list[i];
@@ -656,27 +653,22 @@ static int duplicate_policydb_cond_list(struct policydb *newp,
 				orign->expr.len * sizeof(*orign->expr.nodes),
 				GFP_KERNEL);
 		if (!newn->expr.nodes)
-			goto error;
+			return -ENOMEM;
 
 		newn->expr.len = orign->expr.len;
 
 		rc = cond_dup_av_list(&newn->true_list, &orign->true_list,
 				&newp->te_cond_avtab);
 		if (rc)
-			goto error;
+			return rc;
 
 		rc = cond_dup_av_list(&newn->false_list, &orign->false_list,
 				&newp->te_cond_avtab);
 		if (rc)
-			goto error;
+			return rc;
 	}
 
 	return 0;
-
-error:
-	avtab_destroy(&newp->te_cond_avtab);
-	cond_list_destroy(newp);
-	return -ENOMEM;
 }
 
 static int cond_bools_destroy(void *key, void *datum, void *args)
-- 
2.26.3

