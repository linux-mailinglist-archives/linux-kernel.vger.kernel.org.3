Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501805AC306
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 08:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiIDGjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 02:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiIDGjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 02:39:51 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD881A80C
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 23:39:50 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id A62A7C009; Sun,  4 Sep 2022 08:39:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1662273588; bh=miYzyZXO3Y9mE5VTAs4cy8zeo4mpViTAUsvFYJlZovY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HLsVLhsvfAK+Wa4HgqxkYpMZUKdE/yIGIs5qxTKzKWVyGhllrceb1lZpGeTVV4qU6
         +nnx/vkDs8XRjtPrxn2ngpF/G90UMiSLCNzaR5t3+tB74FXWqyQop1IvEQ9tVxlnbv
         WielN1vgColAi6E5UXJrrcBYMNWo9P4TPBXqd6iU6o5R50Pt6JZcaj21RrY4F85kZZ
         EHcHsW9j2zaYeu6pHkbfqSegL29A13Bn6MGmUhJD9PcoiUVuJgVjRLVVMMB3zTUSKf
         bDCAzJu+jwFnXEk572iNU5PUKrsgTD4RmFEQOANZ6cIynhdjQRAkz2decemK9sNMCB
         NHr45TspgHPug==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 0F923C009;
        Sun,  4 Sep 2022 08:39:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1662273587; bh=miYzyZXO3Y9mE5VTAs4cy8zeo4mpViTAUsvFYJlZovY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DGpImAY0Y2wqk+H5bmyNEk7jt/o3t71V9PIu6k2XfSjaRGl9hb0WIBcziFV9kWTi3
         um6DzOh6+ND0BmALDVyKTrMS9WmGTOKnzsgGn77Y2KluxB16+mNf8nzgauYS11OEKt
         1Vj4Dce8MhlckP9EEnpJt/TxSxicPR9xAs6NmC2bXcM8Hl9RMO54CQqYZkWbH85Tia
         LYCiMvAa2F9VF6BG8TuMQy/fnS3mdxABhcnVHtLX6Pexyr8QE8pP5206AP6HQ7I4Lb
         YnukwnDcgHXB5RdNUPKRfUWWDJaMMnzIkaYOztVfnYkRSWCMMfmOI6AFmfhcgnCMUM
         wT4bFHe+KZE+A==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 2cbbbc34;
        Sun, 4 Sep 2022 06:39:43 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net
Cc:     syzkaller-bugs@googlegroups.com, linux_oss@crudebyte.com,
        linux-kernel@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>,
        syzbot+de52531662ebb8823b26@syzkaller.appspotmail.com
Subject: [PATCH 1/2] 9p: p9_client_create: use p9_client_destroy on failure
Date:   Sun,  4 Sep 2022 15:39:36 +0900
Message-Id: <20220904063936.1305139-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <0000000000001c3efc05e6693f06@google.com>
References: <0000000000001c3efc05e6693f06@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If trans was connected it's somehow possible to fail with requests in
flight that could still be accessed after free if we just free the clnt
on failure.
Just use p9_client_destroy instead that has proper safeguards.

Reported-by: syzbot+de52531662ebb8823b26@syzkaller.appspotmail.com
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 net/9p/client.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 0a6110e15d0f..d340dbbd2ace 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -931,14 +931,10 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	char *client_id;
 
 	err = 0;
-	clnt = kmalloc(sizeof(*clnt), GFP_KERNEL);
+	clnt = kzalloc(sizeof(*clnt), GFP_KERNEL);
 	if (!clnt)
 		return ERR_PTR(-ENOMEM);
 
-	clnt->trans_mod = NULL;
-	clnt->trans = NULL;
-	clnt->fcall_cache = NULL;
-
 	client_id = utsname()->nodename;
 	memcpy(clnt->name, client_id, strlen(client_id) + 1);
 
@@ -948,7 +944,7 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 
 	err = parse_opts(options, clnt);
 	if (err < 0)
-		goto free_client;
+		goto out;
 
 	if (!clnt->trans_mod)
 		clnt->trans_mod = v9fs_get_default_trans();
@@ -957,7 +953,7 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 		err = -EPROTONOSUPPORT;
 		p9_debug(P9_DEBUG_ERROR,
 			 "No transport defined or default transport\n");
-		goto free_client;
+		goto out;
 	}
 
 	p9_debug(P9_DEBUG_MUX, "clnt %p trans %p msize %d protocol %d\n",
@@ -965,7 +961,7 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 
 	err = clnt->trans_mod->create(clnt, dev_name, options);
 	if (err)
-		goto put_trans;
+		goto out;
 
 	if (clnt->msize > clnt->trans_mod->maxsize) {
 		clnt->msize = clnt->trans_mod->maxsize;
@@ -979,12 +975,12 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 		p9_debug(P9_DEBUG_ERROR,
 			 "Please specify a msize of at least 4k\n");
 		err = -EINVAL;
-		goto close_trans;
+		goto out;
 	}
 
 	err = p9_client_version(clnt);
 	if (err)
-		goto close_trans;
+		goto out;
 
 	/* P9_HDRSZ + 4 is the smallest packet header we can have that is
 	 * followed by data accessed from userspace by read
@@ -997,12 +993,8 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 
 	return clnt;
 
-close_trans:
-	clnt->trans_mod->close(clnt);
-put_trans:
-	v9fs_put_trans(clnt->trans_mod);
-free_client:
-	kfree(clnt);
+out:
+	p9_client_destroy(clnt);
 	return ERR_PTR(err);
 }
 EXPORT_SYMBOL(p9_client_create);
-- 
2.35.1

