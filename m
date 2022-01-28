Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DE649F5DD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbiA1JDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:03:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27706 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236195AbiA1JDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:03:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643360609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XCYM+IqJr0NFevLxvsCw0V8lGLw4f7ESZlzKqk6nbbk=;
        b=IX+Q3TCJe5atFXqTK1mi1bDl81ywMTk+w0CzcVfuJtFIFAkS8sCYXapxgImIgP2QQF0D3W
        cOgBejaud4sstm1cD44kP+2J47UJJYfjgwRIDKkjgLDYK6+esGf5udDm3TkqlzZDzF4msU
        zhdU07aqCp+tyzNR4iy5l1X1AJGxv4M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-ECnkCWsuNT23-QgxaB_e_g-1; Fri, 28 Jan 2022 04:03:24 -0500
X-MC-Unique: ECnkCWsuNT23-QgxaB_e_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A194C83DD22;
        Fri, 28 Jan 2022 09:03:21 +0000 (UTC)
Received: from localhost (ovpn-12-152.pek2.redhat.com [10.72.12.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2814C4DC3A;
        Fri, 28 Jan 2022 09:03:13 +0000 (UTC)
Date:   Fri, 28 Jan 2022 17:03:11 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Petr Mladek <pmladek@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "john.ogness@linutronix.de" <john.ogness@linutronix.de>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Subject: Re: [PATCH V3] panic: Move panic_print before kmsg dumpers
Message-ID: <20220128090311.GA27201@MiWiFi-R3L-srv>
References: <20220114183046.428796-1-gpiccoli@igalia.com>
 <20220119071318.GA4977@MiWiFi-R3L-srv>
 <YegytkfED+QI56Y8@alley>
 <20220120085115.GB18398@MiWiFi-R3L-srv>
 <63621138-2a41-26c2-524e-d889068f157a@igalia.com>
 <20220121023119.GB4579@MiWiFi-R3L-srv>
 <MWHPR21MB1593A32A3433F5F262796FCFD75B9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20220122043351.GA2596@MiWiFi-R3L-srv>
 <MWHPR21MB15933573F5C81C5250BF6A1CD75E9@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15933573F5C81C5250BF6A1CD75E9@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/24/22 at 04:57pm, Michael Kelley (LINUX) wrote:
> From: Baoquan He <bhe@redhat.com> Sent: Friday, January 21, 2022 8:34 PM
> > 
> > On 01/21/22 at 03:00pm, Michael Kelley (LINUX) wrote:
> > > From: Baoquan He <bhe@redhat.com> Sent: Thursday, January 20, 2022 6:31 PM
> > > >
> > > > On 01/20/22 at 06:36pm, Guilherme G. Piccoli wrote:
> > > > > Hi Baoquan, some comments inline below:
> > > > >
> > > > > On 20/01/2022 05:51, Baoquan He wrote:
> 
> [snip]
> 
> > > > > Do you think it should be necessary?
> > > > > How about if we allow users to just "panic_print" with or without the
> > > > > "crash_kexec_post_notifiers", then we pursue Petr suggestion of
> > > > > refactoring the panic notifiers? So, after this future refactor, we
> > > > > might have a much clear code.
> > > >
> > > > I haven't read Petr's reply in another panic notifier filter thread. For
> > > > panic notifier, it's only enforced to use on HyperV platform, excepto of
> > > > that, users need to explicitly add "crash_kexec_post_notifiers=1" to enable
> > > > it. And we got bug report on the HyperV issue. In our internal discussion,
> > > > we strongly suggest HyperV dev to change the default enablement, instead
> > > > leave it to user to decide.
> > > >
> > >
> > > Regarding Hyper-V:   Invoking the Hyper-V notifier prior to running the
> > > kdump kernel is necessary for correctness.  During initial boot of the
> > > main kernel, the Hyper-V and VMbus code in Linux sets up several guest
> > > physical memory pages that are shared with Hyper-V, and that Hyper-V
> > > may write to.   A VMbus connection is also established. Before kexec'ing
> > > into the kdump kernel, the sharing of these pages must be rescinded
> > > and the VMbus connection must be terminated.   If this isn't done, the
> > > kdump kernel will see strange memory overwrites if these shared guest
> > > physical memory pages get used for something else.
> > >
> > > I hope we've found and fixed all the problems where the Hyper-V
> > > notifier could get hung.  Unfortunately, the Hyper-V interfaces were
> > > designed long ago without the Linux kexec scenario in mind, and they
> > > don't provide a simple way to reset everything except by doing a
> > > reboot that goes back through the virtual BIOS/UEFI.  So the Hyper-V
> > > notifier code is more complicated than would be desirable, and in
> > > particular, terminating the VMbus connection is tricky.
> > >
> > > This has been an evolving area of understanding.  It's only been the last
> > > couple of years that we've fully understood the implications of these
> > > shared memory pages on the kexec/kdump scenario and what it takes
> > > to reset everything so the kexec'ed kernel will work.
> > 
> > Glad to know these background details, thx, Michael. While from the
> > commit which introduced it and the code comment above code, I thought
> > Hyper-V wants to collect data before crash dump. If this is the true,
> > it might be helpful to add these in commit log or add as code comment,
> > and also help to defend you when people question it.
> > 
> > int __init hv_common_init(void)
> > {
> >         int i;
> > 
> >         /*
> >          * Hyper-V expects to get crash register data or kmsg when
> >          * crash enlightment is available and system crashes. Set
> >          * crash_kexec_post_notifiers to be true to make sure that
> >          * calling crash enlightment interface before running kdump
> >          * kernel.
> >          */
> >         if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
> >                 crash_kexec_post_notifiers = true;
> > 
> > 	......
> > }
> 
> In the Azure cloud, collecting data before crash dumps is a motivation
> as well for setting crash_kexec_post_notifiers to true.   That way as
> cloud operator we can see broad failure trends, and in specific cases
> customers often expect the cloud operator to be able to provide info
> about a problem even if they have taken a kdump.  Where did you
> envision adding a comment in the code to help clarify these intentions?
> 
> I looked at the code again, and should revise my previous comments
> somewhat.   The Hyper-V resets that I described indeed must be done
> prior to kexec'ing the kdump kernel.   Most such resets are actually
> done via __crash_kexec() -> machine_crash_shutdown(), not via the
> panic notifier. However, the Hyper-V panic notifier must terminate the
> VMbus connection, because that must be done even if kdump is not
> being invoked.  See commit 74347a99e73.
> 
> Most of the hangs seen in getting into the kdump kernel on Hyper-V/Azure 
> were probably due to the machine_crash_shutdown() path, and not due
> to running the panic notifiers prior to kexec'ing the kdump kernel.  The
> exception is terminating the VMbus connection, which had problems that
> are hopefully now fixed because of adding a timeout.
Thanks for detailed information.

So I can understand the status as:
===
Hyper-V needed panic_notifier to execute before __crash_kexec() in
the past, because VMbus connection need be terminated, that's done in
commit 74347a99e73 as a workaround when panic happened, whether kdump is
enabled or not. But now, the VMbus connection termination is not needed
anymore since it's fixed by adding a timeout on Hyper-V.

Then, in the current kernel, panic_notifier is taken to execute on Hyper-V
by default just because of one reason, Hyper-V wants to collect data
before crash dump. The data collecting is motivate by trying to see
broad failure trends as cloud operator on Azure cloud, and in specific
cases providing info to customer even if they have taken vmcore.
===

Do I get it right?

