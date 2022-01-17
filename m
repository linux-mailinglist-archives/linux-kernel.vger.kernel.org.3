Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFECB4901DA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 07:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbiAQGNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 01:13:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234488AbiAQGNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 01:13:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642400020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NSS9jCqxWe9PQ1SFQP2RfmQ8vcdsr8YrRTm6MdK+Wfc=;
        b=ZCFyo+GOS2rUt5D1kQuX3/8Sb+KZ40OcYErDT14wFijPv0e0BHTXrJHqNcHs0qPHJItwo3
        1X+ppVaiRVlBkkHhYtGKo3bmOlGbgrAueeNwoHR0TrQmJFVCjuC+Y/1benAYXPiIHiJTVS
        rmsj/kdeKjwpeBuBb6iC+DJbBNut0j8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-F7qMs-TZNimCv3FXP4zbfg-1; Mon, 17 Jan 2022 01:13:36 -0500
X-MC-Unique: F7qMs-TZNimCv3FXP4zbfg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 713F3835B4B;
        Mon, 17 Jan 2022 06:13:34 +0000 (UTC)
Received: from localhost (ovpn-12-67.pek2.redhat.com [10.72.12.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AC39F5DB9E;
        Mon, 17 Jan 2022 06:13:17 +0000 (UTC)
Date:   Mon, 17 Jan 2022 14:13:15 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        pmladek@suse.com, kernel@gpiccoli.net, senozhatsky@chromium.org,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        feng.tang@intel.com, kexec@lists.infradead.org, dyoung@redhat.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Subject: Re: [PATCH V3] panic: Move panic_print before kmsg dumpers
Message-ID: <20220117061315.GF2388@MiWiFi-R3L-srv>
References: <20220114183046.428796-1-gpiccoli@igalia.com>
 <20220117033344.GA2523@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117033344.GA2523@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/17/22 at 11:33am, Baoquan He wrote:
> On 01/14/22 at 03:30pm, Guilherme G. Piccoli wrote:
> ...... 
> >  .../admin-guide/kernel-parameters.txt         |  4 ++++
> >  kernel/panic.c                                | 22 ++++++++++++++-----
> >  2 files changed, 21 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index a069d8fe2fee..0f5cbe141bfd 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3727,6 +3727,10 @@
> >  			bit 4: print ftrace buffer
> >  			bit 5: print all printk messages in buffer
> >  			bit 6: print all CPUs backtrace (if available in the arch)
> > +			*Be aware* that this option may print a _lot_ of lines,
> > +			so there are risks of losing older messages in the log.
> > +			Use this option carefully, maybe worth to setup a
> > +			bigger log buffer with "log_buf_len" along with this.
> >  
> >  	panic_on_taint=	Bitmask for conditionally calling panic() in add_taint()
> >  			Format: <hex>[,nousertaint]
> > diff --git a/kernel/panic.c b/kernel/panic.c
> > index 41ecf9ab824a..4ae712665f75 100644
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -148,10 +148,13 @@ void nmi_panic(struct pt_regs *regs, const char *msg)
> >  }
> >  EXPORT_SYMBOL(nmi_panic);
> >  
> > -static void panic_print_sys_info(void)
> > +static void panic_print_sys_info(bool after_kmsg_dumpers)
> >  {
> > -	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
> > -		console_flush_on_panic(CONSOLE_REPLAY_ALL);
> > +	if (after_kmsg_dumpers) {
> > +		if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
> > +			console_flush_on_panic(CONSOLE_REPLAY_ALL);
> > +		return;
> > +	}
> >  
> >  	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
> >  		trigger_all_cpu_backtrace();
> > @@ -249,7 +252,7 @@ void panic(const char *fmt, ...)
> >  	 * show some extra information on kernel log if it was set...
> >  	 */
> >  	if (kexec_crash_loaded())
> > -		panic_print_sys_info();
> > +		panic_print_sys_info(false);
> 
> Patch can'e be applied on the latest code of linus's tree, can you tell
> which branch your code are based on?

OK, this is based on linux-next, I will apply this patch on the
linux-next/master and have a look.

> 
> >  
> >  	/*
> >  	 * If we have crashed and we have a crash kernel loaded let it handle
> > @@ -283,6 +286,15 @@ void panic(const char *fmt, ...)
> >  	 */
> >  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> >  
> > +	/*
> > +	 * If kexec_crash_loaded() is true and we still reach this point,
> > +	 * kernel would double print the information from panic_print; so
> > +	 * let's guard against that possibility (it happens if kdump users
> > +	 * also set crash_kexec_post_notifiers in the command-line).
> > +	 */
> > +	if (!kexec_crash_loaded())
> > +		panic_print_sys_info(false);
> > +
> >  	kmsg_dump(KMSG_DUMP_PANIC);
> >  
> >  	/*
> > @@ -313,7 +325,7 @@ void panic(const char *fmt, ...)
> >  	debug_locks_off();
> >  	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> >  
> > -	panic_print_sys_info();
> > +	panic_print_sys_info(true);
> >  
> >  	if (!panic_blink)
> >  		panic_blink = no_blink;
> > -- 
> > 2.34.1
> > 
> 

