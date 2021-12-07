Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9724746C6C0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241897AbhLGVh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:37:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27497 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231451AbhLGVh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:37:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638912866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KhZdpLhWPqryvXWVukLCy3lQQWZo4w43qWZkFRBlJ/c=;
        b=Jcs6vL+ZsDT2CuqJLFIgLuU338m4+ZXNPlIBD+nLc+w1CvKNN1LjpwGi6UnxQCOSte7bJF
        oPb87UzaFNpbaVCOAvFA6xPiWi3bxgX/L6ljMzBMfZ82nxlKkXRIYn8bf9/KvHy3/K+c59
        A+J2YUmOXkVWR3ETsqt55ZBH7QDAA5g=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-xS9KLfewMRiAk7jrNJRx9g-1; Tue, 07 Dec 2021 16:34:25 -0500
X-MC-Unique: xS9KLfewMRiAk7jrNJRx9g-1
Received: by mail-io1-f70.google.com with SMTP id s8-20020a056602168800b005e96bba1363so574076iow.21
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 13:34:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KhZdpLhWPqryvXWVukLCy3lQQWZo4w43qWZkFRBlJ/c=;
        b=os91dTc/cCGZ+y7VFFfajHArWXvl/f44P5k3ROhExG48IpwdKFBcQk6AfhDAsLAEGx
         etjyMEgp5L6w4HrIl6T2MKmfKO8IxRu+8Y/34F3Bxl0k6V4J83q/BidAQ8d/ycf5rPhW
         JB9GV3EHK/ZNZbeAfQ7lnO1+nAhwS0Ocfn1+eqCmMgS1UIydHg73DLCyhcE+IY4/lryN
         xHtFA5+fRW5SCrkQSkponFh37YFZ019/BPX3Nr2pI3DiJ8+q2C7RQgkYYqklyXesFNc0
         bTAk2bMJGOfqOkAO4lZaTv1nfU2nVHRxljYeJto8YZSm2CndjWBG4icHq8ACUsxY1e5g
         Y1zA==
X-Gm-Message-State: AOAM5316sBCbanqH9AvwF9J0PKloD58BSDoGUUIj9Lb1NlrGz/PNElyV
        x+gVA40+jnUBf/z8O73ZeukRtnOXe8ODiDcfKrmyvC4hJIKUo6vLBPZ40IC/GjexM5hbvtk4dZz
        tz9ieoRsMfOA8Vc9n8os6PNCj
X-Received: by 2002:a05:6638:3808:: with SMTP id i8mr25358379jav.118.1638912863665;
        Tue, 07 Dec 2021 13:34:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyb5MnlRjkvO0M/rJFKCBnypJG33J8tAJJVDVVLhQIRiKZoHcQVHfC2I6cXzFxfS+C9rTwLXA==
X-Received: by 2002:a05:6638:3808:: with SMTP id i8mr25358304jav.118.1638912863047;
        Tue, 07 Dec 2021 13:34:23 -0800 (PST)
Received: from ?IPV6:2601:280:4400:a2e0:7336:512c:930d:4f0e? ([2601:280:4400:a2e0:7336:512c:930d:4f0e])
        by smtp.gmail.com with ESMTPSA id y21sm539975ioj.41.2021.12.07.13.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 13:34:22 -0800 (PST)
Message-ID: <ade0ed9d-4d6e-d780-4a72-0dcdb2fb2309@redhat.com>
Date:   Tue, 7 Dec 2021 16:34:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        ktkhai@virtuozzo.com, shy828301@gmail.com, guro@fb.com,
        vbabka@suse.cz, vdavydov.dev@gmail.com, raquini@redhat.com
References: <20211206033338.743270-1-npache@redhat.com>
 <20211206033338.743270-3-npache@redhat.com> <Ya3WcYKcej8XEI0W@dhcp22.suse.cz>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <Ya3WcYKcej8XEI0W@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/21 04:22, Michal Hocko wrote:
