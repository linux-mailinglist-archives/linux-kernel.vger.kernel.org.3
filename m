Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CFC5AA810
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbiIBGcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbiIBGct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58000B3B37
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 23:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662100367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W66TddTf10WkGr4cQGB6HUG4UwEsTwDAwkc3PXqiMWM=;
        b=aFf4q0YvpB/FQ4mlW8zOaELUWuNwihg8BPiLTEw1dsGPHLW5ntLqPMi/tWiOi2vDOg9Ejd
        ihc5ZWKeIdetPLjwOuyDmm8B+Aoh0NYMg5OVI0jAN5XBoEa8OYNWwTC5qtbawpNQQHcF/Z
        9BMZfmAeRlUGwr/+GhYMleU1Be+w1Lk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-41-OMWUQgTUM42mbKWB09EWpQ-1; Fri, 02 Sep 2022 02:32:46 -0400
X-MC-Unique: OMWUQgTUM42mbKWB09EWpQ-1
Received: by mail-wm1-f71.google.com with SMTP id q10-20020a1ce90a000000b003a60123678aso265399wmc.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 23:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=W66TddTf10WkGr4cQGB6HUG4UwEsTwDAwkc3PXqiMWM=;
        b=Kc9dXLHZdcB/3Bl2UaPf6mH8mK6JKg1Qd1dJ5x9bwziYmNNaWQ+Jzz+cUI5nf0M79F
         uY7s5vUYLtyJ/nBAdVUrHy3a4yqOlYTnhM1xn8kqzAxe0pqc0+8bVj5k7aTfD+dDUfoU
         PhXsSVHJt5EAyQv0G6FHvYVYK34+Cg1YHkpJVSwwcHty6aHePfn3DSiVwJJXpo4dYeR9
         01uSK0DTZNQ+K5De9oTpbfCvqmxNALYR5f3HSt7ismB90oLBPeclOOH0DtEc+cpnJuOq
         Id1AL6DvbHgWEzJd7ZwuVQ5QSAJ6MssTifJ4wTli6mL1FcSgvxybiOtXgGcWsacOFG0A
         tR+w==
X-Gm-Message-State: ACgBeo3MZM64qgVa3QSbvI+0yuG1+ch88+cROzGJzZsbsWqmDzqw2zjN
        M1qjMkYpvZkzHnW16N8rf4xljVJ62A48JWksrCPHyafA6jA3/yQXODUYtDcecq3Gg8nQlT6EJYm
        2qLmG8BjXjYl0C/lYzV0+aurW
X-Received: by 2002:a05:6000:1867:b0:21f:f2cf:74a8 with SMTP id d7-20020a056000186700b0021ff2cf74a8mr16650472wri.344.1662100365062;
        Thu, 01 Sep 2022 23:32:45 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7nHhm/k5Mwq1+slOV3fyp2ZPs9Zh86R3uNkCy2dVyoQeIft5ws9NqXuWpcMG3fhtjPyiGzsA==
X-Received: by 2002:a05:6000:1867:b0:21f:f2cf:74a8 with SMTP id d7-20020a056000186700b0021ff2cf74a8mr16650412wri.344.1662100364072;
        Thu, 01 Sep 2022 23:32:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c714:4800:2077:1bf6:40e7:2833? (p200300cbc714480020771bf640e72833.dip0.t-ipconnect.de. [2003:cb:c714:4800:2077:1bf6:40e7:2833])
        by smtp.gmail.com with ESMTPSA id k27-20020a05600c1c9b00b003a845fa1edfsm14815062wms.3.2022.09.01.23.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 23:32:43 -0700 (PDT)
Message-ID: <2368d91f-8442-076f-f33a-64b51b44825c@redhat.com>
Date:   Fri, 2 Sep 2022 08:32:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jerome Marchand <jmarchan@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
References: <20220901072119.37588-1-david@redhat.com>
 <YxDdycTur733hMgt@xz-m1.local>
 <fa0bb4b1-3edd-eb5a-7ad6-dff785d88d8f@redhat.com>
 <YxDghv54uHYMGCfG@xz-m1.local>
 <c9dc3f22-4a72-9b9d-7a74-ad77fe4f3b6e@redhat.com>
 <CAHbLzkpdUMq2fMxqx-NgSZ2VLBU5RGqSpJRWH6eRrYymErAbaw@mail.gmail.com>
 <YxD00K1lv151X/eq@xz-m1.local>
 <CAHbLzkrA-jKzTBq_Mn3NZYc91exovv1gH2LNzetCNiVu8+W6Kg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1] mm/gup: adjust stale comment for RCU GUP-fast
