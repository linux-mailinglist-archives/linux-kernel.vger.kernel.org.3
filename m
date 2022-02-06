Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531AF4AAD7A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 03:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381568AbiBFCRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 21:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbiBFCR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 21:17:29 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE4CC043186
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 18:17:28 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id d10so31481538eje.10
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 18:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wvf9x00J4H0W2AQG3OJGkAg6nkvU0MOU4LOi8pHnx4M=;
        b=OsK0qtG1h0KYp7kPZzPff4dCLuuOUfjvFIuPL+0sKkUosvSwxXX1VDwYE0RawoQ0Oz
         kVQxlHNdJ+y8wqGO3RX1dxSSqEVrKDC/ydHCvOk17/JTWoLKo16KlZGhBm2ELtJhIyPV
         d54TErKu+o0RjoadLyMnW8A8hy6+hVO5/a9VjLjqQtfrRj55Qe3HTJwVFsKtnXMdX7sV
         eRDIZ5HA/5wSI0WC1Llmi9XMO4nF09j9i1iu/qudQRwnbUf1Ysxh4G5N4kfjbAyg8I2b
         FDbFxxdYTv6dBFqp76VLyTByubPiDZNEOH7RKN+b+xju0VRwfAs/221Syz6moSbQ6J9D
         4OZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wvf9x00J4H0W2AQG3OJGkAg6nkvU0MOU4LOi8pHnx4M=;
        b=bq7C36B6odJhyBb7lPUp+6fP4sRPilUqXY0mJe8ZDCk3KLxaV7xPuPplT2I3m/2Cac
         3BLbUvTDI9LJeLpaUwHSEj0rp8eRDKaKb9lBnuC64qin+V//ALJanx0S19k6TA+DJvXo
         obGulD9K48EjMRsIYQ18j39VJweknCtYU4fXT/zozreYorqD6YMXz/yA13VOCWwg+Wox
         MZmAiDBreMFW6pz+yUetiFgrjNiK6ceyhTWzFhSlPCltSxdkaTF64nScTUWf1+FSITkq
         1+H0NXKrV/vG6yvxlJLmAGWnz4pcmu3P0IDG7/uvKtVPK09ed/KKbd+h9e4P3mL2xfmt
         iZ8g==
X-Gm-Message-State: AOAM5305aRjq+QwdZRQfaGZhwFaUnd+F7qcaDYaV8M9Bz/HagRft5ezg
        zlJzcDgmG0T4lqbG1VYoD3s=
X-Google-Smtp-Source: ABdhPJwTFYukW4RrmUsK/ddV16Y1VVdSTCQC1gnIaHfwCDOH9sqGCiEpWdfcdpRK+vZLOfUtRZv7YA==
X-Received: by 2002:a17:907:2da0:: with SMTP id gt32mr4744761ejc.545.1644113847273;
        Sat, 05 Feb 2022 18:17:27 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id dt15sm2128704ejb.190.2022.02.05.18.17.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 Feb 2022 18:17:26 -0800 (PST)
Date:   Sun, 6 Feb 2022 02:17:26 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/page_alloc: add zone to zonelist if populated
Message-ID: <20220206021726.wknhhvkc7fevkpc4@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220203020022.3044-1-richard.weiyang@gmail.com>
 <Yfuf759naxpCeSx2@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfuf759naxpCeSx2@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 10:27:11AM +0100, Michal Hocko wrote:
>On Thu 03-02-22 02:00:22, Wei Yang wrote:
>> During memory hotplug, when online/offline a zone, we need to rebuild
>> the zonelist for all nodes. Current behavior would lose a valid zone in
>> zonelist since only pick up managed_zone.
>> 
>> There are two cases for a zone with memory but still !managed.
>> 
>>   * all pages were allocated via memblock
>>   * all pages were taken by ballooning / virtio-mem
>> 
>> This state maybe temporary, since both of them may release some memory.
>> Then it end up with a managed zone not in zonelist.
>> 
>> This is introduced in 'commit 6aa303defb74 ("mm, vmscan: only allocate
>> and reclaim from zones with pages managed by the buddy allocator")'.
>> This patch restore the behavior.
>
>It has been introduced to fix a problem described in the the changelog
>(FADUMP configuration making kswapd hogging a cpu). You are not
>explaining why the original issue is not possible after this change.
>

The first sight is kswapd deals with pgdat->node_zones, which is not affected
by pgdat->node_zonelists.

For the exact detail, I don't figure that out now. Will need some time to take
a look into. For that commit, I only found this link.
http://lkml.kernel.org/r/20160831195104.GB8119@techsingularity.net If there
are some other discussions, it would be helpful.

>I also think that this is more of theoretical issue than anything that
>is a real life concern. It is good to state that in the changelog as
>well.
>
>That being said I am not against the change but the changelog needs more
>explanation before I can ack it.
>
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> CC: Mel Gorman <mgorman@techsingularity.net>
>> CC: David Hildenbrand <david@redhat.com>
>> Fixes: 6aa303defb74 ("mm, vmscan: only allocate and reclaim from zones with pages managed by the buddy allocator")
>
>Fixes tag should be really used only if the referenced commit breaks
>something. I do not really see this to be the case here.
>

Got it.

>Thanks!
>
>> ---
>>  mm/page_alloc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index de15021a2887..b433a57ee76f 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -6092,7 +6092,7 @@ static int build_zonerefs_node(pg_data_t *pgdat, struct zoneref *zonerefs)
>>  	do {
>>  		zone_type--;
>>  		zone = pgdat->node_zones + zone_type;
>> -		if (managed_zone(zone)) {
>> +		if (populated_zone(zone)) {
>>  			zoneref_set_zone(zone, &zonerefs[nr_zones++]);
>>  			check_highest_zone(zone_type);
>>  		}
>> -- 
>> 2.33.1
>
>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
