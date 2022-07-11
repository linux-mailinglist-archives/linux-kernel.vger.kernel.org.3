Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AE456D6C1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiGKH0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiGKH0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:26:16 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F7217AA3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:26:15 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id i128-20020a1c3b86000000b003a2ce31b4f8so4479814wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=t/PqRBXDv8XnbGqXCKFv3DtaQWbjJ/k2C/kwgKRLS8c=;
        b=SCFXq1nfYobOAwlRKYd50zeNz2wJyny1c0M+7nes2JxU4njk6mzBs9jEeFDN4PuYet
         Ave52lUzwL0R4iw+kc066bJkVLCtBFI1toXwXn7f6Un+YuX3ZsAuy+4LgRmdIqOxz2tS
         jkVznlF7REbbg7PR+xCkNW0HVzeEe03KeNo2vyiqndvITucQgxRrPZjzGii724sx8R1y
         kSVmIJ2mbKQqbLKcAvQom3qhm7ljLUQaCB9ikKPJ6Eip5iUc3oAS8orX/LdLLlKWL5sW
         /f5Rp3DJPSbxuRGjkYjSQ5fSl1oKbaEjkxO7rXB2dWT8v2ScYmTNV5ssj5qa7Ehb8tBV
         kwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t/PqRBXDv8XnbGqXCKFv3DtaQWbjJ/k2C/kwgKRLS8c=;
        b=k3mFcpznm+J0+D8BIsG216pIy2iSgDSwGdmvoqiZFNrW/rELP5LIMLA4eSke3ARXxF
         +YVZ4DJL6H5TN1Pj6ly9d4ZZgVTBqsxBy2jM2e33i3CMxO/trcrnsU761SNdgFnNsg03
         F5bReRgscXV/GG/A0KpjQTj/hSUumW9sXQDbnAj7Xbh3qdvQ5NEs1nmHjaupO/Vhzv/s
         +e7ojSQvCp5Qw8A8e4Lo8eBju9L9MZUt24zysDeYjGh9f+zzDAayvW5XBuKimjaaSuPK
         F7O6ED3IHdu4MWypVtNaMTWuqU8VJeaIuIyariqnV2Axi3tiklurVPR257Bgp0DubmlV
         1ZsA==
X-Gm-Message-State: AJIora+EydHU9FScbYq3EIeol41BZkOjhW32Itdw8RPQ0zsTDQJqiRet
        MFrKUcOJwmgQnBQrHlXPsfEgEA==
X-Google-Smtp-Source: AGRyM1uNu4zxhtyxybrkVox/XEc9FSkT3LpZkh5+naANwfdc/8jbNfqrSS/S31sCE69W6rNsJP1ySw==
X-Received: by 2002:a7b:cbcb:0:b0:3a2:e899:7dc9 with SMTP id n11-20020a7bcbcb000000b003a2e8997dc9mr3200161wmi.82.1657524373754;
        Mon, 11 Jul 2022 00:26:13 -0700 (PDT)
Received: from [10.35.4.171] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id j30-20020a05600c1c1e00b003a02de5de80sm9103140wms.4.2022.07.11.00.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 00:26:13 -0700 (PDT)
Message-ID: <683344bd-dc9b-0bb5-9377-b3e9ab410a74@sifive.com>
Date:   Mon, 11 Jul 2022 08:26:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] swiotlb: ensure io_tlb_default_mem spinlock always
 initialised
Content-Language: en-GB
To:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, iommu@lists.linux-foundation.org
Cc:     Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
References: <20220708170811.270589-1-ben.dooks@sifive.com>
 <fdf5d34e-7668-c05c-9098-30e34939c88a@arm.com>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <fdf5d34e-7668-c05c-9098-30e34939c88a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2022 21:32, Robin Murphy wrote:
> On 2022-07-08 18:08, Ben Dooks wrote:
>> If the io_tlb_default_mem is used by a device that then gets used
>> by the swiotlb code, the spinlock warning is triggered causing a
>> lot of stack-trace.
> 
> Hang on, how have we got as far as trying to allocate out of an 
> uninitialised SWIOTLB at all? That seems like either something's gone 
> more fundamentally wrong or we're missing a proper check somewhere. I 
> don't think papering over it like this is right.
> 
> Thanks,
> Robin
We have a system where we have no DMA capable memory in the 32bit
window, which means even if we initialise swiotlb we don't have
any dma capable memory. The code says go use an IOMMU but we don't
have one of those either (and all peripherals are capable of DMA
from any of the memory, so there shouldn't be the need for one)

Is there any other way of fixing this DMA allocation issue?

I added this fix as swiotlb prints an error but also causes
an annoying stack backtrace.

> 
>> Fix this by making the structure's lock initialised at build time.
>>
>> Avoids the following BUG trigger:
>>
>> [    3.046401] BUG: spinlock bad magic on CPU#3, kworker/u8:0/7
>> [    3.046689]  lock: io_tlb_default_mem+0x30/0x60, .magic: 00000000, 
>> .owner: <none>/-1, .owner_cpu: 0
>> [    3.047217] CPU: 3 PID: 7 Comm: kworker/u8:0 Not tainted 
>> 5.17.0-00056-g1e9bac738084-dirty #310
>> [    3.048363] Workqueue: events_unbound deferred_probe_work_func
>> [    3.048892] Call Trace:
>> [    3.049224] [<ffffffff800048aa>] dump_backtrace+0x1c/0x24
>> [    3.049576] [<ffffffff805c5f74>] show_stack+0x2c/0x38
>> [    3.049898] [<ffffffff805cade2>] dump_stack_lvl+0x40/0x58
>> [    3.050216] [<ffffffff805cae0e>] dump_stack+0x14/0x1c
>> [    3.050460] [<ffffffff805c69f6>] spin_dump+0x62/0x6e
>> [    3.050681] [<ffffffff8004e000>] do_raw_spin_lock+0xb0/0xd0
>> [    3.050934] [<ffffffff805d5b58>] _raw_spin_lock_irqsave+0x20/0x2c
>> [    3.051157] [<ffffffff80067e38>] swiotlb_tbl_map_single+0xce/0x3da
>> [    3.051372] [<ffffffff80068320>] swiotlb_map+0x3a/0x15c
>> [    3.051668] [<ffffffff80065a56>] dma_map_page_attrs+0x76/0x162
>> [    3.051975] [<ffffffff8031d542>] dw_pcie_host_init+0x326/0x3f2
>>
>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>> ---
>>   kernel/dma/swiotlb.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index cb50f8d38360..a707a944c39a 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>> @@ -65,7 +65,7 @@
>>   static bool swiotlb_force_bounce;
>>   static bool swiotlb_force_disable;
>> -struct io_tlb_mem io_tlb_default_mem;
>> +struct io_tlb_mem io_tlb_default_mem = { .lock = 
>> __SPIN_LOCK_UNLOCKED(io_tlb_default_mem.lock) } ;
>>   phys_addr_t swiotlb_unencrypted_base;

