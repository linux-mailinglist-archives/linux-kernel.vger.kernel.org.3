Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6504FDC73
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358254AbiDLK1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239068AbiDLKUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29EEE4F9C2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649755698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BPZL0gQJQGj2dxWVcV/vLfhS55E7VF45Sx/T/CMMfLY=;
        b=b7ZBoJaiR0gL29zH05AjqKg8+hDmpF1uJtuMeK6Cy7kNit1+DrJ65M9mDZb1eXdxkFd5/8
        njYw7lXFtZnaAgIlRAB1s2Kj2ANSiHFmx/ghu5mLGZNc+j8+d3uF7zXa36iXS++T0wjN0V
        GJGG8S+NNwntuXJ19yx960yyGX8s9/M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-JjHNRyAEMue8vWapjvbMSw-1; Tue, 12 Apr 2022 05:28:17 -0400
X-MC-Unique: JjHNRyAEMue8vWapjvbMSw-1
Received: by mail-wm1-f71.google.com with SMTP id z16-20020a05600c0a1000b0038bebbd8548so1036115wmp.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=BPZL0gQJQGj2dxWVcV/vLfhS55E7VF45Sx/T/CMMfLY=;
        b=5KCT1MZSITwk38d9/6wR2lYTdX9JSylNxeN1mjEzudcCe+kbt+qRTqRu3O682vTTat
         jsPL2HNbVL/vIxuAu+U+S1LZ0o5wfL5mF/DFYUt+mMsw2HE/XTd3m1st//cuaXcHMetZ
         rQLzFw+zxRt+epTnzqRlNUFJHRSgV0T03Si72ha2wBQRvA4u44dDHJkiVpny5btQnuKh
         K9aOXiEOJlBPnaNRLp++TMrTchEOMS/+Gf4+CmO1ueTybYolpRtzzS60S2mdwzrkjmIl
         Cv7kAavR9OBGQarcbZ4YlvBBDcdFKjt3NKq8s1KrqSn/nDlJfzSXcLYQJ0K2uGjcyUze
         tegw==
X-Gm-Message-State: AOAM532nMVCZSEu07XXJDRjv/nGtHHdR9W0FhfTGzwz/5bsawgdW/79W
        jDvVCQfLKoa6C6yydniLataFZHMUABoqZbEFPdPigUdxNcvqYp89cgirfweL/iMEuRKlNAoIhKc
        WkyfkFYjwhaokn23C7TLRp1ui
X-Received: by 2002:a05:600c:2744:b0:38e:b6f7:d548 with SMTP id 4-20020a05600c274400b0038eb6f7d548mr3223427wmw.49.1649755696255;
        Tue, 12 Apr 2022 02:28:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPb5RwgNVG0/CMAQXa8th3l2BPON0WeEZdxNgyMhc/eoLviJMQjndKh+kSFR0wgqOPunt1GQ==
X-Received: by 2002:a05:600c:2744:b0:38e:b6f7:d548 with SMTP id 4-20020a05600c274400b0038eb6f7d548mr3223398wmw.49.1649755696013;
        Tue, 12 Apr 2022 02:28:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:1800:7c14:16cc:5291:a9f3? (p200300cbc70718007c1416cc5291a9f3.dip0.t-ipconnect.de. [2003:cb:c707:1800:7c14:16cc:5291:a9f3])
        by smtp.gmail.com with ESMTPSA id e14-20020a5d6d0e000000b002078ea4f6bdsm13735358wrq.75.2022.04.12.02.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 02:28:15 -0700 (PDT)
Message-ID: <a1ef20a1-6eda-2350-e5dc-bb32dcff8a1d@redhat.com>
Date:   Tue, 12 Apr 2022 11:28:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 09/16] mm/rmap: use page_move_anon_rmap() when reusing
 a mapped PageAnon() page exclusively
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
 <20220329160440.193848-10-david@redhat.com>
 <7225391a-5798-94ae-7a01-9a9dd344e13a@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <7225391a-5798-94ae-7a01-9a9dd344e13a@suse.cz>
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

On 12.04.22 11:26, Vlastimil Babka wrote:
> On 3/29/22 18:04, David Hildenbrand wrote:
>> We want to mark anonymous pages exclusive, and when using
>> page_move_anon_rmap() we know that we are the exclusive user, as
>> properly documented. This is a preparation for marking anonymous pages
>> exclusive in page_move_anon_rmap().
>>
>> In both instances, we're holding page lock and are sure that we're the
>> exclusive owner (page_count() == 1). hugetlb already properly uses
>> page_move_anon_rmap() in the write fault handler.
> 
> Yeah, note that do_wp_page() used to call page_move_anon_rmap() always since
> the latter was introduced, until commit 09854ba94c6a ("mm: do_wp_page()
> simplification"). Probably not intended.

Yeah, it was buried underneath all that reuse_swap_page() complexity.


-- 
Thanks,

David / dhildenb

