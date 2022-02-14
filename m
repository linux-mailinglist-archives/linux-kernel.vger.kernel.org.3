Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01E54B451A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242643AbiBNJA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:00:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242583AbiBNJAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:00:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7245A5FF01
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 01:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644829246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n/+OsoDsxo0b/PxBRA4bE6Owdj3/vVxVBoMuGfgphHM=;
        b=GoVAQJMIJvAEVuiy+Bs3EzFoDRXFxMc7kkob570yh3472ENZ1dtJUj8y+ZNcNS4xqk81SO
        AdK4hFD02PqWiL0eOEIsjANInjQoZ/YiefbvLzqV9tpvzDYn/6Wmwdf7AYsvClVEgoLqww
        mSsvvCUPa/FG5FL1Igy46XIrGABwzoM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-tffnmvuEMBilBmHx-AfuTw-1; Mon, 14 Feb 2022 04:00:43 -0500
X-MC-Unique: tffnmvuEMBilBmHx-AfuTw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B02B839A4B;
        Mon, 14 Feb 2022 09:00:41 +0000 (UTC)
Received: from localhost (ovpn-13-68.pek2.redhat.com [10.72.13.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 26E251073030;
        Mon, 14 Feb 2022 09:00:39 +0000 (UTC)
Date:   Mon, 14 Feb 2022 17:00:37 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        akpm@linux-foundation.org, anton@enomsg.org, ccross@android.com,
        dyoung@redhat.com, feng.tang@intel.com, john.ogness@linutronix.de,
        keescook@chromium.org, kernel@gpiccoli.net,
        kexec@lists.infradead.org, rostedt@goodmis.org,
        senozhatsky@chromium.org, tony.luck@intel.com, vgoyal@redhat.com
Subject: Re: [PATCH V5] panic: Move panic_print before kmsg dumpers
Message-ID: <YgoaNTnT9hc6PUjP@MiWiFi-R3L-srv>
References: <20220211215539.822466-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211215539.822466-1-gpiccoli@igalia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/22 at 06:55pm, Guilherme G. Piccoli wrote:
> The panic_print setting allows users to collect more information in a
> panic event, like memory stats, tasks, CPUs backtraces, etc.
> This is an interesting debug mechanism, but currently the print event
> happens *after* kmsg_dump(), meaning that pstore, for example, cannot
> collect a dmesg with the panic_print extra information.
> 
> This patch changes that in 2 ways:
                               ~~~ steps?

Otherwise, the whole looks straightforward, clear, thanks.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> (a) The panic_print setting allows to replay the existing kernel log
> buffer to the console (bit 5), besides the extra information dump.
> This functionality makes sense only at the end of the panic() function.
> So, we hereby allow to distinguish the two situations by a new boolean
> parameter in the function panic_print_sys_info().
> 
> (b) With the above change, we can safely call panic_print_sys_info()
> before kmsg_dump(), allowing to dump the extra information when using
> pstore or other kmsg dumpers.
> 
> The additional messages from panic_print could overwrite the oldest
> messages when the buffer is full. The only reasonable solution is to
> use a large enough log buffer, hence we added an advice into the kernel
> parameters documentation about that.
> 
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
> 
> 
> V5:
> * Rebased against next-20220211.
> * Removed code dealing with kdump, based on Baoquan concerns.
>   This was possible after asking Stephen to remove a patch from
>   linux-next[0] to address Baoquan sugestions, so this version
>   is more simple and doesn't ever panic_print before kdump, unless
>   "crash_kexec_post_notifiers" is passed in the kernel cmdline.
> 
> [0] https://lore.kernel.org/lkml/c10fc4fc-58c9-0b3f-5f1e-6f44b0c190d2@igalia.com/
> 
> V4: https://lore.kernel.org/lkml/20220124203101.216051-1-gpiccoli@igalia.com/
> 
> 
>  Documentation/admin-guide/kernel-parameters.txt |  4 ++++
>  kernel/panic.c                                  | 13 +++++++++----
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 3c2b3e24e8f5..2cf7078eaa95 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3766,6 +3766,10 @@
>  			bit 4: print ftrace buffer
>  			bit 5: print all printk messages in buffer
>  			bit 6: print all CPUs backtrace (if available in the arch)
> +			*Be aware* that this option may print a _lot_ of lines,
> +			so there are risks of losing older messages in the log.
> +			Use this option carefully, maybe worth to setup a
> +			bigger log buffer with "log_buf_len" along with this.
>  
>  	panic_on_taint=	Bitmask for conditionally calling panic() in add_taint()
>  			Format: <hex>[,nousertaint]
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 3c3fb36d8d41..eb4dfb932c85 100644
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
> @@ -286,6 +289,8 @@ void panic(const char *fmt, ...)
>  	 */
>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>  
> +	panic_print_sys_info(false);
> +
>  	kmsg_dump(KMSG_DUMP_PANIC);
>  
>  	/*
> @@ -316,7 +321,7 @@ void panic(const char *fmt, ...)
>  	debug_locks_off();
>  	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
>  
> -	panic_print_sys_info();
> +	panic_print_sys_info(true);
>  
>  	if (!panic_blink)
>  		panic_blink = no_blink;
> -- 
> 2.35.0
> 

