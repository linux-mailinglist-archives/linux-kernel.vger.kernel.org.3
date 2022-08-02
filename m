Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17943588344
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 22:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiHBU7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 16:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiHBU7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 16:59:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED47F3336E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 13:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659473989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FlYyxUq4TBUO2ujDZlR7hAoRGaLEjsFsfXjHZjjIh3c=;
        b=GMruv6UyrD0d+o8CXYqpExNtj8zfiIXWj0qKF+svde+jw3MdsJ2SvKjBiOHaIiYPSGRS63
        Xn4R9ZB+LuRHpTa94x53hDU80TZVsPaAHZAGuRyCjkZSXqyfgZTl2+uNOYCm4Gx8NKCNtp
        whlbJ7TIlgbZ3JDrj4WVnp3dTfeu0Po=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-AA8LMfvzOaa1ce9v3u8eSg-1; Tue, 02 Aug 2022 16:59:45 -0400
X-MC-Unique: AA8LMfvzOaa1ce9v3u8eSg-1
Received: by mail-wm1-f72.google.com with SMTP id v64-20020a1cac43000000b003a4bea31b4dso5110261wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 13:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=FlYyxUq4TBUO2ujDZlR7hAoRGaLEjsFsfXjHZjjIh3c=;
        b=7095FO7TW0w+jPS08FK/xqOFyJW+8f6dQZTIgEiAK5/TNNH+0h8GSJ/YFu4gNMst1U
         WEO64nH4BZKxA5iuNsS8HQqJM+v62Xj2j5BtTmOcXVs6Nu55QeTWzyhFKE0QccyWcyso
         rupyerCmzHi2dx/XIYIrapF4TwWQipVdEdD1lQwUFUcoeAjHed3qOvanN1A9bcZEfZ8u
         sdlHgldLT5DwEffYO6boHFiyDJGENQmJ3dRFaI84Vobi9zgU6/C7eyDY81921RHERDg3
         MVflh8iw8sYHgW/VwWyCb/E/0H5bRf46XB05XG1kGhKkFMfJznPqkJayRGbx/BecdoQH
         +vlA==
X-Gm-Message-State: ACgBeo0h9C+aUm/iAuANN/sAGfRsKNYbbeweBPcJbC9DiKJTn75DcKB5
        HTjVj98RFxanbRc6j+sJ6yewyFCAIj4sX47OUGsPBNvrxngODD/TeY1KWbsv291FVtOMWGypECF
        x5Tfx7ZoirFzNbC76b6QFZbWx
X-Received: by 2002:a05:6000:18a2:b0:21d:bc7c:1c83 with SMTP id b2-20020a05600018a200b0021dbc7c1c83mr13941208wri.420.1659473983942;
        Tue, 02 Aug 2022 13:59:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6NvLMSUgfym6qig+NNK7JeAaiHpc6m+XOmwm4mwjmY8k0qE+y0bjE9xFGipim2nNc0Tbk69g==
X-Received: by 2002:a05:6000:18a2:b0:21d:bc7c:1c83 with SMTP id b2-20020a05600018a200b0021dbc7c1c83mr13941195wri.420.1659473983636;
        Tue, 02 Aug 2022 13:59:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3800:8435:659e:f80:9b3d? (p200300cbc70738008435659e0f809b3d.dip0.t-ipconnect.de. [2003:cb:c707:3800:8435:659e:f80:9b3d])
        by smtp.gmail.com with ESMTPSA id k41-20020a05600c1ca900b003a2e5f536b3sm26163056wms.24.2022.08.02.13.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 13:59:43 -0700 (PDT)
Message-ID: <4f876ff0-c6d2-2ebb-5917-dc1ff98fa8b0@redhat.com>
Date:   Tue, 2 Aug 2022 22:59:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20220729014041.21292-1-peterx@redhat.com>
 <f23b71e5-a5f5-bb39-dbec-3e85af344185@redhat.com>
 <YuhVJmSsgs4Q1bYJ@xz-m1.local>
 <49434bea-3862-1052-2993-8ccad985708b@redhat.com>
 <YumFs0jpCc/Mwjzf@xz-m1.local>
 <24ffea6e-ca66-2b94-c682-48a42a655fd1@redhat.com>
 <YumKlqjv8PaafpER@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC 0/4] mm: Remember young bit for migration entries