> On Sun 05-12-21 22:33:38, Nico Pache wrote:
>> We have run into a panic caused by a shrinker allocation being attempted
>> on an offlined node.
>>
>> Our crash analysis has determined that the issue originates from trying
>> to allocate pages on an offlined node in expand_one_shrinker_info. This
>> function makes the incorrect assumption that we can allocate on any node.
>> To correct this we make sure we only itterate over online nodes.
>>
>> This assumption can lead to an incorrect address being assigned to ac->zonelist
>> in the following callchain:
>> 	__alloc_pages
>> 	-> prepare_alloc_pages
>> 	 -> node_zonelist
>>
>> static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
>> {
>>         return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
>> }
>> if the node is not online the return of node_zonelist will evaluate to a
>> invalid pointer of 0x00000 + offset_of(node_zonelists) + (1|0)
>>
>> This address is then dereferenced further down the callchain in:
>> 	prepare_alloc_pages
>> 	-> first_zones_zonelist
>>   	 -> next_zones_zonelist
>> 	  -> zonelist_zone_idx
>>
>> static inline int zonelist_zone_idx(struct zoneref *zoneref)
>> {
>>         return zoneref->zone_idx;
>> }
>>
>> Leading the system to panic.
> 
> Thanks for the analysis! Please also add an oops report so that this is
> easier to search for. It would be also interesting to see specifics
> about the issue. Why was the specific node !online in the first place?
> What architecture was this on?

Here is the Oops report. I will also add it to my commit message on the second
posting! This was x86 btw, but it has also been hit on PPC64.

[  362.179917] RIP: 0010:prepare_alloc_pages.constprop.0+0xc6/0x150
[  362.186639] Code: 03 80 c9 80 83 e2 03 83 fa 01 0f 44 c1 41 89 04 24 c1 eb 0c
48 8b 55 08 83 e3 01 8b 75 1c 48 8b 7d 00 88 5d 20 48 85 d2 75 6b <3b> 77 08 72
66 48 89 7d 10 b8 01 00 00 00 48 83 c4 08 5b 5d 41 5c
[  362.207604] RSP: 0018:ffffb4ba31427bc0 EFLAGS: 00010246
[  362.213443] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000081
[  362.221412] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000002080
[  362.229380] RBP: ffffb4ba31427bf8 R08: 0000000000000000 R09: ffffb4ba31427bf4
[  362.237347] R10: 0000000000000000 R11: 0000000000000000 R12: ffffb4ba31427bf0
[  362.245316] R13: 0000000000000002 R14: ffff9f2fb3788000 R15: 0000000000000078
[  362.253285] FS:  00007fbc57bfd740(0000) GS:ffff9f4c7d780000(0000)
knlGS:0000000000000000
[  362.262322] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  362.268739] CR2: 0000000000002088 CR3: 000002004cb58002 CR4: 00000000007706e0
[  362.276707] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  362.284675] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  362.292644] PKRU: 55555554
[  362.295669] Call Trace:
[  362.298402]  __alloc_pages+0x9d/0x210
[  362.302501]  kmalloc_large_node+0x40/0x90
[  362.306988]  __kmalloc_node+0x3ac/0x480
[  362.311279]  kvmalloc_node+0x46/0x80
[  362.315276]  expand_one_shrinker_info+0x84/0x190
[  362.320437]  prealloc_shrinker+0x166/0x1c0
[  362.325015]  alloc_super+0x2ba/0x330
[  362.329011]  ? __fput_sync+0x30/0x30
[  362.333003]  ? set_anon_super+0x40/0x40
[  362.337288]  sget_fc+0x6c/0x2f0
[  362.340798]  ? mqueue_create+0x20/0x20
[  362.344992]  get_tree_keyed+0x2f/0xc0
[  362.349086]  vfs_get_tree+0x25/0xb0
[  362.352982]  fc_mount+0xe/0x30
[  362.356397]  mq_init_ns+0x105/0x1a0
[  362.360291]  copy_ipcs+0x129/0x220
[  362.364093]  create_new_namespaces+0xa1/0x2e0
[  362.368960]  unshare_nsproxy_namespaces+0x55/0xa0
[  362.374216]  ksys_unshare+0x198/0x380
[  362.378310]  __x64_sys_unshare+0xe/0x20
[  362.382595]  do_syscall_64+0x3b/0x90
[  362.386597]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  362.392247] RIP: 0033:0x7fbc57d14d7b
[  362.396242] Code: 73 01 c3 48 8b 0d ad 70 0e 00 f7 d8 64 89 01 48 83 c8 ff c3
66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 10 01 00 00 0f 05 <48> 3d 01 f0
ff ff 73 01 c3 48 8b 0d 7d 70 0e 00 f7 d8 64 89 01 48
[  362.417204] RSP: 002b:00007fbc4dc73f88 EFLAGS: 00000206 ORIG_RAX:
0000000000000110
[  362.425664] RAX: ffffffffffffffda RBX: 0000560144b09578 RCX: 00007fbc57d14d7b
[  362.433634] RDX: 0000000000000010 RSI: 00007fbc4dc73f90 RDI: 0000000008000000
[  362.441602] RBP: 0000560144b095a0 R08: 0000000000000000 R09: 0000000000000000
[  362.449573] R10: 0000000000000000 R11: 0000000000000206 R12: 00007fbc4dc73f90
[  362.457542] R13: 000000000000006a R14: 0000560144e7e5a0 R15: 00007fff5dec8e10

