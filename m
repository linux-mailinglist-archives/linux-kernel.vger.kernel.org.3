Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158DE566420
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiGEHd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiGEHdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:33:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E5305F77
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657006402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hm4YXXqjJ9GWGedmDSj6+xlai172kqS8Ta7PZrgUG2A=;
        b=NLdb/7E6Rw7AgFKCpRauiLEcHlWgpxUeLPDylhqXKJJ0BxSUarGZr3QWxz3oA/Cz7tJ0aw
        X7W61MYBExhePqKpDBL820ufqBCiFkSt2uIL/K29DETHLHZM8hP+qfAs3FyiuwWQAmAcj/
        S6Nj39M406LeMxiSAEtt3GWhzEApuSQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-ec4SKyFKM5KWXdXBwK47rA-1; Tue, 05 Jul 2022 03:33:21 -0400
X-MC-Unique: ec4SKyFKM5KWXdXBwK47rA-1
Received: by mail-wm1-f69.google.com with SMTP id az40-20020a05600c602800b003a048edf007so4924509wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=hm4YXXqjJ9GWGedmDSj6+xlai172kqS8Ta7PZrgUG2A=;
        b=OUATWMo7ICGZXshc5i0APWnQJ1NofrKAy5fyo68knkbS27jYUA6ZsQII5nuVSFd0gA
         kGkHijhlrIzpTvo3v9CL+8LuJhuDXpRqv5RvP9Pt2BwJIIw6UuWzG8S05QrP1G+iJNAB
         Qd509qUhnD13NQGCEuj0Ym+2rChS/p1j21m+yrvAzndo8SCoi8jAm/HMvDWQ/LPAlPDG
         3i5AFzKL+Mtdd9/gFf6TMM5jdShyNcAv6/Ekof+oBs2GwJaDY2ImFDH7M4OPdBVyGune
         rxCBTfPMyUBTd2JKoMYXIaMN74qfWPdrzk8Z/ceXMulfeEO/3+p0c26k9jeQwYp4CRD4
         d2Jg==
X-Gm-Message-State: AJIora9sCl+0SyrLrGqa4ZyEBo/+XdY0v5fUR5voN6LFIyziNM+V+7VR
        Hhdp8ph+SJePgKhddOQs9TjjE/jCbG6wR9UQzyfk+6B7S/geyMYOMTSkITP+H2fxZhtvesRFxpH
        gqJqgXNcAftFy7vMdcCA5/8tY
X-Received: by 2002:adf:ea08:0:b0:21d:6dbf:6366 with SMTP id q8-20020adfea08000000b0021d6dbf6366mr5983060wrm.137.1657006398689;
        Tue, 05 Jul 2022 00:33:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t/2oTZjs0yRS3ZRoO9aKmpSN52vrsTYwhAqDF0ZKCRvEpstriKJM/NkUDtvQxy6Nh5FDr1QA==
X-Received: by 2002:adf:ea08:0:b0:21d:6dbf:6366 with SMTP id q8-20020adfea08000000b0021d6dbf6366mr5983026wrm.137.1657006398377;
        Tue, 05 Jul 2022 00:33:18 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-106-148.dyn.eolo.it. [146.241.106.148])
        by smtp.gmail.com with ESMTPSA id c2-20020adfe702000000b0021d69860b66sm6329438wrm.9.2022.07.05.00.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:33:18 -0700 (PDT)
Message-ID: <cd046e93a9783be5944cf15974afa534c94fb15e.camel@redhat.com>
Subject: Re: [net-next v4 1/4] seg6: add support for SRv6 H.Encaps.Red
 behavior
From:   Paolo Abeni <pabeni@redhat.com>
To:     Andrea Mayer <andrea.mayer@uniroma2.it>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Anton Makarov <anton.makarov11235@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels.dev@gmail.com>
Date:   Tue, 05 Jul 2022 09:33:16 +0200
In-Reply-To: <20220701150152.24103-2-andrea.mayer@uniroma2.it>
References: <20220701150152.24103-1-andrea.mayer@uniroma2.it>
         <20220701150152.24103-2-andrea.mayer@uniroma2.it>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-01 at 17:01 +0200, Andrea Mayer wrote:
> The SRv6 H.Encaps.Red behavior described in [1] is an optimization of
> the SRv6 H.Encaps behavior [2].
> 
> H.Encaps.Red reduces the length of the SRH by excluding the first
> segment (SID) in the SRH of the pushed IPv6 header. The first SID is
> only placed in the IPv6 Destination Address field of the pushed IPv6
> header.
> When the SRv6 Policy only contains one SID the SRH is omitted, unless
> there is an HMAC TLV to be carried.
> 
> [1] - https://datatracker.ietf.org/doc/html/rfc8986#section-5.2
> [2] - https://datatracker.ietf.org/doc/html/rfc8986#section-5.1
> 
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> Signed-off-by: Anton Makarov <anton.makarov11235@gmail.com>
> ---
>  include/uapi/linux/seg6_iptunnel.h |   1 +
>  net/ipv6/seg6_iptunnel.c           | 126 ++++++++++++++++++++++++++++-
>  2 files changed, 126 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/seg6_iptunnel.h b/include/uapi/linux/seg6_iptunnel.h
> index eb815e0d0ac3..538152a7b2c3 100644
> --- a/include/uapi/linux/seg6_iptunnel.h
> +++ b/include/uapi/linux/seg6_iptunnel.h
> @@ -35,6 +35,7 @@ enum {
>  	SEG6_IPTUN_MODE_INLINE,
>  	SEG6_IPTUN_MODE_ENCAP,
>  	SEG6_IPTUN_MODE_L2ENCAP,
> +	SEG6_IPTUN_MODE_ENCAP_RED,
>  };
>  
>  #endif
> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index d64855010948..4942073650d3 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c
> @@ -36,6 +36,7 @@ static size_t seg6_lwt_headroom(struct seg6_iptunnel_encap *tuninfo)
>  	case SEG6_IPTUN_MODE_INLINE:
>  		break;
>  	case SEG6_IPTUN_MODE_ENCAP:
> +	case SEG6_IPTUN_MODE_ENCAP_RED:
>  		head = sizeof(struct ipv6hdr);
>  		break;
>  	case SEG6_IPTUN_MODE_L2ENCAP:
> @@ -195,6 +196,122 @@ int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
>  }
>  EXPORT_SYMBOL_GPL(seg6_do_srh_encap);
>  
> +/* encapsulate an IPv6 packet within an outer IPv6 header with reduced SRH */
> +static int seg6_do_srh_encap_red(struct sk_buff *skb,
> +				 struct ipv6_sr_hdr *osrh, int proto)
> +{
> +	__u8 first_seg = osrh->first_segment;
> +	struct dst_entry *dst = skb_dst(skb);
> +	struct net *net = dev_net(dst->dev);
> +	struct ipv6hdr *hdr, *inner_hdr;
> +	int hdrlen = ipv6_optlen(osrh);
> +	int red_tlv_offset, tlv_offset;
> +	struct ipv6_sr_hdr *isrh;
> +	bool skip_srh = false;
> +	__be32 flowlabel;
> +	int tot_len, err;
> +	int red_hdrlen;
> +	int tlvs_len;
> +
> +	if (first_seg > 0) {
> +		red_hdrlen = hdrlen - sizeof(struct in6_addr);
> +	} else {
> +		/* NOTE: if tag/flags and/or other TLVs are introduced in the
> +		 * seg6_iptunnel infrastructure, they should be considered when
> +		 * deciding to skip the SRH.
> +		 */
> +		skip_srh = !sr_has_hmac(osrh);
> +
> +		red_hdrlen = skip_srh ? 0 : hdrlen;
> +	}
> +
> +	tot_len = red_hdrlen + sizeof(struct ipv6hdr);
> +
> +	err = skb_cow_head(skb, tot_len + skb->mac_len);
> +	if (unlikely(err))
> +		return err;
> +
> +	inner_hdr = ipv6_hdr(skb);
> +	flowlabel = seg6_make_flowlabel(net, skb, inner_hdr);
> +
> +	skb_push(skb, tot_len);
> +	skb_reset_network_header(skb);
> +	skb_mac_header_rebuild(skb);
> +	hdr = ipv6_hdr(skb);
> +
> +	/* based on seg6_do_srh_encap() */
> +	if (skb->protocol == htons(ETH_P_IPV6)) {
> +		ip6_flow_hdr(hdr, ip6_tclass(ip6_flowinfo(inner_hdr)),
> +			     flowlabel);
> +		hdr->hop_limit = inner_hdr->hop_limit;
> +	} else {
> +		ip6_flow_hdr(hdr, 0, flowlabel);
> +		hdr->hop_limit = ip6_dst_hoplimit(skb_dst(skb));
> +
> +		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
> +		IP6CB(skb)->iif = skb->skb_iif;
> +	}
> +
> +	/* no matter if we have to skip the SRH or not, the first segment
> +	 * always comes in the pushed IPv6 header.
> +	 */
> +	hdr->daddr = osrh->segments[first_seg];
> +
> +	if (skip_srh) {
> +		hdr->nexthdr = proto;
> +
> +		set_tun_src(net, dst->dev, &hdr->daddr, &hdr->saddr);
> +		goto out;
> +	}
> +
> +	/* we cannot skip the SRH, slow path */
> +
> +	hdr->nexthdr = NEXTHDR_ROUTING;
> +	isrh = (void *)hdr + sizeof(struct ipv6hdr);
> +
> +	if (unlikely(!first_seg)) {
> +		/* this is a very rare case; we have only one SID but
> +		 * we cannot skip the SRH since we are carrying some
> +		 * other info.
> +		 */
> +		memcpy(isrh, osrh, hdrlen);
> +		goto srcaddr;
> +	}
> +
> +	tlv_offset = sizeof(*osrh) + (first_seg + 1) * sizeof(struct in6_addr);
> +	red_tlv_offset = tlv_offset - sizeof(struct in6_addr);
> +
> +	memcpy(isrh, osrh, red_tlv_offset);
> +
> +	tlvs_len = hdrlen - tlv_offset;
> +	if (unlikely(tlvs_len > 0)) {
> +		const void *s = (const void *)osrh + tlv_offset;
> +		void *d = (void *)isrh + red_tlv_offset;
> +
> +		memcpy(d, s, tlvs_len);
> +	}
> +
> +	--isrh->first_segment;
> +	isrh->hdrlen -= 2;
> +
> +srcaddr:
> +	isrh->nexthdr = proto;
> +	set_tun_src(net, dst->dev, &hdr->daddr, &hdr->saddr);
> +
> +#ifdef CONFIG_IPV6_SEG6_HMAC
> +	if (unlikely(!skip_srh && sr_has_hmac(isrh))) {
> +		err = seg6_push_hmac(net, &hdr->saddr, isrh);
> +		if (unlikely(err))
> +			return err;
> +	}
> +#endif
> +
> +out:
> +	skb_postpush_rcsum(skb, hdr, tot_len);

It looks like, at this point hdr->payload_len is not initialized yet -
it will be set later by the caller. So the above will corrupt the
checksum complete.

I think the solution is moving 'payload_len' initialization before the
csum update. Note that 'seg6_do_srh_encap' has a similar issue.

Paolo

