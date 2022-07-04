Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BD2564B43
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 03:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbiGDBmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 21:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbiGDBmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 21:42:52 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF896457
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 18:42:51 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id q16so8100355qtn.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 18:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W+zHT5jRR8HXuSY9qedCWZxOgxUoZg3wMQgKUyUgMPU=;
        b=HofjIljn3kbRD4Wm6VdmjRIZ4ODPV2hxrp/AxGfJPB9DDixm6wqF+1PZRoel29qQXW
         Bl8YlLWbvRuva/wvaSeb3dJgJrVXpfCAOdcLkjJNRag9LHOFQdZRZQgXw7XHgLtpRiNi
         QDaq6NJzLh2MK5Kvyy5rhdMgrajy2do5vHpOAJNzPoc/c82K8S1RDYSmLRbnHF4lPj0h
         ETsAR9IWHevBzhNkFpK4An/JGUpFstMNC31CRVzjb9wCZnLjDkK/0oumWh2DYb32nm+n
         /kM2oED+PAGh5tt4s40c1i+bhlr9MaMwBffj++RW8cODdID7B5LL6lh91XYrd1ZvOApu
         rrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+zHT5jRR8HXuSY9qedCWZxOgxUoZg3wMQgKUyUgMPU=;
        b=5ZlgtaayA7M/1i+7RUSx5qZQuBGnsJMgzLV9zKrP590aEdOlvf2GDR8W37uKqjgZXd
         4eLmo16iUiE/xLHgsnefseoFkNpkKxRx+HA3viZSmJGWHTW3viuaHFQF5Ota+ONvQCqv
         8InNOfHHG2ddc+GNSOYK/Ne+2ApgbbsGjrR4AIAPjyTipjhrHrSipUFVGnhQgGrCYAoT
         2xXa8EKEseoIxZ58oYdPdzJQ9W7rif4sHyXZqEjxG+vI7GyxOQ4sH+CL4KGMWPtS3vzy
         5P1ZGFb5YTdvyAo02jHKMhJczAPakDDN5WkBfC9/tFCFOl28Pqz/Wtf8as0XFhp1LRO9
         1gKw==
X-Gm-Message-State: AJIora+I5kRyzY/RKDcjowuiA0DYsOvkQ7Wh0+70GxZnO2jM37M6MPfm
        OEHssIpLi10X206l+aDKQHhNYfg5aNtTviI=
X-Google-Smtp-Source: AGRyM1udPMH1B+N5yMLKzjTYqVyENfEMU/tSF9yN+0/kL1ClqABivF+69COLnpXDogM/t66IlXtXBA==
X-Received: by 2002:a05:622a:1213:b0:319:13fa:3a4f with SMTP id y19-20020a05622a121300b0031913fa3a4fmr21868211qtx.379.1656898969863;
        Sun, 03 Jul 2022 18:42:49 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id de4-20020a05620a370400b006b253a6dd1fsm7284265qkb.125.2022.07.03.18.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 18:42:49 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     v9fs-developer@lists.sourceforge.net,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 2/3] 9p: Add client parameter to p9_req_put()
Date:   Sun,  3 Jul 2022 21:42:42 -0400
Message-Id: <20220704014243.153050-2-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704014243.153050-1-kent.overstreet@gmail.com>
References: <20220704010945.C230AC341C7@smtp.kernel.org>
 <20220704014243.153050-1-kent.overstreet@gmail.com>
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

This is to aid in adding mempools, in the next patch.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>
Cc: Dominique Martinet <asmadeus@codewreck.org>
---
 include/net/9p/client.h |  2 +-
 net/9p/client.c         | 12 ++++++------
 net/9p/trans_fd.c       | 12 ++++++------
 net/9p/trans_rdma.c     |  2 +-
 net/9p/trans_virtio.c   |  4 ++--
 net/9p/trans_xen.c      |  2 +-
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index c038c2d73d..cb78e0e333 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -235,7 +235,7 @@ static inline int p9_req_try_get(struct p9_req_t *r)
 	return refcount_inc_not_zero(&r->refcount);
 }
 
-int p9_req_put(struct p9_req_t *r);
+int p9_req_put(struct p9_client *c, struct p9_req_t *r);
 
 void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status);
 
diff --git a/net/9p/client.c b/net/9p/client.c
index 0ee48e8b72..a36a40137c 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -341,7 +341,7 @@ struct p9_req_t *p9_tag_lookup(struct p9_client *c, u16 tag)
 		if (!p9_req_try_get(req))
 			goto again;
 		if (req->tc.tag != tag) {
-			p9_req_put(req);
+			p9_req_put(c, req);
 			goto again;
 		}
 	}
@@ -367,10 +367,10 @@ static int p9_tag_remove(struct p9_client *c, struct p9_req_t *r)
 	spin_lock_irqsave(&c->lock, flags);
 	idr_remove(&c->reqs, tag);
 	spin_unlock_irqrestore(&c->lock, flags);
