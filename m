Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12D94A32F9
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 02:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353615AbiA3BHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 20:07:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:11829 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232795AbiA3BHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 20:07:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643504842; x=1675040842;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=HAtiV9xYaZQgR7COoOn8hvU9x5+DlnyBUlJJ0ycfjXE=;
  b=W3gWegH3kfSl8Ck5HF77kSjBi5o7dhKR7Rh95gzsPNnFi57YEBjAyp2N
   u6bNWAVqs1ENqas8tTm31qY3RRVB5UNtr8ruHqT7RSV3VN+0NtWvuF97O
   ZgeHEG7dyhzncq2ZJcIy0/6BqnA63SpK4akqMmpbS8blim2oxdj8BM0i5
   VZxrMW6qyz++dOjF4S8485S5T7dIXs5CqD2pDaTBlqc8wh5e1sxUTojLF
   bwyqynbtg69yFISou4fpFWlJmzNcWokOT2rZuLcEH6/yagVSTXJlHJ5oV
   +/9oTK4RYT0nQR41AwD6sc7retl5CTQyyVB3pvGs+u0g3hpMC/5/A32fk
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="247256806"
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="247256806"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 17:07:21 -0800
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="582235464"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 17:07:19 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@surriel.com>
Subject: Re: [RFC PATCH 1/2] NUMA balancing: fix NUMA topology type for
 memory tiering system
References: <20220128023842.1946583-1-ying.huang@intel.com>
        <20220128052345.GA618915@linux.vnet.ibm.com>
        <87czkctiz9.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <YfQIMmbY7nHusQRK@hirez.programming.kicks-ass.net>
Date:   Sun, 30 Jan 2022 09:07:17 +0800
In-Reply-To: <YfQIMmbY7nHusQRK@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Fri, 28 Jan 2022 16:13:54 +0100")
Message-ID: <87sft6rpyy.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Fri, Jan 28, 2022 at 03:30:50PM +0800, Huang, Ying wrote:
>> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
>> 
>> > * Huang Ying <ying.huang@intel.com> [2022-01-28 10:38:41]:
>> >
>> >> 
>> >> One possible fix is to ignore CPU-less nodes when detecting NUMA
>> >> topology type in init_numa_topology_type().  That works well for the
>> >> example system.  Is it good in general for any system with CPU-less
>> >> nodes?
>> >> 
>> >
>> > A CPUless node at the time online doesn't necessarily mean a CPUless node
>> > for the entire boot. For example: On PowerVM Lpars, aka powerpc systems,
>> > some of the nodes may start as CPUless nodes and then CPUS may get
>> > populated/hotplugged on them.
>> 
>> Got it!
>> 
>> > Hence I am not sure if adding a check for CPUless nodes at node online may
>> > work for such systems.
>> 
>> How about something as below?
>
> I'm thinking that might not be enough in that scenario; if we're going
> to consistently skip CPU-less nodes (as I really think we should) then
> __sched_domains_numa_masks_set() is not sufficient for the hotplug case
> since sched_domains_numa_levels and sched_max_numa_distance can also
> change.
>
> This means we need to re-do more of sched_init_numa() and possibly
> re-alloc some of those arrays etc..
>
> Same for offline ofc.

Got it!  It doesn't make sense to create schedule domains for CPU-less
nodes.  I can work on this after Chinese New Year holiday week (the
whole next week).  But if anyone want to work on this, feel free to do
that.

Best Regards,
Huang, Ying
