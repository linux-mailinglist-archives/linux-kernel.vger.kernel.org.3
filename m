Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111BC53A210
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350884AbiFAKLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352397AbiFAKKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:10:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 430B932B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654078233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N3iRtYmMd3c1dldMh9pkSi6ddCpkGPKUoTbkDUVwqOU=;
        b=Psk9SMG9U3vQT+JIvk0AxNFurygxoXEy6L2gEF+tTb29FVhESVFaZXyU1GQ6fa/hW6Cfu0
        9eyBww3id50tyQNcfhnbsOIPhYjmyNFLjzvZJFpkr6qCkgmF2Vb7WFhEwRE0A0Zzcc+ZWz
        S5RG7iIofm/bqiW4udmDitBOTrgKCCE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-04qGgtn3Noud_eLjDvlKTA-1; Wed, 01 Jun 2022 06:10:32 -0400
X-MC-Unique: 04qGgtn3Noud_eLjDvlKTA-1
Received: by mail-wm1-f69.google.com with SMTP id k7-20020a05600c1c8700b003974d762928so685392wms.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 03:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=N3iRtYmMd3c1dldMh9pkSi6ddCpkGPKUoTbkDUVwqOU=;
        b=ZNzv/sLosjWxLIj8KS8/AyxeIG+pdrmbZC1oxpFUsK1yHioFMEgtG+HxAuOMCd/O56
         cIM813eKZe+oRkbJcnwME7YUQspucxcHiwuu7l3duw2vdjwKrm9xz+xVuoRImi2/t5I1
         nwmB4zx/5XKn0S60nDS0ZOGBggkvXlOlRr42qfTwmwInrfniEW817yUQfs3Ucdsltgk0
         XumA60t/yuLS3mvAWISEe0+uDzfX7qgdrZGJxaCSrH02AsnLXctvntVQ8qsSjZevBnhZ
         wz052aEINFHtwfNBydeTfsqQdcYVL/CxQzxE2yVq0Q+3AyqhC1hxv0SAPwcEa06eugrB
         sxqA==
X-Gm-Message-State: AOAM533kJAKAdvyrtQs1TuO1BUcpxFBe/uhGJnfLPLBUh2EXi6gfT653
        0RXXM5pmBZ2nBQYpa+eG1QkbOpSmxszeAKj2Oo3O6XcTTa8H3rGa5M4RBS/m2gS1lQy2TTwJmMv
        0CaTv9kpwP7Jk34qVepxxV5x/
X-Received: by 2002:a05:600c:4f0e:b0:397:6b94:7469 with SMTP id l14-20020a05600c4f0e00b003976b947469mr27810014wmq.145.1654078231104;
        Wed, 01 Jun 2022 03:10:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuC7MTuNl3G5ty6Uutork5jZv8s+yj38vTqZxPE6/TqQYHLLRUonq3mhVTrzfeEN4rQ5SoTA==
X-Received: by 2002:a05:600c:4f0e:b0:397:6b94:7469 with SMTP id l14-20020a05600c4f0e00b003976b947469mr27809993wmq.145.1654078230827;
        Wed, 01 Jun 2022 03:10:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:2600:951d:63df:c091:3b45? (p200300cbc7052600951d63dfc0913b45.dip0.t-ipconnect.de. [2003:cb:c705:2600:951d:63df:c091:3b45])
        by smtp.gmail.com with ESMTPSA id m15-20020a05600c3b0f00b003974ca9fa6dsm6843655wms.2.2022.06.01.03.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 03:10:30 -0700 (PDT)
Message-ID: <ecc076e6-562e-cb5d-6c92-295dde07f657@redhat.com>
Date:   Wed, 1 Jun 2022 12:10:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/3] mm: hugetlb_vmemmap: cleanup
 CONFIG_HUGETLB_PAGE_FREE_VMEMMAP*
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        smuchun@bytedance.com
References: <20220404074652.68024-1-songmuchun@bytedance.com>
 <20220404074652.68024-4-songmuchun@bytedance.com>
 <ba64cd1b-c8ee-a4eb-f0cd-e16c26777d46@redhat.com>
 <Ypc3OquA5MZUl5iw@FVFYT0MHHV2J.googleapis.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Ypc3OquA5MZUl5iw@FVFYT0MHHV2J.googleapis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.06.22 11:54, Muchun Song wrote:
> On Wed, Jun 01, 2022 at 11:32:37AM +0200, David Hildenbrand wrote:
>> On 04.04.22 09:46, Muchun Song wrote:
>>> The word of "free" is not expressive enough to express the feature of optimizing
>>> vmemmap pages associated with each HugeTLB, rename this keywork to "optimeze".
>>> In this patch , cheanup configs to make code more expressive.
>>
>> Nit: why not simply CONFIG_HUGETLB_OPTIMIZE_VMEMMAP if we're touching
>> this already? At least I don't see value in the additional "PAGE" :)
>>
> 
> I thought it keep consistent with CONFIG_HUGETLB_PAGE.  If you think
> CONFIG_HUGETLB_OPTIMIZE_VMEMMAP is a better name, maybe we need to
> another separate patch since this series is already on mm-stable branch.

I see, makes sense then.

>>>
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> ---
>>>  Documentation/admin-guide/kernel-parameters.txt |  4 ++--
>>>  Documentation/admin-guide/mm/hugetlbpage.rst    |  2 +-
>>>  arch/arm64/Kconfig                              |  2 +-
>>>  arch/arm64/mm/flush.c                           |  2 +-
>>>  arch/x86/Kconfig                                |  2 +-
>>>  arch/x86/mm/init_64.c                           |  2 +-
>>>  fs/Kconfig                                      | 16 ++++++++--------
>>>  include/linux/hugetlb.h                         |  2 +-
>>>  include/linux/mm.h                              |  2 +-
>>>  include/linux/page-flags.h                      |  6 +++---
>>>  mm/Makefile                                     |  2 +-
>>>  mm/hugetlb_vmemmap.c                            |  4 ++--
>>>  mm/hugetlb_vmemmap.h                            |  4 ++--
>>>  mm/sparse-vmemmap.c                             |  4 ++--
>>>  14 files changed, 27 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index 56edbe3f458f..89a58ac49d5f 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -1660,7 +1660,7 @@
>>>  			Format: size[KMG]
>>>  
>>>  	hugetlb_free_vmemmap=
>>
>> We didn't change the parameter name in #2, correct?
>>
> 
> I think this is a interface to users. Is it correct to
> change it?

I guess so ... I was just wanted to confirm that this is still correct :)

-- 
Thanks,

David / dhildenb

