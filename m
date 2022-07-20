Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9470257B0DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 08:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239251AbiGTGL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 02:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239208AbiGTGL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 02:11:57 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0040265D54
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 23:11:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VJvYiek_1658297511;
Received: from 30.240.121.248(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VJvYiek_1658297511)
          by smtp.aliyun-inc.com;
          Wed, 20 Jul 2022 14:11:52 +0800
Message-ID: <b6e9490b-f7aa-15df-67cb-6574778ef3a6@linux.alibaba.com>
Date:   Wed, 20 Jul 2022 14:11:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH v2 2/3] drivers/perf: add DDR Sub-System Driveway
 PMU driver for Yitian 710 SoC
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, mark.rutland@arm.com,
        baolin.wang@linux.alibaba.com, yaohongbo@linux.alibaba.com,
        nengchen@linux.alibaba.com, zhuo.song@linux.alibaba.com
References: <20220617111825.92911-1-xueshuai@linux.alibaba.com>
 <20220715151310.90091-3-xueshuai@linux.alibaba.com>
 <20220719141928.00007a90@Huawei.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20220719141928.00007a90@Huawei.com>
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


在 2022/7/19 PM9:19, Jonathan Cameron 写道:
> On Fri, 15 Jul 2022 23:13:09 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
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
> 
> Hi.
> 
> I'd like to see the build constraints relaxed so this gets much more build
> coverage from the automated systems.  COMPILE_TEST can keep the happy
> balance of not showing the driver where it isn't supported, but still ensuring
> it gets hit on lots of random config builds.

I see your concern. I will add COMPILE_TEST in Kconfig in next version.
Thank you.

> Only other significant thing is you are relying on a lot of 'implicit' includes.
> Don't do that as it just makes it harder to refactor the core headers (which is
> an active topic currently as reducing cross includes helps a lot with kernel build
> time). Otherwise LGTM.  So with those addressed.>
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Thanks,
> 
> Jonathan

Thank you, Jonathan. I will explicitly include dependent header file in
next version.

Best Regards,
Shuai

> 
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
> 
> Try to avoid limiting the ability to build the driver. I'm not seeing anything
> in here that needs either ARM64 or ACPI to build.  If you want to keep those
> (I wouldn't) then || COMPILE_TEST
> That way you'll get a lot more builds / random configs run against your code
> and typically see any issues that occur due to changes elsewhere in the tree
> faster than you will if you heavily restrict when your driver is built.

Got it. Agree to remove ACPI dependency, widen the compile-test coverage.
I prefer leaving ARM64 as ARM_CMN does.

	config ARM_CMN
		tristate "Arm CMN-600 PMU support"
		depends on ARM64 || COMPILE_TEST
		help
	  	Support for PMU events monitoring on the Arm CMN-600 Coherent Mesh
	 	Network interconnect.

>> +	default m
> 
> You've addressed this in response to Randy's review.

Yep, will address it in next version. Thank you.

> 
>> +	help
>> +	  Support for Driveway PMU events monitoring on Yitian 710 DDR
>> +	  Sub-system.
>> +
>>  source "drivers/perf/hisilicon/Kconfig"
>>  
>>  config MARVELL_CN10K_DDR_PMU
>> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
>> index 57a279c61df5..050d04ee19dd 100644
>> --- a/drivers/perf/Makefile
>> +++ b/drivers/perf/Makefile
>> @@ -20,3 +20,4 @@ obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
>>  obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) += marvell_cn10k_tad_pmu.o
>>  obj-$(CONFIG_MARVELL_CN10K_DDR_PMU) += marvell_cn10k_ddr_pmu.o
>>  obj-$(CONFIG_APPLE_M1_CPU_PMU) += apple_m1_cpu_pmu.o
>> +obj-$(CONFIG_ALIBABA_UNCORE_DRW_PMU) += alibaba_uncore_drw_pmu.o
>> diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
>> new file mode 100644
>> index 000000000000..4022bc50ffae
>> --- /dev/null
>> +++ b/drivers/perf/alibaba_uncore_drw_pmu.c
>> @@ -0,0 +1,793 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Alibaba DDR Sub-System Driveway PMU driver
>> + *
>> + * Copyright (C) 2022 Alibaba Inc
>> + */
>> +
>> +#define ALI_DRW_PMUNAME		"ali_drw"
>> +#define ALI_DRW_DRVNAME		ALI_DRW_PMUNAME "_pmu"
>> +#define pr_fmt(fmt)		ALI_DRW_DRVNAME ": " fmt
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/perf_event.h>
>> +#include <linux/platform_device.h>
>> +
> 
> See below for examples, but you should look closer at the includes to make
> sure they are appropriate.  Mostly you should not rely on one linux header
> including another, but rather provide everything used in a given file.
> There are some very generic headers where it is fine to ignore that...

