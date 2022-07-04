Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C10D564B46
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 03:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbiGDBmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 21:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiGDBmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 21:42:51 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDC56443
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 18:42:49 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id g14so8100032qto.9
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 18:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GF3HTPtE0daqJydHdURNfVHd7opkifxhxOHGMON+0Mw=;
        b=UYBnuNLSkQaqrG2mjGaiCiNhkejfKcj83E5EUdt1FEgb83oMMHD60n2Fp+OAeVqbKM
         uLaZ+egYoSRWN0nfWo4BuM4sHmY6Y0WpBMLv9mvYl8sXCG51+Uqjik12W4HRNs9InBFN
         rc9ZWKgwrRFG9B8SV9nN9aT3xTn6PHKMfUpO3C98UkKgUTGP1r+YoKy60+9WThBs4YUi
         ACpqDzvCy2KfRU4uTLgpAAFBQqedsvcqYYdAhqS9EsbzT35Lc+pdyUQSMYhKIUO6S7eJ
         lt1zYRwgdw2sRPRXHUslhjtaxlVEPSoEqGAna2rF4/+LXbiGrPHCxvWV+vDLfI10Eevk
         b9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GF3HTPtE0daqJydHdURNfVHd7opkifxhxOHGMON+0Mw=;
        b=jaCmlOKBLbvRqNxmLreq8n4BnJIXo6KELxRdbysl614Cg/AyyV8Jpbm0JEQSOyKve/
         sPHUX+m8TxOVCrsTV+FyaFMfUAu+HBSHX2E6G1oCQpmLNgTxGWkcxjGSgeFT7IrD0yGn
         BqzD34thnEycMcab2GsUjDF+iU7BKqUxkGwlci8G7L76g00JHKABMq0sTq8jm2P1RqIA
         UqANOM2psdujsJ43pyTqcKZ9kZ+2U3c3zI8J/wIl4MBK58VKamPlvLcx2zKY4Jiiwehm
         9cyewrCJNeRw8sHuFsCebDxrj++/Azu6DBX7qggtEqmL0qfGSJnd31IB3KvakeysqQje
         Zf5g==
X-Gm-Message-State: AJIora+8xM3xuLavCrasNKxdNzos2FokZXF3r+FxKlpgnJllxtDamUMg
        948yzzy2oqiM4A3q1/a2TKpYchaMwaR4a9k=
X-Google-Smtp-Source: AGRyM1t4cKUHC1TzsSt+4DBE7zDgk8/4zCGdT/I3JIX+gvz4MTrsEnTkMrbFEAyn/s05PCFnvo3Pdg==
X-Received: by 2002:ac8:5a49:0:b0:31e:78fc:1f3 with SMTP id o9-20020ac85a49000000b0031e78fc01f3mr1376892qta.90.1656898968330;
        Sun, 03 Jul 2022 18:42:48 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id x19-20020ac87ed3000000b0031bf4dd8a39sm11112093qtj.56.2022.07.03.18.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 18:42:47 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     v9fs-developer@lists.sourceforge.net,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 1/3] 9p: Drop kref usage
Date:   Sun,  3 Jul 2022 21:42:41 -0400
Message-Id: <20220704014243.153050-1-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704010945.C230AC341C7@smtp.kernel.org>
References: <20220704010945.C230AC341C7@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series has only been lightly tested, but it seems to do the trick... how's
it look to you? Commit messages could be better, but I'm not familiar with the
right 9p terminology for some things.

-- >8 --

An upcoming patch is going to require passing the client through
p9_req_put() -> p9_req_free(), but that's awkward with the kref
indirection - so this patch switches to using refcount_t directly.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>
Cc: Dominique Martinet <asmadeus@codewreck.org>
---
 include/net/9p/client.h |  6 +++---
 net/9p/client.c         | 19 ++++++++-----------
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index ec1d1706f4..c038c2d73d 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -76,7 +76,7 @@ enum p9_req_status_t {
 struct p9_req_t {
 	int status;
 	int t_err;
-	struct kref refcount;
+	refcount_t refcount;
 	wait_queue_head_t wq;
 	struct p9_fcall tc;
 	struct p9_fcall rc;
@@ -227,12 +227,12 @@ struct p9_req_t *p9_tag_lookup(struct p9_client *c, u16 tag);
 
 static inline void p9_req_get(struct p9_req_t *r)
 {
-	kref_get(&r->refcount);
+	refcount_inc(&r->refcount);
 }
 
 static inline int p9_req_try_get(struct p9_req_t *r)
 {
-	return kref_get_unless_zero(&r->refcount);
+	return refcount_inc_not_zero(&r->refcount);
 }
 
 int p9_req_put(struct p9_req_t *r);
diff --git a/net/9p/client.c b/net/9p/client.c
index 8bba0d9cf9..0ee48e8b72 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -305,7 +305,7 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
 	 * callback), so p9_client_cb eats the second ref there
 	 * as the pointer is duplicated directly by virtqueue_add_sgs()
 	 */
-	refcount_set(&req->refcount.refcount, 2);
+	refcount_set(&req->refcount, 2);
 
 	return req;
 
@@ -370,18 +370,15 @@ static int p9_tag_remove(struct p9_client *c, struct p9_req_t *r)
 	return p9_req_put(r);
 }
 
-static void p9_req_free(struct kref *ref)
-{
-	struct p9_req_t *r = container_of(ref, struct p9_req_t, refcount);
-
-	p9_fcall_fini(&r->tc);
-	p9_fcall_fini(&r->rc);
-	kmem_cache_free(p9_req_cache, r);
-}
-
 int p9_req_put(struct p9_req_t *r)
 {
-	return kref_put(&r->refcount, p9_req_free);
+	if (refcount_dec_and_test(&r->refcount)) {
+		p9_fcall_fini(&r->tc);
+		p9_fcall_fini(&r->rc);
+		kmem_cache_free(p9_req_cache, r);
+		return 1;
+	}
+	return 0;
 }
 EXPORT_SYMBOL(p9_req_put);
 
-- 
2.36.1