In-Reply-To: <CAHbLzkrA-jKzTBq_Mn3NZYc91exovv1gH2LNzetCNiVu8+W6Kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.22 20:35, Yang Shi wrote:
> On Thu, Sep 1, 2022 at 11:07 AM Peter Xu <peterx@redhat.com> wrote:
>>
>> On Thu, Sep 01, 2022 at 10:50:48AM -0700, Yang Shi wrote:
>>> Yeah, because THP collapse does copy the data before clearing pte. If
>>> we want to remove pmdp_collapse_flush() by just clearing pmd, we
>>> should clear *AND* flush pte before copying the data IIRC.
>>
>> Yes tlb flush is still needed.  IIUC the generic pmdp_collapse_flush() will
>> still be working (with the pte level flushing there) but it should just
>> start to work for all archs, so potentially we could drop the arch-specific
>> pmdp_collapse_flush()s, mostly the ppc impl.
> 
> I'm don't know why powperpc needs to have its specific
> pmdp_collapse_flush() in the first place, not only the mandatory IPI
> broadcast, but also the specific implementation of pmd tlb flush. But
> anyway the IPI broadcast could be removed at least IMO.
> 

pmdp_collapse_flush() is overwritten on book3s only. It either translates
to radix__pmdp_collapse_flush() or hash__pmdp_collapse_flush().


radix__pmdp_collapse_flush() has a comment explaining the situation:


+       /*
+        * pmdp collapse_flush need to ensure that there are no parallel gup
+        * walk after this call. This is needed so that we can have stable
+        * page ref count when collapsing a page. We don't allow a collapse page
+        * if we have gup taken on the page. We can ensure that by sending IPI
+        * because gup walk happens with IRQ disabled.
+        */


The comment for hash__pmdp_collapse_flush() is a bit more involved:

	/*
	 * Wait for all pending hash_page to finish. This is needed
	 * in case of subpage collapse. When we collapse normal pages
	 * to hugepage, we first clear the pmd, then invalidate all
	 * the PTE entries. The assumption here is that any low level
	 * page fault will see a none pmd and take the slow path that
	 * will wait on mmap_lock. But we could very well be in a
	 * hash_page with local ptep pointer value. Such a hash page
	 * can result in adding new HPTE entries for normal subpages.
	 * That means we could be modifying the page content as we
	 * copy them to a huge page. So wait for parallel hash_page
	 * to finish before invalidating HPTE entries. We can do this
	 * by sending an IPI to all the cpus and executing a dummy
	 * function there.
	 */

I'm not sure if that implies that the IPI is needed for some other hash-magic.

Maybe Aneesh can clarify.

>>
>> This also reminded me that the s390 version of pmdp_collapse_flush() is a
>> bit weird, since it doesn't even have the tlb flush there.  I feel like
>> it's broken but I can't really tell whether something I've overlooked.
>> Worth an eye on.
> 
> I don't know why. But if s390 doesn't flush tlb in
> pmdp_collapse_flush(), then there may be data integrity problem since
> the page is still writable when copying the data because pte is
> cleared after data copying. Or s390 hardware does flush tlb
> automatically?

s390x does a pmdp_huge_get_and_clear().

pmdp_huge_get_and_clear() does an pmdp_xchg_direct().

pmdp_xchg_direct() does an pmdp_flush_direct().

pmdp_flush_direct() issues an IDTE, which is a TLB flush.


Note that this matches ptep_get_and_clear() behavior on s390x. Quoting the comment in there:


/*
 * This is hard to understand. ptep_get_and_clear and ptep_clear_flush
 * both clear the TLB for the unmapped pte. The reason is that
 * ptep_get_and_clear is used in common code (e.g. change_pte_range)
 * to modify an active pte. The sequence is
 *   1) ptep_get_and_clear
 *   2) set_pte_at
 *   3) flush_tlb_range
 * On s390 the tlb needs to get flushed with the modification of the pte
 * if the pte is active. The only way how this can be implemented is to
 * have ptep_get_and_clear do the tlb flush. In exchange flush_tlb_range
 * is a nop.
 */

-- 
Thanks,

David / dhildenb

