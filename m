Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511DD4E2C70
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350373AbiCUPj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240321AbiCUPjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:39:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6529C2180B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647877106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IK56FkfaiX8vj6FFbros1BGgufggGCH6F0d0KCKn2Mk=;
        b=Cuu4h5nOgNPMzG/cWdEvPFthGvXBMJTufuXaPoDV4nGI+x2joA3IgMxtkZ7eZcUHdBpTng
        JydUUU/bNH8zSiaBaauQZM4p6yobRtICW9EsU4zmnZAEdtmzOiRGVkcDFzVWE8RSBJj/n/
        IJdWMDuVzgJDkkXKhL5bn8YmZlqAEBw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-1HeltN-FMN2hlc0UyLUCqg-1; Mon, 21 Mar 2022 11:38:25 -0400
X-MC-Unique: 1HeltN-FMN2hlc0UyLUCqg-1
Received: by mail-wm1-f72.google.com with SMTP id i6-20020a05600c354600b0038be262d9d9so9270793wmq.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=IK56FkfaiX8vj6FFbros1BGgufggGCH6F0d0KCKn2Mk=;
        b=MJJ6a70ISWOqx3l+BqRWSgBrXOg+m7MpfNt1xzvVwJQULIjYFmgVwy9rgh6jcqbxHx
         kX3kz67lBchOKwQyURh+1AmedtB++qUDa9KFPKDmVfVudRskpinDW102mFN1PzNYOjUX
         HQSKAUuqGhjjBFZOcqWY/rtt2g0pgup1fYzV17Wseglk2U1WOitvFJki4qzJytxuMa6x
         1KeiQiR8XvcxHhIusxCdXCSO9uI6MsE61nGTQOtFTGrFXKhG0IoVFPTDXWV4AjtXLOJt
         nqwf3Q/hQqOzDB/fywkf4ukWyVEoLJReWUvaCTOPrYPEcb9JKRzrKCnEHNdRWTvHh4O+
         X9lw==
X-Gm-Message-State: AOAM531RMviyWrHOEj8c2PBNe5BpugseKwWtPQbYrU4zUIW9xNT+p9C9
        YkWgCEPRU5szRK+Vk3x7msfJv2BewK+KlkAq8QH+Qahq25F10mWUqk5260Og4T6XIR1HTcgMkFD
        wIgf3zPJX1ULFuo1nuUH9C0kF
X-Received: by 2002:a5d:6da5:0:b0:1f1:f968:1a62 with SMTP id u5-20020a5d6da5000000b001f1f9681a62mr19118924wrs.227.1647877103964;
        Mon, 21 Mar 2022 08:38:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJys4YpAtiVdUKa/+qbQgq/FGiMD5QA9HPxmGExmBsZMeDmqFq2njLygrGsf2E9s17Exez4gmQ==
X-Received: by 2002:a5d:6da5:0:b0:1f1:f968:1a62 with SMTP id u5-20020a5d6da5000000b001f1f9681a62mr19118906wrs.227.1647877103667;
        Mon, 21 Mar 2022 08:38:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:4900:849b:f76e:5e1f:ff95? (p200300cbc7044900849bf76e5e1fff95.dip0.t-ipconnect.de. [2003:cb:c704:4900:849b:f76e:5e1f:ff95])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0037bb8df81a2sm21194402wmp.13.2022.03.21.08.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 08:38:23 -0700 (PDT)
Message-ID: <9ece8da5-ae0c-fe1c-ff2f-961f641c00fe@redhat.com>
Date:   Mon, 21 Mar 2022 16:38:22 +0100
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [GIT PULL] Folio patches for 5.18 (MM part)
In-Reply-To: <YjiaSbUBLJP+9Jtt@casper.infradead.org>
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

