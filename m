Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5181546DBB8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 20:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbhLHTDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 14:03:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47886 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232745AbhLHTDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 14:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638990005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/s5sY1q6PQLBZ20cR9DzmY70ulSv5YBsSaYi6x4GpDY=;
        b=QjJtTXKC5DmNt0X4XweHxmRuY5fF0wW8ncigiWMEaKI0AtaxntcT1mlfQP0e7Ttssr9Rf7
        fP0p/eB+Z5OJGXseySzoFTt9WnsPgm4EGjSH9dLpGRIS97raqzaApDvvMzaqurU9l7pCC0
        rTaELph05U5YBklKa+YRu86uIS8zxAQ=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-Q0L7VzqkOBuALBbwLOSHZA-1; Wed, 08 Dec 2021 14:00:04 -0500
X-MC-Unique: Q0L7VzqkOBuALBbwLOSHZA-1
Received: by mail-io1-f71.google.com with SMTP id 7-20020a6b0107000000b005ed196a2546so4261327iob.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 11:00:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/s5sY1q6PQLBZ20cR9DzmY70ulSv5YBsSaYi6x4GpDY=;
        b=LVlTDs+9asOUjzg8PqesqvcOVT3sC9lF4Grh//yvqoJavISv/XEjm7OG6/Quj1p/M7
         CofLEgoTXc92wRDgwjYoWHV7xGldr6pn7a89hqO1b2TDDS2WGyzux4HZL0ezqXLOAOey
         s3pFn5GEjopBI8n6pgOCqVUazs2BynXyPnxgQoNLzwzubp9gwVj6QJ+F8lilOS33u5gt
         ufMGSe6UmRwI8YMKPHK33XPzrGdwmi9XELx17zXJcChZztGtYm92JJILe97/K0hV1Y7A
         pdDiHJGDzLSg3OvHHA/f90orHbiUzW39Gp6Rbmi8BCI/1/oMNpm92lBPvRwgTVQhw0si
         aBeA==
X-Gm-Message-State: AOAM530eR9EpD8Og/JJBUc2y9KFd/CUHVYdegVCyoMHomxPpEZek5K7E
        NZJW0jD81AwPX55qsCe+CFJzYLwfl9eQTZWxHZ9mh7xvw8YSQKnZMxjrNrJ6CrrKI93PNx8y+he
        AA/4lTzit92brtaDOyoEItNmw
X-Received: by 2002:a05:6e02:1a4e:: with SMTP id u14mr9503475ilv.121.1638990003163;
        Wed, 08 Dec 2021 11:00:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwa/4oyrYKSSiV1Tlcx49cqVJY9TfwWzcP/p9FEMpdLD7xA5zXrnnJowGLqiv143OngjfBbCw==
X-Received: by 2002:a05:6e02:1a4e:: with SMTP id u14mr9503450ilv.121.1638990002973;
        Wed, 08 Dec 2021 11:00:02 -0800 (PST)
Received: from ?IPV6:2601:280:4400:a2e0:7336:512c:930d:4f0e? ([2601:280:4400:a2e0:7336:512c:930d:4f0e])
        by smtp.gmail.com with ESMTPSA id l9sm2215746ilh.82.2021.12.08.11.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 11:00:02 -0800 (PST)
Message-ID: <aa8a8deb-0fdb-9408-48d4-adadb5602d72@redhat.com>
Date:   Wed, 8 Dec 2021 14:00:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        shy828301@gmail.com, guro@fb.com, vbabka@suse.cz,
        vdavydov.dev@gmail.com, raquini@redhat.com
References: <20211206033338.743270-1-npache@redhat.com>
 <20211206033338.743270-3-npache@redhat.com> <Ya3WcYKcej8XEI0W@dhcp22.suse.cz>
 <d9d14beb-ee20-7ebb-e007-fbf58fb28535@redhat.com>
 <24b4455c-aff9-ca9f-e29f-350833e7a0d1@virtuozzo.com>
 <Ya4PGJZL8tSb/Prj@dhcp22.suse.cz>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <Ya4PGJZL8tSb/Prj@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/21 08:24, Michal Hocko wrote:
> On Mon 06-12-21 16:19:12, Kirill Tkhai wrote:
>> On 06.12.2021 13:45, David Hildenbrand wrote:
>>>> This doesn't seen complete. Slab shrinkers are used in the reclaim
>>>> context. Previously offline nodes could be onlined later and this would
>>>> lead to NULL ptr because there is no hook to allocate new shrinker
>>>> infos. This would be also really impractical because this would have to
>>>> update all existing memcgs...
>>>
>>> Instead of going through the trouble of updating...
>>>
>>> ...  maybe just keep for_each_node() and check if the target node is
>>> offline. If it's offline, just allocate from the first online node.
>>> After all, we're not using __GFP_THISNODE, so there are no guarantees
>>> either way ...
>>
>> Hm, can't we add shrinker maps allocation to __try_online_node() in addition
>> to this patch? 
> 
> Either that or through hotplug notifier (which would be a better
> solution). But allocating a new shrinker map for each memcg would have
> to be done as has been mentioned earlier.

I took a stab at this approach. It may be incomplete but please let me know what
you think. This would go on top of this series.

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0c5c403f4be6..6c842382fa73 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -520,6 +520,7 @@ static inline struct mem_cgroup *page_memcg_check(struct
page *page)
 	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }

+int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node);
 #ifdef CONFIG_MEMCG_KMEM
 /*
  * folio_memcg_kmem - Check if the folio has the memcg_kmem flag set.
diff --git a/include/linux/node.h b/include/linux/node.h
index bb21fd631b16..5e8c737ea751 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -19,7 +19,7 @@
 #include <linux/cpumask.h>
 #include <linux/list.h>
 #include <linux/workqueue.h>
-
+#include <linux/memcontrol.h>
 /**
  * struct node_hmem_attrs - heterogeneous memory performance attributes
  *
@@ -118,6 +118,7 @@ extern int __register_one_node(int nid);
 /* Registers an online node */
 static inline int register_one_node(int nid)
 {
+	struct mem_cgroup *memcg;
 	int error = 0;

 	if (node_online(nid)) {
@@ -130,6 +131,14 @@ static inline int register_one_node(int nid)
 			return error;
 		/* link memory sections under this node */
 		link_mem_sections(nid, start_pfn, end_pfn, MEMINIT_EARLY);
+		/* Iterate over memcgs and update nodeinfo  */
+		memcg = mem_cgroup_iter(NULL, NULL, NULL);
+		do {
+			if (alloc_mem_cgroup_per_node_info(memcg,nid)) {
+				mem_cgroup_iter_break(NULL, memcg);
+				return error;
+			}
+		} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
 	}

 	return error;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6863a834ed42..2d55fad3229b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5041,18 +5041,11 @@ struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
 	return idr_find(&mem_cgroup_idr, id);
 }

-static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
+int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 {
 	struct mem_cgroup_per_node *pn;
 	int tmp = node;
-	/*
-	 * This routine is called against possible nodes.
-	 * But it's BUG to call kmalloc() against offline node.
-	 *
-	 * TODO: this routine can waste much memory for nodes which will
-	 *       never be onlined. It's better to use memory hotplug callback
-	 *       function.
-	 */
+
 	if (!node_state(node, N_NORMAL_MEMORY))
 		tmp = -1;
 	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, tmp);
@@ -5130,7 +5123,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	if (!memcg->vmstats_percpu)
 		goto fail;

-	for_each_node(node)
+	for_each_online_node(node)
 		if (alloc_mem_cgroup_per_node_info(memcg, node))
 			goto fail;