-	return p9_req_put(r);
+	return p9_req_put(c, r);
 }
 
-int p9_req_put(struct p9_req_t *r)
+int p9_req_put(struct p9_client *c, struct p9_req_t *r)
 {
 	if (refcount_dec_and_test(&r->refcount)) {
 		p9_fcall_fini(&r->tc);
@@ -423,7 +423,7 @@ void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status)
 
 	wake_up(&req->wq);
 	p9_debug(P9_DEBUG_MUX, "wakeup: %d\n", req->tc.tag);
-	p9_req_put(req);
+	p9_req_put(c, req);
 }
 EXPORT_SYMBOL(p9_client_cb);
 
@@ -706,7 +706,7 @@ static struct p9_req_t *p9_client_prepare_req(struct p9_client *c,
 reterr:
 	p9_tag_remove(c, req);
 	/* We have to put also the 2nd reference as it won't be used */
-	p9_req_put(req);
+	p9_req_put(c, req);
 	return ERR_PTR(err);
 }
 
@@ -743,7 +743,7 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 	err = c->trans_mod->request(c, req);
 	if (err < 0) {
 		/* write won't happen */
-		p9_req_put(req);
+		p9_req_put(c, req);
 		if (err != -ERESTARTSYS && err != -EFAULT)
 			c->status = Disconnected;
 		goto recalc_sigpending;
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 8f8f95e39b..007c3f45fe 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -378,7 +378,7 @@ static void p9_read_work(struct work_struct *work)
 		m->rc.sdata = NULL;
 		m->rc.offset = 0;
 		m->rc.capacity = 0;
-		p9_req_put(m->rreq);
+		p9_req_put(m->client, m->rreq);
 		m->rreq = NULL;
 	}
 
@@ -492,7 +492,7 @@ static void p9_write_work(struct work_struct *work)
 	m->wpos += err;
 	if (m->wpos == m->wsize) {
 		m->wpos = m->wsize = 0;
-		p9_req_put(m->wreq);
+		p9_req_put(m->client, m->wreq);
 		m->wreq = NULL;
 	}
 
@@ -695,7 +695,7 @@ static int p9_fd_cancel(struct p9_client *client, struct p9_req_t *req)
 	if (req->status == REQ_STATUS_UNSENT) {
 		list_del(&req->req_list);
 		req->status = REQ_STATUS_FLSHD;
-		p9_req_put(req);
+		p9_req_put(client, req);
 		ret = 0;
 	}
 	spin_unlock(&client->lock);
@@ -722,7 +722,7 @@ static int p9_fd_cancelled(struct p9_client *client, struct p9_req_t *req)
 	list_del(&req->req_list);
 	req->status = REQ_STATUS_FLSHD;
 	spin_unlock(&client->lock);
-	p9_req_put(req);
+	p9_req_put(client, req);
 
 	return 0;
 }
@@ -883,12 +883,12 @@ static void p9_conn_destroy(struct p9_conn *m)
 	p9_mux_poll_stop(m);
 	cancel_work_sync(&m->rq);
 	if (m->rreq) {
-		p9_req_put(m->rreq);
+		p9_req_put(m->client, m->rreq);
 		m->rreq = NULL;
 	}
 	cancel_work_sync(&m->wq);
 	if (m->wreq) {
-		p9_req_put(m->wreq);
+		p9_req_put(m->client, m->wreq);
 		m->wreq = NULL;
 	}
 
diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
index 88e5638266..d817d37452 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -350,7 +350,7 @@ send_done(struct ib_cq *cq, struct ib_wc *wc)
 			    c->busa, c->req->tc.size,
 			    DMA_TO_DEVICE);
 	up(&rdma->sq_sem);
-	p9_req_put(c->req);
+	p9_req_put(client, c->req);
 	kfree(c);
 }
 
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index b24a4fb0f0..147972bf2e 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -199,7 +199,7 @@ static int p9_virtio_cancel(struct p9_client *client, struct p9_req_t *req)
 /* Reply won't come, so drop req ref */
 static int p9_virtio_cancelled(struct p9_client *client, struct p9_req_t *req)
 {
-	p9_req_put(req);
+	p9_req_put(client, req);
 	return 0;
 }
 
@@ -523,7 +523,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	kvfree(out_pages);
 	if (!kicked) {
 		/* reply won't come */
-		p9_req_put(req);
+		p9_req_put(client, req);
 	}
 	return err;
 }
diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index 77883b6788..4cf0c78d4d 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -163,7 +163,7 @@ static int p9_xen_request(struct p9_client *client, struct p9_req_t *p9_req)
 	ring->intf->out_prod = prod;
 	spin_unlock_irqrestore(&ring->lock, flags);
 	notify_remote_via_irq(ring->irq);
-	p9_req_put(p9_req);
+	p9_req_put(client, p9_req);
 
 	return 0;
 }
-- 
2.36.1

