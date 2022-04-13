Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F894FF366
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbiDMJ0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiDMJ0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:26:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F6FE0B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:24:24 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 84F8821123;
        Wed, 13 Apr 2022 09:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649841863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3VKXcEZA2sPwRKLo+G3WMiWaz661bPFmNmayKU+UMes=;
        b=rC59aO5NueCC6JmGiFK1vm4DHgLshCzW/+ZHHc+7Bjx/cV5zVvCmn/CaIAC3DfTj00/nN+
        FuitJcHU1LKkSSVgDGQSX1VzPKTyYyUXziSFz3KeL7RemqX4Xhl3kr9qFJSCsEvXDfFDnp
        oGbTR5vicacv0zVOb6U7uSmw8W6SghM=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 07B55A3B82;
        Wed, 13 Apr 2022 09:24:22 +0000 (UTC)
Date:   Wed, 13 Apr 2022 11:24:22 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     mcgrof@kernel.org, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, wedsonaf@google.com,
        boqun.feng@gmail.com, christophe.leroy@csgroup.eu,
        swboyd@chromium.org, ojeda@kernel.org, ast@kernel.org,
        gary@garyguo.net, mbenes@suse.cz, ndesaulniers@google.com,
        void@manifault.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        v.narang@samsung.com, Onkarnath <onkarnath.1@samsung.com>
Subject: Re: [PATCH 1/1] kallsyms: add kallsyms_show_value definition in all
 cases
Message-ID: <YlaWxh5qYCe40US7@alley>
References: <CGME20220413055318epcas5p3df3cdde54a559d4002a74de9f23289f2@epcas5p3.samsung.com>
 <20220413055305.1768223-1-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413055305.1768223-1-maninder1.s@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-04-13 11:23:05, Maninder Singh wrote:
> kallsyms_show_value return false if KALLSYMS is disabled,
> but it's used in module.c also.
> Thus when KALLSYMS is disabled, system will not print module
> load address:
> 
> / # insmod crash.ko
> / # lsmod
> crash 12288 0 - Live 0x0000000000000000 (O)
> 
> After change (making definition generic)
> ============
> / # lsmod
> crash 12288 0 - Live 0xffff800000ec0000 (O)
> / # cat /proc/modules
> crash 12288 0 - Live 0xffff800000ec0000 (O)
> / #
> 
> Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---
>  include/linux/kallsyms.h | 11 +++--------
>  kernel/kallsyms.c        | 35 -----------------------------------
>  lib/vsprintf.c           | 36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 39 insertions(+), 43 deletions(-)
> 
> diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
> index e5ad6e31697d..efabb8c18492 100644
> --- a/include/linux/kallsyms.h
> +++ b/include/linux/kallsyms.h
> @@ -24,6 +24,9 @@
>  struct cred;
>  struct module;
>  
> +/* How and when do we show kallsyms values? */
> +extern bool kallsyms_show_value(const struct cred *cred);
>
>  static inline int is_kernel_text(unsigned long addr)
>  {
>  	if (__is_kernel_text(addr))
> @@ -93,9 +96,6 @@ extern int sprint_backtrace_build_id(char *buffer, unsigned long address);
>  int lookup_symbol_name(unsigned long addr, char *symname);
>  int lookup_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name);
>  
> -/* How and when do we show kallsyms values? */
> -extern bool kallsyms_show_value(const struct cred *cred);
> -
>  #else /* !CONFIG_KALLSYMS */
>  
>  static inline unsigned long kallsyms_lookup_name(const char *name)
> @@ -158,11 +158,6 @@ static inline int lookup_symbol_attrs(unsigned long addr, unsigned long *size, u
>  	return -ERANGE;
>  }
>  
> -static inline bool kallsyms_show_value(const struct cred *cred)
> -{
> -	return false;
> -}

With the patch, kallsyms_show_value() might return true even when
CONFIG_KALLYSMS are disabled. Did you check all users of this API
that they could handle this?

For example, the comment in bpf_dump_raw_ok() suggests that
it might require more kallsyms functionality.

