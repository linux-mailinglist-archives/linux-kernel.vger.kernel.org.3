Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E0D53578C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 04:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbiE0C0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 22:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiE0C00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 22:26:26 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4285FF5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 19:26:25 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id t4so69079pld.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 19:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GTmACc9N/3MLTj6poPRyGy9qcVFfRLI5Sz32EZV0z38=;
        b=COgXgMZDG8WkP+lglV2Qm8KiYg3OYMJ6q8zRmVVu4YCQhwnr7YHTclag8GvN6sPpqj
         snyshILu0mVF35uUzY3IlNV9lWALJRWgtcJCwaJ1up/VKMnneFH4I2c4Q/SuqpcT+xJS
         daVWNio46q8qRqPTPGJPc/nGy+VQMvmJMExBR9jsfPXJBRsunsvuvv5c2vRI0uGs/H42
         MTteQDv/PoLH7V0fx1W/rcVnFrgqRC/gawvBOz1wSEkGDK7M7tYwSvQDJ1Mj4yC2oeGq
         NBkIf5iBnZvgvG6zmmMCX9Uo0b9ZtH+3JN2JND1LiwxJgkKye5t/48JP60vScOgML+au
         nF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GTmACc9N/3MLTj6poPRyGy9qcVFfRLI5Sz32EZV0z38=;
        b=AjCncZKgVe9PhuwBejH/d86WW550uFetyYjH/ct7p1m3jXEQWmxcBIi2A68qpLnSqU
         zQZIbv4B9OKS1kH7XxiV2V3ZK2w0PwC9eiH7GdlDC68tcC5JwBCpXP7gqM9J4eG7am+2
         8YEx16S2Wv0zfpPtBC2jWNB/K1hpjwWHbwbimriOPLbCJdb7csCAGD9HRfe4g6WQo0GP
         2X59f7DvoRHy7vff9J0ZFRWNHsol37ejUFCxRNpP8BeE4vnvWs/nnZHm8rFQPmMGi89Y
         /vut56UeevBZdJGCiqTDThQhr8OfkVi9BgtscZ7zHCMykvRv5DT31JmbF/QeZpcbLXJq
         5HXA==
X-Gm-Message-State: AOAM532TNZxPh9QEs2JLtGB4w+nwrHigmzAkr+DODLXGyizoO4dMQp7a
        LTalXQLx3JTla50uOfm8YHwXfA==
X-Google-Smtp-Source: ABdhPJwG+lmKSHcrxP6YtEa7GiL6Nr6zjRjr3nP+ihLp9L087u1RV9dVoYNbsckRgYc6uXjSvJ5U9w==
X-Received: by 2002:a17:902:bf06:b0:14d:8c72:96c6 with SMTP id bi6-20020a170902bf0600b0014d8c7296c6mr40633154plb.156.1653618384636;
        Thu, 26 May 2022 19:26:24 -0700 (PDT)
Received: from [10.255.70.20] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902690200b0015f4b7a012bsm2247113plk.251.2022.05.26.19.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 19:26:23 -0700 (PDT)
Message-ID: <27062739-74af-7deb-2486-45bb84888433@bytedance.com>
Date:   Fri, 27 May 2022 10:22:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Re: [PATCH 3/3] virtio_balloon: Introduce memory recover
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com
Cc:     david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        pbonzini@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org
References: <20220520070648.1794132-1-pizhenwei@bytedance.com>
 <20220520070648.1794132-4-pizhenwei@bytedance.com>
 <20220526151507-mutt-send-email-mst@kernel.org>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20220526151507-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/22 03:18, Michael S. Tsirkin wrote:
