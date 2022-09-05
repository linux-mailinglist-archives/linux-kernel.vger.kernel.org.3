Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B277C5AC8EC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 04:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbiIEC4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 22:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbiIEC4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 22:56:08 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF3BC2CDF5;
        Sun,  4 Sep 2022 19:56:03 -0700 (PDT)
Received: from [10.20.42.105] (unknown [10.20.42.105])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxvms6ZRVj2GcRAA--.60790S3;
        Mon, 05 Sep 2022 10:55:54 +0800 (CST)
Subject: Re: [PATCH V3 0/2] DMA: update acpi_dma_get_range to return dma map
 regions
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     lpieralisi@kernel.org, robin.murphy@arm.com, chenhuacai@loongson.cn
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        lenb@kernel.org, robert.moore@intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        loongarch@lists.linux.dev
References: <20220830030139.29899-1-lvjianmin@loongson.cn>
Message-ID: <7ef64254-ed0f-be33-71c1-3f78bdf31238@loongson.cn>
Date:   Mon, 5 Sep 2022 10:55:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220830030139.29899-1-lvjianmin@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxvms6ZRVj2GcRAA--.60790S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrW7Gr1kZFWkuFyDCryfWFg_yoW8GrWrpF
        yfCrsxGr1UKrWfJry3Aw1Uur1Yqw1fA34xJFZrtrykJF1jvr17JryUJ3WxZFyUAFy7Wr40
        qF98Ja4rGF1UAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBS1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4
        CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
        Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY
        0VAS07AlzVAYIcxG8wCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaV
        Av8VW5Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

Is there anything else in this patch series that needs to be modified?

Thanks.
Jianmin.


On 2022/8/30 上午11:01, Jianmin Lv wrote:
> The patch series changed acpi_dma_get_range to return dma regions
> as of_dma_get_range, so that dev->dma_range_map can be initialized
> conveniently.
> 
> And acpi_arch_dma_setup for ARM64 is changed wih removing dma_base
> and size from it's parameters.
> 
> Remove ARCH_HAS_PHYS_TO_DMA for LoongArch and use generic
> phys_to_dma/dma_to_phys in include/linux/dma-direct.h.
> 
> V1 -> V2
> - Removed dma_base and size from acpi_arch_dma_setup' parameters
> - Add patch to remove ARCH_HAS_PHYS_TO_DMA for LoongArch
> 
> V2 -> V3
> - Add kerneldoc for acpi_dma_get_range changing
> - Remove redundant code in acpi_arch_dma_setup, and check map
> 
> 
> Jianmin Lv (2):
>    ACPI / scan: Support multiple dma windows with different offsets
>    LoongArch: Remove ARCH_HAS_PHYS_TO_DMA
> 
>   arch/loongarch/Kconfig        |  1 -
>   arch/loongarch/kernel/dma.c   | 52 +++++++++++++++++-------------------------
>   arch/loongarch/kernel/setup.c |  2 +-
>   drivers/acpi/arm64/dma.c      | 29 ++++++++++++++---------
>   drivers/acpi/scan.c           | 53 +++++++++++++++++++------------------------
>   include/acpi/acpi_bus.h       |  3 +--
>   include/linux/acpi.h          | 12 ++++++----
>   7 files changed, 71 insertions(+), 81 deletions(-)
> 

