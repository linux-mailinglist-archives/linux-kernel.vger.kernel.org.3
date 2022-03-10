Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87D54D4836
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 14:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242507AbiCJNiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 08:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242467AbiCJNht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 08:37:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76CE514F282
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 05:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646919407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B8DIEevWYvuYglJFjyQWsQEqu5VB35wMbcBWRZHjc4g=;
        b=OVzj/u0vea9Ey+kGL1pZBj4cQXxUtXa/Nr/cW2j4L6nIq4Sdab51TYsqguO1j+Ch39TPUd
        yPa2ijlSNJcbNL/y7J1mKrNpn7U3zRdrBCq2fZ6VyBQbGTrg14LCiphbffcZvMAmTQSmyN
        cceWrr6jeRUHBVjZm8161GLQSY1bKUQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-9N9800ZlOCmhow0BwbIhmg-1; Thu, 10 Mar 2022 08:36:44 -0500
X-MC-Unique: 9N9800ZlOCmhow0BwbIhmg-1
Received: by mail-wr1-f69.google.com with SMTP id n4-20020a5d4844000000b001f1ed76e943so1702534wrs.22
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 05:36:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=B8DIEevWYvuYglJFjyQWsQEqu5VB35wMbcBWRZHjc4g=;
        b=TxNDfPohHADJrrdy9utZ0AVVXfz+82Usm+L7dT5k1uOFNv6HeS7GFkLlZ6swq9xkDR
         uHBfCuUZG8PljXOFoFL3B8ZjYC71aYRzbMFGKR1N8uyxu3Y6CY65Yz0NnBsygVOoz3qD
         gDjcVQ9aoxA9wF2oGaRBSVU50cd6E9ZCCRThvEZMRQk+UJ1izlchk3b/RpJXlMDhhoaU
         g7Kk74vE/ZE9x9AYImguYjZ2z6Q0Xj4YJjDJWq3REkq0cjs229W2pC6Mm6cTwdfGv6F2
         nlovo/BbUd/LzoWzmMlLIVBJC9yyGP7cQ8fBVgKQVybkd9yFiiRHEsUDFxDTqniN1f3o
         tVGA==
X-Gm-Message-State: AOAM530ACEbTiExGt4DqlvrY3NJzCM79J9rJCMJVtfoQJXMQKdxrX+L2
        N7qVYGQKRWkJS5UGWuXUKjhX5c0ZHpFOAtPPy0WA77XhAjH0ItNsPl3IDHG6TDDobDCKK6gDqHE
        RXfDgjoGUwsmAuWxW/eLhuXT+
X-Received: by 2002:a5d:64af:0:b0:203:88d0:716e with SMTP id m15-20020a5d64af000000b0020388d0716emr2293137wrp.327.1646919403153;
        Thu, 10 Mar 2022 05:36:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwuoJ4lMptl/9JtRj644DNUVPlOVcLNnwLXnsnQ/usq1lertQQMLVXHPv/RU79B5g3EKng7UA==
X-Received: by 2002:a5d:64af:0:b0:203:88d0:716e with SMTP id m15-20020a5d64af000000b0020388d0716emr2293118wrp.327.1646919402923;
        Thu, 10 Mar 2022 05:36:42 -0800 (PST)
Received: from sgarzare-redhat (host-212-171-187-184.pool212171.interbusiness.it. [212.171.187.184])
        by smtp.gmail.com with ESMTPSA id 9-20020a1c0209000000b003868897278asm6818979wmc.23.2022.03.10.05.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 05:36:42 -0800 (PST)
