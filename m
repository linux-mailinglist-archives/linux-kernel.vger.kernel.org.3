Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8C44F6B9B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiDFUur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbiDFUtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:49:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB623C15BA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 12:05:18 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id p15so6218072ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 12:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qfxFWJFZ6uw2agXHgOvG4u2eDOtbo0NRWmwVpn4uFPA=;
        b=Fx6Uzt6LOot/haJHKSHSwXct2yt9GFO4Y+pzzAVJq+RpsGqBTpxSYkyR9QFt7Y0cLD
         kQxZ1vVDQ7f3QAoHSIG9u5Q3r6tBdOc3EbnYSkMLTr4QM1jbq3UZDKVGAiMfH7bG5YXE
         jJYEf4EuB+iDCS6kGeOsokexim4cusMplStRE1+lq5+0ObBGJhyqoNcoGBjcfYPwJV42
         RK6bnZFLhHVqtvgSyb88PiE6n42DbDIAVYOUqhZ3ULxnGeH6EWbxxq6LQF+saZUMu4XA
         FQKPMrrX9xfisuqVFIcAoplgPEjFtJln0yzkQ6jyBu4WMniucMTHvmEKbFkesaCYihMy
         p3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qfxFWJFZ6uw2agXHgOvG4u2eDOtbo0NRWmwVpn4uFPA=;
        b=MvInvxjynzPZq9GqgFAtVlwGy/wz36tZsqgmH1jXGLeReS7/cnhHhBXSkmWkMP6pnS
         S3eBWWEMNVmuRIwsUofMn4uDMZ3D0tKBRC+99TXWEopJvRSMdb2Dshjt4uSi3WK1r58p
         UjwpiPjaWgi5bk75dEpjkn137VKuNtBKRH+q1KE2n0EpVJs403bXod0ocXs7s8ATIjOe
         hgxLvprVwbMGYDGNFZqfUXonZeT58GSptQysyVy/s+Z+in6g6iaya04NxzQfzCwcpNjy
         UHS/fsJLt8cVym+Hdgg0AsT1vfHPLVp6feEkri3ExjiYGSlNPbgQZUL/atqJ9+MXm3a9
         PXSg==
X-Gm-Message-State: AOAM533C3IoAhhEF3K8qC3iJSr8ckAsiKwQbzAwn20nRjAkI83H7ObBw
        U3Dh74RemDIy9q8cwB1LsFdjCA==
X-Google-Smtp-Source: ABdhPJzNa8Nk7IZLK4W0O/SXUB4IqOz2lnsHa91HVJ6qB8thGBlO43hlkjSUFd9q3q4sAFC1DvyuoA==
X-Received: by 2002:a17:906:6841:b0:6cf:9c02:8965 with SMTP id a1-20020a170906684100b006cf9c028965mr9570039ejs.440.1649271916774;
        Wed, 06 Apr 2022 12:05:16 -0700 (PDT)
Received: from localhost (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id hq39-20020a1709073f2700b006dfc58efab9sm6897892ejc.73.2022.04.06.12.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 12:05:16 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org, Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 1/3] drbd: Fix five use after free bugs in get_initial_state
Date:   Wed,  6 Apr 2022 21:04:43 +0200
Message-Id: <20220406190445.1937206-2-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406190445.1937206-1-christoph.boehmwalder@linbit.com>
References: <20220406190445.1937206-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lv Yunlong <lyl2019@mail.ustc.edu.cn>

In get_initial_state, it calls notify_initial_state_done(skb,..) if
cb->args[5]==1. If genlmsg_put() failed in notify_initial_state_done(),
the skb will be freed by nlmsg_free(skb).
Then get_initial_state will goto out and the freed skb will be used by
return value skb->len, which is a uaf bug.

What's worse, the same problem goes even further: skb can also be
freed in the notify_*_state_change -> notify_*_state calls below.
Thus 4 additional uaf bugs happened.

My patch lets the problem callee functions: notify_initial_state_done
and notify_*_state_change return an error code if errors happen.
So that the error codes could be propagated and the uaf bugs can be avoid.

