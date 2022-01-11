Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B96848AA0B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349127AbiAKJAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:00:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349133AbiAKJAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641891640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HwTgs2Y/gzDETqEOa6cQ15U5dH6fx+WgFTgxP975v6Q=;
        b=gDWrQeambq5xOYRRcHZNcVV9tG/csQBBwflMuRO+ZDBZb/+Z/4klSdBM0PscdwRqclY9jG
        ZCuUHM8hsi4G48q3+q/0qIQ21JtxL5ghQZ3BRF765jxGQJQ4AlfYYTjE7f++U/mQemH2xM
        rHTBXOD2azT4myq4uCd1C5gRjwxGWkQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-NlelGdW1P_GOXz4UoGwmvw-1; Tue, 11 Jan 2022 04:00:38 -0500
X-MC-Unique: NlelGdW1P_GOXz4UoGwmvw-1
Received: by mail-ed1-f72.google.com with SMTP id t1-20020a056402524100b003f8500f6e35so12742714edd.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 01:00:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=HwTgs2Y/gzDETqEOa6cQ15U5dH6fx+WgFTgxP975v6Q=;
        b=OUEm9NreuRg4/5hyGcKWiE3l5QhDjFnFRLAmG6J8pPgF84sLxdwqo+mouJwAJj6l2d
         u5iiEVVcPlOsbM8SsNnU8PhMAtfHJGUhN8xtMI/G/bVBxk0zR4eIYVKFJYDTw6IrCJ3U
         wr0tfBWl3KqYl/s8+Vop0NGti2r18ngyoJmTcSwe7Rs+O5bEgnpmDRdgiYCatwFeUn2u
         UVxLrCAc7WfaYEiTjxj1LMiht0lzBMK88mJIpf+6LQB9ktng1rhdy/9L/VDGwaHnqGoH
         77LYPFVxhLQkcw+O+xSURMupIZMIyRSp/P8jb+P6D1iSIzSBB16++vdq+Dlhjg5hr+t4
         wWTA==
X-Gm-Message-State: AOAM533WotiCtTrX5fIO4SjxwzXPlmIeptceYP8uMbMwHZv65ABmbhMq
        KaoHKCzzbohdHORs4aGw23rBehNfcDiKmOh0XcJmuEzctwnDWgt8FRkS1Xm72dlzHRYmXI2rLFH
        FotiKDnQ0aGWhjdzfkfnwckWG
X-Received: by 2002:aa7:db90:: with SMTP id u16mr3397372edt.403.1641891637581;
        Tue, 11 Jan 2022 01:00:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyt1tzZWdcTIPjqZ/ckY27ze6jZWXnU+i9Or1hNPoXVzyiDFui8mVzHKOKlX5UJaksDRC7jqg==
X-Received: by 2002:aa7:db90:: with SMTP id u16mr3397346edt.403.1641891637307;
        Tue, 11 Jan 2022 01:00:37 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:6800:150a:bea9:f03e:c4da? (p200300cbc7026800150abea9f03ec4da.dip0.t-ipconnect.de. [2003:cb:c702:6800:150a:bea9:f03e:c4da])
        by smtp.gmail.com with ESMTPSA id h11sm4815589edb.59.2022.01.11.01.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 01:00:36 -0800 (PST)
Message-ID: <865621ac-81e4-5396-ded1-3502b1e5a061@redhat.com>
Date:   Tue, 11 Jan 2022 10:00:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
References: <20211115134951.85286-1-peterx@redhat.com>
 <20211115134951.85286-2-peterx@redhat.com>
 <849f1e44-d35e-b8c6-c7c3-a73941028ba7@redhat.com>
 <4711362.BPgp0156Pq@nvdebian>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC v2 1/2] mm: Don't skip swap entry even if zap_details
 specified
In-Reply-To: <4711362.BPgp0156Pq@nvdebian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.01.22 08:40, Alistair Popple wrote:
> On Monday, 10 January 2022 7:37:15 PM AEDT David Hildenbrand wrote:
>> On 15.11.21 14:49, Peter Xu wrote:
>>> This check existed since the 1st git commit of Linux repository, but at that
>>> time there's no page migration yet so I think it's okay.
>>>
>>> With page migration enabled, it should logically be possible that we zap some
>>> shmem pages during migration.  When that happens, IIUC the old code could have
>>> the RSS counter accounted wrong on MM_SHMEMPAGES because we will zap the ptes
>>> without decreasing the counters for the migrating entries.  I have no unit test
>>> to prove it as I don't know an easy way to trigger this condition, though.
>>>
>>> Besides, the optimization itself is already confusing IMHO to me in a few points:
>>>
>>>   - The wording "skip swap entries" is confusing, because we're not skipping all
>>>     swap entries - we handle device private/exclusive pages before that.
>>
>> I think one part of the confusion is "swap vs non-swap" entries.
>> For !pte_none() && !pte_present() we can have
>>
>> * swap entry
>> * non-swap entry
>> ** device exclusive entry
>> ** device private entry
>> ** HWpoison entry
>> ** migration entry
>>
>> So the comment claims to skip "swap entries" but also skips HWpoison and
>> migration entries, and I think that's the confusing part.
>> Both only apply to PageAnon().
> 
> I must be missing something but why do these only apply to PageAnon()?

My memory might be wrong. I remember that for PageAnon() we need
migration/hwpoison entries because there is no way we could refault the
page from a mapping once we zap the entry. For everything else, we could
zap and refault. But looks like we indeed also use migration/hwpoison
entries for pages with a mapping, although it might not be strictly
required.

> 
>> IIUC, the only way we could get details != NULL is via unmap_mapping_page()+unmap_mapping_pages().
>>
>> I do wonder if any of the callers really cares about PageAnon() pages where this would be relevant.
>>
>> Am I wrong or is unmap_mapping_pages() never called with "even_cows == true" and we can remove
>> that paremeter:
> 
> Except that unmap_mapping_range() takes `even_cows` as a parameter and passes
> that to unmap_mapping_pages(), and from what I can tell there are callers of
> unmap_mapping_range() that set `even_cows = true`.

You're right.

-- 
Thanks,

David / dhildenb

