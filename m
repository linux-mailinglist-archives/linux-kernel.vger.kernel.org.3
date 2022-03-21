Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75344E2EBA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351573AbiCUREs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348597AbiCUREp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:04:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EB403A180
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647882195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EclEiKMklxZUr7OGPO5BRpXOeKGJirkfk6SbSBfmrPU=;
        b=ckFUX1/aWpU1ZWTltlfuM2KA05ZIc4C67hlDCq3xWf5OQhL3hACxxCXlqgi7d+wrfX8TtP
        terwApsnBWwOzGgauaVaVHEJEU30XSEcounaGf9Nz5OxW9kdAunxFqTzm8VNBWpPblYv9J
        z/Ybnfe5pDOWTrK9zr68P2evm2hgRNw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-CwNoBoZOO8C1h2wfGitm8Q-1; Mon, 21 Mar 2022 13:03:14 -0400
X-MC-Unique: CwNoBoZOO8C1h2wfGitm8Q-1
Received: by mail-wr1-f69.google.com with SMTP id j67-20020adf9149000000b00203e6b7d151so2575704wrj.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=EclEiKMklxZUr7OGPO5BRpXOeKGJirkfk6SbSBfmrPU=;
        b=xP1eYNRTxnVAATRb8ixgmjKBCyrUYinPtLPLJoJDRu2C9EC76DdXxULaH99gUHV/B7
         C87ikvRr4/jS7qO8lVvOcM1050TPLD5sOmpF89BKut4SeGvXKFjNwybKl+ZhkpIWP/40
         +5HpFvWd+fr1dPM6Cd/tX8tVipnFmD/oaWNATkIGycKLrVAzuAx0hiE4iRR4Pgq5Q/Jl
         t/RoqrwYA2C7X3Tagt7n58WCV1P5UHqoCi1SLe8e+Y2/7y9xwDOdXtT/QQyq8mbgso0F
         4zvRV/TDpa6JBfVGi64DRoF8z7AIv01Cxmm1a0hR28jDk70xciuBxnozKl0yYB8yCDJr
         9fQw==
X-Gm-Message-State: AOAM531svHbDxdUPoXZ8l/as8zdB+Kx/pupybygbjmxFH+h16+WzHTQz
        tUlz9yUhjfxz7Bcj2g6T/HWl1Kfqr6+nD8FRu9ScxkTcXWXnLAtXpgWvprXAJZS49MBusGo5ptv
        a2wjjfxH30nV5sl/5698dCaG4
X-Received: by 2002:a5d:64cf:0:b0:203:7b90:d5e2 with SMTP id f15-20020a5d64cf000000b002037b90d5e2mr19538782wri.558.1647882193076;
        Mon, 21 Mar 2022 10:03:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvImHlCG5CDP1kC2Dto2EW/ZdzaohTgUrRPghuZ9mun31abRhLo+76ZEmCAWgycKVrY5zGvQ==
X-Received: by 2002:a5d:64cf:0:b0:203:7b90:d5e2 with SMTP id f15-20020a5d64cf000000b002037b90d5e2mr19538745wri.558.1647882192728;
        Mon, 21 Mar 2022 10:03:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:4900:849b:f76e:5e1f:ff95? (p200300cbc7044900849bf76e5e1fff95.dip0.t-ipconnect.de. [2003:cb:c704:4900:849b:f76e:5e1f:ff95])
        by smtp.gmail.com with ESMTPSA id r13-20020adfbb0d000000b00203e0efdd3bsm13613365wrg.107.2022.03.21.10.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 10:03:12 -0700 (PDT)
Message-ID: <74cd5e99-a52b-610c-89aa-a5fac43cdab6@redhat.com>
Date:   Mon, 21 Mar 2022 18:03:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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
 <d5676cf0-30f9-8497-95a8-332767dede46@redhat.com>
 <YjiaSbUBLJP+9Jtt@casper.infradead.org>
 <9ece8da5-ae0c-fe1c-ff2f-961f641c00fe@redhat.com>
 <YjittBLCYpft5ALc@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [GIT PULL] Folio patches for 5.18 (MM part)
