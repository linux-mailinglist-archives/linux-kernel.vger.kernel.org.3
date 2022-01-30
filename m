Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896534A353C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 09:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354377AbiA3IvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 03:51:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20575 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236235AbiA3Iu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 03:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643532658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HCXMYXvKDjBzFRFAFcJyGybTMYraghi7evnbgQc/nHI=;
        b=fxwKLQXl7w+5ZFDUFGPA0aO3y7IY41nhawyR47KVFOtPfryeAC73uTN438mk8AkiGgEr5/
        Sd6q8LkURevdlrkWb+iJB7vFfL/UgpmLThNXQoAhTYlKY5gr7AunL1OW6jvMBONzVYQj0y
        tBMzKS4aOSjtPbgj5ibZW9L0mB8Ffaw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-381-aEH1SB3jOdiDX9buAhxxJw-1; Sun, 30 Jan 2022 03:50:54 -0500
X-MC-Unique: aEH1SB3jOdiDX9buAhxxJw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D53361006AA4;
        Sun, 30 Jan 2022 08:50:49 +0000 (UTC)
Received: from localhost (ovpn-12-238.pek2.redhat.com [10.72.12.238])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C56A60C2F;
        Sun, 30 Jan 2022 08:50:40 +0000 (UTC)
Date:   Sun, 30 Jan 2022 16:50:38 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
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
Message-ID: <20220130085038.GC29425@MiWiFi-R3L-srv>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <Yel8WQiBn/HNQN83@alley>
 <ccd9332e-2917-3020-3590-447fa660ff56@igalia.com>
 <20220122105514.GA18258@MiWiFi-R3L-srv>
 <20220123220711.44f1484c9b510eea8cda9c47@kernel.org>
 <20220124135902.GB8305@MiWiFi-R3L-srv>
 <ff3bc2cf-80bf-3bb0-0dcd-7f9cacdae45a@igalia.com>
 <20220126031039.GA26064@MiWiFi-R3L-srv>
 <YfFKiscTVckEy2E8@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfFKiscTVckEy2E8@alley>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/26/22 at 02:20pm, Petr Mladek wrote:
> On Wed 2022-01-26 11:10:39, Baoquan He wrote:
> > On 01/24/22 at 11:48am, Guilherme G. Piccoli wrote:
> > > On 24/01/2022 10:59, Baoquan He wrote:
> > > > [...]
> > > > About pre_dump, if the dump is crash dump, hope those pre_dump notifiers
> > > > will be executed under conditional check, e.g only if 'crash_kexec_post_notifiers'
> > > > is specified in kernel cmdline. 
> > > 
> > > Hi Baoquan, based on Petr's suggestion, I think pre_dump would be
> > > responsible for really *non-intrusive/non-risky* tasks and should be
> > > always executed in the panic path (before kdump), regardless of
> > > "crash_kexec_post_notifiers".
> > > 
> > > The idea is that the majority of the notifiers would be executed in the
> > > post_dump portion, and for that, we have the
> > > "crash_kexec_post_notifiers" conditional. I also suggest we have
> > > blacklist options (based on function names) for both notifiers, in order
> > > to make kdump issues debug easier.
> > > 
> > > Do you agree with that? Feel free to comment with suggestions!
> > > Cheers,
> > 
> > I would say "please NO" cautiously.
> > 
> > As Petr said, kdump mostly works only if people configure it correctly.
> > That's because we try best to switch to kdump kernel from the fragile
> > panicked kernel immediately. When we try to add anthing before the switching,
> > please consider carefully and ask if that adding is mandatory, otherwise
> > switching into kdump kernel may fail. If the answer is yes, the adding
> > is needed and welcomed. Othewise, any unnecessary action, including any
> > "non-intrusive/non-risky" tasks, would be unwelcomed.
> 
> I still do not have the complete picture. But it seems that some
> actions make always sense even for kdump:
> 
>     + Super safe operations that might disable churn from broken
>       system. For examle, disabling watchdogs by setting a single
>       variable, see rcu_panic() notifier
> 
>     + Actions needed that allow to kexec the crash kernel a safe
>       way under some hypervisor, see
>       https://lore.kernel.org/r/MWHPR21MB15933573F5C81C5250BF6A1CD75E9@MWHPR21MB1593.namprd21.prod.outlook.com

Yes, I agree with this after going through threads of discussion again.
There is much space we can do something for panic_notifier, and it might
be a good time to do now with these discussion and some clarification.

> 
> 
> > Surely, we don't oppose the "non-intrusive/non-risky" or completely
> > "intrusive/risky" action adding before kdump kernel switching, with a
> > conditional limitation. When we handle customers' kdump support, we
> > explicitly declare we only support normal and default kdump operation.
> > If any action which is done before switching into kdump kernel is specified,
> > e.g panic_notifier, panic_print, they need take care of their own kdump
> > failure.
> 
> All this actually started because of kmsg_dump. It might make sense to
> allow both kmsg_dump and kdump together. The messages stored by
> kmsg_dump might be better than nothing when kdump fails.

I think this can be done later, after panics notifiers are combed and
tidied up.

> 
> It actually seems to be the main motivation to introduce
> "crash_kexec_post_notifier" parameter, see the commit
> f06e5153f4ae2e2f3b03 ("kernel/panic.c: add "crash_kexec_post_notifiers"
> option for kdump after panic_notifers").

From discussion with Hitachi and FJ engineers, they use
crash_kexec_post_notifiers when 1st kernel panicked and kdump kernel is
not so stable to function. In that case, the captured information 
with best effort after panic in 1st kernel can help analyze what
happened in 1st kernel, and also might give hint on why kdump kernel
is unstbale. But they will not add crash_kexec_post_notifiers in kernel
cmdline by default. The unstable kdump kernel rarely happened, need be
debugged and investigated. 

> 
> And this patch introduces panic_notifier_filter that tries to select
> notifiers that are helpful and harmful. IMHO, it is almost unusable.
> It seems that even kernel developers do not understand what exactly
> some notifiers do and why they are needed. Usually only the author
> and people familiar with the subsystem have some idea. It makes
> it pretty hard for anyone to create a reasonable filter.

Then people can select the notifiers they know to execute. E.g for
Hyper-V, they can run the notifiers related. And as HATAYAMA mentioned,
they have the same expection. This kind of filter is not for people to
blindly pick and run, but for the professional.

I think the chaos is from not being monitored entirely. People can
freely register one when they need. The priority, impaction to the
entirety is not considered by subsystem developer.

> 
> I am pretty sure that we could do better. I propose to add more
> notifier lists that will be called at various places with reasonable
> rules and restrictions. Then the susbsystem maintainers could decide
> where exactly a given action must be done.

Agree that we can do something to improve.

