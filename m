Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8387A52870A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244209AbiEPOaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241425AbiEPOa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:30:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25C113B2B6
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:30:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D259B1063;
        Mon, 16 May 2022 07:30:26 -0700 (PDT)
Received: from [10.57.82.175] (unknown [10.57.82.175])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 225963F73D;
        Mon, 16 May 2022 07:30:24 -0700 (PDT)
Message-ID: <bbf8f8e5-a959-dfd5-5e77-072af8bbd3ae@arm.com>
Date:   Mon, 16 May 2022 15:30:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/1] perf: hisi: Make irq shared
Content-Language: en-GB
To:     Chen Jun <chenjun102@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, zhangshaokun@hisilicon.com,
        will@kernel.org, mark.rutland@arm.com
Cc:     xuqiang36@huawei.com
References: <20220516130500.39586-1-chenjun102@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220516130500.39586-1-chenjun102@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-16 14:05, Chen Jun wrote:
> On some platforms, there are some error:
> genirq: Flags mismatch irq 23. 00010804 (xxx) vs. 00010804 (xxx)
> 
> The reason is that there are more than one pmu nodes using the same
> irq number.
> 
> Add IROF_SHARED when devm_request_irq.

You really need more than this to share an interrupt between multiple 
PMUs correctly. Perf relies on IRQs being handled on event->cpu to 
provide mutual exclusion - if another PMU comes along and moves the 
interrupt affinity to a different CPU, the interrupt handler may update 
the event state from that CPU simultaneously with a regular API call on 
event->cpu also updating it, with potential corruption as a result.

For general solutions, one option is to add a layer of explicit 
interrupt management like arm_dmc620_pmu (FWIW the original idea there 
was to factor that out into common helpers anyway). It's possible that 
IRQ affinity notifiers might work as an alternative approach too, but I 
never got round to looking into that in detail.

Thanks,
Robin.

> Signed-off-by: Chen Jun <chenjun102@huawei.com>
> ---
>   drivers/perf/hisilicon/hisi_uncore_pmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> index 358e4e284a62..bcbd3b467f34 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> @@ -168,7 +168,7 @@ int hisi_uncore_pmu_init_irq(struct hisi_pmu *hisi_pmu,
>   		return irq;
>   
>   	ret = devm_request_irq(&pdev->dev, irq, hisi_uncore_pmu_isr,
> -			       IRQF_NOBALANCING | IRQF_NO_THREAD,
> +			       IRQF_NOBALANCING | IRQF_NO_THREAD | IRQF_SHARED,
>   			       dev_name(&pdev->dev), hisi_pmu);
>   	if (ret < 0) {
>   		dev_err(&pdev->dev,
