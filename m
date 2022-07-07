Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609A7569989
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 06:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbiGGEwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 00:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbiGGEv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 00:51:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0802410F2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 21:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657169517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xsBdnThDwB5k2B2H7io6vmDOz7L77lpbiA9EsoyUbAY=;
        b=iqUYiFtho2eNvfdvRyf6rOoZpK980Gvss4K+csDb3JMGh/auonVdMKIJhi8tIokIhlIRsx
        mibzEPrR4kn7CXH9ZuSgw5jCIRvHdQlRnKqNds9ZK1KSrodTZXUY2DKvJaxy0zD6MJPfHD
        dyfoqU3bTtKz1UUvBvpSFC62yg/m+Kw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-odCE8rvUP9StKEDsL0Teog-1; Thu, 07 Jul 2022 00:51:53 -0400
X-MC-Unique: odCE8rvUP9StKEDsL0Teog-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 337988032EA;
        Thu,  7 Jul 2022 04:51:53 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3371218EC9;
        Thu,  7 Jul 2022 04:51:47 +0000 (UTC)
From:   xiubli@redhat.com
To:     dhowells@redhat.com, idryomov@gmail.com, jlayton@kernel.org
Cc:     marc.dionne@auristor.com, willy@infradead.org,
        keescook@chromium.org, kirill.shutemov@linux.intel.com,
        william.kucharski@oracle.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cachefs@redhat.com, vshankar@redhat.com,
        Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v3 2/2] afs: unlock the folio when vnode is marked deleted
Date:   Thu,  7 Jul 2022 12:51:12 +0800
Message-Id: <20220707045112.10177-3-xiubli@redhat.com>
In-Reply-To: <20220707045112.10177-1-xiubli@redhat.com>
References: <20220707045112.10177-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

The check_write_begin() should unlock the folio if return non-zero,
otherwise locked.

URL: https://tracker.ceph.com/issues/56423
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/afs/file.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index afacce797fb9..b23e7b5a48ad 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -379,7 +379,13 @@ static int afs_check_write_begin(struct file *file, loff_t pos, unsigned len,
 {
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
 
-	return test_bit(AFS_VNODE_DELETED, &vnode->flags) ? -ESTALE : 0;
+	if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
+		folio_unlock(*folio);
+		folio_put(*folio);
+		return -ESTALE;
+	}
+
+	return 0;
 }
 
 static void afs_free_request(struct netfs_io_request *rreq)
-- 
2.36.0.rc1

