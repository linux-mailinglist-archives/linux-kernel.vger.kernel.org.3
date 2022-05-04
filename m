Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C9751AEAF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355249AbiEDUMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358149AbiEDUMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:12:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 908C84EDEB
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651694935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=91mo6dPvqzdevT97jbLPcoi/EGgrjd9edy4N4bVm32I=;
        b=C33GKR0ioBIAUScjjMKwZt8MseuHiE+dr7gJ0fVYdMYKPLD88faX+zaf5/iXpeuA64HJPU
        m9UdzxBqZ6KU3vYFmGM6iJpAPNACzMlUvensSIDe4By0X6c1/ETF/xfaYH4QeyVLw6EQKr
        UeSou/HPlhm7F6gLurw4SR8OPdu+MS8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-bhKTF9z_MiuB9lEMfKMawQ-1; Wed, 04 May 2022 16:08:52 -0400
X-MC-Unique: bhKTF9z_MiuB9lEMfKMawQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CF53185A79C;
        Wed,  4 May 2022 20:08:52 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC75C54CE5B;
        Wed,  4 May 2022 20:08:50 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 0B9F14936629; Wed,  4 May 2022 17:08:31 -0300 (-03)
Date:   Wed, 4 May 2022 17:08:31 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>
Subject: Re: [patch v12 00/13] extensible prctl task isolation interface and
 vmstat sync
Message-ID: <YnLdP3Hq1d69NSzz@fuller.cnet>
References: <20220315153132.717153751@fedora.localdomain>
 <f6217c9398e252f026db54851080a6f73f3f4da6.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6217c9398e252f026db54851080a6f73f3f4da6.camel@linux.intel.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 10:01:47AM -0700, Tim Chen wrote:
> On Tue, 2022-03-15 at 12:31 -0300, Marcelo Tosatti wrote:
> > The logic to disable vmstat worker thread, when entering
> > nohz full, does not cover all scenarios. For example, it is possible
> > for the following to happen:
> > 
> > 1) enter nohz_full, which calls refresh_cpu_vm_stats, syncing the stats.
> > 2) app runs mlock, which increases counters for mlock'ed pages.
> > 3) start -RT loop
> > 
> > Since refresh_cpu_vm_stats from nohz_full logic can happen _before_
> > the mlock, vmstat shepherd can restart vmstat worker thread on
> > the CPU in question.
> > 
> > To fix this, add task isolation prctl interface to quiesce
> > deferred actions when returning to userspace.
> > 
> > The patchset is based on ideas and code from the
> > task isolation patchset from Alex Belits:
> > https://lwn.net/Articles/816298/
> > 
> > Please refer to Documentation/userspace-api/task_isolation.rst
> > (patch 1) for details. Its attached at the end of this message
> 
> Patch 1 doesn't seem to be the documentation patch but rather is
> in patch 4.

Hi Tim,

Yes, one might consider that awkward (but that order made sense when 
writing the patches).

Is there a different order that makes more sense?

