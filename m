Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5684E7943
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376993AbiCYQvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376979AbiCYQvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:51:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8BFC12C4;
        Fri, 25 Mar 2022 09:49:30 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2B58D1F38D;
        Fri, 25 Mar 2022 16:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648226969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6ivythEboEDbL7GPUWVELN/Jqdcen7CCuBCXMVaFSDQ=;
        b=dQjzWZf/421J0weNpwn9VYr6iqOVox3dhJuq7mBRiGWhM20NwS/n8X4GL/TfLi8tGzH4OS
        tE4o8gKIILZD3dsTIbkehKJy5YcbcRV7SgZUDxOnUqtIiIbZHdfpC/Sv6jmNrP14tJBzjU
        jJOuRBMFFLtsTl+Ha1JsIOlX/JPAdd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648226969;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6ivythEboEDbL7GPUWVELN/Jqdcen7CCuBCXMVaFSDQ=;
        b=j4eG4F/BjRwQEejDcI5RXqzomGXrEGN2SQgLJgqvO3kd6Du5DYYIbPBFlMWTK7S/ELtAzH
        b4If7RigS0rPcBDA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B49C31392B;
        Fri, 25 Mar 2022 16:49:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id LfP+KJjyPWJdQAAAGKfGzw
        (envelope-from <lhenriques@suse.de>); Fri, 25 Mar 2022 16:49:28 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 453f7812;
        Fri, 25 Mar 2022 16:49:49 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH] ceph: support legacy v1 encryption policy keysetup
Date:   Fri, 25 Mar 2022 16:49:47 +0000
Message-Id: <20220325164947.22062-1-lhenriques@suse.de>
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

fstests make use of legacy keysetup where the key description uses a
filesystem-specific prefix.  Add this ceph-specific prefix to the
fscrypt_operations data structure.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 fs/ceph/crypto.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index c2e28ae54323..2a8f95885e7d 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -77,6 +77,7 @@ static const union fscrypt_policy *ceph_get_dummy_policy(struct super_block *sb)
 }
 
 static struct fscrypt_operations ceph_fscrypt_ops = {
+	.key_prefix		= "ceph:",
 	.get_context		= ceph_crypt_get_context,
 	.set_context		= ceph_crypt_set_context,
 	.get_dummy_policy	= ceph_get_dummy_policy,
