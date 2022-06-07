Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B304453F3DE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 04:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbiFGCSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 22:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiFGCSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 22:18:43 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F1ACE07
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 19:18:41 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id g186so5618894pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 19:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8sGOsf30AB4emDfiLKO1IlUk0AJkLgR+c81RM9kvUeg=;
        b=23/xn5mUfnbRHw/7rzRolDNvBoA3vJ8Zvi5YH/mMPizfXZRAqEGf1K2xd6h65uCw4B
         X336gShgxmAzPAqaJyWEXrCo8MaNXGdWVSlPDYLLYyHiCe6iRJBF8jRYyqzCCfWoqqmj
         Skc6vJCfA/ocFu2mF/RGBfAzkGNiEW/theV44cARZCzxymjqugvtHvvl6bh11PrGg2JD
         Gy7+kggYxEVh7g28/P5Pjwbeo++DZR6ZYx6g9f8hpIKjN8YRsiM5vMiInKE3rYSewx9A
         ha22E+aJwCOyd1KWeuki+SPV96uIJXHmXszYv96vQ57TqakvebXz/0msJW5VEt7ai04y
         k1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8sGOsf30AB4emDfiLKO1IlUk0AJkLgR+c81RM9kvUeg=;
        b=dIXFPBULQ12wCMg5kCwNTlDSWQ80OMzkYLHfn1Rti0pcT6dHvE9meSc1OrR5/S5ADd
         ljHbDMcQD22NtlmsFLwjgFtsfZdI6CvYWTHnMtAtqRDknwCv5jgy0h/5gyRM/SM90FWp
         C7L5hDsZTcQpTdg++3rutVRz+rUjIEfDQ6oYDD87axeq8qlFgzGy59KE1RtZcuZzAZPQ
         K9NfPMSOqIcZSq9mpL+uFurKSWIbc1Fkq3aOu2jWAbpW+SwzbwkcGDRYPLfNn04nANik
         xOwsJ5ubz/d07NtJggd7WlPV0jx4n+dICivUzHW7FaG1ldKmGI6VmJXaJsljtYvvNPfg
         cmSQ==
X-Gm-Message-State: AOAM532JpFH3WfqjCbnWrjt7AJrE1HBaXZGmIjyWA4kIzyH/q19kZWd/
        6XiS3/qXgNQ9QIscohStvcY1RQ==
X-Google-Smtp-Source: ABdhPJzd5ZXvpWQ60IJGhalL0hOrDsUY1cmxQggKtjiWvLvBXtomKJRxIhxHb/4bKYIiG3S3A79cLg==
X-Received: by 2002:a63:8941:0:b0:3fc:7efa:119d with SMTP id v62-20020a638941000000b003fc7efa119dmr23916764pgd.340.1654568320532;
        Mon, 06 Jun 2022 19:18:40 -0700 (PDT)
Received: from [10.254.91.102] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id ju10-20020a17090b20ca00b001df264610c4sm13930080pjb.0.2022.06.06.19.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 19:18:40 -0700 (PDT)
Message-ID: <64d93544-294b-6149-524d-f7ce227d7e33@bytedance.com>
Date:   Tue, 7 Jun 2022 10:18:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v3] mm: memcontrol: add {pgscan,pgsteal}_{kswapd,direct}
 items in memory.stat of cgroup v2
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     roman.gushchin@linux.dev, shakeelb@google.com,
        songmuchun@bytedance.com, mhocko@kernel.org,
        akpm@linux-foundation.org, corbet@lwn.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
References: <20220606154028.55030-1-zhengqi.arch@bytedance.com>
 <Yp46w4op9JeX9+g9@cmpxchg.org>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Yp46w4op9JeX9+g9@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/7 1:34 AM, Johannes Weiner wrote:
