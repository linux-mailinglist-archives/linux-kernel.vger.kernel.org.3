Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA7146C172
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 18:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239934AbhLGRRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 12:17:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52201 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235416AbhLGRRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638897241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=COjwenkxm8hGw0a/Dri2jSsDB5SQ1RS6CEtMSB+/ozY=;
        b=c1ifsPF34s+jREXvyx+5lbluYDokFP7kc+syw9QP0RF6B4TnO0DjtJ1wgEVcUw0pY0rbzd
        NGgw4a1NMYuMkvFo6FnQFvkPcIA4tUApAc68JRGgBRG2b1QQ6hPe/1mhMusmrNzL0EOx9C
        UEI1FhjQcBwDLsx1oWYGEJm+aN9epYw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-228-hAh0r0IKMHSyhqiFbM5FjQ-1; Tue, 07 Dec 2021 12:13:58 -0500
X-MC-Unique: hAh0r0IKMHSyhqiFbM5FjQ-1
Received: by mail-wr1-f69.google.com with SMTP id q15-20020adfbb8f000000b00191d3d89d09so3205345wrg.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 09:13:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=COjwenkxm8hGw0a/Dri2jSsDB5SQ1RS6CEtMSB+/ozY=;
        b=m30Bhygfb8GqhNygAarzRAEzFIun979XKZn5ZB/RrRMiHBn7waBuwZ/M7E8N5gqcQI
         12Cakyipm61YS5MgxlR9O2Wzb2lIGqKgv85fNm3MRvXhQJEG7jCalA0iboQT8TjdReRa
         DKimxLxH3wmjne8VoZ6o8NmqAuqoIDd3ngncWqx8BT3q51n1wBe7K/C6nciERgtjRsf6
         pwvePkUGxAidvqTgdikrcsJ9bok/uxLOez4/rAs8V1oM6IlY9ULDzJqzr+bKrD0MAZEd
         ik2RU3J9Oi6aHkX9yq1j7CbFARs8xjEGVoz7wW2bphDR8PViA70J3cZvK5vT5W8pZKEv
         bGLw==
X-Gm-Message-State: AOAM531QLKHYOdPeSk8aBUNFZZcHunGkz2gHbpnHlJ1l56xZHUiY310K
        U4OmtyGQEep6+QEJvRa3cdxOqhcrIKHXaWmi5OpQSJlNTcnCWXq5QJMQshQ+McRTCkOIEe78OF3
        Cbl7stVzeGJyVoG4058D4w8ny
X-Received: by 2002:a5d:69c5:: with SMTP id s5mr52069887wrw.283.1638897237001;
        Tue, 07 Dec 2021 09:13:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCJkHHVGi9mxMYTS+DiyWjrvsVzRsKQc/2NJz+8bbKe4P0ECvPXyPr8uhORN0NXaxXbVLPDQ==
X-Received: by 2002:a5d:69c5:: with SMTP id s5mr52069854wrw.283.1638897236754;
        Tue, 07 Dec 2021 09:13:56 -0800 (PST)
Received: from [192.168.3.132] (p4ff23e57.dip0.t-ipconnect.de. [79.242.62.87])
        by smtp.gmail.com with ESMTPSA id d2sm3516059wmb.24.2021.12.07.09.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 09:13:56 -0800 (PST)
Message-ID: <21539fc8-15a8-1c8c-4a4f-8b85734d2a0e@redhat.com>
Date:   Tue, 7 Dec 2021 18:13:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3] mm: fix panic in __alloc_pages
Content-Language: en-US
To:     Alexey Makhalov <amakhalov@vmware.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <1043a1a4-b7f2-8730-d192-7cab9f15ee24@redhat.com>
 <Ya9P5NxhcZDcyptT@dhcp22.suse.cz>
 <ab5cfba0-1d49-4e4d-e2c8-171e24473c1b@redhat.com>
 <Ya9gN3rZ1eQou3rc@dhcp22.suse.cz>
 <77e785e6-cf34-0cff-26a5-852d3786a9b8@redhat.com>
 <Ya992YvnZ3e3G6h0@dhcp22.suse.cz>
 <b7deaf90-8c3c-c22a-b8dc-e6d98bc93ae6@redhat.com>
 <Ya+EHUYgzo8GaCeq@dhcp22.suse.cz>
 <d01c20fe-86d2-1dc8-e56d-15c0da49afb3@redhat.com>
 <Ya+LbaD8mkvIdq+c@dhcp22.suse.cz> <Ya+Nq2fWrSgl79Bn@dhcp22.suse.cz>
 <2E174230-04F3-4798-86D5-1257859FFAD8@vmware.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <2E174230-04F3-4798-86D5-1257859FFAD8@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.12.21 18:02, Alexey Makhalov wrote:
> 
> 
>> On Dec 7, 2021, at 8:36 AM, Michal Hocko <mhocko@suse.com> wrote:
>>
>> On Tue 07-12-21 17:27:29, Michal Hocko wrote:
>> [...]
>>> So your proposal is to drop set_node_online from the patch and add it as
>>> a separate one which handles
>>> 	- sysfs part (i.e. do not register a node which doesn't span a
>>> 	  physical address space)
>>> 	- hotplug side of (drop the pgd allocation, register node lazily
>>> 	  when a first memblocks are registered)
>>
>> In other words, the first stage
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index c5952749ad40..f9024ba09c53 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -6382,7 +6382,11 @@ static void __build_all_zonelists(void *data)
>> 	if (self && !node_online(self->node_id)) {
>> 		build_zonelists(self);
>> 	} else {
>> -		for_each_online_node(nid) {
>> +		/*
>> +		 * All possible nodes have pgdat preallocated
>> +		 * free_area_init
>> +		 */
>> +		for_each_node(nid) {
>> 			pg_data_t *pgdat = NODE_DATA(nid);
>>
>> 			build_zonelists(pgdat);
> 
> Will it blow up memory usage for the nodes which might never be onlined?
> I prefer the idea of init on demand.
> 
> Even now there is an existing problem.
> In my experiments, I observed _huge_ memory consumption increase by increasing number
> of possible numa nodes. I’m going to report it in separate mail thread.

I already raised that PPC might be problematic in that regard. Which
architecture / setup do you have in mind that can have a lot of possible
nodes?


-- 
Thanks,

David / dhildenb

