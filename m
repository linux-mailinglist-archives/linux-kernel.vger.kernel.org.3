Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B6F48D6EA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 12:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbiAMLuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 06:50:11 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43758 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiAMLuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 06:50:10 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EF6E0218F0;
        Thu, 13 Jan 2022 11:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642074608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=24r93SzAjmsGRtc8iOT17b7/d8HkYubjNVUajwDDyfM=;
        b=XWkkKOuj70ajKM/ENePvjr4SPNtxrS/xmYmrCr5SRBXApVZBmx+5qZjVHo0PmHMU75jN0T
        kJWxqq7e4dxBmWOwt2cRBE+MKM9WHFfKTlf4lwMtdYj6zqjAeR9Mg4xTVE//jb0MLrCq9w
        83S/tt5dbT6KrxR6iokZaoJlNrAwRfY=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 485ABA3B87;
        Thu, 13 Jan 2022 11:50:08 +0000 (UTC)
Date:   Thu, 13 Jan 2022 12:50:06 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kernel@gpiccoli.net, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, feng.tang@intel.com,
        kexec@lists.infradead.org, dyoung@redhat.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Subject: Re: [PATCH V2] panic: Move panic_print before kmsg dumpers
Message-ID: <Yd/0K1x7ILw3Qa46@alley>
References: <20220106212835.119409-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106212835.119409-1-gpiccoli@igalia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-01-06 18:28:35, Guilherme G. Piccoli wrote:
> The panic_print setting allows users to collect more information in a
> panic event, like memory stats, tasks, CPUs backtraces, etc.
> This is a pretty interesting debug mechanism, but currently the print
> event happens *after* kmsg_dump(), meaning that pstore, for example,
> cannot collect a dmesg with the panic_print information.

> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -249,7 +252,7 @@ void panic(const char *fmt, ...)
>  	 * show some extra information on kernel log if it was set...
>  	 */
>  	if (kexec_crash_loaded())
> -		panic_print_sys_info();
> +		panic_print_sys_info(false);

panic_print_sys_info(false) will be called twice when both
kexec_crash_loaded() and _crash_kexec_post_notifiers are true.

Do we really need to call panic_print_sys_info() here? All information
provided by panic_print_sys_info(false) can be found also in
the crash dump.

>  	/*
>  	 * If we have crashed and we have a crash kernel loaded let it handle
> @@ -283,6 +286,8 @@ void panic(const char *fmt, ...)
>  	 */
>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>  
> +	panic_print_sys_info(false);

This is where the info might be printed 2nd time.

> +
>  	kmsg_dump(KMSG_DUMP_PANIC);
>  
>  	/*

Otherwise, the change makes sense to me.

Best Regards,
Petr
