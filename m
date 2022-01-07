Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5243B4873AD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345042AbiAGHkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:40:47 -0500
Received: from mga07.intel.com ([134.134.136.100]:49043 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344827AbiAGHkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641541245; x=1673077245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rzUKGrIHlPEMqvM7zyx2deIcGLimwU2Ms3szre8ZO+g=;
  b=TnGrsqfhUO0oOtu9tMJco5Pv7bd6BvDKrE6KHvzYwWuJlhu+IYLB7mVG
   tUsX/hDzUMxkUL2WhSGYt4PDiUtp2VHGmTkSKn5X5+Ud/+5AoeeSHN+3v
   QX6FO7/Q18TRjLetaLN7oqk5YL3Ol4NWEt0/gZhBZV5eOKSj3NA/4lUyz
   i8Gfn66upgKwGRqkza41u6LIeeq3JZGKYsjhnr8oU3AShq9/57XlmubdG
   iqhSh0+0kFeEDi7rZThL/OkTLQKcGtq+r6XENigCR4rRKKJ9w6zdrP1r3
   VpcdzI9MMNbM7u7Nm0Z76PaY/YHo1+3jPT6a7wZwbBXU/zyqCY/mhcylv
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="306191849"
X-IronPort-AV: E=Sophos;i="5.88,269,1635231600"; 
   d="scan'208";a="306191849"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 23:40:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,269,1635231600"; 
   d="scan'208";a="471233079"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Jan 2022 23:40:44 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5jrf-000IQ5-T3; Fri, 07 Jan 2022 07:40:43 +0000
Date:   Fri, 7 Jan 2022 15:40:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH ammarfaizi2-block] EXP timers:
 __pcpu_scope_tick_setup_sched_timer_help_needed can be static
Message-ID: <20220107074006.GA18912@089a6aeb832b>
References: <202201071509.qlXBeLQz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201071509.qlXBeLQz-lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/time/tick-sched.c:1453:1: warning: symbol '__pcpu_scope_tick_setup_sched_timer_help_needed' was not declared. Should it be static?

Fixes: 3cda34a0004e ("EXP timers: Non-nohz_full last-resort jiffies update on IRQ entry")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 tick-sched.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 8790cd4834887c..1af62743be63e8 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1450,7 +1450,7 @@ early_param("skew_tick", skew_tick);
 
 static DEFINE_PER_CPU(unsigned long, tick_setup_sched_timer_jiffies);
 static DEFINE_PER_CPU(int, tick_setup_sched_timer_jiffies_count);
-DEFINE_PER_CPU(bool, tick_setup_sched_timer_help_needed);
+static DEFINE_PER_CPU(bool, tick_setup_sched_timer_help_needed);
 
 /**
  * tick_setup_sched_timer - setup the tick emulation timer