static inline bool bpf_dump_raw_ok(const struct cred *cred)
{
	/* Reconstruction of call-sites is dependent on kallsyms,
	 * thus make dump the same restriction.
	 */
	return kallsyms_show_value(cred);
}

You should definitely add into CC people from affected subsystems.
I do not see:

    + Kees Cook who added/updated most of the callers
    + BPF people that might require even more kallsyms functionality
    + kprobe people that using it as well


> -
>  #endif /*CONFIG_KALLSYMS*/
>  
>  static inline void print_ip_sym(const char *loglvl, unsigned long ip)
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index e8d2262ef2d2..71ef15ba20c7 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -818,41 +818,6 @@ static const struct seq_operations kallsyms_op = {
>  	.show = s_show
>  };
>  
> -static inline int kallsyms_for_perf(void)
> -{
> -#ifdef CONFIG_PERF_EVENTS
> -	extern int sysctl_perf_event_paranoid;
> -	if (sysctl_perf_event_paranoid <= 1)
> -		return 1;
> -#endif
> -	return 0;
> -}
> -
> -/*
> - * We show kallsyms information even to normal users if we've enabled
> - * kernel profiling and are explicitly not paranoid (so kptr_restrict
> - * is clear, and sysctl_perf_event_paranoid isn't set).
> - *
> - * Otherwise, require CAP_SYSLOG (assuming kptr_restrict isn't set to
> - * block even that).
> - */
> -bool kallsyms_show_value(const struct cred *cred)
> -{
> -	switch (kptr_restrict) {
> -	case 0:
> -		if (kallsyms_for_perf())
> -			return true;
> -		fallthrough;
> -	case 1:
> -		if (security_capable(cred, &init_user_ns, CAP_SYSLOG,
> -				     CAP_OPT_NOAUDIT) == 0)
> -			return true;
> -		fallthrough;
> -	default:
> -		return false;
> -	}
> -}
> -
>  static int kallsyms_open(struct inode *inode, struct file *file)
>  {
>  	/*
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 49ef55ffabd7..4bc96a4f3a00 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -870,6 +870,42 @@ static char *default_pointer(char *buf, char *end, const void *ptr,
>  
>  int kptr_restrict __read_mostly;
>  
> +static inline int kallsyms_for_perf(void)
> +{
> +#ifdef CONFIG_PERF_EVENTS
> +	extern int sysctl_perf_event_paranoid;
> +
> +	if (sysctl_perf_event_paranoid <= 1)
> +		return 1;
> +#endif
> +	return 0;
> +}
> +
> +/*
> + * We show kallsyms information even to normal users if we've enabled
> + * kernel profiling and are explicitly not paranoid (so kptr_restrict
> + * is clear, and sysctl_perf_event_paranoid isn't set).
> + *
> + * Otherwise, require CAP_SYSLOG (assuming kptr_restrict isn't set to
> + * block even that).
> + */
> +bool kallsyms_show_value(const struct cred *cred)
> +{
> +	switch (kptr_restrict) {
> +	case 0:
> +		if (kallsyms_for_perf())
> +			return true;
> +		fallthrough;
> +	case 1:
> +		if (security_capable(cred, &init_user_ns, CAP_SYSLOG,
> +				     CAP_OPT_NOAUDIT) == 0)
> +			return true;
> +		fallthrough;
> +	default:
> +		return false;
> +	}
> +}

It is really weird that the function is declared in kallsyms.h
and implemented in vsprintf.c.

What about splitting kallsyms.c into two source files where one
would be always compiled? It would be usable also for the
spring function introduced by
https://lore.kernel.org/r/20220323164742.2984281-1-maninder1.s@samsung.com

It might be something like kallsyms_full.c and/or kallsyms_tiny.c.

Best Regards,
Petr

>  static noinline_for_stack
>  char *restricted_pointer(char *buf, char *end, const void *ptr,
>  			 struct printf_spec spec)
> -- 
> 2.17.1
