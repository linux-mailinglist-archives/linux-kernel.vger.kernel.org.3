Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C784D30F3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiCIOXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbiCIOXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:23:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 792D6106CA4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 06:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646835758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eBdr36BGk28rRgdEtMTExffYNjapNYQlJHsocuTv1h0=;
        b=Qq/u3Cy5BYxH1q+I8LWNQkhqW8VE0XSVhCqapSqIzWMNKwRxEya83I1u4EdK1luY15UFux
        1UKLnn75TyszoWO1QO7cuiyVCnq/ZngOBiy4yyGPksBaHP12Qz50KTcwkX5fgpLjgKlFch
        lzkz0uxJ+9/X41FQNAdOdooVB0W/bLo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-79oIyWLvPSKnb0LlI_EVJA-1; Wed, 09 Mar 2022 09:22:33 -0500
X-MC-Unique: 79oIyWLvPSKnb0LlI_EVJA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79551824FA6;
        Wed,  9 Mar 2022 14:22:31 +0000 (UTC)
Received: from [10.22.18.30] (unknown [10.22.18.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D937923760;
        Wed,  9 Mar 2022 14:22:30 +0000 (UTC)
Message-ID: <45202ef8-1c4a-0f08-d394-b6e0de1307c1@redhat.com>
Date:   Wed, 9 Mar 2022 09:22:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH-mm v2] mm/list_lru: Optimize
 memcg_reparent_list_lru_node()
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
References: <20220309011824.1454619-1-longman@redhat.com>
 <YigNVbz/h8wzNjs/@carbon.dhcp.thefacebook.com>
 <54ea34a9-e261-3521-ce11-efc59c9a803c@redhat.com>
 <YigxKUONWa4iBYvk@carbon.dhcp.thefacebook.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YigxKUONWa4iBYvk@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/22 23:46, Roman Gushchin wrote:
> On Tue, Mar 08, 2022 at 10:12:48PM -0500, Waiman Long wrote:
>> On 3/8/22 21:13, Roman Gushchin wrote:
>>> On Tue, Mar 08, 2022 at 08:18:24PM -0500, Waiman Long wrote:
>>>> Since commit 2c80cd57c743 ("mm/list_lru.c: fix list_lru_count_node()
>>>> to be race free"), we are tracking the total number of lru
>>>> entries in a list_lru_node in its nr_items field.  In the case of
>>>> memcg_reparent_list_lru_node(), there is nothing to be done if nr_items
>>>> is 0.  We don't even need to take the nlru->lock as no new lru entry
>>>> could be added by a racing list_lru_add() to the draining src_idx memcg
>>>> at this point.
>>>>
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>> ---
>>>>    mm/list_lru.c | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/mm/list_lru.c b/mm/list_lru.c
>>>> index ba76428ceece..c669d87001a6 100644
>>>> --- a/mm/list_lru.c
>>>> +++ b/mm/list_lru.c
>>>> @@ -394,6 +394,12 @@ static void memcg_reparent_list_lru_node(struct list_lru *lru, int nid,
>>>>    	int dst_idx = dst_memcg->kmemcg_id;
>>>>    	struct list_lru_one *src, *dst;
>>>> +	/*
>>>> +	 * If there is no lru entry in this nlru, we can skip it immediately.
>>>> +	 */
>>>> +	if (!READ_ONCE(nlru->nr_items))
>>>> +		return;
>>> This is a per-node counter, not a per-memcg, right?
>> Right. list_lru_node is a per-node structure inside list_lru.
>>> If so, do we optimize for the case when all lru items belong to one node and
>>> others are empty?
>> That is actually the case that I am trying to optimize for.
>>
>> If a system has many containers. It is also likely each container may mount
>> one or more container specific filesystems. Since a container likely use
>> just a few cpus, it is highly that only the list_lru_node that contains
>> those cpus will be utilized while the rests may be empty.
>>
>> I got the idea of doing this patch when I was looking at a crash dump
>> related to the list_lru code. That particular crash dump has more than 13k
>> list_lru's and thousands of mount points. I had notice even if nr_items of a
>> list_lru_node is 0, it still tries to transfer lru entries from source idx
>> to dest idx. Without doing an lock/unlock and loading a cacheline from the
>> memcg_lrus, it can save some time. That can be substantial saving if we are
>> talking about thousands of list_lru's.
> Cool! Makes total sense to me. Thanks for the explanation!
> Would you mind to add this text to the commit log?
>
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Sure. I will add some of it into the commit log.

Cheers,
Longman

