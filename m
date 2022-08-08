Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2919C58C64E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242547AbiHHKXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242446AbiHHKXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:23:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D61B612AC1
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 03:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659954227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CZ+7qMtAooG6dh841vB4xXZOc4YcIi/wWT2HlYib+T4=;
        b=ZycgCR8hdsG9QNG4pRzDFFbZxv5bk4c6N2WUcWNTueflOhRu38XAEz20HHIZbuguLIKidB
        gziOahRPbop4bXKkM8ords/mp9zTRMG5K0dVUif/ZKKWJ9fIFqANumlWzseL/eW0BDefeE
        0W7ALKQe2UQ7bi4q0Q2QNpBysl7u6l0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-oAd0LkWdOL-SvIGw3LJGgw-1; Mon, 08 Aug 2022 06:23:46 -0400
X-MC-Unique: oAd0LkWdOL-SvIGw3LJGgw-1
Received: by mail-qt1-f199.google.com with SMTP id e30-20020ac8011e000000b00342f61e67aeso2651867qtg.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 03:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=CZ+7qMtAooG6dh841vB4xXZOc4YcIi/wWT2HlYib+T4=;
        b=nvvAUrj+5GOfIGzLE3WfOTOjxlAU76iSqz3Nd+zJGjWT51jTmNiM2SEIfMro3xLJf+
         HetY0O6p0GqN3JM1XjLQYM/WTzQBAh+0zv04MqglL8IIWQar/djwWLonIVqtwBNFdhOL
         jxlaK16oq1ceBQEgUezUDEFqMr/HxtUIFeJ+6dC/YPYCChS4c9lbKSUoQi0GrBg1yofX
         /fzTYbOLILLN/5T4l3TN4EaLNK2vmOztA+hgCd4J8NFrZerGQBsX75I6LwN+ozerddvZ
         5yIoU5sWlL0bGmG6gjN9asEfgHpihaey2M2Zk8cWcUgfTjRRTBw3Q6+54AuJNUfVek07
         oaFg==
X-Gm-Message-State: ACgBeo1sRKQTOIhgeJf/I3VwxJc6HqhWBxRucevuJYzruUhNPAjwLlJs
        Mdujt5ndcNKJ1O1cDq5NNDFui1AVUxqk6oVZNTSSqD9Buz6RSQDuIrXrkaudRQ5lj7JyRn3InOF
        WSB8i5fk0lwil8BzM/4Je/PaQ
X-Received: by 2002:ac8:7d4e:0:b0:31f:33db:69bc with SMTP id h14-20020ac87d4e000000b0031f33db69bcmr15622447qtb.482.1659954226109;
        Mon, 08 Aug 2022 03:23:46 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6JBzf5xAfbbDtzMbPLn2U0H6BGM6n6lSlv4ISjtq6rY6A09Oo3blf5b3eQhOOQ/S3L7JLDWA==
X-Received: by 2002:ac8:7d4e:0:b0:31f:33db:69bc with SMTP id h14-20020ac87d4e000000b0031f33db69bcmr15622424qtb.482.1659954225867;
        Mon, 08 Aug 2022 03:23:45 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it. [79.46.200.178])
        by smtp.gmail.com with ESMTPSA id k5-20020a05620a414500b006b93ef659c3sm4308518qko.39.2022.08.08.03.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 03:23:44 -0700 (PDT)
Date:   Mon, 8 Aug 2022 12:23:35 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v3 1/9] vsock: SO_RCVLOWAT transport set callback
Message-ID: <20220808102335.nkviqobpgcmcaqhn@sgarzare-redhat>
References: <2ac35e2c-26a8-6f6d-2236-c4692600db9e@sberdevices.ru>
 <45822644-8e37-1625-5944-63fd5fc20dd3@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <45822644-8e37-1625-5944-63fd5fc20dd3@sberdevices.ru>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 01:51:05PM +0000, Arseniy Krasnov wrote:
>This adds transport specific callback for SO_RCVLOWAT, because in some
>transports it may be difficult to know current available number of bytes
>ready to read. Thus, when SO_RCVLOWAT is set, transport may reject it.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> include/net/af_vsock.h   |  1 +
> net/vmw_vsock/af_vsock.c | 25 +++++++++++++++++++++++++
> 2 files changed, 26 insertions(+)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index f742e50207fb..eae5874bae35 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -134,6 +134,7 @@ struct vsock_transport {
> 	u64 (*stream_rcvhiwat)(struct vsock_sock *);
> 	bool (*stream_is_active)(struct vsock_sock *);
> 	bool (*stream_allow)(u32 cid, u32 port);
>+	int (*set_rcvlowat)(struct vsock_sock *, int);

checkpatch suggests to add identifier names. For some we put them in, 
for others we didn't, but I suggest putting them in for the new ones 
because I think it's clearer too.

WARNING: function definition argument 'struct vsock_sock *' should also 
have an identifier name
#25: FILE: include/net/af_vsock.h:137:
+	int (*set_rcvlowat)(struct vsock_sock *, int);

WARNING: function definition argument 'int' should also have an identifier name
#25: FILE: include/net/af_vsock.h:137:
+	int (*set_rcvlowat)(struct vsock_sock *, int);

total: 0 errors, 2 warnings, 0 checks, 44 lines checked

>
> 	/* SEQ_PACKET. */
> 	ssize_t (*seqpacket_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index f04abf662ec6..016ad5ff78b7 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2129,6 +2129,30 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 	return err;
> }
>
>+static int vsock_set_rcvlowat(struct sock *sk, int val)
>+{
>+	const struct vsock_transport *transport;
>+	struct vsock_sock *vsk;
>+	int err = 0;
>+
>+	vsk = vsock_sk(sk);
>+
>+	if (val > vsk->buffer_size)
>+		return -EINVAL;
>+
>+	transport = vsk->transport;
>+
>+	if (!transport)
>+		return -EOPNOTSUPP;

I don't know whether it is better in this case to write it in 
sk->sk_rcvlowat, maybe we can return EOPNOTSUPP only when the trasport 
is assigned and set_rcvlowat is not defined. This is because usually the 
options are set just after creation, when the transport is practically 
unassigned.

I mean something like this:

         if (transport) {
                 if (transport->set_rcvlowat)
                         return transport->set_rcvlowat(vsk, val);
                 else
                         return -EOPNOTSUPP;
         }

         WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);

         return 0;

>+
>+	if (transport->set_rcvlowat)
>+		err = transport->set_rcvlowat(vsk, val);
>+	else
>+		WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);
>+
>+	return err;
>+}
>+
> static const struct proto_ops vsock_stream_ops = {
> 	.family = PF_VSOCK,
> 	.owner = THIS_MODULE,
>@@ -2148,6 +2172,7 @@ static const struct proto_ops vsock_stream_ops = {
> 	.recvmsg = vsock_connectible_recvmsg,
> 	.mmap = sock_no_mmap,
> 	.sendpage = sock_no_sendpage,
>+	.set_rcvlowat = vsock_set_rcvlowat,
> };
>
> static const struct proto_ops vsock_seqpacket_ops = {
>-- 
>2.25.1

