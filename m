Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7603D57764B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 15:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiGQNC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 09:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiGQNCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 09:02:24 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AF71408B
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 06:02:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VJY78e._1658062934;
Received: from 30.63.244.244(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VJY78e._1658062934)
          by smtp.aliyun-inc.com;
          Sun, 17 Jul 2022 21:02:17 +0800
Message-ID: <92b6f01c-52ca-92a8-20ea-450e23f4a10e@linux.alibaba.com>
Date:   Sun, 17 Jul 2022 21:02:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
From:   Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [RESEND PATCH v2 2/3] drivers/perf: add DDR Sub-System Driveway
 PMU driver for Yitian 710 SoC
To:     Randy Dunlap <rdunlap@infradead.org>, Jonathan.Cameron@Huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, mark.rutland@arm.com
Cc:     baolin.wang@linux.alibaba.com, yaohongbo@linux.alibaba.com,
        nengchen@linux.alibaba.com, zhuo.song@linux.alibaba.com
References: <20220617111825.92911-1-xueshuai@linux.alibaba.com>
 <20220715151310.90091-3-xueshuai@linux.alibaba.com>
 <9da48b8e-adbb-9223-5687-549c66526c47@infradead.org>
Content-Language: en-US
In-Reply-To: <9da48b8e-adbb-9223-5687-549c66526c47@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Randy,

Thank you for your quick reply.

在 2022/7/16 AM3:05, Randy Dunlap 写道:
> Hi--
>
> On 7/15/22 08:13, Shuai Xue wrote:
>> Add the DDR Sub-System Driveway Performance Monitoring Unit (PMU) driver
>> support for Alibaba T-Head Yitian 710 SoC chip. Yitian supports DDR5/4
>> DRAM and targets cloud computing and HPC.
>>
>> Each PMU is registered as a device in /sys/bus/event_source/devices, and
>> users can select event to monitor in each sub-channel, independently. For
>> example, ali_drw_21000 and ali_drw_21080 are two PMU devices for two
>> sub-channels of the same channel in die 0. And the PMU device of die 1 is
>> prefixed with ali_drw_400XXXXX, e.g. ali_drw_40021000.
>>
>> Due to hardware limitation, one of DDRSS Driveway PMU overflow interrupt
>> shares the same irq number with MPAM ERR_IRQ. To register DDRSS PMU and
>> MPAM drivers successfully, add IRQF_SHARED flag.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Co-developed-by: Hongbo Yao <yaohongbo@linux.alibaba.com>
>> Signed-off-by: Hongbo Yao <yaohongbo@linux.alibaba.com>
>> Co-developed-by: Neng Chen <nengchen@linux.alibaba.com>
>> Signed-off-by: Neng Chen <nengchen@linux.alibaba.com>
>> ---
>>  drivers/perf/Kconfig                  |   8 +
>>  drivers/perf/Makefile                 |   1 +
>>  drivers/perf/alibaba_uncore_drw_pmu.c | 793 ++++++++++++++++++++++++++
>>  3 files changed, 802 insertions(+)
>>  create mode 100644 drivers/perf/alibaba_uncore_drw_pmu.c
>>
>> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
>> index 1e2d69453771..dfafba4cb066 100644
>> --- a/drivers/perf/Kconfig
>> +++ b/drivers/perf/Kconfig
>> @@ -183,6 +183,14 @@ config APPLE_M1_CPU_PMU
>>  	  Provides support for the non-architectural CPU PMUs present on
>>  	  the Apple M1 SoCs and derivatives.
>>  
>> +config ALIBABA_UNCORE_DRW_PMU
>> +	tristate "Alibaba T-Head Yitian 710 DDR Sub-system Driveway PMU driver"
>> +	depends on (ARM64 && ACPI)
>> +	default m
> 
> Why should this driver be automatically built?
> I.e., why is the "default m" here at all?

Sorry, we automatically build this driver internally. I forgot to delete it.
I will delete "default m" in next version.

Best regards,
Shuai

> 
> Thanks.
> 
>> +	help
>> +	  Support for Driveway PMU events monitoring on Yitian 710 DDR
>> +	  Sub-system.
> 
> 
