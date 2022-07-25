Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A2B580083
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbiGYOL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 10:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiGYOL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:11:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF070AE45
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658758285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/iwb85TjmRaVZHGqzyek+VGRdYMNOqw3oLLy+2G9Arc=;
        b=gsUaJtW03JBCUJKlMBQ9aMdrFSN9hd6ez1ggDg4i2LnIpYGksYC+XKXYvGTaqqLMNTIDDW
        qZHzUeNa+igQQYTWZSqzZZlK/EFzrfINkRCt4z1QMG+cF4/JX0SOTVwa+SW9wZPHG5AlpM
        i5CI8oAoYUpwplb+rnsnJQt6IhQb8+E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-T6Bb1N__MMy4e3QgZxe3Ng-1; Mon, 25 Jul 2022 10:11:22 -0400
X-MC-Unique: T6Bb1N__MMy4e3QgZxe3Ng-1
Received: by mail-wm1-f69.google.com with SMTP id f21-20020a1cc915000000b003a3551598a1so1187783wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=/iwb85TjmRaVZHGqzyek+VGRdYMNOqw3oLLy+2G9Arc=;
        b=8SLLz6YmOuC1kOaL4ew72xHNtKc/Bd2GnkLG0Ikh4zWGcYgbQRoditl+hnL+ULh2PO
         sNNAp1zlRIi5gIMgaMtrC3RdRvCRDHi7cJhWEbfNPWTY7t71A7vU6oE6UlDtNQyPXEJw
         pzbthSr7BOYxew54t5siVuvEAftone/M1OFynCHX3q9Ka5KhVi2tz/Y3iTJNHxdy7d6T
         sNTET5M1VZqesrLJIl6W/zod2exQKqIqHMylul6uLqPN3/UWsn/8KZ0x66caIzY8oYWo
         YBOSIS5M06pDyX3Gv5UfSxtKK/vzvyHHNMmtc8OgcTMt7SOzINzVR65i+VvKWlpIso2I
         leUg==
X-Gm-Message-State: AJIora/Rw4WWsJEQm40LT9pojVnTY5wJkxYsdEEv0ZCkP5U7E+LNNjIS
        iPTMVxTkRg1SlXAomtXq7EX25jUmpeV40LzrcAm0vTI1e9blGR6P3ofpe3+VLWE3iWp62aUVyAz
        3CmleJI+nKyXV4n5Ch/BeMA9r
X-Received: by 2002:a05:600c:3556:b0:3a3:2a9c:f26 with SMTP id i22-20020a05600c355600b003a32a9c0f26mr19871521wmq.58.1658758281137;
        Mon, 25 Jul 2022 07:11:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vtzG0CN2yUQ1pX5yQ/a+vnliMtb9S4rjw1rsrqoCvHi/aPRiJTlaroNrJ3ayyb9sZ2T0ejBw==
X-Received: by 2002:a05:600c:3556:b0:3a3:2a9c:f26 with SMTP id i22-20020a05600c355600b003a32a9c0f26mr19871495wmq.58.1658758280645;
        Mon, 25 Jul 2022 07:11:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:8c00:eee4:63f0:cef2:5ac0? (p200300cbc7048c00eee463f0cef25ac0.dip0.t-ipconnect.de. [2003:cb:c704:8c00:eee4:63f0:cef2:5ac0])
        by smtp.gmail.com with ESMTPSA id q12-20020adff50c000000b0021e5757fb4csm11192877wro.88.2022.07.25.07.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 07:11:20 -0700 (PDT)
Message-ID: <1b574e20-26f3-fb3e-69d2-21f35c9e4730@redhat.com>
Date:   Mon, 25 Jul 2022 16:11:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/3] mm/mprotect: Fix soft-dirty check in
 can_change_pte_writable()
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, Nadav Amit <nadav.amit@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20220721183338.27871-1-peterx@redhat.com>
 <20220721183338.27871-2-peterx@redhat.com>
 <e35e42ce-e942-141d-09e7-a3a7868f4abb@redhat.com>
 <C2910936-FDCF-4ECF-B014-D985284B225A@gmail.com>
 <Yt6htg03lqj7FFU2@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Yt6htg03lqj7FFU2@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.07.22 15:59, Peter Xu wrote:
> On Fri, Jul 22, 2022 at 10:21:00AM -0700, Nadav Amit wrote:
>> On Jul 22, 2022, at 12:08 AM, David Hildenbrand <david@redhat.com> wrote:
>>
>>>> +static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
>>>> +{
>>>> +	/*
>>>> +	 * NOTE: we must check this before VM_SOFTDIRTY on soft-dirty
>>>> +	 * enablements, because when without soft-dirty being compiled in,
>>>> +	 * VM_SOFTDIRTY is defined as 0x0, then !(vm_flags & VM_SOFTDIRTY)
>>>> +	 * will be constantly true.
>>>> +	 */
>>>> +	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
>>>> +		return false;
>>>> +
>>>> +	/*
>>>> +	 * Soft-dirty is kind of special: its tracking is enabled when the
>>>> +	 * vma flags not set.
>>>> +	 */
>>>> +	return !(vma->vm_flags & VM_SOFTDIRTY);
>>>> +}
>>>
>>> That will come in handy in other patches I'm cooking.
>>
>> clear_refs_write() also comes to mind as well (for consistency; I see no
>> correctness or performance issue).
> 
> I explicitly didn't touch that because current code is better..
> 
>         mas_for_each(&mas, vma, ULONG_MAX) {
>                 if (!(vma->vm_flags & VM_SOFTDIRTY))
>                         continue;
>                 vma->vm_flags &= ~VM_SOFTDIRTY;
>                 vma_set_page_prot(vma);
>         }
> 
> It means when !CONFIG_MEM_SOFT_DIRTY the "if" will always be true and all
> vma will be jumped.
> 
> If replaced with vma_soft_dirty_enabled() it'll be instead constantly false
> returned.  We'll redo vma_set_page_prot() even if unnecessary.
> 
> Here if we want to add the "CONFIG_MEM_SOFT_DIRTY" into equation it can be:
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index f8cd58846a28..ab6f2913b5a5 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1290,6 +1290,8 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
>                 }
>  
>                 if (type == CLEAR_REFS_SOFT_DIRTY) {
> +                       if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
> +                               goto out_unlock;
>                         mas_for_each(&mas, vma, ULONG_MAX) {
>                                 if (!(vma->vm_flags & VM_SOFTDIRTY))
>                                         continue;
> 
> Or even at the entrance to not take the mm sem.  But it's not anything
> important IMHO, so if no one asking for that I'll just leave it be.


Yeah, I don't think we particularly care about that.


-- 
Thanks,

David / dhildenb

