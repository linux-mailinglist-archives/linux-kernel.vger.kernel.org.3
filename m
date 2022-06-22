Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613E9554720
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245747AbiFVIpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiFVIpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:45:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5752738D9D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655887503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yM2ilXtSj5hOwfP2Q9CCS31/P/1OntUXQBpNb3rtn7M=;
        b=UxuLco+6YbQXUqMOeCZp3UImfkuU14YBVBl1LeDX31ZEdzkNYZO5z6+dyU5r1dpZMgA4kX
        tji2tlPnu/mNA9Xpi6VxZpFPex52L1zpCh3DMt/Rrn5twcz8MrmjhBB3NT1Sg61a/e+F42
        tkiYItOARf5N5Brg1nga/CirL/85Ty8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-ONSDKO50N0exm0pl1RNt5g-1; Wed, 22 Jun 2022 04:45:00 -0400
X-MC-Unique: ONSDKO50N0exm0pl1RNt5g-1
Received: by mail-wm1-f72.google.com with SMTP id i184-20020a1c3bc1000000b003a026f48333so432004wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=yM2ilXtSj5hOwfP2Q9CCS31/P/1OntUXQBpNb3rtn7M=;
        b=EU8WTFF5SHm85iHDEbg37pw0z6r1HCs6P/D1R1CRg9TggPFa3hccieCl9qkJGctRab
         pTEV2/1atmVVXPXofKPs7cJt/zjRZk/NNW1VT+Z6JedsWlDd2S9z/pt7NL5z+5iXE2Yv
         URF+C1yOF6c1HW9OZfGv/PVdeDttq5UHn8aThjmH1WZsJB18aG7uNgemhFxaoadErbRQ
         LjHQIV9JfmffL6g/dkkQDFnRew8YEvaaqRixWMQi6tsyMg0G6zSx6BhHQmO89QPr0Upj
         8CLTVeJDVayLOiz2PItxWL3DhtSFJu2t4YwmzAaOwV8n0yaTBSt/IMCSd8wWt0h6j7hO
         xLKA==
X-Gm-Message-State: AJIora+kUsuGl6gYV+wp258Kw0hqFRcecNi1U/jpAG4zuva1SHZ5QTGp
        4bRh4GUgqtoowQDfKMi+seP5M2Qsg34PbMnRC6sQN6iMnM/N558nPaESjrkUaqSSvscK/5Jwn0m
        t3dfHqP/L23HH/8iR0wuyiDyO
X-Received: by 2002:a05:600c:a4c:b0:39c:34d0:fd25 with SMTP id c12-20020a05600c0a4c00b0039c34d0fd25mr2645106wmq.172.1655887499345;
        Wed, 22 Jun 2022 01:44:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tqm7fcwKotWffGWNRwGJlX7MqnLDontN9cjXI+cyLOnldlC1tmwlxVGQvXplktCYZVjJwYsw==
X-Received: by 2002:a05:600c:a4c:b0:39c:34d0:fd25 with SMTP id c12-20020a05600c0a4c00b0039c34d0fd25mr2645078wmq.172.1655887498965;
        Wed, 22 Jun 2022 01:44:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:5100:9c77:ce13:2aeb:8748? (p200300cbc70351009c77ce132aeb8748.dip0.t-ipconnect.de. [2003:cb:c703:5100:9c77:ce13:2aeb:8748])
        by smtp.gmail.com with ESMTPSA id a14-20020a056000100e00b0021b862ad439sm1299360wrx.9.2022.06.22.01.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 01:44:58 -0700 (PDT)
Message-ID: <4dccc61d-d8fa-c2b2-d744-398b48ea8a89@redhat.com>
Date:   Wed, 22 Jun 2022 10:44:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220621041717.6355-1-osalvador@suse.de>
 <20220621041717.6355-3-osalvador@suse.de>
 <139fc140-142f-c467-a5e3-0a0954dca127@redhat.com>
 <YrKZsYNUAbfcC1CF@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/2] mm/memory_hotplug: Reset node's state when empty
 during offline
In-Reply-To: <YrKZsYNUAbfcC1CF@localhost.localdomain>
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

