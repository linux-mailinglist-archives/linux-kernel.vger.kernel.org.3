Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D030D4EB761
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 02:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241415AbiC3AQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 20:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiC3AQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 20:16:14 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BD7689AE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 17:14:30 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z92so22494867ede.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 17:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6BYILNTIPfnQ80tiRFzGN+1Svgk8JVvXymct2OKtnuQ=;
        b=UCDZcK2fFmQwYa7X6zFZApqicwxlkir//PRkL9ogxK42ls2ScTKTrLGQrT0Bm11kXr
         EAStHTYWOEPXBIxErv6aSydMHy/iIXxnvgSh2Knrync2dq8cwxIH2TNfPiFwEhF+65NB
         fg00t2THz619b2X/8q1EbsExjQdDEBVsn0LtPJ8TDOFL+2P+6MpekFE6gomkXF8Tf6vu
         DdBnzkZojCOJAPEx1k2YvrV1AfevfG+oIz9Yw/jZCumaBms7hOU6UGlGHh7D0WC+t0Rn
         f/Qit8I0PKz59uWJUHmbsLSZptuKEutMp8DOxXzaBjpSewjXZPf92VLVT9czDq/2HTNc
         TfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6BYILNTIPfnQ80tiRFzGN+1Svgk8JVvXymct2OKtnuQ=;
        b=6NSkQM4vc02wjRI7vS7ZJCaGsOtT66ziOGWbKqWloeK4UQNfAOm4qwQGtJ2tgWKll6
         gPGNnPO8PCiLY4j4LvKeKPwxJFthpChRGLeYyd/m6dOEDafJii0NEkpxjV5GeQJAcnWE
         s4oKlckwFxAxZIrLeB7xcrhDt/Tyyf5Jn8wKM5rCyZGy60rpRsO25GSw694KHRNQXzsy
         3puxLxv1ps+5emRGtqV0Pgs9mFortIW6a61Ca6ToG7PbhHARKPYK9yakZqTTesKG9ECu
         z0wUnDiLOzQnYmiPBY0HkgCWchCjwxObBMHCPmc/637L6GOpZVOpnbShsYd0HH8T5Hrn
         1u4Q==
X-Gm-Message-State: AOAM5307AAG6nxL89QuSt3xHPeSh14/ZFAxvDiVr1tloOiOR7KaDKIb6
        9il9ci4OgLjMYRu+h9lBQyI=
X-Google-Smtp-Source: ABdhPJz9aCt/A4bBe49Yt5ddgqIB3dQ7BNE5/ZWLj5COT1cMKcvdtK91xxYUDqpfaZdAFyVaCr4ZiQ==
X-Received: by 2002:a05:6402:40cb:b0:419:42de:65b6 with SMTP id z11-20020a05640240cb00b0041942de65b6mr7845399edb.66.1648599268830;
        Tue, 29 Mar 2022 17:14:28 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id z13-20020a17090674cd00b006df78d85eabsm7663465ejl.111.2022.03.29.17.14.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Mar 2022 17:14:28 -0700 (PDT)
Date:   Wed, 30 Mar 2022 00:14:27 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net
Subject: Re: [PATCH 2/2] mm/vmscan: make sure wakeup_kswapd with managed zone
Message-ID: <20220330001427.a745zl3qej2fajmf@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220327024101.10378-1-richard.weiyang@gmail.com>
 <20220327024101.10378-2-richard.weiyang@gmail.com>
 <8735j2opd9.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20220329004146.2xdswvrm2qu7f47x@master>
 <875ynxh9lg.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20220329015230.hneciyfxoxtvfytl@master>
 <871qylfr8f.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qylfr8f.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

