Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D26479A29
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 11:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhLRKHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 05:07:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52951 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229831AbhLRKHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 05:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639822023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XZ2/2GDqjwmlPCqWnOt2byTpaYB/3SglXvSt+1GORAs=;
        b=C3DET0ZdE4aLw1bOav5UQT3IAlyMJ7LWMUPEaVKYhxmKKkP06MfYktDxuiRTEtq/9wmWVs
        0J7FJFjApIuHsVlKOr7MbdqraFRI9TDwHEBbbuc9kTxvQGBwRxM4G0eFUFrXtXpxCfMbP3
        sACW9ZLiMK2eodc1l3r9MIJfdP8WCwA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-wgEJALqCOUyTRXvbKsWtrw-1; Sat, 18 Dec 2021 05:07:00 -0500
X-MC-Unique: wgEJALqCOUyTRXvbKsWtrw-1
Received: by mail-wm1-f72.google.com with SMTP id f202-20020a1c1fd3000000b00344f1cae317so2407904wmf.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 02:07:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=XZ2/2GDqjwmlPCqWnOt2byTpaYB/3SglXvSt+1GORAs=;
        b=ziPK9fuLvMTcmuc2lJ4hqd17nYR4IXOJRpRO1gcqqEJiYqCpaG0r1wnr6erPTQZDe5
         kgIXfkenb78vyDAezTn6TXxdbJ8GgXJmOv6uQyE2y5R/fsuktEi2pij2poR7Mq1Y/rTK
         GB8KYWQAcH6HrX0eR0gCmHeCWM4+T92jmB27NKdLvA1B+3Wg58cslrfrLr3GCs0u0iix
         WujmdX12d9jJjxxFa17F9mQa+qzgt86yqN46TEki0zwtDhN8SRu/8KOxczChrT919pIT
         qbZqCgyU7k7rRodfon3l6jrUU17MW1DRP8mJNi29fMXgAYYtimuV7756Z/3B1SxB96a9
         ZwXw==
X-Gm-Message-State: AOAM531fH1VGSVlSbY3PjRX2i3k8mdTBc+QCMFeXc/X4OlYm+cJr0rSh
        XH0PU4WJw7131HLisTx1miDic+qHwWpTOJo6qXL2Ho3xMKSLty9cSfxVft6MAWDc+HyJ4yPjVn5
        Vt1JkHynLpUR6HcJt7y530+bR
X-Received: by 2002:a5d:64e4:: with SMTP id g4mr5622437wri.510.1639822019714;
        Sat, 18 Dec 2021 02:06:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyE6IcrxlQD0ttKE3+QlbV92H6zyi5iah32fTwcoLS9Mg22cTAzNLO8d6jIQan1384A88Cdag==
X-Received: by 2002:a5d:64e4:: with SMTP id g4mr5622424wri.510.1639822019520;
        Sat, 18 Dec 2021 02:06:59 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6703.dip0.t-ipconnect.de. [91.12.103.3])
        by smtp.gmail.com with ESMTPSA id l2sm2726112wru.83.2021.12.18.02.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Dec 2021 02:06:59 -0800 (PST)
Message-ID: <f3479378-48bc-23be-d651-3ec52bb0085d@redhat.com>
Date:   Sat, 18 Dec 2021 11:06:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
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
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20211217113049.23850-1-david@redhat.com>
 <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com>
 <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
 <20211217204705.GF6385@nvidia.com>
 <2E28C79D-F79C-45BE-A16C-43678AD165E9@vmware.com>
 <CAHk-=wgw5bEe8+qifra-aY9fAOf2Pscp1vuXX=f4hESyCK_xLg@mail.gmail.com>
 <CAHk-=wjjNx2Ch2j7P+7vDceK39PpmrOqby3gXuTY4aj62dowFw@mail.gmail.com>
 <CAHk-=wj+VpgJ3RfRQNxYS3xN9O01rwWnSBX7mztxFaE6BTLzFw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHk-=wj+VpgJ3RfRQNxYS3xN9O01rwWnSBX7mztxFaE6BTLzFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.12.21 03:42, Linus Torvalds wrote:
> On Fri, Dec 17, 2021 at 6:17 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I think the hugepage code should use the exact same logic that the
>> regular wp fault code does.
> 
> IOW, I think that this stupid (AND UNTESTED) patch should likely just
> fix David's test-case with the hugepage and splice thing..
> 
> Or at least be somewhat close.  But it should be paired with the GUP
> side doing the right thing too, of course. Maybe it already does,
> maybe it doesn't, I didn't check...
> 
> And maybe there's something subtle about the page_count() of a THP
> entry. Again, I can't really claim to have tested this all, but I'm
> hoping this makes somebody go "Ahh, now I see what Linus means"

Not the reaction you are hoping for: "Gah, Linus still doesn't see why
the page_count is just wrong". :)

See the mail I just wrote, let's get a common understanding of how our
check should actually look like.

-- 
Thanks,

David / dhildenb