> On Fri, May 20, 2022 at 03:06:48PM +0800, zhenwei pi wrote:
>> Introduce a new queue 'recover VQ', this allows guest to recover
>> hardware corrupted page:
>>
>> Guest              5.MF -> 6.RVQ FE    10.Unpoison page
>>                      /           \            /
>> -------------------+-------------+----------+-----------
>>                     |             |          |
>>                  4.MCE        7.RVQ BE   9.RVQ Event
>>   QEMU             /               \       /
>>               3.SIGBUS              8.Remap
>>                  /
>> ----------------+------------------------------------
>>                  |
>>              +--2.MF
>>   Host       /
>>         1.HW error
>>
>> The workflow:
>> 1, HardWare page error occurs randomly.
>> 2, host side handles corrupted page by Memory Failure mechanism, sends
>>     SIGBUS to the user process if early-kill is enabled.
>> 3, QEMU handles SIGBUS, if the address belongs to guest RAM, then:
>> 4, QEMU tries to inject MCE into guest.
>> 5, guest handles memory failure again.
>>
>> 1-5 is already supported for a long time, the next steps are supported
>> in this patch(also related driver patch):
>> 6, guest balloon driver gets noticed of the corrupted PFN, and sends
>>     request to host side by Recover VQ FrontEnd.
>> 7, QEMU handles request from Recover VQ BackEnd, then:
>> 8, QEMU remaps the corrupted HVA fo fix the memory failure, then:
>> 9, QEMU acks the guest side the result by Recover VQ.
>> 10, guest unpoisons the page if the corrupted page gets recoverd
>>      successfully.
>>
>> Then the guest fixes the HW page error dynamiclly without rebooting.
>>
>> Emulate MCE by QEMU, the guest works fine:
>>   mce: [Hardware Error]: Machine check events logged
>>   Memory failure: 0x61646: recovery action for dirty LRU page: Recovered
>>   virtio_balloon virtio5: recovered pfn 0x61646
>>   Unpoison: Unpoisoned page 0x61646 by virtio-balloon
>>   MCE: Killing stress:24502 due to hardware memory corruption fault at 7f5be2e5a010
>>
>> The 'HardwareCorrupted' in /proc/meminfo also shows 0 kB.
>>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   drivers/virtio/virtio_balloon.c     | 243 ++++++++++++++++++++++++++++
>>   include/uapi/linux/virtio_balloon.h |  16 ++
>>   2 files changed, 259 insertions(+)
>>
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>> index f4c34a2a6b8e..f9d95d1d8a4d 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -52,6 +52,7 @@ enum virtio_balloon_vq {
>>   	VIRTIO_BALLOON_VQ_STATS,
>>   	VIRTIO_BALLOON_VQ_FREE_PAGE,
>>   	VIRTIO_BALLOON_VQ_REPORTING,
>> +	VIRTIO_BALLOON_VQ_RECOVER,
>>   	VIRTIO_BALLOON_VQ_MAX
>>   };
>>   
>> @@ -59,6 +60,12 @@ enum virtio_balloon_config_read {
>>   	VIRTIO_BALLOON_CONFIG_READ_CMD_ID = 0,
>>   };
>>   
>> +/* the request body to commucate with host side */
>> +struct __virtio_balloon_recover {
>> +	struct virtio_balloon_recover vbr;
>> +	__virtio32 pfns[VIRTIO_BALLOON_PAGES_PER_PAGE];
>> +};
>> +
> 
> 
> I don't think this idea of passing 32 bit pfns is going to fly.
> What is wrong with just passing the pages normally as a s/g list?
> this is what is done for the hints at the moment.
> 
> neither should you use __virtio types for new functionality
> (should all be __le), nor use __virtio for the struct name.
> 
> 

Guest side sends GPA/PFN to host side by passing the pages normally as a 
s/g list, this is OK.

But in this scenario, guest also needs to get 
status(recovered?corrupted?failed to recover?) of page from the host side.

For a normal page(Ex, 4K), the host could return the status quite 
immediately. But for the 2M hugetlb of guest RAM, the host should be 
pending until the guest requests 512*4K to recover. Once the 2M hugepage 
gets recovered(or failed to recover), the host returns 512 PFNs with 
status to guest. There are at most 512 recover requests of a single 2M 
huge page.

For example, the guest tries to recover a corrupted page:
struct scatterlist status_sg, page_sg, *sgs[2];

sg_init_one(&status_sg, status, sizeof(*status));
sgs[0] = &status_sg;

p = page_address(page);
sg_init_one(&page_sg, p, PAGE_SIZE);
sgs[1] = &page_sg;

virtqueue_add_sgs(recover_vq, sgs, 1, 1, NULL, GFP_ATOMIC);

The host handles 4K recover request on 2M hugepage, this request is 
pending until the full 2M huge page gets recovered(or failed).

To avoid too many pending request in virt queue, I designed as this 
patch(should use __le), passing PFN in request body, using a single IN 
request only.


...
>> --- a/include/uapi/linux/virtio_balloon.h
>> +++ b/include/uapi/linux/virtio_balloon.h
>> @@ -37,6 +37,7 @@
>>   #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
>>   #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
>>   #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
>> +#define VIRTIO_BALLOON_F_RECOVER	6 /* Memory recover virtqueue */
>>   
>>   /* Size of a PFN in the balloon interface. */
>>   #define VIRTIO_BALLOON_PFN_SHIFT 12
> 
> Please get this feature recorded in the spec with the virtio TC.
> They will also ask you to supply minimal documentation.
> 

Sure!
By the way, this feature depends on the memory&&memory-failure 
mechanism, what about sending the change of spec to virtio TC after 
Andrew and Naoya ack?

-- 
zhenwei pi
