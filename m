Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464974EBE93
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245306AbiC3KWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbiC3KWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:22:03 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92E41D9140
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 03:20:17 -0700 (PDT)
X-UUID: 89f0138a04c342f1b10e571f5d544420-20220330
X-Spam-Fingerprint: 0
X-GW-Reason: 11101
X-Policy-Incident: 5pS25Lu25Lq66LaF6L+HNeS6uumcgOimgeWuoeaguA==
X-Content-Feature: ica/max.line-size 85
        audit/email.address 2
X-UUID: 89f0138a04c342f1b10e571f5d544420-20220330
Received: from cs2c.com.cn [(172.17.111.24)] by nksmu.kylinos.cn
        (envelope-from <liucong2@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 888474854; Wed, 30 Mar 2022 14:45:11 +0800
X-ns-mid: postfix-6243FCAB-7174744375
Received: from [172.20.12.219] (unknown [172.20.12.219])
        by cs2c.com.cn (NSMail) with ESMTPSA id 686C7383C640;
        Wed, 30 Mar 2022 06:46:03 +0000 (UTC)
Message-ID: <a1ceefb7-32d8-9ce3-e56f-7684e6d3ee58@kylinos.cn>
Date:   Wed, 30 Mar 2022 14:46:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] drm/qxl: fix qxl can't use in arm64
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        airlied@linux.ie, airlied@redhat.com, kraxel@redhat.com,
        robin.murphy@arm.com
Cc:     virtualization@lists.linux-foundation.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, ray.huang@amd.com,
        spice-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <12eba824-ee80-0aac-56ed-e13084c9cae7@amd.com>
 <20220324104928.2959545-1-liucong2@kylinos.cn>
 <982d233d-7e30-f44e-f49d-473c3c41721e@amd.com>
From:   Cong Liu <liucong2@kylinos.cn>
In-Reply-To: <982d233d-7e30-f44e-f49d-473c3c41721e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

any suggestions or extra test I can do now?

Regards,
Cong

On 2022/3/25 15:45, Christian König wrote:
> Am 24.03.22 um 11:49 schrieb Cong Liu:
>> qxl use ioremap to map ram_header and rom, in the arm64 implementation,
>> the device is mapped as DEVICE_nGnRE, it can not support unaligned
>> access. and qxl is a virtual device, it can be treated more like RAM
>> than actual MMIO registers. use ioremap_wc() replace it.
>>
>> Signed-off-by: Cong Liu <liucong2@kylinos.cn>
> 
> Looks sane to me, but I'm really not involved enough to fully judge.
> 
> Acked-by: Christian König <christian.koenig@amd.com>
> 
>> ---
>>   drivers/gpu/drm/qxl/qxl_kms.c | 4 ++--
>>   drivers/gpu/drm/qxl/qxl_ttm.c | 4 ++--
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/qxl/qxl_kms.c 
>> b/drivers/gpu/drm/qxl/qxl_kms.c
>> index 4dc5ad13f12c..a054e4a00fe8 100644
>> --- a/drivers/gpu/drm/qxl/qxl_kms.c
>> +++ b/drivers/gpu/drm/qxl/qxl_kms.c
>> @@ -165,7 +165,7 @@ int qxl_device_init(struct qxl_device *qdev,
>>            (int)qdev->surfaceram_size / 1024,
>>            (sb == 4) ? "64bit" : "32bit");
>> -    qdev->rom = ioremap(qdev->rom_base, qdev->rom_size);
>> +    qdev->rom = ioremap_wc(qdev->rom_base, qdev->rom_size);
>>       if (!qdev->rom) {
>>           pr_err("Unable to ioremap ROM\n");
>>           r = -ENOMEM;
>> @@ -183,7 +183,7 @@ int qxl_device_init(struct qxl_device *qdev,
>>           goto rom_unmap;
>>       }
>> -    qdev->ram_header = ioremap(qdev->vram_base +
>> +    qdev->ram_header = ioremap_wc(qdev->vram_base +
>>                      qdev->rom->ram_header_offset,
>>                      sizeof(*qdev->ram_header));
>>       if (!qdev->ram_header) {
>> diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c 
>> b/drivers/gpu/drm/qxl/qxl_ttm.c
>> index b2e33d5ba5d0..95df5750f47f 100644
>> --- a/drivers/gpu/drm/qxl/qxl_ttm.c
>> +++ b/drivers/gpu/drm/qxl/qxl_ttm.c
>> @@ -82,13 +82,13 @@ int qxl_ttm_io_mem_reserve(struct ttm_device *bdev,
>>       case TTM_PL_VRAM:
>>           mem->bus.is_iomem = true;
>>           mem->bus.offset = (mem->start << PAGE_SHIFT) + qdev->vram_base;
>> -        mem->bus.caching = ttm_cached;
>> +        mem->bus.caching = ttm_write_combined;
>>           break;
>>       case TTM_PL_PRIV:
>>           mem->bus.is_iomem = true;
>>           mem->bus.offset = (mem->start << PAGE_SHIFT) +
>>               qdev->surfaceram_base;
>> -        mem->bus.caching = ttm_cached;
>> +        mem->bus.caching = ttm_write_combined;
>>           break;
>>       default:
>>           return -EINVAL;
> 
