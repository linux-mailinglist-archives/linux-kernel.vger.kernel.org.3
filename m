Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4915A5D9B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiH3IDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiH3ID1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:03:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1276ED25DA
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661846605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xSV7VY1bq+Nj0WGpDaHmCr7wgHdHGp/Zx8FfKypgW+Y=;
        b=Tu7bYr6mt6JN/+gL8pRj8JN/6XZjEXhEQfd2Xia51TfNn0Sfelyza2syaGy2k7pI+aI0Mk
        G0e9cIqVSa+Ys8FiNMPDQSGgV5EOB6o+ZJDb8Pi5BAQE0RpHiepmKMcFHoMnYh2YGGvvNb
        3qzJ8d2jhHq1gw+fC0055mfy6kk7iiI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-437-yqUhkiOFOfCg6JmjqNe3sw-1; Tue, 30 Aug 2022 04:03:24 -0400
X-MC-Unique: yqUhkiOFOfCg6JmjqNe3sw-1
Received: by mail-wr1-f71.google.com with SMTP id o3-20020adfa103000000b0022514e8e99bso1538810wro.19
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=xSV7VY1bq+Nj0WGpDaHmCr7wgHdHGp/Zx8FfKypgW+Y=;
        b=oN47vnfDRex+2TKBsURqvvilPPnd7wCFD3jtPZx2kOHNi5JVsrVsHTLLkRhCP3Bhit
         m3nI06kE7VVbfWEOcNFZkMFrvjbmd2Jwo1GZsiyCZ01zEkBj9t1JcnPUsCzFHNroY7Im
         qOXGQkOmoWwVi2/Z3rMUoC51JNzo6fuQb21QEJLpTKi4FlVofhk/RCQjx4vPEah93Nul
         taEudE4rdi2GrKCO4u04ktrV9BoOZDDWOWEwyXeVu+dnwSghIPocAbe4evbVfBOeDNPE
         yn0vI2H3aKLnrpNip9GbuGys0Qp3AgVBtVbJLwht17MtndjzAUDZEI4/7c66fIoYMPDK
         xsPA==
X-Gm-Message-State: ACgBeo0HGqbGXL+WLFxoVmSCB4JzifUGjqIIgijrka48eVF4stRI26Pi
        S9pEBiqrbk8ZyA72SiOu851DOnxK4sAMAg9CyNPkG+xG2rVNURNJmju3xl7LIbYUl1heZFzl5CF
        +XIqeqOBtfLwuVByGFVcpsSRc
X-Received: by 2002:a05:6000:60c:b0:220:757a:54a8 with SMTP id bn12-20020a056000060c00b00220757a54a8mr8415652wrb.685.1661846603049;
        Tue, 30 Aug 2022 01:03:23 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5kYhllNyowsxXNRbBSGr72CL2PgWCsQeiOGuKPaFTxf2N3We9Ua52tLi5u3RLh+EKXg21SSg==
X-Received: by 2002:a05:6000:60c:b0:220:757a:54a8 with SMTP id bn12-20020a056000060c00b00220757a54a8mr8415626wrb.685.1661846602721;
        Tue, 30 Aug 2022 01:03:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:1000:ecb4:919b:e3d3:e20b? (p200300cbc70a1000ecb4919be3d3e20b.dip0.t-ipconnect.de. [2003:cb:c70a:1000:ecb4:919b:e3d3:e20b])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600c400f00b003a54f1d007csm11693661wmm.10.2022.08.30.01.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 01:03:22 -0700 (PDT)
Message-ID: <29503bc0-441e-359e-29d0-37ac3c5dff04@redhat.com>
Date:   Tue, 30 Aug 2022 10:03:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] mm: skip reserved page for kmem leak scanning
Content-Language: en-US
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Ke Wang <ke.wang@unisoc.com>
References: <1661483530-11308-1-git-send-email-zhaoyang.huang@unisoc.com>
 <CAGWkznH=Gwr_TDF3=fv+_ZH5P4QN6JXEAtH4DAzNus20pHxyeg@mail.gmail.com>
 <12759ac7-4a6c-89fa-5fd0-914728f6415e@redhat.com>
 <CAGWkznEtFp2+1QLFF-mA0_jhfB48n4oneVXXNvipw3eBYji4kw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAGWkznEtFp2+1QLFF-mA0_jhfB48n4oneVXXNvipw3eBYji4kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.22 04:41, Zhaoyang Huang wrote:
> On Mon, Aug 29, 2022 at 8:19 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 26.08.22 05:23, Zhaoyang Huang wrote:
>>> On Fri, Aug 26, 2022 at 11:13 AM zhaoyang.huang
>>> <zhaoyang.huang@unisoc.com> wrote:
>>>>
>>>> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>>>>
>>>> It is no need to scan reserved page, skip it.
>>>>
>>>> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>>>> ---
>>>>  mm/kmemleak.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>>>> index a182f5d..c546250 100644
>>>> --- a/mm/kmemleak.c
>>>> +++ b/mm/kmemleak.c
>>>> @@ -1471,7 +1471,7 @@ static void kmemleak_scan(void)
>>>>                         if (page_zone(page) != zone)
>>>>                                 continue;
>>>>                         /* only scan if page is in use */
>>>> -                       if (page_count(page) == 0)
>>>> +                       if (page_count(page) == 0 || PageReserved(page))
>>> Sorry for previous stupid code by my faint, correct it here
>>
>> Did you even test the initial patch?
>>
>> I wonder why we should consider this change
>>
>> (a) I doubt it's a performance issue. If it is, please provide numbers
>>     before/after.
> For Android-like SOC systems where AP(cpu runs linux) are one of the
> memory consumers which are composed of other processors such as modem,
> isp,wcn etc. The reserved memory occupies a certain number of
> memory(could be 30% of MemTotal) which makes scan reserved pages
> pointless.

But we only scan the memmap (struct page) here and not the actual
memory. Do you have any performance numbers showing that there is even
an observable change?

>> (b) We'll stop scanning early allocations. As the memmap is usually
>>     allocated early during boot ... we'll stop scanning essentially the
>>     whole mmap and that whole loop would be dead code? What am i
>>     missing?
> memmap refers to pages here? If we can surpass these as it exist
> permanently during life period. Besides, I wonder if PageLRU should
> also be skipped?
> -                       if (page_count(page) == 0)
> +                       if (page_count(page) == 0 ||
> PageReserved(page) || PageLRU(page))

I think we need a really good justification to start poking holes into
the memmap scanner. I'm no expert on this code (and under which
circumstances we actually might find referenced objects in a memmap),
though.

But we should be careful with that.

-- 
Thanks,

David / dhildenb

