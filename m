Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F0C5AE898
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239843AbiIFMlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiIFMlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:41:00 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99F23205FF;
        Tue,  6 Sep 2022 05:40:58 -0700 (PDT)
Received: from [10.20.42.105] (unknown [10.20.42.105])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_2vQPxdj5rwSAA--.8995S3;
        Tue, 06 Sep 2022 20:40:49 +0800 (CST)
Subject: Re: [PATCH V3 1/2] ACPI / scan: Support multiple dma windows with
 different offsets
To:     Robin Murphy <robin.murphy@arm.com>, lpieralisi@kernel.org,
        chenhuacai@loongson.cn
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        lenb@kernel.org, robert.moore@intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        loongarch@lists.linux.dev
References: <20220830030139.29899-1-lvjianmin@loongson.cn>
 <20220830030139.29899-2-lvjianmin@loongson.cn>
 <435e1283-9ff6-f089-6436-3c31a178fd60@arm.com>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <66baf6f8-0f18-e0a6-4ed4-e2f783497d2d@loongson.cn>
Date:   Tue, 6 Sep 2022 20:40:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <435e1283-9ff6-f089-6436-3c31a178fd60@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx_2vQPxdj5rwSAA--.8995S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1fWryfGF4UXw45Xr4Dtwb_yoW8Xr13pa
        48Gr43JrsrtFZ5ur4kXw4UZryrZFW3ur4FqFW8Cwn3CF45WF1Svr4xG3sYkFZYka47Gw10
        9Fs0qF95uF1YywUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB21xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_
        JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        ACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
        W5Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/5 下午8:20, Robin Murphy wrote:
> On 2022-08-30 04:01, Jianmin Lv wrote:
>> For DT, of_dma_get_range returns bus_dma_region typed dma regions,
>> which makes multiple dma windows with different offset available
>> for translation between dma address and cpu address.
>>
>> But for ACPI, acpi_dma_get_range doesn't return similar dma regions,
>> causing no path for setting dev->dma_range_map conveniently. So the
>> patch changes acpi_dma_get_range and returns bus_dma_region typed
>> dma regions according to of_dma_get_range.
>>
>> After changing acpi_dma_get_range, acpi_arch_dma_setup is changed for
>> ARM64, where original dma_addr and size are removed as these
>> arguments are now redundant, and pass 0 and U64_MAX for dma_base
>> and size of arch_setup_dma_ops, so this is a simplification consistent
>> with what other ACPI architectures also pass to iommu_setup_dma_ops().
> 
> Other than a micro-nit that acpi_dma_get_range() could probably use 
> resource_size(),
> 

Ok, thanks, I'll use resource_size() in acpi_dma_get_range().

> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> It took me longer than I care to admit to figure out where the implicit 
> declaration of struct bus_dma_region in the scope of acpi.h and 
> acpi_bus.h comes from, but in the end I guess it's sufficiently 
> well-defined by the C spec to be reliable.
> 
> Thanks for getting this done!
> 

It's a pleasure!


> Robin.
> 

[...]


