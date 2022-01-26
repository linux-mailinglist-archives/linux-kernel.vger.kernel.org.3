Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C5349C74A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239805AbiAZKQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:16:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59868 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232071AbiAZKQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643192207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i+iYnOCszqZtWRIHCDiP4bSvj4+rWsxJQtP1TOvOfEg=;
        b=h9huao2wPaaeqjPnpODf8ow11SeM3qHDM10+blDOcW5QThGD8fSWjrb7qzRtAOELQjn1l5
        aWB7UjlcDaErnY1QbN6+T0cyXGNHL42yOv98Au5fiq3K/NrWv14UU82ZU29knFmsqVYseT
        Sn44Rh23zhUEcCAXnIio8NarkCgl0ZA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-DIusorWnPLybADSk88XE1A-1; Wed, 26 Jan 2022 05:16:45 -0500
X-MC-Unique: DIusorWnPLybADSk88XE1A-1
Received: by mail-wm1-f69.google.com with SMTP id d184-20020a1c1dc1000000b00350769d4bcfso1182405wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:16:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=i+iYnOCszqZtWRIHCDiP4bSvj4+rWsxJQtP1TOvOfEg=;
        b=syBClro7pXNLOAeJI0Rd+ukrjUzWwrvZEo0OSbDXsZ7HJFa6bqRVkXyIRewOxEC6fZ
         vTlUoWzzQXGxIhK7A4YHV9qrwj7dvf02qObh55PdTX62nsTHGOjq5B3uCbrX+PzPYpjf
         hGvPpxOjgUF76PdPuz/vrxrzIboqrsh19kwmD+Dj0TSDrPRny4KJ8/J2kF2bk47i3UJc
         NbatOUhYfWbsWj80XzkNaFDPG2t2/22q6zb5I2RZD9SEC1q0I0DkaNaFyOBpZ7fezJVn
         WKnMo0eYprgXO9nYYpsAlm/eXedYldPYH5db7n4iU7iIschuqbOa51B7rt1lK603JgBw
         K3eQ==
X-Gm-Message-State: AOAM532aQdztNVddwM/YrrlPfcETP1R3AoBcG72KPGbnP6kMCktEauuL
        qEqx53oN0lA+v6Jc7EzLiQgZEl79LlYAqVVsZhz9YGRWY3gPkIXzqfhTSfSMSu8/b4A2s4bGEX/
        6qI+c7RiXJkSO+zWwBLP/abZ9
X-Received: by 2002:a1c:7416:: with SMTP id p22mr6891612wmc.30.1643192204647;
        Wed, 26 Jan 2022 02:16:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwIeCJvuTiz2MYLx0qNnWNJytnSE3+PMInZFlSic+GGcCvaHzih6qz2BK6Wsm+IBAbf4DNl5w==
X-Received: by 2002:a1c:7416:: with SMTP id p22mr6891585wmc.30.1643192204361;
        Wed, 26 Jan 2022 02:16:44 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:2700:cdd8:dcb0:2a69:8783? (p200300cbc7092700cdd8dcb02a698783.dip0.t-ipconnect.de. [2003:cb:c709:2700:cdd8:dcb0:2a69:8783])
        by smtp.gmail.com with ESMTPSA id g6sm16786801wrq.97.2022.01.26.02.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 02:16:43 -0800 (PST)
Message-ID: <e164d7f4-406e-eed8-37d7-753f790b7560@redhat.com>
Date:   Wed, 26 Jan 2022 11:16:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
        longpeng2@huawei.com, arnd@arndb.de, dave.hansen@linux.intel.com,
        rppt@kernel.org, surenb@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Peter Xu <peterx@redhat.com>
References: <cover.1642526745.git.khalid.aziz@oracle.com>
 <20220125114212.ks2qtncaahi6foan@box.shutemov.name>
 <Ye/5yUyEqO0ws0G5@casper.infradead.org>
 <20220125135917.ezi6itozrchsdcxg@box.shutemov.name>
 <YfAEqzTeBJSIOKcA@casper.infradead.org>
 <20220125185705.wf7p2l77vggipfry@box.shutemov.name>
 <YfBIpmxvc0+mFByf@casper.infradead.org>
 <YfDIYKygRHX4RIri@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
In-Reply-To: <YfDIYKygRHX4RIri@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.01.22 05:04, Matthew Wilcox wrote:
> On Tue, Jan 25, 2022 at 06:59:50PM +0000, Matthew Wilcox wrote:
>> On Tue, Jan 25, 2022 at 09:57:05PM +0300, Kirill A. Shutemov wrote:
>>> On Tue, Jan 25, 2022 at 02:09:47PM +0000, Matthew Wilcox wrote:
>>>>> I think zero-API approach (plus madvise() hints to tweak it) is worth
>>>>> considering.
>>>>
>>>> I think the zero-API approach actually misses out on a lot of
>>>> possibilities that the mshare() approach offers.  For example, mshare()
>>>> allows you to mmap() many small files in the shared region -- you
>>>> can't do that with zeroAPI.
>>>
>>> Do you consider a use-case for many small files to be common? I would
>>> think that the main consumer of the feature to be mmap of huge files.
>>> And in this case zero enabling burden on userspace side sounds like a
>>> sweet deal.
>>
>> mmap() of huge files is certainly the Oracle use-case.  With occasional
>> funny business like mprotect() of a single page in the middle of a 1GB
>> hugepage.
> 
> Bill and I were talking about this earlier and realised that this is
> the key point.  There's a requirement that when one process mprotects
> a page that it gets protected in all processes.  You can't do that
> without *some* API because that's different behaviour than any existing
> API would produce.

A while ago I talked with Peter about an extended uffd (here: WP)
mechanism that would work on fds instead of the process address space.

The rough idea would be to register the uffd (or however that would be
called) handler on an fd instead of a virtual address space of a single
process and write-protect pages in that fd. Once anybody would try
writing to such a protected range (write, mmap, ...), the uffd handler
would fire and user space could handle the event (-> unprotect). The
page cache would have to remember the uffd information ("wp using
uffd"). When (un)protecting pages using this mechanism, all page tables
mapping the page would have to be updated accordingly using the rmap. At
that point, we wouldn't care if it's a single page table (e.g., shared
similar to hugetlb) or simply multiple page tables.

It's a completely rough idea, I just wanted to mention it.

-- 
Thanks,

David / dhildenb

