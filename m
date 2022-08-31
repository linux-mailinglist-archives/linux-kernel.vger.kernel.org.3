Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371F15A85B8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbiHaSfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbiHaSf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:35:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDDEB72B5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661970554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o5+efHgbk856m97kY2nZ0pKIsJZ0ZgtcFYWEKHNb/1k=;
        b=Z4vQXiklx1AIBTdFdX6V/vantYkOTTUbOJVqpO3fwITr7xfXUtAqtT34bv2WEe/zPysqV1
        HAZmIWW96I0mQdenZr2J6Schgmyh9JXE0c9NFkwrxBLV36Hgvt8zKHJKAIFpOEaBhtG0+Y
        xrbkKZccWcuVh9OSU484Y2mYmCpFcuc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-168-MiHqEr0VPha6Tjh1A2wwkA-1; Wed, 31 Aug 2022 14:29:12 -0400
X-MC-Unique: MiHqEr0VPha6Tjh1A2wwkA-1
Received: by mail-wm1-f70.google.com with SMTP id h82-20020a1c2155000000b003a64d0510d9so8624214wmh.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=o5+efHgbk856m97kY2nZ0pKIsJZ0ZgtcFYWEKHNb/1k=;
        b=lQefRF7ONMIQba2y5tiBBKe3RN0W/fH8rBqRyRrCICoIW6/EyPWcDfSnY1VUXhvXnn
         66q4KaDlCmNVUYLa/zJ/mmzGsZ0Q0IdYMcmhO9yBIakEWJERkc7VMh3WrYsuJAQ2naye
         rU1RGGCz/pSnWd3CwydKEolLHtEIJzfIn3cAZdkrUDmQIVtOajfzWWYexGenIRrilCEq
         jFroxAMOBbe7Gz+0e4h6RnnxFAP49gQ0xk6zDSFA1c1ZMYJAzz3uPhB/SMSkQh84FlL7
         7msYh8c+a9XW2KpT0SFL1UxYqykK+fkpBrgLcAh6vKfAjZN3cbA+TM2QQGygsrEjvnO8
         fFgA==
X-Gm-Message-State: ACgBeo1MWL6UWQwEmVTKfQNx48/UQaBDjsmKnCYW4mt1ZktcJjp4TuD/
        gUHeGo9qYjioNZFMlToJZxlXqq+JoyN1AMiGhqHz61KX+eCLbVJXwuPLYTC6aKIOimLNK2itqFr
        ov0V/GLi4kDAEieam5/AiHdxe
X-Received: by 2002:a05:6000:18ad:b0:226:f3b4:74f2 with SMTP id b13-20020a05600018ad00b00226f3b474f2mr247222wri.537.1661970551394;
        Wed, 31 Aug 2022 11:29:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6b1CP6vzUobUKRfSrXGys01uisogD5RmcznVnLtQsvt+FdrsqO1kr/Pc38ceTZ9cobzZ2wdg==
X-Received: by 2002:a05:6000:18ad:b0:226:f3b4:74f2 with SMTP id b13-20020a05600018ad00b00226f3b474f2mr247211wri.537.1661970551124;
        Wed, 31 Aug 2022 11:29:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:2900:1613:4308:aca3:2786? (p200300cbc706290016134308aca32786.dip0.t-ipconnect.de. [2003:cb:c706:2900:1613:4308:aca3:2786])
        by smtp.gmail.com with ESMTPSA id m5-20020a5d4a05000000b00225213fd4a9sm13151586wrq.33.2022.08.31.11.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 11:29:10 -0700 (PDT)
Message-ID: <4845ae71-b7dd-1707-ebc3-2eb3521e7fa0@redhat.com>
Date:   Wed, 31 Aug 2022 20:29:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20220831083024.37138-1-david@redhat.com>
 <CAHbLzkqeDAnCdt3q4E2RZw64QEzVaO_pseR3VaoHUhB+rZFcZQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1] mm/ksm: update stale comment in write_protect_page()
In-Reply-To: <CAHbLzkqeDAnCdt3q4E2RZw64QEzVaO_pseR3VaoHUhB+rZFcZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.22 19:55, Yang Shi wrote:
> On Wed, Aug 31, 2022 at 1:30 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> The comment is stale, because a TLB flush is no longer sufficient and
>> required to synchronize against concurrent GUP-fast. This used to be true
>> in the past, whereby a TLB flush would have implied an IPI on architectures
>> that support GUP-fast, resulting in GUP-fast that disables local interrupts
>> from completing before completing the flush.
> 
> Hmm... it seems there might be problem for THP collapse IIUC. THP
> collapse clears and flushes pmd before doing anything on pte and
> relies on interrupt disable of fast GUP to serialize against fast GUP.
> But if TLB flush is no longer sufficient, then we may run into the
> below race IIUC:
> 
>          CPU A                                                CPU B
> THP collapse                                             fast GUP
> 
> gup_pmd_range() <-- see valid pmd
> 
> gup_pte_range() <-- work on pte
> clear pmd and flush TLB
> __collapse_huge_page_isolate()
>     isolate page <-- before GUP bump refcount
> 
>    pin the page
> __collapse_huge_page_copy()
>     copy data to huge page
>     clear pte (don't flush TLB)
> Install huge pmd for huge page
> 
> return the obsolete page

Hm, the is_refcount_suitable() check runs while the PTE hasn't been
cleared yet. And we don't check if the PMD changed once we're in
gup_pte_range().

The comment most certainly should be stale as well -- unless there is
some kind of an implicit IPI broadcast being done.

2667f50e8b81 mentions: "The RCU page table free logic coupled with an
IPI broadcast on THP split (which is a rare event), allows one to
protect a page table walker by merely disabling the interrupts during
the walk."

I'm not able to quickly locate that IPI broadcast -- maybe there is one
being done here (in collapse) as well?

-- 
Thanks,

David / dhildenb

