Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0A24C40D9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238843AbiBYJCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238777AbiBYJCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:02:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25B5B35878
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 01:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645779717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1WIKnGoWFyTndm5TrLW00J+i5t/iVoIUx93nUmuDOHc=;
        b=eo2G9Kz42/CA6kur0toCrFGu2eXX8qRkGpirFcekZgfkpFrS/gH8301pNQ2FzKTVqIm0X9
        8PzPv/sxE+Qp37k12fdvi5ZkNytJakEfgYikQh52+aMxvqtsStv/ewn3/l3/YhtkFlMZuv
        bqKsyo8fI5Dyg/T+VQtqZ2WHgfGFCuQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-6qRBCciCNjijU_pkSSoetg-1; Fri, 25 Feb 2022 04:01:56 -0500
X-MC-Unique: 6qRBCciCNjijU_pkSSoetg-1
Received: by mail-wm1-f71.google.com with SMTP id az39-20020a05600c602700b00380e48f5994so1064859wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 01:01:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=1WIKnGoWFyTndm5TrLW00J+i5t/iVoIUx93nUmuDOHc=;
        b=pFDTpweXRyfq/56bUpJOkvlVGae38cdZOf+hOHouUI+scNOFUZSkZI6POvvZG9SyOa
         ER6TtLAHN/LJWpgdWTYJ8Cg0Xpn7MfJg8O57BpqHZ49LvJa9KQ09mu0MsKGaqXTERv4Z
         iPFTCbSIDkdggpQIcA/PimHHjGU/7GUElQ7axfgq6Z/vYQsci6q1rm708SXG+RJEg7sz
         CHEWY++QCVkwrtObTaZmEpAi72t5dZ0vslV0TJEIn+aDWtqYiYGe3IefCjU5ia83vmtO
         E2cC0cBf7mijkmRcZSV2xZUhYbgrfu77GquRED3QRh3vQGTAhUKCkxU/B7Hgx7hvbNVj
         PtAQ==
X-Gm-Message-State: AOAM530hzBU/lxzruNGaAq6t7syIExTP/PEKrciq7UvJZPOwvl5hPa9W
        p0S6xbWEjrqTL52NeEdoZJd6sm9DDLVxPgor5Gk68Haw10wUewrV0ye8eNNS993XSM9m+whMXki
        SUV7sHqeKpXa4JLcDqrZ0OeA7
X-Received: by 2002:a05:600c:48a:b0:380:3f3a:e08e with SMTP id d10-20020a05600c048a00b003803f3ae08emr1769645wme.1.1645779714883;
        Fri, 25 Feb 2022 01:01:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDy1KgcWpVNdM33QEotT9nlakyx3ll+DkMH6nzYwAtc/XVtP6ENwJ5ePrhSbMpW4nc7Aoc8g==
X-Received: by 2002:a05:600c:48a:b0:380:3f3a:e08e with SMTP id d10-20020a05600c048a00b003803f3ae08emr1769625wme.1.1645779714630;
        Fri, 25 Feb 2022 01:01:54 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:1900:f2f7:d2ad:80d9:218f? (p200300cbc7061900f2f7d2ad80d9218f.dip0.t-ipconnect.de. [2003:cb:c706:1900:f2f7:d2ad:80d9:218f])
        by smtp.gmail.com with ESMTPSA id v25-20020a05600c215900b0038117f41728sm3695546wml.43.2022.02.25.01.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 01:01:54 -0800 (PST)
Message-ID: <c5bc48ba-1c43-12da-0a22-fd8834efe341@redhat.com>
Date:   Fri, 25 Feb 2022 10:01:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH RFC 05/13] mm/rmap: remove do_page_add_anon_rmap()
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
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
        Linux-MM <linux-mm@kvack.org>
References: <20220224122614.94921-1-david@redhat.com>
 <20220224122614.94921-6-david@redhat.com>
 <CAHk-=wh+NxEVxeKc_o1xyVsJAQNqpN1zyCHN96gPEK+DzXaeLw@mail.gmail.com>
 <064ba776-e6c6-a430-7d74-0b691123e2a9@redhat.com>
 <CAHk-=whkO8w6YFbn8YsvwxgDi_pyUeKTCEgncDAzV6_kcqRJMw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHk-=whkO8w6YFbn8YsvwxgDi_pyUeKTCEgncDAzV6_kcqRJMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.02.22 18:48, Linus Torvalds wrote:
> On Thu, Feb 24, 2022 at 9:41 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> Actually, I thought about doing it similarly to what I did in
>> page_alloc.c with fpi_t:
>>
>> typedef int __bitwise fpi_t;
>>
>> #define FPI_NONE                ((__force fpi_t)0)
>>
>> I can do something similar here.
> 
> Yeah, that looks good. And then the relevant function declarations and
> definitions also have that explicit type there instead of 'int', which
> adds a bit more documentation for people grepping for use.
> 

While at it already, I'll also add a patch to drop the "bool compound" parameter
from page_add_new_anon_rmap()

(description only)

Author: David Hildenbrand <david@redhat.com>
Date:   Fri Feb 25 09:38:11 2022 +0100

    mm/rmap: drop "compound" parameter from page_add_new_anon_rmap()
    
    New anonymous pages are always mapped natively: only THP/khugepagd code
    maps a new compound anonymous page and passes "true". Otherwise, we're
    just dealing with simple, non-compound pages.
    
    Let's give the interface clearer semantics and document these.
    
    Signed-off-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

