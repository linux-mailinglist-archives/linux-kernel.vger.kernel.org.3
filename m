Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847C258F1F6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 19:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiHJRwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 13:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHJRwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 13:52:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F8C61FCE5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 10:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660153971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vynGDAzc/6VQwrbleC01WhshW2l2/K6R2zJvHt1giME=;
        b=ChOykzv4qC69cXM7FulUXI39kW1NYXbFSlKOmYpH4cEd3akqB+DvlyIfV40bfRFJDNCPQX
        /IjqZZ1OY5kzb4VgHFkIOJQxvP9GM+WeGb9TwAOWwAIJFqPupTjZwtNTzJjqyfYN5PiUfX
        4HA5OyeiQ8lUkr6jWcqzcUVn+zSl1JY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-bOW-lwPdMP-zrDw_zKjyQg-1; Wed, 10 Aug 2022 13:52:49 -0400
X-MC-Unique: bOW-lwPdMP-zrDw_zKjyQg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62F8B3C0E225;
        Wed, 10 Aug 2022 17:52:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 714A7C15BA4;
        Wed, 10 Aug 2022 17:52:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, Matthew Wilcox (Oracle) <willy@infradead.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeff Layton <jlayton@kernel.org>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Enable multipage folio support
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <826906.1660153967.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 10 Aug 2022 18:52:47 +0100
Message-ID: <826907.1660153967@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Can you apply this please?  It enables multipage folios for afs.  Support =
has
already been implemented in netfslib, fscache and cachefiles and in most o=
f
afs, but I've waited for the VM side to stabilise.

Note that it does require a change to afs_write_begin() to return the corr=
ect
subpage.  This is a "temporary" change as we're working on getting rid of =
the
need for ->write_begin() and ->write_end() completely, at least as far as
network filesystems are concerned - but it doesn't prevent afs from making=
 use
of the capability.

Thanks,
David
---
Enable multipage folio support for the afs filesystem.  This makes use of
Matthew Wilcox's latest folio changes.

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Tested-by: kafs-testing@auristor.com
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/lkml/2274528.1645833226@warthog.procyon.org.=
uk/
---
 fs/afs/inode.c |    2 ++
 fs/afs/write.c |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 64dab70d4a4f..6d3a3dbe4928 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -104,12 +104,14 @@ static int afs_inode_init_from_status(struct afs_ope=
ration *op,
 		inode->i_op	=3D &afs_file_inode_operations;
 		inode->i_fop	=3D &afs_file_operations;
 		inode->i_mapping->a_ops	=3D &afs_file_aops;
+		mapping_set_large_folios(inode->i_mapping);
 		break;
 	case AFS_FTYPE_DIR:
 		inode->i_mode	=3D S_IFDIR |  (status->mode & S_IALLUGO);
 		inode->i_op	=3D &afs_dir_inode_operations;
 		inode->i_fop	=3D &afs_dir_file_operations;
 		inode->i_mapping->a_ops	=3D &afs_dir_aops;
+		mapping_set_large_folios(inode->i_mapping);
 		break;
 	case AFS_FTYPE_SYMLINK:
 		/* Symlinks with a mode of 0644 are actually mountpoints. */
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 2c885b22de34..9ebdd36eaf2f 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -91,7 +91,7 @@ int afs_write_begin(struct file *file, struct address_sp=
ace *mapping,
 			goto flush_conflicting_write;
 	}
 =

-	*_page =3D &folio->page;
+	*_page =3D folio_file_page(folio, pos / PAGE_SIZE);
 	_leave(" =3D 0");
 	return 0;
 =