> 
>> We also correct this behavior in alloc_shrinker_info, free_shrinker_info,
>> and reparent_shrinker_deferred.
>>
>> Fixes: 2bfd36374edd ("mm: vmscan: consolidate shrinker_maps handling code")
>> Fixes: 0a4465d34028 ("mm, memcg: assign memcg-aware shrinkers bitmap to memcg")
> 
> Normally I would split the fix as it is fixing two issues one introduced
> in 4.19 the other in 5.13.

These are both commits that introduced the function, one introduces it while the
other moves it to a separate file. But as Yang Shi pointed out the better commit
to blame is 86daf94efb11 ("mm/memcontrol.c: allocate shrinker_map on appropriate
NUMA node") which actually made the change that would have caused the allocator
to go for an !online node.

> 
>> Signed-off-by: Nico Pache <npache@redhat.com>
>> ---
>>  mm/vmscan.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index fb9584641ac7..731564b61e3f 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -221,7 +221,7 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>>  	int nid;
>>  	int size = map_size + defer_size;
>>  
>> -	for_each_node(nid) {
>> +	for_each_online_node(nid) {
>>  		pn = memcg->nodeinfo[nid];
>>  		old = shrinker_info_protected(memcg, nid);
>>  		/* Not yet online memcg */
>> @@ -256,7 +256,7 @@ void free_shrinker_info(struct mem_cgroup *memcg)
>>  	struct shrinker_info *info;
>>  	int nid;
>>  
>> -	for_each_node(nid) {
>> +	for_each_online_node(nid) {
>>  		pn = memcg->nodeinfo[nid];
>>  		info = rcu_dereference_protected(pn->shrinker_info, true);
>>  		kvfree(info);
>> @@ -274,7 +274,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>  	map_size = shrinker_map_size(shrinker_nr_max);
>>  	defer_size = shrinker_defer_size(shrinker_nr_max);
>>  	size = map_size + defer_size;
>> -	for_each_node(nid) {
>> +	for_each_online_node(nid) {
>>  		info = kvzalloc_node(sizeof(*info) + size, GFP_KERNEL, nid);
>>  		if (!info) {
>>  			free_shrinker_info(memcg);
>> @@ -417,7 +417,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>>  
>>  	/* Prevent from concurrent shrinker_info expand */
>>  	down_read(&shrinker_rwsem);
>> -	for_each_node(nid) {
>> +	for_each_online_node(nid) {
>>  		child_info = shrinker_info_protected(memcg, nid);
>>  		parent_info = shrinker_info_protected(parent, nid);
>>  		for (i = 0; i < shrinker_nr_max; i++) {
>> -- 
>> 2.33.1
> 
> This doesn't seen complete. Slab shrinkers are used in the reclaim
> context. Previously offline nodes could be onlined later and this would
> lead to NULL ptr because there is no hook to allocate new shrinker
> infos. This would be also really impractical because this would have to
> update all existing memcgs...
> 
> To be completely honest I am not really sure this is a practical problem
> because some architectures allocate (aka make online) all possible nodes
> reported by the platform. There are major inconsistencies there. Maybe
> that should be unified, so that problems like this one do not really
> have to add a complexity to the code.

Im currently working a solution that will use register_one_node to perform the
memcg node allocation for all memcgs. I will post that once I've verified all
potential corner cases.

Cheers,
-- Nico

> 

