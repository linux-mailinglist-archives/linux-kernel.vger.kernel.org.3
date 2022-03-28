Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FCB4E8B5F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 02:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbiC1BAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 21:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiC1BAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 21:00:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CA3920197
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 17:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648429143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uYLrKmIc1xkKOwwKtiACpW66v+e2X/uJupKKYBNVgY4=;
        b=B6KNmWukPS6K4JXTB1clCCpD9vJUjcmWSjQzCw3/S5K7MZj8cONYDxVM8pY/eFupGs75im
        QvQQDLPDXmfOnn0elUd2sp3mitzinPKqn/iW1ESwN8epVx2aBPEVImH2h+GOSQ140ITvfW
        rVqHUsOoDHqakU8PeuUK89nQIxjmUPc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-mOREWdQSM1KgkyRB0mBASg-1; Sun, 27 Mar 2022 20:58:59 -0400
X-MC-Unique: mOREWdQSM1KgkyRB0mBASg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C36E2A59559;
        Mon, 28 Mar 2022 00:58:59 +0000 (UTC)
Received: from [10.22.16.95] (unknown [10.22.16.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1643A1121318;
        Mon, 28 Mar 2022 00:58:59 +0000 (UTC)
Message-ID: <c72b89a7-9946-ebad-cdc7-5626233efabe@redhat.com>
Date:   Sun, 27 Mar 2022 20:58:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm/list_lru: Fix possible race in
 memcg_reparent_list_lru_node()
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
References: <20220328005736.2513727-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220328005736.2513727-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/22 20:57, Waiman Long wrote:
> Muchun Song found out there could be a race between list_lru_add()
> and memcg_reparent_list_lru_node() causing the later function to miss
> reparenting of a lru entry as shown below:
>
> CPU0:                               CPU1:
> list_lru_add()
>       spin_lock(&nlru->lock)
>       l = list_lru_from_kmem(memcg)
>                                       memcg_reparent_objcgs(memcg)
>                                       memcg_reparent_list_lrus(memcg)
>                                           memcg_reparent_list_lru()
>                                               memcg_reparent_list_lru_node()
>                                                   if (!READ_ONCE(nlru->nr_items))
>                                                       // Miss reparenting
>                                                       return
>       // Assume 0->1
>       l->nr_items++
>       // Assume 0->1
>       nlru->nr_items++
>
> Though it is not likely that a list_lru_node that has 0 item suddenly
> has a newly added lru entry at the end of its life. The race is still
> theoretically possible.
>
> Adding a spin_is_locked() check will likely be enough for x86, but it
> is less certain for other arches with a more relaxed memory semantics
> like arcm64 and ppc. To avoid race, this patch moves the nr_items check
> to within the lock critical section.
>
> Fixes: 405cc51fc104 ("mm/list_lru: optimize memcg_reparent_list_lru_node()")

Sorry, I should have added

Reported-by: Muchun Song <songmuchun@bytedance.com>

> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   mm/list_lru.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index c669d87001a6..8aec8ebd5995 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -394,18 +394,18 @@ static void memcg_reparent_list_lru_node(struct list_lru *lru, int nid,
>   	int dst_idx = dst_memcg->kmemcg_id;
>   	struct list_lru_one *src, *dst;
>   
> -	/*
> -	 * If there is no lru entry in this nlru, we can skip it immediately.
> -	 */
> -	if (!READ_ONCE(nlru->nr_items))
> -		return;
> -
>   	/*
>   	 * Since list_lru_{add,del} may be called under an IRQ-safe lock,
>   	 * we have to use IRQ-safe primitives here to avoid deadlock.
>   	 */
>   	spin_lock_irq(&nlru->lock);
>   
> +	/*
> +	 * If there is no lru entry in this nlru, we can skip it immediately.
> +	 */
> +	if (!nlru->nr_items)
> +		goto out;
> +
>   	src = list_lru_from_memcg_idx(lru, nid, src_idx);
>   	if (!src)
>   		goto out;
Cheers,
Longman

