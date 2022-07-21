Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E2157CCEA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiGUOK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGUOK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:10:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 701CC481E1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658412655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rDTTu30CW6yuJVbQ/60UukKUOMp8krfp5ZoEixBMzVc=;
        b=RmaM0zuty1fvqD1O/t3vd88KKRhj25LnSupszEN280YbI9PZaWOI0ZvP1CyNS0FXrTeEwk
        ABtA8HNL+tLAwpy+wCO8fbBUFKfDiamyg8ymDof1qkRLMrrfHolOEQpO6CLNqUBVr0U/qZ
        qtfIPLq/x39xHdmuV4aLM76uJVcG/a4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-365-C_4hm5t7Nouoa0k-tAzOjQ-1; Thu, 21 Jul 2022 10:10:54 -0400
X-MC-Unique: C_4hm5t7Nouoa0k-tAzOjQ-1
Received: by mail-wr1-f71.google.com with SMTP id t13-20020adfe10d000000b0021bae3def1eso376131wrz.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:to:cc:references:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=rDTTu30CW6yuJVbQ/60UukKUOMp8krfp5ZoEixBMzVc=;
        b=u+X7OZslPnE4ud5HHBTWMc8/NeFjPlzqdAcVU+TbAiKImSt37z6qp6p1X4e8VFnD+8
         96+iiMma6Zg7bsJ3ilEDYGpW8o4tumZXz2F2m9hRC0L6JrzOKi/zMjwfQyufVjLwKicK
         BBI0zC550I3tjG5LwrTW95aJSgOLL9YOYEv860mQpLXSu8y3BIRZJHCg/kuXNVISsS75
         Rk+6qpCvAF9xaaijiN81JSafE3q9NFh7xg2vmhoKQnIYTy2YHioQD2KxFe/IICOwQCyq
         +210pnWDdjQ7J7x1WUuxZjG1DXxOjtbJsMiRBQzTe/rUEMYPZUw0vmW7UTN2A2uQh0M8
         jkbg==
X-Gm-Message-State: AJIora9vsT+A0bkvT4ERw6e29diczP5/IoUDMB0leEHzUfTafoqcrMVD
        8iX4c9afV2fYDLPIEu2N6cgzM2o4sIxODBYu63lQfWgrtojqZn/7L+OnBfUg6lRqOmeb3mN4DTx
        sjVrv0RdPcDNRainlDeXiWy6I
X-Received: by 2002:a7b:c7d2:0:b0:3a3:209d:cdc6 with SMTP id z18-20020a7bc7d2000000b003a3209dcdc6mr8649596wmk.55.1658412652696;
        Thu, 21 Jul 2022 07:10:52 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vpPVSt5eQQkxyxRPFJ6jginy3ckuXzWnSclnptMjXfdA4Nd/j5PEpqKX37REEkffQhXExeEA==
X-Received: by 2002:a7b:c7d2:0:b0:3a3:209d:cdc6 with SMTP id z18-20020a7bc7d2000000b003a3209dcdc6mr8649580wmk.55.1658412652388;
        Thu, 21 Jul 2022 07:10:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:e000:25d3:15fa:4c8b:7e8d? (p200300cbc707e00025d315fa4c8b7e8d.dip0.t-ipconnect.de. [2003:cb:c707:e000:25d3:15fa:4c8b:7e8d])
        by smtp.gmail.com with ESMTPSA id d5-20020adff845000000b0021dd08ad8d7sm2133349wrq.46.2022.07.21.07.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 07:10:51 -0700 (PDT)
Message-ID: <7a6b346a-9225-c6f4-aca4-93c588b6917e@redhat.com>
Date:   Thu, 21 Jul 2022 16:10:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Peter Xu <peterx@redhat.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>
References: <20220718120212.3180-1-namit@vmware.com>
 <20220718120212.3180-2-namit@vmware.com> <YtcYVMoSRVxRH70Z@xz-m1.local>
 <017facf0-7ef8-3faf-138d-3013a20b37db@redhat.com>
 <Ytf+zIxVPTVXTZdp@xz-m1.local>
 <2b4393ce-95c9-dd3e-8495-058a139e771e@redhat.com>
 <YthUYF3invrjlzUc@xz-m1.local>
 <69022bad-d6f1-d830-224d-eb8e5c90d5c7@redhat.com>
 <YthcC78q1hdd7mNT@xz-m1.local>
 <4ad140b5-1d5b-2486-0893-7886a9cdfd76@redhat.com>
 <95320077-52CF-4CB0-92F9-523E1AE74A3D@gmail.com>
 <468a7114-7541-0d5e-c1fc-083bbb95e78d@redhat.com>
 <F56D4014-7FE2-4C60-9CFA-A7E7B684098B@gmail.com>
 <8e2dcae3-5f50-cd59-7588-b8f566549ad4@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 01/14] userfaultfd: set dirty and young on
 writeprotect
In-Reply-To: <8e2dcae3-5f50-cd59-7588-b8f566549ad4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.07.22 09:52, David Hildenbrand wrote:
>>> Yes. Especially for any MAP_PRIVATE mappings.
>>>
>>> If you want to write to something that's not mapped writable in a
>>> MAP_PRIVATE mapping it
>>> a) Has to be an exclusive anonymous page
>>> b) The pte has to be dirty
>>
>> Do you need both conditions to be true? I thought (a) is sufficient (if
>> the soft-dirty and related checks succeed).
> 
> If we force-write to a page, we need it to be dirty to tell reclaim code
> that the content stale. We can either mark the pte dirty manually, or
> just let the write fault handler deal with it to simplify GUP code. This
> needs some more thought, but that's my understanding.

Extending on my previous answer after staring at the code

a) I have to dig if the FOLL_FORCE special-retry-handling is required
for MAP_SHARED at all.

check_vma_flags() allows FOLL_FORCE only on MAP_PRIVATE VMAs that lack
VM_WRITE.

Consequently, I would have assumed that the first write fault should be
sufficient on a MAP_SHARED VMA to actually map the PTE writable and not
require any of that special retry magic.


b) I wonder if we have to take care of uffd-wp and softdirty (just like
in mprotect code here) as well in case we stumble over an exclusive
anonymous page. Yes, the VMA is currently not writable, but I'd have
expected at least softdirty tracking to apply.

... I'll dig into the details.

-- 
Thanks,

David / dhildenb

