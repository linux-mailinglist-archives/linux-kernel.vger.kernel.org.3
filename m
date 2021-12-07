Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8166C46C151
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 18:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239766AbhLGRJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 12:09:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42478 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234465AbhLGRJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:09:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638896735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WKR4l8EGNswQ0z+RtaYYtmkRaXTvQhgHjbr7U9hnO7I=;
        b=g2N6DPNFu6enmGmYzOCK23m4FOtiqbrCcbcNXILBljX91xiJxWFU488P25cY/98oxZl/RC
        y/kgM7EYomW0gUc1Xe+h6aGfQ5JqUb7jXQeYqOxESlPwlftDBNWLPp8ZzgkRdmGhVEIOW4
        0IUtxnU3OeZNh6soAsiX13kX/5gJm7s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-g_Uo7oAEOhurcKphCNagPQ-1; Tue, 07 Dec 2021 12:05:32 -0500
X-MC-Unique: g_Uo7oAEOhurcKphCNagPQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52411102CB34;
        Tue,  7 Dec 2021 17:05:31 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BFB4145D6A;
        Tue,  7 Dec 2021 17:05:30 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 77715416CE5D; Tue,  7 Dec 2021 14:05:26 -0300 (-03)
Date:   Tue, 7 Dec 2021 14:05:26 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch v7 02/10] add prctl task isolation prctl docs and samples
Message-ID: <20211207170526.GA19149@fuller.cnet>
References: <20211112123531.497831890@fuller.cnet>
 <20211112123750.692268849@fuller.cnet>
 <20211123123620.GB479935@lothringen>
 <20211129151325.GA135990@fuller.cnet>
 <20211202171320.GA648659@lothringen>
 <20211202182930.GA48887@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202182930.GA48887@fuller.cnet>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 03:29:30PM -0300, Marcelo Tosatti wrote:
