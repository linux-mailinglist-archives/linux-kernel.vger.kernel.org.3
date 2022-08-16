Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291A1595A80
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbiHPLpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbiHPLon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:44:43 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E82489926;
        Tue, 16 Aug 2022 04:16:18 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id pm17so9454164pjb.3;
        Tue, 16 Aug 2022 04:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=Xy+EaOiEc1JCMZ8GINadKxdPfXI92avbQ2dDQK0SSyk=;
        b=Xw+Q+ixzKywCpKI5OZPEmzO6giboj540bxTt+7cQMRYaS6/csJqsBo4sOcrUDxzSDL
         q5Yph0HXl6F6+lhbiCCT8T7EqLpsmiUADfE5A1nnzD7Zs34+SNJIfLJkPmDrLKmBu8Xl
         zRu72buqGGIJCJreBso2QDF4egDplidn+mSjzZNZOgrPfHYPUdgIv0cQ1hbDx3QzwZbT
         RYMrs7Sz9e/hrtHuPeUrLPVdFHTn5IDS5wNWDjXdYSuoicEbgswUtJwJQEAsa8RxFBxA
         9uCydaqGW7tOkr2U+f6QpyvqxteiNq74eSLG9k9TPVW5E62beoaHZQgqYVS6eW+pbycz
         5Fhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=Xy+EaOiEc1JCMZ8GINadKxdPfXI92avbQ2dDQK0SSyk=;
        b=PlhxKHqVOP3zEac5MdLgeXVOcvlXsCnYk8+QGFz+GuYgd7KfRky4N7PDp+eUVBA8Wm
         SbZZfQdSSNHueTe2yBEoFF/J3Dyf3y+jxB8TGBZla9PfgEcxGw1LIYiFS11qt1g0pdXX
         X7A0gGNOtESvIXg9CZU595ms/yqcoBhmwde4LlcxddeIPO6mZi2BvOVJjSRJoq3GTjI2
         Ej270TZGTlVJ918deUfYzY6w2rO5GOHMWHVf4sprcR7iNcC+nHfz+RphqUpK47+n9Skf
         ztMCmaJfjn258nXR3SEg6xH2WAdKe31rQGh4F3XWal4eU2Ztjdn/hwE64IPX6qqttA4k
         KEWQ==
X-Gm-Message-State: ACgBeo17mP/mind72+KNnLFGwR2uy4GVknvdq9V//AmuyEGwTjGdnPCf
        jzuZ7kFELst00+fiJn3bEOE=
X-Google-Smtp-Source: AA6agR7TL3UsCCadTluDBmqUz/Qr3DXI4cN3/IuBOlSn8FFltQnRci7VdgGqxItSk4ar5OG7sBahzQ==
X-Received: by 2002:a17:90b:350a:b0:1f5:6a5e:5d12 with SMTP id ls10-20020a17090b350a00b001f56a5e5d12mr32988249pjb.46.1660648577156;
        Tue, 16 Aug 2022 04:16:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g28-20020aa79f1c000000b00518a473265csm1032805pfr.217.2022.08.16.04.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 04:16:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 16 Aug 2022 04:16:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        corbet@lwn.net, fenghua.yu@intel.com, jdelvare@suse.com,
        len.brown@intel.com
Subject: Re: [PATCH V2 3/8] hwmon/coretemp: Handle large core ID value
Message-ID: <20220816111615.GD1108868@roeck-us.net>
References: <20220816051633.17775-1-rui.zhang@intel.com>
 <20220816051633.17775-4-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816051633.17775-4-rui.zhang@intel.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 01:16:28PM +0800, Zhang Rui wrote:
