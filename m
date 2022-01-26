Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804F749C914
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbiAZLvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:51:48 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36150 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbiAZLvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:51:46 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id ABB531F3AE;
        Wed, 26 Jan 2022 11:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643197905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iC+9fZFMgNXQrXNkpV3kwAOp8sXbJjtcXHN+8ofoBuA=;
        b=hQwYelznxpBhZdQP2EnHM50XZ7M8r/yRLTGTF4hUOfLJM/wBp78R2FaDw8RlHD8SF331xw
        OsxEPgm2kgoZh5zfKqDLsORbwcue/aR+fW1613Lk46bO2OUTDFA4ioT6mJaNC1fiNX+3Ah
        AitO49dA6NT+UfSd95uobQdZocBwjgg=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 37C49A3B81;
        Wed, 26 Jan 2022 11:51:45 +0000 (UTC)
Date:   Wed, 26 Jan 2022 12:51:42 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Baoquan He <bhe@redhat.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
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
Message-ID: <YfE1zuhB2Qz73wqF@alley>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-01-24 16:57:17, Michael Kelley (LINUX) wrote:
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

My undestanding is that we could split the actions into three groups:

  1. Actions that has to be before kexec'ing kdump kernel, like
     resetting physicall memory shared with Hyper-V.

     These operation(s) are needed only for kexec and can be done
     in kexec.


   2. Notify Hyper-V so that, for example, Azure cloud, could collect
      data before crash dump.

      It is nice to have.

      It should be configurable if it is not completely safe. I mean
      that there should be a way to disable it when it might increase
      the risk that kexec'ing kdump kernel might fail.


   3. Some actions are needed only when panic() ends up in the
      infinite loop.

      For example, unloading vmbus channel. At least the commit
      74347a99e73ae00b8385f ("x86/Hyper-V: Unload vmbus channel in
      hv panic callback") says that it is done in kdump path
      out of box.

All these operations are needed and used only when the kernel is
running under Hyper-V.

My mine intention is to understand if we need 2 or 3 notifier lists
or the current one is enough.

The 3 notifier lists would be:

   + always do (even before kdump)
   + optionally do before or after kdump
   + needed only when kdump is not called

Thanks a lot for the very valuable input.

Best Regards,
Petr
