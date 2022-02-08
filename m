Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6314AE182
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238395AbiBHSvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385407AbiBHSvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:51:45 -0500
X-Greylist: delayed 2346 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 10:51:44 PST
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B84C0612C0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dAI4MRpXSkWD+3j3FS9v2m1/GR1G+MWPYwH2BqIc/V8=; b=acpIbYGaXGG1lU27jLdiD4AuIh
        0ZnQ9t2EsSsZML9WQnth1+hU9k1SQN1EeLqwJ/p67VbyNeVqXbS4h3kSXUhuvV9MLfEE9qGeHmIqb
        pk57xjXYarfFzRSJO5mdyIYTwI+3fs+KIjpTCCCzoBVTeI+wwXCpUb9d98U31jvicpCoWdLFmIjFz
        WJTUYewJSL/xFLusqLPgMX2BBKejiTt6Qz21OeYAYLK8FrzkvA9POkkXNe9eqUE3kzgfIC4w6Rwe5
        GWkCOXTpFUiu9IbhSs5lO94GWJfnwwAb5XpVQ3AqYTwyloGvZeqUn6xzXe6sem2zcqa2LWr+vbd/7
        pKiAnJ0A==;
Received: from 201-27-34-10.dsl.telesp.net.br ([201.27.34.10] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nHVaM-00010h-88; Tue, 08 Feb 2022 19:51:30 +0100
Message-ID: <e2d39675-5df6-73fb-fa24-df906a97ee50@igalia.com>
Date:   Tue, 8 Feb 2022 15:51:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>, "bhe@redhat.com" <bhe@redhat.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>
Cc:     "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
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
> [...] On Thu 2022-01-27 14:16:20, Guilherme G. Piccoli wrote:
> First, I am sorry for the very long mail. But the problem is really
> complicated. I did my best to describe it a clean way.
> 
> I have discussed these problems with a colleague and he had some good
> points. And my view evolved even further.

Thanks Petr for the very comprehensive and detailed email - this helps a
lot in shaping the future of panic notifier(s)!


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

This was exposed very clearly, thanks. I agree with you, it's a good
approach, and we can evolve that during the implementation phase, like
"function A is not good in the hypervisor list because of this and
that", so we move it to the reboot list. Also, name of the lists is not
so relevant, might evolve in the implementation phase - I personally
liked them, specially the "info" and "hypervisor" ones (reboot seems
good but not great heh).

So, what are the opinions from kdump maintainers about this idea?
Baoquan / Vivek / Dave, does it make sense to you? Do you have any
suggestions/concerns to add on top of Petr draft?

I prefer this refactor than the filter, certainly. If nobody else
working on that, I can try implementing that - it's very interesting.
The only thing I'd like to have first is an ACK from the kdump
maintainers about the general idea.

Cheers,


Guilherme
