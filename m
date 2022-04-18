Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32788505955
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 16:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345102AbiDROSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 10:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244924AbiDRN6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 09:58:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C31726D9;
        Mon, 18 Apr 2022 06:08:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D29A81F381;
        Mon, 18 Apr 2022 13:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650287293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iBYQm7Rp5LG8jKxerzOsfwWsTzE/H7NffrHSL2IyD+s=;
        b=TocHSoPX9e5EcicfNhzjUIFR8D2OXV/K3lKZJSWWVrMF+nTO7p7lqWZukGYiNMgRhCcI2S
        HJTiKL4rTD0OvGEQAOmlFBlwQU9KUgEqfF2NSk75WGi21Uhzu2sWGHOdZf5AjIbAxK3aiV
        lCTohJTbyaE21PBqte+yxlpTjKOPTik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650287293;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iBYQm7Rp5LG8jKxerzOsfwWsTzE/H7NffrHSL2IyD+s=;
        b=xGtN1dHwZEvL/X5HVK+Vrt3cgkkqhFrdYXZs9AO3qJxgafORU/jLMoBegjJTpsRHqcEzFE
        xlEstEnrU2eBGDAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68C5D13ACB;
        Mon, 18 Apr 2022 13:08:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Dj9SFr1iXWLcLwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 18 Apr 2022 13:08:13 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 150a3546;
        Mon, 18 Apr 2022 13:08:40 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH] ceph: prevent snapshots to be created in encrypted locked directories
Date:   Mon, 18 Apr 2022 14:08:39 +0100
Message-Id: <20220418130839.9862-1-lhenriques@suse.de>
In-Reply-To: <20220414135122.26821-1-lhenriques@suse.de>
References: <20220414135122.26821-1-lhenriques@suse.de>
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
 fs/ceph/dir.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index f48f1ff20927..93e2f08102a1 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1071,6 +1071,10 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 		err = -EDQUOT;
 		goto out;
 	}
+	if ((op == CEPH_MDS_OP_MKSNAP) && !fscrypt_has_encryption_key(dir)) {
+		err = -ENOKEY;
+		goto out;
+	}
 
 
 	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
