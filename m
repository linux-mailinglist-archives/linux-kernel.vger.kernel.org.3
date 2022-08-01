Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAFF586645
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiHAIVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiHAIVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:21:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0A492B631
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659342096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HBClpZM4c3tRI2ZtjvvEsL5Ch6l2+EpXFVIr6Odc95M=;
        b=Oz5Ote/pz+/Wr+QpXYGVROPfYRNeumAaEsn+AL9g9XB/40CHbBvpdzsE32KYNNUqzxDA6N
        OmbhbNjM/NofutUZ/eoeSENzrgAeMWePHH3QzHyZ/vb8uhpJJq4U5JYP3RMTQcjXkPgvCh
        qtCDZwx4BG7JvbBqXaEVvNE/EyCOxnM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-FKX1hLBnNgKJ-96AHvJF2Q-1; Mon, 01 Aug 2022 04:21:35 -0400
X-MC-Unique: FKX1hLBnNgKJ-96AHvJF2Q-1
Received: by mail-wm1-f72.google.com with SMTP id az39-20020a05600c602700b003a321d33238so4928289wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 01:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=HBClpZM4c3tRI2ZtjvvEsL5Ch6l2+EpXFVIr6Odc95M=;
        b=0s/DdCVUakba7C9CPRlwppoQE/eIuAGsgmcWcNVwK1hf0U2AxscQLTgPiR7uGHKmol
         7QdhJYUKXH4pDn6UnYoBrwE8ERPio2qpaxU0lePmQgOxgFm7TPjF89OQN3EhsUuadTr3
         HdGpwDOCLnUUBDLb+xIyR7I226dVKmgK8entuwUbzEVZ45s4AnZ1ud/lV3EFky8Yd2fV
         yMjJmg3TnDbmbuhlNLQ+6JOf0wE1TdCZ0HOJb5vh/u/Y9sqDupjv/9Iv+14vGX1fc1R0
         SI/zLZsqpdbOIu4cdM84J6t+zWS0dNjldZEHRZ660+vEPd22ao0IL5dufSkdw6s5v1/C
         Se7A==
X-Gm-Message-State: ACgBeo1QiP+1iMCHkgF+pLZ5udoRTajA+deTHXTPvhQtqhh8+46L3Owg
        65DT6JM4VjwiXoR8ev50U7JozmTV0CzwHLk+2DvJZMq+FuyA3XFDqaU5wGJWV3TNVSb2CvB6Z0r
        9Kf1HR2BWJ2pwFiPV/6fnFZTu
X-Received: by 2002:a05:6000:156b:b0:21d:9daf:3cdb with SMTP id 11-20020a056000156b00b0021d9daf3cdbmr9500849wrz.492.1659342093799;
        Mon, 01 Aug 2022 01:21:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7n7InSWLOF1ARNqkJ63A2m8/M5LaKV9UbPgaCenBCLJ3N4gb+2KCRwNDlehTMSqpFDshnOYA==
X-Received: by 2002:a05:6000:156b:b0:21d:9daf:3cdb with SMTP id 11-20020a056000156b00b0021d9daf3cdbmr9500834wrz.492.1659342093502;
        Mon, 01 Aug 2022 01:21:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6900:6d08:8df1:dd2c:bf00? (p200300cbc70469006d088df1dd2cbf00.dip0.t-ipconnect.de. [2003:cb:c704:6900:6d08:8df1:dd2c:bf00])
        by smtp.gmail.com with ESMTPSA id u1-20020adfdd41000000b0021d80f53324sm11101578wrm.7.2022.08.01.01.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 01:21:33 -0700 (PDT)
Message-ID: <f23b71e5-a5f5-bb39-dbec-3e85af344185@redhat.com>
Date:   Mon, 1 Aug 2022 10:21:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC 0/4] mm: Remember young bit for migration entries
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Huang Ying <ying.huang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20220729014041.21292-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220729014041.21292-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.07.22 03:40, Peter Xu wrote:
> [Marking as RFC; only x86 is supported for now, plan to add a few more
>  archs when there's a formal version]
> 
> Problem
> =======
> 
> When migrate a page, right now we always mark the migrated page as old.
> The reason could be that we don't really know whether the page is hot or
> cold, so we could have taken it a default negative assuming that's safer.
> 
> However that could lead to at least two problems:
> 
>   (1) We lost the real hot/cold information while we could have persisted.
>       That information shouldn't change even if the backing page is changed
>       after the migration,
> 
>   (2) There can be always extra overhead on the immediate next access to
>       any migrated page, because hardware MMU needs cycles to set the young
>       bit again (as long as the MMU supports).
> 
> Many of the recent upstream works showed that (2) is not something trivial
> and actually very measurable.  In my test case, reading 1G chunk of memory
> - jumping in page size intervals - could take 99ms just because of the
> extra setting on the young bit on a generic x86_64 system, comparing to 4ms
> if young set.
> 
> This issue is originally reported by Andrea Arcangeli.
> 
> Solution
> ========
> 
> To solve this problem, this patchset tries to remember the young bit in the
> migration entries and carry it over when recovering the ptes.
> 
> We have the chance to do so because in many systems the swap offset is not
> really fully used.  Migration entries use swp offset to store PFN only,
> while the PFN is normally not as large as swp offset and normally smaller.
> It means we do have some free bits in swp offset that we can use to store
> things like young, and that's how this series tried to approach this
> problem.
> 
> One tricky thing here is even though we're embedding the information into
> swap entry which seems to be a very generic data structure, the number of
> bits that are free is still arch dependent.  Not only because the size of
> swp_entry_t differs, but also due to the different layouts of swap ptes on
> different archs.
> 
> Here, this series requires specific arch to define an extra macro called
> __ARCH_SWP_OFFSET_BITS represents the size of swp offset.  With this
> information, the swap logic can know whether there's extra bits to use,
> then it'll remember the young bits when possible.  By default, it'll keep
> the old behavior of keeping all migrated pages cold.
> 


I played with a similar idea when working on pte_swp_exclusive() but
gave up, because it ended up looking too hacky. Looking at patch #2, I
get the same feeling again. Kind of hacky.


If we mostly only care about x86_64, and it's a performance improvement
after all, why not simply do it like
pte_swp_mkexclusive/pte_swp_exclusive/ ... and reuse a spare PTE bit?


-- 
Thanks,

David / dhildenb

