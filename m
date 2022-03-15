Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A424DA302
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245232AbiCOTJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245487AbiCOTJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:09:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79EAADA9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647371267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fBJf1R7kBM9gH+xhtNa/kOhtVdAYjEafv1mIR3CkHEI=;
        b=a02ENoeAkU4H1SxZNuyf7cP0Rqd3nz3Nz1EWmF8nCz3aleTwmNLpN8V2YdlMaWeXn7zqb/
        A+Fc/A+yBoU8P3SS1WOTK41LK2/DV6UzTa54p4+RnqhSaU7pb3sJLj8WOShX+vwKqLIT1K
        LUn3wX3zqZNeIx/LMJT0O7tKsKjvKfI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-488-Y4HYs6etMH-c-cgy4F4Y0w-1; Tue, 15 Mar 2022 15:07:46 -0400
X-MC-Unique: Y4HYs6etMH-c-cgy4F4Y0w-1
Received: by mail-wr1-f69.google.com with SMTP id a16-20020adff7d0000000b001f0473a6b25so5646306wrq.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:07:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=fBJf1R7kBM9gH+xhtNa/kOhtVdAYjEafv1mIR3CkHEI=;
        b=Qbq1waiA93gl6cJsaw0lbcexMShxYMwf5vcK3B5zjfYJI6p6+ziT7BqeLrdCvjpFfy
         rhJWIdQyRlShlcfw2DR/3SLzppyFQX6zh2VnDZ9JsXDxN+OSpXk7/bLab9Opzw6ruYjT
         dgzqa4XS438VVrKiyRtZAMoleUmhJ0QImEfJmnFS88W+58jwGPaMmSFAcU15tsJaTW73
         y1PsGTB8bkr/wFgS0Q1uBKkj5E0MRUcABk+HY+GUQt7e/q4ezDZ2aIQ1biJZpou+Gxuk
         MIE/X7G/aQZp4RIiNVVW/SrUNX8eQc6hmKfx/vFE8WJ+6V8PrbkoSJQrE4JgHI7GzRuP
         bNzw==
X-Gm-Message-State: AOAM531yzbY21jWDgSbnao4O/AXxjynR/0Ebg3rwEhOFUqsz3LIH06dQ
        LWdVANBLSAl+ZGw/kzRgmIaueMWu6G3KuWknDxrXYmFmtWjxTajoYyjR4ZXMM6LDzkK7kpv4M5Z
        jhT+QwozVco8+ha4b0I2cNGgK
X-Received: by 2002:a05:600c:1c9f:b0:389:cf43:da64 with SMTP id k31-20020a05600c1c9f00b00389cf43da64mr4480395wms.206.1647371264797;
        Tue, 15 Mar 2022 12:07:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyzLlJbwR1xveI8URJ60kP+00Vz8I0FYYiVHPL3IeEWq8UXFCK8AWIjfhzlGgS3nbkP0cs5A==
X-Received: by 2002:a05:600c:1c9f:b0:389:cf43:da64 with SMTP id k31-20020a05600c1c9f00b00389cf43da64mr4480382wms.206.1647371264585;
        Tue, 15 Mar 2022 12:07:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:1800:42bd:3cac:d22a:3c62? (p200300cbc708180042bd3cacd22a3c62.dip0.t-ipconnect.de. [2003:cb:c708:1800:42bd:3cac:d22a:3c62])
        by smtp.gmail.com with ESMTPSA id b15-20020adfc74f000000b001e888b871a0sm16915200wrh.87.2022.03.15.12.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 12:07:43 -0700 (PDT)
Message-ID: <a39c3fe4-3309-dbc4-77f9-f797e3131feb@redhat.com>
Date:   Tue, 15 Mar 2022 20:07:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] mm/migrate: fix race between lock page and clear
 PG_Isolated
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrew Yang <andrew.yang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Howells <dhowells@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Yang Shi <shy828301@gmail.com>, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Nicholas Tang <nicholas.tang@mediatek.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
References: <20220315030515.20263-1-andrew.yang@mediatek.com>
 <20220314212127.a2797926ee0ef8a7ad05dcaa@linux-foundation.org>
 <4cb789a5-c49c-f095-1f7e-67be65ba508a@redhat.com>
 <YjDQRdShE6syVSnM@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YjDQRdShE6syVSnM@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.22 18:43, Matthew Wilcox wrote:
