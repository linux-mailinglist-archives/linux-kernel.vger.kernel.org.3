Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A1646C969
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhLHAoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:44:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41290 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229479AbhLHAoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638924037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I5eY0me2wOSy2UVkmg3afLHAZnrnZAUcXyHGjuGOesc=;
        b=hhcNL0kr4o0J+wt7+2dGL9J2pndkTFTYvGEjYhLITS0T4gMmdcRAor8n9vdX/vOxXon6qo
        EpiUl/3f4guz76SyxcZWICZCVIroQdd0gfjrLiZk1Ugaw7onSdmEp4fW0wnanriPFGK50T
        5XTX1i8ZBplfRFCnNS9k8OLIa8/o2jU=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-METpsH0wN5O6vmyF1f5Zqg-1; Tue, 07 Dec 2021 19:40:36 -0500
X-MC-Unique: METpsH0wN5O6vmyF1f5Zqg-1
Received: by mail-io1-f72.google.com with SMTP id h16-20020a056602155000b005ec7daa8de5so1134574iow.16
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 16:40:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I5eY0me2wOSy2UVkmg3afLHAZnrnZAUcXyHGjuGOesc=;
        b=oWYCawUNYFl5g9krh47dIDjXU+6qBB2F4qyP2YSQMmoE76OGijSLAHXOIIk0CHpv1x
         CiW553cp77yKwh6k7Fh0bXQz9LH2Udrf31p6Zut2b3n4czz+FXpWgsK9gMof5SemQZC1
         MhIZ+oAHwwOJkwXu9Tpn4bJuLjA62VMVda6LV0I3/FHwIDOLYN549m+Ghclz1zyS9UYg
         xeYrFYh3wqpxkAcqs/UzOaFhpxx34CVVBrPs0CJDdz3h6ZMxHVrpM/1elXxC1XkUvnIN
         Fbk6865QM/rN5fDM3xQ1PoJ+OW31sHNu+lGHTHVQWtDSYVbkCH14q9/N1DcEC+y5IrXS
         xgQw==
X-Gm-Message-State: AOAM533wRqz0PQugDmSoVsWovpBk1ZUT4BbBJ8gqYtIymmLjdGOa2TW9
        9fi3+SolZxVTzdgECiWuWOqVI4CljJ3zQ2xtNOy6c7hY8jxt/IdXIZepPExuPWLoFDDy8JWEDTg
        3q2cVYvFqFX8JVXt8jIXh0y7d
X-Received: by 2002:a05:6638:2512:: with SMTP id v18mr53173318jat.22.1638924035641;
        Tue, 07 Dec 2021 16:40:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwjIKfcGrLuNYNhWA+x0K0f3bghJsRqm7e/4zb9+yPA9WYo7XgEUAmx9G3AFdnuu/7SxsdU4Q==
X-Received: by 2002:a05:6638:2512:: with SMTP id v18mr53173290jat.22.1638924035075;
        Tue, 07 Dec 2021 16:40:35 -0800 (PST)
Received: from ?IPV6:2601:280:4400:a2e0:7336:512c:930d:4f0e? ([2601:280:4400:a2e0:7336:512c:930d:4f0e])
        by smtp.gmail.com with ESMTPSA id b6sm819791ilq.18.2021.12.07.16.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 16:40:34 -0800 (PST)
Message-ID: <4c4b4db2-27b9-6001-5bae-ccc500695b42@redhat.com>
Date:   Tue, 7 Dec 2021 19:40:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/1] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        shakeelb@google.com, ktkhai@virtuozzo.com, shy828301@gmail.com,
        guro@fb.com, vbabka@suse.cz, vdavydov.dev@gmail.com,
        raquini@redhat.com, mhocko@suse.com, david@redhat.com
References: <20211207224013.880775-1-npache@redhat.com>
 <20211207224013.880775-2-npache@redhat.com>
 <20211207154438.c1e49a3f0b5ebc9245aac61b@linux-foundation.org>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <20211207154438.c1e49a3f0b5ebc9245aac61b@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/21 18:44, Andrew Morton wrote:
> On Tue,  7 Dec 2021 17:40:13 -0500 Nico Pache <npache@redhat.com> wrote:
> 
>> We have run into a panic caused by a shrinker allocation being attempted
>> on an offlined node.
>>
>> Our crash analysis has determined that the issue originates from trying
>> to allocate pages on an offlined node in expand_one_shrinker_info. This
>> function makes the incorrect assumption that we can allocate on any node.
>> To correct this we make sure the node is online before tempting an
>> allocation. If it is not online choose the closest node.
> 
> This isn't fully accurate, is it?  We could allocate on a node which is
> presently offline but which was previously onlined, by testing
> NODE_DATA(nid).

Thanks for the review! I took your changes below into consideration for my V3.

My knowledge of offlined/onlined nodes is quite limited but after looking into
it it doesnt seem like anything clears the state of NODE_DATA(nid) after a
try_offline_node is attempted. So theoretically the panic we saw would not
happen. What is the expected behavior of trying to allocate a page on a offline
node?

> 
> It isn't entirely clear to me from the v1 discussion why this approach
> isn't being taken?
> 
> AFAICT the proposed patch is *already* taking this approach, by having
> no protection against a concurrent or subsequent node offlining?
> 
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -222,13 +222,16 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>>  	int size = map_size + defer_size;
>>  
>>  	for_each_node(nid) {
>> +		int tmp = nid;
> 
> Not `tmp', please.  Better to use an identifier which explains the
> variable's use.  target_nid?
> 
> And a newline after defining locals, please.
> 
>>  		pn = memcg->nodeinfo[nid];
>>  		old = shrinker_info_protected(memcg, nid);
>>  		/* Not yet online memcg */
>>  		if (!old)
>>  			return 0;
>>  
>> -		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
>> +		if(!node_online(nid))
> 
> s/if(/if (/
> 
>> +			tmp = numa_mem_id();
>> +		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, tmp);
>>  		if (!new)
>>  			return -ENOMEM;
>>  
> 
> And a code comment fully explaining what's going on here?
> 

