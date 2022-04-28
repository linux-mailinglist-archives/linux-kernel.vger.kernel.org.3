Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8523D513979
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349827AbiD1QRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349818AbiD1QRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:17:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76A3E5C37B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651162456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dGBrnOhdj0Ms1xTSGzmkeoSPGVLRW+Ni49nUm3bjdfI=;
        b=ekL3T8ar72OMfPeRKyPx2w6F1I+2h1OaMcVwlJ0duWs74AHGCyS+nhaPCq0KmhOZbsIe9A
        yu7fHchYVTckz+ZBGk4SvaT+AoyMsMaOPMVemCzNRSPF64TQoF6mLBo+kAIAJ8XmnxPRkD
        VJRv0ej/YGz5nPTGonUPKq6zpN3ACAg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-mfi9JGRWM06SdTpXTpbgtQ-1; Thu, 28 Apr 2022 12:14:15 -0400
X-MC-Unique: mfi9JGRWM06SdTpXTpbgtQ-1
Received: by mail-wr1-f69.google.com with SMTP id b10-20020adfc74a000000b0020ab029d5edso2080909wrh.18
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=dGBrnOhdj0Ms1xTSGzmkeoSPGVLRW+Ni49nUm3bjdfI=;
        b=KbC+EMXjKYQ++EKuuT8JngGWIQ9vowqEmfL62V+72NANEhQz/JwVubnZVeeiRxGz2t
         8c+NRJVRHKPGwqNgW583bz9LLzZYhPn9pH6zax8REAkkC1jkkuyn82ShfBkXpWItPySE
         Dxqa4rw/4xvxN8P6degerZl69RZysyBzsxHV/RQ/9FxqfxyD59grkLq2pYxr30OiF50t
         bZ+BqhX6YvqoIlhyI2PTaPhQjmXMqdELxjmXzvfVyiVftXeFpvIkKxkfH7NObGDTSHBN
         x12Uxtbq+9+Oi4cAvHWspZoMgsdC+LqMpHFRR6cOXD3kwNDfnv/g3MTSXpwv+Dxmf9Nb
         maWw==
X-Gm-Message-State: AOAM530W1msYVrDAT/E6vnMXdcMyiYxKKfL4fKHRSZ1v23kMwpCTvVK6
        KajQWtDYA2uoOB9Lfs4f4UkTsJB4shuH+/FARBaQ0KMJw2rDvqFiMn7iZcJollG/lv/TM61IPuB
        cxYjfRqmE9f2+Apbj4MIZTCKc
X-Received: by 2002:a05:600c:1c17:b0:393:e6ee:1e1c with SMTP id j23-20020a05600c1c1700b00393e6ee1e1cmr24294405wms.85.1651162454037;
        Thu, 28 Apr 2022 09:14:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoeQ+QCpA3TNwQQ/y/ZymUkfPUtA0Or9PN6nAykWJhle/CVQxQ84s8seyzRGeMQGbwpLAWTA==
X-Received: by 2002:a05:600c:1c17:b0:393:e6ee:1e1c with SMTP id j23-20020a05600c1c1700b00393e6ee1e1cmr24294382wms.85.1651162453733;
        Thu, 28 Apr 2022 09:14:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:ef00:7443:a23c:26b8:b96? (p200300cbc708ef007443a23c26b80b96.dip0.t-ipconnect.de. [2003:cb:c708:ef00:7443:a23c:26b8:b96])
        by smtp.gmail.com with ESMTPSA id u22-20020adfa196000000b0020ad517ce4bsm217625wru.52.2022.04.28.09.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 09:14:12 -0700 (PDT)
Message-ID: <34000b9d-1fc3-fef5-d048-3cb3f8a36f1d@redhat.com>
Date:   Thu, 28 Apr 2022 18:14:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [RFC 1/3] mm: change vma_is_anonymous to vma_is_private_anon
Content-Language: en-US
To:     Nico Pache <npache@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Hugh Dickins <hughd@google.com>
References: <20220421190533.1601879-1-npache@redhat.com>
 <20220421190533.1601879-2-npache@redhat.com>
 <YmGwYKtz3sFkJlcv@casper.infradead.org>
 <1f0f3254-31bd-5d09-6520-1897b3c5755b@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <1f0f3254-31bd-5d09-6520-1897b3c5755b@redhat.com>
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

On 22.04.22 16:00, Nico Pache wrote:
> 
> 
> On 4/21/22 15:28, Matthew Wilcox wrote:
>> On Thu, Apr 21, 2022 at 03:05:31PM -0400, Nico Pache wrote:
>>> The vma_is_anonymous function isn't fully indicative of what it checks.
>>>
>>> Without having full knowledge of the mmap process, one may incorrectly
>>> assume this covers all types of anonymous memory; which is not the case.
>>
>> Is your complaint that anonymous memory can also be found in file VMAs
>> that were mapped with MAP_PRIVATE?  ie COWed pages?
> I should have been more descriptive in my commit msg about how I came to this
> conclusion.
> 
> From my understanding of the mmap process, a vma->vm_ops field is only NULL when
> mmapped as !file and !shared:
> 
> 	if (file){
> 		...
> 	} else if (vm_flags & VM_SHARED) { 	//ANON SHARED
> 		error = shmem_zero_setup(vma);
> 	        if (error)
>         		goto free_vma;
> 	} else { 				//ANON PRIVATE
> 		vma_set_anonymous(vma);		//set vma->vm_ops= NULL
> 	}
> 
> To me this means that the VMA is PRIVATE ANON memory. The vma_is_anonymous
> function returns true when vm_ops == NULL. So my intentions were to more
> accurately describe what we are checking for. I could be wrong though thats why
> I started with an RFC :)

Shared anon in the kernel is really just shmem.  The user space notion
is MAP_ANON|MAP_SHARED, but that really just maps to shmem and the
kernel doesn't really call that thing anonymous memory.

So I agree, renaming this is not appropriate.

-- 
Thanks,

David / dhildenb

