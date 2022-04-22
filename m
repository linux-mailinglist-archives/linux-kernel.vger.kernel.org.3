Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE12950B95E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352501AbiDVODn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344513AbiDVODk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:03:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FA2A6456
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650636046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9x3v/ioYU2PkbStJSHQW4pdUX8pdnAHng9fSZRsv8Nk=;
        b=UZxs1H5tV/yZ1Xp4CBC1mwHrvIqD5gSUMz3rDckfaigN+u54ZXHG94LcvRMLta6NEkwoN2
        saKkCdEpr0U3rlhTCkAUZw3E3lkd+85GghPH3caNhkbwiA55m4vmAmHkBrE9/DnYKNcq62
        nfr+bvJQ1Yk9/rbyFJx9nVWN/fIjKXo=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-172-NLdFs66_PqWWR-1_WuM2xQ-1; Fri, 22 Apr 2022 10:00:44 -0400
X-MC-Unique: NLdFs66_PqWWR-1_WuM2xQ-1
Received: by mail-oi1-f199.google.com with SMTP id n81-20020aca4054000000b0032276048b14so3576701oia.21
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9x3v/ioYU2PkbStJSHQW4pdUX8pdnAHng9fSZRsv8Nk=;
        b=PhXRs9kbj/EGohcFCnwGW1DJ2uPWaQwDmbcBHjqCf4mcrq8oJMzLHcLd1yo3G+wPru
         WDWRgmfSg7adP5T0yhKdsJn6k4tjeyxzIBU8TBrDCBInODCIhXlIa+Mkj/7hxW7tzWxv
         MUyeCAPMWVoZGu6xmFPE7EzufJHL0yIFKnEFgqaebFQwvdfBfZgAAqd7Dc8OTm6RF8tQ
         WXjrnH7gk6ZRUAeR37EjmfTZPs3iQoMPqi8qT1KkoMcWuNLUAOD+RzA3Vx5QOK7+PzGn
         vUbw9O6pnrD9ffgKIVYDQSi0NW6HWPhRLBANUDldG1HX4v240ZXq9JHyKbSX52C2Rvd6
         UneQ==
X-Gm-Message-State: AOAM531aID2v9lhmRrolG+SuRFgg1jTjHWrLD5LMc8VQWzlVih0NslsK
        WZ2b94Sv9ce0qwTkAeXN0iIRVHfOpCrPkRgsDiuqe+rG306wyy6FvFt1eVaZChoB+Pt01+XuejS
        +E4mMMTh+p99p+Gw9ihmubdTv
X-Received: by 2002:a05:6870:6196:b0:e1:e1a2:5c65 with SMTP id a22-20020a056870619600b000e1e1a25c65mr2038381oah.190.1650636043807;
        Fri, 22 Apr 2022 07:00:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaAvrG4ahVI6peqDBkgAZ6DW/cDwXzRY7tyv0DEpwTfCyPnW3MVghH/9LDprI3Zcm7alLlHA==
X-Received: by 2002:a05:6870:6196:b0:e1:e1a2:5c65 with SMTP id a22-20020a056870619600b000e1e1a25c65mr2038370oah.190.1650636043541;
        Fri, 22 Apr 2022 07:00:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:5610:6e80::41? ([2600:1700:5610:6e80::41])
        by smtp.gmail.com with ESMTPSA id y11-20020a4ad64b000000b00333c9ad6eb8sm815835oos.21.2022.04.22.07.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 07:00:43 -0700 (PDT)
Message-ID: <1f0f3254-31bd-5d09-6520-1897b3c5755b@redhat.com>
Date:   Fri, 22 Apr 2022 10:00:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC 1/3] mm: change vma_is_anonymous to vma_is_private_anon
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
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
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <YmGwYKtz3sFkJlcv@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/22 15:28, Matthew Wilcox wrote:
> On Thu, Apr 21, 2022 at 03:05:31PM -0400, Nico Pache wrote:
>> The vma_is_anonymous function isn't fully indicative of what it checks.
>>
>> Without having full knowledge of the mmap process, one may incorrectly
>> assume this covers all types of anonymous memory; which is not the case.
> 
> Is your complaint that anonymous memory can also be found in file VMAs
> that were mapped with MAP_PRIVATE?  ie COWed pages?
I should have been more descriptive in my commit msg about how I came to this
conclusion.

From my understanding of the mmap process, a vma->vm_ops field is only NULL when
mmapped as !file and !shared:

	if (file){
		...
	} else if (vm_flags & VM_SHARED) { 	//ANON SHARED
		error = shmem_zero_setup(vma);
	        if (error)
        		goto free_vma;
	} else { 				//ANON PRIVATE
		vma_set_anonymous(vma);		//set vma->vm_ops= NULL
	}

To me this means that the VMA is PRIVATE ANON memory. The vma_is_anonymous
function returns true when vm_ops == NULL. So my intentions were to more
accurately describe what we are checking for. I could be wrong though thats why
I started with an RFC :)

There could be some aspect of COW that I dont fully understand. It is not
something I've looked into much.

Cheers,
-- Nico

