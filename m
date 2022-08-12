Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6875914B5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 19:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239322AbiHLRQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 13:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiHLRQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 13:16:06 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148748C00A;
        Fri, 12 Aug 2022 10:16:04 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so1501913pjl.0;
        Fri, 12 Aug 2022 10:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=iBEBZOechpa068VAHtNj8j6pUKrVkIcPB+LaVmGFPJk=;
        b=q2P4M2g7xhfvoWiknLxrbXjpXu69d/q4zhXchpjqRMFuB8WfNu3aEc0JZ5vt0onlDE
         o4vacFIcyRes3YDJeaU38A1dusmvCpZkLrv/r5CpfZTs8J6Piau2OnUOO5SbgUdFQMZU
         K2NfbFreCifvFbgsk+qdUSAvBrPhRCBLvlgftrlocMmSlL9oXWnCQRnGhmDU5R/2ijAc
         hVX4oEsBUvjcm5E0LXSj6yW24jK0S9ffosCBv33iskAPjqO++hpaP42FpHkQH9wjDKXY
         c7NNEo5kTP3zMKjawwCq81akmCfw2B6JYiYcZqRoGzNX4d2+a6aaPOVoP765k/tb2eYL
         Bvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=iBEBZOechpa068VAHtNj8j6pUKrVkIcPB+LaVmGFPJk=;
        b=axVUfdHLlOY0TLViGIm2h70HV7OtAARfSYRMZv4/2QYMdLmibChwGX8EtugNO1hmDG
         VTo63UX1qp/OrwPOHGi2BieFE/EznFsWuzpJXm2SAXVQM76qRdoFR9820FRU2ukyj7qx
         bkOkbcFcj20x+QnXPvsgVkRCVNYg5xNeeg/94gIdANY/0U6vYQ73QArYHt9rIK8MERMa
         EVcMIcd8h5FScKiPzECFy7/IqlRVaotFZrwP9aqBIRmt8pSQ8gZv+q0GwrAW2ue733/3
         riRe4CMr/uGrg5+xHJt4pfrs6HLQzvpTIAXD4Z3qNM+eQRZ/8e7bdYvAcnG8mKaWYHrg
         o0cA==
X-Gm-Message-State: ACgBeo0JIOPiZRMie45LrF4923z41v72Q+8NmTA4PSE1q9ZatRUuVIc8
        BUftIlfKB8F3qCAQ1jCYgYg=
X-Google-Smtp-Source: AA6agR5TcwLaaYiS3fv6nwUccF/8tTFa00FNi/5axnOHKok9uu3CLL6jemxN9EMrWe5EeHRUdR0cNA==
X-Received: by 2002:a17:90b:4f8e:b0:1f4:ed30:d286 with SMTP id qe14-20020a17090b4f8e00b001f4ed30d286mr5353525pjb.66.1660324563450;
        Fri, 12 Aug 2022 10:16:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w1-20020a631601000000b004129741dd9dsm1579909pgl.51.2022.08.12.10.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 10:16:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 12 Aug 2022 10:16:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        corbet@lwn.net, fenghua.yu@intel.com, jdelvare@suse.com,
        len.brown@intel.com
Subject: Re: [PATCH 3/7] hwmon/coretemp: Handle large core id value
Message-ID: <20220812171600.GB2960077@roeck-us.net>
References: <20220812164144.30829-1-rui.zhang@intel.com>
 <20220812164144.30829-4-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812164144.30829-4-rui.zhang@intel.com>
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

On Sat, Aug 13, 2022 at 12:41:40AM +0800, Zhang Rui wrote:
> The coretemp driver supports up to a hard-coded limit of 128 cores.
> 
> Today, the driver can not support a core with an id above that limit.
> Yet, the encoding of core_id's is arbitrary (BIOS APIC-id) and so they
> may be sparse and they may be large.
> 
> Update the driver to map arbitrary core_id numbers into appropriate
> array indexes so that 128 cores can be supported, no matter the encoding
> of core_ids's.
> 
> Acked-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/hwmon/coretemp.c | 55 +++++++++++++++++++++++++++++-----------
>  1 file changed, 40 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index ccf0af5b988a..3f0f7d7612ae 100644
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
> +	if (pkg_flag)
> +		attr_no = PKG_SYSFS_ATTR_NO;
> +	else {
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
> @@ -524,6 +538,8 @@ static void coretemp_remove_core(struct platform_data *pdata, int indx)
>  
>  	kfree(pdata->core_data[indx]);
>  	pdata->core_data[indx] = NULL;
> +
> +	ida_free(&pdata->ida, indx - BASE_SYSFS_ATTR_NO);
>  }
>  
>  static int coretemp_probe(struct platform_device *pdev)
> @@ -537,6 +553,7 @@ static int coretemp_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	pdata->pkg_id = pdev->id;
> +	ida_init(&pdata->ida);
>  	platform_set_drvdata(pdev, pdata);
>  
>  	pdata->hwmon_dev = devm_hwmon_device_register_with_groups(dev, DRVNAME,
> @@ -553,6 +570,7 @@ static int coretemp_remove(struct platform_device *pdev)
>  		if (pdata->core_data[i])
>  			coretemp_remove_core(pdata, i);
>  
> +	ida_destroy(&pdata->ida);
>  	return 0;
>  }
>  
> @@ -647,7 +665,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
>  	struct platform_device *pdev = coretemp_get_pdev(cpu);
>  	struct platform_data *pd;
>  	struct temp_data *tdata;
> -	int indx, target;
> +	int i, indx = -1, target;
>  
>  	/*
>  	 * Don't execute this on suspend as the device remove locks
> @@ -660,12 +678,19 @@ static int coretemp_cpu_offline(unsigned int cpu)
>  	if (!pdev)
>  		return 0;
>  
> -	/* The core id is too big, just return */
> -	indx = TO_ATTR_NO(cpu);
> -	if (indx > MAX_CORE_DATA - 1)
> +	pd = platform_get_drvdata(pdev);
> +
> +	for (i = 0; i < NUM_REAL_CORES; i++) {
> +		if (pd->cpu_map[i] == topology_core_id(cpu)) {
> +			indx = i + BASE_SYSFS_ATTR_NO;
> +			break;
> +		}
> +	}
> +
> +	/* Too many cores and this core is not pupolated, just return */

populated

Other than that looks good.

Acked-by: Guenter Roeck <linux@roeck-us.net>

> +	if (indx < 0)
>  		return 0;
>  
> -	pd = platform_get_drvdata(pdev);
>  	tdata = pd->core_data[indx];
>  
>  	cpumask_clear_cpu(cpu, &pd->cpumask);
> -- 
> 2.34.1
> 