> The coretemp driver supports up to a hard-coded limit of 128 cores.
> 
> Today, the driver can not support a core with an ID above that limit.
> Yet, the encoding of core ID's is arbitrary (BIOS APIC-ID) and so they
> may be sparse and they may be large.
> 
> Update the driver to map arbitrary core ID numbers into appropriate
> array indexes so that 128 cores can be supported, no matter the encoding
> of core ID's.
> 
> Acked-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/hwmon/coretemp.c | 56 +++++++++++++++++++++++++++++-----------
>  1 file changed, 41 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index bfdcfe8ccb34..291566aeb703 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -46,9 +46,6 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
>  #define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
>  #define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
>  
> -#define TO_CORE_ID(cpu)		(cpu_data(cpu).cpu_core_id)
> -#define TO_ATTR_NO(cpu)		(TO_CORE_ID(cpu) + BASE_SYSFS_ATTR_NO)
> -
>  #ifdef CONFIG_SMP
>  #define for_each_sibling(i, cpu) \
>  	for_each_cpu(i, topology_sibling_cpumask(cpu))
> @@ -91,6 +88,8 @@ struct temp_data {
>  struct platform_data {
>  	struct device		*hwmon_dev;
>  	u16			pkg_id;
> +	u16			cpu_map[NUM_REAL_CORES];
> +	struct ida		ida;
>  	struct cpumask		cpumask;
>  	struct temp_data	*core_data[MAX_CORE_DATA];
>  	struct device_attribute name_attr;
> @@ -441,7 +440,7 @@ static struct temp_data *init_temp_data(unsigned int cpu, int pkg_flag)
>  							MSR_IA32_THERM_STATUS;
>  	tdata->is_pkg_data = pkg_flag;
>  	tdata->cpu = cpu;
> -	tdata->cpu_core_id = TO_CORE_ID(cpu);
> +	tdata->cpu_core_id = topology_core_id(cpu);
>  	tdata->attr_size = MAX_CORE_ATTRS;
>  	mutex_init(&tdata->update_lock);
>  	return tdata;
> @@ -454,7 +453,7 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
>  	struct platform_data *pdata = platform_get_drvdata(pdev);
>  	struct cpuinfo_x86 *c = &cpu_data(cpu);
>  	u32 eax, edx;
> -	int err, attr_no;
> +	int err, index, attr_no;
>  
>  	/*
>  	 * Find attr number for sysfs:
> @@ -462,14 +461,26 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
>  	 * The attr number is always core id + 2
>  	 * The Pkgtemp will always show up as temp1_*, if available
>  	 */
> -	attr_no = pkg_flag ? PKG_SYSFS_ATTR_NO : TO_ATTR_NO(cpu);
> +	if (pkg_flag) {
> +		attr_no = PKG_SYSFS_ATTR_NO;
> +	} else {
> +		index = ida_alloc(&pdata->ida, GFP_KERNEL);
> +		if (index < 0)
> +			return index;
> +		pdata->cpu_map[index] = topology_core_id(cpu);
> +		attr_no = index + BASE_SYSFS_ATTR_NO;
> +	}
>  
> -	if (attr_no > MAX_CORE_DATA - 1)
> -		return -ERANGE;
> +	if (attr_no > MAX_CORE_DATA - 1) {
> +		err = -ERANGE;
> +		goto ida_free;
> +	}
>  
>  	tdata = init_temp_data(cpu, pkg_flag);
> -	if (!tdata)
> -		return -ENOMEM;
> +	if (!tdata) {
> +		err = -ENOMEM;
> +		goto ida_free;
> +	}
>  
>  	/* Test if we can access the status register */
>  	err = rdmsr_safe_on_cpu(cpu, tdata->status_reg, &eax, &edx);
> @@ -505,6 +516,9 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
>  exit_free:
>  	pdata->core_data[attr_no] = NULL;
>  	kfree(tdata);
> +ida_free:
> +	if (!pkg_flag)
> +		ida_free(&pdata->ida, index);
>  	return err;
>  }
>  
> @@ -524,6 +538,9 @@ static void coretemp_remove_core(struct platform_data *pdata, int index)
>  
>  	kfree(pdata->core_data[index]);
>  	pdata->core_data[index] = NULL;
> +
> +	if (index >= BASE_SYSFS_ATTR_NO)
> +		ida_free(&pdata->ida, index - BASE_SYSFS_ATTR_NO);
>  }
>  
>  static int coretemp_probe(struct platform_device *pdev)
> @@ -537,6 +554,7 @@ static int coretemp_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	pdata->pkg_id = pdev->id;
> +	ida_init(&pdata->ida);
>  	platform_set_drvdata(pdev, pdata);
>  
>  	pdata->hwmon_dev = devm_hwmon_device_register_with_groups(dev, DRVNAME,
> @@ -553,6 +571,7 @@ static int coretemp_remove(struct platform_device *pdev)
>  		if (pdata->core_data[i])
>  			coretemp_remove_core(pdata, i);
>  
> +	ida_destroy(&pdata->ida);
>  	return 0;
>  }
>  
> @@ -647,7 +666,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
>  	struct platform_device *pdev = coretemp_get_pdev(cpu);
>  	struct platform_data *pd;
>  	struct temp_data *tdata;
> -	int index, target;
> +	int i, index = -1, target;
>  
>  	/*
>  	 * Don't execute this on suspend as the device remove locks
> @@ -660,12 +679,19 @@ static int coretemp_cpu_offline(unsigned int cpu)
>  	if (!pdev)
>  		return 0;
>  
> -	/* The core id is too big, just return */
> -	index = TO_ATTR_NO(cpu);
> -	if (index > MAX_CORE_DATA - 1)
> +	pd = platform_get_drvdata(pdev);
> +
> +	for (i = 0; i < NUM_REAL_CORES; i++) {
> +		if (pd->cpu_map[i] == topology_core_id(cpu)) {
> +			index = i + BASE_SYSFS_ATTR_NO;
> +			break;
> +		}
> +	}
> +
> +	/* Too many cores and this core is not populated, just return */
> +	if (index < 0)
>  		return 0;
>  
> -	pd = platform_get_drvdata(pdev);
>  	tdata = pd->core_data[index];
>  
>  	cpumask_clear_cpu(cpu, &pd->cpumask);
> -- 
> 2.25.1
> 
