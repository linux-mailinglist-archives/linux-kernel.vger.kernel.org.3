Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570FA4A2C93
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 08:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245071AbiA2Hmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 02:42:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20300 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239887AbiA2Hmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 02:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643442168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hqAbydCBk9H7/5XjW5Z7u+h9UMhr2T8NZqYgPwuQK68=;
        b=E6lo7rXSTapKmI97fot2plyAY/BTa0GvF47yFpNIELprafSRsDXiJUH5393IQLMIjoxTHi
        MBjBSOPa4pw2IGOWlXkyVrQEPwqxklMRDDfZzgA7IXB0FsrvcQVHiw/xbjneaMgHz2B1iP
        jl/PxwSaN3nSG2kM0UcA6ldzp90aOgc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-YzTIbIpCMQqLosWZ1C3_xg-1; Sat, 29 Jan 2022 02:42:47 -0500
X-MC-Unique: YzTIbIpCMQqLosWZ1C3_xg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C06AC1898290;
        Sat, 29 Jan 2022 07:42:44 +0000 (UTC)
Received: from localhost (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87C616E4A1;
        Sat, 29 Jan 2022 07:42:37 +0000 (UTC)
Date:   Sat, 29 Jan 2022 15:42:34 +0800
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
Message-ID: <20220129074234.GA17613@MiWiFi-R3L-srv>
References: <20220119071318.GA4977@MiWiFi-R3L-srv>
 <YegytkfED+QI56Y8@alley>
 <20220120085115.GB18398@MiWiFi-R3L-srv>
 <63621138-2a41-26c2-524e-d889068f157a@igalia.com>
 <20220121023119.GB4579@MiWiFi-R3L-srv>
 <MWHPR21MB1593A32A3433F5F262796FCFD75B9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20220122043351.GA2596@MiWiFi-R3L-srv>
 <MWHPR21MB15933573F5C81C5250BF6A1CD75E9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20220128090311.GA27201@MiWiFi-R3L-srv>
 <MWHPR21MB159337667BD11F6F8BCA6A06D7229@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB159337667BD11F6F8BCA6A06D7229@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/28/22 at 06:24pm, Michael Kelley (LINUX) wrote:
> From: Baoquan He <bhe@redhat.com> Sent: Friday, January 28, 2022 1:03 AM
> > 
> > On 01/24/22 at 04:57pm, Michael Kelley (LINUX) wrote:
> > > From: Baoquan He <bhe@redhat.com> Sent: Friday, January 21, 2022 8:34 PM
> > > >
> > > > On 01/21/22 at 03:00pm, Michael Kelley (LINUX) wrote:
> > > > > From: Baoquan He <bhe@redhat.com> Sent: Thursday, January 20, 2022 6:31 PM
> > > > > >
> > > > > > On 01/20/22 at 06:36pm, Guilherme G. Piccoli wrote:
> > > > > > > Hi Baoquan, some comments inline below:
> > > > > > >
> > > > > > > On 20/01/2022 05:51, Baoquan He wrote:
> > >
> > > [snip]
> > >
> > > > > > > Do you think it should be necessary?
> > > > > > > How about if we allow users to just "panic_print" with or without the
> > > > > > > "crash_kexec_post_notifiers", then we pursue Petr suggestion of
> > > > > > > refactoring the panic notifiers? So, after this future refactor, we
> > > > > > > might have a much clear code.
> > > > > >
> > > > > > I haven't read Petr's reply in another panic notifier filter thread. For
> > > > > > panic notifier, it's only enforced to use on HyperV platform, excepto of
> > > > > > that, users need to explicitly add "crash_kexec_post_notifiers=1" to enable
> > > > > > it. And we got bug report on the HyperV issue. In our internal discussion,
> > > > > > we strongly suggest HyperV dev to change the default enablement, instead
> > > > > > leave it to user to decide.
> > > > > >
> > > > >
> > > > > Regarding Hyper-V:   Invoking the Hyper-V notifier prior to running the
> > > > > kdump kernel is necessary for correctness.  During initial boot of the
> > > > > main kernel, the Hyper-V and VMbus code in Linux sets up several guest
> > > > > physical memory pages that are shared with Hyper-V, and that Hyper-V
> > > > > may write to.   A VMbus connection is also established. Before kexec'ing
> > > > > into the kdump kernel, the sharing of these pages must be rescinded
> > > > > and the VMbus connection must be terminated.   If this isn't done, the
> > > > > kdump kernel will see strange memory overwrites if these shared guest
> > > > > physical memory pages get used for something else.
> > > > >
> > > > > I hope we've found and fixed all the problems where the Hyper-V
> > > > > notifier could get hung.  Unfortunately, the Hyper-V interfaces were
> > > > > designed long ago without the Linux kexec scenario in mind, and they
> > > > > don't provide a simple way to reset everything except by doing a
> > > > > reboot that goes back through the virtual BIOS/UEFI.  So the Hyper-V
> > > > > notifier code is more complicated than would be desirable, and in
> > > > > particular, terminating the VMbus connection is tricky.
> > > > >
> > > > > This has been an evolving area of understanding.  It's only been the last
> > > > > couple of years that we've fully understood the implications of these
> > > > > shared memory pages on the kexec/kdump scenario and what it takes
> > > > > to reset everything so the kexec'ed kernel will work.
> > > >
> > > > Glad to know these background details, thx, Michael. While from the
> > > > commit which introduced it and the code comment above code, I thought
> > > > Hyper-V wants to collect data before crash dump. If this is the true,
> > > > it might be helpful to add these in commit log or add as code comment,
> > > > and also help to defend you when people question it.
> > > >
> > > > int __init hv_common_init(void)
> > > > {
> > > >         int i;
> > > >
> > > >         /*
> > > >          * Hyper-V expects to get crash register data or kmsg when
> > > >          * crash enlightment is available and system crashes. Set
> > > >          * crash_kexec_post_notifiers to be true to make sure that
> > > >          * calling crash enlightment interface before running kdump
> > > >          * kernel.
> > > >          */
> > > >         if (ms_hyperv.misc_features &
> > HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
> > > >                 crash_kexec_post_notifiers = true;
> > > >
> > > > 	......
> > > > }
> > >
> > > In the Azure cloud, collecting data before crash dumps is a motivation
> > > as well for setting crash_kexec_post_notifiers to true.   That way as
> > > cloud operator we can see broad failure trends, and in specific cases
> > > customers often expect the cloud operator to be able to provide info
> > > about a problem even if they have taken a kdump.  Where did you
> > > envision adding a comment in the code to help clarify these intentions?
> > >
> > > I looked at the code again, and should revise my previous comments
> > > somewhat.   The Hyper-V resets that I described indeed must be done
> > > prior to kexec'ing the kdump kernel.   Most such resets are actually
> > > done via __crash_kexec() -> machine_crash_shutdown(), not via the
> > > panic notifier. However, the Hyper-V panic notifier must terminate the
> > > VMbus connection, because that must be done even if kdump is not
> > > being invoked.  See commit 74347a99e73.
> > >
> > > Most of the hangs seen in getting into the kdump kernel on Hyper-V/Azure
> > > were probably due to the machine_crash_shutdown() path, and not due
> > > to running the panic notifiers prior to kexec'ing the kdump kernel.  The
> > > exception is terminating the VMbus connection, which had problems that
> > > are hopefully now fixed because of adding a timeout.
> > Thanks for detailed information.
> > 
> > So I can understand the status as:
> > ===
> > Hyper-V needed panic_notifier to execute before __crash_kexec() in
> > the past, because VMbus connection need be terminated, that's done in
> > commit 74347a99e73 as a workaround when panic happened, whether kdump is
> > enabled or not. But now, the VMbus connection termination is not needed
> > anymore since it's fixed by adding a timeout on Hyper-V.
> 
> No.  Sorry I wasn't clear.  Even now, specific action needs to be taken to
> terminate the VMbus connection before __crash_kexec() runs so that
> the new kdump kernel can start fresh and establish its own VMbus
> connection.  You had originally mentioned hang problems occurring
> because of running the Hyper-V panic notifier before __crash_kexec().
> Terminating the VMbus connection waits for a reply from Hyper-V
> because terminating the connection can take a while (10's seconds)
> if Hyper-V has a lot of disk data cached.  Dirty data must be flushed back
> to a cloud disk before the kdump kernel runs (otherwise other weird stuff
> happens in the kdump kernel).  We've added a timeout in Linux so that if
> for whatever reason Hyper-V fails to reply, __crash_kexec() still gets called.
> Hopefully that timeout cures any hang problems that were previously
> seen.  But the timeout does not remove the need to terminate the
> VMbus connection.

Ah, got it now, thx.

So the VMbus connection has to be terminated explicitly and need be
waited, no matter kdump is configured or not. Wondering why we don't 
wrap these into a function and call it before __crash_kexec() if
platform is Hyper-V. Honeslty, hooking it up to panic_notifier_list
and executing the entire panic_notifiers for Hyper-V is risky and
not so inappropriate.




