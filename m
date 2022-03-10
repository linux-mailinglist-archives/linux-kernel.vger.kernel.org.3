Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1554D4659
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241800AbiCJL65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiCJL64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:58:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C54244771
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646913473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TZYKuCaufEHQEij7wfPKMNByDrNFZ28XleuZYsmHjGY=;
        b=NDY1w0Uswzzw3tqztgi59vbCMNffVIAH6Z5NUj8fs7jbCKw8lMeEqDcM7Au5cEwsnxeCL6
        gohQqeH2tv78z+Z0wf8WJmOjNEdKzfLXdeDoEzVapT1RhM27t2sCfCQ7INVrAxw9U22AGb
        WPdJtBLdxY/ns3N8gz8bo63stDEp854=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-IV1SI8S_ML6VkiwIlYqGMA-1; Thu, 10 Mar 2022 06:57:52 -0500
X-MC-Unique: IV1SI8S_ML6VkiwIlYqGMA-1
Received: by mail-wm1-f69.google.com with SMTP id 20-20020a05600c231400b00389886f6b23so2192630wmo.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:57:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=TZYKuCaufEHQEij7wfPKMNByDrNFZ28XleuZYsmHjGY=;
        b=1vA+JvLbgHOOQylUu8AY62Nt+7Z6M9scYS6Tn2kuCezURd2ec2MWufJs2cDidpsZ6y
         7kX9Yzji0SV3STEOBuQnXBfSeNWf+LoFIFRkvDWX2tye4dFx9fApNMIo8/5M6YNwT4Qf
         rEdrakeF8yGzlRkWxc6V4pVHbPjxJbrm5L/edGWdK32Yo2aJt735t4k12Iu02xnDBgZ7
         mQ3Npe2i7pgULVTk9DXm/3VwvvmHfSUUdn5Y/qvvMhog/tARB2+RmCahuBo0rBt6AFzf
         vDnwfR652ee1CjDf5MyP4dIZTso2fhcbaIrMtT3Qr/ynTqr9wnmnQHmUf45aqOvRWIsM
         KqKg==
X-Gm-Message-State: AOAM530gwx3VdbrQ5Vn4kRms8k4tEJvjMnYt0V5uZLmHGCD59tRpXk2t
        o5zXmGOybLu9OZwavR/n7/YERn1dJlaYzLhOFAV6rSFrbbsHI/nVsb/XQ3FSC5zBL9ZXvSvtXN/
        QwapswH2eRX53K5zEBKxPqPMB
X-Received: by 2002:a5d:55c7:0:b0:1f0:48cf:9568 with SMTP id i7-20020a5d55c7000000b001f048cf9568mr3369498wrw.379.1646913470862;
        Thu, 10 Mar 2022 03:57:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz++U/wpOl6a/LR9/pa8J/lU8vzFbnm6yXOHWBiLvHSzFRpfwBSs9aGyz2BZYkaAeFm9lCKaA==
X-Received: by 2002:a5d:55c7:0:b0:1f0:48cf:9568 with SMTP id i7-20020a5d55c7000000b001f048cf9568mr3369473wrw.379.1646913470442;
        Thu, 10 Mar 2022 03:57:50 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id z3-20020a1cf403000000b0037d1f4a2201sm4365294wma.21.2022.03.10.03.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 03:57:49 -0800 (PST)
Message-ID: <f2b40094-0117-e9f0-7dd8-375bed12fd6e@redhat.com>
Date:   Thu, 10 Mar 2022 12:57:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 00/15] mm: COW fixes part 2: reliable GUP pins of
 anonymous pages
Content-Language: en-US
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        Khalid Aziz <khalid.aziz@oracle.com>
References: <20220308141437.144919-1-david@redhat.com>
 <CAHk-=wiA0KMVbLacK-Gi5_ZsZhXVi++6ePTtPrJkgf0az7r2ww@mail.gmail.com>
 <d615d51d-8643-190e-9cc2-844a28a349cf@redhat.com>
 <CAFCwf10NyRmcsDVH+j5B=FDfjquqmDUjYb=Hzn2OUCxOAFE+-w@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAFCwf10NyRmcsDVH+j5B=FDfjquqmDUjYb=Hzn2OUCxOAFE+-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.03.22 12:13, Oded Gabbay wrote:
> On Wed, Mar 9, 2022 at 10:00 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 08.03.22 22:22, Linus Torvalds wrote:
>>> On Tue, Mar 8, 2022 at 6:14 AM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> This series fixes memory corruptions when a GUP pin (FOLL_PIN) was taken
>>>> on an anonymous page and COW logic fails to detect exclusivity of the page
>>>> to then replacing the anonymous page by a copy in the page table [...]
>>>
>>> From a cursory scan of the patches, this looks sane.
>>
>> Thanks for skimming over the patches that quickly!
>>
>>>
>>> I'm not sure what the next step should be, but I really would like the
>>> people who do a lot of pinning stuff to give it a good shake-down.
>>> Including both looking at the patches, but very much actually running
>>> it on whatever test-cases etc you people have.
>>>
>>> Please?
> 
> I can take this patch-set and test it in our data-center with all the
> DL workloads we are running
> on Gaudi.

Perfect!

> 
> David,
> Any chance you can prepare me a branch with your patch-set based on 5.17-rc7 ?
> I prefer to take a stable kernel and not 5.18-rc1 as this is going to
> run on hundreds of machines.

https://github.com/davidhildenbrand/linux/tree/cow_fixes_part_2_v1

contains the state of this series, based on v5.17-rc7 and part 1.

I'll be leaving that branch unmodified when working on newer versions of
the patch set.

-- 
Thanks,

David / dhildenb

