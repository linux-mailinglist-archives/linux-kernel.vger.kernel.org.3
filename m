Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B9F51BA6A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349028AbiEEIct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348951AbiEEIco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:32:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A205E366BE;
        Thu,  5 May 2022 01:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=we+pAHqfCL1HrPHWKdp8u/GbNSzdRAevWAngCc03fN8=; b=TVABNaAxngnB0uwZp5oPcegIj+
        9eBlOfM5JnxFBnJVZyaha8SVflbybX2X7+bHwaS2M8O8eAyllYorc1XsoLyq4rwePjIB//4SdoMNz
        iscl0WZuQnSaGdBkeescihMp0NoPl5QmMgq/VFCwkG5K1KtXNbmg9aHaf6aOZP6zl7hpLfwJtLxm1
        pBwHgLYVaWbd8AkW3CGiEiP8jgGlqvE2rCbDCGLPBJ/GlrclNDinHAsNUqh6NoPtnyr9SeqNFlGOZ
        mn1MQRQhSGsVJ6WD5v4BOpfODZ/TAOv9zkWa3OBGadLaITiw3sxaVnAyGBcsxM9Oy5qik39RPiYxY
        SDHAfmuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmWqY-00BJut-Ai; Thu, 05 May 2022 08:28:26 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 42061980FA2; Thu,  5 May 2022 10:28:24 +0200 (CEST)
Date:   Thu, 5 May 2022 10:28:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH v5 07/10] platform/x86/intel/ifs: Add scan test support
Message-ID: <20220505082824.GD2501@worktop.programming.kicks-ass.net>
References: <20220422200219.2843823-1-tony.luck@intel.com>
 <20220428153849.295779-1-tony.luck@intel.com>
 <20220428153849.295779-8-tony.luck@intel.com>
 <87r159jxaq.ffs@tglx>
 <YnLLekoripdY2oQU@agluck-desk3.sc.intel.com>
 <87tua4j3es.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tua4j3es.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 01:15:07AM +0200, Thomas Gleixner wrote:
> We don't have stomp_cpumask() today, but that's trivial enough to
> implement.

I don't think we want to gift people a random cpumask stop_machine(),
but here's one that stops a core. It runs the @fn on every cpu since I
thought to have understood that was the requirement for this muck.

*completely* untestededed.

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 6da7b91af353..2e7324e44e38 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -631,6 +631,34 @@ int stop_machine(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus)
 }
 EXPORT_SYMBOL_GPL(stop_machine);
 
+/*
+ * stop_core_cpuslocked - stop_machine a core
+ * @cpu: any cpu in the targeted core
+ * @fn: the function to run
+ * @data: the data ptr for @fn()
+ *
+ * RETURNS:
+ * 0 if all executions of @fn returned 0, any non zero return value if any
+ * returned non zero.
+ */
+int stop_core_cpuslocked(unsigned int cpu, cpu_stop_fn_t fn, void *data)
+{
+	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
+
+	struct multi_stop_data msdata = {
+		.fn = fn,
+		.data = data,
+		.num_threads = cpumask_weight(smt_mask);
+		.active_cpus = smt_mask,
+	};
+
+	lockdep_assert_cpus_held();
+
+	/* Set the initial state and stop all online cpus. */
+	set_state(&msdata, MULTI_STOP_PREPARE);
+	return stop_cpus(smt_mask, multi_cpu_stop, &msdata);
+}
+
 /**
  * stop_machine_from_inactive_cpu - stop_machine() from inactive CPU
  * @fn: the function to run
