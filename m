Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18C75020D3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 05:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349114AbiDODDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 23:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349069AbiDODDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 23:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01C0DAA03C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 20:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649991644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tA0uDOIQJO8DmINdwnol/uT15UPPYSx+8xWvdjqUWss=;
        b=ZM4fGbnEuRmeKJmuV6e23kpn8Bu+GjGhrle2hqProu6DTfpyFhA+1x3AhZMUOGMYgBN/8Y
        fgFU2ATfxc2VlYswxRYZccupCqxmxT91IpCg6YeQ6LiYra3nDzOHFQ2E+3mC2uWoQVnfIi
        l3+04b69K5QILe+8ojPCuPupDTS2FGo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-otMX9rUmME6eoGlKdgpbBg-1; Thu, 14 Apr 2022 23:00:42 -0400
X-MC-Unique: otMX9rUmME6eoGlKdgpbBg-1
Received: by mail-pj1-f70.google.com with SMTP id v14-20020a17090a0c8e00b001cb778cc439so3794886pja.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 20:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tA0uDOIQJO8DmINdwnol/uT15UPPYSx+8xWvdjqUWss=;
        b=zlcU/7jq3B3tkFr1MPEGbhdNo1YyORFkPlPM/EyBEfsMCiLLz/3kcz2JtJ5ypQSfqs
         woN+mB8nplCOOjwNCTjSgD/+ay3v/dEt+N4tjsAeVZk/tFSECEnA7Tw3zyyM7fVqyni0
         +38L7tIHM5q7MmZhj1FpFWgItjGFGO3W+6ZqtJ3oi+Bh4QPqfxcJpZJRXRfNsY1WA9yU
         cC0WHeUcDoyELOQ0rTc/iiIzwUm+gSifFdmXHUrnMvfxSv98oNEPF/ff5oakXbch93B4
         c0dK1Xru4NozTyMZzQSxOeraMUILge31PRe7xfcPlc4lzqnnjdjL3Esp/tTK5F6TlrFX
         iRWQ==
X-Gm-Message-State: AOAM531A71FbgFwjANdIhdWGGH0BdaxA633PH0i/gw4obbes1A0Vfgha
        xqaw6VTld6UCaWKV4G/dxqSE6syBNiNyHAPLEcaPTjYSrs/NRqNxg8LtwLQIKV4uQKE8v8D+SzH
        yGEFTIyd5rCNjwZSFDr0S1SCY
X-Received: by 2002:a17:903:3014:b0:158:921b:6ebe with SMTP id o20-20020a170903301400b00158921b6ebemr13621627pla.164.1649991641864;
        Thu, 14 Apr 2022 20:00:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyBudUwUFp5mBEDDIs5/uq0/x9ilfdL7IEMpmHyK5nTFf0nJ5B53+sjXRM1FKAUPSg5wPhfg==
X-Received: by 2002:a17:903:3014:b0:158:921b:6ebe with SMTP id o20-20020a170903301400b00158921b6ebemr13621599pla.164.1649991641471;
        Thu, 14 Apr 2022 20:00:41 -0700 (PDT)
Received: from [10.72.13.51] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w13-20020a17090a5e0d00b001c7d4099670sm3190794pjf.28.2022.04.14.20.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 20:00:40 -0700 (PDT)
Message-ID: <87985be4-8cb0-2292-d799-5a91fb32acda@redhat.com>
Date:   Fri, 15 Apr 2022 11:00:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH 2/3] virtio_net: Add control VQ struct to carry vlan id
Content-Language: en-US
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, si-wei.liu@oracle.com
References: <20220411122942.225717-1-elic@nvidia.com>
 <20220411122942.225717-3-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220411122942.225717-3-elic@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/4/11 20:29, Eli Cohen 写道:
> Add structure to define the payload of control VQ messages carrying the
> configured vlan ID. It will be used in subsequent patches of this
> series.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   include/uapi/linux/virtio_net.h | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index 3f55a4215f11..b94a405fa8d2 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -270,6 +270,9 @@ struct virtio_net_ctrl_mac {
>   #define VIRTIO_NET_CTRL_VLAN       2
>    #define VIRTIO_NET_CTRL_VLAN_ADD             0
>    #define VIRTIO_NET_CTRL_VLAN_DEL             1
> +struct virtio_net_ctrl_vlan {
> +	__virtio16 id;
> +};


It looks to me there's no need to bother uAPI and we can simply use 
__virtio16 in patch 3?

Thanks


>   
>   /*
>    * Control link announce acknowledgement

