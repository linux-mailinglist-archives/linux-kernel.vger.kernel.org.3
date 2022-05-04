Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E154551ABE5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 19:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376338AbiEDRyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 13:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356619AbiEDRST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 13:18:19 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04CF4990E
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 10:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651683709; x=1683219709;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2WrdM+/HAHfwQ7ZhweduXwegvWW0ZYY0fbEWdpuIFuQ=;
  b=LpJ1lc7YG4h4nyUyc5aQm6H9+rbcd/NCYnWhl2T/QpRdGPsFK3c5W8M9
   QE6bGyNdhFzvI/Gxx/v9tSPHvUFMSlVqe3Ce30Ca7E8vM6pqwYnwTKObz
   RQNjPkZbJFfjtQLp5R/BI4DyLfx47AgsOZ9TTeJI9dCuupXwm3unQ4ayM
   fIKKEBnKXE0HCPr2yYM8mvrmopL3HxhW/5mcxkqJ6sEP++4XPjOOyXjud
   HVzS3zePssAWn8Ye7WJcIMaQHihoTssGfWkgQz5n4zp7J3CxYN6fiX/BW
   PpL0sIxBWDrazSFR06S8oSNSlBzDYQjnbl45YQXXLBK/haBFEJms+siRg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="267980578"
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="267980578"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 10:01:48 -0700
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="548930357"
Received: from schen9-mobl.amr.corp.intel.com ([10.212.140.240])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 10:01:47 -0700
Message-ID: <f6217c9398e252f026db54851080a6f73f3f4da6.camel@linux.intel.com>
Subject: Re: [patch v12 00/13] extensible prctl task isolation interface and
 vmstat sync
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>
Date:   Wed, 04 May 2022 10:01:47 -0700
In-Reply-To: <20220315153132.717153751@fedora.localdomain>
References: <20220315153132.717153751@fedora.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-03-15 at 12:31 -0300, Marcelo Tosatti wrote:
> The logic to disable vmstat worker thread, when entering
> nohz full, does not cover all scenarios. For example, it is possible
> for the following to happen:
> 
> 1) enter nohz_full, which calls refresh_cpu_vm_stats, syncing the stats.
> 2) app runs mlock, which increases counters for mlock'ed pages.
> 3) start -RT loop
> 
> Since refresh_cpu_vm_stats from nohz_full logic can happen _before_
> the mlock, vmstat shepherd can restart vmstat worker thread on
> the CPU in question.
> 
> To fix this, add task isolation prctl interface to quiesce
> deferred actions when returning to userspace.
> 
> The patchset is based on ideas and code from the
> task isolation patchset from Alex Belits:
> https://lwn.net/Articles/816298/
> 
> Please refer to Documentation/userspace-api/task_isolation.rst
> (patch 1) for details. Its attached at the end of this message

Patch 1 doesn't seem to be the documentation patch but rather is
in patch 4.

