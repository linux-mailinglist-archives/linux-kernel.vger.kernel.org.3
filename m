Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DC4461AB9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 16:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240661AbhK2PYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 10:24:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60176 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244519AbhK2PWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 10:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638199173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eZEx92rbd27scWY5gjEifsF/ROnUDNkZpXPLz0otWBA=;
        b=ZtCK7odUdq2mVdEKcBeIK8QULc1a/1uQJXVQX3bCstk0GnU2mFNVfV11pV1kl9HXc1HpG9
        zh021LulSL5/5X96AbOsCnT8uPlgTbtpLbRn5CxDJqthKOmsGVd6RYJ1sNVhNI+vp2gYqr
        vsOylFexxHyIPNl+oYvd7AYP0Sn4WSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-5mdlWMaPNtOe5Yb4VjdTVQ-1; Mon, 29 Nov 2021 10:19:30 -0500
X-MC-Unique: 5mdlWMaPNtOe5Yb4VjdTVQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AFD3881278;
        Mon, 29 Nov 2021 15:19:29 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C83119724;
        Mon, 29 Nov 2021 15:19:28 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 9FC6B4172ED4; Mon, 29 Nov 2021 12:19:24 -0300 (-03)
Date:   Mon, 29 Nov 2021 12:19:24 -0300
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
Message-ID: <20211129151924.GB135990@fuller.cnet>
References: <20211112123531.497831890@fuller.cnet>
 <20211112123750.692268849@fuller.cnet>
 <20211123143726.GC479935@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123143726.GC479935@lothringen>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 03:37:26PM +0100, Frederic Weisbecker wrote:
> On Fri, Nov 12, 2021 at 09:35:33AM -0300, Marcelo Tosatti wrote:
> > +**PR_ISOL_CFG_GET**:
> > +
> > +        Retrieve task isolation configuration.
> > +        The general format is::
> > +
> > +                prctl(PR_ISOL_CFG_GET, what, arg3, arg4, arg5);
> > +
> > +        The 'what' argument specifies what to configure. Possible values are:
> > +
> > +        - ``I_CFG_FEAT``:
> > +
> > +                Return configuration of task isolation features. The 'arg3' argument specifies
> > +                whether to return configured features (if zero), or individual
> > +                feature configuration (if not zero), as follows.
> > +
> > +                - ``0``:
> > +
> > +                        Return the bitmask of configured features, in the location
> > +                        pointed  to  by  ``(int *)arg4``. The buffer should allow space
> > +                        for 8 bytes.
> > +
> > +                - ``ISOL_F_QUIESCE``:
> > +
> > +                        If arg4 is QUIESCE_CONTROL, return the control structure for
> > +                        quiescing of background kernel activities, in the location
> > +                        pointed to by ``(int *)arg5``::
> > +
> > +                         struct task_isol_quiesce_control {
> > +                                __u64 flags;
> > +                                __u64 quiesce_mask;
> > +                                __u64 quiesce_oneshot_mask;
> > +                                __u64 pad[5];
> > +                         };
> > +
> > +                        See PR_ISOL_CFG_GET description for meaning of
> > fields.
> 
> PR_ISOL_CFG_SET ?

Yes, _SET.

> [...]
> > +
> > +                        *quiesce_oneshot_mask*: A bitmask indicating which kernel
> > +                        activities should behave in oneshot mode, that is, quiescing
> > +                        will happen on return from prctl(PR_ISOL_ACTIVATE_SET), but not
> > +                        on return of subsequent system calls. The corresponding bit(s)
> > +                        must also be set at quiesce_mask.
> 
> Don't forget to mention interrupts and exceptions.

OK.

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
> > +
> > +        - ``I_CFG_INHERIT``:
> > +                Set inheritance configuration when a new task
> > +                is created via fork and clone.
> > +
> > +                The ``(int *)arg4`` argument is a pointer to::
> > +
> > +                        struct task_isol_inherit_control {
> > +                                __u8    inherit_mask;
> > +                                __u8    pad[7];
> > +                        };
> > +
> > +                inherit_mask is a bitmask that specifies which part
> > +                of task isolation should be inherited:
> > +
> > +                - Bit ISOL_INHERIT_CONF: Inherit task isolation configuration.
> > +                  This is the state written via prctl(PR_ISOL_CFG_SET, ...).
> > +
> > +                - Bit ISOL_INHERIT_ACTIVE: Inherit task isolation activation
> > +                  (requires ISOL_INHERIT_CONF to be set). The new task
> > +                  should behave, after fork/clone, in the same manner
> > +                  as the parent task after it executed:
> > +
> > +                        prctl(PR_ISOL_ACTIVATE_SET, &mask, ...);
> 
> I'm confused, what is the purpose of ISOL_INHERIT_CONF?

When ISOL_INHERIT_CONF is set, task isolation configuration (everything
configured through PR_ISOL_CFG_SET) is copied across fork/clone
(but not activation) so one can:

	1) configure task isolation (with chisol, for example).
	2) activate task isolation from the latency sensitive app:

+This is a snippet of code to activate task isolation if
+it has been previously configured (by chisol for example)::
+
+        #include <sys/prctl.h>
+        #include <linux/types.h>
+
+        #ifdef PR_ISOL_CFG_GET
+        unsigned long long fmask;
+
+        ret = prctl(PR_ISOL_CFG_GET, I_CFG_FEAT, 0, &fmask, 0);
+        if (ret != -1 && fmask != 0) {
+                ret = prctl(PR_ISOL_ACTIVATE_SET, &fmask, 0, 0, 0);
+                if (ret == -1) {
+                        perror("prctl PR_ISOL_ACTIVATE_SET");
+                        return ret;
+                }
+        }
+        #endif

Regarding the 3 possible modes of operation and their relation 
to ISOL_INHERIT_CONF / ISOL_INHERIT_ACTIVE:

+This results in three combinations:
+
+1. Both configuration and activation performed by the
+latency sensitive application.
+Allows fine grained control of what task isolation
+features are enabled and when (see samples section below).

	inherit_mask = 0

+2. Only activation can be performed by the latency sensitive app
+(and configuration performed by chisol).
+This allows the admin/user to control task isolation parameters,
+and applications have to be modified only once.

	inherit_mask = ISOL_INHERIT_CONF

+3. Configuration and activation performed by an external tool.
+This allows unmodified applications to take advantage of
+task isolation. Activation is performed by the "-a" option
+of chisol.

	inherit_mask = ISOL_INHERIT_ACTIVE