On 22.06.22 06:25, Oscar Salvador wrote:
> On Tue, Jun 21, 2022 at 09:59:07AM +0200, David Hildenbrand wrote:
>>> +static void node_reset_state(int node)
>>> +{
>>> +	pg_data_t *pgdat = NODE_DATA(node);
>>> +	int cpu;
>>> +
>>> +	kswapd_stop(node);
>>> +	kcompactd_stop(node);
>>> +
>>> +	pgdat->nr_zones = 0;
>>
>> ^ what is that? it should be "highest_zone_idx" and I don't see any
>> reason that we really need this.
> 
> Uhm, I thought we need to reset this, otherwise init_currently_empty_zone()
> might not set it to a right value:
> 
> ...
>  if (zone_idx > pgdat->nr_zones)
>     pgdat->nr_zones = zone_idx
> ...
> 
> At least we set it to 0 in free_area_init_core_hotplug() (before this patch).

Yeah, I don't think we need to, the nodes+zones should be empty either
way. Maybe a micro-optimization that doesn't really optimize anything
that much?

free_area_init_node() warns if it isn't reset, but my gut feeling is
this is completely unnecessary. We're not dealing with 200 zones ...

> 
>> To detect if a node is empty we can use pgdat_is_empty(). To detect if a
>> zone is empty we can use zone_is_empty().
>>
>> The usage of "pgdat->nr_zones" as an optimization is questionable,
>> especially when iterating over our handful of zones where most nodes
>> miss the *lower* zones like ZONE_DMA* in practice and have ZONE_NORMAL.
>>
>> Can we get rid of that and just check pgdat_is_empty() and
>> zone_is_empty() and iterate all applicable zones from 0..X?
> 
> So, lemme see if I get you.
> You mean to e.g: replace the following (code snippet from set_pgdat_percpu_threshold)
> 
>   for (i = 0; i < pgdat->nr_zones; i++) {
>            zone = &pgdat->node_zones[i];
> 
> 		    [some code]
>   }
> 
> with this:
> 
>   for (zid = 0; zid < MAX_NR_ZONES; i++) {
>             struct zone *zone = pgdat->node_zones + i;
> 
>             if (zone_is_empty(zone))
>                     continue; 
>   }

Yes, some places that are not interested in ZONE_DEVICE might want to
skip that completely. See below.

> 
> I guess we can, and I can see that we have a mix of both usages, so it might be
> good to consolidate one.
> And actually, I think we do the same amount of work, right? So not really an
> optimization in those pieces of code.

That's my understanding.

> 
> The only thing that unsettles me is the compaction part.
> We set pgdat->kcompactd_highest_zoneidx by checking pgdat->nr_zones, and use
> that as our compact_control->highest_zoneidx. (kcompactd->kcompactd_do_work)

I wonder why we would want to use ZONE_DEVICE there ...

move_pfn_range_to_zone()->init_currently_empty_zone() would set
pgdat->nr_zones = ZONE_DEVICE.

Which looks unnecessary.

> 
> Now, I do not really see any reason we could not adapt that code to not
> realy on pgdat->nr_zones, but I would have to check further how this
> interacts with highest_zoneidx down the road, and where else should
> we rewrite code.

I wonder if all we want is:


diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index aab70355d64f..905919683025 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -497,8 +497,9 @@ enum zone_type {
         * there can be false negatives).
         */
        ZONE_MOVABLE,
+       __MAX_NR_BUDDY_ZONES,
 #ifdef CONFIG_ZONE_DEVICE
-       ZONE_DEVICE,
+       ZONE_DEVICE = __MAX_NR_BUDDY_ZONES,
 #endif
        __MAX_NR_ZONES

diff --git a/tools/testing/memblock/linux/mmzone.h
b/tools/testing/memblock/linux/mmzone.h
index 7c2eb5c9bb54..2c3492239e45 100644
--- a/tools/testing/memblock/linux/mmzone.h
+++ b/tools/testing/memblock/linux/mmzone.h
@@ -17,6 +17,7 @@ enum zone_type {
 };

 #define MAX_NR_ZONES __MAX_NR_ZONES
+#define MAX_NR_BUDDY_ZONES __MAX_NR_BUDDY_ZONES
 #define MAX_ORDER 11
 #define MAX_ORDER_NR_PAGES (1 << (MAX_ORDER - 1))



Then, all relevant buddy-related code (compaction ...) can simply run

for (i = 0; i < MAX_NR_BUDDY_ZONES; i++)

or

for (i = MAX_NR_BUDDY_ZONES - 1; i >= 0; i--)

and check if the relevant zone is empty.


There will still be users of MAX_NR_ZONES, though, that have to consider
ZONE_DEVICE as well.

-- 
Thanks,

David / dhildenb

