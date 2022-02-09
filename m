Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5C64AE8BF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiBIFH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:07:26 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377840AbiBIEmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 23:42:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69B86C061578
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 20:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644381757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yaq4rpOgDgAbrBPGfd0R9MJrfvV414wZMPHWroYPN5k=;
        b=dqmztLxSewElP3eN/GBh0OFpryWHGPaVEkpum3NAtd8gQOLzOjgfpDIPnogNaYK0i9fFer
        yHjtSED1bZoSvqnkNXlzTnR/QB0Wsxfu20Lgn0rZZl4e9NGbRH3fk8lBCTgEpgAaIpoB54
        p/nevHVnv53zCQHuemIRtufAectbldc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-sqKnH_AgPq6liNK4Ed_5dg-1; Tue, 08 Feb 2022 23:42:34 -0500
X-MC-Unique: sqKnH_AgPq6liNK4Ed_5dg-1
Received: by mail-pl1-f200.google.com with SMTP id v20-20020a1709028d9400b0014ca63d0f10so952590plo.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 20:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yaq4rpOgDgAbrBPGfd0R9MJrfvV414wZMPHWroYPN5k=;
        b=MD3SUCm391benHquLiXzS2+FMsJZs7Hp0qmXFnD61AnRAWbUhYrUbgpPfuxPGoRQfu
         Nh5eDyWnKAeGtBChVQgk8JbkkBdQXW9dIfpoH/x4wS9UM/RIUgRqAz51df+REETIajJ2
         LafOifC28O3ILo20cltGt6tkf3+jyEDRz1Za5sgm6C0iuEyFjjfDEVHx8zlOvSrJL6cd
         agOo/vufeRqo3gA+BwgXXG3adnxLndrNd8GlvSsuVxk/zjAhKkb25C2RZGTp4zxOnvM1
         QjBV95vMBMPqZuskhe2c+He8JcpC3O4xCq98MkBOBr2kYHVYkir4NirWK1Yf5BGqLaca
         QSIg==
X-Gm-Message-State: AOAM532WnwH1lRn7ozDZyjnAoPmBjJmwlZ0yj0gUdanrgj93saWwVHyg
        /9AZHDk8fOhhDsLuf6qyI8GaxKNlaN0tKwc2wZLo0rxF7oJiOEqVaBo5bZVLvZF0vOLYYPrgU81
        mO2ZEmEU3MdDQNNUycW4fK+mM
X-Received: by 2002:a17:90a:fc6:: with SMTP id 64mr625896pjz.36.1644381753225;
        Tue, 08 Feb 2022 20:42:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybr0rixmXjHT+8KfaprN9MEJ5npqWoXnDzZIPoVnL2fUOHdcT9dt7lsJLeGDIgt0wSg3oZGw==
X-Received: by 2002:a17:90a:fc6:: with SMTP id 64mr625883pjz.36.1644381753000;
        Tue, 08 Feb 2022 20:42:33 -0800 (PST)
Received: from [10.72.13.141] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 16sm7028826pfm.200.2022.02.08.20.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 20:42:32 -0800 (PST)
Message-ID: <e5410a91-f9ac-6987-5de0-728a50431225@redhat.com>
Date:   Wed, 9 Feb 2022 12:42:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [RFC PATCH 4/5] linux/virtio_net.h: Added Support for GSO_UDP_L4
 offload.
Content-Language: en-US
To:     Andrew Melnychenko <andrew@daynix.com>, davem@davemloft.net,
        kuba@kernel.org, mst@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     yuri.benditovich@daynix.com, yan@daynix.com
References: <20220125084702.3636253-1-andrew@daynix.com>
 <20220125084702.3636253-5-andrew@daynix.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220125084702.3636253-5-andrew@daynix.com>
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
> Now, it's possible to convert vnet packets from/to skb.


I suggest to change the title to "net: support XXX offload in vnet header"

Thanks


>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>   include/linux/virtio_net.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index a960de68ac69..9311d41d0a81 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -17,6 +17,9 @@ static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
>   	case VIRTIO_NET_HDR_GSO_UDP:
>   		return protocol == cpu_to_be16(ETH_P_IP) ||
>   		       protocol == cpu_to_be16(ETH_P_IPV6);
> +	case VIRTIO_NET_HDR_GSO_UDP_L4:
> +		return protocol == cpu_to_be16(ETH_P_IP) ||
> +		       protocol == cpu_to_be16(ETH_P_IPV6);
>   	default:
>   		return false;
>   	}
> @@ -31,6 +34,7 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
>   	switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
>   	case VIRTIO_NET_HDR_GSO_TCPV4:
>   	case VIRTIO_NET_HDR_GSO_UDP:
> +	case VIRTIO_NET_HDR_GSO_UDP_L4:
>   		skb->protocol = cpu_to_be16(ETH_P_IP);
>   		break;
>   	case VIRTIO_NET_HDR_GSO_TCPV6:
> @@ -69,6 +73,11 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>   			ip_proto = IPPROTO_UDP;
>   			thlen = sizeof(struct udphdr);
>   			break;
> +		case VIRTIO_NET_HDR_GSO_UDP_L4:
> +			gso_type = SKB_GSO_UDP_L4;
> +			ip_proto = IPPROTO_UDP;
> +			thlen = sizeof(struct udphdr);
> +			break;
>   		default:
>   			return -EINVAL;
>   		}
> @@ -182,6 +191,8 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>   			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
>   		else if (sinfo->gso_type & SKB_GSO_TCPV6)
>   			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
> +		else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> +			hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
>   		else
>   			return -EINVAL;
>   		if (sinfo->gso_type & SKB_GSO_TCP_ECN)

