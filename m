Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0935B4CF080
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 04:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiCGDnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 22:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbiCGDni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 22:43:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B17E2DA83
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 19:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646624563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wbQwy5zQ24ii7T84VoJRgoRtZjyaWfJ4MGDMUq3pW3I=;
        b=VbO7F9SY7wLdpcSepyQUHt2IA7vsd/xgWYeFp4KVwxUcZluluT81B11aENtorwBnh41RP8
        +jyw/ytXLj3QDod3MJaR1QvBcNFb8rAHlFqZCKT2bBzjZlwB+IfgeIJ6hgaQ1lPXmR6uVU
        WmunmaIL0imosAY/p0pBBP1INr6dAZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-4_yJTt5sMHGW0KKsiBI7TQ-1; Sun, 06 Mar 2022 22:42:39 -0500
X-MC-Unique: 4_yJTt5sMHGW0KKsiBI7TQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A2C18145F6;
        Mon,  7 Mar 2022 03:42:37 +0000 (UTC)
Received: from localhost (ovpn-13-211.pek2.redhat.com [10.72.13.211])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 257DC4CEE7;
        Mon,  7 Mar 2022 03:42:24 +0000 (UTC)
Date:   Mon, 7 Mar 2022 11:42:21 +0800
From:   "bhe@redhat.com" <bhe@redhat.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "halves@canonical.com" <halves@canonical.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>
Subject: Re: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Message-ID: <YiV/HbXftVF2iAvU@MiWiFi-R3L-srv>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <TYAPR01MB6507D06BA6D32218F6E88198955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fda509a5-ea0d-4d1d-a1c1-ca5e80010fc0@igalia.com>
 <TYAPR01MB6507D9747647685B554B8F8F955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fb5e66b6-049a-22ab-5913-a04cc302b629@igalia.com>
 <YfPxvzSzDLjO5ldp@alley>
 <73011b6f-084b-43f5-cc01-1818a8a57e56@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73011b6f-084b-43f5-cc01-1818a8a57e56@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/22 at 11:21am, Guilherme G. Piccoli wrote:
> On 28/01/2022 10:38, Petr Mladek wrote:
> > [...] 
> > I think about the following solution:
> > 
> >     + split the notifiers into three lists:
> > 
> > 	+ info: stop watchdogs, provide extra info
> > 	+ hypervisor: poke hypervisor
> > 	+ reboot: actions needed only when crash dump did not happen
> > 
> >     + allow to call hypervisor notifiers before or after kdump
> > 
> >     + stop CPUs before kdump when either hypervisor notifiers or
> >       kmsg_dump is enabled
> > 
> > Note that it still allows to call kdump as the first action when
> > hypervisor notifiers are called after kdump and no kmsg dumper
> > is registered.
> > 
> > 
> > void panic(void)
> > {
> > 	[...]
> > 
> > 	if (crash_kexec_post_hypervisor || panic_print || enabled_kmsg_dump()) {
> > 		/*
> > 		 * Stop CPUs when some extra action is required before
> > 		 * crash dump. We will need architecture dependent extra
> > 		 * works in addition to stopping other CPUs.
> > 		 */
> > 		 crash_smp_send_stop();
> > 		 cpus_stopped = true;
> > 	}
> > 
> > 	if (crash_kexec_post_hypervisor) {
> > 		  /* Tell hypervisor about the panic */
> > 		  atomic_notifier_call_chain(&panic_hypervisor_notifier_list, 0, buf);
> > 	}
> > 
> > 	if (enabled_kmsg_dump) {
> > 		  /*
> > 		   * Print extra info by notifiers.
> > 		   * Prevent rumors, for example, by stopping watchdogs.
> > 		   */
> > 		  atomic_notifier_call_chain(&panic_info_notifier_list, 0, buf);
> > 	}
> > 
> > 	/* Optional extra info */
> > 	panic_printk_sys_info();
> > 
> > 	/* No dumper by default */
> > 	kmsg_dump();
> > 
> > 	/* Used only when crash kernel loaded */
> > 	__crash_kexec(NULL);
> > 
> > 	if (!cpus_stopped) {
> > 		/*
> > 		 * Note smp_send_stop is the usual smp shutdown function, which
> > 		 * unfortunately means it may not be hardened to work in a
> > 		 * panic situation.
> > 		 */
> > 		smp_send_stop();
> > 	}
> > 
> > 	if (!crash_kexec_post_hypervisor) {
> > 		  /* Tell hypervisor about the panic */
> > 		  atomic_notifier_call_chain(&panic_hypervisor_notifier_list, 0, buf);
> > 	}
> > 
> > 	if (!enabled_kmsg_dump) {
> > 		  /*
> > 		   * Print extra info by notifiers.
> > 		   * Prevent rumors, for example, by stopping watchdogs.
> > 		   */
> > 		  atomic_notifier_call_chain(&panic_info_notifier_list, 0, buf);
> > 	}
> > 
> > 	/*
> > 	 * Help to reboot a safe way.
> > 	 */
> > 	atomic_notifier_call_chain(&panic_reboot_notifier_list, 0, buf);
> > 
> > 	[...]
> > }
> > 
> > Any opinion?
> > Do the notifier list names make sense?
> > 
> > Best Regards,
> > Petr
> 
> 
> Hi folks, I'm working on this now, and while looking into it I've
> noticed that we have the concept of "priority" in the notifiers list.
> Basically, you can order the calls the way it fits best, priority is an
> integer and must the set in the moment of registration, it's up to the
> users of the notifiers to set it and enforce the ordering.
> 
> So what I'm thinking is: currently, only 3 or 4 panic notifiers make use
> of that. What if, since we're re-working this, we add a priority for
> *all* notifiers and enforce its usage? This way we guarantee
> consistency, it'd make debug easier and maybe even more important:
> having all the notifiers and their priorities in a list present in the
> header file would be great documentation about all the existing
> notifiers and how they are called - today this information is quite
> obscure and requires lots of code grepping!
> 
> Let me know your thoughts Petr / Baoquan - it would add slightly more
> code / complexity, but in my opinion the payback is very good.
> Cheers,

The ideal situation is each panic notifier has an order or index to
indicate its priority. Wondering how to make it. What I think of is
copying initcall. We have several priorities, at the same priority,
execution sequence is not important. Not sure if I get your point.

~~~~~~~
#define core_initcall(fn)               __define_initcall(fn, 1)
#define core_initcall_sync(fn)          __define_initcall(fn, 1s)
......
#define late_initcall(fn)               __define_initcall(fn, 7)
#define late_initcall_sync(fn)          __define_initcall(fn, 7s)

