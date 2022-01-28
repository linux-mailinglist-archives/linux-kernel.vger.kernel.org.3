Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EC34A01D3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 21:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351129AbiA1U3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 15:29:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20656 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346480AbiA1U3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643401753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6DOvcDg522mwUl70M+gghWC3MO+Q3R15lzpFJhyB6Lg=;
        b=RHtq+vuPs/vIf3KZmH263dPc+GH3BG+4ThUaY/oHncfSRfLJP+6HpJMrRqV9wZWcS8iOe2
        jH75djpuCiY1lWRf88754IPISahHLQEY3Leyl0MngxvtG7u95YbJXcu0e0NebbaY2OckaT
        XpRFNsD1yoIhho77Sx9BJ+YsX0OlAs4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-VpDf3GJ1MNSAFPVNtyDr9w-1; Fri, 28 Jan 2022 15:29:12 -0500
X-MC-Unique: VpDf3GJ1MNSAFPVNtyDr9w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48A973459B;
        Fri, 28 Jan 2022 20:29:11 +0000 (UTC)
Received: from vbendel-laptop-2020.redhat.com (unknown [10.40.195.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 765BC5E26B;
        Fri, 28 Jan 2022 20:29:09 +0000 (UTC)
From:   vbendel@redhat.com
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     omosnace@redhat.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vratislav Bendel <vbendel@redhat.com>
Subject: [PATCH 1/3] selinux: consistently clear cond_list on error paths
Date:   Fri, 28 Jan 2022 21:28:56 +0100
Message-Id: <20220128202858.96935-2-vbendel@redhat.com>
In-Reply-To: <20220128202858.96935-1-vbendel@redhat.com>
References: <20220128202858.96935-1-vbendel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vratislav Bendel <vbendel@redhat.com>

Currently there are two users of policydb->cond_list: cond_read_list()
and duplicate_policydb_cond_list(). On their error path one clears
->cond_list to NULL, but the other doesn't.
Make the behavior consistent by resetting ->cond_list to NULL in
cond_list_destroy(), which is called by both on the error path.

Signed-off-by: Vratislav Bendel <vbendel@redhat.com>
---
 security/selinux/ss/conditional.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 2ec6e5cd25d9..1d0e5f326b62 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -152,6 +152,7 @@ static void cond_list_destroy(struct policydb *p)
 	for (i = 0; i < p->cond_list_len; i++)
 		cond_node_destroy(&p->cond_list[i]);
 	kfree(p->cond_list);
+	p->cond_list = NULL;
 }
 
 void cond_policydb_destroy(struct policydb *p)
@@ -441,7 +442,6 @@ int cond_read_list(struct policydb *p, void *fp)
 	return 0;
 err:
 	cond_list_destroy(p);
-	p->cond_list = NULL;
 	return rc;
 }
 
-- 
2.26.3

