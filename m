Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A21C4F7F67
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245385AbiDGMsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237014AbiDGMsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:48:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDAEC7DE37
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649335561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9/Us2cruhioCbl6RqJqudnxQAOhVEhkUDGtI39MXnNI=;
        b=M6p7sicFM3xDGLQF7R+hn+Njj6DxM/8nBwAX4jPYW54e+5yQJsFWt5teyRTbhrSkGY6rrx
        p6puSVgsk0S7IBLZdG8+3wRYaMgC7lnTp4L4xqTBKXFJ78iRocmiB2bNdnMNZjB+njcgYW
        FLITsR2PPkikm5K1H3xqPD9XBaRtBPg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-poEOq9QlOGKVjZRuoFlBng-1; Thu, 07 Apr 2022 08:46:00 -0400
X-MC-Unique: poEOq9QlOGKVjZRuoFlBng-1
Received: by mail-wm1-f72.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so2942581wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 05:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=9/Us2cruhioCbl6RqJqudnxQAOhVEhkUDGtI39MXnNI=;
        b=POym5rQiCFAp6R6Gct4jx2mrtBnQKk+BRjHYgqyK54ew+qIXNB1K+vzK6exEJjnwrl
         EuM3AlbkWxy1zHrtp2fDTBoYndulv1Mlb81QkR8rI9GU30yer7ISfiXQOtA3iHsOUif7
         Id+y03+XY04wFghL8OqlmX1w9IcbixwtLcmewoNJLuAclWR4OHUx1qzzGGwZoWqDzwdn
         CN0pnfZY7tfvU8zmfG30rgY3uT+8EwZwWM28/VjwSRRjMmcxBD/z3HRll8w+8lP9wYsQ
         Nl1R3okNNXLarQIZ2DLiKn6g+pmymXh3L0n+Bj4Y9ia76+lnRPUf5mJ5eRv1WV7ieIO5
         Gq/A==
X-Gm-Message-State: AOAM533U9yqvGvRje0tFh5EAIRNr18hk7xbOtrUwy3dOJPFECzFTir8O
        j2uWazrmXYC7fSRfkIfj0Rdf45sNuKHozagAFzZA+R3olXK1c0ba3C7k+vB4kgWCwYwxRYa1563
        yDrjH7rKtNYWgLoAGMlued94L
X-Received: by 2002:adf:f6c4:0:b0:206:1581:dabc with SMTP id y4-20020adff6c4000000b002061581dabcmr10825218wrp.375.1649335559573;
        Thu, 07 Apr 2022 05:45:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyM1kHX4+XtYoFq61dk62qQKc+KfdCBkhZ/B4Cy+Xlwxk5a3SuVrXH/rmpX3u/AmPLQfe4l7w==
X-Received: by 2002:adf:f6c4:0:b0:206:1581:dabc with SMTP id y4-20020adff6c4000000b002061581dabcmr10825196wrp.375.1649335559301;
        Thu, 07 Apr 2022 05:45:59 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id p5-20020adff205000000b0020614a499fbsm13364584wro.90.2022.04.07.05.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 05:45:58 -0700 (PDT)
Message-ID: <42046fe0-d4da-625d-6412-b5459b80ee11@redhat.com>
Date:   Thu, 7 Apr 2022 14:45:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2] mm, page_alloc: fix build_zonerefs_node()
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>, Michal Hocko <mhocko@suse.com>
References: <20220407120637.9035-1-jgross@suse.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220407120637.9035-1-jgross@suse.com>
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

On 07.04.22 14:06, Juergen Gross wrote:
> Since commit 6aa303defb74 ("mm, vmscan: only allocate and reclaim from
> zones with pages managed by the buddy allocator") only zones with free
> memory are included in a built zonelist. This is problematic when e.g.
> all memory of a zone has been ballooned out when zonelists are being
> rebuilt.
> 
> The decision whether to rebuild the zonelists when onlining new memory
> is done based on populated_zone() returning 0 for the zone the memory
> will be added to. The new zone is added to the zonelists only, if it
> has free memory pages (managed_zone() returns a non-zero value) after
> the memory has been onlined. This implies, that onlining memory will
> always free the added pages to the allocator immediately, but this is
> not true in all cases: when e.g. running as a Xen guest the onlined
> new memory will be added only to the ballooned memory list, it will be
> freed only when the guest is being ballooned up afterwards.
> 
> Another problem with using managed_zone() for the decision whether a
> zone is being added to the zonelists is, that a zone with all memory
> used will in fact be removed from all zonelists in case the zonelists
> happen to be rebuilt.
> 
> Use populated_zone() when building a zonelist as it has been done
> before that commit.
> 
> Cc: stable@vger.kernel.org
> Fixes: 6aa303defb74 ("mm, vmscan: only allocate and reclaim from zones with pages managed by the buddy allocator")
> Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
> V2:
> - updated commit message (Michal Hocko)
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

Did you drop my Ack?

Also, I'd appreciate getting CCed on patches where I commented.

-- 
Thanks,

David / dhildenb

