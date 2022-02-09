Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F254AE60B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 01:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240027AbiBIAcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 19:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbiBIAcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 19:32:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64DA2C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 16:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644366738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sB5IseLJBNqjNOsMz7OQ46XvJJFOFs9bsWn3jXjDKHA=;
        b=KLZVHtEKXfeDtRPr27USTZeKUJ7jbnn7hzkdeku1xmYvF1pIHoFGTW9oPGp0m0yXb+KxMK
        CSVPW6EAtqk367NJHnuYwQRFhN6zwpGoIvWpuD/H4WJ5UXVckxSrc0dTcqy2NWcd7AH42Y
        Y8p+I9Cx4TBv4E/1P8gkrtTpSOw7ops=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-SjNaxTdpPPeoX9hYgKnVJg-1; Tue, 08 Feb 2022 19:32:14 -0500
X-MC-Unique: SjNaxTdpPPeoX9hYgKnVJg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CC7E1006AA4;
        Wed,  9 Feb 2022 00:32:11 +0000 (UTC)
Received: from localhost (ovpn-12-114.pek2.redhat.com [10.72.12.114])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 229E162D48;
        Wed,  9 Feb 2022 00:31:53 +0000 (UTC)
Date:   Wed, 9 Feb 2022 08:31:51 +0800
From:   "bhe@redhat.com" <bhe@redhat.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "halves@canonical.com" <halves@canonical.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>, mhiramat@kernel.org,
        d.hatayama@jp.fujitsu.com
Subject: Re: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Message-ID: <YgMLd+avxyBplfk2@MiWiFi-R3L-srv>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <TYAPR01MB6507D06BA6D32218F6E88198955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fda509a5-ea0d-4d1d-a1c1-ca5e80010fc0@igalia.com>
 <TYAPR01MB6507D9747647685B554B8F8F955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fb5e66b6-049a-22ab-5913-a04cc302b629@igalia.com>
 <YfPxvzSzDLjO5ldp@alley>
 <e2d39675-5df6-73fb-fa24-df906a97ee50@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2d39675-5df6-73fb-fa24-df906a97ee50@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/22 at 03:51pm, Guilherme G. Piccoli wrote:
> On 28/01/2022 10:38, Petr Mladek wrote:
> > [...] On Thu 2022-01-27 14:16:20, Guilherme G. Piccoli wrote:
> > First, I am sorry for the very long mail. But the problem is really
> > complicated. I did my best to describe it a clean way.
> > 
> > I have discussed these problems with a colleague and he had some good
> > points. And my view evolved even further.
> 
> Thanks Petr for the very comprehensive and detailed email - this helps a
> lot in shaping the future of panic notifier(s)!
> 
> 
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
> 
> This was exposed very clearly, thanks. I agree with you, it's a good
> approach, and we can evolve that during the implementation phase, like
> "function A is not good in the hypervisor list because of this and
> that", so we move it to the reboot list. Also, name of the lists is not
> so relevant, might evolve in the implementation phase - I personally
> liked them, specially the "info" and "hypervisor" ones (reboot seems
> good but not great heh).
> 
> So, what are the opinions from kdump maintainers about this idea?
> Baoquan / Vivek / Dave, does it make sense to you? Do you have any
> suggestions/concerns to add on top of Petr draft?

Yeah, it's reasonable. As I replied to Michael in another thread, I
think splitting the current notifier list is a good idea. At least the
code to archieve hyper-V's goal with panic_notifier is a little odd and
should be taken out and execute w/o conditional before kdump, and maybe
some others Petr has combed out.

For those which will be switched on with the need of adding panic_notifier
or panic_print into cmdline, the heavy users like HATAYAMA and Masa can
help check.

For Petr's draft code, does it mean hyper-V need another knob to trigger
the needed notifiers? Will you go with the draft direclty? Hyper-V now
runs panic notifiers by default, just a reminder.

> 
> I prefer this refactor than the filter, certainly. If nobody else
> working on that, I can try implementing that - it's very interesting.
> The only thing I'd like to have first is an ACK from the kdump
> maintainers about the general idea.
> 
> Cheers,
> 
> 
> Guilherme
> 

