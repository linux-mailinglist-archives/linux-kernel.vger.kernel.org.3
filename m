Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD874CEBE0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 15:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiCFOWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 09:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiCFOWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 09:22:53 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9713F897;
        Sun,  6 Mar 2022 06:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Py4p6iS6EYZuvEmVNp0u2Xszje9rqH2a0r3dEaBrDKY=; b=I6z8nkqYupJIL9fdF/+cj5VkWW
        rGpMh4385K6I/UX+qNroLSy0xlWald17f4KzPRGlCHLwj8UD55D0UA/l4jynz3vyPVHfIBdSyxBIi
        a+OykIHn1wD7VEcSLzjFn7TqgdDVRN7FpHuol+hOrKgbuDYy/AvOCFYcUAGvA3wIik9w3D4TDSTHm
        nXaO3uCHQg/84Rw2TDleypxOZr/T6md2HPilZNYKPEi+srOfujw5LcTMHcd8QWu66+9szF8857SeE
        404i9i5L9WcGwZo9kVLxkzUwcGIsPpw3ziNg5sgEG2WiJ4U5w4n+d96QkeCG7fdxwjePmMUzV6EUW
        AbOd8Wqg==;
Received: from [187.56.66.217] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nQrlZ-0004v2-94; Sun, 06 Mar 2022 15:21:45 +0100
Message-ID: <73011b6f-084b-43f5-cc01-1818a8a57e56@igalia.com>
Date:   Sun, 6 Mar 2022 11:21:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>, "bhe@redhat.com" <bhe@redhat.com>
Cc:     "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>,
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
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <TYAPR01MB6507D06BA6D32218F6E88198955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fda509a5-ea0d-4d1d-a1c1-ca5e80010fc0@igalia.com>
 <TYAPR01MB6507D9747647685B554B8F8F955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fb5e66b6-049a-22ab-5913-a04cc302b629@igalia.com> <YfPxvzSzDLjO5ldp@alley>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YfPxvzSzDLjO5ldp@alley>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2022 10:38, Petr Mladek wrote:
> [...] 
> I think about the following solution:
> 
>     + split the notifiers into three lists:
> 
> 	+ info: stop watchdogs, provide extra info
> 	+ hypervisor: poke hypervisor
> 	+ reboot: actions needed only when crash dump did not happen
> 
>     + allow to call hypervisor notifiers before or after kdump
> 
>     + stop CPUs before kdump when either hypervisor notifiers or
>       kmsg_dump is enabled
> 
> Note that it still allows to call kdump as the first action when
> hypervisor notifiers are called after kdump and no kmsg dumper
> is registered.
> 
> 
> void panic(void)
> {
> 	[...]
> 
> 	if (crash_kexec_post_hypervisor || panic_print || enabled_kmsg_dump()) {
> 		/*
> 		 * Stop CPUs when some extra action is required before
> 		 * crash dump. We will need architecture dependent extra
> 		 * works in addition to stopping other CPUs.
> 		 */
> 		 crash_smp_send_stop();
> 		 cpus_stopped = true;
> 	}
> 
> 	if (crash_kexec_post_hypervisor) {
> 		  /* Tell hypervisor about the panic */
> 		  atomic_notifier_call_chain(&panic_hypervisor_notifier_list, 0, buf);
> 	}
> 
> 	if (enabled_kmsg_dump) {
> 		  /*
> 		   * Print extra info by notifiers.
> 		   * Prevent rumors, for example, by stopping watchdogs.
> 		   */
> 		  atomic_notifier_call_chain(&panic_info_notifier_list, 0, buf);
> 	}
> 
> 	/* Optional extra info */
> 	panic_printk_sys_info();
> 
> 	/* No dumper by default */
> 	kmsg_dump();
> 
> 	/* Used only when crash kernel loaded */
> 	__crash_kexec(NULL);
> 
> 	if (!cpus_stopped) {
> 		/*
> 		 * Note smp_send_stop is the usual smp shutdown function, which
> 		 * unfortunately means it may not be hardened to work in a
> 		 * panic situation.
> 		 */
> 		smp_send_stop();
> 	}
> 
> 	if (!crash_kexec_post_hypervisor) {
> 		  /* Tell hypervisor about the panic */
> 		  atomic_notifier_call_chain(&panic_hypervisor_notifier_list, 0, buf);
> 	}
> 
> 	if (!enabled_kmsg_dump) {
> 		  /*
> 		   * Print extra info by notifiers.
> 		   * Prevent rumors, for example, by stopping watchdogs.
> 		   */
> 		  atomic_notifier_call_chain(&panic_info_notifier_list, 0, buf);
> 	}
> 
> 	/*
> 	 * Help to reboot a safe way.
> 	 */
> 	atomic_notifier_call_chain(&panic_reboot_notifier_list, 0, buf);
> 
> 	[...]
> }
> 
> Any opinion?
> Do the notifier list names make sense?
> 
> Best Regards,
> Petr


Hi folks, I'm working on this now, and while looking into it I've
noticed that we have the concept of "priority" in the notifiers list.
Basically, you can order the calls the way it fits best, priority is an
integer and must the set in the moment of registration, it's up to the
users of the notifiers to set it and enforce the ordering.

So what I'm thinking is: currently, only 3 or 4 panic notifiers make use
of that. What if, since we're re-working this, we add a priority for
*all* notifiers and enforce its usage? This way we guarantee
consistency, it'd make debug easier and maybe even more important:
having all the notifiers and their priorities in a list present in the
header file would be great documentation about all the existing
notifiers and how they are called - today this information is quite
obscure and requires lots of code grepping!

Let me know your thoughts Petr / Baoquan - it would add slightly more
code / complexity, but in my opinion the payback is very good.
Cheers,


Guilherme
