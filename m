Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9364EE3CB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242214AbiCaWHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241364AbiCaWHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:07:44 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1E42220FE;
        Thu, 31 Mar 2022 15:05:56 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h4so883956edr.3;
        Thu, 31 Mar 2022 15:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+lEn0rQXRmAObsqwUwKyW/Jy0vdmwy8BXHEgwAE2mHM=;
        b=PEzt+lNbqXrw78tEz86wAgIk1WgIENnBw4AQdHmYeS76iY4ontNQCB7V2FhHBy137N
         h25I9VQ0x1o6CC6zeggAoOJdtDlPn9c1z1tZ96oTptUO/ZUDkFx1y54OdctnZSwRzjth
         2yTXbIkfbLK2y5U+Dxw40iw36w/h6fN5CvxNkhEyZ9bVeboOcS7khnNwGocYDeJ6DTH/
         fS1rAwNWAnioifnye/a/ou8j/md8VMXAHNChdh9G+ACrGzRkp+k+O2nBldq5EGDzZsDH
         QkCyBEQZMwcup94DmLfkop43kjPiwhJngebHt3HcdZl/+OPYbYpB0tNoFJ4tTVJxQKU7
         waNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+lEn0rQXRmAObsqwUwKyW/Jy0vdmwy8BXHEgwAE2mHM=;
        b=jncdieohy67Y9hxtT75uhtn3oJ42YJZoEHja2JAmgxLLqEvoplTQO5mozb2g7zhhBT
         bV+SAqIZTN13DP0h6JoB3Wnc4rsAbMf8Yqp/O+oQZl4hgT2s4e50dcivB8ZiBtl59p4Q
         PE6kLhkFYIunXWPHU8FU+GBiXUQjZe8/gYeUycxzhZADoZxhmkRjw7DaTPy6jzEA0/VE
         dAoJSeu5YwM2K+ix6mjjHO/lZpIDDgQFJ8obdRRF5rWI/0hXaD29NSh6odamBizH2gEN
         yuNIaaV3lemt3nMAynQEfqc5Y6qFyTKPl+rJZwSAb+tBQ5PwgdeLo4/w2vmKRHDnsrkc
         02Ew==
X-Gm-Message-State: AOAM532JJUZnXi1AoEFqIOSxNSTEgidLMtR6WmEQaMJv9isLnE/0MW/q
        O1tcnIZQyC3hFGelVVYSvEI=
X-Google-Smtp-Source: ABdhPJzNZk8q2x1q7JKwPHbmGCK62v+mwob1Y6v9D7/hHAtR5hk1m/aaU1rHniseikkyl4flEhzC2g==
X-Received: by 2002:a05:6402:1e8a:b0:41a:4242:7de9 with SMTP id f10-20020a0564021e8a00b0041a42427de9mr18307883edf.284.1648764355187;
        Thu, 31 Mar 2022 15:05:55 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id o2-20020a50d802000000b00410d7f0c52csm321110edj.8.2022.03.31.15.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 15:05:54 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Philipp Reisner <philipp.reisner@linbit.com>
Cc:     Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH 2/2] drbd: remove check of list iterator against head past the loop body
Date:   Fri,  1 Apr 2022 00:03:49 +0200
Message-Id: <20220331220349.885126-2-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220331220349.885126-1-jakobkoschel@gmail.com>
References: <20220331220349.885126-1-jakobkoschel@gmail.com>
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

When list_for_each_entry() completes the iteration over the whole list
without breaking the loop, the iterator value will be a bogus pointer
computed based on the head element.

While it is safe to use the pointer to determine if it was computed
based on the head element, either with list_entry_is_head() or
&pos->member == head, using the iterator variable after the loop should
be avoided.

In preparation to limit the scope of a list iterator to the list
traversal loop, use a dedicated pointer to point to the found element [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/block/drbd/drbd_req.c | 42 ++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index c04394518b07..b2571dc77fe6 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -332,17 +332,21 @@ static void set_if_null_req_next(struct drbd_peer_device *peer_device, struct dr
 static void advance_conn_req_next(struct drbd_peer_device *peer_device, struct drbd_request *req)
 {
 	struct drbd_connection *connection = peer_device ? peer_device->connection : NULL;
+	struct drbd_request *iter = req;
 	if (!connection)
 		return;
 	if (connection->req_next != req)
 		return;
-	list_for_each_entry_continue(req, &connection->transfer_log, tl_requests) {
-		const unsigned s = req->rq_state;
-		if (s & RQ_NET_QUEUED)
+
+	req = NULL;
+	list_for_each_entry_continue(iter, &connection->transfer_log, tl_requests) {
+		const unsigned int s = iter->rq_state;
+
+		if (s & RQ_NET_QUEUED) {
+			req = iter;
 			break;
+		}
 	}
-	if (&req->tl_requests == &connection->transfer_log)
-		req = NULL;
 	connection->req_next = req;
 }
 
@@ -358,17 +362,21 @@ static void set_if_null_req_ack_pending(struct drbd_peer_device *peer_device, st
 static void advance_conn_req_ack_pending(struct drbd_peer_device *peer_device, struct drbd_request *req)
 {
 	struct drbd_connection *connection = peer_device ? peer_device->connection : NULL;
+	struct drbd_request *iter = req;
 	if (!connection)
 		return;
 	if (connection->req_ack_pending != req)
 		return;
-	list_for_each_entry_continue(req, &connection->transfer_log, tl_requests) {
-		const unsigned s = req->rq_state;
-		if ((s & RQ_NET_SENT) && (s & RQ_NET_PENDING))
+
+	req = NULL;
+	list_for_each_entry_continue(iter, &connection->transfer_log, tl_requests) {
+		const unsigned int s = iter->rq_state;
+
+		if ((s & RQ_NET_SENT) && (s & RQ_NET_PENDING)) {
+			req = iter;
 			break;
+		}
 	}
-	if (&req->tl_requests == &connection->transfer_log)
-		req = NULL;
 	connection->req_ack_pending = req;
 }
 
@@ -384,17 +392,21 @@ static void set_if_null_req_not_net_done(struct drbd_peer_device *peer_device, s
 static void advance_conn_req_not_net_done(struct drbd_peer_device *peer_device, struct drbd_request *req)
 {
 	struct drbd_connection *connection = peer_device ? peer_device->connection : NULL;
+	struct drbd_request *iter = req;
 	if (!connection)
 		return;
 	if (connection->req_not_net_done != req)
 		return;
-	list_for_each_entry_continue(req, &connection->transfer_log, tl_requests) {
-		const unsigned s = req->rq_state;
-		if ((s & RQ_NET_SENT) && !(s & RQ_NET_DONE))
+
+	req = NULL;
+	list_for_each_entry_continue(iter, &connection->transfer_log, tl_requests) {
+		const unsigned int s = iter->rq_state;
+
+		if ((s & RQ_NET_SENT) && !(s & RQ_NET_DONE)) {
+			req = iter;
 			break;
+		}
 	}
-	if (&req->tl_requests == &connection->transfer_log)
-		req = NULL;
 	connection->req_not_net_done = req;
 }
 
-- 
2.25.1

