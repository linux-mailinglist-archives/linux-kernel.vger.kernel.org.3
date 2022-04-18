Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B992505A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244614AbiDRPID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345393AbiDRPHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:07:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D438E1A6;
        Mon, 18 Apr 2022 06:59:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 527D01F75D;
        Mon, 18 Apr 2022 13:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650290374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KPeaGa1p82s2eYcsNFRY7rxYiJ/jMxjPDAxuhJ07BsU=;
        b=A13IgqmZyHKzM+crWTQFObajY7Z7rQ1XCDSx+f53UgTovUeOGHIBEBv9BGq/Z6nJosb1MG
        4WDddD9QfFL1m1ZCFZi1rgxK+fDjEMQx/vtMPm1VdXYXLf/wJhdjlSmL641JNycp/OJqO0
        ZG4w9Y5GkvB9kwuevQX4UT0EkDp/TUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650290374;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KPeaGa1p82s2eYcsNFRY7rxYiJ/jMxjPDAxuhJ07BsU=;
        b=hotTrITyhaslQ9exb3WDWbwSnGcDWIGWRE+MQv+m8sXkDjYDoRme0yk7Kk7YAqnDzcpbvL
        lrmLghpAx8vZlyCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF8C913A9B;
        Mon, 18 Apr 2022 13:59:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cNGjM8VuXWLiOwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 18 Apr 2022 13:59:33 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id c21201d9;
        Mon, 18 Apr 2022 13:59:58 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH v5 5/5] ceph: prevent snapshots to be created in encrypted locked directories
Date:   Mon, 18 Apr 2022 14:59:57 +0100
Message-Id: <20220418135957.12056-6-lhenriques@suse.de>
In-Reply-To: <20220418135957.12056-1-lhenriques@suse.de>
References: <20220418135957.12056-1-lhenriques@suse.de>
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

With snapshot names encryption we can not allow snapshots to be created in
locked directories because the names wouldn't be encrypted.  This patch
forces the directory to be unlocked to allow a snapshot to be created.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 fs/ceph/dir.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index f48f1ff20927..44b7114ca267 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1071,6 +1071,11 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 		err = -EDQUOT;
 		goto out;
 	}
+	if ((op == CEPH_MDS_OP_MKSNAP) && IS_ENCRYPTED(dir) &&
+	    !fscrypt_has_encryption_key(dir)) {
+		err = -ENOKEY;
+		goto out;
+	}
 
 
 	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
