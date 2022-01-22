Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF3F496BA7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 11:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbiAVKSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 05:18:50 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:37615 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiAVKSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 05:18:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1642846695;
    s=strato-dkim-0002; d=schoebel-theuer.de;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=8T8wzyEFV1gpfcMp5beb/aXparqxKKNBbKGp5R8qWvU=;
    b=WCkICED+u8UqCXNAn4Q6ec3VIfgAQioAw1TAu4XkEqOOpuIlCorxIE+ICU9SYmvjXt
    QFP5iTmHrT8aCDSd/MDbYLGBwbtQyYb8b2+E81yESNOiCtNCHrLxHZ8tqQRmz2EJ3Z8t
    VvTY4VoAES0QxOaNjkSyNY1lbtrkHz6+2EonIYa8SiCeYuHJl0IzC0sI1K7BJO1gzpff
    QR2Cyr2lwLTbQh97+2Cpx/hF0uh1sXirZQfBVTcnlUGJJzIaEUc2j1Hu0jYuSq/1v1GF
    BkUHu1f9Q50Ez8UYUlUxYLMkBp0/yT42fvV8upU/J9MYmSgKE9/20kTcQlpDT+MLSr5P
    2tGA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":OH8QVVOrc/CP6za/qRmbF3BWedPGA1vjs2e0bDjfg8OiOrPJifeRMRhMYPeob5ctvymt3ppSxzy7"
X-RZG-CLASS-ID: mo00
Received: from [192.168.2.102]
    by smtp.strato.de (RZmta 47.38.0 DYNA|AUTH)
    with ESMTPSA id 036fcey0MAIEB3H
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 22 Jan 2022 11:18:14 +0100 (CET)
From:   Thomas Schoebel-Theuer <tst@schoebel-theuer.de>
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
To:     Matthew Wilcox <willy@infradead.org>,
        "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        Barry Song <21cnbao@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
References: <cover.1642526745.git.khalid.aziz@oracle.com>
 <20220121010806.5607-1-21cnbao@gmail.com>
 <YeoW4CMiU8qbRFST@casper.infradead.org>
 <CAGsJ_4wv144TUSQPNOnHnmNmJrXe4Fn8d14JeAJ5ka-S+dRxRA@mail.gmail.com>
 <YerHceldiYXLk2DE@casper.infradead.org>
 <0ec88ae7-9740-835d-1f07-60bd57081fcd@oracle.com>
 <b34ded1e11154eabbce07618bf0a6676@huawei.com>
 <Yetgy/eT+rZBgSq7@casper.infradead.org>
Message-ID: <cb55951f-3c30-61e3-23a3-7a99064918b7@schoebel-theuer.de>
Date:   Sat, 22 Jan 2022 11:18:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <Yetgy/eT+rZBgSq7@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/22 2:41 AM, Matthew Wilcox wrote:
> On Sat, Jan 22, 2022 at 01:39:46AM +0000, Longpeng (Mike, Cloud Infrastructure Service Product Dept.) wrote:
>>>> Our use case is that we have some very large files stored on persistent
>>>> memory which we want to mmap in thousands of processes.  So the first
>> The memory overhead of PTEs would be significantly saved if we use
>> hugetlbfs in this case, but why not?
> Because we want the files to be persistent across reboots.

100% agree. There is another use case: geo-redundancy.

My view is publicly documented at 
https://github.com/schoebel/mars/tree/master/docu and click at 
architecture-guide-geo-redundancy.pdf

In some scenarios, migration or (temporary) co-existence of block 
devices from/between hardware architecture A to/between hardware 
architecture B might become a future requirement for me.

The currrent implementation does not yet use hugetlbfs and/or its 
proposed / low-overhead / more fine-grained and/or less 
hardware-architecture specific (future) alternatives.

For me, all of these are future options. In particular, when (1) 
abstractable for reduction of architectural dependencies, and hopefully 
(2) usable from both kernelspace and userspace.

It would be great if msharefs is not only low-footprint, but also would 
be usable from kernelspace.

Reduction (or getting rid) of preallocation strategies would be also a 
valuable feature for me.

Of course, I cannot decide what I will prefer in future for any future 
requirements. But some kind of mutual awareness and future collaboration 
would be great.

