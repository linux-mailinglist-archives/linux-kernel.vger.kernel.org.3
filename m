Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B000B515425
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 20:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380175AbiD2S7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 14:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380172AbiD2S71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 14:59:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE41F89CEE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651258567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oXEYOVGiEIaS8rjqVK/VtY7+96OZNTU9qHtWYBB2mls=;
        b=Ymn1tw2dF9rNZDIS0zpMkGk/AmYoqpZqduOOlIwpIzCS1BJfc0uVUXJg3+8hF/SIivxCz5
        XUm/JSVB/gpW2q3sz+Yk73VbpTKa6NVg/xaOI7rmNg6zGsgds0IicoXWZhroQQhYCdCqun
        acIiF+As6YsvS02mGYL8BqNusECP+Oo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-xt5N50nfOlWH07DiGnX_OA-1; Fri, 29 Apr 2022 14:56:06 -0400
X-MC-Unique: xt5N50nfOlWH07DiGnX_OA-1
Received: by mail-wm1-f70.google.com with SMTP id c62-20020a1c3541000000b0038ec265155fso6232798wma.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=oXEYOVGiEIaS8rjqVK/VtY7+96OZNTU9qHtWYBB2mls=;
        b=ZQQxBdv5d+LJZYIuYUQFsaPF++kKhBMmiZsJeNZxoQBx2D5j/w/mn8ekFsuaWBulzZ
         L1LJ3gz2UDjYCs6HsvRUTZIUupmK/2zp/HGWTj365CoavQAK0K8hBoVZ7uqCTV3hHMsR
         JKbJBEMOb0v/GCxoTxNJq6+f8ZkMTc8dpKJu037nLpA04hu0isiavh2aDfIQ3WDNDD4+
         8MwHU7GI5CFeOLj6gEea7KoLylCIGM9woBStWn5ymWq4bGcPmX7G70yz7Lf1PAQU5JID
         56dWURTLdo08JRIQlA69gzcnosZtyMeHBiD2QiIVPSbAP+lss9ywMEjRBm8us3sIi6Vp
         kM2w==
X-Gm-Message-State: AOAM530RpGQbUI6XwC0cjZ+mKjo7tiNYXcyYwFpWjniTlmgiSIxM4dw/
        DTiaMcWYLfi/i97NKwNI1ezbpMNrICY83qLWbJ9AEvIouED0g4opRGiG7lJRT+G42KgRGF2Pz7F
        8YUqa9qv96RxdmcH3B3Mbn1zQ
X-Received: by 2002:a5d:47af:0:b0:20a:c95e:b236 with SMTP id 15-20020a5d47af000000b0020ac95eb236mr394589wrb.53.1651258565160;
        Fri, 29 Apr 2022 11:56:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6ZE3RROaOfJj+XJfJxSRg2A5j0PJ86gl1VDYbLGFPHLsd+sT4VA321qoca53c0lbL8rwW4A==
X-Received: by 2002:a5d:47af:0:b0:20a:c95e:b236 with SMTP id 15-20020a5d47af000000b0020ac95eb236mr394561wrb.53.1651258564917;
        Fri, 29 Apr 2022 11:56:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:fe00:bbeb:98e6:617a:dea1? (p200300cbc707fe00bbeb98e6617adea1.dip0.t-ipconnect.de. [2003:cb:c707:fe00:bbeb:98e6:617a:dea1])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm3892909wmp.14.2022.04.29.11.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 11:56:04 -0700 (PDT)
Message-ID: <9781c7e7-d84e-4911-396b-718514f76b1f@redhat.com>
Date:   Fri, 29 Apr 2022 20:56:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v4 12/17] mm: remember exclusively mapped anonymous pages
 with PG_anon_exclusive
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
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
References: <20220428083441.37290-1-david@redhat.com>
 <20220428083441.37290-13-david@redhat.com>
 <20220429112655.6b44dae1a93a9aa93adb0bcf@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220429112655.6b44dae1a93a9aa93adb0bcf@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.04.22 20:26, Andrew Morton wrote:
> On Thu, 28 Apr 2022 10:34:36 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>> Let's mark exclusively mapped anonymous pages with PG_anon_exclusive as
>> exclusive, and use that information to make GUP pins reliable and stay
>> consistent with the page mapped into the page table even if the
>> page table entry gets write-protected.
> 
> No reviewers on this one?
> 
> 

Looks like I missed Vlastimils ACK on this one in his second reply:

https://lkml.kernel.org/r/abc33620-b0dc-67e3-d3a9-2094475bf16e@suse.cz

-- 
Thanks,

David / dhildenb

