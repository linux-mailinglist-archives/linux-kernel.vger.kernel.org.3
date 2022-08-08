Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEC658C680
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242560AbiHHKeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242453AbiHHKeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:34:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEBB56241
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 03:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659954843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S0oiLh71RSIVoaGi+EfAcjkjFhoW+EB960Go0IldyoM=;
        b=iEpMmpww3xTIrCfbcwS+xbvFCBVd4i/Bmeyo8QGxA/hLWrWC33V8JN+1hrf3zQTWpFleeJ
        zlM+mOHgY+DH7YgA3G3TeZONvOMDkgg2wh6gGIOK7k91vSnwQFClF34wyAv/ZcFULbb3Qc
        tnMa8GSgnbFhFtRyOKyGCLKNJaPmrqQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-w71QbqEMO5Ww87Xf87eZ8g-1; Mon, 08 Aug 2022 06:34:02 -0400
X-MC-Unique: w71QbqEMO5Ww87Xf87eZ8g-1
Received: by mail-qt1-f198.google.com with SMTP id s2-20020ac85cc2000000b00342f8ad1f40so1798146qta.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 03:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=S0oiLh71RSIVoaGi+EfAcjkjFhoW+EB960Go0IldyoM=;
        b=HitBJ3rIojHaDRAF9UbM94DUm7bTGZeFq3O1CgpbN9nou/XeAOxDQW+vhE79CXlWYg
         cgr9bpRGT9Z21hy9SJpQknWPTHcZy/iGybsEclAfHs7Cb3Y8F62TbcZ/gahSxreWuySt
         GGiHz4SbC+AliDfmMbwdJhBBKvpAWnbN8D18cdviteVCQGKlrmxy1jUkf1dbDcGs1XGb
         riokzT/kvqpAghjuBozQSUge0ExVUTi/1R4eQIhbWz62cxSkht50p0VoOvvmj1qmO9Ok
         3wt76nQCiE06N6NhvNshgdY30+gWjTLSm6rhXQnvPpxKggXp2ibpKhdhBf6RlyCJD1wN
         Pb6w==
X-Gm-Message-State: ACgBeo3rlzjJ70RafroS+NYYkBG4M4YRF+6R6DyqVKEZW224m1e4inWC
        oqjCyG8eI596IACZ8l+y/BgsupS98xzTL3OewoZo4AdhBrfhOu/GFdaoZYzwgJGTTKLXrUUh2wm
        X91oBu7mtWb0nHfJPlKiJ97zP
X-Received: by 2002:ad4:596a:0:b0:476:7e0d:814d with SMTP id eq10-20020ad4596a000000b004767e0d814dmr14913657qvb.54.1659954842077;
        Mon, 08 Aug 2022 03:34:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5n5s+A4rSh6Kwr7qIkkTbJpQvidZHOgXQA0zDG1SXTSXmxFoSSj6EjiuYLIzJ7H46F5+fW3w==
X-Received: by 2002:ad4:596a:0:b0:476:7e0d:814d with SMTP id eq10-20020ad4596a000000b004767e0d814dmr14913632qvb.54.1659954841872;
        Mon, 08 Aug 2022 03:34:01 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it. [79.46.200.178])
        by smtp.gmail.com with ESMTPSA id bs30-20020a05620a471e00b006b9122642f5sm7589418qkb.75.2022.08.08.03.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 03:34:01 -0700 (PDT)
Date:   Mon, 8 Aug 2022 12:33:51 +0200
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
Subject: Re: [RFC PATCH v3 3/9] virtio/vsock: use 'target' in notify_poll_in
 callback
Message-ID: <20220808103351.gebdfctorobvbrow@sgarzare-redhat>
References: <2ac35e2c-26a8-6f6d-2236-c4692600db9e@sberdevices.ru>
 <a6844149-6ffc-09a6-b858-f24a27264c83@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a6844149-6ffc-09a6-b858-f24a27264c83@sberdevices.ru>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 01:55:36PM +0000, Arseniy Krasnov wrote:
>This callback controls setting of POLLIN,POLLRDNORM output bits of poll()
>syscall,but in some cases,it is incorrectly to set it, when socket has
>at least 1 bytes of available data. Use 'target' which is already exists
>and equal to sk_rcvlowat in this case.

Little suggestion:
We should update the commit description, since so far 'target' is not 
equal to sk_rcvlowat.

With that fixed (and adding some spaces after the commas):

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index ec2c2afbf0d0..8f6356ebcdd1 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -634,10 +634,7 @@ virtio_transport_notify_poll_in(struct vsock_sock *vsk,
> 				size_t target,
> 				bool *data_ready_now)
> {
>-	if (vsock_stream_has_data(vsk))
>-		*data_ready_now = true;
>-	else
>-		*data_ready_now = false;
>+	*data_ready_now = vsock_stream_has_data(vsk) >= target;
>
> 	return 0;
> }
>-- 
>2.25.1

