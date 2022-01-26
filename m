Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1059749CAA0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238674AbiAZNUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:20:17 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45488 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238596AbiAZNUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:20:16 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D37AD1F397;
        Wed, 26 Jan 2022 13:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643203214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oJL4Adj+H6C1XkGFJGLoj0TBC596419DIcULA/qs6RA=;
        b=c7g4DAAdYkWL4aUuiDJ1skfsjqgtSvGuAgQKrVZkC/XsKu8yV9BMFqQG4Rf7B8jKSv2Wgf
        IbG/yTrhYYLTmO64rTBxrkFfNz1YLywAptmVUOIcsCpUKN813hD/SxAJD4wrOvBaVagtDm
        1CbK0CfmDIt5+Nnjx35Dqrjc+woFIuo=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 23D67A3B83;
        Wed, 26 Jan 2022 13:20:14 +0000 (UTC)
Date:   Wed, 26 Jan 2022 14:20:10 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        dyoung@redhat.com, linux-doc@vger.kernel.org, vgoyal@redhat.com,
        stern@rowland.harvard.edu, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
        halves@canonical.com, kernel@gpiccoli.net,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, mikelley@microsoft.com
Subject: Re: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Message-ID: <YfFKiscTVckEy2E8@alley>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <Yel8WQiBn/HNQN83@alley>
 <ccd9332e-2917-3020-3590-447fa660ff56@igalia.com>
 <20220122105514.GA18258@MiWiFi-R3L-srv>
 <20220123220711.44f1484c9b510eea8cda9c47@kernel.org>
 <20220124135902.GB8305@MiWiFi-R3L-srv>
 <ff3bc2cf-80bf-3bb0-0dcd-7f9cacdae45a@igalia.com>
 <20220126031039.GA26064@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126031039.GA26064@MiWiFi-R3L-srv>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-01-26 11:10:39, Baoquan He wrote:
> On 01/24/22 at 11:48am, Guilherme G. Piccoli wrote:
> > On 24/01/2022 10:59, Baoquan He wrote:
> > > [...]
> > > About pre_dump, if the dump is crash dump, hope those pre_dump notifiers
> > > will be executed under conditional check, e.g only if 'crash_kexec_post_notifiers'
> > > is specified in kernel cmdline. 
> > 
> > Hi Baoquan, based on Petr's suggestion, I think pre_dump would be
> > responsible for really *non-intrusive/non-risky* tasks and should be
> > always executed in the panic path (before kdump), regardless of
> > "crash_kexec_post_notifiers".
> > 
> > The idea is that the majority of the notifiers would be executed in the
> > post_dump portion, and for that, we have the
> > "crash_kexec_post_notifiers" conditional. I also suggest we have
> > blacklist options (based on function names) for both notifiers, in order
> > to make kdump issues debug easier.
> > 
> > Do you agree with that? Feel free to comment with suggestions!
> > Cheers,
> 
> I would say "please NO" cautiously.
> 
> As Petr said, kdump mostly works only if people configure it correctly.
> That's because we try best to switch to kdump kernel from the fragile
> panicked kernel immediately. When we try to add anthing before the switching,
> please consider carefully and ask if that adding is mandatory, otherwise
> switching into kdump kernel may fail. If the answer is yes, the adding
> is needed and welcomed. Othewise, any unnecessary action, including any
> "non-intrusive/non-risky" tasks, would be unwelcomed.

I still do not have the complete picture. But it seems that some
actions make always sense even for kdump:

    + Super safe operations that might disable churn from broken
      system. For examle, disabling watchdogs by setting a single
      variable, see rcu_panic() notifier

    + Actions needed that allow to kexec the crash kernel a safe
      way under some hypervisor, see
      https://lore.kernel.org/r/MWHPR21MB15933573F5C81C5250BF6A1CD75E9@MWHPR21MB1593.namprd21.prod.outlook.com


> Surely, we don't oppose the "non-intrusive/non-risky" or completely
> "intrusive/risky" action adding before kdump kernel switching, with a
> conditional limitation. When we handle customers' kdump support, we
> explicitly declare we only support normal and default kdump operation.
> If any action which is done before switching into kdump kernel is specified,
> e.g panic_notifier, panic_print, they need take care of their own kdump
> failure.

All this actually started because of kmsg_dump. It might make sense to
allow both kmsg_dump and kdump together. The messages stored by
kmsg_dump might be better than nothing when kdump fails.

It actually seems to be the main motivation to introduce
"crash_kexec_post_notifier" parameter, see the commit
f06e5153f4ae2e2f3b03 ("kernel/panic.c: add "crash_kexec_post_notifiers"
option for kdump after panic_notifers").

And this patch introduces panic_notifier_filter that tries to select
notifiers that are helpful and harmful. IMHO, it is almost unusable.
It seems that even kernel developers do not understand what exactly
some notifiers do and why they are needed. Usually only the author
and people familiar with the subsystem have some idea. It makes
it pretty hard for anyone to create a reasonable filter.

I am pretty sure that we could do better. I propose to add more
notifier lists that will be called at various places with reasonable
rules and restrictions. Then the susbsystem maintainers could decide
where exactly a given action must be done.

The result might be that we will need only few options that will
enable/disable some well defined optional features.

Best Regards,
Petr
