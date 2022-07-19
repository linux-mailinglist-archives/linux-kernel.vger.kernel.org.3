Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88426579FBB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbiGSNeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237515AbiGSNee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:34:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C3488E6F0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658234948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SQ7i8DMmDNLQBzOxesas/9REVBIK8tkfXNsEsnI0ryg=;
        b=Rq/ifcv1AdJVs/VpkGcVe41ohxb3Kbj8iReyWfnJSZyXk68CNlk6LQY42wQ3cYdYWewDaK
        r2V7PzCSg3nUevyy5XJ5e/at/wSys11hGMcwMJiIVrIb9Ia79KTLZrZJG6B2yk9+0XNX90
        vejHKAFqaeVATduPEcXFPQi0Jj/f9iU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-HldKJFIKNCazhkVptSN6_g-1; Tue, 19 Jul 2022 08:49:07 -0400
X-MC-Unique: HldKJFIKNCazhkVptSN6_g-1
Received: by mail-qk1-f200.google.com with SMTP id i15-20020a05620a404f00b006b55998179bso11618875qko.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SQ7i8DMmDNLQBzOxesas/9REVBIK8tkfXNsEsnI0ryg=;
        b=PSiZO1nDH085BFcHZkNNS81TmUAJfgUdrmhDKgK5uYSp4Ob/wdyqhHcOEKOn/irMDH
         7ZT/B/AGrY/nyAHKaE53ZhA8C1Fp5D/17M64veq+AGs+f7/k/l3yWP8bggGKU5yWxySW
         9jqzYtTAyNsMoBRpX0P68LAVRF01HjE0JBCdeArkU0REgjOhvf3gAojxJP8EbWh0apDu
         qr0YITNlGyaUVVSGWMUn/xGSsYKaqqkWDqB8dM3zGMrFFcjI3dhh91Jqocu2wosA64Md
         zar+XVzv7LMUb1iTz6sUnDiIa7LO+1w0MvqM+OKGZJfzYmYh6cLhV6qyRV4BLszyMFW7
         7xMA==
X-Gm-Message-State: AJIora/zOALviKcuPh668khCtJLwvwXAolicdqwaqQSbWatgi/p2iDey
        AYzaYElfH5TXuKagc+gCPixbnzXEr7gHDOA3aRugpGGe+bTI3V5jQdrRSX28y8QEmIoY4XtKx3B
        HaelhpC0pZNfz5GrbXy15fSB3
X-Received: by 2002:a05:6214:5285:b0:472:ed70:23a0 with SMTP id kj5-20020a056214528500b00472ed7023a0mr24653528qvb.121.1658234946739;
        Tue, 19 Jul 2022 05:49:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uZuaMPjQgfS6W9/DnlaK0uE0XgUkrEb2ofE1GV4HHuSsM3Xbj6XHQUCZkbhYbWbuoG/U//nQ==
X-Received: by 2002:a05:6214:5285:b0:472:ed70:23a0 with SMTP id kj5-20020a056214528500b00472ed7023a0mr24653509qvb.121.1658234946505;
        Tue, 19 Jul 2022 05:49:06 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it. [79.46.200.178])
        by smtp.gmail.com with ESMTPSA id dm53-20020a05620a1d7500b006b4880b08a9sm14522441qkb.88.2022.07.19.05.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 05:49:05 -0700 (PDT)
Date:   Tue, 19 Jul 2022 14:48:57 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v1 2/3] virtio/vsock: use 'target' in notify_poll_in,
 callback.
Message-ID: <20220719124857.akv25sgp6np3pdaw@sgarzare-redhat>
References: <c8de13b1-cbd8-e3e0-5728-f3c3648c69f7@sberdevices.ru>
 <358f8d52-fd88-ad2e-87e2-c64bfa516a58@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <358f8d52-fd88-ad2e-87e2-c64bfa516a58@sberdevices.ru>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 08:17:31AM +0000, Arseniy Krasnov wrote:
>This callback controls setting of POLLIN,POLLRDNORM output bits
>of poll() syscall,but in some cases,it is incorrectly to set it,
>when socket has at least 1 bytes of available data. Use 'target'
>which is already exists and equal to sk_rcvlowat in this case.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index ec2c2afbf0d0..591908740992 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -634,7 +634,7 @@ virtio_transport_notify_poll_in(struct vsock_sock *vsk,
> 				size_t target,
> 				bool *data_ready_now)
> {
>-	if (vsock_stream_has_data(vsk))
>+	if (vsock_stream_has_data(vsk) >= target)
> 		*data_ready_now = true;
> 	else
> 		*data_ready_now = false;

Perhaps we can take the opportunity to clean up the code in this way:

	*data_ready_now = vsock_stream_has_data(vsk) >= target;

Anyway, I think we also need to fix the other transports (vmci and 
hyperv), what do you think?

Thanks,
Stefano

