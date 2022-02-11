Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAADB4B2068
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243293AbiBKInx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:43:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiBKInw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:43:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95D7BE67
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644569030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T1tDnrHIbG9LXNEmLQIdCuYtaS1n3f83/zIK/VL9XPM=;
        b=KyeSzzpUIMVYEmmyUW0obpvVqAeVc68miUOwjOgK/3tXRnQ3DMRtKHpLadAs0vpoM/8pSb
        hOT8sTSmPrbshpAqj2R/qUJAbsiPlQpDEcn3dwlgiZlAkXOUa3AkDLVyaIU8/EIlLd5Exx
        qDGC8G+Zbo1hJEbwap2DGEOrrWeFhUI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-UbgzzdC6PbauOz5RvPxZsw-1; Fri, 11 Feb 2022 03:43:49 -0500
X-MC-Unique: UbgzzdC6PbauOz5RvPxZsw-1
Received: by mail-wr1-f70.google.com with SMTP id k20-20020adfc714000000b001e305cd1597so3581740wrg.19
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:43:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=T1tDnrHIbG9LXNEmLQIdCuYtaS1n3f83/zIK/VL9XPM=;
        b=pQ57xVkgfVow77opvvcA4MNpSpcnJBjBj41qC8x1m6+Z43Ks2ca3c/4kvNHvQ7QpcT
         ykjNe1Y38tg0r/X7MfI0zshun+kCpR4um0bG7ZChJtG+o362RWj9rkBaiz/FIcQGnt/f
         1fqJ+C0zOUBPRY5+Or6MhV4VXpLrcZlyh0MexqumAY+CgZiwnx/YeUs3vU2+ibhbdIzX
         SBOxUXHanpF+8eizMIi/9Iqr//ZtTd3B7F8EVv0WzDBGdFJ4L/qF3AGuNW/PKs1JLHvQ
         ON0eCNCy8y8Bu0d4dRHXYLoWsgY3iF1f6TJMpRe/WawZZHOP81Ej5HZLdIo5ZI8MZWkx
         nZNw==
X-Gm-Message-State: AOAM53017exX7S91yQPalM2EWPaIGUOy7ittAka8c7Et7DhWr2nCrrEg
        NWlTWluP5MN1/kAux6rKVEh+f/CRne0TvvMoagSA8WHf6028acyzvUA7J/NGAqAIBulmT+F9cN+
        2WfPhX86QRRUn+wSYkG8VGzCf
X-Received: by 2002:adf:fb0e:: with SMTP id c14mr483648wrr.586.1644569028310;
        Fri, 11 Feb 2022 00:43:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUBv5o6lrc5bIuyfHJC73FB/0g+al611mC6ZxwixSW6SrEZEOwJ3diZZy9JWwqLfEpAY3wKA==
X-Received: by 2002:adf:fb0e:: with SMTP id c14mr483633wrr.586.1644569028116;
        Fri, 11 Feb 2022 00:43:48 -0800 (PST)
Received: from ?IPV6:2003:cb:c70c:aa00:4cc6:d24a:90ae:8c1f? (p200300cbc70caa004cc6d24a90ae8c1f.dip0.t-ipconnect.de. [2003:cb:c70c:aa00:4cc6:d24a:90ae:8c1f])
        by smtp.gmail.com with ESMTPSA id w3sm4872992wrl.113.2022.02.11.00.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 00:43:47 -0800 (PST)
Message-ID: <356a4b9a-1f56-ae06-b211-bd32fc93ecda@redhat.com>
Date:   Fri, 11 Feb 2022 09:43:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
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
 <b7ebafed-7dc3-b08d-15d4-859c7bc0fe2e@redhat.com>
 <55b6e78f-9594-8d5b-6ce2-bb699b9549fd@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 1/3] mm: enable MADV_DONTNEED for hugetlb mappings
In-Reply-To: <55b6e78f-9594-8d5b-6ce2-bb699b9549fd@oracle.com>
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

>>>
>>> I am now rethinking the decision to proceed with b) as described above.
>>>
>>> With the exception of MADV_REMOVE (which we may be able to change for
>>> hugetlb),  madvise operations operate on huge page size pages for hugetlb
>>> mappings.  If start address is in the middle of a hugetlb page, we essentially
>>> align down to the beginning of the hugetlb page.  If length lands in the
>>> middle of a hugetlb page, we essentially round up.
>>
>> Which MADV calls would be affected?
> 
> Not sure I understand the question.  I was saying that madvise calls which
> operate on hugetlb mappings today only operate on huge pages.  So, this is
> essentially align down starting address and align up end address.

Let me clarify:

If you accidentially
MADV_NORMAL/MADV_RANDOM/MADV_SEQUENTIAL/MADV_WILLNEED a range that's
slightly bigger/smaller than the requested one you don't actually care,
because it will only slightly affect the performance of an application,
if at all.  MADV_COLD/MADV_PAGEOUT should be similar. I assume these
don't apply to hugetlb at all.

The effects of
MADV_MERGEABLE/MADV_UNMERGEABLE/MADV_HUGEPAGE/MADV_NOHUGEPAGE should in
theory be similar, however, there can be some user-space visible effects
when you get it wrong. I assume these don't apply to hugetlb at all.

However, for
MADV_DONTNEED/MADV_REMOVE/MADV_DONTFORK/MADV_DOFORK/MADV_FREE/MADV_WIPEONFORK/MADV_KEEPONFORK/MADV_DONTDUMP/MADV_DODUMP/....
the application could easily detect the difference of the actual range
handling.


> For example consider the MADV_POPULATE calls you recently added.  They will
> only fault in huge pages in a hugetlb vma.

On a related note: I don't see my man page updates upstream yet. And the
last update upstream seems to have happened 5 months ago ... not sure
why the man project seems to have stalled.

https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/

-- 
Thanks,

David / dhildenb

