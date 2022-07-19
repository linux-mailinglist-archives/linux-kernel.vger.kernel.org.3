Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDBE579F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239677AbiGSN3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239630AbiGSN2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:28:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D97DA84ED9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658234680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nwoURb29VClO3NnOpfstDR3d53hCEYhJJWEs1w35jSE=;
        b=Lsr2t1MhPK7rsygzSoiCs7YiMfQrlv/MmxOOLM/xtwVHHJIlvzkaXUIGJqIFKJaApNkfeQ
        HvC1OMWj4v0bKQxuOAP8u3PNKclzWfS27LdHEIsSyuoUaP5R7m84NaeebAE4hjdFX679pJ
        0yx/MkKj+H6AeLMl7tpLJ/WYx9mdc9c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-269-sBA4hBnENOmxxblaS6T8EQ-1; Tue, 19 Jul 2022 08:44:38 -0400
X-MC-Unique: sBA4hBnENOmxxblaS6T8EQ-1
Received: by mail-qk1-f198.google.com with SMTP id k190-20020a37bac7000000b006af6d953751so11733515qkf.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nwoURb29VClO3NnOpfstDR3d53hCEYhJJWEs1w35jSE=;
        b=QuuZoBwenwDst7Gki/s+2PiYxksRE4ouXsMD7pF2iWvCvbgv7PSFoZK3lSPu+bGRsm
         249g7GONhOxf0jXLdE8n9TOcjKXUOkm4T9awrLRNagzdkJ9q39UpMs5o6s4dvxgICr7y
         9FyH6LSdwhIc9JRWkASdnXF/hlrlhzyPqbcI9HUwU+UTgDoTIHkOS+Ct333Jvxk6m6Lk
         /5KrMGAn9/LdKg4lpLrZio6TK5ED5Xnj54A1+VWbYxFKRZm0KlfqS0YDGojREndRJCAP
         GOtOBqVvMMpXC9HyBwC9aNM9O8oAIdIgtnU9lTzlmF3opqLTOwvRFcuUq+cEkjxI08Zz
         ltbg==
X-Gm-Message-State: AJIora9zyobvtPUtKqn5vhcPiUgzH86OgXnm+fojIKp+WHw172G5GD5X
        Akaw5XPFnePLZ50bdS1cSiik5cDnhPbtoKNAAl18/53GCI/uRIxzw17w2LgG4bIB3NdeLtzaRTR
        S7jg69j+m5J8n6e3Kam9WaWdf
X-Received: by 2002:a05:620a:4409:b0:6b5:9563:2357 with SMTP id v9-20020a05620a440900b006b595632357mr20517124qkp.394.1658234678312;
        Tue, 19 Jul 2022 05:44:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vfYt5xMGWnPHxRK79lORLDfPCOEjuG06J02WcZOiurWkTLl4+3VDRo/4HLmjvxNof1xrPgsQ==
X-Received: by 2002:a05:620a:4409:b0:6b5:9563:2357 with SMTP id v9-20020a05620a440900b006b595632357mr20517108qkp.394.1658234678086;
        Tue, 19 Jul 2022 05:44:38 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it. [79.46.200.178])
        by smtp.gmail.com with ESMTPSA id t13-20020a37ea0d000000b006af147d4876sm13363159qkj.30.2022.07.19.05.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 05:44:37 -0700 (PDT)
Date:   Tue, 19 Jul 2022 14:44:29 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v1 1/3] vsock: use sk_skrcvlowat to set
 POLLIN,POLLRDNORM, bits.
Message-ID: <20220719124429.3y5hi7itx4hdkqbz@sgarzare-redhat>
References: <c8de13b1-cbd8-e3e0-5728-f3c3648c69f7@sberdevices.ru>
 <637e945f-f28a-86d9-a242-1f4be85d9840@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <637e945f-f28a-86d9-a242-1f4be85d9840@sberdevices.ru>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 08:15:42AM +0000, Arseniy Krasnov wrote:
>Both bits indicate, that next data read call won't be blocked,
>but when sk_rcvlowat is not 1,these bits will be set by poll
>anyway,thus when user tries to dequeue data, it will wait until
>sk_rcvlowat bytes of data will be available.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/af_vsock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index f04abf662ec6..0225f3558e30 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1067,7 +1067,7 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> 		    !(sk->sk_shutdown & RCV_SHUTDOWN)) {
> 			bool data_ready_now = false;
> 			int ret = transport->notify_poll_in(
>-					vsk, 1, &data_ready_now);
>+					vsk, sk->sk_rcvlowat, &data_ready_now);

In tcp_poll() we have the following:
     int target = sock_rcvlowat(sk, 0, INT_MAX);

Maybe we can do the same here.

Thanks,
Stefano

> 			if (ret < 0) {
> 				mask |= EPOLLERR;
> 			} else {
>-- 
>2.25.1

