Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B44A4E2C1B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350116AbiCUPZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350106AbiCUPZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:25:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 447302983B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647876252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gkwfmV9h90rKkg7JIWAtJfnSFaMHQkfhf23YAP5P8Rg=;
        b=ZAPxojj9L6+BgXIs60HJzLGS5xCMABz4uBOmHpIj1xpWHIw4le10KUTtk92BWDhnGUBRbT
        894RnDsR2b7N2pxZ68Ni0yoUTidrC2TrV1MuS8rfbn2V/Fsu/Y45+j0RcU9Ep7+jgt1tG+
        URObtAyKsG+JpIwwAUH0YQdlTN38F1A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-316-juQKa2BvNiqyY7yMUbvHQQ-1; Mon, 21 Mar 2022 11:24:11 -0400
X-MC-Unique: juQKa2BvNiqyY7yMUbvHQQ-1
Received: by mail-wm1-f71.google.com with SMTP id m123-20020a1c2681000000b0038c9e1197f6so1650100wmm.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:organization:in-reply-to
         :content-transfer-encoding;
        bh=gkwfmV9h90rKkg7JIWAtJfnSFaMHQkfhf23YAP5P8Rg=;
        b=PE/P7dNX2J//9aqiH2xDXHRVmFJROOHjExfrRZLQLk090Zr+qRWVTgSIYdKQI+oDn6
         yo2HIM/cJ6oMZBsuTN/4UEX3NC4elJWfg/mPqgmNnaKHuSUgjvIuvIBn/ErxoMZTMtEl
         0ZR5pKfMwTIm4YJKQL3abKqDu6SQSx77ZL8sbzFUv4hm2T5th9nQvONX8Fv2p0cAVNEO
         jmfLHqagJHH53HbcQS1ZuFdsukfdU78/Cf/rZM/jVLadf0vKvPUt2lWNtHudZcmLUZEp
         +a5ZfhfZ6yPXaORTpn7fT6AUW7UcFTB1KwK7+7XQ5QXizTUS1U3ZYT0XxtkQjmG/COr8
         xr5w==
X-Gm-Message-State: AOAM530Rh/28a1wNuocHQQnOejCWZHQ7z0ylXyJ4i/GY9FpMx4DPExqj
        iwcHO7vbvfHE9Po5c6FFTTTgDU1soJSgjxEpQnp9yixBf0wAT/hY54VnTWWKxtTNZHSkFfpFhXX
        rUF9dJvRiq69Fx2heo2d0GkFb
X-Received: by 2002:a05:600c:3c8a:b0:389:cf43:eaf6 with SMTP id bg10-20020a05600c3c8a00b00389cf43eaf6mr19810853wmb.199.1647876249780;
        Mon, 21 Mar 2022 08:24:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwegmlA7v6h+7OLrqTmDae/ZCWlQDUWC84R+Dmzz23xCWP1ygvd+1BcbP8JTZ0/E58v29s+ZQ==
X-Received: by 2002:a05:600c:3c8a:b0:389:cf43:eaf6 with SMTP id bg10-20020a05600c3c8a00b00389cf43eaf6mr19810829wmb.199.1647876249539;
        Mon, 21 Mar 2022 08:24:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:4900:849b:f76e:5e1f:ff95? (p200300cbc7044900849bf76e5e1fff95.dip0.t-ipconnect.de. [2003:cb:c704:4900:849b:f76e:5e1f:ff95])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b0038c949ef0d5sm7269674wmq.8.2022.03.21.08.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 08:24:09 -0700 (PDT)
Message-ID: <d5676cf0-30f9-8497-95a8-332767dede46@redhat.com>
Date:   Mon, 21 Mar 2022 16:24:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [GIT PULL] Folio patches for 5.18 (MM part)
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@kernel.org>,
        William Kucharski <william.kucharski@oracle.com>
References: <Yjh+EuacJURShtJI@casper.infradead.org>
 <9ae0a8e4-41b7-04f4-4435-17cbba9850fb@redhat.com>
Organization: Red Hat
In-Reply-To: <9ae0a8e4-41b7-04f4-4435-17cbba9850fb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.22 16:16, David Hildenbrand wrote:
> On 21.03.22 14:30, Matthew Wilcox wrote:
>> Hi Linus,
>>
>> This is the first of two folio-related pull requests for this merge
>> window.  This is the MM side of things and we had some unfortunate
>> complex merge conflicts to resolve.  I decided to redo my changes on
>> top of Hugh's and Christoph's patches, so I'm the one sending the
>> pull request.
>>
>> The following changes since commit f71077a4d84bbe8c7b91b7db7c4ef815755ac5e3:
>>
>>   Merge tag 'mmc-v5.17-rc1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc (2022-02-16 12:09:22 -0800)
>>
>> are available in the Git repository at:
>>
>>   git://git.infradead.org/users/willy/pagecache.git tags/folio-5.18
>>
>> for you to fetch changes up to 5063f22c914e3e5f2239cf91f4986042dc705bde:
>>
>>   mm/damon: minor cleanup for damon_pa_young (2022-03-16 10:09:50 -0400)
>>
>> ----------------------------------------------------------------
>> Folio changes for 5.18
>>
>> Several of us had overlapping, conflicting changes to the MM this
>> round, and I volunteered to send the pull request.
>>
>>  - Hugh rewrote how munlock works to massively reduce the contention
>>    on i_mmap_rwsem:
>>    https://lore.kernel.org/linux-mm/8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com/
>>  - Christoph sorted out the page refcount mess for ZONE_DEVICE pages:
>>    https://lore.kernel.org/linux-mm/20220210072828.2930359-1-hch@lst.de/
>>  - I converted GUP to use folios and make pincount available for order-1
>>    pages.
>>  - I converted a few more truncation functions to use folios
>>  - I converted page_vma_mapped_walk to use PFNs instead of pages
>>  - I converted rmap_walk to use folios
>>  - I converted most of shrink_page_list() to use a folio
>>  - I added support for creating large folios in readahead
>>
>> ----------------------------------------------------------------
>> Alex Sierra (10):
>>       mm: add zone device coherent type memory support
>>       mm: add device coherent vma selection for memory migration
>>       mm/gup: fail get_user_pages for LONGTERM dev coherent type
>>       drm/amdkfd: add SPM support for SVM
>>       drm/amdkfd: coherent type as sys mem on migration to ram
>>       lib: test_hmm add ioctl to get zone device type
>>       lib: test_hmm add module param for zone device type
>>       lib: add support for device coherent type in test_hmm
>>       tools: update hmm-test to support device coherent type
>>       tools: update test_hmm script to support SP config
>>
>> Alistair Popple (2):
>>       mm: remove the vma check in migrate_vma_setup()
>>       mm/gup: migrate device coherent pages when pinning instead of failing
> 
> ... I thought DEVICE_COHERENT is still under development?
> 

After verifying that I'm not daydreaming [1] (and realizing that I had
review comments to some of these patches that have not been resolved
yet) and also not spotting these change in your changelog above, I
assume this stuff was included by mistake. NACK to merging
DEVICE_COHERENT at this point.

[1] https://lkml.kernel.org/r/20220310172633.9151-1-alex.sierra@amd.com


-- 
Thanks,

David / dhildenb

