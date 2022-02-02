Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD7F4A7664
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344609AbiBBRB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:01:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36587 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230295AbiBBRB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643821317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D25YjSr7KJ4sxl/Zh1uNR8s2aJGVWxQUiTzrhOO5QZM=;
        b=PAVhHaIeZOhKBB05nYseW9KX8s4Xcttj3rIYWtkFPk4LbEo02+fAIusZ0Dj/HpEl35oDJ0
        fVa2cPPrGsrAiEJDv80OOPm1PR6cEC98P5Iq4b1W/ssIOnA9gYW5vVmK8X7OYIRpLJOwx/
        /OrA/zDc3HPjJFDfLCVCqMPFuzcpODA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-vWDjpXF1P2yKIPeBdGL-ag-1; Wed, 02 Feb 2022 12:01:56 -0500
X-MC-Unique: vWDjpXF1P2yKIPeBdGL-ag-1
Received: by mail-wm1-f70.google.com with SMTP id ay8-20020a05600c1e0800b00350de81da56so4670303wmb.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 09:01:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=D25YjSr7KJ4sxl/Zh1uNR8s2aJGVWxQUiTzrhOO5QZM=;
        b=vlBI02PjLYd7eiftWSqIceUgWpruAVxS+tUxOHlPYcz//PMtjdbvBq5WwCV+ziI+au
         iv6fidNfEIOCcjRKY/gs4mOkIr/UvLBoTc3ngI8OjLckzPw5IhLDPCm9AyQcJZPovCmj
         4yYflyuZqq69XdtkQ7wLZ9O1rv99s5WjfW5v/V8aACgS9PV3De2HIU+M7LgbhqVh/Scn
         BkFhRCE145bhEDMNgWluA8FK2W/h81nFSv+u13H7C5nfHunB/8M9HwQPofeM43k89Ghu
         nuP7blLAQjMMOa9nZ8R1CJFnd1Iuy2GlQboL95itEo3iRxvujnu2bJvtDh0HwW8AZjK0
         EZGQ==
X-Gm-Message-State: AOAM5309g+tgSZn/wzCjq2FidMoHdSHh9T3M3vZOeq1vE2YjTSAvxPHt
        GxkSloMtYLk4b1IXLonKjeNrAzWqoznjN2pd7BVzTWxslSINc4HxOu5x5DD2ikNIzgLn+HHtWsC
        Gud65ibEqnCPwt22DIRmAPaet
X-Received: by 2002:adf:f8c6:: with SMTP id f6mr26089500wrq.290.1643821315074;
        Wed, 02 Feb 2022 09:01:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBUnBUSnsyQiXftcnch1RhXBPr4CAoPeFm5KDXx4DpxbNsCZ64xkm+qIkPtlCiPBMMG4kedw==
X-Received: by 2002:adf:f8c6:: with SMTP id f6mr26089483wrq.290.1643821314779;
        Wed, 02 Feb 2022 09:01:54 -0800 (PST)
Received: from ?IPV6:2003:d8:2f11:9700:838c:3860:6500:5284? (p200300d82f119700838c386065005284.dip0.t-ipconnect.de. [2003:d8:2f11:9700:838c:3860:6500:5284])
        by smtp.gmail.com with ESMTPSA id n5sm5957602wmq.43.2022.02.02.09.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 09:01:54 -0800 (PST)
Message-ID: <a7d787c7-d29a-e6af-5ed4-c43b198c2b27@redhat.com>
Date:   Wed, 2 Feb 2022 18:01:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 7/9] mm/swapfile: remove stale reuse_swap_page()
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
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
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>, linux-mm@kvack.org
References: <20220131162940.210846-1-david@redhat.com>
 <20220131162940.210846-8-david@redhat.com> <20220202143549.GA24789@lst.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220202143549.GA24789@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.02.22 15:35, Christoph Hellwig wrote:
> On Mon, Jan 31, 2022 at 05:29:37PM +0100, David Hildenbrand wrote:
>> All users are gone, let's remove it. We'll let SWP_STABLE_WRITES stick
>> around for now, as it might come in handy in the near future.
> 
> I don't think leaving a flag that has no user an a completely trivial
> place to set it around is a good idea.  This is a classic case of
> bitrot.

Right now I'm planning on using it in part 2 -- on which I'm currently
working on. If I don't end up reusing it, I'll remember to remove it.

-- 
Thanks,

David / dhildenb

