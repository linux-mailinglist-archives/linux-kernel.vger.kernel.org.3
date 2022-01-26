Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF01D49C300
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 06:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiAZFXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 00:23:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21592 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229691AbiAZFXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 00:23:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643174582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ynnc6+wbtkYwrJ+1sA+Eb18h6IaclkgRD462jbpTKd0=;
        b=iqIZzUjOi8pkKLDBjQS0vSr0ZBTVmcbhNn3ZM6EMQzwvtdgxK7AjpfkdYfEAcZs5H71NJo
        glVh0vrkP6hzhfkPDBBnnFG2b1TN0etinGpsdSUviOoZj7ZBSwSnFzIWe33B/b9d8fOoIO
        eCT1zI1IndGm55valoD0HfEVHQR0mUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-KokxABPsPz-amuS6yQRGXg-1; Wed, 26 Jan 2022 00:22:58 -0500
X-MC-Unique: KokxABPsPz-amuS6yQRGXg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1F14835B47;
        Wed, 26 Jan 2022 05:22:56 +0000 (UTC)
Received: from localhost (ovpn-12-215.pek2.redhat.com [10.72.12.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B5C075ED33;
        Wed, 26 Jan 2022 05:22:52 +0000 (UTC)
Date:   Wed, 26 Jan 2022 13:22:46 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        akpm@linux-foundation.org, anton@enomsg.org, ccross@android.com,
        dyoung@redhat.com, feng.tang@intel.com, john.ogness@linutronix.de,
        keescook@chromium.org, kernel@gpiccoli.net,
        kexec@lists.infradead.org, rostedt@goodmis.org,
        senozhatsky@chromium.org, tony.luck@intel.com, vgoyal@redhat.com
Subject: Re: [PATCH V4] panic: Move panic_print before kmsg dumpers
Message-ID: <20220126052246.GC2086@MiWiFi-R3L-srv>
References: <20220124203101.216051-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124203101.216051-1-gpiccoli@igalia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/24/22 at 05:31pm, Guilherme G. Piccoli wrote:
  			Format: <hex>[,nousertaint]
...snip...

> diff --git a/kernel/panic.c b/kernel/panic.c
> index 41ecf9ab824a..b274e6c241d9 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -148,10 +148,13 @@ void nmi_panic(struct pt_regs *regs, const char *msg)
>  }
>  EXPORT_SYMBOL(nmi_panic);
>  
> -static void panic_print_sys_info(void)
> +static void panic_print_sys_info(bool console_flush)
>  {
> -	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
> -		console_flush_on_panic(CONSOLE_REPLAY_ALL);
> +	if (console_flush) {
> +		if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
> +			console_flush_on_panic(CONSOLE_REPLAY_ALL);
> +		return;
> +	}
>  
>  	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
>  		trigger_all_cpu_backtrace();
> @@ -244,22 +247,20 @@ void panic(const char *fmt, ...)
>  	 */
>  	kgdb_panic(buf);
>  
> -	/*
> -	 * If we have a kdump kernel loaded, give a chance to panic_print
> -	 * show some extra information on kernel log if it was set...
> -	 */
> -	if (kexec_crash_loaded())
> -		panic_print_sys_info();
> -
>  	/*
>  	 * If we have crashed and we have a crash kernel loaded let it handle
> -	 * everything else.
> +	 * everything else. Also, give a chance to panic_print show some extra
> +	 * information on kernel log if it was set...
> +	 *
>  	 * If we want to run this after calling panic_notifiers, pass
>  	 * the "crash_kexec_post_notifiers" option to the kernel.
>  	 *
>  	 * Bypass the panic_cpu check and call __crash_kexec directly.
>  	 */
>  	if (!_crash_kexec_post_notifiers) {
> +		if (kexec_crash_loaded())
> +			panic_print_sys_info(false);
> +

Please reconsider this change. As I said in another thread, it's not
suggested when adding any action before kdump switching and the action
doesn't benefit kdump switching.

We don't oppose execute handling before kdump switching as long as
it's executed conditionally. For those conditional extra handling and
the followoing crash dumping's stability, it's not under kdump's care.

>  		__crash_kexec(NULL);
>  
>  		/*
> @@ -283,6 +284,15 @@ void panic(const char *fmt, ...)
>  	 */
>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>  
> +	/*
> +	 * If a crash kernel is not loaded (or if it's loaded but we still
> +	 * want to allow the panic notifiers), then we dump panic_print after
> +	 * the notifiers - some notifiers disable watchdogs, for example, so
> +	 * we reduce the risk of lockups/hangs or garbled output this way.
> +	 */
> +	if (_crash_kexec_post_notifiers || !kexec_crash_loaded())
> +		panic_print_sys_info(false);
> +
>  	kmsg_dump(KMSG_DUMP_PANIC);
>  
>  	/*
> @@ -313,7 +323,7 @@ void panic(const char *fmt, ...)
>  	debug_locks_off();
>  	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
>  
> -	panic_print_sys_info();
> +	panic_print_sys_info(true);
>  
>  	if (!panic_blink)
>  		panic_blink = no_blink;
> -- 
> 2.34.1
> 

