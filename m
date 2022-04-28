Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C628512EE9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344785AbiD1IuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344990AbiD1ItX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:49:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 025AC34B83
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651135459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n3mG7OCWwWi6M3HbCNxE1UVDPEiuEaK15OULCVjtY8o=;
        b=G6MKrfhoWwTjt8AxCAYMlAHhG+KbRNIzsUL8sjKaGM5n/DItIRb74m5IRneaDMN2KioSIP
        /ZssTCzeaBxVAKSqhxBVDeAdVqEVaW+gV1IAYXGgJtzHZrfnRw81G1AdEFpSuxMNDsOHqB
        giPY0UMoxr84+05AKduEoeSg13YPCIc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-127-1PltRjfxNru5bf1GWlYygg-1; Thu, 28 Apr 2022 04:44:18 -0400
X-MC-Unique: 1PltRjfxNru5bf1GWlYygg-1
Received: by mail-wm1-f71.google.com with SMTP id c125-20020a1c3583000000b0038e3f6e871aso1648102wma.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=n3mG7OCWwWi6M3HbCNxE1UVDPEiuEaK15OULCVjtY8o=;
        b=aA1g0nsZcqXhuG3FapC21kDrWwFpsJQgHvSrGTHftO3A+RSBevWTf0jYabOpKD8LBc
         KEbGVbsbJsmP0FFV5jN0mH+iQ3hrDdwjUpR6aycdhN5TFQaLljPIXal7lbGPa73U8Zf0
         RYRqh/n92jimBiF+hSmf03UqXAKfGKxenXMqT4xQUlML2eQ43Bz8kD76mMnEQtMfKMTa
         a42s3L7Q0FVus4UPrzlZ3QKU/8QODDJ1+wwmw223Qlhu750sjK8d9vkMmMzN+B8Qu8xG
         dSytO4Tf9Td32Cb9YjGb6W/5kaTr7PXRjJBpBmawLo9p5yBYVARC0bKCMcKv51/UIsqJ
         fHjQ==
X-Gm-Message-State: AOAM532zXXKmME54HljdzzhVHXUU0zugMRbn6D1Uwb+rv+lENOt5kkGD
        +EbZrhSU/lPWZSBt7NRaXrwVqyR0gQIXWTM+EYi+spukSwJ/yRUBjvuEOlp6XgKcub6ensf91xc
        J/JMziO6uNGADAnSXSO1ALzyo
X-Received: by 2002:a1c:1947:0:b0:392:b883:aac9 with SMTP id 68-20020a1c1947000000b00392b883aac9mr29100876wmz.155.1651135457032;
        Thu, 28 Apr 2022 01:44:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeSreX4jrrkiol2W8yhE4l74/X3ldbnoEnA/m0SAs98NLzNAnN4IKbE3Tf+6522jzFOLuWlA==
X-Received: by 2002:a1c:1947:0:b0:392:b883:aac9 with SMTP id 68-20020a1c1947000000b00392b883aac9mr29100860wmz.155.1651135456802;
        Thu, 28 Apr 2022 01:44:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:ef00:7443:a23c:26b8:b96? (p200300cbc708ef007443a23c26b80b96.dip0.t-ipconnect.de. [2003:cb:c708:ef00:7443:a23c:26b8:b96])
        by smtp.gmail.com with ESMTPSA id bj3-20020a0560001e0300b0020af3d365f4sm1906215wrb.98.2022.04.28.01.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 01:44:16 -0700 (PDT)
Message-ID: <bb1caf48-7e9d-61bf-e0dc-72fcc0228f28@redhat.com>
Date:   Thu, 28 Apr 2022 10:44:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
 <54399815-10fe-9d43-7ada-7ddb55e798cb@redhat.com>
 <20220427122049.GA3918978@hori.linux.bs1.fc.nec.co.jp>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH v1 0/4] mm, hwpoison: improve handling workload
 related to hugetlb and memory_hotplug
In-Reply-To: <20220427122049.GA3918978@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> 2) It happens rarely (ever?), so do we even care?
> 
> I'm not certain of the rarity.  Some cloud service providers who maintain
> lots of servers may care?

About replacing broken DIMMs? I'm not so sure, especially because it
requires a special setup with ZONE_MOVABLE (i.e., movablecore) to be
somewhat reliable and individual DIMMs can usually not get replaced at all.

> 
>> 3) Once the memory is offline, we can re-online it and lost HWPoison.
>>    The memory can be happily used.
>>
>> 3) can happen easily if our DIMM consists of multiple memory blocks and
>> offlining of some memory block fails -> we'll re-online all already
>> offlined ones. We'll happily reuse previously HWPoisoned pages, which
>> feels more dangerous to me then just leaving the DIMM around (and
>> eventually hwpoisoning all pages on it such that it won't get used
>> anymore?).
> 
> I see. This scenario can often happen.
> 
>>
>> So maybe we should just fail offlining once we stumble over a hwpoisoned
>> page?
> 
> That could be one choice.
> 
> Maybe another is like this: offlining can succeed but HWPoison flags are
> kept over offline-reonline operations.  If the system noticed that the
> re-onlined blocks are backed by the original DIMMs or NUMA nodes, then the
> saved HWPoison flags are still effective, so keep using them.  If the
> re-onlined blocks are backed by replaced DIMMs/NUMA nodes, then we can clear
> all HWPoison flags associated with replaced physical address range.  This
> can be done automatically in re-onlining if there's a way for kernel to know
> whether DIMM/NUMA nodes are replaced with new ones.  But if there isn't,
> system applications have to check the HW and explicitly reset the HWPoison
> flags.

Offline memory sections have a stale memmap, so there is no trusting on
that. And trying to work around that or adjusting memory onlining code
overcomplicates something we really don't care about supporting.

So if we continue allowing offlining memory blocks with poisoned pages,
we could simply remember that that memory block had any posioned page
(either for the memory section or maybe better for the whole memory
block). We can then simply reject/fail memory onlining of these memory
blocks.

So that leaves us with either

1) Fail offlining -> no need to care about reonlining
2) Succeed offlining but fail re-onlining

-- 
Thanks,

David / dhildenb