Got it, good point. Thank you.

>> +#define ALI_DRW_PMU_COMMON_MAX_COUNTERS			16
>> +#define ALI_DRW_PMU_TEST_SEL_COMMON_COUNTER_BASE	19
>> +
>> +#define ALI_DRW_PMU_PA_SHIFT			12
>> +#define ALI_DRW_PMU_CNT_INIT			0x00000000
>> +#define ALI_DRW_CNT_MAX_PERIOD			0xffffffff
>> +#define ALI_DRW_PMU_CYCLE_EVT_ID		0x80
>> +
>> +#define ALI_DRW_PMU_CNT_CTRL			0xC00
>> +#define ALI_DRW_PMU_CNT_RST			BIT(2)
>> +#define ALI_DRW_PMU_CNT_STOP			BIT(1)
>> +#define ALI_DRW_PMU_CNT_START			BIT(0)
>> +
>> +#define ALI_DRW_PMU_CNT_STATE			0xC04
>> +#define ALI_DRW_PMU_TEST_CTRL			0xC08
>> +#define ALI_DRW_PMU_CNT_PRELOAD			0xC0C
>> +
>> +#define ALI_DRW_PMU_CYCLE_CNT_HIGH_MASK		GENMASK(23, 0)
>> +#define ALI_DRW_PMU_CYCLE_CNT_LOW_MASK		GENMASK(31, 0)
>> +#define ALI_DRW_PMU_CYCLE_CNT_HIGH		0xC10
>> +#define ALI_DRW_PMU_CYCLE_CNT_LOW		0xC14
>> +
>> +/* PMU EVENT SEL 0-3 are paired in 32-bit registers on a 4-byte stride */
>> +#define ALI_DRW_PMU_EVENT_SEL0			0xC68
>> +/* counter 0-3 use sel0, counter 4-7 use sel1...*/
>> +#define ALI_DRW_PMU_EVENT_SELn(n) \
>> +	(ALI_DRW_PMU_EVENT_SEL0 + (n / 4) * 0x4)
>> +#define ALI_DRW_PMCOM_CNT_EN			BIT(7)
>> +#define ALI_DRW_PMCOM_CNT_EVENT_MASK		GENMASK(5, 0)
>> +#define ALI_DRW_PMCOM_CNT_EVENT_OFFSET(n) \
>> +	(8 * (n % 4))
>> +
>> +/* PMU COMMON COUNTER 0-15, are paired in 32-bit registers on a 4-byte stride */
>> +#define ALI_DRW_PMU_COMMON_COUNTER0		0xC78
>> +#define ALI_DRW_PMU_COMMON_COUNTERn(n) \
>> +	(ALI_DRW_PMU_COMMON_COUNTER0 + 0x4 * (n))
>> +
>> +#define ALI_DRW_PMU_OV_INTR_ENABLE_CTL		0xCB8
>> +#define ALI_DRW_PMU_OV_INTR_DISABLE_CTL		0xCBC
>> +#define ALI_DRW_PMU_OV_INTR_ENABLE_STATUS	0xCC0
>> +#define ALI_DRW_PMU_OV_INTR_CLR			0xCC4
>> +#define ALI_DRW_PMU_OV_INTR_STATUS		0xCC8
>> +#define ALI_DRW_PMCOM_CNT_OV_INTR_MASK		GENMASK(23, 8)
>> +#define ALI_DRW_PMBW_CNT_OV_INTR_MASK		GENMASK(7, 0)
>> +#define ALI_DRW_PMU_OV_INTR_MASK		GENMASK_ULL(63, 0)
>> +
>> +static int ali_drw_cpuhp_state_num;
>> +
>> +static LIST_HEAD(ali_drw_pmu_irqs);
>> +static DEFINE_MUTEX(ali_drw_pmu_irqs_lock);
> 
> include linux/mutex.h

