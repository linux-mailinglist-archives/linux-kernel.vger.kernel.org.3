Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B255D524977
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352285AbiELJxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352268AbiELJxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1393E433B9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652349185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+3Nztyld9eDHPSeSn0M3tTjhNNbITpLXi7y864KZCxM=;
        b=UiXBrWdBc5iVbljqIMa4ZyPUmdxeai1X/XJh05BK/SKKTinWhqC+c8woMaKF73ii/X7BLo
        tDMJBDGMVfB4itG5fd8jDXXuQiS9J+nIG7nO4517pIaKnksk9BpX0TEn1CgJHONvNSfduh
        c/xRivG9uFVsfaOOvDF2Ct2vYLxnP3Q=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-gR8rIPG1MgqvdKdo8lfAmQ-1; Thu, 12 May 2022 05:53:03 -0400
X-MC-Unique: gR8rIPG1MgqvdKdo8lfAmQ-1
Received: by mail-ed1-f70.google.com with SMTP id r8-20020a056402018800b00428b43999feso2855115edv.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+3Nztyld9eDHPSeSn0M3tTjhNNbITpLXi7y864KZCxM=;
        b=OqE/pOPUZyDfdYeINwHYbGGXdrsRaq3BGSiC6fSEXvJ2O7GiOmXszBTuUdZd7Y8ORW
         4p+ZDlJ/iUZFu+UWTe98NGF8s9Cr1lw6o/G3N0xYBFHnTvEhcWC/q9EPBeFSOB8wJIg9
         LLsz3b+4nEZ/Jri2Vslfp4Ag3+KKwycMsJA5xFBeEvITrzffJJXbhil2cX4qp3ZeUVBC
         usAYr4RS+8W7TLaZ2DgSyAY4/i6Rhqo3Ro2Sb2K1XuZkX4qNBuk+9Rs3ayHY1nyIDrZG
         gJ1yl3rjIAhAuLtWc9iddbavdn9GkK5U1VC4EFpSFzcCeitaAcqURCLcczJXCWjhooJR
         Ir8g==
X-Gm-Message-State: AOAM531ZB+hnMQGQQNTKgBDUEOHUPs7E8BOLsecpUJ9OQJvKYFmVnYUj
        WOm3XIMexdvwCV2dCPYVKhfh3XZv6WgLJd1JmVGa56FxwMKfXeu+2dwthXLrLN/5D9WcRU3nefG
        FsxWp9jU2wp464W0eJ5zXePdo
X-Received: by 2002:a05:6402:26d3:b0:427:c57f:5333 with SMTP id x19-20020a05640226d300b00427c57f5333mr33933004edd.61.1652349182125;
        Thu, 12 May 2022 02:53:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxU+yiXPvmNwB30ImWEgmeuYovzHEke4htr7L1cgQhehQ+e+3Q/YNZ1VsfIH2fDixst6DQa1g==
X-Received: by 2002:a05:6402:26d3:b0:427:c57f:5333 with SMTP id x19-20020a05640226d300b00427c57f5333mr33932995edd.61.1652349181926;
        Thu, 12 May 2022 02:53:01 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id i11-20020a50870b000000b0042617ba63a6sm2532698edb.48.2022.05.12.02.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 02:53:01 -0700 (PDT)
Message-ID: <ce8e9601-f514-5227-f9f7-87594218f95f@redhat.com>
Date:   Thu, 12 May 2022 11:53:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [pdx86-platform-drivers-x86:review-hans 46/59]
 kernel/stop_machine.c:638:35: error: call to undeclared function
 'cpu_smt_mask'; ISO C99 and later do not support implicit function
 declarations
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
References: <202205120904.Gr9HEY5E-lkp@intel.com> <87zgjnw1bg.ffs@tglx>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <87zgjnw1bg.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/12/22 11:24, Thomas Gleixner wrote:
> On Thu, May 12 2022 at 09:29, kernel test robot wrote:
>>>> kernel/stop_machine.c:638:35: error: call to undeclared function 'cpu_smt_mask'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>>            const struct cpumask *smt_mask = cpu_smt_mask(cpu);
> 
> This warning with W=1 is not the worst of the problems.
> 
> The build will simply fail for CONFIG_SMP=y && CONFIG_SCHED_SMT=n
> because cpu_smt_mask() cannot be resolved.
> 
> The other issue is CONFIG_SMP=n. This will fail to build the IFS driver
> because stop_core_cpuslocked() is not available for SMP=n.

The IFS Kconfig already depends on SMP :

config INTEL_IFS
        tristate "Intel In Field Scan"
        depends on X86 && 64BIT && SMP
        select INTEL_IFS_DEVICE
        help
          Enable ...


So I don't think we need the non-SMP implementation inside
include/linux/stop_machine.h, we only need the #ifdef you
suggest in kernel/stop_machine.c  ?

I think it is best to just squash this into the original
patch, do you agree ?

Regards,

Hans





> Something like the below should work as x86 selects SCHED_SMT when
> SMP=y.
> 
> Thanks,
> 
>         tglx
> ---
> --- a/include/linux/stop_machine.h
> +++ b/include/linux/stop_machine.h
> @@ -156,6 +156,12 @@ static __always_inline int stop_machine_
>  }
>  
>  static __always_inline int
> +stop_core_cpuslocked(unsigned int cpu, cpu_stop_fn_t fn, void *data)
> +{
> +	return stop_machine_cpuslocked(fn, data, NULL);
> +}
> +
> +static __always_inline int
>  stop_machine(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus)
>  {
>  	return stop_machine_cpuslocked(fn, data, cpus);
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -631,6 +631,7 @@ int stop_machine(cpu_stop_fn_t fn, void
>  }
>  EXPORT_SYMBOL_GPL(stop_machine);
>  
> +#ifdef CONFIG_SCHED_SMT
>  int stop_core_cpuslocked(unsigned int cpu, cpu_stop_fn_t fn, void *data)
>  {
>  	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
> @@ -649,6 +650,7 @@ int stop_core_cpuslocked(unsigned int cp
>  	return stop_cpus(smt_mask, multi_cpu_stop, &msdata);
>  }
>  EXPORT_SYMBOL_GPL(stop_core_cpuslocked);
> +#endif
>  
>  /**
>   * stop_machine_from_inactive_cpu - stop_machine() from inactive CPU
> 
> 
> 

