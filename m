Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C420461AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 16:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbhK2PYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 10:24:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244226AbhK2PWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 10:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638199174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dh9oJ6PVGl1aO7ou0WASoJD2DrpHlrNES9QEvDvnypw=;
        b=iT14vkSCooWat8M9YfOmL+1Lmkyj8hJmPvUxnV8pK7Et6Z9gMvgKJBkejCs7oNUEsnKvmr
        qXS8cUFKXqP6p0SymjAlIyNHcILVOXUlQtrCN9T/n8p8mwUo6FWO308bJnnMKp+z4Er6Hu
        rScYINjWq429Mn448updhTnh61wJymQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-tgiKbbubMTuFxEbvi5jfag-1; Mon, 29 Nov 2021 10:19:31 -0500
X-MC-Unique: tgiKbbubMTuFxEbvi5jfag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 457BA1019627;
        Mon, 29 Nov 2021 15:19:29 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B369060BF1;
        Mon, 29 Nov 2021 15:19:28 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 4196E416D862; Mon, 29 Nov 2021 12:13:25 -0300 (-03)
Date:   Mon, 29 Nov 2021 12:13:25 -0300
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
Message-ID: <20211129151325.GA135990@fuller.cnet>
References: <20211112123531.497831890@fuller.cnet>
 <20211112123750.692268849@fuller.cnet>
 <20211123123620.GB479935@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123123620.GB479935@lothringen>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 01:36:20PM +0100, Frederic Weisbecker wrote:
> On Fri, Nov 12, 2021 at 09:35:33AM -0300, Marcelo Tosatti wrote:
> > +**PR_ISOL_CFG_SET**:
> > +
> > +        Set task isolation configuration.
> > +        The general format is::
> > +
> > +                prctl(PR_ISOL_CFG_SET, what, arg3, arg4, arg5);
> > +
> > +        The 'what' argument specifies what to configure. Possible values are:
> > +
> > +        - ``I_CFG_FEAT``:
> > +
> > +                Set configuration of task isolation features. 'arg3' specifies
> > +                the feature. Possible values are:
> > +
> > +                - ``ISOL_F_QUIESCE``:
> > +
> > +                        If arg4 is QUIESCE_CONTROL, set the control structure
> > +                        for quiescing of background kernel activities, from
> > +                        the location pointed to by ``(int *)arg5``::
> > +
> > +                         struct task_isol_quiesce_control {
> > +                                __u64 flags;
> > +                                __u64 quiesce_mask;
> > +                                __u64 quiesce_oneshot_mask;
> > +                                __u64 pad[5];
> > +                         };
> > +
> > +                        Where:
> > +
> > +                        *flags*: Additional flags (should be zero).
> > +
> > +                        *quiesce_mask*: A bitmask containing which kernel
> > +                        activities to quiesce.
> > +
> > +                        *quiesce_oneshot_mask*: A bitmask indicating which kernel
> > +                        activities should behave in oneshot mode, that is, quiescing
> > +                        will happen on return from prctl(PR_ISOL_ACTIVATE_SET), but not
> > +                        on return of subsequent system calls. The corresponding bit(s)
> > +                        must also be set at quiesce_mask.
> > +
> > +                        *pad*: Additional space for future enhancements.
> > +
> > +                        For quiesce_mask (and quiesce_oneshot_mask), possible bit sets are:
> > +
> > +                        - ``ISOL_F_QUIESCE_VMSTATS``
> > +
> > +                        VM statistics are maintained in per-CPU counters to
> > +                        improve performance. When a CPU modifies a VM statistic,
> > +                        this modification is kept in the per-CPU counter.
> > +                        Certain activities require a global count, which
> > +                        involves requesting each CPU to flush its local counters
> > +                        to the global VM counters.
> > +
> > +                        This flush is implemented via a workqueue item, which
> > +                        might schedule a workqueue on isolated CPUs.
> > +
> > +                        To avoid this interruption, task isolation can be
> > +                        configured to, upon return from system calls, synchronize
> > +                        the per-CPU counters to global counters, thus avoiding
> > +                        the interruption.
> 
> Sorry I know this is already v7 but we really don't want to screw up this interface.

No problem.

> What would be more simple and flexible for individual features to quiesce:
> 
>    arg3 = ISOL_F_QUIESCE
>    arg4 = which feature to quiesce (eg: ISOL_F_QUIESCE_VMSTATS)

arg4 is QUIESCE_CONTROL today so one can expand the interface
(by adding new commands).

>    arg5 =
> 
>        struct task_isol_quiesce_control {
>            __u64 flags; //with ONESHOT as the first and only possible flag for now
>            __u64 pad[5];
>        };

So your idea is to allow expansion at this level ? Say while adding
a new

ISOL_F_QUIESCE_NEWITEM

one can add

	struct task_isol_quiesce_control_newitem {
		__u64 flags;
		__u64 pad[5];
	};

And add new fields to "struct task_isol_quiesce_control_newitem".

One downside of this suggestion is that for use-cases of the task_isol_computation.c type,
(see patch 2 "add prctl task isolation prctl docs and samples"), this might need
multiple system calls for each enable/disable cycle. Is that OK?

See more below.

> This way we can really do a finegrained control over each feature to quiesce.

With the patchset above, one can add new values to arg4 
(at the same level of QUIESCE_CONTROL). Your suggestion does not save
room for that.

One could add new values to the same space of I_CFG_FEAT:

          prctl(PR_ISOL_CFG_SET, I_CFG_FEAT_xxx, ...);

But that sounds awkward.

Or change the current ioctl to:

          prctl(PR_ISOL_CFG, I_CFG_FEAT_CONTROL, ...);

Which makes it less awkward.

What do you say?

--- 

And then, what about keeping the bitmaps with enabled/one-shot mode
per feature per bit (to avoid multiple system calls)
but having (in the future) additional per-quiesce instance commands ?








