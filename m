Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E97A5072C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354522AbiDSQT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354551AbiDSQTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:19:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99FB03A5F8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650385000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=feagHcqxbeiZZqCkc7XRmApRsAl3Hwsk1QnHwbNmE9Q=;
        b=ZoEt0vZdj04l9rcRdyo4Y/ohfWtNlU/qvot66ojnanzlLLjdn2R39c/6wXldNLt0XfF4UF
        kkN0dA3fUX+UE/jg08W7HPQM7Cp1H4SYLlbpJRgfsA/OOW0TOi9cMr4tmVFfD9FaZh+n2o
        5gDy1LLyCrnClvxxbF5kEIBE4iw3OkM=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-vTekoS4bMUqzdXCHgeqD9w-1; Tue, 19 Apr 2022 12:16:39 -0400
X-MC-Unique: vTekoS4bMUqzdXCHgeqD9w-1
Received: by mail-io1-f71.google.com with SMTP id y10-20020a056602164a00b00653f388e244so6654908iow.22
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=feagHcqxbeiZZqCkc7XRmApRsAl3Hwsk1QnHwbNmE9Q=;
        b=orQxl7yo19nlBPbTrlFUCXmzoo5JOsEEMOeS1ElhWRG9rmR5+zK/se34r+H39TpuJN
         J2/Sdc9yvvoePW2k37AxwusFsp1FqYv+tpUx51oDJTV7o0HwzpcO+7TPLw7EbIF08VS8
         WbsF2RhP0rmWs0jfoBZbJOJBxHGyStcqueK8qn15Nvv1BtzyAjVXdkW/ANbCL3jI+ysq
         qfjhV1VUG+JAjhK8XQ5K02OjE+sJtdyFuC0Zt6zn3JruGzeNc6SYi4IjPnSg4OCjQn+p
         Yx6Y1W1Jld7ZI+sepn1etUUTATfGgP6WCTPPZBpbnnVPTDNmr42M4a/0EmsGbD4CzZqo
         eAjA==
X-Gm-Message-State: AOAM530/7pz7W9wvwsrB0TNFfbmu+gS1LMXanatE3XK4deIpgU36mZoZ
        V85HcuMvbYmw4XlE8mvFeeQU6Q8iWipxcJ6rMHBtwhxkK0wquc8KCEUtQ8nAnRo3OEu8vqlobmx
        LLPeQOmB+pm8zonQwmlPxbCYw
X-Received: by 2002:a05:6e02:1d85:b0:2cb:fa5e:73fa with SMTP id h5-20020a056e021d8500b002cbfa5e73famr7182100ila.294.1650384998619;
        Tue, 19 Apr 2022 09:16:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhHvQQOCwK/bC1iSAYmZ/USMc21YsvbIyJomXHZ6/51e2BqTSDdxCO939mrDl7PDkCurFtYQ==
X-Received: by 2002:a05:6e02:1d85:b0:2cb:fa5e:73fa with SMTP id h5-20020a056e021d8500b002cbfa5e73famr7182085ila.294.1650384998180;
        Tue, 19 Apr 2022 09:16:38 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id a1-20020a923301000000b002cae7560bfesm9092389ilf.62.2022.04.19.09.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:16:37 -0700 (PDT)
Date:   Tue, 19 Apr 2022 12:16:35 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Alistair Popple <apopple@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, surenb@google.com, minchan@kernel.org,
        sfr@canb.auug.org.au, rcampbell@nvidia.com,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/swapfile: unuse_pte can map random data if swap
 read fails
Message-ID: <Yl7gY6G8/To1yHOe@xz-m1.local>
References: <20220416030549.60559-1-linmiaohe@huawei.com>
 <87tuapk9n7.fsf@nvdebian.thelocal>
 <5a78dd68-343d-ac57-a698-2cfead8ee366@huawei.com>
 <72cfde7a-61d7-980c-4653-94ae83eb4257@redhat.com>
 <87pmldjxiq.fsf@nvdebian.thelocal>
 <21003e7a-01e4-c751-dd41-fce4149d424c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21003e7a-01e4-c751-dd41-fce4149d424c@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 01:14:29PM +0200, David Hildenbrand wrote:
