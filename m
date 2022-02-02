Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7C64A6FE6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343904AbiBBLZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:25:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47876 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232773AbiBBLZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643801133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=f9ysAxbXC0GSfw703DH/tdETiMeXJAtzyEW9vX7rENo=;
        b=J5U57MLYfM0Q/WW0prKLDCzOZ+qDeEi8YHxmFrJ0rCHrvjIwVdm4u7y5TzP6xqhOhG2gZ8
        d0e4EMnOkOar0WCoxSIIddH6Wsk+s5EqBGcoxGmllNOIA4f3Uobn63KF0jqsj52Yn9+ilI
        J+59Q4zrMX/haez2BJA+R2AEp790YQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-245-t6Tzd3unPO2X-ga9Grp-sw-1; Wed, 02 Feb 2022 06:25:30 -0500
X-MC-Unique: t6Tzd3unPO2X-ga9Grp-sw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD98086A8A0;
        Wed,  2 Feb 2022 11:25:28 +0000 (UTC)
Received: from vbendel-laptop-2020.redhat.com (unknown [10.40.193.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF4CD7BB69;
        Wed,  2 Feb 2022 11:25:25 +0000 (UTC)
From:   vbendel@redhat.com
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     omosnace@redhat.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vratislav Bendel <vbendel@redhat.com>
Subject: [PATCH v2] selinux: fix double free of cond_list on error paths
Date:   Wed,  2 Feb 2022 12:25:11 +0100
Message-Id: <20220202112511.18010-1-vbendel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vratislav Bendel <vbendel@redhat.com>

On error path from cond_read_list() and duplicate_policydb_cond_list()
the cond_list_destroy() gets called a second time in caller functions,
resulting in NULL pointer deref.
Fix this by resetting the cond_list_len to 0 in cond_list_destroy(),
making subsequent calls a noop.

Also consistently reset the cond_list pointer to NULL after freeing.

Signed-off-by: Vratislav Bendel <vbendel@redhat.com>
---
 security/selinux/ss/conditional.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 2ec6e5cd25d9..feb206f3acb4 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -152,6 +152,8 @@ static void cond_list_destroy(struct policydb *p)
 	for (i = 0; i < p->cond_list_len; i++)
 		cond_node_destroy(&p->cond_list[i]);
 	kfree(p->cond_list);
+	p->cond_list = NULL;
+	p->cond_list_len = 0;
 }
 
 void cond_policydb_destroy(struct policydb *p)
@@ -441,7 +443,6 @@ int cond_read_list(struct policydb *p, void *fp)
 	return 0;
 err:
 	cond_list_destroy(p);
-	p->cond_list = NULL;
 	return rc;
 }
 
-- 
2.26.3