v2 reports a compilation warning. This v3 fixed this warning and built
successfully in my local environment with no additional warnings.
v2: https://lore.kernel.org/patchwork/patch/1435218/

Fixes: a29728463b254 ("drbd: Backport the "events2" command")
Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_int.h          |  8 ++---
 drivers/block/drbd/drbd_nl.c           | 41 ++++++++++++++++----------
 drivers/block/drbd/drbd_state.c        | 18 +++++------
 drivers/block/drbd/drbd_state_change.h |  8 ++---
 4 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 4b55e864a0a3..4d3efaa20b7b 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1638,22 +1638,22 @@ struct sib_info {
 };
 void drbd_bcast_event(struct drbd_device *device, const struct sib_info *sib);
 
-extern void notify_resource_state(struct sk_buff *,
+extern int notify_resource_state(struct sk_buff *,
 				  unsigned int,
 				  struct drbd_resource *,
 				  struct resource_info *,
 				  enum drbd_notification_type);
-extern void notify_device_state(struct sk_buff *,
+extern int notify_device_state(struct sk_buff *,
 				unsigned int,
 				struct drbd_device *,
 				struct device_info *,
 				enum drbd_notification_type);
-extern void notify_connection_state(struct sk_buff *,
+extern int notify_connection_state(struct sk_buff *,
 				    unsigned int,
 				    struct drbd_connection *,
 				    struct connection_info *,
 				    enum drbd_notification_type);
-extern void notify_peer_device_state(struct sk_buff *,
+extern int notify_peer_device_state(struct sk_buff *,
 				     unsigned int,
 				     struct drbd_peer_device *,
 				     struct peer_device_info *,
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 02030c9c4d3b..b7216c186ba4 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -4549,7 +4549,7 @@ static int nla_put_notification_header(struct sk_buff *msg,
 	return drbd_notification_header_to_skb(msg, &nh, true);
 }
 
-void notify_resource_state(struct sk_buff *skb,
+int notify_resource_state(struct sk_buff *skb,
 			   unsigned int seq,
 			   struct drbd_resource *resource,
 			   struct resource_info *resource_info,
@@ -4591,16 +4591,17 @@ void notify_resource_state(struct sk_buff *skb,
 		if (err && err != -ESRCH)
 			goto failed;
 	}
-	return;
+	return 0;
 
 nla_put_failure:
 	nlmsg_free(skb);
 failed:
 	drbd_err(resource, "Error %d while broadcasting event. Event seq:%u\n",
 			err, seq);
+	return err;
 }
 
-void notify_device_state(struct sk_buff *skb,
+int notify_device_state(struct sk_buff *skb,
 			 unsigned int seq,
 			 struct drbd_device *device,
 			 struct device_info *device_info,
@@ -4640,16 +4641,17 @@ void notify_device_state(struct sk_buff *skb,
 		if (err && err != -ESRCH)
 			goto failed;
 	}
-	return;
+	return 0;
 
 nla_put_failure:
 	nlmsg_free(skb);
 failed:
 	drbd_err(device, "Error %d while broadcasting event. Event seq:%u\n",
 		 err, seq);
+	return err;
 }
 
-void notify_connection_state(struct sk_buff *skb,
+int notify_connection_state(struct sk_buff *skb,
 			     unsigned int seq,
 			     struct drbd_connection *connection,
 			     struct connection_info *connection_info,
@@ -4689,16 +4691,17 @@ void notify_connection_state(struct sk_buff *skb,
 		if (err && err != -ESRCH)
 			goto failed;
 	}
-	return;
+	return 0;
 
 nla_put_failure:
 	nlmsg_free(skb);
 failed:
 	drbd_err(connection, "Error %d while broadcasting event. Event seq:%u\n",
 		 err, seq);
+	return err;
 }
 
-void notify_peer_device_state(struct sk_buff *skb,
+int notify_peer_device_state(struct sk_buff *skb,
 			      unsigned int seq,
 			      struct drbd_peer_device *peer_device,
 			      struct peer_device_info *peer_device_info,
@@ -4739,13 +4742,14 @@ void notify_peer_device_state(struct sk_buff *skb,
 		if (err && err != -ESRCH)
 			goto failed;
 	}
-	return;
+	return 0;
 
 nla_put_failure:
 	nlmsg_free(skb);
 failed:
 	drbd_err(peer_device, "Error %d while broadcasting event. Event seq:%u\n",
 		 err, seq);
+	return err;
 }
 
 void notify_helper(enum drbd_notification_type type,
@@ -4796,7 +4800,7 @@ void notify_helper(enum drbd_notification_type type,
 		 err, seq);
 }
 
-static void notify_initial_state_done(struct sk_buff *skb, unsigned int seq)
+static int notify_initial_state_done(struct sk_buff *skb, unsigned int seq)
 {
 	struct drbd_genlmsghdr *dh;
 	int err;
@@ -4810,11 +4814,12 @@ static void notify_initial_state_done(struct sk_buff *skb, unsigned int seq)
 	if (nla_put_notification_header(skb, NOTIFY_EXISTS))
 		goto nla_put_failure;
 	genlmsg_end(skb, dh);
-	return;
+	return 0;
 
 nla_put_failure:
 	nlmsg_free(skb);
 	pr_err("Error %d sending event. Event seq:%u\n", err, seq);
+	return err;
 }
 
 static void free_state_changes(struct list_head *list)
@@ -4841,6 +4846,7 @@ static int get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
 	unsigned int seq = cb->args[2];
 	unsigned int n;
 	enum drbd_notification_type flags = 0;
+	int err = 0;
 
 	/* There is no need for taking notification_mutex here: it doesn't
 	   matter if the initial state events mix with later state chage
@@ -4849,32 +4855,32 @@ static int get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
 
 	cb->args[5]--;
 	if (cb->args[5] == 1) {
-		notify_initial_state_done(skb, seq);
+		err = notify_initial_state_done(skb, seq);
 		goto out;
 	}
 	n = cb->args[4]++;
 	if (cb->args[4] < cb->args[3])
 		flags |= NOTIFY_CONTINUES;
 	if (n < 1) {
-		notify_resource_state_change(skb, seq, state_change->resource,
+		err = notify_resource_state_change(skb, seq, state_change->resource,
 					     NOTIFY_EXISTS | flags);
 		goto next;
 	}
 	n--;
 	if (n < state_change->n_connections) {
-		notify_connection_state_change(skb, seq, &state_change->connections[n],
+		err = notify_connection_state_change(skb, seq, &state_change->connections[n],
 					       NOTIFY_EXISTS | flags);
 		goto next;
 	}
 	n -= state_change->n_connections;
 	if (n < state_change->n_devices) {
-		notify_device_state_change(skb, seq, &state_change->devices[n],
+		err = notify_device_state_change(skb, seq, &state_change->devices[n],
 					   NOTIFY_EXISTS | flags);
 		goto next;
 	}
 	n -= state_change->n_devices;
 	if (n < state_change->n_devices * state_change->n_connections) {
-		notify_peer_device_state_change(skb, seq, &state_change->peer_devices[n],
+		err = notify_peer_device_state_change(skb, seq, &state_change->peer_devices[n],
 						NOTIFY_EXISTS | flags);
 		goto next;
 	}
@@ -4889,7 +4895,10 @@ static int get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
 		cb->args[4] = 0;
 	}
 out:
-	return skb->len;
+	if (err)
+		return err;
+	else
+		return skb->len;
 }
 
 int drbd_adm_get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index b8a27818ab3f..4ee11aef6672 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1537,7 +1537,7 @@ int drbd_bitmap_io_from_worker(struct drbd_device *device,
 	return rv;
 }
 
-void notify_resource_state_change(struct sk_buff *skb,
+int notify_resource_state_change(struct sk_buff *skb,
 				  unsigned int seq,
 				  struct drbd_resource_state_change *resource_state_change,
 				  enum drbd_notification_type type)
@@ -1550,10 +1550,10 @@ void notify_resource_state_change(struct sk_buff *skb,
 		.res_susp_fen = resource_state_change->susp_fen[NEW],
 	};
 
-	notify_resource_state(skb, seq, resource, &resource_info, type);
+	return notify_resource_state(skb, seq, resource, &resource_info, type);
 }
 
-void notify_connection_state_change(struct sk_buff *skb,
+int notify_connection_state_change(struct sk_buff *skb,
 				    unsigned int seq,
 				    struct drbd_connection_state_change *connection_state_change,
 				    enum drbd_notification_type type)
@@ -1564,10 +1564,10 @@ void notify_connection_state_change(struct sk_buff *skb,
 		.conn_role = connection_state_change->peer_role[NEW],
 	};
 
-	notify_connection_state(skb, seq, connection, &connection_info, type);
+	return notify_connection_state(skb, seq, connection, &connection_info, type);
 }
 
-void notify_device_state_change(struct sk_buff *skb,
+int notify_device_state_change(struct sk_buff *skb,
 				unsigned int seq,
 				struct drbd_device_state_change *device_state_change,
 				enum drbd_notification_type type)
@@ -1577,10 +1577,10 @@ void notify_device_state_change(struct sk_buff *skb,
 		.dev_disk_state = device_state_change->disk_state[NEW],
 	};
 
-	notify_device_state(skb, seq, device, &device_info, type);
+	return notify_device_state(skb, seq, device, &device_info, type);
 }
 
-void notify_peer_device_state_change(struct sk_buff *skb,
+int notify_peer_device_state_change(struct sk_buff *skb,
 				     unsigned int seq,
 				     struct drbd_peer_device_state_change *p,
 				     enum drbd_notification_type type)
@@ -1594,7 +1594,7 @@ void notify_peer_device_state_change(struct sk_buff *skb,
 		.peer_resync_susp_dependency = p->resync_susp_dependency[NEW],
 	};
 
-	notify_peer_device_state(skb, seq, peer_device, &peer_device_info, type);
+	return notify_peer_device_state(skb, seq, peer_device, &peer_device_info, type);
 }
 
 static void broadcast_state_change(struct drbd_state_change *state_change)
@@ -1602,7 +1602,7 @@ static void broadcast_state_change(struct drbd_state_change *state_change)
 	struct drbd_resource_state_change *resource_state_change = &state_change->resource[0];
 	bool resource_state_has_changed;
 	unsigned int n_device, n_connection, n_peer_device, n_peer_devices;
-	void (*last_func)(struct sk_buff *, unsigned int, void *,
+	int (*last_func)(struct sk_buff *, unsigned int, void *,
 			  enum drbd_notification_type) = NULL;
 	void *last_arg = NULL;
 
diff --git a/drivers/block/drbd/drbd_state_change.h b/drivers/block/drbd/drbd_state_change.h
index ba80f612d6ab..d5b0479bc9a6 100644
--- a/drivers/block/drbd/drbd_state_change.h
+++ b/drivers/block/drbd/drbd_state_change.h
@@ -44,19 +44,19 @@ extern struct drbd_state_change *remember_old_state(struct drbd_resource *, gfp_
 extern void copy_old_to_new_state_change(struct drbd_state_change *);
 extern void forget_state_change(struct drbd_state_change *);
 
-extern void notify_resource_state_change(struct sk_buff *,
+extern int notify_resource_state_change(struct sk_buff *,
 					 unsigned int,
 					 struct drbd_resource_state_change *,
 					 enum drbd_notification_type type);
-extern void notify_connection_state_change(struct sk_buff *,
+extern int notify_connection_state_change(struct sk_buff *,
 					   unsigned int,
 					   struct drbd_connection_state_change *,
 					   enum drbd_notification_type type);
-extern void notify_device_state_change(struct sk_buff *,
+extern int notify_device_state_change(struct sk_buff *,
 				       unsigned int,
 				       struct drbd_device_state_change *,
 				       enum drbd_notification_type type);
-extern void notify_peer_device_state_change(struct sk_buff *,
+extern int notify_peer_device_state_change(struct sk_buff *,
 					    unsigned int,
 					    struct drbd_peer_device_state_change *,
 					    enum drbd_notification_type type);
-- 
2.35.1

