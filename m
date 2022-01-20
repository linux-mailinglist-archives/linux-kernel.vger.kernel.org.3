Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86870495386
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbiATRta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:49:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58661 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232295AbiATRt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642700968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nCG2sPJLK6kzXhJ8UHVqsNF/fPPpVfwzYVA6Udq3IAs=;
        b=Z+Xg7M3ZOEFRwbQQc+nwtZ86mDiREMFXUp5YKkXGg1y5zcuofmuJutsIviQOYYpBK+zKQH
        gWGFxN9A3RD0jqeDkr+D3yIWDIvUCDlvBI+VjjcKLtOuHcg8M4uZuQb5hdkVxY8noa4kNq
        vxJUS6N4Zd1Fkiemt/te9oGIoy6h9oo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-488-QGE3UWSEOJiwQA2ToRMniw-1; Thu, 20 Jan 2022 12:49:26 -0500
X-MC-Unique: QGE3UWSEOJiwQA2ToRMniw-1
Received: by mail-wm1-f70.google.com with SMTP id v185-20020a1cacc2000000b0034906580813so7397632wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=nCG2sPJLK6kzXhJ8UHVqsNF/fPPpVfwzYVA6Udq3IAs=;
        b=DzFkYVSDPmJFexhtOrDYRxDNlLQEJXlddDzKiyV+e0jwumhg/doefVbHhBjwKSlWCg
         6BYQZtkJwK/ZYIjVxjPGSgD5ZB7A8/V8XA/z2zCinUtuGFrhcGCRvI4bwY4Jp1W8Jy+Z
         s2pu//fRoBvq0m+5X+wu9jVrLx/+n8KNtPi0JYt0UrRf5IKvFeNvsV//2CzZBI13OkZH
         acYnCNQZNOAkXPM5uSiiWLH4ruIEAeCJ30mWw0fI1DMwQkP9kDrqQeHhvDTvrgfO9AjX
         vHDkdN4jjxLEnAGmP1f4bkRqg11BTQn51zKzbM5Y4LTj/IaoeFviHl1aFJKhbnSBg54P
         1zng==
X-Gm-Message-State: AOAM533Qkr8Ixg0bt3/kzcS9MMhaPYQI8C/aI2Q6cF8hVyT+9LB1yDLk
        /wk0wULLHsjULEaD1OGXWikOj3Dx4h5eqaeOW1oxpCZHJ+seE2ulWM35F8BeH0M0PADDVyMSg5n
        8ruDt1/dekJcGc5o4zPXFtFld
X-Received: by 2002:a7b:c389:: with SMTP id s9mr10063584wmj.187.1642700965660;
        Thu, 20 Jan 2022 09:49:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwOgrAzOzVk/Tex+x+IQgm2nyqsRrltPt6JVBIbhqjWR5Q/MBuyoXyZStU3JqtYqk+plHRdxw==
X-Received: by 2002:a7b:c389:: with SMTP id s9mr10063554wmj.187.1642700965427;
        Thu, 20 Jan 2022 09:49:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5800:eeb:dae2:b1c0:f5d1? (p200300cbc70e58000eebdae2b1c0f5d1.dip0.t-ipconnect.de. [2003:cb:c70e:5800:eeb:dae2:b1c0:f5d1])
        by smtp.gmail.com with ESMTPSA id w22sm3554602wra.59.2022.01.20.09.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 09:49:24 -0800 (PST)
Message-ID: <605bff5f-1244-af8f-bb2a-c1da0fc4bf7a@redhat.com>
Date:   Thu, 20 Jan 2022 18:49:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "zhangliang (AG)" <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com
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
 <Yel0BXVyj8uvsWJX@casper.infradead.org>
 <e2580cfa-a529-934d-861a-091c4a9714d4@redhat.com>
 <CAHk-=wjBFF_EJHVRe48jAjb7Xwu0aRNejyefzLOAGW_qnNu=-w@mail.gmail.com>
 <43e41259-b228-2a75-e59d-0c6a1e81912f@redhat.com>
 <CAHk-=wirJT_K381J+8AAnOeyEtUuQ=eAwg=EzBJPcN7TyygNbg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
In-Reply-To: <CAHk-=wirJT_K381J+8AAnOeyEtUuQ=eAwg=EzBJPcN7TyygNbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.01.22 18:22, Linus Torvalds wrote:
> On Thu, Jan 20, 2022 at 5:46 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> I'm, not concerned about fork(), I'm concerned about other false positives.
> 
> Without a fork(), you won't have the THP marked for COW, so is it
> really an issue?

Oh sorry, I should have been clearer.

I absolutely agree that there is no way around COW if there are multiple
sharers of a page :) If you fork() and write to a shared page, you have
to expect that THP get split and that you get a copy. No change on that
front.

At this point I'm trying to assess the impact of the change and how to
eventually mitigate it if it turns out to be a real problem.

(I've been spending a lot of time trying to understand all the
complexity, and sometimes my brain is ... a bit overloaded by all of
that. Well, at least I learn a lot ...)

One scenario I have in mind how we can end up easily with R/O mapped
exclusive THP is a simple fork() with an immediate exec(), unmap() or
exit() of the child. Might not be the most efficient way of doing
things, but that doesn't mean that existing user space doesn't rely on
it not happening. Then, of course, there are other ways to read-protect
THP temporarily (mprotect() and friends), where you wouldn't expect to
lose your THP, but it's somewhat a secondary concern most probably .

Obviously, we need another (temporary/speculative) reference on the THP
or writeback to actually split it. I'm *hoping* that it will be so rare
that we really don't care. I decided to always lock the THP in
do_wp_page() to at least handle page migration and swapcache more reliably.

To answer you question: people optimized the reuse case heavily
previously (reuse_swap_page()), and I can see how it might happen. I'm
hoping that it won't matter in practice, but I'd like to at least
document the impact and have some magic solution in sleeve that I can
just pull out when reports start coming in.

> 
>> Here is what I currently have, I hope that makes sense:
> 
> From a quick look, that patch looks fine to me, but there might be
> something I'm missing... And who knows what odd usage patterns there
> might be in this area. The whole odd Android thing with forking that
> zygote process.

Exactly my thoughts. I'm trying to be very careful.

-- 
Thanks,

David / dhildenb

