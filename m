Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D91B4CF37F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbiCGI0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiCGIZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:25:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8E3360AB8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 00:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646641503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jp8xbJXc3F2xf0wOHHnbLnk2PeJF6d1Q4COXVNu7Rm8=;
        b=iySDEOo/sb5je6ezmF3kn0G2YQSfBrQhvgneomKkUzwiljPrAcGlUKZ/TPmqQvREphHpbj
        YhhueFsZoJb2UnXZHZzD4dcEhgqpkT34956ZnM161ltF0MmWVR8Whb7fJI+lee4L/KYUR3
        +qI+++5A14Nj9QgpJOdyYI58Q6GVHUw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-TKTZ08G4Pqm-R9JGCIbR8A-1; Mon, 07 Mar 2022 03:25:01 -0500
X-MC-Unique: TKTZ08G4Pqm-R9JGCIbR8A-1
Received: by mail-wr1-f69.google.com with SMTP id n4-20020a5d4844000000b001f1ed76e943so338731wrs.22
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 00:25:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=Jp8xbJXc3F2xf0wOHHnbLnk2PeJF6d1Q4COXVNu7Rm8=;
        b=Xko/59ImEeDc+AN90Yk9BO4EzLnf2wDG8V/ngdKai74yH3Fsj0fyJzY7ApiIau4i9L
         yYAq/p/4mruxhdB5Pmu3cirH6oor/J4cfYypWjsCytKlF2SOoID+GgRRMCo6NFUi5fii
         UfLLlc2n4ikdAT2olNZgSmAmUYl6rV+vSKZeHnTyczVBSnP4t66/CA2dtcwMQc041C8O
         IYOPXZtYro8p+W0b2TwvqpBfUEovczdq7wvD7lSnogVRcyqZe5cDcnReFzn7IIb8pyWM
         erpzMJCYEv5gCyd/Evkqcw/YBg1pPH/yqaBBsPyG7xokR7KE4WOldzaNikDcQQY+wGcr
         tU+g==
X-Gm-Message-State: AOAM5304yfZzdqU/XAObb03A7Gc3KO/P44sKELZIwJaXBQ06W69AEuyY
        GnZmeMpoMTgX/H9WvEs4tk521weTfZFIIdJ/NdKG3X8jIjHw/tSX5fkB5YUNtBynxuseaTPmiMJ
        QlRH4tzj//F2KXu4j+dTrRqCX
X-Received: by 2002:a5d:4992:0:b0:1f0:68bd:4c34 with SMTP id r18-20020a5d4992000000b001f068bd4c34mr7633604wrq.670.1646641500044;
        Mon, 07 Mar 2022 00:25:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXMKXq8Pic3/bEs4X9zXY/UJ/munTO9d4a7KdGL1+a0vKhRumDwQZuZusyk2ldq7j4udF4mA==
X-Received: by 2002:a5d:4992:0:b0:1f0:68bd:4c34 with SMTP id r18-20020a5d4992000000b001f068bd4c34mr7633589wrq.670.1646641499742;
        Mon, 07 Mar 2022 00:24:59 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:1e00:8d67:f75a:a8ae:dc02? (p200300cbc7051e008d67f75aa8aedc02.dip0.t-ipconnect.de. [2003:cb:c705:1e00:8d67:f75a:a8ae:dc02])
        by smtp.gmail.com with ESMTPSA id f186-20020a1c38c3000000b00382a9b91515sm16784987wma.37.2022.03.07.00.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 00:24:59 -0800 (PST)
Message-ID: <84a6c9c1-d18f-6955-2666-0a2d7bce6094@redhat.com>
Date:   Mon, 7 Mar 2022 09:24:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20220303222014.517033-1-shy828301@gmail.com>
 <CADFyXm6W9CVkO4XPYep-tHg55c8m8NES783kcVYrdjSMbzYoDA@mail.gmail.com>
 <CAHbLzkriyBy2HqjssurLSnhoyuUzpJRZjMPNx34MTgxeO0dddg@mail.gmail.com>
 <13ad4ba1-2a88-9459-3995-70af36aba33e@redhat.com>
 <20220306180718.6d4e6233130b94fdad98df88@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: thp: don't have to lock page anymore when splitting
 PMD
