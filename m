Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DA947328F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241359AbhLMQ5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:57:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37881 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241335AbhLMQ5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639414650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SB9pVU9twW4y0IFAeP6lCvm2GDocVWXcsHoWXwSrqTI=;
        b=Us5NPZM01ormO/hVJLf0/l1q/UIADXqjHjzLclH2iREsLIRUuICOLsnF/vt0jCq129/qUm
        AzspbT0RsaycKNgKh4wvSPNaFc0JN+gY98L7l5lY3bzfgcKlFgLobqYimm8OeYLGo80wdc
        3qteqICC1x0PPUQayI9lmL4MnirLNKU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-a4JSjOKlN7y8yyamOcB9vA-1; Mon, 13 Dec 2021 11:57:29 -0500
X-MC-Unique: a4JSjOKlN7y8yyamOcB9vA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C7D9101872C;
        Mon, 13 Dec 2021 16:57:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A026A752C4;
        Mon, 13 Dec 2021 16:57:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix mmap
From:   David Howells <dhowells@redhat.com>
To:     marc.dionne@auristor.com
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 13 Dec 2021 16:57:25 +0000
Message-ID: <163941464554.620822.14509008966840730864.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix afs_add_open_map() to check that the vnode isn't already on the list
when it adds it.  It's possible that afs_drop_open_mmap() decremented the
cb_nr_mmap counter, but hadn't yet got into the locked section to remove
it.

Also vnode->cb_mmap_link should be initialised, so fix that too.

Fixes: 6e0e99d58a65 ("afs: Fix mmap coherency vs 3rd-party changes")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
---

 fs/afs/file.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 572063dad0b3..bcda99dcfdec 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -539,8 +539,9 @@ static void afs_add_open_mmap(struct afs_vnode *vnode)
 	if (atomic_inc_return(&vnode->cb_nr_mmap) == 1) {
 		down_write(&vnode->volume->cell->fs_open_mmaps_lock);
 
-		list_add_tail(&vnode->cb_mmap_link,
-			      &vnode->volume->cell->fs_open_mmaps);
+		if (list_empty(&vnode->cb_mmap_link))
+			list_add_tail(&vnode->cb_mmap_link,
+				      &vnode->volume->cell->fs_open_mmaps);
 
 		up_write(&vnode->volume->cell->fs_open_mmaps_lock);
 	}


