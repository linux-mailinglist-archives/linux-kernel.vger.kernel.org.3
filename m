Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522B359568E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbiHPJgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbiHPJf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:35:28 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D168A1E7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:58:15 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so151322wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=kcZB5yTljjYoYb9rI3K3bWUxtmO10iyk2JL0XgGiWoI=;
        b=U3A0UsWJHGGuyHOK1Yi6OlB+zQt7JB1FczCZZ6L2HRY/n2oMyrUnNhY+AdmWQKnTWC
         d/bLGd6vo3w5Oqlw8I7YHCq7B4J5DJpfZiJud5cLOGxbMB3Ol1ngrEMulrS+hX/ZQsfZ
         c48sxq8YyEJKrTVfP0GZTV6KNEhdh2ShQAGJh01/QY6QcVzmX7Ywrpl+bWdSHiBd0c1L
         wkfV6CEnkYkGOMtaR4H6jeYb0KBWB0ppgvgX13uerJqnK+sYXFIsmZkk8zApiBdrGzLz
         L9aybYmjpbrOqID8DnVKfS43RKufNb5bDzejb4v5pj1lXiAqc7nMx0jlfg4dqnh/uXZ4
         0Tjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=kcZB5yTljjYoYb9rI3K3bWUxtmO10iyk2JL0XgGiWoI=;
        b=tXWIsQ+wGIpSi57fbJUu5DkL9/eXP+LO7ZXOuUb0BQCiTuUXJu/04FkxuJNCZuxWG6
         UDTO23E9DLuz9mDxUGTA1ujFtcUyzPR5eHoHgMViEplNjaEIVa/iGwEX2dSN2zuvpJih
         TDTUfMODoNwsxzB90cKzaPAFPZJowwf7XId2PRXjNZdeywk/a/1RWvt2uYQf77wLANu6
         sPTRN/X+IcUq9Fajj4MOIBcwGrX5uEMb4PezyYP3E/eAwG3H0NPqR3Pn3TLPdjUfE8RB
         o5e8mtefZ9piE8raoPcY6+vSJ5rArH4zETQ/YMGHn0mOJSsDbXOhtefXybMaGrF8YUQl
         EHlA==
X-Gm-Message-State: ACgBeo3ivNLCsqcV6mf4/iHGinmalc0S+iH5eqTh3dycOYQMuE7ZAmxI
        HdmYs6kVFkUK4p3Bj4yv7JorFQ==
X-Google-Smtp-Source: AA6agR7U5C+g3hVuqF+oDiAfmo4MLevLaQJZr/r/vnMzTtW2R+PsUOLNIht3+hWDjG2EOYtYOBDiZA==
X-Received: by 2002:a7b:c852:0:b0:3a5:407a:76df with SMTP id c18-20020a7bc852000000b003a5407a76dfmr12104848wml.101.1660636692002;
        Tue, 16 Aug 2022 00:58:12 -0700 (PDT)
Received: from [192.168.1.69] (120.205.87.79.rev.sfr.net. [79.87.205.120])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d5551000000b0021f0af83142sm9319944wrw.91.2022.08.16.00.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 00:58:11 -0700 (PDT)
Message-ID: <fe0fe04e-5ac2-e8c2-d568-0976ba085d6a@baylibre.com>
Date:   Tue, 16 Aug 2022 09:58:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v4 3/3] counter: capture-tiecap: capture driver support
 for ECAP
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     vilhelm.gray@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mranostay@ti.com
References: <20220810140724.182389-1-jpanis@baylibre.com>
 <20220810140724.182389-4-jpanis@baylibre.com> <Yvkq9Hy+hxAPQd8J@fedora>
Content-Language: en-US
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <Yvkq9Hy+hxAPQd8J@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/08/2022 19:03, William Breathitt Gray wrote:
> On Wed, Aug 10, 2022 at 04:07:24PM +0200, Julien Panis wrote:
>> ECAP hardware on AM62x SoC supports capture feature. It can be used
>> to timestamp events (falling/rising edges) detected on signal input pin.
>>
>> This commit adds capture driver support for ECAP hardware on AM62x SoC.
>>
>> In the ECAP hardware, capture pin can also be configured to be in
>> PWM mode. Current implementation only supports capture operating mode.
>> Hardware also supports timebase sync between multiple instances, but
>> this driver supports simple independent capture functionality.
>>
>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> Hi Julien,
>
> You picked up the Counter paradigm pretty quickly, good job! Some
> suggestions and comments inline below.

Hi William,
Thank you for your review.
My answers to your questions below.

