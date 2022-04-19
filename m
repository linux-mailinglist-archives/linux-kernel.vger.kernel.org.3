Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660F1506C90
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345417AbiDSMhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiDSMh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:37:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89D53340C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650371682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kmRkaKzAt9R+U4rWTjWmga5zw1HoOc2kC7WKpK/XhjA=;
        b=HNAqWrwc2fJFwVNEB2eiuEA2s5n5dM06iIU4kNc40i7pNXw0gFnTHHKMv/eheNTbWi8uxu
        OsT9JBMuzVtWTcHrBMNaXi3Xq0+rvhIqpPX1BW8pzt4TRoi0fiKgHwI/vXqz3URBELgngT
        mwE8qzIs+SDV5pBfyXBapjWoattEEPc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-jPIJFVchPR-oAzXrl5iVEA-1; Tue, 19 Apr 2022 08:34:41 -0400
X-MC-Unique: jPIJFVchPR-oAzXrl5iVEA-1
Received: by mail-wr1-f69.google.com with SMTP id p18-20020adf9592000000b00207bc12decbso1605880wrp.21
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=kmRkaKzAt9R+U4rWTjWmga5zw1HoOc2kC7WKpK/XhjA=;
        b=LkjB7+9ekZiNSRvx4Tt0bDJia53vFxbAc6s9OS1JimwOJPtEenWToRWAiPlE95lelb
         N9PD02GW1hQ0lBLofF8RbxOJfY49931QW2DPlWfieWVb9AIdEFACrZ6TivK7eKxg+yfV
         lVKNudWyNwdcScEQaflSjM69O160irNHC24IBxo2toH5gbn6WJf43N+SU98GEs634sbR
         CDecFv776R7DYbJJhHF/QWNuM+2a4uyDKcJXcOepjM3r/F4z5IHMhICj8+ytDmKMX+Lb
         pDIqez0i9/rX4jrPMalUom9lXrQZoVbnYHKJJiZKNYSJgICB64Ujhacn0rsTu516NWTD
         XhWQ==
X-Gm-Message-State: AOAM531WbY8Y7621DFE0RnxQW0xIXSgz8hQkwuMrYoYfLXCfIsVXE+ZU
        ul8LnraAUvdR/LVNajid9syLt6JdSVIL8p9ju5uw21ZfMRSIVTSJja40aAMdzKJbjzjYRSsBDk2
        kL69zVJyAWI3He3HJVgi7hPHF
X-Received: by 2002:adf:e188:0:b0:207:9b59:9d82 with SMTP id az8-20020adfe188000000b002079b599d82mr11441204wrb.114.1650371679940;
        Tue, 19 Apr 2022 05:34:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfp002VP04ht3smessK2Y4vAHKcqQI5bI1sFeNhNsV7IhBIUmSKtYiAN70U6ifKiIlcXyeyw==
X-Received: by 2002:adf:e188:0:b0:207:9b59:9d82 with SMTP id az8-20020adfe188000000b002079b599d82mr11441185wrb.114.1650371679646;
        Tue, 19 Apr 2022 05:34:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5d00:d8c2:fbf6:a608:957a? (p200300cbc7045d00d8c2fbf6a608957a.dip0.t-ipconnect.de. [2003:cb:c704:5d00:d8c2:fbf6:a608:957a])
        by smtp.gmail.com with ESMTPSA id a4-20020a056000188400b0020a9ec6e8e3sm3830865wri.55.2022.04.19.05.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 05:34:39 -0700 (PDT)
Message-ID: <d98bb24d-b8cd-b00b-57c3-d96dae57ad5b@redhat.com>
Date:   Tue, 19 Apr 2022 14:34:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>,
        Baokun Li <libaokun1@huawei.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        David Hildenbrand <dhildenb@redhat.com>
References: <20220418195402.2986573-1-jsavitz@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH] kernel/cpu: restart cpu_up when hotplug is disabled
In-Reply-To: <20220418195402.2986573-1-jsavitz@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.04.22 21:54, Joel Savitz wrote:
> The cpu hotplug path may be utilized while hotplug is disabled for a
> brief moment leading to failures. As an example, attempts to perform
> cpu hotplug by userspace soon after boot may race with pci_device_probe
> leading to inconsistent results.

You might want to extend a bit in which situation we observed that issue
fairly reliably.

When restricting the number of boot cpus on the kernel cmdline, e.g.,
via "maxcpus=2", udev will find the offline cpus when enumerating all
cpus and try onlining them. Due to the race, onlining of some cpus fails
e.g., when racing with pci_device_probe().

While teaching udev to not online coldplugged CPUs when "maxcpus" was
specified ("policy"), it revealed the underlying issue that onlining a
CPU can fail with -EBUSY in corner cases when cpu hotplug is temporarily
disabled.

> 
> Proposed idea:
> Call restart_syscall instead of returning -EBUSY since
> cpu_hotplug_disabled seems to only have a positive value
> for short, temporary amounts of time.
> 
> Does anyone see any serious problems with this?
> 
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>  kernel/cpu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 5797c2a7a93f..2992c7d1d24e 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -35,6 +35,7 @@
>  #include <linux/percpu-rwsem.h>
>  #include <linux/cpuset.h>
>  #include <linux/random.h>
> +#include <linux/delay.h>
>  
>  #include <trace/events/power.h>
>  #define CREATE_TRACE_POINTS
> @@ -1401,7 +1402,9 @@ static int cpu_up(unsigned int cpu, enum cpuhp_state target)
>  	cpu_maps_update_begin();
>  
>  	if (cpu_hotplug_disabled) {
> -		err = -EBUSY;
> +		/* avoid busy looping (5ms of sleep should be enough) */
> +		msleep(5);
> +		err = restart_syscall();

It's worth noting that we use the same approach in
lock_device_hotplug_sysfs(). It's far from perfect I would say, but we
really wanted to avoid letting user space having to deal with retry logic.


For example, while memory onlining can fail with -EBUSY, it's not
expected to fail during memory onlining (we only fail in very rare
cases, when a memory notifier fails -- for example when kasan fails to
allocate memory).

-- 
Thanks,

David / dhildenb

