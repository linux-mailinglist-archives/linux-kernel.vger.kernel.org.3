Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCE55AA826
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiIBGjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbiIBGjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:39:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725E7BB6B7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 23:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662100751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=smA4UY8sXEdNIEMlZ16VEJW1RuVtIcLIqTxA8bYdNhs=;
        b=Uh7r5BvjCdQQRbWggiECcM944qw2cwTanaYniay4MPRxsDGolpbG+sdOqGyr+2jXYffH1W
        KaIpYWYdxkH+V1KXfiG+ooO2DeVOBT3VOBVAZzgkcrWWO7tZ8aAUGUqfqPLFptQ2tj21+u
        DXjduLolaJslnWlYj+4NAkNDmRW4sbo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-654-_sHi8aKIOUaCEzLlA4GnmQ-1; Fri, 02 Sep 2022 02:39:10 -0400
X-MC-Unique: _sHi8aKIOUaCEzLlA4GnmQ-1
Received: by mail-wm1-f71.google.com with SMTP id r83-20020a1c4456000000b003a7b679981cso2479280wma.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 23:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=smA4UY8sXEdNIEMlZ16VEJW1RuVtIcLIqTxA8bYdNhs=;
        b=pCgSMs7v/4WSjOBFzMNP7ui/qJrAnnnL5XlJS5nM0MLjE/cSFzRR3uAvFgzJeGTcFk
         fUUB1PVARAxRmD+9bCfPTunLqykLZOUDytVYmWwIFX/r1gfVJsDcmQ5jVErqx/0CY6wr
         ocUAqi3xnIL/QbL0hXlYKkxPv9Yx2CZsv5w3b2yCkmlcCYA1Mo7ZEQ+yefusbgTc6IbN
         4IubagocpH/DmWVYg9ymis6muB/6emUkKKQCEZ2tzoogS0hGZvU7FGtd8wfeAMDMBz0n
         DXWDXIN2UiF3cugFRonkR4yima1sh2e2GZ1JKgvTsc3iEwROT6cuZFaR5db3Ut+aLYP6
         TklQ==
X-Gm-Message-State: ACgBeo2OyocavFwvJ5/ZRmAohgAwmPFDP1MYfC3NPm2CP2xnN1ptx4VD
        8Ggt0yDvhlHoZw3KE/HzutM5EmfRIwuYbUfVXn3HQPjR/cNGqvi4ScyeyIicGV/ev1okPIq6NFS
        4IUTsu6pyBHCNyCcmtXCDuF7N
X-Received: by 2002:a5d:610b:0:b0:226:d241:65e8 with SMTP id v11-20020a5d610b000000b00226d24165e8mr15587287wrt.703.1662100748760;
        Thu, 01 Sep 2022 23:39:08 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4673nHlMv5dt9gE/7vE0SOdJcW2bMT36NxYTzGlempi8dS8+MsdN3h8BPFY6RtS6/7A+bz8A==
X-Received: by 2002:a5d:610b:0:b0:226:d241:65e8 with SMTP id v11-20020a5d610b000000b00226d24165e8mr15587271wrt.703.1662100748500;
        Thu, 01 Sep 2022 23:39:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c714:4800:2077:1bf6:40e7:2833? (p200300cbc714480020771bf640e72833.dip0.t-ipconnect.de. [2003:cb:c714:4800:2077:1bf6:40e7:2833])
        by smtp.gmail.com with ESMTPSA id f1-20020a7bcd01000000b003a35516ccc3sm1169265wmj.26.2022.09.01.23.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 23:39:08 -0700 (PDT)
Message-ID: <1688bcf0-01b2-0f89-68db-d9d66e207bc6@redhat.com>
Date:   Fri, 2 Sep 2022 08:39:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>
Cc:     kirill.shutemov@linux.intel.com, jhubbard@nvidia.com,
        jgg@nvidia.com, hughd@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220901222707.477402-1-shy828301@gmail.com>
 <YxE/vuQlWJCJMuG2@xz-m1.local>
 <CAHbLzkqjZ_UhUbJ_f9Br7WCAgQvjrm5bMPRsKYvaFc2bzSuzrw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
In-Reply-To: <CAHbLzkqjZ_UhUbJ_f9Br7WCAgQvjrm5bMPRsKYvaFc2bzSuzrw@mail.gmail.com>
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

On 02.09.22 01:50, Yang Shi wrote:
> On Thu, Sep 1, 2022 at 4:26 PM Peter Xu <peterx@redhat.com> wrote:
>>
>> Hi, Yang,
>>
>> On Thu, Sep 01, 2022 at 03:27:07PM -0700, Yang Shi wrote:
>>> Since general RCU GUP fast was introduced in commit 2667f50e8b81 ("mm:
>>> introduce a general RCU get_user_pages_fast()"), a TLB flush is no longer
>>> sufficient to handle concurrent GUP-fast in all cases, it only handles
>>> traditional IPI-based GUP-fast correctly.
>>
>> If TLB flush (or, IPI broadcasts) used to work to protect against gup-fast,
>> I'm kind of confused why it's not sufficient even if with RCU gup?  Isn't
>> that'll keep working as long as interrupt disabled (which current fast-gup
>> will still do)?
> 
> Actually the wording was copied from David's commit log for his
> PageAnonExclusive fix. My understanding is the IPI broadcast still
> works, but it may not be supported by all architectures and not
> preferred anymore. So we should avoid depending on IPI broadcast IIUC.

Right. Not all architectures perform an IPI broadcast on TLB flush.

IPI broadcasts will continue working until we use RCU instead of
disabling local interrupts in GUP-fast.


>>>    CPU A                                          CPU B
>>> THP collapse                                     fast GUP
>>>                                               gup_pmd_range() <-- see valid pmd
>>>                                                   gup_pte_range() <-- work on pte
>>> pmdp_collapse_flush() <-- clear pmd and flush
>>> __collapse_huge_page_isolate()
>>>     check page pinned <-- before GUP bump refcount
>>>                                                       pin the page
>>>                                                       check PTE <-- no change
>>> __collapse_huge_page_copy()
>>>     copy data to huge page
>>>     ptep_clear()
>>> install huge pmd for the huge page
>>>                                                       return the stale page
>>> discard the stale page
>>>
>>> The race could be fixed by checking whether PMD is changed or not after
>>> taking the page pin in fast GUP, just like what it does for PTE.  If the
>>> PMD is changed it means there may be parallel THP collapse, so GUP
>>> should back off.
>>
>> Could the race also be fixed by impl pmdp_collapse_flush() correctly for
>> the archs that are missing? Do you know which arch(s) is broken with it?
> 
> Yes, and this was suggested by me in the first place, but per the
> suggestion from John and David, this is not the preferred way. I think
> it is because:
> 
> Firstly, using IPI to serialize against fast GUP is not recommended
> anymore since fast GUP does check PTE then back off so we should avoid
> it.
> Secondly, if checking PMD then backing off could solve the problem,
> why do we still need broadcast IPI? It doesn't sound performant.

I'd say, using an IPI is the old-styled way of doing things. Sure, using
an IPI broadcast will work (and IMHO it's a lot easier to
not-get-wrong). But it somewhat contradicts to the new way of doing things.

>>
>> It's just not clear to me whether this patch is an optimization or a fix,
>> if it's a fix whether the IPI broadcast in ppc pmdp_collapse_flush() would
>> still be needed.
> 
> It is a fix and the fix will make IPI broadcast not useful anymore.

I'd wonder how "easy" adding the IPI broadcast would be -- IOW, if the
IPI fix has a real advantage.


-- 
Thanks,

David / dhildenb