>
>> ---
>>   drivers/counter/Kconfig          |  14 +
>>   drivers/counter/Makefile         |   1 +
>>   drivers/counter/capture-tiecap.c | 634 +++++++++++++++++++++++++++++++
>>   include/uapi/linux/counter.h     |   2 +
>>   4 files changed, 651 insertions(+)
>>   create mode 100644 drivers/counter/capture-tiecap.c
>>
>> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
>> index 5edd155f1911..580640807a94 100644
>> --- a/drivers/counter/Kconfig
>> +++ b/drivers/counter/Kconfig
>> @@ -101,4 +101,18 @@ config INTEL_QEP
>>   	  To compile this driver as a module, choose M here: the module
>>   	  will be called intel-qep.
>>   
>> +config CAPTURE_TIECAP
>> +	tristate "TI eCAP capture driver"
>> +	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
>> +	depends on HAS_IOMEM
>> +	help
>> +	  Select this option to enable the Texas Instruments Enhanced Capture
>> +	  (eCAP) driver in input mode.
>> +
>> +	  It can be used to timestamp events (falling/rising edges) detected
>> +	  on signal input pin.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called capture-tiecap.
>> +
> The naming convention I typically see is to lead with the company name
> followed by device model; e.g. ti-ecap-capture. That should result in
> better grouping with the existing drivers in the drivers/counter
> directory. It's a minor benefit, so let's use that convention unless
> there's a reason why capture-tiecap is better here.

Another driver implementing ECAP PWM functionality was named "pwm-tiecap".
That's why I chose this "capture-tiecap" name. But that's OK for 
ti-ecap-capture,
it's better indeed to use the same naming convention for all counter 
drivers.
I will also add "select REGMAP_MMIO" to Kconfig, similarly to others drivers
(ti-eqep for instance).