Will add it in next version, thanks.

>> +
>> +struct ali_drw_pmu_irq {
>> +	struct hlist_node node;
>> +	struct list_head irqs_node;
>> +	struct list_head pmus_node;
> Include appropriate headers for list_head, hlist_node etc directly rather than
> relying on possibly unstable includes from within other headers.

Will add them in next version, thanks.

>> +	int irq_num;
>> +	int cpu;
>> +	refcount_t refcount;
>> +};
>> +
>> +struct ali_drw_pmu {
>> +	void __iomem *cfg_base;
>> +	struct device *dev;
>> +
>> +	struct list_head pmus_node;
>> +	struct ali_drw_pmu_irq *irq;
>> +	int irq_num;
>> +	int cpu;
>> +	DECLARE_BITMAP(used_mask, ALI_DRW_PMU_COMMON_MAX_COUNTERS);
> 
> bitmap.h

Will add it in next version, thanks.

> 
>> +	struct perf_event *events[ALI_DRW_PMU_COMMON_MAX_COUNTERS];
>> +	int evtids[ALI_DRW_PMU_COMMON_MAX_COUNTERS];
>> +
>> +	struct pmu pmu;
>> +};
>> +
> 
>> +
>> +/* find a counter for event, then in add func, hw.idx will equal to counter */
>> +static int ali_drw_get_counter_idx(struct perf_event *event)
>> +{
>> +	struct ali_drw_pmu *drw_pmu = to_ali_drw_pmu(event->pmu);
>> +	int idx;
>> +
>> +	for (idx = 0; idx < ALI_DRW_PMU_COMMON_MAX_COUNTERS; ++idx) {
>> +		if (!test_and_set_bit(idx, drw_pmu->used_mask))
>> +			return idx;
>> +	}
>> +
>> +	/* The counters are all in use. */
>> +	return -EBUSY;
>> +}
>>
> 
> 
>> +
>> +/*
>> + * Due to historical reasons, the HID used in the production environment is
>> + * ARMHD700, so we leave ARMHD700 as Compatible ID.
>> + */
>> +static const struct acpi_device_id ali_drw_acpi_match[] = {
> 
> If you build without ACPI support and drop the requirement for it as suggested
> above, this will give an unused warning.
> Either drop the ACPI_PTR() - that's very rarely worth bothering or
> add a __maybe_unused marking to this array.

Got it. I will remove ACPI dependency and drop ACPI_PTR(). Thank you very much.
> 
>> +	{"BABA5000", 0},
>> +	{"ARMHD700", 0},
>> +	{}
>> +};
>> +
>> +MODULE_DEVICE_TABLE(acpi, ali_drw_acpi_match);
>> +
>> +static struct platform_driver ali_drw_pmu_driver = {
>> +	.driver = {
>> +		   .name = "ali_drw_pmu",
>> +		   .acpi_match_table = ACPI_PTR(ali_drw_acpi_match),
>> +		   },
>> +	.probe = ali_drw_pmu_probe,
>> +	.remove = ali_drw_pmu_remove,
>> +};
>> +
