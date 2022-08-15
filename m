Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643B1593278
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiHOPuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiHOPui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:50:38 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2B85F67;
        Mon, 15 Aug 2022 08:50:35 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 7CE2A760; Mon, 15 Aug 2022 10:50:34 -0500 (CDT)
Date:   Mon, 15 Aug 2022 10:50:34 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Serge Hallyn <serge@hallyn.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, John Haxby <john.haxby@oracle.com>
Subject: Re: [PATCH v2] capabilities: new kernel.ns_modules_allowed sysctl
Message-ID: <20220815155034.GB20944@mail.hallyn.com>
References: <20220815082753.6088-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815082753.6088-1-vegard.nossum@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 10:27:53AM +0200, Vegard Nossum wrote:
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
> 
> Testing: Running the reproducer for CVE-2022-2588 fails and results in the
> following message in the kernel log:
> 
>     [  130.208030] request_module: pid 4107 (a.out) requested kernel module rtnl-link-dummy; denied due to kernel.ns_modules_allowed sysctl
> 
> v2:
> - fix build failure due to missing CONFIG_SYSCTL guard around register_sysctl_init()
> - use .maxlen = sizeof(int) for proc_dobool()
> - don't warn when sysctl_ns_modules_allowed == 1
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
> index ee6572b1edada..1e13f7f1a9550 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -604,6 +604,17 @@ A value of 0 means no change. The default value is 200 meaning the NMI
>  watchdog is set to 30s (based on ``watchdog_thresh`` equal to 10).
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
> index 80fe60fa77fba..0b99268da5081 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1245,6 +1245,23 @@ config USER_NS
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
> index b717134ebe170..46f8c0ad6c921 100644
> --- a/kernel/kmod.c
> +++ b/kernel/kmod.c
> @@ -25,6 +25,7 @@
>  #include <linux/ptrace.h>
>  #include <linux/async.h>
>  #include <linux/uaccess.h>
> +#include <linux/sysctl.h>
>  
>  #include <trace/events/module.h>
>  
> @@ -105,6 +106,12 @@ static int call_modprobe(char *module_name, int wait)
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
> @@ -148,6 +155,18 @@ int __request_module(bool wait, const char *fmt, ...)
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * Disallow if we're in a user namespace and we don't have
> +	 * CAP_SYS_MODULE in the init namespace.
> +	 */
> +	if (current_user_ns() != &init_user_ns &&
> +	    !capable(CAP_SYS_MODULE) &&

It's monday, so maybe I'm thinking wrongly - but I don't believe that you can
possible pass capable(CAP_SYS_MODULE) if current_user_ns() != &init_user_ns.
So I think you can drop the second check.

> +	    !sysctl_ns_modules_allowed) {
> +		pr_warn_ratelimited("request_module: pid %d (%s) in user namespace requested kernel module %s; denied due to kernel.ns_modules_allowed sysctl\n",
> +			task_pid_nr(current), current->comm, module_name);
> +		return -EPERM;
> +	}
> +
>  	if (atomic_dec_if_positive(&kmod_concurrent_max) < 0) {
>  		pr_warn_ratelimited("request_module: kmod_concurrent_max (%u) close to 0 (max_modprobes: %u), for module %s, throttling...",
>  				    atomic_read(&kmod_concurrent_max),
> @@ -175,3 +194,23 @@ int __request_module(bool wait, const char *fmt, ...)
>  	return ret;
>  }
>  EXPORT_SYMBOL(__request_module);
> +
> +#ifdef CONFIG_SYSCTL
> +static struct ctl_table kmod_sysctl_table[] = {
> +	{
> +		.procname       = "ns_modules_allowed",
> +		.data           = &sysctl_ns_modules_allowed,
> +		.maxlen         = sizeof(int),
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
> +#endif
> -- 
> 2.35.1.46.g38062e73e0
