Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959F65AAA55
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbiIBInO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbiIBInA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:43:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2C4A1A62
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662108172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1zJot1sbctL/r1rOpAyGprgdV7lZzSxC7o857qrNS3g=;
        b=R+dAHjorODAFSBqEfqhBEI+M2bsRy9ikX04ifbJmDip8KVebiVA5nDVtA6B2Ok/0IY040a
        NVeY2VV4v8hqTa/huKUvMfnwfNQxowK95YDdVlhJv/ooaUK+KE4yesBw5oRpjo0YVA/FGc
        rOs5z9R+WTDLztGMFnK4Kk8hOWcDqK8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-466-Ybz6TTt0NU2fuYixFtAe6A-1; Fri, 02 Sep 2022 04:42:51 -0400
X-MC-Unique: Ybz6TTt0NU2fuYixFtAe6A-1
Received: by mail-wm1-f72.google.com with SMTP id r83-20020a1c4456000000b003a7b679981cso2625593wma.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 01:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=1zJot1sbctL/r1rOpAyGprgdV7lZzSxC7o857qrNS3g=;
        b=hGtrdAeoNeSnsXcOlUVV4VvjyNM1bYufUeMgkD962xz6Qi98ka9C6uR7VpcAeX85Pr
         BiqVOGqNIT8bQ0nk6os0NqrVzCkcZlmJS36AoZ/fvStcGi0SYiqTzjzUo0hdcdweCb1v
         k1LbG4oVQWSeYgAvgwWYyX2eEHUR9RBJIPOa2sXm7ebDUvrym2CQpFPJn9KOIMBy93GK
         eWgrDVzGQyzAOeDhvcgMDR2M4CmLL5gAVJN7yPms7xZ7jByd3JJlL0W817IfUCk4PZVU
         xibgtxCw0sO2ZLFga9V6P4HpmrO/MWWTex5DbZx3rmfoW9X5uKqBrfxtHA1VeAp8gxXu
         3AXA==
X-Gm-Message-State: ACgBeo0lpqeGV3zV27u7YYJ3OVpTJ1y6IKLNaFYaPqGwEYpTcxK45tEQ
        yWfTnT95BgQID80pts7PsotDcDn0Sy1xWpdoYbfbU0k3pNO167NpljOmPo2hK73y7MMJBHrUgHs
        CfqV3szhJQPH5eEwNZOBOUFQn
X-Received: by 2002:a5d:6248:0:b0:222:cd3b:94c8 with SMTP id m8-20020a5d6248000000b00222cd3b94c8mr16997916wrv.97.1662108170132;
        Fri, 02 Sep 2022 01:42:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6eEem5pJpyAX8xVTLKir5GJuvqD1/WeFXYRXR9FWghtwikjyK7S9Pxai2VdDN3dVZg35rw1g==
X-Received: by 2002:a5d:6248:0:b0:222:cd3b:94c8 with SMTP id m8-20020a5d6248000000b00222cd3b94c8mr16997905wrv.97.1662108169923;
        Fri, 02 Sep 2022 01:42:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c714:4800:2077:1bf6:40e7:2833? (p200300cbc714480020771bf640e72833.dip0.t-ipconnect.de. [2003:cb:c714:4800:2077:1bf6:40e7:2833])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c089400b003a30fbde91dsm7315866wmp.20.2022.09.02.01.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 01:42:49 -0700 (PDT)
Message-ID: <e0405abb-d1ea-977b-6d16-859a56bf3027@redhat.com>
Date:   Fri, 2 Sep 2022 10:42:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
References: <20220902064751.17890-1-wangkefeng.wang@huawei.com>
 <20220902064751.17890-2-wangkefeng.wang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 2/2] mm: add pageblock_aligned() macro
In-Reply-To: <20220902064751.17890-2-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.09.22 08:47, Kefeng Wang wrote:
> Add pageblock_aligned() and use it to simplify code.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---

[...]

> -	unsigned long nr_pgmask = pageblock_nr_pages - 1;
>  	int nid = zone_to_nid(zone);
>  	unsigned long nr_pages = 0;
>  	int zid = zone_idx(zone);
> @@ -1977,7 +1974,7 @@ static unsigned long  __init deferred_init_pages(struct zone *zone,
>  		if (!deferred_pfn_valid(pfn)) {
>  			page = NULL;
>  			continue;
> -		} else if (!page || !(pfn & nr_pgmask)) {


I didn't sleep too well this night and am tired, please tell me why I'm
wrong :)


"pfn & (pageblock_nr_pages - 1)" is true if the pageblock is not aligned

E.g., pfn = 1, pageblock_nr_pages = 512

pfn & (pageblock_nr_pages - 1)
-> 1 & (512 - 1)
-> 1 & 511
-> true

"!(pfn & (pageblock_nr_pages - 1))" is true if the pageblock is aligned
-> !(true)
-> false


However, "!pageblock_aligned(1)" = true


> +		} else if (!page || !pageblock_aligned(pfn)) {


So shouldn't this be "pageblock_aligned(pfn)"


?

>  			page = pfn_to_page(pfn);
>  		} else {
>  			page++;


-- 
Thanks,

David / dhildenb

