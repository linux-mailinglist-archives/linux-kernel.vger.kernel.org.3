Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929D649E0F1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240381AbiA0Lbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiA0Lbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:31:43 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F230BC061714;
        Thu, 27 Jan 2022 03:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=B9zmfILtAtminki6w4+yjCQ5l4pbQADmPtKrAzTYH0w=; b=Twp1gVOJUcDy3nTRbzUSTOJtyl
        cj/wRD6XfneVeqBqoBdUFbF1rA2NzHL6nhAzXZ7JBjeP0KV3i6Z+C68ngWr7JJXvTNsY2CKuEB60U
        kRgLJ9TYHqJQKSzOwqnKDqHAXbAqUVOM25T+/HuE2ORpkthl6hjPIa37Arqu9M4FS6Tm5c+4Rp+i2
        iNc04hVgmrVg1nz6ENmcATFcC56qzXG7HK8vrF54OztD1YCxYbpyRQw6omjNzeKKwWPxjjw71kaUv
        vtS4sK2vs5UoSvQigZZynnhcfzC5Z50ePxR4isLVwIiRJxkQGdaTAYZmSfUxLSl7DJF0KSbn87xJu
        uxn9PERA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD2zp-0049P9-EN; Thu, 27 Jan 2022 11:31:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EF83D300268;
        Thu, 27 Jan 2022 12:31:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D512A201C21AE; Thu, 27 Jan 2022 12:31:18 +0100 (CET)
Date:   Thu, 27 Jan 2022 12:31:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Kyle Huey <me@kylehuey.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: [PATCH] x86/perf: Default freeze_on_smi on for Comet Lake and
 later.
Message-ID: <YfKChjX61OW4CkYm@hirez.programming.kicks-ass.net>
References: <20220122072644.92292-1-khuey@kylehuey.com>
 <878929bb-39e7-f1b1-a6a2-f6057517058f@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878929bb-39e7-f1b1-a6a2-f6057517058f@citrix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 02:22:23AM +0000, Andrew Cooper wrote:

> Frankly, it is an error that FREEZE_WHILE_SMM is under the kernels
> control, and not SMM's control.  After all, it's SMM handling all the
> UEFI secrets/etc.
> 
> Linux ought to set FREEZE_WHILE_SMM unilaterally, because most kernel
> profiling probably won't want interference from SMM.  Root can always
> disable FREEZE_WHILE_SMM if profiling is really wanted.
> 
> I'm not sure if anything can be done on pre-FREEZE_WHILE_SMM CPUs.  Nor
> AMD CPUs which are also gaining CPL3 SMM logic, and don't appear to have
> any equivalent functionality.

Which suggests something like this?

---
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c91434056c29..5874fa088630 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4703,6 +4703,19 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.lbr_read		= intel_pmu_lbr_read_64,
 	.lbr_save		= intel_pmu_lbr_save,
 	.lbr_restore		= intel_pmu_lbr_restore,
+
+	/*
+	 * SMM has access to all 4 rings and while traditionally SMM code only
+	 * ran in CPL0, newer firmware is starting to make use of CPL3 in SMM.
+	 *
+	 * Since the EVENTSEL.{USR,OS} CPL filtering makes no distinction
+	 * between SMM or not, this results in what should be pure userspace
+	 * counters including SMM data.
+	 *
+	 * This is a clear privilege issue, therefore globally disable
+	 * counting SMM by default.
+	 */
+	.attr_freeze_on_smi	= 1,
 };
 
 static __init void intel_clovertown_quirk(void)
