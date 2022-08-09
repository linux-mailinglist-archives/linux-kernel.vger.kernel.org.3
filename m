Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53FD58E36F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiHIW4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiHIW4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:56:08 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6845C638A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:56:07 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 12so12725591pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=qPaf96LOcB5hJ+znr1ij7oaSYni8mR+aeJ7R79yz+nU=;
        b=AUr1j6I25lZeckDGfeCpMtzJEaPSx60qpI608a0xSJLt43SACFuo7adiY2XVGPalre
         Rrg0fw35SHsM88Cgus3Ou/7nE4vEzLyHGOHMvBnBwhAB6kNeKW1c+2h3hQxGrd3mMMm1
         CejQci8R+ZSAT9U++9w0ent+NQeC6pmZ2MoS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=qPaf96LOcB5hJ+znr1ij7oaSYni8mR+aeJ7R79yz+nU=;
        b=tzXh0TEK9bhq+8BCos1C1c8tsyf3PDrlDnpklFIJla8/DYVfbvube5i9kIFcwJVVkC
         QuGbc6Lzem/RbObM/jFrdtCrIdBbSuO1a83GDWpGTEOUBARMF5IPTH48E95uzSaCiiyB
         z/jpb0hLUTccCfl0302uaoad4+vJFU2JVj2v72ZeDaN3t5MZl4IcBl++DVYFI46c8kBG
         yEySA/mCCp2slr2A0A/i9lDyQ2SHNFMPjrZKPDfXz2mGyTfC54TdicMCe0UxfCDtp+8k
         K4+/o7a6RC+l6fOXrFFlVc1npT9lW+XRqj/bzHKiPnFv/yrgdPfeZFOJJB5zH4sbMZPV
         TZ4w==
X-Gm-Message-State: ACgBeo2slecnpIfjc5XN+2QTU27jRup816QqixIqVuCbe7d2ZYcdPqP2
        lk+4voiomhllxFcvxApXkwARMg==
X-Google-Smtp-Source: AA6agR4vH0girDDhfOMXFhrKh883gFZTMenDBS+TjIu0dFndaCwIL0vzA1bkEN8fzkYI6oPNafAbpQ==
X-Received: by 2002:a63:80c8:0:b0:41c:62c7:abd7 with SMTP id j191-20020a6380c8000000b0041c62c7abd7mr20931256pgd.570.1660085766916;
        Tue, 09 Aug 2022 15:56:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902680700b0016dbaf3ff2esm11378543plk.22.2022.08.09.15.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:56:05 -0700 (PDT)
Date:   Tue, 9 Aug 2022 15:56:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Serge Hallyn <serge@hallyn.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-hardening@vger.kernel.org, John Haxby <john.haxby@oracle.com>
Subject: Re: [PATCH] capabilities: new kernel.ns_modules_allowed sysctl
Message-ID: <202208091551.6879CADA0@keescook>
References: <20220809185229.28417-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809185229.28417-1-vegard.nossum@oracle.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 08:52:29PM +0200, Vegard Nossum wrote:
> Creating a new user namespace grants you the ability to reach a lot of code
> (including loading certain kernel modules) that would otherwise be out of
> reach of an attacker. We can reduce the attack surface and block exploits
> by ensuring that user namespaces cannot trigger module (auto-)loading.
> 
> A cursory search of exploits found online yields the following extremely
> non-exhaustive list of vulnerabilities, and shows that the technique is
> both old and still in use:
> 
> - CVE-2016-8655
> - CVE-2017-1000112
> - CVE-2021-32606
> - CVE-2022-2588
> - CVE-2022-27666
> - CVE-2022-34918
> 
> This patch adds a new sysctl, kernel.ns_modules_allowed, which when set to
> 0 will block requests to load modules when the request originates in a
> process running in a user namespace.
> 
> For backwards compatibility, the default value of the sysctl is set to
> CONFIG_NS_MODULES_ALLOWED_DEFAULT_ON, which in turn defaults to 1, meaning
> there should be absolutely no change in behaviour unless you opt in either
> at compile time or at runtime.
> 
> This mitigation obviously offers no protection if the vulnerable module is
> already loaded, but for many of these exploits the vast majority of users
> will never actually load or use these modules on purpose; in other words,
> for the vast majority of users, this would block exploits for the above
> list of vulnerabilities.

We've needed better module autoloading protections for a long time[1].
This patch is a big hammer ("all user namespaces"), so I worry it
wouldn't actually get used much.

Here's a pointer into a prior thread, where Linus chimed in[2].
I replied back then, but I'm not sure I agree with my 2017 self any
more. :P

It really does feel like the loading decisions need to be made by the
userspace helper, which currently doesn't have enough information to
make those choices.

-Kees

[1] https://github.com/KSPP/linux/issues/24
[2] https://lore.kernel.org/kernel-hardening/CA+55aFxiDKfe6VCM+aV2OgnkzMpP+iz+rn2k25_Qa_QLex=pPQ@mail.gmail.com/

