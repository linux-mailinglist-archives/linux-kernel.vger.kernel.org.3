Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D95D4E2BA0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349897AbiCUPST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349890AbiCUPSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:18:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07F0110EC5A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647875809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nX4QZCO/oNI/owmGNcTSGcMnEF5mlfrSVaizLBz7uJ0=;
        b=buoEHscV8d93rWe5zHzGJmIyTgBhH+xN63JqSUIhUnCGV7/AYpMQbcUKYrgYmiKa1bjnlb
        m4x7O615a7tjxhtxFSODOISeTvo/Ue192l503kI4evEeiekCP4wLPVJUJSQucWue0r8v6R
        PT7YuzQCWhyHoeIwRUmRLG95uLT7pfo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-32-J4n9EuznNs-N3PQXTFnW8g-1; Mon, 21 Mar 2022 11:16:46 -0400
X-MC-Unique: J4n9EuznNs-N3PQXTFnW8g-1
Received: by mail-wr1-f69.google.com with SMTP id 71-20020adf82cd000000b00203dc43d216so3191693wrc.22
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=nX4QZCO/oNI/owmGNcTSGcMnEF5mlfrSVaizLBz7uJ0=;
        b=GcSjvf3FxYGpRXMqJGVu4+1K4h2uAhsjLCZTTHg1o7ECkHqXBsUcbqQbtFtlY7hUeN
         KbUQcUxjnx3NlZopO2HT9Ot5pjUWJGHCslCvtfHokzHE1Y7w7qPw/lHVQzEoLNnApodc
         M0jX7Kc2oaig74RLNnYYMIyYs4hC85wMXXgOaxvi2tt7UkkiqI+h0SN8FIXDXi/hnmjQ
         t7RxgKJs5GyW/Tl/c44tgV8YJqBBsm3G5PCyhO/W2X32goGNcp/wVoJpJ85HqYukTdbM
         YmpIVVHIcJY+c7d/40G0A0f+Ut1GB7fKPeWuyiR3cih3X1g4bVts+h7A9Xy8MzHySKL/
         OMTQ==
X-Gm-Message-State: AOAM530N/JKlwcxw8706ckE8bmtnVGpqbfl8BkLUN5MRvGnmodA1rjy4
        Ow90zOZuvcLPNtkJVMXLTrz+Q4KAfQiUQPrU9If6SBs3ClquDelJSq7BoVKNZSvQwNi9xRLdGUx
        QssYk619urAjZp3IMdCkYpc9k
X-Received: by 2002:a5d:5690:0:b0:203:f727:362 with SMTP id f16-20020a5d5690000000b00203f7270362mr13336324wrv.717.1647875805651;
        Mon, 21 Mar 2022 08:16:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzTIc10MZuTh5WcD+YFZa7hXvGCjsQ2g+VK/yHzoP82TjLC4Ii/L09EZIrxSnI/6aUkzWG0g==
X-Received: by 2002:a5d:5690:0:b0:203:f727:362 with SMTP id f16-20020a5d5690000000b00203f7270362mr13336299wrv.717.1647875805316;
        Mon, 21 Mar 2022 08:16:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:4900:849b:f76e:5e1f:ff95? (p200300cbc7044900849bf76e5e1fff95.dip0.t-ipconnect.de. [2003:cb:c704:4900:849b:f76e:5e1f:ff95])
        by smtp.gmail.com with ESMTPSA id i5-20020adfaac5000000b00203fd04bf86sm7526495wrc.66.2022.03.21.08.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 08:16:44 -0700 (PDT)
Message-ID: <9ae0a8e4-41b7-04f4-4435-17cbba9850fb@redhat.com>
Date:   Mon, 21 Mar 2022 16:16:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [GIT PULL] Folio patches for 5.18 (MM part)
Content-Language: en-US
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Yjh+EuacJURShtJI@casper.infradead.org>
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

On 21.03.22 14:30, Matthew Wilcox wrote:
> Hi Linus,
> 
> This is the first of two folio-related pull requests for this merge
> window.  This is the MM side of things and we had some unfortunate
> complex merge conflicts to resolve.  I decided to redo my changes on
> top of Hugh's and Christoph's patches, so I'm the one sending the
> pull request.
> 
> The following changes since commit f71077a4d84bbe8c7b91b7db7c4ef815755ac5e3:
> 
>   Merge tag 'mmc-v5.17-rc1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc (2022-02-16 12:09:22 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/users/willy/pagecache.git tags/folio-5.18
> 
> for you to fetch changes up to 5063f22c914e3e5f2239cf91f4986042dc705bde:
> 
>   mm/damon: minor cleanup for damon_pa_young (2022-03-16 10:09:50 -0400)
> 
> ----------------------------------------------------------------
> Folio changes for 5.18
> 
> Several of us had overlapping, conflicting changes to the MM this
> round, and I volunteered to send the pull request.
> 
>  - Hugh rewrote how munlock works to massively reduce the contention
>    on i_mmap_rwsem:
>    https://lore.kernel.org/linux-mm/8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com/
>  - Christoph sorted out the page refcount mess for ZONE_DEVICE pages:
>    https://lore.kernel.org/linux-mm/20220210072828.2930359-1-hch@lst.de/
>  - I converted GUP to use folios and make pincount available for order-1
>    pages.
>  - I converted a few more truncation functions to use folios
>  - I converted page_vma_mapped_walk to use PFNs instead of pages
>  - I converted rmap_walk to use folios
>  - I converted most of shrink_page_list() to use a folio
>  - I added support for creating large folios in readahead
> 
> ----------------------------------------------------------------
> Alex Sierra (10):
>       mm: add zone device coherent type memory support
>       mm: add device coherent vma selection for memory migration
>       mm/gup: fail get_user_pages for LONGTERM dev coherent type
>       drm/amdkfd: add SPM support for SVM
>       drm/amdkfd: coherent type as sys mem on migration to ram
>       lib: test_hmm add ioctl to get zone device type
>       lib: test_hmm add module param for zone device type
>       lib: add support for device coherent type in test_hmm
>       tools: update hmm-test to support device coherent type
>       tools: update test_hmm script to support SP config
> 
> Alistair Popple (2):
>       mm: remove the vma check in migrate_vma_setup()
>       mm/gup: migrate device coherent pages when pinning instead of failing

... I thought DEVICE_COHERENT is still under development?


-- 
Thanks,

David / dhildenb

