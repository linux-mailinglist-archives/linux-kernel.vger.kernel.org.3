Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA95A4951CB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376807AbiATPvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:51:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41902 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376718AbiATPvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:51:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642693911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CoYY5viRTf6GNH+jXrDipEksbJM4x4BdIORqy3eZioQ=;
        b=Yzvo8ybZMSTCnbAM+ROZuisisTlX/zpk/xPWAK41tvU4XEDoRtnQxc5Jn+cuP7hm72hLkC
        8i2tygT6SsMsED5qnD8sykP4PRwfVewlVc8A5XxrjEXbunDW7AO+B9Ev2LApSvf+hU6aLz
        EFEa+8UdkiwONykVyCiqHJUCtpSFNCk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-037anfH2NHivNCGBeYTCYw-1; Thu, 20 Jan 2022 10:51:50 -0500
X-MC-Unique: 037anfH2NHivNCGBeYTCYw-1
Received: by mail-ed1-f70.google.com with SMTP id h21-20020aa7c955000000b0040390b2bfc5so6256085edt.15
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:51:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=CoYY5viRTf6GNH+jXrDipEksbJM4x4BdIORqy3eZioQ=;
        b=Q0DjrEp3FMJnSYuhvK8MZt7GItFhsLexGN0z57AoTQKA53JxZJfK5QkOljXqj281am
         SzqsBh7NFkWO3xo05jkLOPNY91OTxwyDe0sPtIZEDYjPxh3BnBydRYDwPxXGp6e6Mff/
         gEVGy15GVQNlEGOyMN4QbMXi2ux0NRF1YNgNI1nk91F5gsWLzrU5AmRYCHlsu2wAUJQA
         ErzF+jgTnwR9UCj3mD06AwVQ3AFcR0WLBKcjblKJVW6yNvc/IvvnbWJflXLrUSkNPdvd
         xher8/nVQRm5PD0Z02ldIP5j61HKzAfhdEkGUxpb2gZFUNiyE9yhNwOG8U274M180pIx
         3y0g==
X-Gm-Message-State: AOAM530B2cZdgLWPTP8b3Vl7Y21xEA2Ag1PJ2a8Rqa4GKIVQ48bVScH7
        qFDr8ryHp3MiDr3CQCPRxyWh/5Vb4zlCysLaQBKKX3dSpy+iGsyvwOmID9nAzkss8Fx+oV3XqTw
        CF8vzCnVs9nI9L4ditXu4n1Pe
X-Received: by 2002:a05:6402:4406:: with SMTP id y6mr19755879eda.223.1642693908821;
        Thu, 20 Jan 2022 07:51:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcWYPWw0qlk/R3upaiwvY2ZgKVUs8+1u3TPq9D7w89gknnCekiLfKaMoADb7owdWhHRLMnvA==
X-Received: by 2002:a05:6402:4406:: with SMTP id y6mr19755861eda.223.1642693908646;
        Thu, 20 Jan 2022 07:51:48 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5800:eeb:dae2:b1c0:f5d1? (p200300cbc70e58000eebdae2b1c0f5d1.dip0.t-ipconnect.de. [2003:cb:c70e:5800:eeb:dae2:b1c0:f5d1])
        by smtp.gmail.com with ESMTPSA id b2sm1461596edu.84.2022.01.20.07.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 07:51:48 -0800 (PST)
Message-ID: <88a8b1a3-232d-df9c-d7f6-0ea9f2dd4b36@redhat.com>
Date:   Thu, 20 Jan 2022 16:51:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "zhangliang (AG)" <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <a93988da-80fb-dd32-4717-a6a0bae9e4ee@huawei.com>
 <dc415c4a-63aa-19b0-0fbc-795989970f6d@redhat.com>
 <fb02087a-b102-c91e-ab65-fb02cc8ee0a2@huawei.com>
 <9cd7eee2-91fd-ddb8-e47d-e8585e5baa05@redhat.com>
 <b6df4f7f-c080-ad6c-d1ad-098115f016f3@huawei.com>
 <747ff31c-6c9e-df6c-f14d-c43aa1c77b4a@redhat.com>
 <Yel0BXVyj8uvsWJX@casper.infradead.org>
 <e2580cfa-a529-934d-861a-091c4a9714d4@redhat.com>
 <YemBl4ZVtJqtAVwV@casper.infradead.org>
 <759f9bc8-0b10-7f0f-28a6-f292bed9053f@redhat.com>
 <YemDry2rkD2VUcw9@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YemDry2rkD2VUcw9@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Yes, we are talking past each other and no, I am talking about fully
>> mapped THP, just mapped via PTEs.
>>
>> Please refer to our THP COW logic: do_huge_pmd_wp_page()
> 
> You're going to have to be a bit more explicit.  That's clearly handling
> the case where there's a PMD mapping.  If there is _also_ a PTE mapping,
> then obviously the page is mapped more than once and can't be reused!
> 
>>>
>>>>> Anon THP is always going to start out aligned (and can be moved by
>>>>> mremap()).  Arguably it should be broken up if it's moved so it can be
>>>>> reformed into aligned THPs by khugepaged.
>>>>
>>>> Can you elaborate, I'm missing the point where something gets moved. I
>>>> don't care about mremap() at all here.
>>>>
>>>>
>>>> 1. You have a read-only, PTE mapped THP
>>>> 2. Write fault on the THP
>>>> 3. We PTE-map the THP because we run into a false positive in our COW
>>>>    logic to handle COW on PTE
>>>> 4. Write fault on the PTE
>>>> 5. We always have to COW each and every sub-page and can never reuse,
>>>>    because page_count() > 1
>>>>
>>>> That's essentially what reuse_swap_page() tried to handle before.
>>>> Eventually optimizing for this is certainly the next step, but I'd like
>>>> to document which effect the removal of reuse_swap_page() will have to THP.
>>>
>>> I'm talking about step 0.  How do we get a read-only, PTE-mapped THP?
>>> Through mremap() or perhaps through an mprotect()/mmap()/munmap() that
>>> failed to split the THP.
>>
>> do_huge_pmd_wp_page()
> 
> I feel you could be a little more verbose about what you think is
> going on here.  Are you talking about the fallback: path where we
> call __split_huge_pmd()?

Sorry, I was less verbose because I was just sending out the
patch+description to Linus' reply and was assuming you're going to read
it anyways ;)

Yes, I'm speaking about exactly that fallback path.

-- 
Thanks,

David / dhildenb