> On Thu, Dec 02, 2021 at 06:13:20PM +0100, Frederic Weisbecker wrote:
> > On Mon, Nov 29, 2021 at 12:13:25PM -0300, Marcelo Tosatti wrote:
> > > On Tue, Nov 23, 2021 at 01:36:20PM +0100, Frederic Weisbecker wrote:
> > > > On Fri, Nov 12, 2021 at 09:35:33AM -0300, Marcelo Tosatti wrote:
> > > > > +**PR_ISOL_CFG_SET**:
> > > > > +
> > > > > +        Set task isolation configuration.
> > > > > +        The general format is::
> > > > > +
> > > > > +                prctl(PR_ISOL_CFG_SET, what, arg3, arg4, arg5);
> > > > > +
> > > > > +        The 'what' argument specifies what to configure. Possible values are:
> > > > > +
> > > > > +        - ``I_CFG_FEAT``:
> > > > > +
> > > > > +                Set configuration of task isolation features. 'arg3' specifies
> > > > > +                the feature. Possible values are:
> > > > > +
> > > > > +                - ``ISOL_F_QUIESCE``:
> > > > > +
> > > > > +                        If arg4 is QUIESCE_CONTROL, set the control structure
> > > > > +                        for quiescing of background kernel activities, from
> > > > > +                        the location pointed to by ``(int *)arg5``::
> > > > > +
> > > > > +                         struct task_isol_quiesce_control {
> > > > > +                                __u64 flags;
> > > > > +                                __u64 quiesce_mask;
> > > > > +                                __u64 quiesce_oneshot_mask;
> > > > > +                                __u64 pad[5];
> > > > > +                         };
> > > > > +
> > > > > +                        Where:
> > > > > +
> > > > > +                        *flags*: Additional flags (should be zero).
> > > > > +
> > > > > +                        *quiesce_mask*: A bitmask containing which kernel
> > > > > +                        activities to quiesce.
> > > > > +
> > > > > +                        *quiesce_oneshot_mask*: A bitmask indicating which kernel
> > > > > +                        activities should behave in oneshot mode, that is, quiescing
> > > > > +                        will happen on return from prctl(PR_ISOL_ACTIVATE_SET), but not
> > > > > +                        on return of subsequent system calls. The corresponding bit(s)
> > > > > +                        must also be set at quiesce_mask.
> > > > > +
> > > > > +                        *pad*: Additional space for future enhancements.
> > > > > +
> > > > > +                        For quiesce_mask (and quiesce_oneshot_mask), possible bit sets are:
> > > > > +
> > > > > +                        - ``ISOL_F_QUIESCE_VMSTATS``
> > > > > +
> > > > > +                        VM statistics are maintained in per-CPU counters to
> > > > > +                        improve performance. When a CPU modifies a VM statistic,
> > > > > +                        this modification is kept in the per-CPU counter.
> > > > > +                        Certain activities require a global count, which
> > > > > +                        involves requesting each CPU to flush its local counters
> > > > > +                        to the global VM counters.
> > > > > +
> > > > > +                        This flush is implemented via a workqueue item, which
> > > > > +                        might schedule a workqueue on isolated CPUs.
> > > > > +
> > > > > +                        To avoid this interruption, task isolation can be
> > > > > +                        configured to, upon return from system calls, synchronize
> > > > > +                        the per-CPU counters to global counters, thus avoiding
> > > > > +                        the interruption.
> > > > 
> > > > Sorry I know this is already v7 but we really don't want to screw up this interface.
> > > 
> > > No problem.
> > > 
> > > > What would be more simple and flexible for individual features to quiesce:
> > > > 
> > > >    arg3 = ISOL_F_QUIESCE
> > > >    arg4 = which feature to quiesce (eg: ISOL_F_QUIESCE_VMSTATS)
> > > 
> > > arg4 is QUIESCE_CONTROL today so one can expand the interface
> > > (by adding new commands).
> > > 
> > > >    arg5 =
> > > > 
> > > >        struct task_isol_quiesce_control {
> > > >            __u64 flags; //with ONESHOT as the first and only possible flag for now
> > > >            __u64 pad[5];
> > > >        };
> > > 
> > > So your idea is to allow expansion at this level ? Say while adding
> > > a new
> > > 
> > > ISOL_F_QUIESCE_NEWITEM
> > > 
> > > one can add
> > > 
> > > 	struct task_isol_quiesce_control_newitem {
> > > 		__u64 flags;
> > > 		__u64 pad[5];
> > > 	};
> > > 
> > > And add new fields to "struct task_isol_quiesce_control_newitem".
> > > 
> > > One downside of this suggestion is that for use-cases of the task_isol_computation.c type,
> > > (see patch 2 "add prctl task isolation prctl docs and samples"), this might need
> > > multiple system calls for each enable/disable cycle. Is that OK?
> > > 
> > > See more below.
> > > 
> > > > This way we can really do a finegrained control over each feature to quiesce.
> > > 
> > > With the patchset above, one can add new values to arg4 
> > > (at the same level of QUIESCE_CONTROL). Your suggestion does not save
> > > room for that.
> > > 
> > > One could add new values to the same space of I_CFG_FEAT:
> > > 
> > >           prctl(PR_ISOL_CFG_SET, I_CFG_FEAT_xxx, ...);
> > > 
> > > But that sounds awkward.
> > > 
> > > Or change the current ioctl to:
> > > 
> > >           prctl(PR_ISOL_CFG, I_CFG_FEAT_CONTROL, ...);
> > > 
> > > Which makes it less awkward.
> > > 
> > > What do you say?
> > > 
> > > --- 
> > > 
> > > And then, what about keeping the bitmaps with enabled/one-shot mode
> > > per feature per bit (to avoid multiple system calls)
> > > but having (in the future) additional per-quiesce instance commands ?
> > 
> > Ok got your points.
> > 
> > I guess we can then simply rename ISOL_F_QUIESCE to ISOL_F_QUIESCE_MULTIPLE
> > for simple all-in-one configuration. Then if the need ever arise in the future,
> > we can always add ISOL_F_QUIESCE (or ISOL_F_QUIESCE_ONE) to do finegrained
> > control over a single quiescing feature.
> > 
> > Does that sound ok?
> 
> Yep, it does, will change that.

Actually, after performing some of the changes, it turns out that
just adding ISOL_F_QUIESCE_ONE to configure individual features, 
and keeping the current ISOL_F_QUIESCE works just as well.

Fixed the other issues you raised, and added documentation about 
the possibility of ISOL_F_QUIESCE_ONE.

Will resend.

