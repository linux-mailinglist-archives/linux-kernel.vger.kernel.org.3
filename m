Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD254D1864
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241487AbiCHM4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241323AbiCHM4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:56:00 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95F0473B5;
        Tue,  8 Mar 2022 04:55:03 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 778B0210F4;
        Tue,  8 Mar 2022 12:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646744102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0jKnX/F50qztDlLwiFAY7FdUc++7GIssZthEmQQhqQc=;
        b=FuN4gT5N/Pwo0tqX2b9D4WbQu/FlWUaPaJ5FxWcm2mOTa+atw1FpvKmYiTRqF13exeHmTE
        C5+LNcqzbqcbiJMVO77ZcS4mItaWd/ueViUK/RTn5qITzTDWD9RorGPM/aYkx7QmkeDpYG
        xyCEsoOUAKEnqUVLpMXvpzjQdxF9YLw=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 159A6A3B85;
        Tue,  8 Mar 2022 12:55:02 +0000 (UTC)
Date:   Tue, 8 Mar 2022 13:54:59 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     "bhe@redhat.com" <bhe@redhat.com>,
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
Message-ID: <YidSI33Uk8wHDuO9@alley>
References: <TYAPR01MB6507D06BA6D32218F6E88198955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fda509a5-ea0d-4d1d-a1c1-ca5e80010fc0@igalia.com>
 <TYAPR01MB6507D9747647685B554B8F8F955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fb5e66b6-049a-22ab-5913-a04cc302b629@igalia.com>
 <YfPxvzSzDLjO5ldp@alley>
 <73011b6f-084b-43f5-cc01-1818a8a57e56@igalia.com>
 <YiV/HbXftVF2iAvU@MiWiFi-R3L-srv>
 <e1033adc-46ff-5dbc-e739-1bf725b6fed0@igalia.com>
 <YiYQ/w6Hn5Zb67di@MiWiFi-R3L-srv>
 <788ab36d-ef65-4cc8-4edf-a46d2687d97e@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <788ab36d-ef65-4cc8-4edf-a46d2687d97e@igalia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-03-07 11:25:30, Guilherme G. Piccoli wrote:
> On 07/03/2022 11:04, bhe@redhat.com wrote:
> > [...]
> > Ah, sorry, I even didn't notice that. That's awesome if we can make use
> > of that. While I still have concerns:
> > 
> 
> Thanks, nice that you liked the idea.
> 
> > 1) about those we have decided to take out from panic notifier list and
> > put before kdump, e.g the Hypver-V notifier, how will we do with it? Are
> > we going to handle them as we have discussed?
> > 
> 
> While implementing that I will think of something, but if
> understood/remember correctly Hyper-V gonna be one of the first to run
> in the first notifier list proposed by Petr - so we might still use
> ordering by priority there, having Hyper-V being the first heh

My understanding is that the problem is not a priority but an ordering
against other operations.

Namely, Hyper-V must be called even before crash dump. Some others before
kmsg_dump(). And the rest only when the crash dump is not called at all.


> > 2) Combing and settling priority for all existing panic notifier looks
> > great, even though it will take some effort. How about the later newly
> > added one? How can we guarantee that those new notifiers are getting
> > appropriate priority to mark their order? Sometime we even don't know
> > a new panic notifier is added since code change may be made in any
> > component or driver.
> > 
> 
> This is a great point! How to do it? One idea is to have a special
> registering function for panic notifiers that checks for priority field
> missing, and good documentation is a good idea as well, always.
> 
> But if you / others have other suggestions, let me know - appreciate that.
> Cheers,

Honestly, I am not that keen about enforcing the priorities.

It would make sense only when the ordering is really important.
Then there should be some rules. It should be obvious why
something has to be done earlier than something else.

From my POV, it is just another complexity. Someone will need to
assign the priority to the existing notifiers. People will wonder
about it for newly added notifiers.

Reproducibility seems to be the only motivation. Is it really a
problem? Do the notifiers affect each other?

Also the notifiers are typically registered by some early boot
code. It will define some ordering out of box.

Best Regards,
Petr
