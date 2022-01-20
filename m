Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BEE495410
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346559AbiATST5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:19:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50751 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233514AbiATST4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642702795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rKxyIeZW7RYW3u4+X955jRymBZg+th+EIWA7v064V2E=;
        b=cAUtShJbQ+jTNurs/x79rMhXzP44gJ15ynQgkbwKWZyrYtfEIn8O9h/c1Gk7/zZCbWge0p
        MTkvegqKUPPKlSB1Fo1BmDs3tWiXz5Z0O+tTTAUCnr3ye4Tb3Q2kvrz3++i4h3So2jABdi
        RFiM00h8+sYRauNfpCX7fSR2oChB9UU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-c0gIOMpuMJ2JZ6CTwJwVew-1; Thu, 20 Jan 2022 13:19:54 -0500
X-MC-Unique: c0gIOMpuMJ2JZ6CTwJwVew-1
Received: by mail-ed1-f72.google.com with SMTP id z9-20020a05640240c900b003fea688a17eso6676964edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:19:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=rKxyIeZW7RYW3u4+X955jRymBZg+th+EIWA7v064V2E=;
        b=YeVEH95dHj94zxU6bRGjS7s3Gop/fCId4tOB1lPjG5KWJm9tO17Db6vCa96A3kjnZ2
         oa7Fvw4TwIrbJqKXXpEchyvDYOTGsab9ZPmYerMKpz8BRWNW6qejBjzGvbfG95F2WMsB
         u33XClW5S1DHZq0dTswe6rMvQb0zTWDO71ErKIVojrYTa93h0xvSHQIo92U6eKeXcuuy
         +P1CGaKaZH0/06Hb6Ruth5G1vzOzltkQVzI82fQOPUM1SkcU0seaf42F5HfykT0zIbIu
         udK310uBd7rConzNEaNYi6mY3MSMlMXa/o1e4TQTo94VqUzQJvBmpvKnfVXlt+0SUv8f
         Z1Zg==
X-Gm-Message-State: AOAM532StVcUQ5wrmoJA9GPXp24aalSzcVVM8qjEwcBa5BkQC8mRoIiq
        1PHooLg9+ozGCwE6OOhuiIggHxdnt0ypFdDfmPjwqIs6b2icnoBWdtbTLS+oJaTp2oUKRHgyMqH
        6fL4YUkHbfY/XvSmYtwhlqZhn
X-Received: by 2002:a17:907:7d8a:: with SMTP id oz10mr113652ejc.320.1642702792938;
        Thu, 20 Jan 2022 10:19:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwU9TWkRnVmK3HK4zfioqdII11rqxD40tMTTzfgBpEJQdwiaFvEt+7U82gMa0IM1APSiHIlfg==
X-Received: by 2002:a17:907:7d8a:: with SMTP id oz10mr113628ejc.320.1642702792649;
        Thu, 20 Jan 2022 10:19:52 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5800:eeb:dae2:b1c0:f5d1? (p200300cbc70e58000eebdae2b1c0f5d1.dip0.t-ipconnect.de. [2003:cb:c70e:5800:eeb:dae2:b1c0:f5d1])
        by smtp.gmail.com with ESMTPSA id g9sm1287766ejf.33.2022.01.20.10.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 10:19:52 -0800 (PST)
Message-ID: <0b734af9-d2c3-acef-3804-3a87e1e61a59@redhat.com>
Date:   Thu, 20 Jan 2022 19:19:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
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
 <8931808d-db61-0f06-ceb3-f48a83b1f74c@redhat.com>
 <6225EAFF-B323-4DC5-AC4C-885B29ED7261@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <6225EAFF-B323-4DC5-AC4C-885B29ED7261@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Sounds good? At least to me. If only swap/migration entries wouldn't be
>> harder to handle than I'd wish, that's why it's taking a little and will
>> take a little longer.
> 
> Thanks for the quick response. I would have to see the logic to set/clear
> PageAnonExclusive to fully understand how things are handled.
> 

I'll let you know as soon as I have something. I'll most probably share
a document explaining the design first.

> BTW, I just saw this patch form PeterZ [1] that seems to be related, as
> it deals with changing protection on pinned pages.

Unfortunately the use of page_maybe_dma_pinned() is racy, as we can race
with GUP fast. It's a problem for vmscan which currently relies on it
for correctness. For migration, it might be good enough as we should
fail later when trying to freeze the refcount.

> 
> 
> [1] https://lore.kernel.org/linux-mm/20220120160822.666778608@infradead.org/
> 


-- 
Thanks,

David / dhildenb