On Tue, Mar 29, 2022 at 10:05:20AM +0800, Huang, Ying wrote:
>Wei Yang <richard.weiyang@gmail.com> writes:
>
>> On Tue, Mar 29, 2022 at 08:43:23AM +0800, Huang, Ying wrote:
>> [...]
>>>>>> --- a/mm/migrate.c
>>>>>> +++ b/mm/migrate.c
>>>>>> @@ -2046,7 +2046,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>>>>>>  		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING))
>>>>>>  			return 0;
>>>>>>  		for (z = pgdat->nr_zones - 1; z >= 0; z--) {
>>>>>> -			if (populated_zone(pgdat->node_zones + z))
>>>>>> +			if (managed_zone(pgdat->node_zones + z))
>>>>>
>>>>>This looks good to me!  Thanks!  It seems that we can replace
>>>>>populated_zone() in migrate_balanced_pgdat() too.  Right?
>>>>>
>>>>
>>>> Yes, you are right. I didn't spot this.
>>>>
>>>> While this patch comes from the clue of wakeup_kswapd(), I am not sure it is
>>>> nice to put it in this patch together.
>>>>
>>>> Which way you prefer to include this: merge the change into this one, or a
>>>> separate one?
>>>
>>>Either is OK for me.
>>>
>>
>> After reading the code, I am willing to do a little simplification. Does this
>> look good to you?
>>
>> From 85c8a5cd708ada3e9f5b0409413407b7be1bc446 Mon Sep 17 00:00:00 2001
>> From: Wei Yang <richard.weiyang@gmail.com>
>> Date: Tue, 29 Mar 2022 09:24:36 +0800
>> Subject: [PATCH] mm/migrate.c: return valid zone for wakeup_kswapd from
>>  migrate_balanced_pgdat()
>>
>> To wakeup kswapd, we need to iterate pgdat->node_zones and get the
>> proper zone. While this work has already been done in
>> migrate_balanced_pgdat().
>>
>> Let's return the valid zone directly instead of do the iteration again.
>>
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> ---
>>  mm/migrate.c | 21 ++++++++-------------
>>  1 file changed, 8 insertions(+), 13 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 5adc55b5347c..b086bd781956 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1973,7 +1973,7 @@ SYSCALL_DEFINE6(move_pages, pid_t, pid, unsigned long, nr_pages,
>>   * Returns true if this is a safe migration target node for misplaced NUMA
>>   * pages. Currently it only checks the watermarks which is crude.
>>   */
>> -static bool migrate_balanced_pgdat(struct pglist_data *pgdat,
>> +static struct zone *migrate_balanced_pgdat(struct pglist_data *pgdat,
>>  				   unsigned long nr_migrate_pages)
>>  {
>>  	int z;
>> @@ -1985,14 +1985,13 @@ static bool migrate_balanced_pgdat(struct pglist_data *pgdat,
>>  			continue;
>>  
>>  		/* Avoid waking kswapd by allocating pages_to_migrate pages. */
>> -		if (!zone_watermark_ok(zone, 0,
>> +		if (zone_watermark_ok(zone, 0,
>>  				       high_wmark_pages(zone) +
>>  				       nr_migrate_pages,
>>  				       ZONE_MOVABLE, 0))
>> -			continue;
>> -		return true;
>> +			return zone;
>>  	}
>> -	return false;
>> +	return NULL;
>>  }
>>  
>>  static struct page *alloc_misplaced_dst_page(struct page *page,
>> @@ -2032,6 +2031,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>>  	int page_lru;
>>  	int nr_pages = thp_nr_pages(page);
>>  	int order = compound_order(page);
>> +	struct zone *zone;
>>  
>>  	VM_BUG_ON_PAGE(order && !PageTransHuge(page), page);
>>  
>> @@ -2040,16 +2040,11 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>>  		return 0;
>>  
>>  	/* Avoid migrating to a node that is nearly full */
>> -	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
>> -		int z;
>> -
>> +	if ((zone = migrate_balanced_pgdat(pgdat, nr_pages))) {
>
>I think that this reverses the original semantics.  Originally, we give
>up and wake up kswapd if there's no enough free pages on the target
>node.  But now, you give up and wake up if there's enough free pages.
>

You are right, I misunderstand it.

Sorry


-- 
Wei Yang
Help you, Help me
