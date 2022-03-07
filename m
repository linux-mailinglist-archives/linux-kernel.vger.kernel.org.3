Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A150F4D00AA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242986AbiCGOFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiCGOFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:05:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5DCD5AECE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646661897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+/lGec4dDaa2PRCmRBpnfAUw2RsLSGmneKuOWF+Jy7s=;
        b=Wq4UVYcYFUmouqf3RNaoTlP4H5MnlXm/EU+99YyWODt1gWNGns7OG16ph3HHAIHqz6Iagh
        Lw4UlMXaal1A6JLdDiNG6sWxyzBkM77f+Z3aYow5XdvqZRRuNTtO1vZFm5FD4ptRK9Jht2
        eDaL5WgH4CCbR95s68jaS1aoxXRfMsA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-T9rlbQuhOnSjEboWkQd7lQ-1; Mon, 07 Mar 2022 09:04:53 -0500
X-MC-Unique: T9rlbQuhOnSjEboWkQd7lQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E6A3801DDB;
        Mon,  7 Mar 2022 14:04:51 +0000 (UTC)
Received: from localhost (ovpn-13-211.pek2.redhat.com [10.72.13.211])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FF417A542;
        Mon,  7 Mar 2022 14:04:49 +0000 (UTC)
Date:   Mon, 7 Mar 2022 22:04:47 +0800
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
Message-ID: <YiYQ/w6Hn5Zb67di@MiWiFi-R3L-srv>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <TYAPR01MB6507D06BA6D32218F6E88198955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fda509a5-ea0d-4d1d-a1c1-ca5e80010fc0@igalia.com>
 <TYAPR01MB6507D9747647685B554B8F8F955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fb5e66b6-049a-22ab-5913-a04cc302b629@igalia.com>
 <YfPxvzSzDLjO5ldp@alley>
 <73011b6f-084b-43f5-cc01-1818a8a57e56@igalia.com>
 <YiV/HbXftVF2iAvU@MiWiFi-R3L-srv>
 <e1033adc-46ff-5dbc-e739-1bf725b6fed0@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1033adc-46ff-5dbc-e739-1bf725b6fed0@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/22 at 10:11am, Guilherme G. Piccoli wrote:
> On 07/03/2022 00:42, bhe@redhat.com wrote:
> > [...]
> >> Let me know your thoughts Petr / Baoquan - it would add slightly more
> >> code / complexity, but in my opinion the payback is very good.
> >> Cheers,
> > 
> > The ideal situation is each panic notifier has an order or index to
> > indicate its priority. Wondering how to make it. What I think of is
> > copying initcall. We have several priorities, at the same priority,
> > execution sequence is not important. Not sure if I get your point.
> > 
> > ~~~~~~~
> > #define core_initcall(fn)               __define_initcall(fn, 1)
> > #define core_initcall_sync(fn)          __define_initcall(fn, 1s)
> > ......
> > #define late_initcall(fn)               __define_initcall(fn, 7)
> > #define late_initcall_sync(fn)          __define_initcall(fn, 7s)
> > 
> 
> Hi Baoquan, thanks for you consideration! In fact, the notifiers
> infrastructure already have a mechanism of ordering, my idea is to make
> use of that. It's not that different from the initcall system...

Ah, sorry, I even didn't notice that. That's awesome if we can make use
of that. While I still have concerns:

1) about those we have decided to take out from panic notifier list and
put before kdump, e.g the Hypver-V notifier, how will we do with it? Are
we going to handle them as we have discussed?

2) Combing and settling priority for all existing panic notifier looks
great, even though it will take some effort. How about the later newly
added one? How can we guarantee that those new notifiers are getting
appropriate priority to mark their order? Sometime we even don't know
a new panic notifier is added since code change may be made in any
component or driver.

> 
> For instance, the code in the notifier register function checks for the
> priority field in the notifier block:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/notifier.c#n31
> .
> 
> For example, the Xen panic notifier is one of the few blocks that make
> use of that, currently:
> 
> static struct notifier_block xen_panic_block = {
> 	.notifier_call = xen_panic_event,
> 	.priority = INT_MIN
> };
> 
> (see
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/xen/enlighten.c#n286)
> 
> In this case, xen_panic_event() will be the latest one to run. My idea
> is to make use of that in *all* panic notifiers, having a table/list on
> panic_notifier.h (defines or enum, I'll think about that when writing
> this part) so all notifiers are documented and the ordering is clear and
> enforced.
> 
> Makes sense to you?
> Cheers,
> 
> 
> Guilherme
> 

