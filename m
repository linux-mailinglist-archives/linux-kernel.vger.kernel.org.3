Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A8A572C38
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiGMERy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiGMERv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:17:51 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D656D9E13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:17:49 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 1A7E5C01D; Wed, 13 Jul 2022 06:17:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1657685868; bh=4ZFN7HS6FgPkkHOU1N5/skhVhOFInJEZ7hMaP56++zU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OsPR/KMeTzqUGC8tHYBChJQhcpPcbsqssA8hi7XCV2ECoqxImtN+3lQ59n4fSeNWa
         YEPhI4YxqMn6I2gVgmiTpvTtJxgDQHaGYpxvzWvdMf3QI6e/plBkgHkF33vZ+6ESBf
         tyxr8f55W6Z71H4xqcCtty7rGdznPAOd69khYFs8YZXXX0bGyWDkkCvb/hLbIQWyJB
         u25dupai01VBiL6ysDaYDzrIWQCGWPDEVh6FseZfBpvIjFyl5ZI1d+nnm3InOVl+ld
         z7ANByvMikWi1qUkGl3zX+8pXfksIxW5EYtxM0Jnl/86JuxwIEm+HQTlzMSWHmzC+I
         xk5e1nl6WDIpA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id B7618C009;
        Wed, 13 Jul 2022 06:17:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1657685867; bh=4ZFN7HS6FgPkkHOU1N5/skhVhOFInJEZ7hMaP56++zU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v2xFwPy9SA+bilY7KOlCje6JG2SV7jsjI2mOUR8D/+DQpD0RzU9CSgD40OZiC+vCV
         4kD2W1GJMacqJMEaN5O8xiEakFJ6OrqqjL9uvjcvtQFXxccqDqCBp3gITgPPzC27h7
         IBq8i4vzigKlGmNwmFQ9V0YH7AIQVCND/WAobiPKghXzoAIk7s5abJlzv30crfH93U
         rQuBuY1E5BsY7l1Wcb2I6qT+Ec+29fKvK5jl8xs9ph/7qBdgKgtV7Oq3CaHZJdaP/u
         J6wPZZwAyMcVVob/DPzcRWnMyN8tNAclnaJ7NFyj0oR0JCn/0fIESyrzjWW6x4w0Z8
         ko2b0elpZ9pfw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id a4b300d7;
        Wed, 13 Jul 2022 04:17:40 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Greg Kurz <groug@kaod.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [RFC PATCH] 9p: forbid use of mempool for TFLUSH
Date:   Wed, 13 Jul 2022 13:17:01 +0900
Message-Id: <20220713041700.2502404-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <12950409.o0bIpVV1Ut@silver>
References: <12950409.o0bIpVV1Ut@silver>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TFLUSH is called while the thread still holds memory for the
request we're trying to flush, so mempool alloc can deadlock
there. With p9_msg_buf_size() rework the flush allocation is
small so just make it fail if allocation failed; all that does
is potentially leak the request we're flushing until its reply
finally does come.. or if it never does until umount.

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---

Here's a concrete version of what I had in mind: literally just make
allocation fail if the initial alloc failed.

I can't reproduce any bad hang with a sane server here, but we still
risk hanging with a bad server that ignores flushes as these are still
unkillable (someday I'll finish my async requests work...)

So ultimately there are two things I'm not so happy about with mempools:
 - this real possibility of client hangs if a server mishandles some
replies -- this might make fuzzing difficult in particular, I think it's
easier to deal with failed IO (as long as it fails all the way back to
userspace) than to hang forever.
I'm sure there are others who prefer to wait instead, but I think this
should at least have a timeout or something.
 - One of the reasons I wanted to drop the old request cache before is
that these caches are per mount/connection. If you have a dozen of
mounts that each cache 4 requests worth as here, with msize=1MB and two
buffers per request we're locking down 8 * 12 = 96 MB of ram just for
mounting.
That being said, as long as hanging is a real risk I'm not comfortable
sharing the mempools between all the clients either, so I'm not sure
what to suggest.


Anyway, we're getting close to the next merge request and I don't have
time to look deeper into this; I'll be putting the mempool patches on
hold for next cycle at least and we can discuss again if Kent still
encounters allocation troubles with Christian's smaller buffers
optimization first.
These will very likely get in this cycle unless something bad happens,
I've finished retesting a bit without trouble here.


 net/9p/client.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 928c9f88f204..f9c17fb79f35 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -218,7 +218,7 @@ static int parse_opts(char *opts, struct p9_client *clnt)
 	return ret;
 }
 
-static void p9_fcall_init(struct p9_client *c, struct p9_fcall *fc,
+static int p9_fcall_init(struct p9_client *c, struct p9_fcall *fc,
 			  int fc_idx, unsigned alloc_msize)
 {
 	gfp_t gfp = GFP_NOFS|__GFP_NOWARN;
@@ -232,11 +232,13 @@ static void p9_fcall_init(struct p9_client *c, struct p9_fcall *fc,
 	if (alloc_msize < c->msize)
 		fc->sdata = kmalloc(alloc_msize, gfp);
 
-	if (!fc->sdata) {
+	if (!fc->sdata && fc_idx >= 0) {
 		fc->sdata = mempool_alloc(&c->pools[fc_idx], gfp);
 		fc->used_mempool = true;
 		fc->capacity = c->msize;
 	}
+
+	return fc->sdata == NULL;
 }
 
 void p9_fcall_fini(struct p9_client *c, struct p9_fcall *fc,
@@ -280,6 +282,7 @@ p9_tag_alloc(struct p9_client *c, int8_t type, uint t_size, uint r_size,
 	struct p9_req_t *req = kmem_cache_alloc(p9_req_cache, GFP_NOFS);
 	int alloc_tsize;
 	int alloc_rsize;
+	int fc_idx = 0;
 	int tag;
 	va_list apc;
 
@@ -294,8 +297,19 @@ p9_tag_alloc(struct p9_client *c, int8_t type, uint t_size, uint r_size,
 	if (!req)
 		return ERR_PTR(-ENOMEM);
 
-	p9_fcall_init(c, &req->tc, 0, alloc_tsize);
-	p9_fcall_init(c, &req->rc, 1, alloc_rsize);
+	/* We cannot use the mempool for TFLUSH because flushes can be
+	 * allocated when the thread still holds memory for the request
+	 * we're flushing. A negative fc_idx will make p9_fcall_init
+	 * error out.
+	 */
+	if (type == P9_TFLUSH) {
+		fc_idx = -2;
+	}
+
+	if (p9_fcall_init(c, &req->tc, fc_idx, alloc_tsize))
+		goto free_req;
+	if (p9_fcall_init(c, &req->rc, fc_idx + 1, alloc_rsize))
+		goto free;
 
 	p9pdu_reset(&req->tc);
 	p9pdu_reset(&req->rc);
@@ -334,6 +348,7 @@ p9_tag_alloc(struct p9_client *c, int8_t type, uint t_size, uint r_size,
 free:
 	p9_fcall_fini(c, &req->tc, 0);
 	p9_fcall_fini(c, &req->rc, 1);
+free_req:
 	kmem_cache_free(p9_req_cache, req);
 	return ERR_PTR(-ENOMEM);
 }
-- 
2.35.1