> 
> Testing: Running the reproducer for CVE-2022-2588 fails and results in the
> following message in the kernel log:
> 
>     [  130.208030] request_module: pid 4107 (a.out) requested kernel module rtnl-link-dummy; denied due to kernel.ns_modules_allowed sysctl
> 
> Cc: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: linux-hardening@vger.kernel.org
> Cc: John Haxby <john.haxby@oracle.com>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 11 ++++++
>  init/Kconfig                                | 17 +++++++++
>  kernel/kmod.c                               | 39 +++++++++++++++++++++
>  3 files changed, 67 insertions(+)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index ddccd10774623..551de7bce836c 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -592,6 +592,17 @@ to the guest kernel command line (see
>  Documentation/admin-guide/kernel-parameters.rst).
>  
>  
> +ns_modules_allowed
> +==================
> +
> +Control whether processes may trigger module loading inside a user namespace.
> +
> += =================================
> +0 Deny module loading requests.
> +1 Accept module loading requests.
> += =================================
> +
> +
>  numa_balancing
>  ==============
>  
> diff --git a/init/Kconfig b/init/Kconfig
> index c984afc489dea..6734373995936 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1226,6 +1226,23 @@ config USER_NS
>  
>  	  If unsure, say N.
>  
> +config NS_MODULES_ALLOWED_DEFAULT_ON
> +	bool "Allow user namespaces to auto-load kernel modules by default"
> +	depends on MODULES
> +	depends on USER_NS
> +	default y
> +	help
> +	  This option makes it so that processes running inside user
> +	  namespaces may auto-load kernel modules.
> +
> +	  Say N to mitigate some exploits that rely on being able to
> +	  auto-load kernel modules; however, this may also cause some
> +	  legitimate programs to fail unless kernel modules are loaded by
> +	  hand.
> +
> +	  You can write 0 or 1 to /proc/sys/kernel/ns_modules_allowed to
> +	  change behaviour at run-time.
> +
>  config PID_NS
>  	bool "PID Namespaces"
>  	default y
> diff --git a/kernel/kmod.c b/kernel/kmod.c
> index b717134ebe170..53e26009410ef 100644
> --- a/kernel/kmod.c
> +++ b/kernel/kmod.c
> @@ -105,6 +105,12 @@ static int call_modprobe(char *module_name, int wait)
>  	return -ENOMEM;
>  }
>  
> +/*
> + * Allow processes running inside namespaces to trigger module loading?
> + */
> +static bool sysctl_ns_modules_allowed __read_mostly =
> +	IS_BUILTIN(CONFIG_NS_MODULES_ALLOWED_DEFAULT_ON);
> +
>  /**
>   * __request_module - try to load a kernel module
>   * @wait: wait (or not) for the operation to complete
> @@ -148,6 +154,21 @@ int __request_module(bool wait, const char *fmt, ...)
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * Disallow if we're in a user namespace and we don't have
> +	 * CAP_SYS_MODULE in the init namespace.
> +	 */
> +	if (current_user_ns() != &init_user_ns && !capable(CAP_SYS_MODULE)) {
> +		if (sysctl_ns_modules_allowed) {
> +			pr_warn_ratelimited("request_module: pid %d (%s) in user namespace requested kernel module %s\n",
> +				task_pid_nr(current), current->comm, module_name);
> +		} else {
> +			pr_warn_ratelimited("request_module: pid %d (%s) in user namespace requested kernel module %s; denied due to kernel.ns_modules_allowed sysctl\n",
> +				task_pid_nr(current), current->comm, module_name);
> +			return -EPERM;
> +		}
> +	}
> +
>  	if (atomic_dec_if_positive(&kmod_concurrent_max) < 0) {
>  		pr_warn_ratelimited("request_module: kmod_concurrent_max (%u) close to 0 (max_modprobes: %u), for module %s, throttling...",
>  				    atomic_read(&kmod_concurrent_max),
> @@ -175,3 +196,21 @@ int __request_module(bool wait, const char *fmt, ...)
>  	return ret;
>  }
>  EXPORT_SYMBOL(__request_module);
> +
> +static struct ctl_table kmod_sysctl_table[] = {
> +	{
> +		.procname       = "ns_modules_allowed",
> +		.data           = &sysctl_ns_modules_allowed,
> +		.maxlen         = sizeof(sysctl_ns_modules_allowed),
> +		.mode           = 0644,
> +		.proc_handler   = proc_dobool,
> +	},
> +	{ }
> +};
> +
> +static int __init kmod_sysctl_init(void)
> +{
> +	register_sysctl_init("kernel", kmod_sysctl_table);
> +	return 0;
> +}
> +late_initcall(kmod_sysctl_init);
> -- 
> 2.35.1.46.g38062e73e0
> 

-- 
Kees Cook
