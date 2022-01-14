Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DD548EB00
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 14:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241417AbiANNok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 08:44:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30595 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241425AbiANNoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 08:44:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642167877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nfjFLSHiBQKga3FwXwxrCNc9DhWW0rRljO+uSdIGNDI=;
        b=eSlalJItA1fAVeZ4lPifC1zKADSLB1XFI24QmLbj/CORxM2iHCkLA/C9iltecnBJ2jvxbV
        iJ7kVrleBjitaKDkAL+9D7B2XjeuUNWqmSLgOZ4WsU+N/XTLkihUEiQ4q/ogWLOqzu9gze
        seFz3ufpxA2CKQ+kvZU75+eYUTRf7Es=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-QSY6WpR3MViWiHuHd4mlHw-1; Fri, 14 Jan 2022 08:44:35 -0500
X-MC-Unique: QSY6WpR3MViWiHuHd4mlHw-1
Received: by mail-ed1-f70.google.com with SMTP id y18-20020a056402271200b003fa16a5debcso8382208edd.14
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 05:44:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=nfjFLSHiBQKga3FwXwxrCNc9DhWW0rRljO+uSdIGNDI=;
        b=LXPZ0oEUyW6Yu9xQawMdaj/nIm5V+/dSQQtEqOmG0fSWsqRRwRDAm/H1DOZ36wVjEk
         0QInC7oFONgUMu0NwUpODQ8zNliL6281U28dwLw2eDm4g2QOwRq3lHDwAyPOPvB7ARSL
         TEBKV7hbTGSR5PFGN1VDy5H42q3Nm3c8OGdH4LIm+sMLMKeFnnb9ucU+2sYg3b7I3Kn2
         hoVchZz7XNdpqlEuCkd4Je6g0zbkxO3k8iYBKo80law2eaEXJmmi6s1CmAdLr63ZOowj
         /G3Fbm3Giptap1xx9wcFmTytL/QXsd48e0Wt8Iwpnnn1wXsTR6z4oShiGT2JJdoZ8QL8
         AF5w==
X-Gm-Message-State: AOAM533MkEvpNE2Cau/2XGrjvZVLp6Q5tnDvuted+tMx2khcfK7sNyML
        FBgtYDYjhJFF5ROQBxPwBZicSPi7UyRC2JZfuJn/MIN9OVRCpUMujtQ1XhUMteTdjdIBDe3cX0z
        gAF+19nOolRYDJ7k5jngCx7nc
X-Received: by 2002:a05:6402:1008:: with SMTP id c8mr9115180edu.114.1642167874594;
        Fri, 14 Jan 2022 05:44:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5OFak9AC/l+A6gU6QqTI2K9zWFX8t7yOZXV50BOSN3qj9pr1cdJHhBXdsT7LCgDNpLjpiDw==
X-Received: by 2002:a05:6402:1008:: with SMTP id c8mr9115163edu.114.1642167874354;
        Fri, 14 Jan 2022 05:44:34 -0800 (PST)
Received: from ?IPV6:2003:cb:c701:9d00:ff87:1c9b:108a:9702? (p200300cbc7019d00ff871c9b108a9702.dip0.t-ipconnect.de. [2003:cb:c701:9d00:ff87:1c9b:108a:9702])
        by smtp.gmail.com with ESMTPSA id 10sm1861145ejy.174.2022.01.14.05.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 05:44:33 -0800 (PST)
Message-ID: <60778775-b5f5-0837-092f-9911cec84854@redhat.com>
Date:   Fri, 14 Jan 2022 14:44:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH v3 7/8] drivers: virtio_mem: use pageblock size as the
 minimum virtio_mem size.
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>
References: <20220105214756.91065-1-zi.yan@sent.com>
 <20220105214756.91065-8-zi.yan@sent.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220105214756.91065-8-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.01.22 22:47, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> alloc_contig_range() now only needs to be aligned to pageblock_order,
> drop virtio_mem size requirement that it needs to be the max of
> pageblock_order and MAX_ORDER.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  drivers/virtio/virtio_mem.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index a6a78685cfbe..2664dc16d0f9 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -2481,8 +2481,7 @@ static int virtio_mem_init_hotplug(struct virtio_mem *vm)
>  	 * - Is required for now for alloc_contig_range() to work reliably -
>  	 *   it doesn't properly handle smaller granularity on ZONE_NORMAL.
>  	 */

Please also update this comment.

-- 
Thanks,

David / dhildenb