> 
> Task isolation prctl interface
> ******************************
> 
> Certain types of applications benefit from running uninterrupted by
> background OS activities. Realtime systems and high-bandwidth
> networking applications with user-space drivers can fall into the
> category.
> 
> To create an OS noise free environment for the application, this
> interface allows userspace to inform the kernel the start and end of
> the latency sensitive application section (with configurable system
> behaviour for that section).
> 
> Note: the prctl interface is independent of nohz_full=.
> 
> The prctl options are:
> 
>    * PR_ISOL_FEAT_GET: Retrieve supported features.
> 
>    * PR_ISOL_CFG_GET: Retrieve task isolation configuration.
> 
>    * PR_ISOL_CFG_SET: Set task isolation configuration.
> 
>    * PR_ISOL_ACTIVATE_GET: Retrieve task isolation activation state.
> 
>    * PR_ISOL_ACTIVATE_SET: Set task isolation activation state.
> 
> Summary of terms:
> 
> * feature:
> 
>      A distinct attribute or aspect of task isolation. Examples of
>      features could be logging, new operating modes (eg: syscalls
>      disallowed), userspace notifications, etc. The only feature
>      currently available is quiescing.
> 
> * configuration:
> 
>      A specific choice from a given set of possible choices that
>      dictate how the particular feature in question should behave.
> 
> * activation state:
> 
>      The activation state (whether active/inactive) of the task
>      isolation features (features must be configured before being
>      activated).
> 
> Inheritance of the isolation parameters and state, across fork(2) and
> clone(2), can be changed via PR_ISOL_CFG_GET/PR_ISOL_CFG_SET.
> 
> At a high-level, task isolation is divided in two steps:
> 
> 1. Configuration.
> 
> 2. Activation.
> 
> Section "Userspace support" describes how to use task isolation.
> 
> In terms of the interface, the sequence of steps to activate task
> isolation are:
> 
> 1. Retrieve supported task isolation features (PR_ISOL_FEAT_GET).
> 
> 2. Configure task isolation features
>    (PR_ISOL_CFG_GET/PR_ISOL_CFG_SET).
> 
> 3. Activate or deactivate task isolation features
>    (PR_ISOL_ACTIVATE_GET/PR_ISOL_ACTIVATE_SET).
> 
> This interface is based on ideas and code from the task isolation
> patchset from Alex Belits: https://lwn.net/Articles/816298/
> 
> Note: if the need arises to configure an individual quiesce feature
> with its own extensible structure, please add ISOL_F_QUIESCE_ONE to
> PR_ISOL_CFG_GET/PR_ISOL_CFG_SET (ISOL_F_QUIESCE operates on multiple
> features per syscall currently).
> 
> 
> Feature description
> ===================
> 
>    * "ISOL_F_QUIESCE"
> 
>    This feature allows quiescing selected kernel activities on return
>    from system calls.
> 
> 
> Interface description
> =====================
> 
> **PR_ISOL_FEAT**:
> 
>    Returns the supported features and feature capabilities, as a
>    bitmask:
> 
>       prctl(PR_ISOL_FEAT, feat, arg3, arg4, arg5);
> 
>    The 'feat' argument specifies whether to return supported features
>    (if zero), or feature capabilities (if not zero). Possible values
>    for 'feat' are:
> 
>    * "0":
> 
>         Return the bitmask of supported features, in the location
>         pointed  to  by  "(int *)arg3". The buffer should allow space
>         for 8 bytes.
> 
>    * "ISOL_F_QUIESCE":
> 
>         Return a structure containing which kernel activities are
>         supported for quiescing, in the location pointed to by "(int
>         *)arg3":
> 
>            struct task_isol_quiesce_extensions {
>                    __u64 flags;
>                    __u64 supported_quiesce_bits;
>                    __u64 pad[6];
>            };
> 
>         Where:
> 
>         *flags*: Additional flags (should be zero).
> 
>         *supported_quiesce_bits*: Bitmask indicating
>            which features are supported for quiescing.
> 
>         *pad*: Additional space for future enhancements.
> 
>    Features and its capabilities are defined at
>    include/uapi/linux/task_isolation.h.
> 
> **PR_ISOL_CFG_GET**:
> 
>    Retrieve task isolation configuration. The general format is:
> 
>       prctl(PR_ISOL_CFG_GET, what, arg3, arg4, arg5);
> 
>    The 'what' argument specifies what to configure. Possible values
>    are:
> 
>    * "I_CFG_FEAT":
> 
>         Return configuration of task isolation features. The 'arg3'
>         argument specifies whether to return configured features (if
>         zero), or individual feature configuration (if not zero), as
>         follows.
> 
>         * "0":
> 
>              Return the bitmask of configured features, in the
>              location pointed  to  by  "(int *)arg4". The buffer
>              should allow space for 8 bytes.
> 
>         * "ISOL_F_QUIESCE":
> 
>              If arg4 is QUIESCE_CONTROL, return the control structure
>              for quiescing of background kernel activities, in the
>              location pointed to by "(int *)arg5":
> 
>                 struct task_isol_quiesce_control {
>                        __u64 flags;
>                        __u64 quiesce_mask;
>                        __u64 quiesce_oneshot_mask;
>                        __u64 pad[5];
>                 };
> 
>              See PR_ISOL_CFG_SET description for meaning of fields.
> 
>    * "I_CFG_INHERIT":
> 
>         Retrieve inheritance configuration across fork/clone.
> 
>         Return the structure which configures inheritance across
>         fork/clone, in the location pointed to by "(int *)arg4":
> 
>            struct task_isol_inherit_control {
>                    __u8    inherit_mask;
>                    __u8    pad[7];
>            };
> 
>         See PR_ISOL_CFG_SET description for meaning of fields.
> 
> **PR_ISOL_CFG_SET**:
> 
>    Set task isolation configuration. The general format is:
> 
>       prctl(PR_ISOL_CFG_SET, what, arg3, arg4, arg5);
> 
>    The 'what' argument specifies what to configure. Possible values
>    are:
> 
>    * "I_CFG_FEAT":
> 
>         Set configuration of task isolation features. 'arg3' specifies
>         the feature. Possible values are:
> 
>         * "ISOL_F_QUIESCE":

Is it really necessary for such fine grain control for which kernel
activity to quiesce?  

For most user, all they care about is their
task is not disturbed by kernel activities and not be bothered about
setting which particular activities to quiesce.  And in your patches there
is only ISOL_F_QUIESCE_VMSTATS and nothing else.  I think you could
probably skip the QUIESCE control for now and add it when there's really
a true need for fine grain control.  This will make the interface simpler
for user applications.

Tim