In-Reply-To: <YumKlqjv8PaafpER@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.08.22 22:35, Peter Xu wrote:
> On Tue, Aug 02, 2022 at 10:23:49PM +0200, David Hildenbrand wrote:
>>> I don't think we only care about x86_64?  Should other archs have the same
>>> issue as long as there's the hardware young bit?
>>>
>>> Even without it, it'll affect page reclaim logic too, and that's also not
>>> x86 only.
>>
>> Okay, reading the cover letter and looking at the code my understanding
>> was that x86-64 is the real focus.
>>
>>>>
>>>>>
>>>>> Besides I actually have a question on the anon exclusive bit in the swap
>>>>> pte: since we have that anyway, why we need a specific migration type for
>>>>> anon exclusive pages?  Can it be simply read migration entries with anon
>>>>> exclusive bit set?
>>>>
>>>> Not before all arch support pte_swp_mkexclusive/pte_swp_exclusive/.
>>>>
>>>> As pte_swp_mkexclusive/pte_swp_exclusive/ only applies to actual swap
>>>> PTEs, you could even reuse that bit for migration entries and get at
>>>> alteast the most relevant 64bit architectures supported easily.
>>>
>>> Yes, but I think having two mechanisms for the single problem can confuse
>>> people.
>>>
>>
>> It would be one bit with two different meanings depending on the swp type.
>>
>>> IIUC the swap bit is already defined in major archs anyway, and since anon
>>> exclusive bit is best-effort (or am I wrong?..), I won't worry too much on
>>
>> It kind-of is best effort, but the goal is to have all archs support it.
>>
>> ... just like the young bit here?
> 
> Exactly, so I'm also wondering whether we can move the swp pte anon
> exclusive bit into swp entry.  It just sounds weird to have them defined in
> two ways.

I'd argue it's just the swp vs. nonswp difference that are in fact two
different concepts (device+offset vs. type+pte). And some dirty details
how swp entries are actually used.

With swp entries you have to be very careful, for example, take a look
at radix_to_swp_entry() and swp_to_radix_entry(). That made me refrain
from touching anything inside actual swp entries and instead store it in
the pte.

> 
>>
>>> archs outside x86/arm/ppc/s390 on having anon exclusive bit lost during
>>> migrations, because afaict the whole swap type of ANON_EXCLUSIVE_READ is
>>> only servicing that very minority.. which seems to be a pity to waste the
>>
>> I have a big item on my todo list to support all, but I have different
>> priorities right now.
>>
>> If there is no free bit, simply steal one from the offset ... which is
>> the same thing your approach would do, just in a different way, no?
>>
>>> swp type on all archs even if the archs defined swp pte bits just for anon
>>> exclusive.
>>
>> Why do we care? We walk about one type not one bit.
> 
> The swap type address space is still limited, I'd say we should save when
> possible.  I believe people caring about swapping care about the limit of
> swap devices too.  If the offset can keep it, I think it's better than the

Ehm, last time I did the math I came to the conclusion that nobody
cares. Let me redo the math:

MAX_SWAPFILES = 1<<5 - 1 - 1 - 4 - 3 - 1 = 22

Which is the worst case right now with all kinds of oddity compiled in
(sorry CONFIG_DEVICE_PRIVATE).

So far nobody complaint.

> swap type.  De-dup either the type or the swap pte bit would be nicer, imho.
> 

If you manage bits in the pte manually, you might be able to get a
better packing density, if bits are scattered around. Just take a look
at the x86_64 location of _PAGE_SWP_EXCLUSIVE.

What I'm rooting for is something like

#define pte_nonswp_mkyoung pte_swp_mkexclusive

Eventually with some VM_BUG_ONs to make sure people call it on the right
swp ptes.

If we ever want to get rid of SWP_MIGRATION_READ_EXCLUSIVE (so people
can have 23 swap devices), and eventually have separate bits for both.
For now it's not necessary.

-- 
Thanks,

David / dhildenb

