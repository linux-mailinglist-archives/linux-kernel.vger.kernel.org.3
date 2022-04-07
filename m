Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D237A4F7C12
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbiDGJsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiDGJsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:48:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1B453FBEF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649324776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CIrkyxw2ltSATsongCKPkeTXMJ2u05ZyiioovqE8L0s=;
        b=XOfPxoDk9VCcvJYem46YEBw3tYjh8uvmu8n+694jbfSz/1w2ziGeEfRbahUXzmv36uwbqS
        h7JabP+wWTcE5poq9U53zO9RmvpySR31rPhi5xP5eNARGxvZQlunAhlAYhq8B2WwIqglGF
        vZ3slaU32ANsYstlrM1DAVMj4TasVvM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198--2P25L-bNzivvLEzGm_LRg-1; Thu, 07 Apr 2022 05:46:15 -0400
X-MC-Unique: -2P25L-bNzivvLEzGm_LRg-1
Received: by mail-wm1-f71.google.com with SMTP id m3-20020a05600c3b0300b0038e74402cb6so2714624wms.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 02:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=CIrkyxw2ltSATsongCKPkeTXMJ2u05ZyiioovqE8L0s=;
        b=mvjzeVywDx/WKnvtNfgAi410++eiHZoloOsZGKPBtQKAAG/5v2ssKiU5WW+kPKogKZ
         r5hv/PckGg3GREAQ1j/cPX+eVjsvqYfX1umXw5nSSaX+c+P49I4h2QF6zXZeRFR9vY7t
         fy9oASEKf0kGOsCv9DiJaD0+Qx7/VuLkd4qk2FmyvllPeg+WLnUGQjHutmcNbuj84Hjd
         KQBGxY9aDehhuOqDYVdEaZWZs3PYKHrG/J5LEYgIQQqDYHLZF3ewpA7ATrnuec867lWg
         zkzWZVsWzYvdr+oGBL8neiCcPsc80GAfqWuD5TKLYFahbH6QTwzagIFGAgh5pz8O64hx
         vFEg==
X-Gm-Message-State: AOAM531sK+kGvhHTrrQTW5FDYCENIBFgl5ASCrHdnWWUBGFqPFJhicjw
        7Q24HhbVk/7YldbQbPV7XX2itHurcNIKa5aXfTXdskhyvytHpx/zMiDFtnRGlohbphnuYbVfoZQ
        0U9Pyp5ab8kfktFWXsEE0ZYfQ
X-Received: by 2002:a1c:f005:0:b0:38c:b6d5:5c2a with SMTP id a5-20020a1cf005000000b0038cb6d55c2amr11560875wmb.89.1649324774614;
        Thu, 07 Apr 2022 02:46:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaV/O4sc8yI66xNvj9tArkavzQBoS8J9F6Pviebz+CdcTWfctMEO9PWcH/8H60MajLM0j21Q==
X-Received: by 2002:a1c:f005:0:b0:38c:b6d5:5c2a with SMTP id a5-20020a1cf005000000b0038cb6d55c2amr11560857wmb.89.1649324774387;
        Thu, 07 Apr 2022 02:46:14 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id l28-20020a05600c1d1c00b0038e72a95ec4sm8249142wms.13.2022.04.07.02.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 02:46:13 -0700 (PDT)
Message-ID: <1028ca3c-5b6c-d95e-9372-ae64b1fcbc82@redhat.com>
Date:   Thu, 7 Apr 2022 11:46:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] mm, page_alloc: fix build_zonerefs_node()
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>
References: <20220407093221.1090-1-jgross@suse.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220407093221.1090-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.04.22 11:32, Juergen Gross wrote:
> Since commit 9d3be21bf9c0 ("mm, page_alloc: simplify zonelist
> initialization") only zones with free memory are included in a built
> zonelist. This is problematic when e.g. all memory of a zone has been
> ballooned out.
> 
> Use populated_zone() when building a zonelist as it has been done
> before that commit.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9d3be21bf9c0 ("mm, page_alloc: simplify zonelist initialization")
> Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index bdc8f60ae462..3d0662af3289 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6128,7 +6128,7 @@ static int build_zonerefs_node(pg_data_t *pgdat, struct zoneref *zonerefs)
>  	do {
>  		zone_type--;
>  		zone = pgdat->node_zones + zone_type;
> -		if (managed_zone(zone)) {
> +		if (populated_zone(zone)) {
>  			zoneref_set_zone(zone, &zonerefs[nr_zones++]);
>  			check_highest_zone(zone_type);
>  		}

Let's see if we have to find another way to properly handle fadump.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

