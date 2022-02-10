Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC2D4B0E24
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241990AbiBJNJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:09:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238484AbiBJNJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:09:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A2381A7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 05:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644498563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M/BVmK6ZEQDXgu6WLITH9xryIPWjvCSUhZcH2xVdXdE=;
        b=M7Dosj+33kBp8HV0T9oam1Pp98hVgTgfyDs4ONdcq07c38rM4Vd3KYsBfyNgav09AhW4pC
        0yBcydAsnYD3QPEIyjz7y8ozR5pDRuhXUsh10XaxI5n9TAXNNOhJwFZ9xhZZ1KJrqZw7Na
        92qIz1xvBWnXNbd3mgK6ffvxiJvJc+A=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-yp6M5IJkMI2NT-3sG9NwGg-1; Thu, 10 Feb 2022 08:09:22 -0500
X-MC-Unique: yp6M5IJkMI2NT-3sG9NwGg-1
Received: by mail-ed1-f70.google.com with SMTP id b26-20020a056402139a00b004094fddbbdfso3318063edv.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 05:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=M/BVmK6ZEQDXgu6WLITH9xryIPWjvCSUhZcH2xVdXdE=;
        b=54i76DFBrr5xDHnLhqd6aaosoH0qZHXchVUDRV4XLheoZCaJgk6i9/m2zxrurnP7Xm
         97W60W3byvR6TJehwuq1SCUr7Gmtw0v7jW9/ebA/0ODbBtJ7ISHuxrSnBeaR/jUYpsrN
         QQ3aSJX0Go5iNtO1D2KAT1kNZP9h+jghrEHhmGMZVHsJN9yKwBD599zdmrtPv3OsIsNn
         q2sR+6FBRNxAlGxRFLiRS+AjM1ubZLxRkitN1iHSrSy4B6LBl6ewspyW3Qhh64EOV2fT
         Ozp4W4PmnSouheVUtb3QvLBqnU013P0fCKiULVn63me2zRU+zZHPVzkWEB8oRxifSXmt
         c9cQ==
X-Gm-Message-State: AOAM531alCdOn8aAkOePQws5iO2n1z8AOykitE/wtWkNA1N8b/JwmEXQ
        DX/y3dAY+94nvYENt0yFQXNJ/d7u0nqfE70b1Hhqsp9o6z/TdoU41UgmypuINh7TpdrtiRI6Egs
        uQT72sQWRGUODUuIFsWffr47h
X-Received: by 2002:a17:907:1c01:: with SMTP id nc1mr6554295ejc.659.1644498560752;
        Thu, 10 Feb 2022 05:09:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxA9WIx4q8U+5xgExPBsytlGv4dEUQkQQY+E5IEnfheqiHgyMsJL9Nla/bZ/c6l554DELMX6g==
X-Received: by 2002:a17:907:1c01:: with SMTP id nc1mr6554276ejc.659.1644498560524;
        Thu, 10 Feb 2022 05:09:20 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:f900:7b04:69ec:2caf:3b42? (p200300cbc70bf9007b0469ec2caf3b42.dip0.t-ipconnect.de. [2003:cb:c70b:f900:7b04:69ec:2caf:3b42])
        by smtp.gmail.com with ESMTPSA id h7sm4477148ejb.40.2022.02.10.05.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 05:09:18 -0800 (PST)
Message-ID: <b7ebafed-7dc3-b08d-15d4-859c7bc0fe2e@redhat.com>
Date:   Thu, 10 Feb 2022 14:09:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 1/3] mm: enable MADV_DONTNEED for hugetlb mappings
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220202014034.182008-1-mike.kravetz@oracle.com>
 <20220202014034.182008-2-mike.kravetz@oracle.com>
 <20571829-9d3d-0b48-817c-b6b15565f651@redhat.com>
 <7b174c48-d368-43ba-7eab-13719a0d15ef@oracle.com>
 <6a82ea68-6e1e-8f5a-ca89-6744fc896a0b@redhat.com>
 <d7e6ee46-8e0b-2ae3-c159-449a26c17ae9@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <d7e6ee46-8e0b-2ae3-c159-449a26c17ae9@oracle.com>
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

On 08.02.22 00:47, Mike Kravetz wrote:
> On 2/4/22 00:35, David Hildenbrand wrote:
>>> I thought this was simple. :)
>>
>> It really bugs me that it's under-specified what's supposed to happen
>> when the length is not aligned.
>>
>> BUT: in the posix world, "calling posix_madvise() shall not affect the
>> semantics of access to memory in the specified range". So we don't care
>> too much about if we align up/down, because it wouldn't affect the
>> semantics. Especially for MADV_DONTNEED/MADV_REMOVE as implemented by
>> Linux this is certainly different and the alignment handling matters.
>>
>> So I guess especially for MADV_DONTNEED/MADV_REMOVE we need a clear
>> specification what's supposed to happen if the length falls into the
>> middle of a huge page. We should document alignment handling for
>> madvise() in general I assume.
>>
>> IMHO we should have bailed out right from the start whenever something
>> is not properly aligned, but that ship has sailed. So I agree, maybe we
>> can make at least hugetlb MADV_DONTNEED obey the same (weird) rules as
>> ordinary pages.
>>
>> So b) would mean, requiring start to be hugepage aligned and aligning-up
>> the end. Still feels wrong but at least matches existing semantics.
>>
>> Hugetlb MADV_REMOVE semantics are unfortunate and we should document the
>> exception.
> 
> Thank you for all your comments David!
> 
> So, my plan was to make MADV_DONTNEED behave as described above:
> - EINVAL if start address not huge page size aligned
> - Align end/length up to huge page size.
> 
> The code I had for this was very specific to MADV_DONTNEED.  I then thought,
> why not do the same for MADV_REMOVE as well?  Or even more general, add this
> check and alignment to the vma parsing code in madvise.
> 
> It was then that I realized there are several madvise behaviors that take
> non-huge page size aligned addresses for hugetlb mappings today.  Making
> huge page size alignment a requirement for all madvise behaviors could break
> existing code.  So, it seems like it could only be added to MADV_DONTNEED as
> this functionality does not exist today.  We then end up with MADV_DONTNEED
> as the only behavior requiring huge page size alignment for hugetlb mappings.
> Sigh!!!

:/

> 
> I am now rethinking the decision to proceed with b) as described above.
> 
> With the exception of MADV_REMOVE (which we may be able to change for
> hugetlb),  madvise operations operate on huge page size pages for hugetlb
> mappings.  If start address is in the middle of a hugetlb page, we essentially
> align down to the beginning of the hugetlb page.  If length lands in the
> middle of a hugetlb page, we essentially round up.

Which MADV calls would be affected?

The "bad" thing about MADV_DONTNEED and MADV_REMOVE are that they
destroy data, which is why they heavily diverge from the original posix
madvise odea.

> 
> When adding MADV_REMOVE perhaps we should go with this align down start and
> align up end strategy that is used everywhere else?  I really wish we could
> go back and change things, but as you know it is too late for that.

I assume whatever we do, we should document it at least cleanly in the
man page. Unfortunately, hugetlb is a gift that keeps on giving. Making
it at least somehow consistent, even if it's "hugtlb being consistent in
its own mess", that would be preferable I guess.

-- 
Thanks,

David / dhildenb