In-Reply-To: <20220306180718.6d4e6233130b94fdad98df88@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.22 03:07, Andrew Morton wrote:
> On Fri, 4 Mar 2022 19:50:08 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
>> @Andrew, the last mail I received was
>>
>> + mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd.patch
>> added to -mm tree
>>
>> The patch shows up in mmotm as
>>
>> #[merged]mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd.patch
>>
>> ... which shouldn't be true.
> 
> I guess I mislabelled the reason for dropping it.  Should have been to-be-updated, 
> due to https://lkml.kernel.org/r/CAHbLzkpbnQyHRckoRtbZoaLvANu92MY4kEsbKudaQ8MDUA3nVg@mail.gmail.com
> 

Let me clarify.

1. I sent [1] (9 patches)

2. You queued the 9 patches

E.g., in "mmotm 2022-02-15-20-22 uploaded"

* mm-optimize-do_wp_page-for-exclusive-pages-in-the-swapcache.patch
* mm-optimize-do_wp_page-for-fresh-pages-in-local-lru-pagevecs.patch
* mm-slightly-clarify-ksm-logic-in-do_swap_page.patch
* mm-streamline-cow-logic-in-do_swap_page.patch
* mm-huge_memory-streamline-cow-logic-in-do_huge_pmd_wp_page.patch
* mm-khugepaged-remove-reuse_swap_page-usage.patch
* mm-swapfile-remove-stale-reuse_swap_page.patch
* mm-huge_memory-remove-stale-page_trans_huge_mapcount.patch
* mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd.patch

3. The last patch in the series was dropped. What remains are 8 patches.

E.g., in "mmotm 2022-02-24-22-38 uploaded"

* mm-optimize-do_wp_page-for-exclusive-pages-in-the-swapcache.patch
* mm-optimize-do_wp_page-for-fresh-pages-in-local-lru-pagevecs.patch
* mm-slightly-clarify-ksm-logic-in-do_swap_page.patch
* mm-streamline-cow-logic-in-do_swap_page.patch
* mm-huge_memory-streamline-cow-logic-in-do_huge_pmd_wp_page.patch
* mm-khugepaged-remove-reuse_swap_page-usage.patch
* mm-swapfile-remove-stale-reuse_swap_page.patch
* mm-huge_memory-remove-stale-page_trans_huge_mapcount.patch

4. Yang Shi sent his patch (the one we're replying to)

5. You picked his patch and dropped it again due to [2]


I'm wondering why 3 happened and why
https://www.ozlabs.org/~akpm/mmotm/series contains:


mm-optimize-do_wp_page-for-exclusive-pages-in-the-swapcache.patch
mm-optimize-do_wp_page-for-fresh-pages-in-local-lru-pagevecs.patch
mm-slightly-clarify-ksm-logic-in-do_swap_page.patch
mm-streamline-cow-logic-in-do_swap_page.patch
mm-huge_memory-streamline-cow-logic-in-do_huge_pmd_wp_page.patch
mm-khugepaged-remove-reuse_swap_page-usage.patch
mm-swapfile-remove-stale-reuse_swap_page.patch
mm-huge_memory-remove-stale-page_trans_huge_mapcount.patch
...
#[merged]mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd.patch


[1]
https://lore.kernel.org/linux-mm/20220131162940.210846-1-david@redhat.com/

[2]
https://lkml.kernel.org/r/CAHbLzkpbnQyHRckoRtbZoaLvANu92MY4kEsbKudaQ8MDUA3nVg@mail.gmail.com

-- 
Thanks,

David / dhildenb