Date:   Thu, 10 Mar 2022 14:36:38 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jiyong Park <jiyong@google.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, adelva@google.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vsock: each transport cycles only on its own sockets
Message-ID: <20220310133638.qe7eevwsmcbku2mc@sgarzare-redhat>
References: <20220310132830.88203-1-jiyong@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220310132830.88203-1-jiyong@google.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 10:28:29PM +0900, Jiyong Park wrote:
>When iterating over sockets using vsock_for_each_connected_socket, make
>sure that a transport filters out sockets that don't belong to the
>transport.
>
>There actually was an issue caused by this; in a nested VM
>configuration, destroying the nested VM (which often involves the
>closing of /dev/vhost-vsock if there was h2g connections to the nested
>VM) kills not only the h2g connections, but also all existing g2h
>connections to the (outmost) host which are totally unrelated.
>
>Tested: Executed the following steps on Cuttlefish (Android running on a
>VM) [1]: (1) Enter into an `adb shell` session - to have a g2h
>connection inside the VM, (2) open and then close /dev/vhost-vsock by
>`exec 3< /dev/vhost-vsock && exec 3<&-`, (3) observe that the adb
>session is not reset.
>
>[1] https://android.googlesource.com/device/google/cuttlefish/
>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Signed-off-by: Jiyong Park <jiyong@google.com>
>---
>Changes in v2:
>  - Squashed into a single patch
>
> drivers/vhost/vsock.c            | 3 ++-
> include/net/af_vsock.h           | 3 ++-
> net/vmw_vsock/af_vsock.c         | 9 +++++++--
> net/vmw_vsock/virtio_transport.c | 7 +++++--
> net/vmw_vsock/vmci_transport.c   | 3 ++-
> 5 files changed, 18 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 37f0b4274113..e6c9d41db1de 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -753,7 +753,8 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
>
> 	/* Iterating over all connections for all CIDs to find orphans is
> 	 * inefficient.  Room for improvement here. */
>-	vsock_for_each_connected_socket(vhost_vsock_reset_orphans);
>+	vsock_for_each_connected_socket(&vhost_transport.transport,
>+					vhost_vsock_reset_orphans);
>
> 	/* Don't check the owner, because we are in the release path, so we
> 	 * need to stop the vsock device in any case.
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index ab207677e0a8..f742e50207fb 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -205,7 +205,8 @@ struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr);
> struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
> 					 struct sockaddr_vm *dst);
> void vsock_remove_sock(struct vsock_sock *vsk);
>-void vsock_for_each_connected_socket(void (*fn)(struct sock *sk));
>+void vsock_for_each_connected_socket(struct vsock_transport *transport,
>+				     void (*fn)(struct sock *sk));
> int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
> bool vsock_find_cid(unsigned int cid);
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 38baeb189d4e..f04abf662ec6 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -334,7 +334,8 @@ void vsock_remove_sock(struct vsock_sock *vsk)
> }
> EXPORT_SYMBOL_GPL(vsock_remove_sock);
>
>-void vsock_for_each_connected_socket(void (*fn)(struct sock *sk))
>+void vsock_for_each_connected_socket(struct vsock_transport *transport,
>+				     void (*fn)(struct sock *sk))
> {
> 	int i;
>
>@@ -343,8 +344,12 @@ void vsock_for_each_connected_socket(void (*fn)(struct sock *sk))
> 	for (i = 0; i < ARRAY_SIZE(vsock_connected_table); i++) {
> 		struct vsock_sock *vsk;
> 		list_for_each_entry(vsk, &vsock_connected_table[i],
>-				    connected_table)
>+				    connected_table) {
>+			if (vsk->transport != transport)
>+				continue;
>+
> 			fn(sk_vsock(vsk));
>+		}
> 	}
>
> 	spin_unlock_bh(&vsock_table_lock);
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index fb3302fff627..5afc194a58bb 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -24,6 +24,7 @@
> static struct workqueue_struct *virtio_vsock_workqueue;
> static struct virtio_vsock __rcu *the_virtio_vsock;
> static DEFINE_MUTEX(the_virtio_vsock_mutex); /* protects the_virtio_vsock */
>+static struct virtio_transport virtio_transport; /* forward declaration */
>
> struct virtio_vsock {
> 	struct virtio_device *vdev;
>@@ -384,7 +385,8 @@ static void virtio_vsock_event_handle(struct virtio_vsock *vsock,
> 	switch (le32_to_cpu(event->id)) {
> 	case VIRTIO_VSOCK_EVENT_TRANSPORT_RESET:
> 		virtio_vsock_update_guest_cid(vsock);
>-		vsock_for_each_connected_socket(virtio_vsock_reset_sock);
>+		vsock_for_each_connected_socket(&virtio_transport.transport,
>+						virtio_vsock_reset_sock);
> 		break;
> 	}
> }
>@@ -662,7 +664,8 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
> 	synchronize_rcu();
>
> 	/* Reset all connected sockets when the device disappear */
>-	vsock_for_each_connected_socket(virtio_vsock_reset_sock);
>+	vsock_for_each_connected_socket(&virtio_transport.transport,
>+					virtio_vsock_reset_sock);
>
> 	/* Stop all work handlers to make sure no one is accessing the device,
> 	 * so we can safely call virtio_reset_device().
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index 7aef34e32bdf..735d5e14608a 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -882,7 +882,8 @@ static void vmci_transport_qp_resumed_cb(u32 sub_id,
> 					 const struct vmci_event_data *e_data,
> 					 void *client_data)
> {
>-	vsock_for_each_connected_socket(vmci_transport_handle_detach);
>+	vsock_for_each_connected_socket(&vmci_transport,
>+					vmci_transport_handle_detach);
> }
>
> static void vmci_transport_recv_pkt_work(struct work_struct *work)

This breaks the build of vmci-transport:

../net/vmw_vsock/vmci_transport.c: In function ‘vmci_transport_qp_resumed_cb’:
../net/vmw_vsock/vmci_transport.c:885:42: error: ‘vmci_transport’ undeclared (first use in this function)
   885 |         vsock_for_each_connected_socket(&vmci_transport,
       |                                          ^~~~~~~~~~~~~~
../net/vmw_vsock/vmci_transport.c:885:42: note: each undeclared identifier is reported only once for each function it appears in


Stefano