> On Tue, Mar 15, 2022 at 04:45:13PM +0100, David Hildenbrand wrote:
>> On 15.03.22 05:21, Andrew Morton wrote:
>>> On Tue, 15 Mar 2022 11:05:15 +0800 Andrew Yang <andrew.yang@mediatek.com> wrote:
>>>
>>>> When memory is tight, system may start to compact memory for large
>>>> continuous memory demands. If one process tries to lock a memory page
>>>> that is being locked and isolated for compaction, it may wait a long time
>>>> or even forever. This is because compaction will perform non-atomic
>>>> PG_Isolated clear while holding page lock, this may overwrite PG_waiters
>>>> set by the process that can't obtain the page lock and add itself to the
>>>> waiting queue to wait for the lock to be unlocked.
>>>>
>>>> CPU1                            CPU2
>>>> lock_page(page); (successful)
>>>>                                 lock_page(); (failed)
>>>> __ClearPageIsolated(page);      SetPageWaiters(page) (may be overwritten)
>>>> unlock_page(page);
>>>>
>>>> The solution is to not perform non-atomic operation on page flags while
>>>> holding page lock.
>>>
>>> Sure, the non-atomic bitop optimization is really risky and I suspect
>>> we reach for it too often.  Or at least without really clearly
>>> demonstrating that it is safe, and documenting our assumptions.
>>
>> I agree. IIRC, non-atomic variants are mostly only safe while the
>> refcount is 0. Everything else is just absolutely fragile.
> 
> We could add an assertion ... I just tried this:
> 
> +++ b/include/linux/page-flags.h
> @@ -342,14 +342,16 @@ static __always_inline                                                    \
>  void __folio_set_##lname(struct folio *folio)                          \
>  { __set_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }         \
>  static __always_inline void __SetPage##uname(struct page *page)                \
> -{ __set_bit(PG_##lname, &policy(page, 1)->flags); }
> +{ VM_BUG_ON_PGFLAGS(atomic_read(&policy(page, 1)->_refcount), page);   \
> +  __set_bit(PG_##lname, &policy(page, 1)->flags); }
> 
>  #define __CLEARPAGEFLAG(uname, lname, policy)                          \
>  static __always_inline                                                 \
>  void __folio_clear_##lname(struct folio *folio)                                \
>  { __clear_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }       \
>  static __always_inline void __ClearPage##uname(struct page *page)      \
> -{ __clear_bit(PG_##lname, &policy(page, 1)->flags); }
> +{ VM_BUG_ON_PGFLAGS(atomic_read(&policy(page, 1)->_refcount), page);   \
> +  __clear_bit(PG_##lname, &policy(page, 1)->flags); }
> 
>  #define TESTSETFLAG(uname, lname, policy)                              \
>  static __always_inline                                                 \
> 
> ... but it dies _really_ early:
> 
> (gdb) bt
> #0  0xffffffff820055e5 in native_halt ()
>     at ../arch/x86/include/asm/irqflags.h:57
> #1  halt () at ../arch/x86/include/asm/irqflags.h:98
> #2  early_fixup_exception (regs=regs@entry=0xffffffff81e03cf8,
>     trapnr=trapnr@entry=6) at ../arch/x86/mm/extable.c:283
> #3  0xffffffff81ff243c in do_early_exception (regs=0xffffffff81e03cf8,
>     trapnr=6) at ../arch/x86/kernel/head64.c:419
> #4  0xffffffff81ff214f in early_idt_handler_common ()
>     at ../arch/x86/kernel/head_64.S:417
> #5  0x0000000000000000 in ?? ()
> 
> and honestly, I'm not sure how to debug something that goes wrong this
> early.  Maybe I need to make that start warning 5 seconds after boot
> or only if we're not in pid 1, or something ...

Maybe checking for "system_state >= SYSTEM_RUNNING" or "system_state >=
SYSTEM_SCHEDULING" to exclude early boot where no (real) concurrency is
happening. But I assume you'll still get plenty of such reports.

-- 
Thanks,

David / dhildenb

