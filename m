Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC046580123
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 17:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbiGYPHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 11:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiGYPHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 11:07:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAA9112D0A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 08:07:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F9EF2B;
        Mon, 25 Jul 2022 08:07:48 -0700 (PDT)
Received: from [10.1.30.135] (e127744.cambridge.arm.com [10.1.30.135])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65BC43F73D;
        Mon, 25 Jul 2022 08:07:46 -0700 (PDT)
Subject: Re: [PATCH v1 1/4] coresight: Remove unused function parameter
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        suzuki.poulose@arm.com
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        linux-kernel@vger.kernel.org
References: <20220725145221.517776-1-james.clark@arm.com>
 <20220725145221.517776-2-james.clark@arm.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <9292b1c9-25ab-1137-1a34-3783f3835f2b@arm.com>
Date:   Mon, 25 Jul 2022 16:07:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220725145221.517776-2-james.clark@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/07/2022 15:52, James Clark wrote:
> The ability to use a custom function in this sysfs show function isn't
> used so remove it.
>
> No functional changes.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-priv.h | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index ff1dd2092ac5..f2458b794ef3 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -40,31 +40,23 @@
>  #define ETM_MODE_EXCL_KERN	BIT(30)
>  #define ETM_MODE_EXCL_USER	BIT(31)
>  
> -typedef u32 (*coresight_read_fn)(const struct device *, u32 offset);
> -#define __coresight_simple_func(type, func, name, lo_off, hi_off)	\
> +#define __coresight_simple_show(type, name, lo_off, hi_off)		\
>  static ssize_t name##_show(struct device *_dev,				\
>  			   struct device_attribute *attr, char *buf)	\
>  {									\
>  	type *drvdata = dev_get_drvdata(_dev->parent);			\
> -	coresight_read_fn fn = func;					\
>  	u64 val;							\
>  	pm_runtime_get_sync(_dev->parent);				\
> -	if (fn)								\
> -		val = (u64)fn(_dev->parent, lo_off);			\
> -	else								\
> -		val = coresight_read_reg_pair(drvdata->base,		\
> -						 lo_off, hi_off);	\
> +	val = coresight_read_reg_pair(drvdata->base, lo_off, hi_off);	\
>  	pm_runtime_put_sync(_dev->parent);				\
>  	return scnprintf(buf, PAGE_SIZE, "0x%llx\n", val);		\

Sorry for the slightly out-of-scope reply, but I think you could also 
take the opportunity to replace scnprintf() calls with sysfs_emit()   
calls, if you think it is worth it.

Thanks,
German

>  }									\
>  static DEVICE_ATTR_RO(name)
>  
> -#define coresight_simple_func(type, func, name, offset)			\
> -	__coresight_simple_func(type, func, name, offset, -1)
>  #define coresight_simple_reg32(type, name, offset)			\
> -	__coresight_simple_func(type, NULL, name, offset, -1)
> +	__coresight_simple_show(type, name, offset, -1)
>  #define coresight_simple_reg64(type, name, lo_off, hi_off)		\
> -	__coresight_simple_func(type, NULL, name, lo_off, hi_off)
> +	__coresight_simple_show(type, name, lo_off, hi_off)
>  
>  extern const u32 coresight_barrier_pkt[4];
>  #define CORESIGHT_BARRIER_PKT_SIZE (sizeof(coresight_barrier_pkt))
