Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD9149CBC9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241918AbiAZOFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbiAZOFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:05:03 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AB9C06161C;
        Wed, 26 Jan 2022 06:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LDOLYM2UfrQAiWJ+eM2UXKMwCeFJxxfa8YNvPPKmDCc=; b=ELrBa3qC7jTSTLpOImhQz3dzEz
        K5WpZ/YZNRUQTA5GRRhG6YiSdHMRVkodurb0Am0X6SmfvxxM4e30HzzO0Bq+Eya4Z4YKZsqyZnHRq
        WUbgL69McwYa9JEsI5oTYalj84FVvlFriG5wyGGcjvvUqF3QFnjgJERnCaHSyuuX1VWvdDmH9ubgF
        fJKVKswc9GsTI7CfyMfotquwNpIzpjlt+9i2tvGaowEnY0/GTHW4z87fV/3J6mP9njzNubFGlAfz7
        fq2jpcbaKAgrY6uR1AMaqLdZfQnwioMKBvnr6oeatrRB6eM1WA2W2FyfS5VrAE1X84P7KWS611JLB
        HGQIVHaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCiuj-003os7-UP; Wed, 26 Jan 2022 14:04:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 501733002C5;
        Wed, 26 Jan 2022 15:04:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E9FC72B36E787; Wed, 26 Jan 2022 15:04:43 +0100 (CET)
Date:   Wed, 26 Jan 2022 15:04:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Kyle Huey <me@kylehuey.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
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
        Keno Fischer <keno@juliacomputing.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86/perf: Default freeze_on_smi on for Comet Lake and
 later.
Message-ID: <YfFU+2nMjEC1Mo3m@hirez.programming.kicks-ass.net>
References: <20220122072644.92292-1-khuey@kylehuey.com>
 <Ye6Z31keWVPrsNWU@hirez.programming.kicks-ass.net>
 <3c35dc76-c187-8d3f-7fc9-75de32e7cbf6@linux.intel.com>
 <CAP045ArbX7cYKyv0H4X2SxUJWycB1VoLZWLME=_RXttBFBfP3A@mail.gmail.com>
 <7ef1bf66-4184-7f5b-c0bd-351ec743d4e9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ef1bf66-4184-7f5b-c0bd-351ec743d4e9@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 08:57:09AM -0500, Liang, Kan wrote:
> I see. I was thought the unprivileged user can observe the SMM code on the
> previous platforms. The CML+ change only makes part of the SMM code CPL0.
> Seems I'm wrong. The change looks like changing the previous CPL0 code to
> CPL3 code. If so, yes, I think we should prevent the information leaks for
> the unprivileged user.

Right.

> Changing it to all platforms seems a too big hammer. I agree we should limit
> it to the impacted platforms.
> 
> I've contacted the author of the white paper. I was told that the change is
> for the client vPro platforms. They are not sure whether it impacts Server
> platform or Atom platforms. I'm still working on it. I will let you and
> Peter know once I get more information.

For now I've updated the patch as per the below. I'm tempted to simply
apply it as is and let it be.

Having different defaults for vPro vs !vPro chips seems more confusing
than not.

We should also very much get this change reverted for future chips.

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6094,6 +6094,16 @@ __init int intel_pmu_init(void)
 			x86_pmu.commit_scheduling = intel_tfa_commit_scheduling;
 		}
 
+		if (boot_cpu_data.x86_model == INTEL_FAM6_COMETLAKE_L ||
+		    boot_cpu_data.x86_model == INTEL_FAM6_COMETLAKE) {
+			/*
+			 * For some idiotic reason SMM is visible to USR
+			 * counters. Since this is a privilege issue, default
+			 * disable counters in SMM for these chips.
+			 */
+			x86_pmu.attr_freeze_on_smi = 1;
+		}
+
 		pr_cont("Skylake events, ");
 		name = "skylake";
 		break;
@@ -6135,6 +6145,8 @@ __init int intel_pmu_init(void)
 		x86_pmu.num_topdown_events = 4;
 		x86_pmu.update_topdown_event = icl_update_topdown_event;
 		x86_pmu.set_topdown_event_period = icl_set_topdown_event_period;
+		/* SMM visible in USR, see above */
+		x86_pmu.attr_freeze_on_smi = 1;
 		pr_cont("Icelake events, ");
 		name = "icelake";
 		break;
@@ -6172,6 +6184,8 @@ __init int intel_pmu_init(void)
 		x86_pmu.num_topdown_events = 8;
 		x86_pmu.update_topdown_event = icl_update_topdown_event;
 		x86_pmu.set_topdown_event_period = icl_set_topdown_event_period;
+		/* SMM visible in USR, see above */
+		x86_pmu.attr_freeze_on_smi = 1;
 		pr_cont("Sapphire Rapids events, ");
 		name = "sapphire_rapids";
 		break;
@@ -6217,6 +6231,8 @@ __init int intel_pmu_init(void)
 		 * x86_pmu.rtm_abort_event.
 		 */
 		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xc9, .umask=0x04);
+		/* SMM visible in USR, see above */
+		x86_pmu.attr_freeze_on_smi = 1;
 
 		td_attr = adl_hybrid_events_attrs;
 		mem_attr = adl_hybrid_mem_attrs;
