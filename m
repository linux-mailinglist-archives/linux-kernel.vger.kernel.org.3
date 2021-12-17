Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA18479398
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 19:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239749AbhLQSLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 13:11:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25558 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234093AbhLQSLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 13:11:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639764679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hdfHxUnq6Oqm9XHwzWNrUsr9UOXdYQoaq+fiSudykl8=;
        b=cMahuuQyeJoHgl+KgkCr/Uap0t59SoFqpFJHZ4VAUwILPIPQe7nqSwC9neBrdAC0Tn8hB6
        BeG2k7JoaU2ygffFVZh+GkhvOIxMDLrDd/8d0NXGBUKyA6Fi0GgCJYF0T1rW8hX6ZvxojS
        O3irI4SyrozSL0qvQwXD7Cx6yPBLBu4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-wmsTP_TTMHS7io7rzGje0w-1; Fri, 17 Dec 2021 13:11:18 -0500
X-MC-Unique: wmsTP_TTMHS7io7rzGje0w-1
Received: by mail-wr1-f72.google.com with SMTP id v15-20020adf8b4f000000b001a24c46d6ceso867657wra.15
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 10:11:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=hdfHxUnq6Oqm9XHwzWNrUsr9UOXdYQoaq+fiSudykl8=;
        b=cQL80EKeXoxafxM7LEPMbStekvsYHDI2HFnafa9o/zN6giSh94P28l2CAFCKRM9GpE
         7pJ0Jcqna8UkzbXmbaP1dgHXdQ0mKbO5VlT9mw/qCpH9j3/1D191or/26D6mdHj98LJM
         O/iyQmeEPSuPxm3g36c/6WrMT1MBwvZJ6zbd7wvOyGJ7nztFJbTIGkan5jbldO36K0Iz
         RjAK4Dq7ml5amM/wCtMOMGMLAF5/c2mxXELbGj6aw6uNE1HmQvpt7cnnprBdS0J2zERH
         LHYS+M/hEeXTarayglD3aOM81Pp9XifcMoY9cmMHYhKobWW2x/b02QlYKQOMd3Aas3cg
         LYpQ==
X-Gm-Message-State: AOAM532Pd10UMdWpv06f7XY57l6EnWdQl3WvxRdajPVYZAEBK0lbeOXI
        gle8TrblRFNd8eqYoVz5lq0QxwIOWn5lTuArTmMVokcIkFPGtS5RxsrRaOzlpILO8hxnhVRqCX8
        2s5n6AQVxqRrRe9V4HZyj7IsS
X-Received: by 2002:a05:6000:178a:: with SMTP id e10mr3479603wrg.373.1639764677177;
        Fri, 17 Dec 2021 10:11:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLgy4aZOFKjfg55PAvd6AQPyzQU9oTMWCfs9cPWTUhUrmiyEGJg84XCeuZydB2K04JHLv4EA==
X-Received: by 2002:a05:6000:178a:: with SMTP id e10mr3479574wrg.373.1639764676913;
        Fri, 17 Dec 2021 10:11:16 -0800 (PST)
Received: from [192.168.3.132] (p4ff234b8.dip0.t-ipconnect.de. [79.242.52.184])
        by smtp.gmail.com with ESMTPSA id n1sm9827003wrc.54.2021.12.17.10.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 10:11:16 -0800 (PST)
Message-ID: <7f35b4a3-8a31-d74c-fcc0-ecc87071d9a5@redhat.com>
Date:   Fri, 17 Dec 2021 19:11:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 03/11] mm: simplify hugetlb and file-THP handling in
 __page_mapcount()
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
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
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20211217113049.23850-1-david@redhat.com>
 <20211217113049.23850-4-david@redhat.com>
 <0b0007b3-bf6f-ccd7-96cf-3dd861abf224@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <0b0007b3-bf6f-ccd7-96cf-3dd861abf224@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.12.21 19:06, Mike Kravetz wrote:
> On 12/17/21 03:30, David Hildenbrand wrote:
>> Let's return early for hugetlb, which really only relies on the compound
>> mapcount so far and does not support PageDoubleMap() yet. Use the chance
> 
> It is too early to say if hugetlb double mapping will use PageDoubleMap().
> I do not think (hope) it will be necessary.  So, I think you can drop mention
> of it here.

Desires have most certainly been expressed from a couple of parties --
to PTE map huge pages :) Hopefully we'll find a way to avoid
PageDoubleMap, I agree.

Dropping the comment!

> 
>> to cleanup the file-THP case to make it easier to grasp. While at it, use
>> head_compound_mapcount().
>>
>> This is a preparation for further changes.
>>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> 

Thanks!

-- 
Thanks,

David / dhildenb

