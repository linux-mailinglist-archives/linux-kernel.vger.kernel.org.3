Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D840B46C8A3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238556AbhLHA3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:29:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51841 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhLHA3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638923129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vL66q55dWWCdgYpPhLfU3fp1NwArxVg0aJUFZipYmVg=;
        b=VOlZRk3RsCgnZsziVAJUT740oL++CNB3qCNQjr26AdbGHFnS/gy4uy4e1+ujZm1vQ65aBS
        DOA9el2R6fWu08Kp448aYO0KHXBqYjfr1megBp9YnV0vAL5h/F8jAuBFvHR4bbElsUa8A0
        H2e+U/Uyre0G+LYkVbHUNFaBD/3rQlQ=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-wPo9IskZPReRVqSdLVvHVQ-1; Tue, 07 Dec 2021 19:25:28 -0500
X-MC-Unique: wPo9IskZPReRVqSdLVvHVQ-1
Received: by mail-il1-f199.google.com with SMTP id j1-20020a056e02154100b002a181a1ce89so1006425ilu.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 16:25:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vL66q55dWWCdgYpPhLfU3fp1NwArxVg0aJUFZipYmVg=;
        b=Lq0A6WXE4UV9ZEFIqyLCz1t1V56NrA9aFfeaH/nIPkViGgM6sj4KIS2KpCBJfQYwnE
         8QZ6e/b6Sa/06JLUvl97Xks2f4qMYUo1rQE50VuuwczI7N3U7N97st/VJ41ZAFnTwb9J
         mdk3phlY6EGmqM/Bn4g8tJbOX1BJ7bZeeepFPjwvsKN5QRq2lB0TFMLGy3oKvy/CsyqT
         2JS/REKmB+/jxBCNNFbHtpvDlsth61QVn3Hiozak8lVCZew3lUDyjjFYUYG6suo1esC6
         uVPbb/1lXYw87Q1qK1gdWn4YIOjl2hc34LJbjgbmaqDpx/1DFUMjWa09cI1jS7ZWnuYp
         KSnQ==
X-Gm-Message-State: AOAM532ir9C6EGUqssCbGPSMRsGYOus8vyXWOJRRoLkZz4jegn4pPR8R
        oaEMl0udPPGb53dnHGoNoQLXbxAmCShC+goQFpZoyUOp2oq2oTRBZe1WY9exQXaEXF+n2SiUkGG
        5eoIbmWZ6mqLCXPoIy8yUAvLT
X-Received: by 2002:a05:6638:1607:: with SMTP id x7mr56534040jas.27.1638923127500;
        Tue, 07 Dec 2021 16:25:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzXfTdYROr2ty3V9158qTk1ZTQBQ1cnMMfIFquYrZLWi36z/QOZojMKQAvzcw/3cICEXoCaA==
X-Received: by 2002:a05:6638:1607:: with SMTP id x7mr56534028jas.27.1638923127373;
        Tue, 07 Dec 2021 16:25:27 -0800 (PST)
Received: from ?IPV6:2601:280:4400:a2e0:7336:512c:930d:4f0e? ([2601:280:4400:a2e0:7336:512c:930d:4f0e])
        by smtp.gmail.com with ESMTPSA id t6sm764024ios.13.2021.12.07.16.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 16:25:27 -0800 (PST)
Message-ID: <a1c3e952-866d-e3b4-1479-8f04e963bf11@redhat.com>
Date:   Tue, 7 Dec 2021 19:25:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/1] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>, mhocko@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        ktkhai@virtuozzo.com, shy828301@gmail.com, guro@fb.com,
        vbabka@suse.cz, vdavydov.dev@gmail.com, raquini@redhat.com,
        david@redhat.com
References: <20211207224013.880775-1-npache@redhat.com>
 <20211207224013.880775-2-npache@redhat.com>
 <Ya/vaGdKHm6Zy3ML@casper.infradead.org>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <Ya/vaGdKHm6Zy3ML@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/21 18:34, Matthew Wilcox wrote:
> On Tue, Dec 07, 2021 at 05:40:13PM -0500, Nico Pache wrote:
>> +++ b/mm/vmscan.c
>> @@ -222,13 +222,16 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>>  	int size = map_size + defer_size;
>>  
>>  	for_each_node(nid) {
>> +		int tmp = nid;
>>  		pn = memcg->nodeinfo[nid];
>>  		old = shrinker_info_protected(memcg, nid);
>>  		/* Not yet online memcg */
>>  		if (!old)
>>  			return 0;
>>  
>> -		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
>> +		if(!node_online(nid))
>> +			tmp = numa_mem_id();
>> +		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, tmp);
>>  		if (!new)
> 
> Why should this be fixed here and not in, say, kvmalloc_node()?

according to Michal, the caller should be responsible for making sure it is
allocating on a correct node. This avoids adding branches to hot-paths and
wasting cycles. Im not opposed to moving it to kvmalloc_node, but it may result
in masking other issues from other callers.
> 

