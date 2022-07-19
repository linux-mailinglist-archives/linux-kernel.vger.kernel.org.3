Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63A557A217
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbiGSOov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240018AbiGSOo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:44:27 -0400
Received: from out199-13.us.a.mail.aliyun.com (out199-13.us.a.mail.aliyun.com [47.90.199.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42599BB8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:43:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VJsAilE_1658241782;
Received: from 30.30.98.197(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VJsAilE_1658241782)
          by smtp.aliyun-inc.com;
          Tue, 19 Jul 2022 22:43:03 +0800
Message-ID: <cd9c83de-7ee5-6dae-a2e4-4b6b0a9800f7@linux.alibaba.com>
Date:   Tue, 19 Jul 2022 22:43:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:103.0)
 Gecko/20100101 Thunderbird/103.0
Subject: Re: [PATCH 1/3] mm/slub: fix the race between validate_slab and
 slab_free
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@linux.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com>
 <69462916-2d1c-dd50-2e64-b31c2b61690e@suse.cz>
 <5344e023-29f0-9285-a402-19e2a556dbb0@linux.alibaba.com>
 <ad258412-2f8f-8e15-fbd0-c0933aeb1a6d@suse.cz>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <ad258412-2f8f-8e15-fbd0-c0933aeb1a6d@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/22 10:21 PM, Vlastimil Babka wrote:
> On 7/19/22 16:15, Rongwei Wang wrote:
>>
> ...
>>> +
>>> +    slab_unlock(slab, &flags2);
>>> +    spin_unlock_irqrestore(&n->list_lock, flags);
>>> +    if (!ret)
>>> +        slab_fix(s, "Object at 0x%p not freed", object);
>>> +    if (slab_to_discard) {
>>> +        stat(s, FREE_SLAB);
>>> +        discard_slab(s, slab);
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>> I had test this patch, and it indeed deal with the bug that I described.
> 
> Thanks.
> 
>> Though I am also has prepared this part of code, your code is ok to me.
> 
> Aha, feel free to post your version, maybe it's simpler? We can compare.
My code only includes the part of your free_debug_processing(), the 
structure of it likes:

slab_free() {
     if (kmem_cache_debug(s))
         slab_free_debug();
     else
         __do_slab_free();
}

The __slab_free_debug() here likes your free_debug_processing().

+/*
+ * Slow path handling for debugging.
+ */
+static void __slab_free_debug(struct kmem_cache *s, struct slab *slab,
+                       void *head, void *tail, int cnt,
+                       unsigned long addr)
+
+{
+       void *prior;
+       int was_frozen;
+       struct slab new;
+       unsigned long counters;
+       struct kmem_cache_node *n = NULL;
+       unsigned long flags;
+       int ret;
+
+       stat(s, FREE_SLOWPATH);
+
+       if (kfence_free(head))
+               return;
+
+       n = get_node(s, slab_nid(slab));
+
+       spin_lock_irqsave(&n->list_lock, flags);
+       ret = free_debug_processing(s, slab, head, tail, cnt, addr);
+       if (!ret) {
+               spin_unlock_irqrestore(&n->list_lock, flags);
+               return;
+       }
+
+       do {
+               prior = slab->freelist;
+               counters = slab->counters;
+               set_freepointer(s, tail, prior);
+               new.counters = counters;
+               was_frozen = new.frozen;
+               new.inuse -= cnt;
+       } while (!cmpxchg_double_slab(s, slab,
+               prior, counters,
+               head, new.counters,
+               "__slab_free"));
+
+       if ((new.inuse && prior) || was_frozen) {
+               spin_unlock_irqrestore(&n->list_lock, flags);
+               if (likely(was_frozen)) {
+                       stat(s, FREE_FROZEN);
+               }
+
+               return;
+       }
+
+       if (!new.inuse && n->nr_partial >= s->min_partial) {
+               /* Indicate no user in this slab, discarding it 
naturally. */
+               if (prior) {
+                       /* Slab on the partial list. */
+                       remove_partial(n, slab);
+                       stat(s, FREE_REMOVE_PARTIAL);
+               } else {
+                       /* Slab must be on the full list */
+                       remove_full(s, n, slab);
+               }
+
+               spin_unlock_irqrestore(&n->list_lock, flags);
+               stat(s, FREE_SLAB);
+               discard_slab(s, slab);
+               return;
+       }
+
+       /*
+        * Objects left in the slab. If it was not on the partial list 
before
+        * then add it.
+        */
+       if (!prior) {
+               remove_full(s, n, slab);
+               add_partial(n, slab, DEACTIVATE_TO_TAIL);
+               stat(s, FREE_ADD_PARTIAL);
+       }
+       spin_unlock_irqrestore(&n->list_lock, flags);
+
+       return;
+}




