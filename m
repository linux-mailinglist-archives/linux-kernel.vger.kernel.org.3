Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBC44FF6D2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbiDMMbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiDMMbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:31:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25B1E5DA67
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649852923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qsU6DS5U2wkJ+v5NrpLhGhWiJHM31d3LlhPBq0tETIc=;
        b=WI8MS9lbFyuD4ykqzV028RJ+Fo5boIGtxxsLP7p2kwtT6Akzf/JKiAMyGSsKOa84QcJSv8
        FmcQfuLpm/RW/JCsWIYpluqZcFJEshn48kwczev54YKa6yLnBpCm8dRsH7of+l4pG30mMc
        CBkVSFcVrv15ej9VrZSay7npj+EhQOM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-mSqJtagSMWmjI1bSTQgMow-1; Wed, 13 Apr 2022 08:28:42 -0400
X-MC-Unique: mSqJtagSMWmjI1bSTQgMow-1
Received: by mail-wr1-f72.google.com with SMTP id s13-20020adfa28d000000b00205e049cff2so326607wra.17
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=qsU6DS5U2wkJ+v5NrpLhGhWiJHM31d3LlhPBq0tETIc=;
        b=ocJXYEgvqpICcZVcURPqFj3bUpHp0gDuuJwzbHoodWEaHVHvsEC0bAZlnZdaoe+6Gj
         oH/hWyVT65Y0/LzavF/MosC8LQbSPGIvZnQhUdzvF53kPcftmvCN0OnUkCeI0GCSURMu
         JwF8tBzo6WB3NsGD/CBBuGEbQvshaM2jIG3sE2zFkC4CkeCPOhAlddSuyIREiK9vs7JG
         NS8DzW9f1NSm3PlhEtkJvBMdEzrf2lVrBuCb8QuGAWru/SvosPkKJgO+D0GYUWjTQW0X
         0Z4rSiMxsOGeDvmfWpINcUPCXJGoRxmi2hT7nkwkKMms1atieW2mBYZ0Hbvpn7svFoNU
         a+sQ==
X-Gm-Message-State: AOAM530wabDsS3NYPENjpgkdE+heBCra/aWpyKq4b3sDJShG0AZUkfto
        yYqF2TMef8wia4c3JyeKXrOZRxgRxb3jSfRf6YrJ9v2Q4DB38bGQPT6FIjRSys0pJ+G/yNYHs91
        mLNoRemSZ1JoMRfrI46xbXLuC
X-Received: by 2002:adf:e74a:0:b0:1f0:25cb:3ad5 with SMTP id c10-20020adfe74a000000b001f025cb3ad5mr32825365wrn.231.1649852920940;
        Wed, 13 Apr 2022 05:28:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBPuGiBkWKAv4X+Gv+AZ8tuTHo5epBTh7Wu31/gbzLstA9OS8Bqszv+EEp4CdiHPVziWNY7g==
X-Received: by 2002:adf:e74a:0:b0:1f0:25cb:3ad5 with SMTP id c10-20020adfe74a000000b001f025cb3ad5mr32825329wrn.231.1649852920699;
        Wed, 13 Apr 2022 05:28:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5800:1078:ebb9:e2c3:ea8c? (p200300cbc70458001078ebb9e2c3ea8c.dip0.t-ipconnect.de. [2003:cb:c704:5800:1078:ebb9:e2c3:ea8c])
        by smtp.gmail.com with ESMTPSA id r12-20020a5d6c6c000000b00203ec2b1255sm39631983wrz.60.2022.04.13.05.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 05:28:40 -0700 (PDT)
Message-ID: <0c9d2c39-5080-a855-8ecd-e2c1bd1179fa@redhat.com>
Date:   Wed, 13 Apr 2022 14:28:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 08/16] mm/rmap: drop "compound" parameter from
 page_add_new_anon_rmap()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
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
 <20220329160440.193848-9-david@redhat.com>
 <4cb92b41-95e1-1666-321e-96ff9e6095bb@suse.cz>
 <368902ab-8d3f-5d62-581e-1ff930bcefa0@redhat.com>
 <YlbBXiVezzVw+NZZ@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YlbBXiVezzVw+NZZ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.22 14:26, Matthew Wilcox wrote:
> On Tue, Apr 12, 2022 at 11:37:09AM +0200, David Hildenbrand wrote:
>> On 12.04.22 10:47, Vlastimil Babka wrote:
>>> There's a VM_BUG_ON_PAGE(PageTransCompound(page), page); later in a
>>> !compound branch. Since compound is now determined by the same check, could
>>> be deleted.
>>
>> Yes, eventually we could get rid of both VM_BUG_ON_PAGE() on both
>> branches and add a single VM_BUG_ON_PAGE(PageTail(page), page) check on
>> the compound branch. (we could also make sure that we're not given a
>> hugetlb page)
> 
> As a rule of thumb, if you find yourself wanting to add
> VM_BUG_ON_PAGE(PageTail(page), page), you probably want to change the
> interface to take a folio.

Yeah, I had the same in mind. Might be a reasonable addon on top --
although it would stick out in the rmap code a bit because most
functions deal with both, folios and subpages.

-- 
Thanks,

David / dhildenb

