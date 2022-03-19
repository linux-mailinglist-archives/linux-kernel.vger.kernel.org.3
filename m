Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B21B4DE792
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 12:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242775AbiCSLSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 07:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242770AbiCSLSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 07:18:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C71F82C3DE1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 04:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647688642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h01om2OJNg7UN6xR5wRvwatJof/v6Qj0aJDQ8nw06cE=;
        b=EqQK3mjvMALifaDE4O5hPUmLxr5k7qOqzDeogrbUnf6ytlzB+PGAU9eyybDXrayzFZx4Fm
        O8hQbl8mtQhw4j/Mcmv5pGVYcARJtyrN/4DfDxKIRWVyU0Hynk9IZC1xkl+JyMgMefny/s
        AMPLgzBBAhMD0d0sy+6Dc46SpbeZSFY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-INtOALXlPh23BVZM7Ybv9A-1; Sat, 19 Mar 2022 07:17:20 -0400
X-MC-Unique: INtOALXlPh23BVZM7Ybv9A-1
Received: by mail-wm1-f72.google.com with SMTP id o21-20020a05600c511500b003818c4b98b5so4041368wms.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 04:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=h01om2OJNg7UN6xR5wRvwatJof/v6Qj0aJDQ8nw06cE=;
        b=nP8Aw+62K/psdIGTLM+SLs0fNHkzKn2agzuN2W2vD1EjMtcuObeflXd/3NYeCvBhfy
         JQzkesSOX81sR1Jq5AYqLUKP80BGH/UBYQ/xQYzxr0CEtqj5UTJoPxwhtMyZcizyM8TU
         F2ScVviTwogeJZ/W7g8BTfAsIhK7hjNWASVShDomIJEIZNlDrSdLUU4Mkq970mxeHtfI
         Eu9mEZebIewT9eH/XwtuWTn6/0gNkEPNXqptFiRMVwE2EXOGzvkvgGSqUihuCocozMTX
         TEujWSf+4LdGUtQ4d5xX7CZ4E8o0otd8F3Fw8E004kCfxd4f2gCIaIRsA6Sj+y1yx7D2
         ubnw==
X-Gm-Message-State: AOAM533RPinoqTk4cwuGiHkPp6K8/iluS1MQCjvKngsbQWtq3LlQqwvv
        sJVludUhEV0J0K7cqj0UcEI9WMs4fqPu2kcFsUKb7aoLX0NDVvkUPdIlMld3sWDMX3hKVaj0W4a
        4XkLmlE+4OOeP9D/pbkYZxxeY
X-Received: by 2002:a05:600c:3785:b0:38c:9b55:a477 with SMTP id o5-20020a05600c378500b0038c9b55a477mr214083wmr.164.1647688639514;
        Sat, 19 Mar 2022 04:17:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXQYHzmUknpl8dPLzijazZTS08+rGUI4YNRhcnL/au2TdAywuFEvKBekLN0RmMcXEBv9O0Qg==
X-Received: by 2002:a05:600c:3785:b0:38c:9b55:a477 with SMTP id o5-20020a05600c378500b0038c9b55a477mr214049wmr.164.1647688639186;
        Sat, 19 Mar 2022 04:17:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f24:9200:124e:f0bf:6f8c:cbd8? (p200300d82f249200124ef0bf6f8ccbd8.dip0.t-ipconnect.de. [2003:d8:2f24:9200:124e:f0bf:6f8c:cbd8])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c4f8f00b003842f011bc5sm12433837wmq.2.2022.03.19.04.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Mar 2022 04:17:18 -0700 (PDT)
Message-ID: <74fdfa8c-abaa-ea48-4b82-6f0023548ead@redhat.com>
Date:   Sat, 19 Mar 2022 12:17:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
References: <20220315141837.137118-1-david@redhat.com>
 <20220318234850.GD11336@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 0/7] mm: COW fixes part 3: reliable GUP R/W FOLL_GET of
 anonymous pages
In-Reply-To: <20220318234850.GD11336@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.03.22 00:48, Jason Gunthorpe wrote:
> On Tue, Mar 15, 2022 at 03:18:30PM +0100, David Hildenbrand wrote:
>> This is just the natural follow-up of part 2, that will also further
>> reduce "wrong COW" on the swapin path, for example, when we cannot remove
>> a page from the swapcache due to concurrent writeback, or if we have two
>> threads faulting on the same swapped-out page. Fixing O_DIRECT is just a
>> nice side-product :)

Hi Jason,

thanks or the review!

> 
> I know I would benefit alot from a description of the swap specific
> issue a bit more. Most of this message talks about clear_refs which I
> do understand a bit better.

Patch #1 contains some additional information. In general, it's the same
issue as with any other mechanism that could get the page mapped R/O
while there is a FOLL_GET | FOLL_WRITE reference to it --  for example,
DMA to that page as happens with our O_DIRECT reproducer.

Part 2 essentially fixed the other cases (i.e., clear_refs), but the
remaining swapout+refault from swapcache case is handled in this series.

> 
> Is this talking about what happens after a page gets swapped back in?
> eg the exclusive bit is missing when the page is recreated?

Right, try_to_unmap() was the last remaining case where we'd have lost
the exclusivity information -- it wasn't required for reliable GUP pins
in part 2.

Here is what happens without PG_anon_exclusive:

1. The application uses parts of an anonymous base page for direct I/O,
let's assume the first 512 bytes of page.

fd = open(filename, O_DIRECT| ...);
pread(fd, page, 512, 0);

O_DIRECT will take a FOLL_GET|FOLL_WRITE reference on the page

2. Reclaim kicks in and wants to swapout the page -- mm/vmscan.c

shrink_page_list() first adds the page to the swapcache and then unmaps
it via try_to_unmap().

After the page was successfully unmapped, pageout() will start
triggering writeback but will realize that there are additional
references on the page (via is_page_cache_freeable()) and fail.

3. The application uses unrelated parts of the page for other purposes
while the DMA is not completed, e.g., doing a a simple

page[4095]++;

The read access will fault in the page readable from the swap cache in
do_swap_page(). The write access will trigger our COW fault handler. As
we have an additional reference on the page, we will create a copy and
map it into out page table. At this point, the page table and the GUP
reference are out of sync.

4. O_DIRECT completes

The read targets the page that is no longer referenced in the page
tables. For the application, it looks like the read() never happened, as
we lost our DMA read to our page.


With PG_anon_exclusive from series part 2, we don't remember exclusivity
information in try_to_unmap() yet. do_swap_page() cannot restore it as
it has to assume the page is possibly shared.

With this series, we remember exclusivity information in try_to_unmap()
in the SWP PTE. do_swap_page() can restore it. Consequently, our COW
fault handler won't create a wrong copy and we won't go out of sync
between GUP and the page mapped into the page table.


Hope that helps!

-- 
Thanks,

David / dhildenb

