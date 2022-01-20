Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A544953C9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbiATSAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:00:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43805 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232955AbiATSAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642701643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xG8ATCiG+XFzwKW1rvbLJULeQ6x9hpa2tAuaM5r+WyQ=;
        b=TLUlTy7iIgKYakROEwST4kWsp07FINY/d11FHzR6xKnkrnJ6+vRI7syhaGlyF8gCyZPLl+
        K+byI7nJwqFkfWmnW3zd2/dohiReb6u8sPORvIA9oF/AHNT90rq1qSRgUaQCRvEhWAoldQ
        GqNZ2OAafmn4h3XmtKJ1+HKjGpUpgCc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-95QDHf30P12D_lCqrLT89Q-1; Thu, 20 Jan 2022 13:00:41 -0500
X-MC-Unique: 95QDHf30P12D_lCqrLT89Q-1
Received: by mail-ed1-f71.google.com with SMTP id j1-20020aa7c341000000b0040417b84efeso6525041edr.21
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:00:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=xG8ATCiG+XFzwKW1rvbLJULeQ6x9hpa2tAuaM5r+WyQ=;
        b=NrWix9PzOGBnoOphLQm/U6Wrbmb3nJsbJaTqH03QzSlNjYdNRZNBxU3S+LYlPAhOpi
         Vl1HNt+yti9Ge5/fRUmXKvQCNXthorF0GnAC6gegeWPTR8dzkJiUqRrmMwB3u8NOo89D
         xYrHuXbvv2Mkg/1LY6GS40pILAmE0+tuzhSWlXnLzAr7MM/a/8L5UvfUWCQc1l0O7lMp
         k1xz1rk/ybgwvddElP0juwblU2XPUheAppnuiQ5n/LNYT/CvfthTcaBkiNtmRobGKMEP
         ONQ4MA7NoIX5xndvadWqAKCcwMN+rC4vPEvd2ySjzADrrPa01xo4DLQ8Mral+ntrYlx0
         Zxfw==
X-Gm-Message-State: AOAM533DjIvJdSIf0H+fbdhc5U5v6XWAMbv/RHbdsSKGOP1EBYTpHrDL
        O+FhkSXOUILhVDg9tD7Pr08CG5ar8RKQW+527y3uQn0TzvD8OOsVmdhxnYs5vJ8Sye/Ik1sjSTQ
        nL2qy1JGsGa8P72M5tHRKtX2w
X-Received: by 2002:a17:906:c058:: with SMTP id bm24mr46488ejb.50.1642701640134;
        Thu, 20 Jan 2022 10:00:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5bWIoqRADndOdik1C8nbEca2kYtg300FlXfWdlrg8NTMyukErf+Y3mpewRw+ZcpU7tJkDpA==
X-Received: by 2002:a17:906:c058:: with SMTP id bm24mr46462ejb.50.1642701639906;
        Thu, 20 Jan 2022 10:00:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5800:eeb:dae2:b1c0:f5d1? (p200300cbc70e58000eebdae2b1c0f5d1.dip0.t-ipconnect.de. [2003:cb:c70e:5800:eeb:dae2:b1c0:f5d1])
        by smtp.gmail.com with ESMTPSA id h15sm1274546ejg.144.2022.01.20.10.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 10:00:39 -0800 (PST)
Message-ID: <8931808d-db61-0f06-ceb3-f48a83b1f74c@redhat.com>
Date:   Thu, 20 Jan 2022 19:00:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     "zhangliang (AG)" <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220113140318.11117-1-zhangliang5@huawei.com>
 <YeA5oP/iaxtVPHb3@casper.infradead.org>
 <CAHk-=wjB0i-B=U-DhpAajQx3f6bp1X==neLOrg0jwq29mgz=3g@mail.gmail.com>
 <172ccfbb-7e24-db21-7d84-8c8d8c3805fd@redhat.com>
 <a93988da-80fb-dd32-4717-a6a0bae9e4ee@huawei.com>
 <dc415c4a-63aa-19b0-0fbc-795989970f6d@redhat.com>
 <fb02087a-b102-c91e-ab65-fb02cc8ee0a2@huawei.com>
 <9cd7eee2-91fd-ddb8-e47d-e8585e5baa05@redhat.com>
 <b6df4f7f-c080-ad6c-d1ad-098115f016f3@huawei.com>
 <747ff31c-6c9e-df6c-f14d-c43aa1c77b4a@redhat.com>
 <C8734D0B-B855-4323-A7DF-2D96245951B2@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
In-Reply-To: <C8734D0B-B855-4323-A7DF-2D96245951B2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.01.22 18:48, Nadav Amit wrote:
> 
>> On Jan 20, 2022, at 6:15 AM, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 17.01.22 14:31, zhangliang (AG) wrote:
>>> Sure, I will do that :)
>>
>> I'm polishing up / testing the patches and might send something out for discussion shortly.
>> Just a note that on my branch was a version with a wrong condition that should have been fixed now.
>>
> 
> Sorry for being late for the discussion.
> 
> David, does any of it regards the lru_cache_add() reference issue that I
> mentioned? [1]

No, unfortunately not in that part of my work. *Maybe* we could also try
to handle that reference similarly to the swapcache, but the question is
if we can't wait for PageAnonExclusive.

Right now I have the following in mind to get most parts working as
exptected:

1. Optimize reuse logic for the swapcache as it seems to be easy
2. Streamline COW logic and remove reuse_swap_page() -- fix the CVE for
   THP.
3. Introduce PageAnonExclusive and allow FOLL_PIN only on
   PageAnonExclusive pages.
4. Convert O_DIRECT to FOLL_PIN

We will never ever have to copy a page PageAnonExclusive page in the COW
handler and can immediately reuse it without even locking the page. The
existing reuse logic is essentially then used to reset PageAnonExclusive
on a page (thus it makes sense to work on it) where the flag is not set
anymore -- or on a fresh page if we have to copy.

That implies that all these additional references won't care if your app
doesn't fork() or KSM isn't active. Consequently, anything that
read-protects anonymous pages will work as expected and should be as
fast as it gets.

Sounds good? At least to me. If only swap/migration entries wouldn't be
harder to handle than I'd wish, that's why it's taking a little and will
take a little longer.

> 
> Seems to me that any solution should also regard this problem, or am I
> missing something?

The bigger picture has to handle it, yes!

-- 
Thanks,

David / dhildenb

