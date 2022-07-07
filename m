Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8701D56A360
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbiGGNVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbiGGNVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:21:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 798A813D60
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 06:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657200111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OOBRD0wmr2rvfwmljryCiegH8fKKnPBuD2ipRfg+U4U=;
        b=ht4c4E+Mvqas3xM3yQFI/bbV/rYBSKbnceCWIu9T7xI22bFRDyDIqk7cpd5kIGg50HvpU8
        O1sf1zL98mIEaJd4LKdilJAxAtBEQz9UE5OQ0hj636YC92bxwgaq+SqFnExcmvKpx95WPP
        ztRq8KOZL7gk+T1dWqCqanRDTsDCIxg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-37mpEwMIMMyxmIa8w0AU5w-1; Thu, 07 Jul 2022 09:21:48 -0400
X-MC-Unique: 37mpEwMIMMyxmIa8w0AU5w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8415E85A582;
        Thu,  7 Jul 2022 13:21:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE4542166B29;
        Thu,  7 Jul 2022 13:21:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220707045112.10177-1-xiubli@redhat.com>
References: <20220707045112.10177-1-xiubli@redhat.com>
To:     xiubli@redhat.com
Cc:     dhowells@redhat.com, idryomov@gmail.com, jlayton@kernel.org,
        marc.dionne@auristor.com, willy@infradead.org,
        keescook@chromium.org, kirill.shutemov@linux.intel.com,
        william.kucharski@oracle.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cachefs@redhat.com, vshankar@redhat.com
Subject: [PATCH v4] netfs: do not unlock and put the folio twice
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2520850.1657200105.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 07 Jul 2022 14:21:45 +0100
Message-ID: <2520851.1657200105@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's my take on this.  I've made the error: path handle folio =3D=3D NUL=
L, so
you don't need to split that error case.  I've also changed
->check_write_begin() so that it returns 0, not -EAGAIN, if we drop the fo=
lio;
the process is retried then if the folio pointer got cleared.

As a result, you don't have to discard the page if you want to return an e=
rror
and thus don't need the additional afs patch

David
---
commit 8489c89f6a186272593ab5e3fffbd47ea21185b7
Author: Xiubo Li <xiubli@redhat.com>
Date:   Thu Jul 7 12:51:11 2022 +0800

    netfs: do not unlock and put the folio twice
    =

    check_write_begin() will unlock and put the folio when return
    non-zero.  So we should avoid unlocking and putting it twice in
    netfs layer.
    =

    Change the way ->check_write_begin() works in the following two ways:
    =

     (1) Pass it a pointer to the folio pointer, allowing it to unlock and=
 put
         the folio prior to doing the stuff it wants to do, provided it cl=
ears
         the folio pointer.
    =

     (2) Change the return values such that 0 with folio pointer set means
         continue, 0 with folio pointer cleared means re-get and all error
         codes indicating an error (no special treatment for -EAGAIN).
    =

    Link: https://tracker.ceph.com/issues/56423
    Link: https://lore.kernel.org/r/20220707045112.10177-2-xiubli@redhat.c=
om/
    Signed-off-by: Xiubo Li <xiubli@redhat.com>
    Co-developed-by: David Howells <dhowells@redhat.com>
    Signed-off-by: David Howells <dhowells@redhat.com>

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/f=
ilesystems/netfs_library.rst
index 4d19b19bcc08..89085e1c22db 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -301,7 +301,7 @@ through which it can issue requests and negotiate::
 		void (*issue_read)(struct netfs_io_subrequest *subreq);
 		bool (*is_still_valid)(struct netfs_io_request *rreq);
 		int (*check_write_begin)(struct file *file, loff_t pos, unsigned len,
-					 struct folio *folio, void **_fsdata);
+					 struct folio **_folio, void **_fsdata);
 		void (*done)(struct netfs_io_request *rreq);
 	};
 =

@@ -381,8 +381,10 @@ The operations are as follows:
    allocated/grabbed the folio to be modified to allow the filesystem to =
flush
    conflicting state before allowing it to be modified.
 =

