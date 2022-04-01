Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20234EEC73
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 13:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345560AbiDALjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 07:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbiDALjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 07:39:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDA21D7DB1;
        Fri,  1 Apr 2022 04:38:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E235521A91;
        Fri,  1 Apr 2022 11:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648813080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=LAYvz0hJSPWBWZb7wY9ZS6Pxs0R0ipWo+Er9FVtXgGs=;
        b=T7PCMC5IwEpXOrp3gNwYDyC2GaJwgBQTaLvY+QPCpmAjzg4P78kD8ngCrlqpzDoMqu1D6n
        vxAL0XtXAi/oDEPr8sn7oY4Lgk5tlbpcKDHFpHLNMuMW26xMXC2Wpfet4pZdtoYDzI/kLh
        VFAlGG6+8bVKOeUCTsrYxN2DZs0h4Lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648813080;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=LAYvz0hJSPWBWZb7wY9ZS6Pxs0R0ipWo+Er9FVtXgGs=;
        b=L+phv4ITqea8XFzQrAHlKewz37vEdvAUQ5yB+MwLpk4TyusSHcEbhyaw9gw9CrhGrJjry4
        /4gyP1vUlkcZTPCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 787F81331E;
        Fri,  1 Apr 2022 11:38:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QYZYGhjkRmL4HgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 01 Apr 2022 11:38:00 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 41960ec0;
        Fri, 1 Apr 2022 11:38:22 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH] ceph: truncate page cache when doing DIO in encrypted inodes
Date:   Fri,  1 Apr 2022 12:38:22 +0100
Message-Id: <20220401113822.32545-1-lhenriques@suse.de>
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

When doing DIO on an encrypted node, we need to truncate the page cache in
the range being written to, otherwise the cache will include invalid data.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 fs/ceph/file.c | 5 +++++
 1 file changed, 5 insertions(+)

This patch should fix generic/647 fstest when run with test_dummy_encryption.

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 5072570c2203..0f31c4d352a4 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1895,6 +1895,11 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 		req->r_inode = inode;
 		req->r_mtime = mtime;
 
+		if (IS_ENCRYPTED(inode) && (iocb->ki_flags & IOCB_DIRECT))
+			truncate_inode_pages_range(
+				inode->i_mapping, write_pos,
+				PAGE_ALIGN(write_pos + write_len) - 1);
+
 		/* Set up the assertion */
 		if (rmw) {
 			/*