On 21.03.22 16:31, Matthew Wilcox wrote:
> On Mon, Mar 21, 2022 at 04:24:08PM +0100, David Hildenbrand wrote:
>> On 21.03.22 16:16, David Hildenbrand wrote:
>>> On 21.03.22 14:30, Matthew Wilcox wrote:
>>>> Hi Linus,
>>>>
>>>> This is the first of two folio-related pull requests for this merge
>>>> window.  This is the MM side of things and we had some unfortunate
>>>> complex merge conflicts to resolve.  I decided to redo my changes on
>>>> top of Hugh's and Christoph's patches, so I'm the one sending the
>>>> pull request.
>>>>
>>>> The following changes since commit f71077a4d84bbe8c7b91b7db7c4ef815755ac5e3:
>>>>
>>>>   Merge tag 'mmc-v5.17-rc1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc (2022-02-16 12:09:22 -0800)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>   git://git.infradead.org/users/willy/pagecache.git tags/folio-5.18
>>>>
>>>> for you to fetch changes up to 5063f22c914e3e5f2239cf91f4986042dc705bde:
>>>>
>>>>   mm/damon: minor cleanup for damon_pa_young (2022-03-16 10:09:50 -0400)
>>>>
>>>> ----------------------------------------------------------------
>>>> Folio changes for 5.18
>>>>
>>>> Several of us had overlapping, conflicting changes to the MM this
>>>> round, and I volunteered to send the pull request.
>>>>
>>>>  - Hugh rewrote how munlock works to massively reduce the contention
>>>>    on i_mmap_rwsem:
>>>>    https://lore.kernel.org/linux-mm/8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com/
>>>>  - Christoph sorted out the page refcount mess for ZONE_DEVICE pages:
>>>>    https://lore.kernel.org/linux-mm/20220210072828.2930359-1-hch@lst.de/
>>>>  - I converted GUP to use folios and make pincount available for order-1
>>>>    pages.
>>>>  - I converted a few more truncation functions to use folios
>>>>  - I converted page_vma_mapped_walk to use PFNs instead of pages
>>>>  - I converted rmap_walk to use folios
>>>>  - I converted most of shrink_page_list() to use a folio
>>>>  - I added support for creating large folios in readahead
>>>>
>>>> ----------------------------------------------------------------
>>>> Alex Sierra (10):
>>>>       mm: add zone device coherent type memory support
>>>>       mm: add device coherent vma selection for memory migration
>>>>       mm/gup: fail get_user_pages for LONGTERM dev coherent type
>>>>       drm/amdkfd: add SPM support for SVM
>>>>       drm/amdkfd: coherent type as sys mem on migration to ram
>>>>       lib: test_hmm add ioctl to get zone device type
>>>>       lib: test_hmm add module param for zone device type
>>>>       lib: add support for device coherent type in test_hmm
>>>>       tools: update hmm-test to support device coherent type
>>>>       tools: update test_hmm script to support SP config
>>>>
>>>> Alistair Popple (2):
>>>>       mm: remove the vma check in migrate_vma_setup()
>>>>       mm/gup: migrate device coherent pages when pinning instead of failing
>>>
>>> ... I thought DEVICE_COHERENT is still under development?
>>>
>>
>> After verifying that I'm not daydreaming [1] (and realizing that I had
>> review comments to some of these patches that have not been resolved
>> yet) and also not spotting these change in your changelog above, I
>> assume this stuff was included by mistake. NACK to merging
>> DEVICE_COHERENT at this point.
>>
>> [1] https://lkml.kernel.org/r/20220310172633.9151-1-alex.sierra@amd.com
> 
> That patch ("split vm_normal_pages for LRU and non-LRU handling") isn't
> included in this pull request.  The patches I have were those sent by
> Christoph here:
> 
> https://lore.kernel.org/linux-mm/20220210072828.2930359-1-hch@lst.de/
> 
> I can drop any patches that you have objections to, but I don't see
> any objections from you to any patches in that list.

Well, I was discussing with the original authors about how to proceed.

Quoting from:

https://lkml.kernel.org/r/1747447c-202d-9195-9d44-57f299be48c4@amd.com

"
Yes, it should be part of that series. Alex developed it on top of the
series for now. But I think eventually it would need to be spliced into it.

Patch1 would need to go somewhere before the other DEVICE_COHERENT
patches (with minor modifications). Patch 2 could be squashed into
"tools: add hmm gup test for long term pinned device pages" or go next
to it. Patch 3 doesn't have a direct dependency on device-coherent
pages. It only mentions them in comments.
"

I can understand that Christoph included a rebased version in his rework
(to keep it working in -next and/or help the original authors?), but to
me that doesn't mean that the feature is finally done.

-- 
Thanks,

David / dhildenb

