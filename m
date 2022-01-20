Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB5B495277
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377063AbiATQfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:35:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45497 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377048AbiATQfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642696530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Cv4ecf7GNT/p9vmHS5xcSabCvV+bpl0vkADyXi+gD8=;
        b=BnxHWWDKo0WzCmneTRSNhSD5Epob2x3rfUIeleb+cjCJeUV1m5SK2VHz5r5deeHAsdvnCX
        fawWQ4dA9VW95sBCTEWNVQ/mPRcP+++Qd+sT4fGZx521LnUssD8bec4YfzCJhnDmsoUy1/
        0iHESivWND+l+nCTVibbzWIrl0M1Vnw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-442-Bd4JDC78MZa_80u-xQ8tIQ-1; Thu, 20 Jan 2022 11:35:27 -0500
X-MC-Unique: Bd4JDC78MZa_80u-xQ8tIQ-1
Received: by mail-wm1-f71.google.com with SMTP id f187-20020a1c38c4000000b0034d5c66d8f5so4907617wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 08:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=7Cv4ecf7GNT/p9vmHS5xcSabCvV+bpl0vkADyXi+gD8=;
        b=dWAFoJE+pp9n5mRzuR0/TUr8v0CqsPMLbSumvyTlRZVqxf1LGmP+ogumnRpXjTh8Se
         jgMXgDjKYsRiyJzmF033GgfdDaUQWYfjWMbc6rjWlyD7s1avvFWQ9JV72li8FQXxT1dX
         zfByxR+Ji8sGiuEi8xJwa7Yq06oB+l9yEvcOnM7RIi5ytlrelMRp7ix5qlbDTUAdQ4HC
         KcKatG88fsFs01OPx+6zc54QAwQg2wro2cYKPQfL4c1SxKwInG5iyMSzui/b078zSt5/
         g00RBt7SnuPepv0i693m5NaD8ZuWLGhN9i9nxV8laE4laRoRP4IM4ExpOS9qpLcoz0fn
         2S5w==
X-Gm-Message-State: AOAM530vG0Jv/bPB6aoSUaBzU5vkQUdbJvwhnC6Bfbav6R+qXwydQgeA
        gLZt1YSgSCy58jUA90EXYtIdkDZhRu658v6bWUNmEWJfxmEaukwwMlhL4BRKriyIiBm2cLo12zE
        9fqjgwvJwn3ZEv8FlzeoT1O4Y
X-Received: by 2002:a05:600c:3843:: with SMTP id s3mr5749074wmr.150.1642696525979;
        Thu, 20 Jan 2022 08:35:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMb3IqTVFLfQdg4IWw3BqbA+NKZnfLxu9CZU6PoSYNSOuBGcrB/a08RW5NoiZLqF3sZR88Jw==
X-Received: by 2002:a05:600c:3843:: with SMTP id s3mr5749054wmr.150.1642696525736;
        Thu, 20 Jan 2022 08:35:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5800:eeb:dae2:b1c0:f5d1? (p200300cbc70e58000eebdae2b1c0f5d1.dip0.t-ipconnect.de. [2003:cb:c70e:5800:eeb:dae2:b1c0:f5d1])
        by smtp.gmail.com with ESMTPSA id i17sm3055553wru.107.2022.01.20.08.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 08:35:25 -0800 (PST)
Message-ID: <6ccfce39-d022-0c85-cfee-3070d9dfc9a1@redhat.com>
Date:   Thu, 20 Jan 2022 17:35:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "zhangliang (AG)" <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <fb02087a-b102-c91e-ab65-fb02cc8ee0a2@huawei.com>
 <9cd7eee2-91fd-ddb8-e47d-e8585e5baa05@redhat.com>
 <b6df4f7f-c080-ad6c-d1ad-098115f016f3@huawei.com>
 <747ff31c-6c9e-df6c-f14d-c43aa1c77b4a@redhat.com>
 <Yel0BXVyj8uvsWJX@casper.infradead.org>
 <e2580cfa-a529-934d-861a-091c4a9714d4@redhat.com>
 <YemBl4ZVtJqtAVwV@casper.infradead.org>
 <759f9bc8-0b10-7f0f-28a6-f292bed9053f@redhat.com>
 <YemDry2rkD2VUcw9@casper.infradead.org>
 <88a8b1a3-232d-df9c-d7f6-0ea9f2dd4b36@redhat.com>
 <YemJLR08tsY4s/nN@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
In-Reply-To: <YemJLR08tsY4s/nN@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> Sorry, I was less verbose because I was just sending out the
>> patch+description to Linus' reply and was assuming you're going to read
>> it anyways ;)
> 
> This reply arrived before your reply to Linus ;-)  Anyway ...

Yes, I could just have added that I'm going to reply with the patch to
Linus after Linus' mail flew in and I made up my mind how to proceed,
that would have been nicer :)

> 
>> Yes, I'm speaking about exactly that fallback path.
> 
> OK, so in that fallback path, we're already determined the THP has
> more than one reference to it (ok, maybe that extra reference was
> temporary and now gone), but we've already split the PMD down into

Yes, any extra references or concurrent writeback. Swapcache was once
example that my patch hopefully handles properly.

> PTEs, and COWed one of the other pages that was in the THP.  If
> anything, we should be more aggressive about COWing the remaining
> pages in the THP, not looking for reasons why we might be able to
> avoid COWing this particular page.

At that point in time we didn't COW yet, we only PTE-mapped the THP, but
yes, once we reach do_wp_page() we will always COW, even if there are no
additional references anymore.

Ideas I had what we could do once we're in do_cow_page() and we spot
that we do have a PTE-mapped THP:
* Count the mappings in the process page table and use that as baseline
 (instead of 1). Would fail if there are additional references.
* Try to split the compound page immediately. Will also fail if there
  are additional references.

COWing more extremely sounds like an interesting idea to free up the
compound page after we fragmented it -- which will succeed once
additional references are gone.

-- 
Thanks,

David / dhildenb

