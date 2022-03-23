Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413C84E4AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 02:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240822AbiCWB4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 21:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240157AbiCWB4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 21:56:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 839A456202
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648000510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GQneE/rU6uYhLlhfDWprcrRBY9/cQlczmjL+8igVejo=;
        b=gT7R/uCegvH/p5aLMmbZgYko1Tu3Ewg1dz2OOxuXoltL+IgqlR4x89ml9aDa2HRNgYlGx8
        1o/JOcrGsPkbQjKHCM4JonHzRVQP6O4DyYtkXQrFObCcOd3QraudDwmugwV6pj7crmPC+L
        uNFM8CF6+XlUt/szX6aRfysj85uAxjU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-37AbWpS6Mxu4ESKL-r-VHw-1; Tue, 22 Mar 2022 21:55:07 -0400
X-MC-Unique: 37AbWpS6Mxu4ESKL-r-VHw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B87BE3C11A0B;
        Wed, 23 Mar 2022 01:55:06 +0000 (UTC)
Received: from [10.22.16.140] (unknown [10.22.16.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AF3043E90C;
        Wed, 23 Mar 2022 01:55:06 +0000 (UTC)
Message-ID: <2263666d-5eef-b1fe-d5e3-b166a3185263@redhat.com>
Date:   Tue, 22 Mar 2022 21:55:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH-mm v3] mm/list_lru: Optimize
 memcg_reparent_list_lru_node()
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
References: <20220309144000.1470138-1-longman@redhat.com>
 <CAMZfGtWS581YW4Y8oNU=E_zPnpK=mMdYVSG1F3U3fJNAzBzc+g@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAMZfGtWS581YW4Y8oNU=E_zPnpK=mMdYVSG1F3U3fJNAzBzc+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 21:06, Muchun Song wrote:
> On Wed, Mar 9, 2022 at 10:40 PM Waiman Long <longman@redhat.com> wrote:
>> Since commit 2c80cd57c743 ("mm/list_lru.c: fix list_lru_count_node()
>> to be race free"), we are tracking the total number of lru
>> entries in a list_lru_node in its nr_items field.  In the case of
>> memcg_reparent_list_lru_node(), there is nothing to be done if nr_items
>> is 0.  We don't even need to take the nlru->lock as no new lru entry
>> could be added by a racing list_lru_add() to the draining src_idx memcg
>> at this point.
> Hi Waiman,
>
> Sorry for the late reply.  Quick question: what if there is an inflight
> list_lru_add()?  How about the following race?
>
> CPU0:                               CPU1:
> list_lru_add()
>      spin_lock(&nlru->lock)
>      l = list_lru_from_kmem(memcg)
>                                      memcg_reparent_objcgs(memcg)
>                                      memcg_reparent_list_lrus(memcg)
>                                          memcg_reparent_list_lru()
>                                              memcg_reparent_list_lru_node()
>                                                  if (!READ_ONCE(nlru->nr_items))
>                                                      // Miss reparenting
>                                                      return
>      // Assume 0->1
>      l->nr_items++
>      // Assume 0->1
>      nlru->nr_items++
>
> IIUC, we use nlru->lock to serialise this scenario.

I guess this race is theoretically possible but very unlikely since it 
means a very long pause between list_lru_from_kmem() and the increment 
of nr_items.

How about the following changes to make sure that this race can't happen?

diff --git a/mm/list_lru.c b/mm/list_lru.c
index c669d87001a6..c31a0a8ad4e7 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -395,9 +395,10 @@ static void memcg_reparent_list_lru_node(struct 
list_lru *lru, int nid,
         struct list_lru_one *src, *dst;

         /*
-        * If there is no lru entry in this nlru, we can skip it 
immediately.
+        * If there is no lru entry in this nlru and the nlru->lock is free,
+        * we can skip it immediately.
          */
-       if (!READ_ONCE(nlru->nr_items))
+       if (!READ_ONCE(nlru->nr_items) && !spin_is_locked(&nlru->lock))
                 return;

Cheers,
Longman

