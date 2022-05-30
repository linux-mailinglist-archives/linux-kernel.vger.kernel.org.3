Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86A153759D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbiE3Hlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbiE3Hla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:41:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33CDB12ABF
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653896488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ioljxq6PuUu4lxQDlH2MK2dNxIoWh+YwDSpERyNHcYc=;
        b=XvvzWp4Bbvuec6SPEujVI3QqJPEREweV2vgK9bMN7ZdrA/6fg0c0ScUCSZ/UJ66eM1qfe0
        oEuRc3xxI5fz59GitkUNXgL1VptzUcrZJF6ra3reUqGGTSvQLeTS4gmLV1TkOLNL2o9xjv
        WeZZLpCR/JOyxrjO9KkWV/i7bIPo5fc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-lLl-GGQbPY2Mcr6iJ0B-TA-1; Mon, 30 May 2022 03:41:25 -0400
X-MC-Unique: lLl-GGQbPY2Mcr6iJ0B-TA-1
Received: by mail-wm1-f69.google.com with SMTP id j40-20020a05600c1c2800b003972dbb1066so9286045wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=Ioljxq6PuUu4lxQDlH2MK2dNxIoWh+YwDSpERyNHcYc=;
        b=vONZ4LKHwLYZIVy8TnHcCu47rvkVLXtui2mZ+HCqxmZRys23WLWLIXg8HPlar1OsRz
         l1B1EpyvMFuqrgSjrcNEA/S84FLVkq6hcJitCtqmuZ7QN48av9bryeGQ3qjeb08q39CU
         Izxwpaxhp/fYt2sRw2d9PjajChe1RgoKih0SzvBrbWKCA4HAlURZ5b+PDb43M9N9Tyaq
         QBXRb3J1ne8P55Ev5XnNNGxi9RYB404E5C5vgLL9r27tenW8iqX5ldtuj3nVdYduh764
         l+KTOvehq3WkySYlKz8c6pqOg6DyDl1kdqkFSgr7lE3SL47K+PxBts719tWCrtIbwXqA
         JD/A==
X-Gm-Message-State: AOAM5312sxGIKrAGvA/Ye/wzytWhNy4CMrZQLaUo6lC1hd3S9zAU1eOy
        KDqXsrKl9SYGfjJk/LzCJZ5E2a+TYMAZuRhn+PK5ciXKMDLR9U90gc0HiT/OX78qYVKBjl0jAVW
        Z2aURjkW5SAua/l5hcikZt5hP
X-Received: by 2002:a05:6000:144f:b0:20f:d6e8:a54 with SMTP id v15-20020a056000144f00b0020fd6e80a54mr30927446wrx.482.1653896483860;
        Mon, 30 May 2022 00:41:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygmIHMNmIMibGNEd206s8mAH/2ItntHqoVW3Fp9CPDeipNv0CP+C+hoSkZ/LeN5Ih++u+6aA==
X-Received: by 2002:a05:6000:144f:b0:20f:d6e8:a54 with SMTP id v15-20020a056000144f00b0020fd6e80a54mr30927434wrx.482.1653896483573;
        Mon, 30 May 2022 00:41:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:7c00:aaa9:2ce5:5aa0:f736? (p200300cbc7047c00aaa92ce55aa0f736.dip0.t-ipconnect.de. [2003:cb:c704:7c00:aaa9:2ce5:5aa0:f736])
        by smtp.gmail.com with ESMTPSA id h9-20020a7bc929000000b003974a3af623sm9688836wml.17.2022.05.30.00.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 00:41:23 -0700 (PDT)
Message-ID: <0d266c61-605d-ce0c-4274-b0c7e10f845a@redhat.com>
Date:   Mon, 30 May 2022 09:41:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     zhenwei pi <pizhenwei@bytedance.com>, Peter Xu <peterx@redhat.com>,
        Jue Wang <juew@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, jasowang@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, mst@redhat.com,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Paolo Bonzini <pbonzini@redhat.com>,
        qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
References: <CAPcxDJ5pduUyMA0rf+-aTjK_2eBvig05UTiTptX1nVkWE-_g8w@mail.gmail.com>
 <Yo/I3oLkd9OU0ice@xz-m1.local>
 <24a95dea-9ea6-a904-7c0b-197961afa1d1@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 0/3] recover hardware corrupted page by virtio balloon
In-Reply-To: <24a95dea-9ea6-a904-7c0b-197961afa1d1@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.05.22 08:32, zhenwei pi wrote:
> On 5/27/22 02:37, Peter Xu wrote:
>> On Wed, May 25, 2022 at 01:16:34PM -0700, Jue Wang wrote:
>>> The hypervisor _must_ emulate poisons identified in guest physical
>>> address space (could be transported from the source VM), this is to
>>> prevent silent data corruption in the guest. With a paravirtual
>>> approach like this patch series, the hypervisor can clear some of the
>>> poisoned HVAs knowing for certain that the guest OS has isolated the
>>> poisoned page. I wonder how much value it provides to the guest if the
>>> guest and workload are _not_ in a pressing need for the extra KB/MB
>>> worth of memory.
>>
>> I'm curious the same on how unpoisoning could help here.  The reasoning
>> behind would be great material to be mentioned in the next cover letter.
>>
>> Shouldn't we consider migrating serious workloads off the host already
>> where there's a sign of more severe hardware issues, instead?
>>
>> Thanks,
>>
> 
> I'm maintaining 1000,000+ virtual machines, from my experience:
> UE is quite unusual and occurs randomly, and I did not hit UE storm case 
> in the past years. The memory also has no obvious performance drop after 
> hitting UE.
> 
> I hit several CE storm case, the performance memory drops a lot. But I 
> can't find obvious relationship between UE and CE.
> 
> So from the point of my view, to fix the corrupted page for VM seems 
> good enough. And yes, unpoisoning several pages does not help 
> significantly, but it is still a chance to make the virtualization better.
> 

I'm curious why we should care about resurrecting a handful of poisoned
pages in a VM. The cover letter doesn't touch on that.

IOW, I'm missing the motivation why we should add additional
code+complexity to unpoison pages at all.

If we're talking about individual 4k pages, it's certainly sub-optimal,
but does it matter in practice? I could understand if we're losing
megabytes of memory. But then, I assume the workload might be seriously
harmed either way already?


I assume when talking about "the performance memory drops a lot", you
imply that this patch set can mitigate that performance drop?

But why do you see a performance drop? Because we might lose some
possible THP candidates (in the host or the guest) and you want to plug
does holes? I assume you'll see a performance drop simply because
poisoning memory is expensive, including migrating pages around on CE.

If you have some numbers to share, especially before/after this change,
that would be great.

-- 
Thanks,

David / dhildenb

