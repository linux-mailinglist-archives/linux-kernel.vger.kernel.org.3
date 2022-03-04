Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0614CD8C6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240681AbiCDQOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240183AbiCDQOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:14:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F66157207;
        Fri,  4 Mar 2022 08:13:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 876C01F38A;
        Fri,  4 Mar 2022 16:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646410430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+3iB4IVSxvoxrgPRlS4xZegvmXLYHfk7btvgwcWOpvg=;
        b=d2jF9WrhG5m83dax3NIdFlMlkxldqtyWg/OF7qKs/faW68IEoGLltHId6bZgIl6BzLW2sz
        aD9bu/qz44Kar+SaM6Ei3G2zouTnpOZ0GvwolTfCQgd815vfJ8LOe86dyGETNblhAC8fMc
        u6zm6N/ciO6n/+Ub+9QOB1Q/HAbjiBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646410430;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+3iB4IVSxvoxrgPRlS4xZegvmXLYHfk7btvgwcWOpvg=;
        b=rJYkoa8Z8Nz0U6cYo52Y0FqpTFa1/XxmMOGsYj4KUxEIV7a8kQf9NqrNmiw2yWSJdDIrzS
        7hZmItE0lNSzSFDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1592C13B64;
        Fri,  4 Mar 2022 16:13:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cPRhAr46ImKeRAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 04 Mar 2022 16:13:50 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 8db641e2;
        Fri, 4 Mar 2022 16:14:04 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH 2/3] ceph: fix use-after-free in ceph_readdir
Date:   Fri,  4 Mar 2022 16:14:02 +0000
Message-Id: <20220304161403.19295-3-lhenriques@suse.de>
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

After calling ceph_mdsc_put_request() on dfi->last_readdir, this field
should be set to NULL, otherwise we may end-up freeing it twince and get
the following splat:

  refcount_t: underflow; use-after-free.
  WARNING: CPU: 0 PID: 229 at lib/refcount.c:28 refcount_warn_saturate+0xa6/0xf0
  ...
  Call Trace:
    <TASK>
    ceph_readdir+0xd35/0x1460 [ceph]
    ? _raw_spin_unlock+0x12/0x30
    ? preempt_count_add+0x73/0xa0
    ? _raw_spin_unlock+0x12/0x30
    ? __mark_inode_dirty+0x27c/0x3a0
    iterate_dir+0x7d/0x190
    __x64_sys_getdents64+0x80/0x120
    ? compat_fillonedir+0x160/0x160
    do_syscall_64+0x43/0x90
    entry_SYSCALL_64_after_hwframe+0x44/0xae

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 fs/ceph/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 0bcb677d2199..934402f5e9e6 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -555,6 +555,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			      le32_to_cpu(rde->inode.in->mode) >> 12)) {
 			dout("filldir stopping us...\n");
 			ceph_mdsc_put_request(dfi->last_readdir);
+			dfi->last_readdir = NULL;
 			err = 0;
 			goto out;
 		}
