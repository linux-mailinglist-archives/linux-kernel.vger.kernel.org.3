Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEF852C41C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242514AbiERUWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242489AbiERUWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:22:19 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3F6B8BDA
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:22:16 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t11-20020a17090a6a0b00b001df6f318a8bso6681388pjj.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MgCA3HhvCAXdmpcrypetaNA0L9iEcnT799fYDKq1FeY=;
        b=eUyPQoUqfSD8xsDhA/B0vZLSwHoojYBvJnnLjVlugAxl3OcR1hp5mtTsL6x0DgAzjf
         ewwSD6kN9Pz8wGhV7maiFqWQ+njNzpaPjLGOjIl9tm8a5xMbSz1Eo1CnoLqJu+qkhpOE
         wQfEGMkesuPusTPpvsODQ3YOnyZkYPHvJPUu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MgCA3HhvCAXdmpcrypetaNA0L9iEcnT799fYDKq1FeY=;
        b=7nTvZJEmyf5UVAaU7uHFvHo3QODVFYh5zLA7Gckq7gHSm5A4Bo+orMnQj9S8m4r/O+
         WsSorAehTOtEyUeNGy19mQo9LioQRSd4vJdnPUcV+F2fFx9IU9BM4cNMQ5YznRaUl+WG
         K4tMAhvjtt6NKLAzk4cHMrkq2nW1hnn7VAtlxGYjNn23FAlsiL7KhSZjFAbcjKJXuWRN
         58GcmICAl0IpylUsoCF5H18W7hfULr+psKTdkZPx1lB6iBieBG355E353a8ntZtVU2dq
         wzR5FkzalRXeCOCCyOdHx7a5ZyEsyumrEbUK42SeJOa7L/kvOAMyacjQ0peSERPaRvaT
         V4Jw==
X-Gm-Message-State: AOAM532XzXB/1TLmgmG8VF6y505ib2jEHvnnolfW8ltKM+J9Pzsx7NIJ
        EutQtsL4TGcWXL5EpQAJR+VyQR9ormqKMA==
X-Google-Smtp-Source: ABdhPJznrLPyYbV5bbR8+4C6C1cVQu0Yq1fBrFhg67MPULK6ma0ssZNbmRiDeip1c6RHqNbq54OS2w==
X-Received: by 2002:a17:90b:4c48:b0:1dc:a631:e353 with SMTP id np8-20020a17090b4c4800b001dca631e353mr1217248pjb.218.1652905336439;
        Wed, 18 May 2022 13:22:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a18-20020a170902ecd200b0015e8d4eb1b6sm10837plh.0.2022.05.18.13.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:22:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Layton <jlayton@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Steve French <sfrench@samba.org>,
        William Kucharski <william.kucharski@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2] netfs: Use container_of() for offset casting
Date:   Wed, 18 May 2022 13:22:12 -0700
Message-Id: <20220518202212.2322058-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7332; h=from:subject; bh=qJGxhml2rFK2BJJgAS/PiywVQK/xYAr077qKmK7SVGo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBihVVzlUQF9SKJKoYvrOpMzfZ8CGJau/PDLX18DAD6 bCJQ1zqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYoVVcwAKCRCJcvTf3G3AJlOGD/ 9kStftzMAF20n6V/iNDvJkfn96gEB/daLj6GWvY57giVsimoJCLOI4v+zZOus/nBPo0qEEbNZgjvma gr49UkgcThdX7m8bzkZUdifBScyaaOSYgXSuwSBJsyfMeHQutcw8IuCSomLejuLb8temYWMOzs9Bvb 37J2FabV8XTmGRTVfMrtgpVio7W2ZlNc7X+j8u1UiSUgYfsLG3Xj4qZdXsVBBUZFOtYnIqd8lvYfDT qFhL1MY8PURQAmrQOLZ7P72DJo76E5OR5CaSvUU/7NS/wZ38ojRUZ6/5vxwUODS9CLbJS6UlnyK2Gq p18x4qwXVfW79GTyCDTSX3unMTIkonUQbvOe4HG6LbINLtv84zpDaRHGasJfUisifaz+7s2gx2MzIC ENd4cRmetR/pHomBvpa0v8peH9TiigpTEMS6x0seW87HoedV6wL3QO/vQhQ35h5iD4ytOA6dow4dQM qddyT1tV8P1h902HdPf6uzMR+SoCQJaYDRkiJuJTwqeL/Hc9L0Gv4DqT9YVkCsBUy39/3kn7KIhRWg cQDqgCrf/fgX8qvQo+mBN64MiWcQIZZqeMEYFuMLqBvqtzmjXeBRH/cm5DF5PhRNzkMcnbvUpHg+Wm vWqs0Zb1xlTfnJaSA6VMpeXxoq9bRLehaMLryh9eQbe8PbcxQLPJsU7VFGaw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While randstruct was satisfied with using an open-coded "void *" offset
cast for the netfs_i_context <-> inode casting, __builtin_object_size()
as used by FORTIFY_SOURCE was not as easily fooled. Switch to using
an internally defined netfs_i_context/inode struct for doing a full
container_of() casting. This keeps both randstruct and __bos() happy
under GCC 12. Silences:

In file included from ./include/linux/string.h:253,
                 from ./include/linux/ceph/ceph_debug.h:7,
                 from fs/ceph/inode.c:2:
In function ‘fortify_memset_chk’,
    inlined from ‘netfs_i_context_init’ at ./include/linux/netfs.h:326:2,
    inlined from ‘ceph_alloc_inode’ at fs/ceph/inode.c:463:2:
./include/linux/fortify-string.h:242:25: warning: call to ‘__write_overflow_field’ declared with attribute warning:
detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
  242 |                         __write_overflow_field(p_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Jeff Layton <jlayton@kernel.org>
Link: https://lore.kernel.org/lkml/d2ad3a3d7bdd794c6efb562d2f2b655fb67756b9.camel@kernel.org
Cc: Jeff Layton <jlayton@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20220517210230.864239-1-keescook@chromium.org
v2:
 - Add macro for keeping all netfs users on the same page
 - Update documentation and each netfs user
---
 Documentation/filesystems/netfs_library.rst | 12 ++++------
 fs/9p/v9fs.h                                |  7 ++----
 fs/afs/internal.h                           |  7 +-----
 fs/ceph/super.h                             |  7 ++----
 fs/cifs/cifsglob.h                          |  7 ++----
 include/linux/netfs.h                       | 26 +++++++++++++++++++--
 6 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index 69f00179fdfe..8024d442833e 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -43,15 +43,13 @@ structure is defined::
 	};
 
 A network filesystem that wants to use netfs lib must place one of these
