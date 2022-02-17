Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6876C4B9B93
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238269AbiBQI6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:58:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiBQI6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:58:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F11132A39C3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645088309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GrFM36GXCLpEs5PixdxLnf8cSAbh9T3Q4gJPAQrISRU=;
        b=LO51uaejTlpe6DGBhTzcx8QyTyt8TSgH5gcywjt/UDZkKZbkn8u5MGwX/oWGS/ltci/sOo
        bujsp+CAVqDs+w72ZV8CF9mwsRdWGbU5jmU7mEw6S0cxggk8uqY1qgbJCQOiLotqOpLiAf
        IQIx9t/NAOpZGqhHxlJaRBNrOi3hmE4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-C58sAHUdPgiyh3gO0ZVrXw-1; Thu, 17 Feb 2022 03:58:28 -0500
X-MC-Unique: C58sAHUdPgiyh3gO0ZVrXw-1
Received: by mail-ej1-f70.google.com with SMTP id v2-20020a170906292200b006a94a27f903so1200887ejd.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:58:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=GrFM36GXCLpEs5PixdxLnf8cSAbh9T3Q4gJPAQrISRU=;
        b=VerhcwlQg2WkIMDC3R5Uevy5DyLn1qh6Q7TeRhqqpCsbvCKs8t4dHmp2VVOtd9p3Ct
         TOMCCj3W2TPeOXcAJHJCMlXWgq2J196TP/adz2JLq6YzB1Tl4u9dYJB2+aFrCCaNESUy
         myM6azavWiNAT0HzXpPeo5aLQpiXdEJxUzxPSdKxfZRaNsFHtgW+dXu0jh45iG2HMy1e
         JKPbTnPuqfIw5bcyZMtzyJqfbHOOzFoHTVSNRfmQpsiBdThniFR32rCA8SsDZz1p+Pi7
         7kN488wFJ4iIz7mHlH5sr4pl1LBQRFAWW/JfaxFrm2fbfsgDMO/ihQAr45faf9/4HQVe
         Ea7g==
X-Gm-Message-State: AOAM533lGKk7VG+t/708webQ5ibbK+tFj2DUuHaQmbLyE95NbSaMRf4V
        WLyeg0AeEho8NFAsfZI+VGcdLXsxW5owN8nWCbDCkmtlqzXgue2HhFoC9U8JtCxvliKeGU8KJ3t
        Q2mJuM7nDy5Hv2PKc02198nbC
X-Received: by 2002:a17:907:9195:b0:6ce:e31e:361e with SMTP id bp21-20020a170907919500b006cee31e361emr1510705ejb.349.1645088307504;
        Thu, 17 Feb 2022 00:58:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz79VLxnC2xgHyODxqG8K1CPVfa4ThO9Tuq5uUbZRan2TYF0NgFCw5GjHBbvpCD+tBRn989fA==
X-Received: by 2002:a17:907:9195:b0:6ce:e31e:361e with SMTP id bp21-20020a170907919500b006cee31e361emr1510686ejb.349.1645088307249;
        Thu, 17 Feb 2022 00:58:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c711:b800:254c:2d22:aab2:20a? (p200300cbc711b800254c2d22aab2020a.dip0.t-ipconnect.de. [2003:cb:c711:b800:254c:2d22:aab2:20a])
        by smtp.gmail.com with ESMTPSA id 29sm935809ejk.107.2022.02.17.00.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 00:58:26 -0800 (PST)
Message-ID: <fad42051-6816-08cf-1430-ad4da5dbc951@redhat.com>
Date:   Thu, 17 Feb 2022 09:58:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 1/3] mm: enable MADV_DONTNEED for hugetlb mappings
Content-Language: en-US
To:     Yin Fengwei <fengwei.yin@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220215002348.128823-1-mike.kravetz@oracle.com>
 <20220215002348.128823-2-mike.kravetz@oracle.com>
 <57fa170a-253b-932f-0261-b4905881d888@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <57fa170a-253b-932f-0261-b4905881d888@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.02.22 09:32, Yin Fengwei wrote:
> 
> 
> On 2022/2/15 08:23, Mike Kravetz wrote:
>> MADV_DONTNEED is currently disabled for hugetlb mappings.  This
>> certainly makes sense in shared file mappings as the pagecache maintains
>> a reference to the page and it will never be freed.  However, it could
>> be useful to unmap and free pages in private mappings.  In addition,
>> userfaultfd minor fault users may be able to simplify code by using
>> MADV_DONTNEED.
>>
>> The primary thing preventing MADV_DONTNEED from working on hugetlb
>> mappings is a check in can_madv_lru_vma().  To allow support for hugetlb
>> mappings create and use a new routine madvise_dontneed_free_valid_vma()
>> that allows hugetlb mappings in this specific case.
>>
>> For normal mappings, madvise requires the start address be PAGE aligned
>> and rounds up length to the next multiple of PAGE_SIZE.  Do similarly
> 
> In man page of mmap, NOTE for "Huge page (Huge TLB) mappings":
> 
> "For munmap(), addr, and length must both be a multiple of the 
> underlying huge page size."
> 
> Should we apply same rule to MADV_DONTNEED? Thanks.

madvise() already has different rules than mmap() for ordinary pages, so
we'd much rather try staying consistent with madvise() rules.

-- 
Thanks,

David / dhildenb

