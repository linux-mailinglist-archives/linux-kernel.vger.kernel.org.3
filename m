Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668E64EEE2D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346386AbiDANeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345975AbiDANeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:34:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B8227E84C;
        Fri,  1 Apr 2022 06:32:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 779F521605;
        Fri,  1 Apr 2022 13:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648819947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ABdU4ym8GUS4ocgC+XnqD1ou4OCW3BeFe0yT//Yc+oQ=;
        b=LhTvJZEXvpJhoHc/R4OxFi148eg/rq/J5JgLjVgcfRINUq7d0Tn5L4zkt2z8q7sPfWzXti
        o184B8ALGVXxyjOJenS7t46AUCxNf9wVZIv1CGzR9NsystVqhZeQgWvSnm33jCgVM5wP5v
        h6dZJ3AXeZQYmalX8S7BjlF/yr7uUGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648819947;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ABdU4ym8GUS4ocgC+XnqD1ou4OCW3BeFe0yT//Yc+oQ=;
        b=cbmek1fBuqR5pe/3fkJZ5B/WV0IXyHzbFx4NfXpniqSar6J8EOwZ8TdL+u02BKOSF/m+6x
        drNo/5FAZFTDwvCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0CCDE132C1;
        Fri,  1 Apr 2022 13:32:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mEIQAOv+RmJLWwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 01 Apr 2022 13:32:26 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id b980623e;
        Fri, 1 Apr 2022 13:32:44 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH v2] ceph: invalidate pages when doing DIO in encrypted inodes
Date:   Fri,  1 Apr 2022 14:32:43 +0100
Message-Id: <20220401133243.1075-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing DIO on an encrypted node, we need to invalidate the page cache in
the range being written to, otherwise the cache will include invalid data.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 fs/ceph/file.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

Changes since v1:
- Replaced truncate_inode_pages_range() by invalidate_inode_pages2_range
- Call fscache_invalidate with FSCACHE_INVAL_DIO_WRITE if we're doing DIO

Note: I'm not really sure this last change is required, it doesn't really
affect generic/647 result, but seems to be the most correct.

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 5072570c2203..b2743c342305 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1605,7 +1605,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 	if (ret < 0)
 		return ret;
 
-	ceph_fscache_invalidate(inode, false);
+	ceph_fscache_invalidate(inode, (iocb->ki_flags & IOCB_DIRECT));
 	ret = invalidate_inode_pages2_range(inode->i_mapping,
 					    pos >> PAGE_SHIFT,
 					    (pos + count - 1) >> PAGE_SHIFT);
@@ -1895,6 +1895,15 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 		req->r_inode = inode;
 		req->r_mtime = mtime;
 
+		if (IS_ENCRYPTED(inode) && (iocb->ki_flags & IOCB_DIRECT)) {
+			ret = invalidate_inode_pages2_range(
+				inode->i_mapping,
+				write_pos >> PAGE_SHIFT,
+				(write_pos + write_len - 1) >> PAGE_SHIFT);
+			if (ret < 0)
+				dout("invalidate_inode_pages2_range returned %d\n", ret);
+		}
+
 		/* Set up the assertion */
 		if (rmw) {
 			/*
