Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81FF4D473D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 13:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242113AbiCJMvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 07:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240315AbiCJMuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 07:50:55 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B241C14891E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 04:49:54 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d61f6c1877so39551087b3.15
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 04:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ALSEL9LuFnUnMtyCTwSaJ5peLevtVaPVQNw8s0gGmYc=;
        b=Tu8P5221QkfRPOdz7Vm/QjH0r1IZAxD6FteMSjhufUD8xUak1VWpt+675KKx1TyEYg
         wsmrWx6ynA7A1frWYCWAAljGT8IJA8UQ0ll2idnTo2hoKQThmcPzlDFUUeqymcjRkm3i
         Vln3s9ysDwzp7U4/KpcLoHqIoetFgmYdQz5fz12jNjcNvPAxSKEMNsWC0EjahbyuOgsR
         6Gg5hCOIixsXMJ8S6Ql4FCOUDG1rQdDjsrTn3hpiEfnoI7Zi/edy0BF2mcyaGyTAd4Hx
         xXoOPkC+G3wdr0wl5J6DKG7dtLQIVvvHRidU4NFoiV8C95/F4SfyI3uPR8onwSDYIMLJ
         yjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ALSEL9LuFnUnMtyCTwSaJ5peLevtVaPVQNw8s0gGmYc=;
        b=jnmADHkudD4LxjYsTR4szOkQWa+cor8hzl9UjdxikSvv0YI0xDUuGNWTgSIaG1qfXX
         sAQAkkSO+uFu9rpKyvvrqmPZlcd/o28RC+/2kjG7sZ6fOySjU1tUf7LYlI0NG94mSrmv
         UViWbAAToAFkoR/NYJANRZ1MwFqiV8uG9PWK44No/iVWJ+VQbSlUZ0ybVyCk0xqmelL5
         XLHV4BleQJaiN7VPlWj3AajbrIt7Ph87UBF5TzUtHrSJN67N5BMD+mrd5q9IQGM+T2EK
         BXHAdG/M0PQ11u3luL4pW5yYFMxZ8zXCwm1DP9aUALbrihrbZM3SUisQCCLLD/DJsdhE
         8zbg==
X-Gm-Message-State: AOAM533dm3BDefYfkX87c/ii/h4i1VJR9y0VQ8viuXYk0dDsAcXtnkpu
        VAkLpZ4+VM9tjv7VDMIBRsf5uUHcy14=
X-Google-Smtp-Source: ABdhPJyjh0R7OFT0MD8hNPxUC6ZfB745tOtX2yKAhiJF44VEL6Hbmw+DEcAR7EUp4465bHQ6CF3to7qK6OE=
X-Received: from jiyong.seo.corp.google.com ([2401:fa00:d:11:f59e:134:eb7:e1d2])
 (user=jiyong job=sendgmr) by 2002:a25:3c41:0:b0:62c:2929:84b1 with SMTP id
 j62-20020a253c41000000b0062c292984b1mr3615986yba.338.1646916593902; Thu, 10
 Mar 2022 04:49:53 -0800 (PST)
Date:   Thu, 10 Mar 2022 21:49:35 +0900
In-Reply-To: <20220310124936.4179591-1-jiyong@google.com>
Message-Id: <20220310124936.4179591-2-jiyong@google.com>
Mime-Version: 1.0
References: <20220310124936.4179591-1-jiyong@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH 1/2] vsock: each transport cycles only on its own sockets
From:   Jiyong Park <jiyong@google.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     adelva@google.com, Jiyong Park <jiyong@google.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When iterating over sockets using vsock_for_each_connected_socket, make
sure that a transport filters out sockets that don't belong to the
transport.

There actually was an issue caused by this; in a nested VM
configuration, destroying the nested VM (which often involves the
closing of /dev/vhost-vsock if there was h2g connections to the nested
VM) kills not only the h2g connections, but also all existing g2h
connections to the (outmost) host which are totally unrelated.

Tested: Executed the following steps on Cuttlefish (Android running on a
VM) [1]: (1) Enter into an `adb shell` session - to have a g2h
connection inside the VM, (2) open and then close /dev/vhost-vsock by
`exec 3< /dev/vhost-vsock && exec 3<&-`, (3) observe that the adb
session is not reset.

[1] https://android.googlesource.com/device/google/cuttlefish/

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Signed-off-by: Jiyong Park <jiyong@google.com>
---
 drivers/vhost/vsock.c            | 4 ++++
 net/vmw_vsock/virtio_transport.c | 7 +++++++
 net/vmw_vsock/vmci_transport.c   | 5 +++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 37f0b4274113..853ddac00d5b 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -722,6 +722,10 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
 	 * executing.
 	 */
 
+	/* Only handle our own sockets */
+	if (vsk->transport != &vhost_transport.transport)
+		return;
+
 	/* If the peer is still valid, no need to reset connection */
 	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
 		return;
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index fb3302fff627..61b24eb31d4b 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -24,6 +24,7 @@
 static struct workqueue_struct *virtio_vsock_workqueue;
 static struct virtio_vsock __rcu *the_virtio_vsock;
 static DEFINE_MUTEX(the_virtio_vsock_mutex); /* protects the_virtio_vsock */
+static struct virtio_transport virtio_transport; /* forward declaration */
 
 struct virtio_vsock {
 	struct virtio_device *vdev;
@@ -357,11 +358,17 @@ static void virtio_vsock_event_fill(struct virtio_vsock *vsock)
 
 static void virtio_vsock_reset_sock(struct sock *sk)
 {
+	struct vsock_sock *vsk = vsock_sk(sk);
+
 	/* vmci_transport.c doesn't take sk_lock here either.  At least we're
 	 * under vsock_table_lock so the sock cannot disappear while we're
 	 * executing.
 	 */
 
+	/* Only handle our own sockets */
+	if (vsk->transport != &virtio_transport.transport)
+		return;
+
 	sk->sk_state = TCP_CLOSE;
 	sk->sk_err = ECONNRESET;
 	sk_error_report(sk);
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 7aef34e32bdf..cd2f01513fae 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -803,6 +803,11 @@ static void vmci_transport_handle_detach(struct sock *sk)
 	struct vsock_sock *vsk;
 
 	vsk = vsock_sk(sk);
+
+	/* Only handle our own sockets */
+	if (vsk->transport != &vmci_transport)
+		return;
+
 	if (!vmci_handle_is_invalid(vmci_trans(vsk)->qp_handle)) {
 		sock_set_flag(sk, SOCK_DONE);
 
-- 
2.35.1.723.g4982287a31-goog

