Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F22257B2D1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240112AbiGTIX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239724AbiGTIXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A65136C103
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658305400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WqWXkpMYDjGMkR6N048q9/Kkfh0q8LEuKcrhvdxBx9U=;
        b=hM4sCBCDK1fzZ3MJUCTImXsawh/y66NWsCaiLq//l/e3rNHatkBmu/TMaZIgKTJNerAAxI
        8fgGRAj7nw0lof+2j+kh5t6icz+WahgfpL+xd3U+kzFqvHtkDin/wFdVMaAIstLF6o4vCH
        wX/PG6iDZEpOqwayaYw1c9zOk3FxXlQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-j90_OfA2OPWADZmWx_GyTA-1; Wed, 20 Jul 2022 04:23:13 -0400
X-MC-Unique: j90_OfA2OPWADZmWx_GyTA-1
Received: by mail-wm1-f72.google.com with SMTP id h65-20020a1c2144000000b003a30cae106cso872589wmh.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WqWXkpMYDjGMkR6N048q9/Kkfh0q8LEuKcrhvdxBx9U=;
        b=XR3I8tU3Cll4FbDPYAa1t65RXObhzuHufqLkFMLE+iWsK/33rT03jSsi0ixquwwLJ1
         xe6KCm87Mf6OmI798FL5gJ/qibe04rDGI+Ug8in9p+bRmHJac/3xF1oUpLTTEJuxqJtO
         ehY4bWyvj4/u1qCTUu2q28ymqIRJKY0OvifFkKSfT8GaOIe6xhcvlvIqgsyzMgm+hUhy
         iZJEZ2QJoGWW/PKyFpJCNOSomJ6jaOqGdNURZ4O+iwNTFRKJp4M5eIKxp5YXO7zTd+2j
         XorFpmMEwZcfmTweO+WQTMSeimJsqU7ToHXIQ0dpGu23yCoPzQpSnl8KYldcBJr0H8Kd
         6EVQ==
X-Gm-Message-State: AJIora+0DuWXUQcm4o6WGTIRZd0d6XjDAfvMv7Uqqa7SzXaB2nlSpx2V
        ct+VvNPEBuN8eTKWBJmaDbAbNV6bhh9p6NRmZIRZSQH1RVzTsAPjruZl4RHysih+bu09Q6UINak
        yZQ9LE1PddjPTN3Ze5BQbKWLY
X-Received: by 2002:a05:600c:3227:b0:3a3:be7:2917 with SMTP id r39-20020a05600c322700b003a30be72917mr2760525wmp.83.1658305392299;
        Wed, 20 Jul 2022 01:23:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sk2lxdgaBkVc5Kem0cnAq2mfCBRvNA74098gzKOVACYFwhUlWyh6yfDCAwDcJmLBObthn+bA==
X-Received: by 2002:a05:600c:3227:b0:3a3:be7:2917 with SMTP id r39-20020a05600c322700b003a30be72917mr2760502wmp.83.1658305392025;
        Wed, 20 Jul 2022 01:23:12 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it. [79.46.200.178])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c4ec800b003a317ee3036sm1887541wmq.2.2022.07.20.01.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 01:23:11 -0700 (PDT)
Date:   Wed, 20 Jul 2022 10:23:07 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Dexuan Cui <decui@microsoft.com>
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
Message-ID: <20220720082307.djbf7qgnlsjmrxcf@sgarzare-redhat>
References: <c8de13b1-cbd8-e3e0-5728-f3c3648c69f7@sberdevices.ru>
 <358f8d52-fd88-ad2e-87e2-c64bfa516a58@sberdevices.ru>
 <20220719124857.akv25sgp6np3pdaw@sgarzare-redhat>
 <15f38fcf-f1ff-3aad-4c30-4436bb8c4c44@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15f38fcf-f1ff-3aad-4c30-4436bb8c4c44@sberdevices.ru>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 05:38:03AM +0000, Arseniy Krasnov wrote:
>On 19.07.2022 15:48, Stefano Garzarella wrote:
>> On Mon, Jul 18, 2022 at 08:17:31AM +0000, Arseniy Krasnov wrote:
>>> This callback controls setting of POLLIN,POLLRDNORM output bits
>>> of poll() syscall,but in some cases,it is incorrectly to set it,
>>> when socket has at least 1 bytes of available data. Use 'target'
>>> which is already exists and equal to sk_rcvlowat in this case.
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>> net/vmw_vsock/virtio_transport_common.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>> index ec2c2afbf0d0..591908740992 100644
>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>> @@ -634,7 +634,7 @@ virtio_transport_notify_poll_in(struct vsock_sock *vsk,
>>>                 size_t target,
>>>                 bool *data_ready_now)
>>> {
>>> -    if (vsock_stream_has_data(vsk))
>>> +    if (vsock_stream_has_data(vsk) >= target)
>>>         *data_ready_now = true;
>>>     else
>>>         *data_ready_now = false;
>>
>> Perhaps we can take the opportunity to clean up the code in this way:
>>
>>     *data_ready_now = vsock_stream_has_data(vsk) >= target;
>Ack
>>
>> Anyway, I think we also need to fix the other transports (vmci and hyperv), what do you think?
>For vmci it is look clear to fix it. For hyperv i need to check it more, because it already
>uses some internal target value.

Yep, I see. Maybe you can pass `target` to hvs_channel_readable() and 
use it as parameter of HVS_PKT_LEN().

@Dexuan what do you think?

Thanks,
Stefano