-   It should return 0 if everything is now fine, -EAGAIN if the folio sho=
uld be
-   regrabbed and any other error code to abort the operation.
+   It may unlock and discard the folio it was given and set the caller's =
folio
+   pointer to NULL.  It should return 0 if everything is now fine (*_foli=
o
+   left set) or the op should be retried (*_folio cleared) and any other =
error
+   code to abort the operation.
 =

  * ``done``
 =

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 42118a4f3383..afacce797fb9 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -375,7 +375,7 @@ static int afs_begin_cache_operation(struct netfs_io_r=
equest *rreq)
 }
 =

 static int afs_check_write_begin(struct file *file, loff_t pos, unsigned =
len,
-				 struct folio *folio, void **_fsdata)
+				 struct folio **folio, void **_fsdata)
 {
 	struct afs_vnode *vnode =3D AFS_FS_I(file_inode(file));
 =

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 6dee88815491..ab070a24ca23 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -63,7 +63,7 @@
 	 (CONGESTION_ON_THRESH(congestion_kb) >> 2))
 =

 static int ceph_netfs_check_write_begin(struct file *file, loff_t pos, un=
signed int len,
-					struct folio *folio, void **_fsdata);
+					struct folio **folio, void **_fsdata);
 =

 static inline struct ceph_snap_context *page_snap_context(struct page *pa=
ge)
 {
@@ -1288,18 +1288,19 @@ ceph_find_incompatible(struct page *page)
 }
 =

 static int ceph_netfs_check_write_begin(struct file *file, loff_t pos, un=
signed int len,
-					struct folio *folio, void **_fsdata)
+					struct folio **folio, void **_fsdata)
 {
 	struct inode *inode =3D file_inode(file);
 	struct ceph_inode_info *ci =3D ceph_inode(inode);
 	struct ceph_snap_context *snapc;
 =

-	snapc =3D ceph_find_incompatible(folio_page(folio, 0));
+	snapc =3D ceph_find_incompatible(folio_page(*folio, 0));
 	if (snapc) {
 		int r;
 =

-		folio_unlock(folio);
-		folio_put(folio);
+		folio_unlock(*folio);
+		folio_put(*folio);
+		*folio =3D NULL;
 		if (IS_ERR(snapc))
 			return PTR_ERR(snapc);
 =

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 42f892c5712e..69bbf1c25cf4 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -319,8 +319,9 @@ static bool netfs_skip_folio_read(struct folio *folio,=
 loff_t pos, size_t len,
  * conflicting writes once the folio is grabbed and locked.  It is passed=
 a
  * pointer to the fsdata cookie that gets returned to the VM to be passed=
 to
  * write_end.  It is permitted to sleep.  It should return 0 if the reque=
st
- * should go ahead; unlock the folio and return -EAGAIN to cause the foli=
o to
- * be regot; or return an error.
+ * should go ahead or it may return an error.  It may also unlock and put=
 the
+ * folio, provided it sets *_folio to NULL, in which case a return of 0 w=
ill
+ * cause the folio to be re-got and the process to be retried.
  *
  * The calling netfs must initialise a netfs context contiguous to the vf=
s
  * inode before calling this.
@@ -348,13 +349,13 @@ int netfs_write_begin(struct netfs_inode *ctx,
 =

 	if (ctx->ops->check_write_begin) {
 		/* Allow the netfs (eg. ceph) to flush conflicts. */
-		ret =3D ctx->ops->check_write_begin(file, pos, len, folio, _fsdata);
+		ret =3D ctx->ops->check_write_begin(file, pos, len, &folio, _fsdata);
 		if (ret < 0) {
 			trace_netfs_failure(NULL, NULL, ret, netfs_fail_check_write_begin);
-			if (ret =3D=3D -EAGAIN)
-				goto retry;
 			goto error;
 		}
+		if (!folio)
+			goto retry;
 	}
 =

 	if (folio_test_uptodate(folio))
@@ -416,8 +417,10 @@ int netfs_write_begin(struct netfs_inode *ctx,
 error_put:
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_failed);
 error:
-	folio_unlock(folio);
-	folio_put(folio);
+	if (folio) {
+		folio_unlock(folio);
+		folio_put(folio);
+	}
 	_leave(" =3D %d", ret);
 	return ret;
 }
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 1773e5df8e65..6ab5d56dac74 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -214,7 +214,7 @@ struct netfs_request_ops {
 	void (*issue_read)(struct netfs_io_subrequest *subreq);
 	bool (*is_still_valid)(struct netfs_io_request *rreq);
 	int (*check_write_begin)(struct file *file, loff_t pos, unsigned len,
-				 struct folio *folio, void **_fsdata);
+				 struct folio **_folio, void **_fsdata);
 	void (*done)(struct netfs_io_request *rreq);
 };
 =