> On Mon, Jun 06, 2022 at 11:40:28PM +0800, Qi Zheng wrote:
>> There are already statistics of {pgscan,pgsteal}_kswapd and
>> {pgscan,pgsteal}_direct of memcg event here, but now only the
>> sum of the two is displayed in memory.stat of cgroup v2.
>>
>> In order to obtain more accurate information during monitoring
>> and debugging, and to align with the display in /proc/vmstat,
>> it better to display {pgscan,pgsteal}_kswapd and
>> {pgscan,pgsteal}_direct separately.
>>
>> Also, for forward compatibility, we still display pgscan and
>> pgsteal items so that it won't break existing applications.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
>> Acked-by: Muchun Song <songmuchun@bytedance.com>
>> Acked-by: Shakeel Butt <shakeelb@google.com>
>> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> No objection to keeping pgscan and pgsteal, but can you please fix the
> doc to present the items in the same order as memory.stat has them?

Sure, will fix.

Thanks,
Qi

> 
>> @@ -1445,9 +1445,21 @@ PAGE_SIZE multiple when read back.
>>   	  pgscan (npn)
>>   		Amount of scanned pages (in an inactive LRU list)
>>   
>> +	  pgscan_kswapd (npn)
>> +		Amount of scanned pages by kswapd (in an inactive LRU list)
>> +
>> +	  pgscan_direct (npn)
>> +		Amount of scanned pages directly  (in an inactive LRU list)
>> +
>>   	  pgsteal (npn)
>>   		Amount of reclaimed pages
>>   
>> +	  pgsteal_kswapd (npn)
>> +		Amount of reclaimed pages by kswapd
>> +
>> +	  pgsteal_direct (npn)
>> +		Amount of reclaimed pages directly
>> +
>>   	  pgactivate (npn)
>>   		Amount of pages moved to the active LRU list
> 
> vs:
> 
>> @@ -1495,41 +1518,17 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>>   	}
>>   
>>   	/* Accumulated memory events */
>> -
>> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGFAULT),
>> -		       memcg_events(memcg, PGFAULT));
>> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGMAJFAULT),
>> -		       memcg_events(memcg, PGMAJFAULT));
>> -	seq_buf_printf(&s, "%s %lu\n",  vm_event_name(PGREFILL),
>> -		       memcg_events(memcg, PGREFILL));
>>   	seq_buf_printf(&s, "pgscan %lu\n",
>>   		       memcg_events(memcg, PGSCAN_KSWAPD) +
>>   		       memcg_events(memcg, PGSCAN_DIRECT));
>>   	seq_buf_printf(&s, "pgsteal %lu\n",
>>   		       memcg_events(memcg, PGSTEAL_KSWAPD) +
>>   		       memcg_events(memcg, PGSTEAL_DIRECT));
>> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGACTIVATE),
>> -		       memcg_events(memcg, PGACTIVATE));
>> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGDEACTIVATE),
>> -		       memcg_events(memcg, PGDEACTIVATE));
>> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGLAZYFREE),
>> -		       memcg_events(memcg, PGLAZYFREE));
>> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGLAZYFREED),
>> -		       memcg_events(memcg, PGLAZYFREED));
>> -
>> -#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
>> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(ZSWPIN),
>> -		       memcg_events(memcg, ZSWPIN));
>> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(ZSWPOUT),
>> -		       memcg_events(memcg, ZSWPOUT));
>> -#endif
>>   
>> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(THP_FAULT_ALLOC),
>> -		       memcg_events(memcg, THP_FAULT_ALLOC));
>> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(THP_COLLAPSE_ALLOC),
>> -		       memcg_events(memcg, THP_COLLAPSE_ALLOC));
>> -#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>> +	for (i = 0; i < ARRAY_SIZE(memcg_vm_event_stat); i++)
>> +		seq_buf_printf(&s, "%s %lu\n",
>> +			       vm_event_name(memcg_vm_event_stat[i]),
>> +			       memcg_events(memcg, memcg_vm_event_stat[i]));
> 
> Thanks

-- 
Thanks,
Qi
