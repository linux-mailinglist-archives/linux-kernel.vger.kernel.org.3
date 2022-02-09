Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87E34AE8C2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiBIFHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:07:16 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377810AbiBIElT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 23:41:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E00CC061578
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 20:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644381677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MFWmdw6agML5Lvp7n8TEaUNHHxhduLe2TaxIAnf1RnY=;
        b=H85f/ZHElrZsagJ7Z5dzJXtrK69eI8Q9/Gpm5VpuHcJdD7LcEyVDvhDIpEGmDfjBxxxYkP
        lRh1NU9NhiFnLP34W1mRY3g8vNxrY0qFF3fgOS00Q371UYuPDgNU6WVqaOkaUlaZ7Cbv+m
        iGl0fIObI2lS0G4ZsiGIBI36JlLCFtA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-GZIRS1mWMNGj30O6Ni3giQ-1; Tue, 08 Feb 2022 23:41:16 -0500
X-MC-Unique: GZIRS1mWMNGj30O6Ni3giQ-1
Received: by mail-pl1-f197.google.com with SMTP id f9-20020a170902684900b0014cd6059ecdso946678pln.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 20:41:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MFWmdw6agML5Lvp7n8TEaUNHHxhduLe2TaxIAnf1RnY=;
        b=jf1L+WbD5lDJbv92aFD8iwL4l13NG7vgwc4pekgxR/Al65fc4cke58pRT2KlxmU0Ez
         MatiwdE4BSU0czFSS8E/Js/EzXwCdplYZh0WntOIobrYpUY6jCDUv9JNX+PKuqwceS75
         /yZqfHRFCxONR9CZq2mwf5UIGWPF5acaG5HCOXiqitRVTpyBXKFyB1u1PMyP7+9piCX6
         JtWgiVKZ5OVHrjqF6N/Td3z57eNml5vIv1baagFS4JR9Yhy8b1sFD9YxxS/6sQmtKVu1
         av/LIXaIpAteeCIusPRmHgDnUfKfdQPzTLF2II8CY8KUmBCLNVKApv/KnvgZgaP+g2v2
         s+pQ==
X-Gm-Message-State: AOAM530nvvPMCzEow1baibDesC8sLdxWqoTpphC/2Dz5KC8osKKA2Lm5
        2ZC0DBeQLX7+TthoSwYPx7ObcnaKQMxKQriNuOO/Gb2bZqsBRuc0mr7Pk5+Zr0TnhkBYTJlOt8a
        Bfhy93apWPi0x2NKzryam128C
X-Received: by 2002:a17:902:ce04:: with SMTP id k4mr488613plg.153.1644381674856;
        Tue, 08 Feb 2022 20:41:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJziDDW40ufTvoa4ZTNyDLcixnRVfaKgHb5Pf+PMQoswgukJOyKCv3mwEFbssbYa6ZkDWq3aMg==
X-Received: by 2002:a17:902:ce04:: with SMTP id k4mr488594plg.153.1644381674587;
        Tue, 08 Feb 2022 20:41:14 -0800 (PST)
Received: from [10.72.13.141] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q16sm17640261pfu.194.2022.02.08.20.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 20:41:13 -0800 (PST)
Message-ID: <158bf351-9ffd-39d0-8658-52d4667f781d@redhat.com>
Date:   Wed, 9 Feb 2022 12:41:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [RFC PATCH 3/5] uapi/linux/virtio_net.h: Added USO types.
Content-Language: en-US
To:     Andrew Melnychenko <andrew@daynix.com>, davem@davemloft.net,
        kuba@kernel.org, mst@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     yuri.benditovich@daynix.com, yan@daynix.com
References: <20220125084702.3636253-1-andrew@daynix.com>
 <20220125084702.3636253-4-andrew@daynix.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220125084702.3636253-4-andrew@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/1/25 下午4:47, Andrew Melnychenko 写道:
> Added new GSO type for USO: VIRTIO_NET_HDR_GSO_UDP_L4.
> Feature VIRTIO_NET_F_HOST_USO allows to enable NETIF_F_GSO_UDP_L4.
> Separated VIRTIO_NET_F_GUEST_USO4 & VIRTIO_NET_F_GUEST_USO6 features
> required for Windows guests.
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>   include/uapi/linux/virtio_net.h | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index 3f55a4215f11..620addc5767b 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -56,6 +56,9 @@
>   #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
>   					 * Steering */
>   #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> +#define VIRTIO_NET_F_GUEST_USO4	54	/* Guest can handle USOv4 in. */
> +#define VIRTIO_NET_F_GUEST_USO6	55	/* Guest can handle USOv6 in. */
> +#define VIRTIO_NET_F_HOST_USO	56	/* Host can handle USO in. */


I think it's better to be consistent here. Either we split in both guest 
and host or not.

Thanks


>   
>   #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
>   #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
> @@ -130,6 +133,7 @@ struct virtio_net_hdr_v1 {
>   #define VIRTIO_NET_HDR_GSO_TCPV4	1	/* GSO frame, IPv4 TCP (TSO) */
>   #define VIRTIO_NET_HDR_GSO_UDP		3	/* GSO frame, IPv4 UDP (UFO) */
>   #define VIRTIO_NET_HDR_GSO_TCPV6	4	/* GSO frame, IPv6 TCP */
> +#define VIRTIO_NET_HDR_GSO_UDP_L4	5	/* GSO frame, IPv4 & IPv6 UDP (USO) */
>   #define VIRTIO_NET_HDR_GSO_ECN		0x80	/* TCP has ECN set */
>   	__u8 gso_type;
>   	__virtio16 hdr_len;	/* Ethernet + IP + tcp/udp hdrs */