In-Reply-To: <YjittBLCYpft5ALc@casper.infradead.org>
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

On 21.03.22 17:54, Matthew Wilcox wrote:
> On Mon, Mar 21, 2022 at 04:38:22PM +0100, David Hildenbrand wrote:
>> On 21.03.22 16:31, Matthew Wilcox wrote:
>>>>>> Alex Sierra (10):
>>>>>>       mm: add zone device coherent type memory support
>>>>>>       mm: add device coherent vma selection for memory migration
>>>>>>       mm/gup: fail get_user_pages for LONGTERM dev coherent type
>>>>>>       drm/amdkfd: add SPM support for SVM
>>>>>>       drm/amdkfd: coherent type as sys mem on migration to ram
>>>>>>       lib: test_hmm add ioctl to get zone device type
>>>>>>       lib: test_hmm add module param for zone device type
>>>>>>       lib: add support for device coherent type in test_hmm
>>>>>>       tools: update hmm-test to support device coherent type
>>>>>>       tools: update test_hmm script to support SP config
>>>>>>
>>>>>> Alistair Popple (2):
>>>>>>       mm: remove the vma check in migrate_vma_setup()
>>>>>>       mm/gup: migrate device coherent pages when pinning instead of failing
>>>>>
>>>>> ... I thought DEVICE_COHERENT is still under development?
>>>>>
>>>>
>>>> After verifying that I'm not daydreaming [1] (and realizing that I had
>>>> review comments to some of these patches that have not been resolved
>>>> yet) and also not spotting these change in your changelog above, I
>>>> assume this stuff was included by mistake. NACK to merging
>>>> DEVICE_COHERENT at this point.
>>>>
>>>> [1] https://lkml.kernel.org/r/20220310172633.9151-1-alex.sierra@amd.com
>>>
>>> That patch ("split vm_normal_pages for LRU and non-LRU handling") isn't
>>> included in this pull request.  The patches I have were those sent by
>>> Christoph here:
>>>
>>> https://lore.kernel.org/linux-mm/20220210072828.2930359-1-hch@lst.de/
>>>
>>> I can drop any patches that you have objections to, but I don't see
>>> any objections from you to any patches in that list.
>>
>> Well, I was discussing with the original authors about how to proceed.
>>
>> Quoting from:
>>
>> https://lkml.kernel.org/r/1747447c-202d-9195-9d44-57f299be48c4@amd.com
>>
>> "
>> Yes, it should be part of that series. Alex developed it on top of the
>> series for now. But I think eventually it would need to be spliced into it.
> 
> It wasn't clear to me that you were talking about this series.
> 
>> Patch1 would need to go somewhere before the other DEVICE_COHERENT
>> patches (with minor modifications). Patch 2 could be squashed into
>> "tools: add hmm gup test for long term pinned device pages" or go next
>> to it. Patch 3 doesn't have a direct dependency on device-coherent
>> pages. It only mentions them in comments.
>> "
>>
>> I can understand that Christoph included a rebased version in his rework
>> (to keep it working in -next and/or help the original authors?), but to
>> me that doesn't mean that the feature is finally done.
> 
> OK, so you object to the last 12 patches from Alistair and Alex?  And
> you're OK with the preceeding 15 patches from Christoph?  I can put
> together a pull request for that combination.
> 

Yes, I'm only concerned about the new feature (DEVICE_COHERENT),
essentially what is still under discussion in [1] and [2]
  [PATCH v6 00/10] Add MEMORY_DEVICE_COHERENT for coherent device memory
  mapping
  [PATCH v2 0/3] Migrate device coherent pages on get_user_pages()

I think these should be the patches from Alex and Alistair. I'm happy to
see Christoph's ZONE_DEVICE refocunt changes upstream ;)

[1] https://lkml.kernel.org/r/20220201154901.7921-1-alex.sierra@amd.com
[2]
https://lkml.kernel.org/r/cover.0d3c846b1c6c294e055ff7ebe221fab9964c1436.1644207242.git-series.apopple@nvidia.com
-- 
Thanks,

David / dhildenb

