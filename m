Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295A8570648
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiGKOxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiGKOxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:53:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BAF61E3E2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657551220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WJKzatRpxuBvlw+y/WmRUjNpFDe0w/BjpatBDpchBJM=;
        b=JfoC/2v0koMztXy7nlpLhI0AoMujYOKff3fWmuX6J8CEZPQS7isOwwXRRP50myoB/RkD3h
        7xUr0M+b2kmSQf/fJXBIKsASnXitmIL4pmX0exPXDaVkUG8xgtaV3r2IOQMbUOOpxpvNHU
        h7/Jq22YZ2jVxii4OLzsFeYkQvax53s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-55y4w_EoNSeDcEeM6QEI6Q-1; Mon, 11 Jul 2022 10:53:39 -0400
X-MC-Unique: 55y4w_EoNSeDcEeM6QEI6Q-1
Received: by mail-wm1-f70.google.com with SMTP id f16-20020a1c6a10000000b003a2d92ab4d8so2713782wmc.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=WJKzatRpxuBvlw+y/WmRUjNpFDe0w/BjpatBDpchBJM=;
        b=CsIdLPMNdhmwizUZihYHYKy3SZWUJbT7FmuGXJM/nIqdqUdmpMLKeuIDS4P7iNmCqs
         mlUsCKFRuABZTUuBshz49x19rpMxkPeYR1OBuXwTLQx4+8LLg7djs0/7Ua2NlQt0U3/m
         C1Pq/KZIwjwhKp/dfLg7g6bAQuGdSxiETyvgeDgDo7/DVwqpf6i/ugE2QPuUtg2AE8td
         innfE9Uw5JBLT2/5znzDLzid4xaeYE779o/6n+e2PnlWo/yWXmBmthTy0gCwXvXlGKn4
         qDtSjmNmg2ybsfttauKSHGGsJdIDKBVJsr42Gpv7gKiC0euEvRdWVZ+YASqy4AspsKzi
         AZWw==
X-Gm-Message-State: AJIora+IwecpN7maYp0pxMF8C7fKmBnOkblVgXo0ZBecRmBip8OVwezF
        eHUyLjsnXd/Y9pBMfGLc9u6deDT/Fz5rbl6dK6Ll+jga4ehoZCpRoa1K573DbRktHi9++X4Bifd
        b8Ui8c8vVp0bCHmCl9/Rp5h+n
X-Received: by 2002:a05:600c:3592:b0:3a1:9e9d:2595 with SMTP id p18-20020a05600c359200b003a19e9d2595mr16789383wmq.76.1657551217926;
        Mon, 11 Jul 2022 07:53:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uF7fVJz9gV/LGNy5ZuztDsIKohRmcbcs6QZEq6X8YOCi+3alMsLlZbv00GX9vpBHFadMKsmA==
X-Received: by 2002:a05:600c:3592:b0:3a1:9e9d:2595 with SMTP id p18-20020a05600c359200b003a19e9d2595mr16789363wmq.76.1657551217690;
        Mon, 11 Jul 2022 07:53:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:1400:c3:4ae0:6d5c:1ab2? (p200300cbc702140000c34ae06d5c1ab2.dip0.t-ipconnect.de. [2003:cb:c702:1400:c3:4ae0:6d5c:1ab2])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c3b0800b003a2ead2c884sm528930wms.13.2022.07.11.07.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 07:53:37 -0700 (PDT)
Message-ID: <c2d4c6ac-fad7-d5b3-8cbf-f62a7db5b998@redhat.com>
Date:   Mon, 11 Jul 2022 16:53:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/4] mm/sparse: skip no-map memblock check when
 fill_subsection_map
Content-Language: en-US
To:     Li Chen <me@linux.beauty>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Li Chen <lchen@ambarella.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org
References: <20220711122459.13773-1-me@linux.beauty>
 <20220711122459.13773-3-me@linux.beauty>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220711122459.13773-3-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.07.22 14:24, Li Chen wrote:
> From: Li Chen <lchen@ambarella.com>
> 
> When mhp use sparse_add_section, don't check no-map region,
> so that to allow no-map reserved memory to get struct page
> support.
> 
> Signed-off-by: Li Chen <lchen@ambarella.com>
> Change-Id: I0d2673cec1b66adf695251037a00c240976b226f
> ---
>  mm/sparse.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 120bc8ea5293..a29cd1e7014f 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -690,7 +690,9 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
>  
>  	if (bitmap_empty(map, SUBSECTIONS_PER_SECTION))
>  		rc = -EINVAL;
> -	else if (bitmap_intersects(map, subsection_map, SUBSECTIONS_PER_SECTION))
> +	else if (memblock_is_map_memory(PFN_PHYS(pfn)) &&
> +		 bitmap_intersects(map, subsection_map,
> +				   SUBSECTIONS_PER_SECTION))
>  		rc = -EEXIST;
>  	else
>  		bitmap_or(subsection_map, map, subsection_map,

I'm not sure I follow completely what you are trying to achieve. But if
you have to add memblock hacks into mm/sparse.c you're most probably
doing something wrong.

Please explain why that change is necessary, and why it is safe.

If the subsection map already spans memory (iow, subsection map is set)
you intend to add, then something already added memory in that range?

-- 
Thanks,

David / dhildenb