-directly after the VFS ``struct inode`` it allocates, usually as part of its
-own struct.  This can be done in a way similar to the following::
+directly after the VFS ``struct inode`` it allocates, either by using
+``struct netfs_i_c_pair`` or by using the ``DECLARE_NETFS_INODE()`` helper,
+which arranges ``struct inode`` and ``struct netfs_i_context`` together
+without a struct namespace::
 
 	struct my_inode {
-		struct {
-			/* These must be contiguous */
-			struct inode		vfs_inode;
-			struct netfs_i_context  netfs_ctx;
-		};
+		DECLARE_NETFS_INODE(vfs_inode, netfs_ctx);
 		...
 	};
 
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index ec0e8df3b2eb..595add687ac6 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -109,11 +109,8 @@ struct v9fs_session_info {
 #define V9FS_INO_INVALID_ATTR 0x01
 
 struct v9fs_inode {
-	struct {
-		/* These must be contiguous */
-		struct inode	vfs_inode;	/* the VFS's inode record */
-		struct netfs_i_context netfs_ctx; /* Netfslib context */
-	};
+	/* the VFS's inode record and the Netfslib context */
+	DECLARE_NETFS_INODE(vfs_inode, netfs_ctx);
 	struct p9_qid qid;
 	unsigned int cache_validity;
 	struct p9_fid *writeback_fid;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 7b7ef945dc78..e2cb94196828 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -619,12 +619,7 @@ enum afs_lock_state {
  * leak from one inode to another.
  */
 struct afs_vnode {
-	struct {
-		/* These must be contiguous */
-		struct inode	vfs_inode;	/* the VFS's inode record */
-		struct netfs_i_context netfs_ctx; /* Netfslib context */
-	};
-
+	DECLARE_NETFS_INODE(vfs_inode, netfs_ctx); /* VFS inode and Netfslib context */
 	struct afs_volume	*volume;	/* volume on which vnode resides */
 	struct afs_fid		fid;		/* the file identifier for this inode */
 	struct afs_file_status	status;		/* AFS status info for this file */
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 20ceab74e871..7c36623bb42c 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -316,11 +316,8 @@ struct ceph_inode_xattrs_info {
  * Ceph inode.
  */
 struct ceph_inode_info {
-	struct {
-		/* These must be contiguous */
-		struct inode vfs_inode;
-		struct netfs_i_context netfs_ctx; /* Netfslib context */
-	};
+	/* the VFS's inode record and the Netfslib context */
+	DECLARE_NETFS_INODE(vfs_inode, netfs_ctx);
 	struct ceph_vino i_vino;   /* ceph ino + snap */
 
 	spinlock_t i_ceph_lock;
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 8de977c359b1..4a36dad99e32 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1405,11 +1405,8 @@ void cifsFileInfo_put(struct cifsFileInfo *cifs_file);
  */
 
 struct cifsInodeInfo {
-	struct {
-		/* These must be contiguous */
-		struct inode	vfs_inode;	/* the VFS's inode record */
-		struct netfs_i_context netfs_ctx; /* Netfslib context */
-	};
+	/* the VFS's inode record and the Netfslib context */
+	DECLARE_NETFS_INODE(vfs_inode, netfs_ctx);
 	bool can_cache_brlcks;
 	struct list_head llist;	/* locks helb by this inode */
 	/*
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 0c33b715cbfd..7facb11c9ac7 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -286,6 +286,28 @@ extern void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 				 bool was_async, enum netfs_sreq_ref_trace what);
 extern void netfs_stats_show(struct seq_file *);
 
+/*
+ * The struct netfs_i_context instance must always follow the VFS inode, so
+ * struct netfs_i_c_pair enforces this. However, netfs users may want to
+ * avoid a sub-struct namespace, so they can alternatively use the
+ * DECLARE_NETFS_INODE macro to provide an anonymous union/struct wrapper,
+ * allowing netfs internals to still correctly use container_of() against
+ * the struct netfs_i_c_pair for casting between vfs_inode and netfs_ctx.
+ */
+struct netfs_i_c_pair {
+	struct inode		vfs_inode;
+	struct netfs_i_context	netfs_ctx;
+};
+
+#define DECLARE_NETFS_INODE(_inode, _ctx)			\
+	union {							\
+		struct {					\
+			struct inode		_inode;		\
+			struct netfs_i_context	_ctx;		\
+		};						\
+		struct netfs_i_c_pair		netfs_inode;	\
+	}
+
 /**
  * netfs_i_context - Get the netfs inode context from the inode
  * @inode: The inode to query
@@ -295,7 +317,7 @@ extern void netfs_stats_show(struct seq_file *);
  */
 static inline struct netfs_i_context *netfs_i_context(struct inode *inode)
 {
-	return (void *)inode + sizeof(*inode);
+	return &container_of(inode, struct netfs_i_c_pair, vfs_inode)->netfs_ctx;
 }
 
 /**
@@ -307,7 +329,7 @@ static inline struct netfs_i_context *netfs_i_context(struct inode *inode)
  */
 static inline struct inode *netfs_inode(struct netfs_i_context *ctx)
 {
-	return (void *)ctx - sizeof(struct inode);
+	return &container_of(ctx, struct netfs_i_c_pair, netfs_ctx)->vfs_inode;
 }
 
 /**
-- 
2.32.0

