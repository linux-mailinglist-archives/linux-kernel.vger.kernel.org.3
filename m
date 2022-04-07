Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413354F81EB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiDGOkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344087AbiDGOkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:40:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD5A163E3C;
        Thu,  7 Apr 2022 07:38:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B76DB1F85E;
        Thu,  7 Apr 2022 14:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649342292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CKo5P0+IINNApxT8SqgJZMHI5ahw3+NgqnnbLxnbVog=;
        b=tIY9qc2J9fjwaH10ymJNmn+4YDyXMySBNX8eumG7uD8wraF3k0qtU9onrc+TVhddI/fSwL
        qIOPPGGbaMlOVtRYn3L0HmmcqWag6SMysAD3yBfDyaz4KisjltNKrkjLWRw1NTcMQbKZ+I
        CP8S9YWrA4F97VtoUh9lscuYGVlvoJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649342292;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CKo5P0+IINNApxT8SqgJZMHI5ahw3+NgqnnbLxnbVog=;
        b=RK4YwKjrz/cHmy19x5GhR/8HDXwA60FHwKmK1ZNnmCw5Oqq4wL3iqXd1AqP34S+vgk04YD
        ncS0V/UMyTE+k/Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5177313485;
        Thu,  7 Apr 2022 14:38:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uk/0EFT3TmKdVwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 07 Apr 2022 14:38:12 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id c9aa668c;
        Thu, 7 Apr 2022 14:38:35 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH v3] ceph: invalidate pages when doing direct/sync writes
Date:   Thu,  7 Apr 2022 15:38:34 +0100
Message-Id: <20220407143834.7516-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing a direct/sync write, we need to invalidate the page cache in
the range being written to.  If we don't do this, the cache will include
invalid data as we just did a write that avoided the page cache.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 fs/ceph/file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

Ok, here's a new attempt.  After discussion in this thread and on IRC, I
think this is the right fix.  generic/647 now passes with and without
encryption.  Thanks!

Changes since v2:
- Invalidation needs to be done after a write

Changes since v1:
- Replaced truncate_inode_pages_range() by invalidate_inode_pages2_range
- Call fscache_invalidate with FSCACHE_INVAL_DIO_WRITE if we're doing DIO

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 5072570c2203..63e67eb60310 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1938,6 +1938,15 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 			break;
 		}
 		ceph_clear_error_write(ci);
+		ret = invalidate_inode_pages2_range(
+				inode->i_mapping,
+				pos >> PAGE_SHIFT,
+				(pos + len - 1) >> PAGE_SHIFT);
+		if (ret < 0) {
+			dout("invalidate_inode_pages2_range returned %d\n",
+			     ret);
+			ret = 0;
+		}
 		pos += len;
 		written += len;
 		dout("sync_write written %d\n", written);
