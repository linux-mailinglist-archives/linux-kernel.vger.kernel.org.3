Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351A44CDCF3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiCDSvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241837AbiCDSvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:51:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8ECF81D683D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646419812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mmu2/MJWkduXbhCk1Ykv/xaI9FSQg18IJV+b9NPI6qk=;
        b=bwjpZed4KZt172BDEQzqPLJoTqWNJqTlJkuKqpjoLOFK5aQUaLAA9QYV+cXvNBR4gZ0IB/
        dFJsq0wFTro4VC9TWlA9ym7ZRnrxItq/O+HoJ8Su//bzckgOPsbelhzlKd6ITs0Wszj2Vb
        pAwOOBmy7EOG8UaovEdrCzmq3UPOyDg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-67xfxQzIPK6XAxwERYROhw-1; Fri, 04 Mar 2022 13:50:11 -0500
X-MC-Unique: 67xfxQzIPK6XAxwERYROhw-1
Received: by mail-wm1-f72.google.com with SMTP id j42-20020a05600c1c2a00b00381febe402eso4033971wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 10:50:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=Mmu2/MJWkduXbhCk1Ykv/xaI9FSQg18IJV+b9NPI6qk=;
        b=2FcvQL2YVTC1d088jBjGTn77lBZuE3tyq14C98lWdVdzm+7zSZ61vTQCw4BaH2UXph
         L2stlOA4C510rM8SwCSCpA6PusV9YCETPTRQ1Or43cwqDY6o9EvvPUVE1nyTwy3FRPwc
         Z6W/at552vLsi3idjx+opkFUn4fbht0nxuSlTuytEIoMx8d4fRt8+B1FjyTkzkO1V1aT
         OIkWBE7Sd0AxrWS3yOzhqUgYFOCSPIjxgkf52qUGHy0qGMiceuZwQXmm/Z+etBxxUVHw
         lLOJif7b5YSaOie5wQ+Q0yTyy5VTEdvDoVt56UUtLDWzspG3b4HaaR/kPmDTP5sOe7h9
         1f4A==
X-Gm-Message-State: AOAM532tQUmTVfuwfK9/GZOBwrfGs6XKowUSuv42gVXq5vXRQAxt81cw
        DLu0RsmsTtdTyQl4743uPZEGfZMTa+myWoAz+l+BD3/QXkLEszdNTa6niKX23a4o9/pEunON6Ay
        JRsAwvXgjLW4pdei68PEhGL/V
X-Received: by 2002:adf:e44b:0:b0:1f0:250a:d3ef with SMTP id t11-20020adfe44b000000b001f0250ad3efmr93705wrm.402.1646419809890;
        Fri, 04 Mar 2022 10:50:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/YyaYNjCSltEDDDSbD09ZoT/SOumsdrUNzVER/VcVldWBZr9luJE8t3fiZySZcHShGgCzOg==
X-Received: by 2002:adf:e44b:0:b0:1f0:250a:d3ef with SMTP id t11-20020adfe44b000000b001f0250ad3efmr93690wrm.402.1646419809640;
        Fri, 04 Mar 2022 10:50:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:4600:7355:df2c:f6ff:94d? (p200300cbc70946007355df2cf6ff094d.dip0.t-ipconnect.de. [2003:cb:c709:4600:7355:df2c:f6ff:94d])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d5406000000b001f049726044sm5203344wrv.79.2022.03.04.10.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 10:50:09 -0800 (PST)
Message-ID: <13ad4ba1-2a88-9459-3995-70af36aba33e@redhat.com>
Date:   Fri, 4 Mar 2022 19:50:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20220303222014.517033-1-shy828301@gmail.com>
 <CADFyXm6W9CVkO4XPYep-tHg55c8m8NES783kcVYrdjSMbzYoDA@mail.gmail.com>
 <CAHbLzkriyBy2HqjssurLSnhoyuUzpJRZjMPNx34MTgxeO0dddg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: thp: don't have to lock page anymore when splitting
 PMD
In-Reply-To: <CAHbLzkriyBy2HqjssurLSnhoyuUzpJRZjMPNx34MTgxeO0dddg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.03.22 19:30, Yang Shi wrote:
> On Thu, Mar 3, 2022 at 9:06 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> Hi,
>>
>> This probably bounces on the list due to html junk from the gmail app.
>>
>> What happened to
>>
>> https://lore.kernel.org/linux-mm/20220131162940.210846-10-david@redhat.com/
>>
>> Included in the very series mentioned below?
>>
>> Was this silently dropped due to folio conversion collisions? :/
> 
> I really didn't notice you already proposed this. Maybe folio
> conversion, maybe mlock cleanup, I can't tell. But anyway this patch
> needs to get rebased. I will submit v2 to solve the comment, will add
> your signed-off-by.
> 

Why a rebase? The folio change comes via another tree (unfortunately not
Andrews tree, I wish we would have a single MM tree for MM patches).

@Andrew, the last mail I received was

+ mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd.patch
added to -mm tree

The patch shows up in mmotm as

#[merged]mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd.patch

... which shouldn't be true.

-- 
Thanks,

David / dhildenb

