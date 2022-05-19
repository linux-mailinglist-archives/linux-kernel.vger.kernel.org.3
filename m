Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558B852D3F7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238800AbiESN3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbiESN3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:29:51 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FD1B0419
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 06:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652966990; x=1684502990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+QZKUutU69n8P+AnNReePdXFjDWKleNIDXE7z/OhEyY=;
  b=RxEZzsxNcABn9D9MKhZCLBQ+cjXT66Abwr92mNyKDkF9jUQpi1kD58DC
   qOPJ1QxwQkU0QtUhGvFAknMkiSoa7QVdc47xTlahOH3T3nQtUz3/LS29g
   re+aBx7i5h+vovNNiJ3/Pk1CZFpMdvmQSC3ceEaIL1RZsmw05jJ30tcyU
   M=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 19 May 2022 06:29:50 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 06:29:49 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 19 May 2022 06:29:49 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 19 May
 2022 06:29:48 -0700
Date:   Thu, 19 May 2022 09:29:45 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, <kafai@fb.com>,
        <kpsingh@kernel.org>
Subject: Re: [PATCH 0/6] Drain remote per-cpu directly v3
Message-ID: <YoZGSd6yQL3EP8tk@qian>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
 <20220517233507.GA423@qian>
 <20220518125152.GQ3441@techsingularity.net>
 <YoUealVA1bMaSH2l@qian>
 <20220518171503.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220518171503.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 10:15:03AM -0700, Paul E. McKenney wrote:
> So does this python script somehow change the tracing state?  (It does
> not look to me like it does, but I could easily be missing something.)

No, I don't think so either. It pretty much just offline memory sections
one at a time.

> Either way, is there something else waiting for these RCU flavors?
> (There should not be.)  Nevertheless, if so, there should be
> a synchronize_rcu_tasks(), synchronize_rcu_tasks_rude(), or
> synchronize_rcu_tasks_trace() on some other blocked task's stack
> somewhere.

There are only three blocked tasks when this happens. The kmemleak_scan()
is just the victim waiting for the locks taken by the stucking
offline_pages()->synchronize_rcu() task.

 task:kmemleak        state:D stack:25824 pid: 1033 ppid:     2 flags:0x00000008
 Call trace:
  __switch_to
  __schedule
  schedule
  percpu_rwsem_wait
  __percpu_down_read
  percpu_down_read.constprop.0
  get_online_mems
  kmemleak_scan
  kmemleak_scan_thread
  kthread
  ret_from_fork

 task:cppc_fie        state:D stack:23472 pid: 1848 ppid:     2 flags:0x00000008
 Call trace:
  __switch_to
  __schedule
  lockdep_recursion

 task:tee             state:D stack:24816 pid:16733 ppid: 16732 flags:0x0000020c
 Call trace:
  __switch_to
  __schedule
  schedule
  schedule_timeout
  __wait_for_common
  wait_for_completion
  __wait_rcu_gp
  synchronize_rcu
  lru_cache_disable
  __alloc_contig_migrate_range
  isolate_single_pageblock
  start_isolate_page_range
  offline_pages
  memory_subsys_offline
  device_offline
  online_store
  dev_attr_store
  sysfs_kf_write
  kernfs_fop_write_iter
  new_sync_write
  vfs_write
  ksys_write
  __arm64_sys_write
  invoke_syscall
  el0_svc_common.constprop.0
  do_el0_svc
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync
 
> Or maybe something sleeps waiting for an RCU Tasks * callback to
> be invoked.  In that case (and in the above case, for that matter),
> at least one of these pointers would be non-NULL on some CPU:
> 
> 1.	rcu_tasks__percpu.cblist.head
> 2.	rcu_tasks_rude__percpu.cblist.head
> 3.	rcu_tasks_trace__percpu.cblist.head
> 
> The ->func field of the pointed-to structure contains a pointer to
> the callback function, which will help work out what is going on.
> (Most likely a wakeup being lost or not provided.)

What would be some of the easy ways to find out those? I can't see anything
interesting from the output of sysrq-t.

> Alternatively, if your system has hundreds of thousands of tasks and
> you have attached BPF programs to short-lived socket structures and you
> don't yet have the workaround, then you can see hangs.  (I am working on a
> longer-term fix.)  In the short term, applying the workaround is the right
> thing to do.  (Adding a couple of the BPF guys on CC for their thoughts.)

The system is pretty much idle after a fresh reboot. The only workload is
to run the script.