> On 19.04.22 10:08, Alistair Popple wrote:
> > David Hildenbrand <david@redhat.com> writes:
> > 
> >> On 19.04.22 09:29, Miaohe Lin wrote:
> >>> On 2022/4/19 11:51, Alistair Popple wrote:
> >>>> Miaohe Lin <linmiaohe@huawei.com> writes:
> >>>>
> >>>>> There is a bug in unuse_pte(): when swap page happens to be unreadable,
> >>>>> page filled with random data is mapped into user address space. In case
> >>>>> of error, a special swap entry indicating swap read fails is set to the
> >>>>> page table. So the swapcache page can be freed and the user won't end up
> >>>>> with a permanently mounted swap because a sector is bad. And if the page
> >>>>> is accessed later, the user process will be killed so that corrupted data
> >>>>> is never consumed. On the other hand, if the page is never accessed, the
> >>>>> user won't even notice it.
> >>>>
> >>>> Hi Miaohe,
> >>>>> It seems we're not actually using the pfn that gets stored in the special swap
> >>>> entry here. Is my understanding correct? If so I think it would be better to use
> >>>
> >>> Yes, you're right. The pfn is not used now. What we need here is a special swap entry
> >>> to do the right things. I think we can change to store some debugging information instead
> >>> of pfn if needed in the future.
> >>>
> >>>> the new PTE markers Peter introduced[1] rather than adding another swap entry
> >>>> type.
> >>>
> >>> IIUC, we should not reuse that swap entry here. From definition:
> >>>
> >>> PTE markers
> >>> `========='
> >>> ...
> >>> PTE marker is a new type of swap entry that is ony applicable to file
> >>> backed memories like shmem and hugetlbfs.  It's used to persist some
> >>> pte-level information even if the original present ptes in pgtable are
> >>> zapped.
> >>>
> >>> It's designed for file backed memories while swapin error entry is for anonymous
> >>> memories. And there has some differences in processing. So it's not a good idea
> >>> to reuse pte markers. Or am I miss something?
> >>
> >> I tend to agree. As raised in my other reply, maybe we can simply reuse
> >> hwpoison entries and update the documentation of them accordingly.
> > 
> > Unless I've missed something I don't think PTE markers should be restricted
> > solely to file backed memory. It's true that the only user of them at the moment
> > is UFFD-WP for file backed memory, but PTE markers are just a special swap entry
> > same as what is added here.
> 
> There is a difference.
> 
> What we want here is "there used to be something mapped but it's not
> readable anymore. Please fail hard when userspace tries accessing
> this.". Just like with hwpoison entries.
> 
> What a pte marker expresses is that "here is nothing mapped right now
> but we have additional metadata available here. For file-backed memory,
> it translates to: If we ever touch this page, lookup the pagecache what
> to map here."
> 
> In the anonymous memory world, this would map to "populate the zeropage
> or a fresh anonymous page on access." and keep the metadata around.

So far it's defined like that, but it does not necessarily need to.  IMHO
PTE marker could work here for the anonymous use case as Alistair stated.
Say, it's fairly simple to not go into anonymous page handling at all if we
see this pte marker with the new bit set.  It's indeed just tailored for
such use case where we don't need to store special data like pfn.

Hwpoison entry looks good to me too, but as discussed we may need to
reserve pfn=0 or -1 or anything we're sure an invalid value, and then we'll
also need to cover the rest hwpoison related code (carefully, as rightfully
pointed out by Miaohe on the difference of VM_FAULT_* fields being
returned) to not faultly treat the "swp device read error" with general
MCEs.

From that POV it seems pte markers would be slightly cleaner, we'll need to
touch up existing pte markers code path to start accept anonymous vmas,
though.  No strong opinion on this.

Btw, is there an error dumped into dmesg when the read error happens (e.g.,
would block IO path trigger some warning already)?  I'm wondering whether
we should report it to the user somehow so that the user should know even
earlier than when the bad page is accessed, then the user could potentially
do something useful.

-- 
Peter Xu

