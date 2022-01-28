Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1C94A01D7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 21:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351132AbiA1U3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 15:29:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35101 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351145AbiA1U3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:29:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643401758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i+Eh88opqIqEsznXGNCa0iEdXEj8AF6KwI0Mv89OrFI=;
        b=XS7wg0RYrYKVk0r28/WSxGySKsDxCnGGFQuRKh16Qa0mgQQLkExCKmhzwUH3dT7yELHdaz
        VqHFQyN6E+v8vwK2o2qabZmYsiiWXIv2aMrb1mAnJHz0qPWEIkIop+iIbefyeKxC7MzHlm
        wfZnqqWJHxFMgYLfVpaY7eoyJ6WKfLs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-fLX-DTyNP1qVMuwgkPEdHw-1; Fri, 28 Jan 2022 15:29:14 -0500
X-MC-Unique: fLX-DTyNP1qVMuwgkPEdHw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 961E21006AA4;
        Fri, 28 Jan 2022 20:29:13 +0000 (UTC)
Received: from vbendel-laptop-2020.redhat.com (unknown [10.40.195.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C04075E26B;
        Fri, 28 Jan 2022 20:29:11 +0000 (UTC)
From:   vbendel@redhat.com
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     omosnace@redhat.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vratislav Bendel <vbendel@redhat.com>
Subject: [PATCH 2/3] selinux: fix double free of cond_list on error paths
Date:   Fri, 28 Jan 2022 21:28:57 +0100
Message-Id: <20220128202858.96935-3-vbendel@redhat.com>
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
the cond_list_destroy() gets called a second time in caller functions,
resulting in NULL pointer deref.
Fix this by resetting the cond_list_len to 0 in cond_list_destroy(),
making subsequent calls a noop.

Signed-off-by: Vratislav Bendel <vbendel@redhat.com>
---
 security/selinux/ss/conditional.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 1d0e5f326b62..8bc16ad3af9e 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -151,6 +151,8 @@ static void cond_list_destroy(struct policydb *p)
 
 	for (i = 0; i < p->cond_list_len; i++)
 		cond_node_destroy(&p->cond_list[i]);
+	p->cond_list_len = 0;
+
 	kfree(p->cond_list);
 	p->cond_list = NULL;
 }
-- 
2.26.3

