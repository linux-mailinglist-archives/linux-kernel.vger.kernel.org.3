Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B44E51C826
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345854AbiEESm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383127AbiEESmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:42:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FE766FAE;
        Thu,  5 May 2022 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651775526; x=1683311526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qIOFndILJT/RTQCAijUPdDLm6tWk5rI8wqnqOSA8lFw=;
  b=SsHNPhOK4Q6OjfRtOJQRD5vplIv4ZjZEDSdlPiH8NBi5My9/z5WLISWo
   2VcSqEwqM+AT4soZAlXbK8XnoUOaG1ddRX+sRlRJduRnCv2tt7Ql+7p9y
   VL1jHqvG0Nqe1aq7ThZkUrImG8p0QK8hQ76Ay25HqhhOf98JmUm/ImoBL
   tX7s+/BoHYeDrmQ6+fpjK8cbxY1vCg1/BuBs2EpCDQZzcyewm9xmf2Rg7
   qUm+TD02FXCk6HKsGHtuC3pAHLCJEIXPmleLiZhVozSmBlEb3DXaRMUYX
   OeCyD854RHRQFzVQM7XV9T68ucXqR0fcTCbuzL604dyt9MDJGxO48Pzlc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="265807023"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="265807023"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 11:32:06 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="621427891"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 11:32:05 -0700
Date:   Thu, 5 May 2022 11:32:04 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, hdegoede@redhat.com,
        markgross@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH v5 07/10] platform/x86/intel/ifs: Add scan test support
Message-ID: <YnQYJIVC0scuL7D7@agluck-desk3.sc.intel.com>
References: <20220422200219.2843823-1-tony.luck@intel.com>
 <20220428153849.295779-1-tony.luck@intel.com>
 <20220428153849.295779-8-tony.luck@intel.com>
 <87r159jxaq.ffs@tglx>
 <YnLLekoripdY2oQU@agluck-desk3.sc.intel.com>
 <87tua4j3es.ffs@tglx>
 <20220505082824.GD2501@worktop.programming.kicks-ass.net>
 <87bkwcic9k.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkwcic9k.ffs@tglx>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 11:01:27AM +0200, Thomas Gleixner wrote:
> On Thu, May 05 2022 at 10:28, Peter Zijlstra wrote:
> > On Thu, May 05, 2022 at 01:15:07AM +0200, Thomas Gleixner wrote:
> >> We don't have stomp_cpumask() today, but that's trivial enough to
> >> implement.
> >
> > I don't think we want to gift people a random cpumask stop_machine(),
> 
> Fair enough.
> 
> > but here's one that stops a core. It runs the @fn on every cpu since I
> > thought to have understood that was the requirement for this muck.
> 
> Yes.
> 
> > *completely* untestededed.
> 
> Looks about right neverthelessesseess.

Close enough. I made these changes:

1) Added EXPORT_SYMBOL_GPL()
2) Added protoype in <linux/stop_machine.h>
3) Moved the kerneldoc comment to the header (for some reason
   the other stop* functions document there).
4) Edited that kerneldoc a bit <<<< NEEDS REVIEW  >>>
5) Changed a ';' to a ',' to make it compile.

With that it works, and will do exactly what I need (with less code
in the IFS driver by the look of things).

A couple of thousand tests shows it works. The two threads
arrive within 20 TSC cycles of each other 60% of the time,
but I have some outliers up to 654 cycles ... which is plenty
close enough.

Patch now looks like this. Author credit to Peter ... are you willing
to add a Signed-off-by to stop checkpatch from whining at me?

There isn't a "Something-similar-suggested-by:" tag to credit Thomas
with this.  Perhaps "Inspired-by:"?

-Tony


From df5ca8024997d3d782978d154cfbff5147f451ad Mon Sep 17 00:00:00 2001
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 5 May 2022 08:55:09 -0700
Subject: [PATCH] stop_machine: Add stop_core_cpuslocked() for per-core
 operations

Hardware core level testing features require near simultaneous execution
of WRMSR instructions on all threads of a core to initiate a test.

Provide a customized cut down version of stop_machine_cpuslocked() that
just operates on the threads of a single core.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/stop_machine.h | 16 ++++++++++++++++
 kernel/stop_machine.c        | 19 +++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
index 46fb3ebdd16e..ea7a74ea7389 100644
--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -124,6 +124,22 @@ int stop_machine(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus);
  */
 int stop_machine_cpuslocked(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus);
 
+/**
+ * stop_core_cpuslocked: - stop all threads on just one core
+ * @cpu: any cpu in the targeted core
+ * @fn: the function to run
+ * @data: the data ptr for @fn()
+ *
+ * Same as above, but instead of every CPU, only the logical CPUs of a
+ * single core are affected.
+ *
+ * Context: Must be called from within a cpus_read_lock() protected region.
+ *
+ * Return: 0 if all executions of @fn returned 0, any non zero return
+ * value if any returned non zero.
+ */
+int stop_core_cpuslocked(unsigned int cpu, cpu_stop_fn_t fn, void *data);
+
 int stop_machine_from_inactive_cpu(cpu_stop_fn_t fn, void *data,
 				   const struct cpumask *cpus);
 #else	/* CONFIG_SMP || CONFIG_HOTPLUG_CPU */
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index cbc30271ea4d..579761729836 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -633,6 +633,25 @@ int stop_machine(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus)
 }
 EXPORT_SYMBOL_GPL(stop_machine);
 
+int stop_core_cpuslocked(unsigned int cpu, cpu_stop_fn_t fn, void *data)
+{
+	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
+
+	struct multi_stop_data msdata = {
+		.fn = fn,
+		.data = data,
+		.num_threads = cpumask_weight(smt_mask),
+		.active_cpus = smt_mask,
+	};
+
+	lockdep_assert_cpus_held();
+
+	/* Set the initial state and stop all online cpus. */
+	set_state(&msdata, MULTI_STOP_PREPARE);
+	return stop_cpus(smt_mask, multi_cpu_stop, &msdata);
+}
+EXPORT_SYMBOL_GPL(stop_core_cpuslocked);
+
 /**
  * stop_machine_from_inactive_cpu - stop_machine() from inactive CPU
  * @fn: the function to run
-- 
2.35.1

