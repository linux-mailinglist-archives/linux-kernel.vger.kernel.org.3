Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8919A4CB003
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243312AbiCBUjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242725AbiCBUi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:38:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26E321FA6C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646253494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nMsfn4Rs0wG7spUhGbyLnPRwbrnVAsF3QEAbPCpAwa0=;
        b=N/0AO/A+zAjeM1EVWvjs+Z0nFpDP/EsK4AawLZChMTeWojNQfx1Of5RirQIfMniFg8ghd6
        k8YvbEkXc/rfLgndxoKs1tzEg8uR2ZnaXAqh2m9KMJ42B1OVqeWXrJBf0uuKqwfFndFsu8
        GPiAFqTQN0sFBovm1fWXiQ0uBh5ZgKs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-Nue3MOgTPJioLVc9RK0ALw-1; Wed, 02 Mar 2022 15:38:13 -0500
X-MC-Unique: Nue3MOgTPJioLVc9RK0ALw-1
Received: by mail-wr1-f72.google.com with SMTP id p9-20020adf9589000000b001e333885ac1so1050385wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:38:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=nMsfn4Rs0wG7spUhGbyLnPRwbrnVAsF3QEAbPCpAwa0=;
        b=Nj647pMa8m8WQjgh9aOSn79Ie2KNZg5biBxB7Tt3OHqDp4oDSggEVJvVXgQEvHend4
         eF4AFr/Uc2Y57cjrGc99f6WOGt/Wz8oeRlqlkbR39fxBAuGVQDSrfFIryPbT1iaWbK4q
         ZRRpI+6cbfInDK+TpaTK8kMBA6NGJBzspyWDJmZBW6oJYImJX9V28G2NAqBDoxSNUcQh
         FUBcyt2CPhmKojkXIyXI+mlL9jd9/bM3O1rYAj/Pgjn3PzNjU1peQtoBgO5FJMKg07oB
         bu/gzXdWhzg78w29cDVQcwDUjyQ9ejj51DlPb4SNWzg83ZU1nzRmwm4hgbjj3f5+fuuF
         K6cA==
X-Gm-Message-State: AOAM531dMUWJWcBSmENzEH1B4vjdZwnnr6D95q6Kr0JKs3sP49nx+iey
        XLVx6R9PjcodrpsRsNvC6J6rM7W9OTLnhDxL1rYpjrEKsvbTuBBhNvrHWj6LXAE4msDvItHSeP5
        W2OaDL/5wgMNqiKqUqDqzs5cA
X-Received: by 2002:a05:6000:2c9:b0:1f0:49aa:d347 with SMTP id o9-20020a05600002c900b001f049aad347mr1084981wry.453.1646253492115;
        Wed, 02 Mar 2022 12:38:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9nsVwmkEM6/m/0SMuz52ZfnM1DW3UGN+YBkJuzcILW720TEYWY5MncvxoFHCV5hIHl1XqBA==
X-Received: by 2002:a05:6000:2c9:b0:1f0:49aa:d347 with SMTP id o9-20020a05600002c900b001f049aad347mr1084964wry.453.1646253491815;
        Wed, 02 Mar 2022 12:38:11 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:be00:9509:b3b1:97e2:ef4c? (p200300cbc709be009509b3b197e2ef4c.dip0.t-ipconnect.de. [2003:cb:c709:be00:9509:b3b1:97e2:ef4c])
        by smtp.gmail.com with ESMTPSA id p190-20020a1c29c7000000b00381227166b2sm68644wmp.41.2022.03.02.12.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 12:38:11 -0800 (PST)
Message-ID: <fb895ba3-9d7e-7421-d5c6-f5e7a2d1231a@redhat.com>
Date:   Wed, 2 Mar 2022 21:38:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
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
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
References: <20220224122614.94921-1-david@redhat.com>
 <20220224122614.94921-13-david@redhat.com>
 <20220302165559.GU219866@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC 12/13] mm/gup: trigger FAULT_FLAG_UNSHARE when
 R/O-pinning a possibly shared anonymous page
In-Reply-To: <20220302165559.GU219866@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.03.22 17:55, Jason Gunthorpe wrote:
> On Thu, Feb 24, 2022 at 01:26:13PM +0100, David Hildenbrand wrote:
>> Whenever GUP currently ends up taking a R/O pin on an anonymous page that
>> might be shared -- mapped R/O and !PageAnonExclusive() -- any write fault
>> on the page table entry will end up replacing the mapped anonymous page
>> due to COW, resulting in the GUP pin no longer being consistent with the
>> page actually mapped into the page table.
>>
>> The possible ways to deal with this situation are:
>>  (1) Ignore and pin -- what we do right now.
>>  (2) Fail to pin -- which would be rather surprising to callers and
>>      could break user space.
>>  (3) Trigger unsharing and pin the now exclusive page -- reliable R/O
>>      pins.
> 

Hi Jason,

> How does this mesh with the common FOLL_FORCE|FOLL_WRITE|FOLL_PIN
> pattern used for requesting read access? Can they be converted to
> just FOLL_WRITE|FOLL_PIN after this?

Interesting question, I thought about this in detail yet, let me give it
a try:


IIRC, the sole purpose of FOLL_FORCE in the context of R/O pins is to
enforce the eventual COW -- meaning we COW (via FOLL_WRITE) even if we
don't have the permissions to write (via FOLL_FORCE), to make sure we
most certainly have an exclusive anonymoous page in a MAP_PRIVATE mapping.

Dropping only the FOLL_FORCE would make the FOLL_WRITE request fail if
the mapping is currently !VM_WRITE (but is VM_MAYWRITE), so that
wouldn't work.

I recall that we don't allow pinning the zero page ("special pte",
!vm_normal_page()). So if you have an ordinary MAP_PRIVATE|MAP_ANON
mapping, you will now only need a "FOLL_READ" and have a reliable pin,
even if not previously writing to every page.


It would we different with other MAP_PRIVATE file mappings I remember:

With FOLL_FORCE|FOLL_WRITE|FOLL_PIN we'd force placement of an anonymous
page, resulting in the R/O (long-term ?) pin not observing consecutive
file changes. With a pure FOLL_READ we'd still observe file changes as
we don't trigger a write fault.

BUT, once we actually write to the private mapping via the page table,
the GUP pin would go out of sync with the now-anonymous page mapped into
the page table. However, I'm having a hard time answering what's
actually expected?

It's really hard to tell what the user wants with MAP_PRIVATE file
mappings and stumbles over a !anon page (no modifications so far):

(a) I want a R/O pin to observe file modifications.
(b) I want the R/O pin to *not* observe file modifications but observe
    my (eventual? if any) private modifications,

Of course, if we already wrote to that page and now have an anon page,
it's easy: we are already no longer following file changes.

Maybe FOLL_PIN would already do now what we'd expect from a R/O pin --
(a), maybe not. I'm wondering if FOLL_LONGTERM could give us an
indication whether (a) or (b) applies.

-- 
Thanks,

David / dhildenb

