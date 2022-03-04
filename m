Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEED4CD8CC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240671AbiCDQOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbiCDQOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:14:39 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBBA15721B;
        Fri,  4 Mar 2022 08:13:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0E42C2113B;
        Fri,  4 Mar 2022 16:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646410430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2i3AYvAIrrLAz95RlVXW6R4/R4Sbs8yHQrijZ34iSgc=;
        b=AwGhhe4mSRmtgOqAPc7fMj+CmV/osuW6LDMZE7EO2GA8wlXq4o13/FqTWRK//v02rUEMh7
        RNEOKkdciOz2YEbkNCe3Hx2HxVf4AieVhOd9COx7VxGB4Z0WxnJbyfjrmdM4izIJNkZDy6
        KvRz4+V4Dy2mbRLYhYJWg+S4c0Ifii0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646410430;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2i3AYvAIrrLAz95RlVXW6R4/R4Sbs8yHQrijZ34iSgc=;
        b=MWkcjt9wUo7c3YglXgAytNenhUmIQ/zXfq63zYf1tSG4uEEssYvjMtr1ljuSaU/MgKngwE
        sLUsFj2pWvBHZaAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9155A13B64;
        Fri,  4 Mar 2022 16:13:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qOWhIL06ImKeRAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 04 Mar 2022 16:13:49 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 378d5cce;
        Fri, 4 Mar 2022 16:14:04 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH 1/3] ceph: fix error path in ceph_readdir()
Date:   Fri,  4 Mar 2022 16:14:01 +0000
Message-Id: <20220304161403.19295-2-lhenriques@suse.de>
In-Reply-To: <20220304161403.19295-1-lhenriques@suse.de>
References: <20220304161403.19295-1-lhenriques@suse.de>
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

This was introduced by commit

  "ceph: add support to readdir for encrypted filenames"

It will eventually leak the fscrypt_str names in this error path.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 fs/ceph/dir.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 44395aae7259..0bcb677d2199 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -500,7 +500,6 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 					       next_offset);
 			if (err) {
 				ceph_mdsc_put_request(dfi->last_readdir);
-				return err;
 				goto out;
 			}
 		} else if (req->r_reply_info.dir_end) {
