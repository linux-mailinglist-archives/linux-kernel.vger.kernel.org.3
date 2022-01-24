Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E994498458
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243273AbiAXQKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:10:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38065 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243549AbiAXQK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:10:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643040627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WdeMH8HK1q8ogzZ9caXmVPMv56FNH0sXWYlkWt7cOS8=;
        b=NRIo3/lJ0KosPeBjnZtlg9xT5XEiMjrInOOEV8AyKAeDuNzgsOBuAt8us5ASWY87O541CE
        QlSqgQsuTEwgDlxxLC8fMWRpJHyjXQbVHd/98BmLkgzvRAc//0Oo0kFoURgJDrDUgqPa7e
        syfqNilaN5nPZf645cmb4E1DE8GcNsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-Blr47l-gNX2DFlmCno7v8A-1; Mon, 24 Jan 2022 11:10:24 -0500
X-MC-Unique: Blr47l-gNX2DFlmCno7v8A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED96781DFAC;
        Mon, 24 Jan 2022 16:10:22 +0000 (UTC)
Received: from llong.com (unknown [10.22.35.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C4EB1091ED5;
        Mon, 24 Jan 2022 16:10:22 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2] vfs: Pre-allocate superblock in sget_fc() if !test
Date:   Mon, 24 Jan 2022 11:10:06 -0500
Message-Id: <20220124161006.141323-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the test function is not defined in sget_fc(), we always need
to allocate a new superblock. So there is no point in acquiring the
sb_lock twice in this case. Optimize the !test case by pre-allocating
the superblock first before acquring the lock.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index a6405d44d4ca..6601267f6fe0 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -520,6 +520,8 @@ struct super_block *sget_fc(struct fs_context *fc,
 	struct user_namespace *user_ns = fc->global ? &init_user_ns : fc->user_ns;
 	int err;
 
+	if (!test)
+		goto prealloc;
 retry:
 	spin_lock(&sb_lock);
 	if (test) {
@@ -530,6 +532,7 @@ struct super_block *sget_fc(struct fs_context *fc,
 	}
 	if (!s) {
 		spin_unlock(&sb_lock);
+prealloc:
 		s = alloc_super(fc->fs_type, fc->sb_flags, user_ns);
 		if (!s)
 			return ERR_PTR(-ENOMEM);
-- 
2.27.0