>
>>   endif # COUNTER
>> diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
>> index 8fde6c100ebc..7fac3e0985b5 100644
>> --- a/drivers/counter/Makefile
>> +++ b/drivers/counter/Makefile
>> @@ -14,3 +14,4 @@ obj-$(CONFIG_TI_EQEP)		+= ti-eqep.o
>>   obj-$(CONFIG_FTM_QUADDEC)	+= ftm-quaddec.o
>>   obj-$(CONFIG_MICROCHIP_TCB_CAPTURE)	+= microchip-tcb-capture.o
>>   obj-$(CONFIG_INTEL_QEP)		+= intel-qep.o
>> +obj-$(CONFIG_CAPTURE_TIECAP)	+= capture-tiecap.o
>> diff --git a/drivers/counter/capture-tiecap.c b/drivers/counter/capture-tiecap.c
>> new file mode 100644
>> index 000000000000..0601c65ef203
>> --- /dev/null
>> +++ b/drivers/counter/capture-tiecap.c
>> @@ -0,0 +1,634 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * ECAP Capture driver
>> + *
>> + * Copyright (C) 2022 Julien Panis <jpanis@baylibre.com>
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/counter.h>
>> +#include <linux/err.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/regmap.h>
>> +
>> +#define ECAP_DRV_NAME "ecap"
>> +
>> +/* Registers */
>> +#define ECAP_NB_CAP			4
>> +
>> +#define ECAP_TSCNT_REG			0x00
>> +
>> +#define ECAP_CAP_REG(i)		(((i) << 2) + 0x08)
>> +
>> +#define ECAP_ECCTL_REG			0x28
>> +#define ECAP_CAPPOL_BIT(i)		BIT((i) << 1)
>> +#define ECAP_EV_MODE_MASK		GENMASK(7, 0)
>> +#define ECAP_CAPLDEN_BIT		BIT(8)
>> +#define ECAP_CONT_ONESHT_BIT		BIT(16)
>> +#define ECAP_STOPVALUE_MASK		GENMASK(18, 17)
>> +#define ECAP_REARM_RESET_BIT		BIT(19)
>> +#define ECAP_TSCNTSTP_BIT		BIT(20)
>> +#define ECAP_SYNCO_DIS_MASK		GENMASK(23, 22)
>> +#define ECAP_CAP_APWM_BIT		BIT(25)
>> +#define ECAP_ECCTL_EN_MASK		(ECAP_CAPLDEN_BIT | ECAP_TSCNTSTP_BIT)
>> +#define ECAP_ECCTL_CFG_MASK		(ECAP_SYNCO_DIS_MASK | ECAP_STOPVALUE_MASK	\
>> +					| ECAP_ECCTL_EN_MASK | ECAP_REARM_RESET_BIT	\
>> +					| ECAP_CAP_APWM_BIT | ECAP_CONT_ONESHT_BIT)
>> +
>> +#define ECAP_ECINT_EN_FLG_REG		0x2c
>> +#define ECAP_NB_CEVT			(ECAP_NB_CAP + 1)
>> +#define ECAP_CEVT_EN_MASK		GENMASK(ECAP_NB_CEVT, ECAP_NB_CAP)
>> +#define ECAP_CEVT_FLG_BIT(i)		BIT((i) + 17)
>> +
>> +#define ECAP_ECINT_CLR_FRC_REG	0x30
>> +#define ECAP_INT_CLR_BIT		BIT(0)
>> +#define ECAP_CEVT_CLR_BIT(i)		BIT((i) + 1)
>> +#define ECAP_CEVT_CLR_MASK		GENMASK(ECAP_NB_CEVT, 0)
>> +
>> +#define ECAP_PID_REG			0x5c
>> +
>> +/*
>> + * Event modes
>> + * One bit for each CAPx register : 1 = falling edge / 0 = rising edge
>> + * e.g. mode = 13 = 0xd = 0b1101
>> + * -> falling edge for CAP1-3-4 / rising edge for CAP2
>> + */
>> +#define ECAP_EV_MODE_BIT(i)		BIT(i)
>> +
>> +/* ECAP input */
>> +#define ECAP_SIGNAL 0
>> +
>> +static const struct regmap_config ecap_cnt_regmap_config = {
>> +	.reg_bits = 32,
>> +	.reg_stride = 4,
>> +	.val_bits = 32,
>> +	.max_register = ECAP_PID_REG,
>> +};
>> +
>> +/**
>> + * struct ecap_cnt_dev - device private data structure
>> + * @enabled:      device state
>> + * @clk:          device clock
>> + * @clk_rate:     device clock rate
>> + * @regmap:       device register map
>> + * @elapsed_time: elapsed time since capture start
>> + * @lock:         synchronization lock to prevent race conditions when computing times
>> + * @pm_ctx:       device context for PM operations
>> + */
>> +struct ecap_cnt_dev {
>> +	bool enabled;
>> +	struct clk *clk;
>> +	unsigned long clk_rate;
>> +	struct regmap *regmap;
>> +	__aligned_u64 elapsed_time;
>> +	spinlock_t lock;
>> +	struct {
>> +		u8 ev_mode;
>> +		unsigned int time_cntr;
>> +	} pm_ctx;
>> +};
>> +
>> +static u8 ecap_cnt_capture_get_evmode(struct counter_device *counter)
>> +{
>> +	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
>> +	u8 ev_mode = 0;
>> +	unsigned int regval;
>> +	int i;
>> +
>> +	pm_runtime_get_sync(counter->parent);
>> +	regmap_read(ecap_dev->regmap, ECAP_ECCTL_REG, &regval);
>> +	pm_runtime_put_sync(counter->parent);
>> +
>> +	for (i = 0 ; i < ECAP_NB_CAP ; i++) {
>> +		if (regval & ECAP_CAPPOL_BIT(i))
>> +			ev_mode |= ECAP_EV_MODE_BIT(i);
>> +	}
>> +
>> +	return ev_mode;
>> +}
>> +
>> +static void ecap_cnt_capture_set_evmode(struct counter_device *counter, u8 ev_mode)
>> +{
>> +	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
>> +	unsigned int regval = 0;
>> +	int i;
>> +
>> +	for (i = 0 ; i < ECAP_NB_CAP ; i++) {
>> +		if (ev_mode & ECAP_EV_MODE_BIT(i))
>> +			regval |= ECAP_CAPPOL_BIT(i);
>> +	}
>> +
>> +	pm_runtime_get_sync(counter->parent);
>> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_EV_MODE_MASK, regval);
>> +	pm_runtime_put_sync(counter->parent);
>> +}
>> +
>> +static void ecap_cnt_capture_enable(struct counter_device *counter, bool rearm)
>> +{
>> +	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
>> +	unsigned int regval;
>> +
>> +	pm_runtime_get_sync(counter->parent);
>> +
>> +	/* Enable interrupts on events */
>> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG,
>> +			   ECAP_CEVT_EN_MASK, ECAP_CEVT_EN_MASK);
>> +
>> +	/* Run counter */
>> +	regval = ECAP_SYNCO_DIS_MASK | ECAP_STOPVALUE_MASK | ECAP_ECCTL_EN_MASK;
>> +	if (rearm) {
>> +		ecap_dev->elapsed_time = 0;
>> +		regmap_write(ecap_dev->regmap, ECAP_TSCNT_REG, 0);
>> +		regval |= ECAP_REARM_RESET_BIT;
>> +	}
>> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_ECCTL_CFG_MASK, regval);
>> +}
>> +
>> +static void ecap_cnt_capture_disable(struct counter_device *counter)
>> +{
>> +	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
>> +
>> +	/* Disable interrupts on events */
>> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG, ECAP_CEVT_EN_MASK, 0);
>> +
>> +	/* Stop counter */
>> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_ECCTL_EN_MASK, 0);
>> +
>> +	pm_runtime_put_sync(counter->parent);
>> +}
>> +
>> +static int ecap_cnt_count_get_ns(struct counter_device *counter, unsigned int reg, u64 *val)
>> +{
>> +	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
>> +	unsigned int regval;
>> +	unsigned long flags;
>> +
>> +	pm_runtime_get_sync(counter->parent);
>> +	spin_lock_irqsave(&ecap_dev->lock, flags);
>> +
>> +	/* time_ns = 10^9 * (time_cycles + time_cumul) / clk_rate */
>> +	regmap_read(ecap_dev->regmap, reg, &regval);
>> +	*val = (regval + ecap_dev->elapsed_time) * NSEC_PER_SEC;
>> +	do_div(*val, ecap_dev->clk_rate);
>> +
>> +	spin_unlock_irqrestore(&ecap_dev->lock, flags);
>> +	pm_runtime_put_sync(counter->parent);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int ecap_cnt_count_read(struct counter_device *counter,
>> +				      struct counter_count *count,
>> +				      u64 *val)
>> +{
>> +	return ecap_cnt_count_get_ns(counter, ECAP_TSCNT_REG, val);
>> +}
> This conversion to nanoseconds is an interpretation of the count value
> that belongs in userspace. Instead of converting to nanoseconds here,
> simply expose the count value directly and add extensions to expose the
> elapsed time (a Count extension) and clock rate (a Signal extension) as
> well; with these three values you can derive nanoseconds in userspace
> using the time_ns equation in your ecap_cnt_count_get_ns() comment.
>
>> +static int ecap_cnt_function_read(struct counter_device *counter,
>> +				  struct counter_count *count,
>> +				  enum counter_function *function)
>> +{
>> +	*function = COUNTER_FUNCTION_INCREASE;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ecap_cnt_action_read(struct counter_device *counter,
>> +				struct counter_count *count,
>> +				struct counter_synapse *synapse,
>> +				enum counter_synapse_action *action)
>> +{
>> +	*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
>> +
>> +	return 0;
>> +}
> Right now you have a Signal defined for the ECAPSIG line, but there is
> at least one more relevant Signal to define: the clock updating ECAPCNT.
> The Synapse action of COUNTER_SYNAPSE_ACTION_BOTH_EDGES is for that
> clock Signal, but for the ECAPSIG Signal you will need to report a
> Synapse action based on the polarity of the next capture (i.e. whether
> high or low).

Just to be sure : by using the word ECAPCNT, I guess that you speak 
about the
Mod4 counter (0->1->2->3->0...), don't you ? (2 bits)
Or do you speak about ECAP_TSCNT_REG register content ? (32 bits)

>
>> +
>> +static int ecap_cnt_watch_validate(struct counter_device *counter,
>> +				   const struct counter_watch *watch)
>> +{
>> +	struct counter_event_node *event_node;
>> +
>> +	if (watch->channel || watch->event != COUNTER_EVENT_CAPTURE)
>> +		return -EINVAL;
> The intention of this conditional is more obvious if you explicitly
> check for watch->channel != 0.
>
>> +
>> +	list_for_each_entry(event_node, &counter->next_events_list, l)
>> +		if (watch->component.type != COUNTER_COMPONENT_EXTENSION ||
>> +		    watch->component.scope != COUNTER_SCOPE_COUNT ||
>> +		    watch->component.parent ||
>> +		    watch->component.id >= ECAP_NB_CAP)
>> +			return -EINVAL;
> You don't need this list_for_each_entry loop at all. The purpose of the
> watch_validate() callback is to make sure a watch isn't added with a
> channel or event configuration that conflicts with existing watches in
> the next_events_list list.
>
> For example, the 104-QUAD-8 device only allows one particular event to
> occur on any given channel. The quad8_watch_validate() function makes
> sure that all watches for a particular channel are set for the same
> event; if a watch for that channel is set for a different event, then
> that watch is invalid because the 104-QUAD-8 device cannot handle such
> a request for two different events on the same channel.
>
> Regarding the TI ECAP device, it looks like it only supports that one
> COUNTER_EVENT_CAPTURE event so you don't need to check the other watches
> in the next_events_list list. Your conditional check above for
> watch->channel and watch->event should be enough by itself.
>
>> +
>> +	return 0;
>> +}
>> +
>> +static int ecap_cnt_enable_read(struct counter_device *counter,
>> +				struct counter_count *count,
>> +				u8 *enable)
>> +{
>> +	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
>> +
>> +	*enable = ecap_dev->enabled;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ecap_cnt_enable_write(struct counter_device *counter,
>> +				 struct counter_count *count,
>> +				 u8 enable)
>> +{
>> +	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
>> +
>> +	if (enable > 1)
>> +		return -EINVAL;
>> +	if (enable == ecap_dev->enabled)
>> +		return 0;
>> +	if (enable)
>> +		ecap_cnt_capture_enable(counter, true);
>> +	else
>> +		ecap_cnt_capture_disable(counter);
>> +	ecap_dev->enabled = enable;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ecap_cnt_cap_get_pol(struct counter_device *counter,
>> +				struct counter_signal *signal,
>> +				u32 *pol, u8 inst)
>> +{
>> +	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
>> +
>> +	pm_runtime_get_sync(counter->parent);
>> +	*pol = regmap_test_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL_BIT(inst));
>> +	pm_runtime_put_sync(counter->parent);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ecap_cnt_cap_set_pol(struct counter_device *counter,
>> +				struct counter_signal *signal,
>> +				u32 pol, u8 inst)
>> +{
>> +	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
>> +
>> +	if (ecap_dev->enabled)
>> +		return -EBUSY;
>> +	if (pol > 1)
>> +		return -EINVAL;
>> +
>> +	pm_runtime_get_sync(counter->parent);
>> +	if (pol)
>> +		regmap_set_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL_BIT(inst));
>> +	else
>> +		regmap_clear_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL_BIT(inst));
>> +	pm_runtime_put_sync(counter->parent);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int ecap_cnt_cap_read(struct counter_device *counter,
>> +				    struct counter_count *count,
>> +				    u64 *cap, u8 inst)
>> +{
>> +	return ecap_cnt_count_get_ns(counter, ECAP_CAP_REG(inst), cap);
>> +}
> Return the captured count value directly here; userspace can handle the
> nanosecond interpretation for the same reason explained earlier for the
> ECAPCNT count value.
>
>> +static inline int ecap_cnt_cap1_get_pol(struct counter_device *counter,
>> +					struct counter_signal *signal, u32 *pol)
>> +{
>> +	return ecap_cnt_cap_get_pol(counter, signal, pol, 0);
>> +}
>> +
>> +static inline int ecap_cnt_cap2_get_pol(struct counter_device *counter,
>> +					struct counter_signal *signal, u32 *pol)
>> +{
>> +	return ecap_cnt_cap_get_pol(counter, signal, pol, 1);
>> +}
>> +
>> +static inline int ecap_cnt_cap3_get_pol(struct counter_device *counter,
>> +					struct counter_signal *signal, u32 *pol)
>> +{
>> +	return ecap_cnt_cap_get_pol(counter, signal, pol, 2);
>> +}
>> +
>> +static inline int ecap_cnt_cap4_get_pol(struct counter_device *counter,
>> +					struct counter_signal *signal, u32 *pol)
>> +{
>> +	return ecap_cnt_cap_get_pol(counter, signal, pol, 3);
>> +}
>> +
>> +static inline int ecap_cnt_cap1_set_pol(struct counter_device *counter,
>> +					struct counter_signal *signal, u32 pol)
>> +{
>> +	return ecap_cnt_cap_set_pol(counter, signal, pol, 0);
>> +}
>> +
>> +static inline int ecap_cnt_cap2_set_pol(struct counter_device *counter,
>> +					struct counter_signal *signal, u32 pol)
>> +{
>> +	return ecap_cnt_cap_set_pol(counter, signal, pol, 1);
>> +}
>> +
>> +static inline int ecap_cnt_cap3_set_pol(struct counter_device *counter,
>> +					struct counter_signal *signal, u32 pol)
>> +{
>> +	return ecap_cnt_cap_set_pol(counter, signal, pol, 2);
>> +}
>> +
>> +static inline int ecap_cnt_cap4_set_pol(struct counter_device *counter,
>> +					struct counter_signal *signal, u32 pol)
>> +{
>> +	return ecap_cnt_cap_set_pol(counter, signal, pol, 3);
>> +}
>> +
>> +static inline int ecap_cnt_cap1_read(struct counter_device *counter,
>> +				     struct counter_count *count, u64 *cap)
>> +{
>> +	return ecap_cnt_cap_read(counter, count, cap, 0);
>> +}
>> +
>> +static inline int ecap_cnt_cap2_read(struct counter_device *counter,
>> +				     struct counter_count *count, u64 *cap)
>> +{
>> +	return ecap_cnt_cap_read(counter, count, cap, 1);
>> +}
>> +
>> +static inline int ecap_cnt_cap3_read(struct counter_device *counter,
>> +				     struct counter_count *count, u64 *cap)
>> +{
>> +	return ecap_cnt_cap_read(counter, count, cap, 2);
>> +}
>> +
>> +static inline int ecap_cnt_cap4_read(struct counter_device *counter,
>> +				     struct counter_count *count, u64 *cap)
>> +{
>> +	return ecap_cnt_cap_read(counter, count, cap, 3);
>> +}
> There's a lot of boilerplate code here for each ECAP register read/write
> callback. Try defining a macro to build these so you can define each
> read/write callback pair more succinctly.

I tried to use a macro but did not find any clean way to do that. I will 
try again, maybe
some Zephyr code could be inspiring for that kind of static definition 
using macros.

>
>> +static const struct counter_ops ecap_cnt_ops = {
>> +	.count_read = ecap_cnt_count_read,
>> +	.function_read = ecap_cnt_function_read,
>> +	.action_read = ecap_cnt_action_read,
>> +	.watch_validate = ecap_cnt_watch_validate,
>> +};
>> +
>> +static const enum counter_function ecap_cnt_functions[] = {
>> +	COUNTER_FUNCTION_INCREASE,
>> +};
>> +
>> +static const enum counter_synapse_action ecap_cnt_actions[] = {
>> +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
>> +};
>> +
>> +static const char *const ecap_cnt_cap_polarities[] = {
>> +	"rising",
>> +	"falling",
>> +};
>> +
>> +static DEFINE_COUNTER_ENUM(ecap_cnt_cap_avail_pol, ecap_cnt_cap_polarities);
>> +
>> +static struct counter_comp ecap_cnt_signal_ext[] = {
>> +	COUNTER_COMP_SIGNAL_ENUM("polarity1", ecap_cnt_cap1_get_pol,
>> +				 ecap_cnt_cap1_set_pol, ecap_cnt_cap_avail_pol),
>> +	COUNTER_COMP_SIGNAL_ENUM("polarity2", ecap_cnt_cap2_get_pol,
>> +				 ecap_cnt_cap2_set_pol, ecap_cnt_cap_avail_pol),
>> +	COUNTER_COMP_SIGNAL_ENUM("polarity3", ecap_cnt_cap3_get_pol,
>> +				 ecap_cnt_cap3_set_pol, ecap_cnt_cap_avail_pol),
>> +	COUNTER_COMP_SIGNAL_ENUM("polarity4", ecap_cnt_cap4_get_pol,
>> +				 ecap_cnt_cap4_set_pol, ecap_cnt_cap_avail_pol),
>> +};
>> +
>> +static struct counter_signal ecap_cnt_signals[] = {
>> +	{
>> +		.id = ECAP_SIGNAL,
>> +		.name = "ECAPSIG",
>> +		.ext = ecap_cnt_signal_ext,
>> +		.num_ext = ARRAY_SIZE(ecap_cnt_signal_ext),
>> +	},
>> +};
> As mentioned earlier, define another Signal here representing the clock
> feeding ECAPCNT. You should also define another extensions array for
> this new Signal that will provide the clock rate for userspace to read.
>
>> +static struct counter_synapse ecap_cnt_synapses[] = {
>> +	{
>> +		.actions_list = ecap_cnt_actions,
>> +		.num_actions = ARRAY_SIZE(ecap_cnt_actions),
>> +		.signal = &ecap_cnt_signals[ECAP_SIGNAL],
>> +	},
>> +};
> You will need to define another Synapse here for the clock Signal
> mentioned above; similarly, you need to define another actions array for
> the possible edge triggers.
>
>> +static struct counter_comp ecap_cnt_count_ext[] = {
>> +	COUNTER_COMP_COUNT_U64("capture1", ecap_cnt_cap1_read, NULL),
>> +	COUNTER_COMP_COUNT_U64("capture2", ecap_cnt_cap2_read, NULL),
>> +	COUNTER_COMP_COUNT_U64("capture3", ecap_cnt_cap3_read, NULL),
>> +	COUNTER_COMP_COUNT_U64("capture4", ecap_cnt_cap4_read, NULL),
>> +	COUNTER_COMP_ENABLE(ecap_cnt_enable_read, ecap_cnt_enable_write),
> I just want to verify: this enable extension should disable the ECAPCNT
> count itself (i.e. no more increasing count value). Is that what's
> happening here, or is this meant to disable just the captures?

Yes, it is what's happening here : no more increasing count value.

>
>> +};
>> +
>> +static struct counter_count ecap_cnt_counts[] = {
>> +	{
>> +		.id = 0,
>> +		.name = "ECAPCNT",
>> +		.functions_list = ecap_cnt_functions,
>> +		.num_functions = ARRAY_SIZE(ecap_cnt_functions),
>> +		.synapses = ecap_cnt_synapses,
>> +		.num_synapses = ARRAY_SIZE(ecap_cnt_synapses),
>> +		.ext = ecap_cnt_count_ext,
>> +		.num_ext = ARRAY_SIZE(ecap_cnt_count_ext),
>> +	},
>> +};
>> +
>> +static irqreturn_t ecap_cnt_isr(int irq, void *dev_id)
>> +{
>> +	struct counter_device *counter_dev = dev_id;
>> +	struct ecap_cnt_dev *ecap_dev = counter_priv(counter_dev);
>> +	unsigned int clr = 0;
>> +	unsigned int flg;
>> +	int i;
>> +	unsigned long flags;
>> +
>> +	regmap_read(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG, &flg);
>> +
>> +	for (i = ECAP_NB_CAP - 1 ; i < ECAP_NB_CEVT ; i++) {
> Would you walk me through the logic for this loop. Is this for-loop
> intended to loop through all four capture indices? ECAP_NB_CAP and
> ECAP_NB_CEVT are defines, so your for-loop has i=3 and i<5; is this what
> you want?

In previous versions (IIO subsys), this for-loop was intended to loop 
through all 4 capture indices
and overflow flag.
In this version, it has been modified to loop only for the last capture 
indice (the 4th)
and overflow flag : yes, this is intentional. Only 1 event has to be 
pushed so that the user
gets all 4 captured timestamps in a single-reading (using 4 watches).
But if I understand well your previous suggestion, you would like 
tracking Mod4 counter value,
don't you ? So, I will change back this for-loop, so that it loops for 
all capture indices (and
overflow flag) -> For all 4 capture indices, Mod4 count will be updated. 
And event will still be
pushed only for the 4th capture indice.

>
>> +		if (flg & ECAP_CEVT_FLG_BIT(i)) {
>> +			if (i < ECAP_NB_CAP) {
>> +				/* Input signal edge detected on last CAP (CAP4) */
>> +				counter_push_event(counter_dev, COUNTER_EVENT_CAPTURE, 0);
>> +			} else {
>> +				/* Counter overflow */
>> +				spin_lock_irqsave(&ecap_dev->lock, flags);
>> +				ecap_dev->elapsed_time += (u64)U32_MAX + 1;
>> +				spin_unlock_irqrestore(&ecap_dev->lock, flags);
> Should we push COUNTER_EVENT_OVERFLOW here? Since elapsed_time always
> increments by the same constant (U32_MAX), it would be better to replace
> this with an atomic_t "num_overflows" to track the number of overflows
> with atomic_inc() and compute the particular elapsed_time later.

I agree with this suggestion.

>
> William Breathitt Gray
>
>> +			}
>> +
>> +			clr |= ECAP_CEVT_CLR_BIT(i);
>> +		}
>> +	}
>> +
>> +	clr |= ECAP_INT_CLR_BIT;
>> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECINT_CLR_FRC_REG, ECAP_CEVT_CLR_MASK, clr);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static void ecap_cnt_clk_disable(void *clk)
>> +{
>> +	clk_disable_unprepare(clk);
>> +}
>> +
>> +static int ecap_cnt_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct ecap_cnt_dev *ecap_dev;
>> +	struct counter_device *counter_dev;
>> +	void __iomem *mmio_base;
>> +	int ret;
>> +
>> +	counter_dev = devm_counter_alloc(dev, sizeof(*ecap_dev));
>> +	if (IS_ERR(counter_dev))
>> +		return PTR_ERR(counter_dev);
>> +
>> +	counter_dev->name = ECAP_DRV_NAME;
>> +	counter_dev->parent = dev;
>> +	counter_dev->ops = &ecap_cnt_ops;
>> +	counter_dev->signals = ecap_cnt_signals;
>> +	counter_dev->num_signals = ARRAY_SIZE(ecap_cnt_signals);
>> +	counter_dev->counts = ecap_cnt_counts;
>> +	counter_dev->num_counts = ARRAY_SIZE(ecap_cnt_counts);
>> +
>> +	ecap_dev = counter_priv(counter_dev);
>> +
>> +	ecap_dev->clk = devm_clk_get(dev, "fck");
>> +	if (IS_ERR(ecap_dev->clk))
>> +		return dev_err_probe(dev, PTR_ERR(ecap_dev->clk), "failed to get clock\n");
>> +
>> +	ret = clk_prepare_enable(ecap_dev->clk);
>> +	if (ret) {
>> +		dev_err(dev, "failed to enable clock\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = devm_add_action_or_reset(dev, ecap_cnt_clk_disable, ecap_dev->clk);
>> +	if (ret) {
>> +		dev_err(dev, "failed to add clock disable action\n");
>> +		return ret;
>> +	}
>> +
>> +	ecap_dev->clk_rate = clk_get_rate(ecap_dev->clk);
>> +	if (!ecap_dev->clk_rate) {
>> +		dev_err(dev, "failed to get clock rate\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	mmio_base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(mmio_base))
>> +		return PTR_ERR(mmio_base);
>> +
>> +	ecap_dev->regmap = devm_regmap_init_mmio(dev, mmio_base, &ecap_cnt_regmap_config);
>> +	if (IS_ERR(ecap_dev->regmap))
>> +		return dev_err_probe(dev, PTR_ERR(ecap_dev->regmap), "failed to init regmap\n");
>> +
>> +	spin_lock_init(&ecap_dev->lock);
>> +
>> +	ret = platform_get_irq(pdev, 0);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to get irq\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = devm_request_irq(dev, ret, ecap_cnt_isr, 0, pdev->name, counter_dev);
>> +	if (ret) {
>> +		dev_err(dev, "failed to request irq\n");
>> +		return ret;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, counter_dev);
>> +	pm_runtime_enable(dev);
>> +
>> +	ecap_dev->enabled = 0;
>> +	ecap_cnt_capture_set_evmode(counter_dev, 0);
>> +
>> +	ret = devm_counter_add(dev, counter_dev);
>> +	if (ret) {
>> +		dev_err(dev, "failed to add counter\n");
>> +		pm_runtime_disable(dev);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int ecap_cnt_remove(struct platform_device *pdev)
>> +{
>> +	struct counter_device *counter_dev = platform_get_drvdata(pdev);
>> +	struct ecap_cnt_dev *ecap_dev = counter_priv(counter_dev);
>> +
>> +	if (ecap_dev->enabled)
>> +		ecap_cnt_capture_disable(counter_dev);
>> +
>> +	pm_runtime_disable(&pdev->dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ecap_cnt_suspend(struct device *dev)
>> +{
>> +	struct counter_device *counter_dev = dev_get_drvdata(dev);
>> +	struct ecap_cnt_dev *ecap_dev = counter_priv(counter_dev);
>> +
>> +	/* If eCAP is running, stop capture then save timestamp counter */
>> +	if (ecap_dev->enabled) {
>> +		ecap_cnt_capture_disable(counter_dev);
>> +
>> +		pm_runtime_get_sync(dev);
>> +		regmap_read(ecap_dev->regmap, ECAP_TSCNT_REG, &ecap_dev->pm_ctx.time_cntr);
>> +		pm_runtime_put_sync(dev);
>> +	}
>> +
>> +	ecap_dev->pm_ctx.ev_mode = ecap_cnt_capture_get_evmode(counter_dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ecap_cnt_resume(struct device *dev)
>> +{
>> +	struct counter_device *counter_dev = dev_get_drvdata(dev);
>> +	struct ecap_cnt_dev *ecap_dev = counter_priv(counter_dev);
>> +
>> +	ecap_cnt_capture_set_evmode(counter_dev, ecap_dev->pm_ctx.ev_mode);
>> +
>> +	/* If eCAP was running, restore timestamp counter then run capture */
>> +	if (ecap_dev->enabled) {
>> +		pm_runtime_get_sync(dev);
>> +		regmap_write(ecap_dev->regmap, ECAP_TSCNT_REG, ecap_dev->pm_ctx.time_cntr);
>> +		pm_runtime_put_sync(dev);
>> +
>> +		ecap_cnt_capture_enable(counter_dev, false);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static DEFINE_SIMPLE_DEV_PM_OPS(ecap_cnt_pm_ops, ecap_cnt_suspend, ecap_cnt_resume);
>> +
>> +static const struct of_device_id ecap_cnt_of_match[] = {
>> +	{ .compatible	= "ti,am62-ecap-capture" },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, ecap_cnt_of_match);
>> +
>> +static struct platform_driver ecap_cnt_driver = {
>> +	.probe = ecap_cnt_probe,
>> +	.remove = ecap_cnt_remove,
>> +	.driver = {
>> +		.name = "ecap-capture",
>> +		.of_match_table = ecap_cnt_of_match,
>> +		.pm = pm_sleep_ptr(&ecap_cnt_pm_ops),
>> +	},
>> +};
>> +module_platform_driver(ecap_cnt_driver);
>> +
>> +MODULE_DESCRIPTION("ECAP Capture driver");
>> +MODULE_AUTHOR("Julien Panis <jpanis@baylibre.com>");
>> +MODULE_LICENSE("GPL");
>> diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
>> index 96c5ffd368ad..4c5372c6f2a3 100644
>> --- a/include/uapi/linux/counter.h
>> +++ b/include/uapi/linux/counter.h
>> @@ -63,6 +63,8 @@ enum counter_event_type {
>>   	COUNTER_EVENT_INDEX,
>>   	/* State of counter is changed */
>>   	COUNTER_EVENT_CHANGE_OF_STATE,
>> +	/* Count value is captured */
>> +	COUNTER_EVENT_CAPTURE,
>>   };
>>   
>>   /**
>> -- 
>> 2.25.1
>>

