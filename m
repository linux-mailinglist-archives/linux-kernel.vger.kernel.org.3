Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769104FD681
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391371AbiDLJ3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241804AbiDLIkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:40:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0ECC2496D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649750768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kVXYFS3onY7D3CiQ2s6YTYii2qpFys84Xut+HVHR5k8=;
        b=Yd4OmFAHUn70PA0P0HPbs5jDanmUPwdEbCgwXY781vyxExkIo4CJQrY00UF6T+vj4Amr2b
        HpkXBUHoop3ua/DhbqS6nlp6YaaCY+QJHDTFp3h+88tMQxAS7viHVf7rBuarSCe/IL5KrP
        8+SkEPRPR+974VgjRwlRa7GcOnmoB6Q=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-2mUDefbYNVuNf32Uc168vw-1; Tue, 12 Apr 2022 04:06:07 -0400
X-MC-Unique: 2mUDefbYNVuNf32Uc168vw-1
Received: by mail-ed1-f70.google.com with SMTP id l24-20020a056402231800b00410f19a3103so10459938eda.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=kVXYFS3onY7D3CiQ2s6YTYii2qpFys84Xut+HVHR5k8=;
        b=sQUxZ6CDlp5LO6Oy9sZcOwWXoX/Y1BD09LAAe4LehcpbJ89rw3IkRAv2x3pGtDKckP
         6bxSzQSXoulm1BSey648ggvYbjJkHQ3AhkRtjoY6MCyCo5tI/FOeEwXwtMrJ+/kT1sKO
         +pA2LqPDznIkv5YtZiDUsXGGclFzwTCU2+uWrLpyQjtMNuNCmMl3jOVLpbnYfm5/HeNE
         a/dCvN1xM8uqhISc7qm/Ko5IZLdwwc9yL0ZrwTg2cd5acH9JUTC7kVNYsUq60ZCvYKWE
         7g8a8ttnVp9aif6d5MVsMU9dJsjMVND13ENYtRn1WWf+Y6cdbWTXvK4/9tH6Rj4NVbgo
         bueA==
X-Gm-Message-State: AOAM531HLWC2ozI3AiCrbzmg2VHu4STPUt5i8FkmOrtNXv3KV+d08Y9Q
        7Q2fxStgBqBap9ut3HT4W+UmdbVczn1Wg7Fsa1x5Mn9dQJY83Ebhbeo/MYSV7kDzfOXjD1TTYif
        jTfOPTRjcY215C7lOdcbQ9eux
X-Received: by 2002:a17:906:730c:b0:6e6:c512:49c8 with SMTP id di12-20020a170906730c00b006e6c51249c8mr33701477ejc.405.1649750766459;
        Tue, 12 Apr 2022 01:06:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxo4u4ew37f1UDJH2s9fF8MD/mnigSDDhKICnyE8nZmBItPQ2UIjbR6/EP8inuN+owHYdapXw==
X-Received: by 2002:a17:906:730c:b0:6e6:c512:49c8 with SMTP id di12-20020a170906730c00b006e6c51249c8mr33701441ejc.405.1649750766226;
        Tue, 12 Apr 2022 01:06:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:1800:7c14:16cc:5291:a9f3? (p200300cbc70718007c1416cc5291a9f3.dip0.t-ipconnect.de. [2003:cb:c707:1800:7c14:16cc:5291:a9f3])
        by smtp.gmail.com with ESMTPSA id bj13-20020a170906b04d00b006e742719b9fsm10946061ejb.7.2022.04.12.01.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 01:06:05 -0700 (PDT)
Message-ID: <7d9353f5-2aa4-1e70-deb2-2ff3d2afb396@redhat.com>
Date:   Tue, 12 Apr 2022 10:06:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 04/16] mm/rmap: split page_dup_rmap() into
 page_dup_file_rmap() and page_try_dup_anon_rmap()
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>, Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
References: <20220329160440.193848-1-david@redhat.com>
 <20220329160440.193848-5-david@redhat.com>
 <bec1b401-fb2e-6672-d904-396402434890@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <bec1b401-fb2e-6672-d904-396402434890@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.04.22 20:18, Vlastimil Babka wrote:
> On 3/29/22 18:04, David Hildenbrand wrote:
>> ... and move the special check for pinned pages into
>> page_try_dup_anon_rmap() to prepare for tracking exclusive anonymous
>> pages via a new pageflag, clearing it only after making sure that there
>> are no GUP pins on the anonymous page.
>>
>> We really only care about pins on anonymous pages, because they are
>> prone to getting replaced in the COW handler once mapped R/O. For !anon
>> pages in cow-mappings (!VM_SHARED && VM_MAYWRITE) we shouldn't really
>> care about that, at least not that I could come up with an example.
>>
>> Let's drop the is_cow_mapping() check from page_needs_cow_for_dma(), as we
>> know we're dealing with anonymous pages. Also, drop the handling of
>> pinned pages from copy_huge_pud() and add a comment if ever supporting
>> anonymous pages on the PUD level.
>>
>> This is a preparation for tracking exclusivity of anonymous pages in
>> the rmap code, and disallowing marking a page shared (-> failing to
>> duplicate) if there are GUP pins on a page.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Nit:
> 
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -825,7 +825,8 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>>  		 */
>>  		get_page(page);
>>  		rss[mm_counter(page)]++;
>> -		page_dup_rmap(page, false);
>> +		/* Cannot fail as these pages cannot get pinned. */
>> +		BUG_ON(page_try_dup_anon_rmap(page, false, src_vma));
> 
> Should we just call __page_dup_rmap() here? This is block for the condition
> is_device_private_entry(), and page_try_dup_anon_rmap() can't return -EBUSY
> for is_device_private_page().


Hi Vlastimil,

thanks for your review!

We want to keep page_try_dup_anon_rmap() here, because we extend
page_try_dup_anon_rmap() in patch #12 to properly clear
PageAnonExclusive() of there are no GUP pins. Just like with current
page_try_dup_anon_rmap(), that can't fail for device private pages.

-- 
Thanks,

David / dhildenb