> > 
> > Task isolation prctl interface
> > ******************************
> > 
> > Certain types of applications benefit from running uninterrupted by
> > background OS activities. Realtime systems and high-bandwidth
> > networking applications with user-space drivers can fall into the
> > category.
> > 
> > To create an OS noise free environment for the application, this
> > interface allows userspace to inform the kernel the start and end of
> > the latency sensitive application section (with configurable system
> > behaviour for that section).
> > 
> > Note: the prctl interface is independent of nohz_full=.
> > 
> > The prctl options are:
> > 
> >    * PR_ISOL_FEAT_GET: Retrieve supported features.
> > 
> >    * PR_ISOL_CFG_GET: Retrieve task isolation configuration.
> > 
> >    * PR_ISOL_CFG_SET: Set task isolation configuration.
> > 
> >    * PR_ISOL_ACTIVATE_GET: Retrieve task isolation activation state.
> > 
> >    * PR_ISOL_ACTIVATE_SET: Set task isolation activation state.
> > 
> > Summary of terms:
> > 
> > * feature:
> > 
> >      A distinct attribute or aspect of task isolation. Examples of
> >      features could be logging, new operating modes (eg: syscalls
> >      disallowed), userspace notifications, etc. The only feature
> >      currently available is quiescing.
> > 
> > * configuration:
> > 
> >      A specific choice from a given set of possible choices that
> >      dictate how the particular feature in question should behave.
> > 
> > * activation state:
> > 
> >      The activation state (whether active/inactive) of the task
> >      isolation features (features must be configured before being
> >      activated).
> > 
> > Inheritance of the isolation parameters and state, across fork(2) and
> > clone(2), can be changed via PR_ISOL_CFG_GET/PR_ISOL_CFG_SET.
> > 
> > At a high-level, task isolation is divided in two steps:
> > 
> > 1. Configuration.
> > 
> > 2. Activation.
> > 
> > Section "Userspace support" describes how to use task isolation.
> > 
> > In terms of the interface, the sequence of steps to activate task
> > isolation are:
> > 
> > 1. Retrieve supported task isolation features (PR_ISOL_FEAT_GET).
> > 
> > 2. Configure task isolation features
> >    (PR_ISOL_CFG_GET/PR_ISOL_CFG_SET).
> > 
> > 3. Activate or deactivate task isolation features
> >    (PR_ISOL_ACTIVATE_GET/PR_ISOL_ACTIVATE_SET).
> > 
> > This interface is based on ideas and code from the task isolation
> > patchset from Alex Belits: https://lwn.net/Articles/816298/
> > 
> > Note: if the need arises to configure an individual quiesce feature
> > with its own extensible structure, please add ISOL_F_QUIESCE_ONE to
> > PR_ISOL_CFG_GET/PR_ISOL_CFG_SET (ISOL_F_QUIESCE operates on multiple
> > features per syscall currently).
> > 
> > 
> > Feature description
> > ===================
> > 
> >    * "ISOL_F_QUIESCE"
> > 
> >    This feature allows quiescing selected kernel activities on return
> >    from system calls.
> > 
> > 
> > Interface description
> > =====================
> > 
> > **PR_ISOL_FEAT**:
> > 
> >    Returns the supported features and feature capabilities, as a
> >    bitmask:
> > 
> >       prctl(PR_ISOL_FEAT, feat, arg3, arg4, arg5);
> > 
> >    The 'feat' argument specifies whether to return supported features
> >    (if zero), or feature capabilities (if not zero). Possible values
> >    for 'feat' are:
> > 
> >    * "0":
> > 
> >         Return the bitmask of supported features, in the location
> >         pointed  to  by  "(int *)arg3". The buffer should allow space
> >         for 8 bytes.
> > 
> >    * "ISOL_F_QUIESCE":
> > 
> >         Return a structure containing which kernel activities are
> >         supported for quiescing, in the location pointed to by "(int
> >         *)arg3":
> > 
> >            struct task_isol_quiesce_extensions {
> >                    __u64 flags;
> >                    __u64 supported_quiesce_bits;
> >                    __u64 pad[6];
> >            };
> > 
> >         Where:
> > 
> >         *flags*: Additional flags (should be zero).
> > 
> >         *supported_quiesce_bits*: Bitmask indicating
> >            which features are supported for quiescing.
> > 
> >         *pad*: Additional space for future enhancements.
> > 
> >    Features and its capabilities are defined at
> >    include/uapi/linux/task_isolation.h.
> > 
> > **PR_ISOL_CFG_GET**:
> > 
> >    Retrieve task isolation configuration. The general format is:
> > 
> >       prctl(PR_ISOL_CFG_GET, what, arg3, arg4, arg5);
> > 
> >    The 'what' argument specifies what to configure. Possible values
> >    are:
> > 
> >    * "I_CFG_FEAT":
> > 
> >         Return configuration of task isolation features. The 'arg3'
> >         argument specifies whether to return configured features (if
> >         zero), or individual feature configuration (if not zero), as
> >         follows.
> > 
> >         * "0":
> > 
> >              Return the bitmask of configured features, in the
> >              location pointed  to  by  "(int *)arg4". The buffer
> >              should allow space for 8 bytes.
> > 
> >         * "ISOL_F_QUIESCE":
> > 
> >              If arg4 is QUIESCE_CONTROL, return the control structure
> >              for quiescing of background kernel activities, in the
> >              location pointed to by "(int *)arg5":
> > 
> >                 struct task_isol_quiesce_control {
> >                        __u64 flags;
> >                        __u64 quiesce_mask;
> >                        __u64 quiesce_oneshot_mask;
> >                        __u64 pad[5];
> >                 };
> > 
> >              See PR_ISOL_CFG_SET description for meaning of fields.
> > 
> >    * "I_CFG_INHERIT":
> > 
> >         Retrieve inheritance configuration across fork/clone.
> > 
> >         Return the structure which configures inheritance across
> >         fork/clone, in the location pointed to by "(int *)arg4":
> > 
> >            struct task_isol_inherit_control {
> >                    __u8    inherit_mask;
> >                    __u8    pad[7];
> >            };
> > 
> >         See PR_ISOL_CFG_SET description for meaning of fields.
> > 
> > **PR_ISOL_CFG_SET**:
> > 
> >    Set task isolation configuration. The general format is:
> > 
> >       prctl(PR_ISOL_CFG_SET, what, arg3, arg4, arg5);
> > 
> >    The 'what' argument specifies what to configure. Possible values
> >    are:
> > 
> >    * "I_CFG_FEAT":
> > 
> >         Set configuration of task isolation features. 'arg3' specifies
> >         the feature. Possible values are:
> > 
> >         * "ISOL_F_QUIESCE":
> 
> Is it really necessary for such fine grain control for which kernel
> activity to quiesce?  
> 
> For most user, all they care about is their
> task is not disturbed by kernel activities and not be bothered about
> setting which particular activities to quiesce.  And in your patches there
> is only ISOL_F_QUIESCE_VMSTATS and nothing else.  I think you could
> probably skip the QUIESCE control for now and add it when there's really
> a true need for fine grain control.  This will make the interface simpler
> for user applications.
> 
> Tim

Yes, this could be done (for example can maintain the current scheme,
add a way to query all supported features, enable them at chisol).
Then the application only has to be modified with:

This is a snippet of code to activate task isolation if
it has been previously configured (by chisol for example)::

        #include <sys/prctl.h>
        #include <linux/types.h>

        #ifdef PR_ISOL_CFG_GET
        unsigned long long fmask;

        ret = prctl(PR_ISOL_CFG_GET, I_CFG_FEAT, 0, &fmask, 0);
        if (ret != -1 && fmask != 0) {
                ret = prctl(PR_ISOL_ACTIVATE_SET, &fmask, 0, 0, 0);
                if (ret == -1) {
                        perror("prctl PR_ISOL_ACTIVATE_SET");
                        return ret;
                }
        }
        #endif

Or not modified at all (well not initially since support for executing
unmodified binaries will be dropped).








