Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FECD4E8F09
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238828AbiC1Hfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 03:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238827AbiC1Hfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 03:35:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D507D4AE0E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 00:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648452834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z9XZp52oACkgIKoqkexoluVDy/BwEPxs39tIximHMiw=;
        b=iOZmXL+8a7mu3WfPxQQKIlE1spUMk3Jwb4f8vldhY7DE8MVIv4BvUT3+8bGVzmPb1LmgcV
        D4U6grrpznpCsHGuym6B9J+P3Wn6bE7FWnuuD3iGDALxbbJqRyVi056EogNtVJFFbiICfg
        I+ehuOHoo1sfXk3pySjcBSIJG+0fSNM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-e7oxxaaeOxOtvkq3AcKShQ-1; Mon, 28 Mar 2022 03:33:53 -0400
X-MC-Unique: e7oxxaaeOxOtvkq3AcKShQ-1
Received: by mail-wm1-f69.google.com with SMTP id v2-20020a05600c214200b0038c7c02deceso5326495wml.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 00:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=z9XZp52oACkgIKoqkexoluVDy/BwEPxs39tIximHMiw=;
        b=sH+XphVdiNLDo1mFcibDCnLQEo14jhDG9m6v0SlsWwKvo9wvRsdwguuMZJ6ndZ9yj7
         Fiqm6a+sZTsbbcMtxbrb+Z/WNKMGJ1zWhwhsrONamQWg7YM9YKLY7MQGggfAmLRhoJPh
         CGSCFSzBBTlsswpKUfuqiD2VB7qoV8+jmkMGwbVpq6OXkDRlYJ2vYUK25N3XgS4yEgvg
         EMaKWtyTxARnY2yv3EWWF8D095NF93tAKV205gfNywD3JhiDnhcpGj5D5Nl6EGIUYF/C
         xDukLwsuIvSxtwESlFF1zbnYjUE7GpY0qvpwfg/q+ZEHUHi59sCSim0+y/INM0mH4rWd
         e84g==
X-Gm-Message-State: AOAM532RCVMXAWsEAxCTHql8pVf32O1eVrLUpQHSADT28sDwXTgdReu+
        nuAAJ3kKh9zVyFJpTVw87P1RBJHCM15Ab4DmBIqsIfD61amw5IfhEB/HnkDOWKmcQjtrHxkAp0T
        zVNQVaDMNdtHGm7bNHWhqO58X
X-Received: by 2002:a5d:6750:0:b0:203:efaf:9fc1 with SMTP id l16-20020a5d6750000000b00203efaf9fc1mr21339404wrw.252.1648452831777;
        Mon, 28 Mar 2022 00:33:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8CVQchI+J8cFZu7EhBEKy/ErIlY77zkJwrFB6+EFgoMzhF+/lltIFD1/JP1p10sMWtyn2jw==
X-Received: by 2002:a5d:6750:0:b0:203:efaf:9fc1 with SMTP id l16-20020a5d6750000000b00203efaf9fc1mr21339374wrw.252.1648452831464;
        Mon, 28 Mar 2022 00:33:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:2200:50d1:ff5c:5927:203a? (p200300cbc704220050d1ff5c5927203a.dip0.t-ipconnect.de. [2003:cb:c704:2200:50d1:ff5c:5927:203a])
        by smtp.gmail.com with ESMTPSA id n65-20020a1c2744000000b003862bfb509bsm15389618wmn.46.2022.03.28.00.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 00:33:51 -0700 (PDT)
Message-ID: <31c9ea16-2271-c616-3e32-ea0dc725a4c4@redhat.com>
Date:   Mon, 28 Mar 2022 09:33:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 1/2] mm/vmscan: reclaim only affects managed_zones
Content-Language: en-US
To:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net
References: <20220327024101.10378-1-richard.weiyang@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220327024101.10378-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.03.22 04:41, Wei Yang wrote:
> As mentioned in commit 6aa303defb74 ("mm, vmscan: only allocate and
> reclaim from zones with pages managed by the buddy allocator") , reclaim
> only affects managed_zones.
> 
> Let's adjust the code and comment accordingly.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  mm/vmscan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 7ad54b770bb1..89745cf34386 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1031,7 +1031,7 @@ static bool skip_throttle_noprogress(pg_data_t *pgdat)
>  	for (i = 0; i < MAX_NR_ZONES; i++) {
>  		struct zone *zone = pgdat->node_zones + i;
>  
> -		if (!populated_zone(zone))
> +		if (!managed_zone(zone))
>  			continue;
>  
>  		reclaimable += zone_reclaimable_pages(zone);
> @@ -3912,7 +3912,7 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
>  	}
>  
>  	/*
> -	 * If a node has no populated zone within highest_zoneidx, it does not
> +	 * If a node has no managed zone within highest_zoneidx, it does not
>  	 * need balancing by definition. This can happen if a zone-restricted
>  	 * allocation tries to wake a remote kswapd.
>  	 */

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

