Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A9C496A96
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 08:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiAVH0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 02:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiAVH0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 02:26:49 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AC6C06173D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 23:26:48 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id e9so10130579pgb.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 23:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2+Hv7nAmqViSixp8vVAFUuKJDivxF+KK0jrhpTa6c7s=;
        b=AaWlQXmwnIn0izQMh7HbIzWqQn9YU3IXrx/8d+P8wFclpuLDUP3IdeE0kja+rMmxMW
         tdc/np4CoY+1v5XT44xDYpDj1nWAj847k6yxmIvtNiVw+YJGWwhwvXeV09IywTB0YRKI
         6qTuaL7qKgPVWltthxHySCGP/A39cI5ABBcm2zNBZbC6dr6oLmu+/n6T+kNIonuaoDLC
         ReajfP/irsSqSpvgd7FKhrZmfQqZcOalgUWmcBjoXvQi9cJ+iUtwysTi5mqU4V3BstbS
         xeqoq1OLu8cC6BrgKEG4esonnAwFZ5qtAblPAa+k2jo6ZDWwPD+w++yPx50MN4Fgk3nM
         bWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2+Hv7nAmqViSixp8vVAFUuKJDivxF+KK0jrhpTa6c7s=;
        b=3PnY1LKgHE28kp06sTAE0n2LKoZs+HxPdVgAqEz45KcCkyuVO5aDXJLE2rGmSbRPTx
         ogRzQCaX/oy3vTOPt2LOqKqTKQ40iWh3dyjtNmlIMZnybKzAiJCXmjA8Vk8f3vC3aM5P
         1zAOUfRe1SHuXtKU4prH6bWJ3TySR2pesXwx2qtcWu1GqNUxExFbidQyz2Gd2S0Np3LA
         NopT/0SAXtev9ncuCn21WF85e+q4SGZeVKUVjjg6O6ZrHaTzHnOeU4f9A7KnTCkXmCv6
         sOZ/zEhJ9YkL+K5WhQDzMWHsuMWTa0jcjmDFnr5q/9CNZi6DeEjNLaEsZUmZ0OSL9hpc
         OXKw==
X-Gm-Message-State: AOAM532GXJv3sxLSWR+UuZR/Q+Y8xTVcJst5ewt1F+M7xujA+Eq9QyJv
        z+JqGVt8lvIIV5vGz4gFMN29EBp827URDXP7
X-Google-Smtp-Source: ABdhPJxzIqqKPFECARlzx5DZ2EH8C2YoWJnDwNBqg6RbLNn8ZCs+7KlelNxxUL4AyLvDIVDpvZsDRA==
X-Received: by 2002:a63:2362:: with SMTP id u34mr5336495pgm.441.1642836407936;
        Fri, 21 Jan 2022 23:26:47 -0800 (PST)
Received: from minbar.home.kylehuey.com (c-71-198-251-229.hsd1.ca.comcast.net. [71.198.251.229])
        by smtp.gmail.com with ESMTPSA id b12sm9348994pfv.148.2022.01.21.23.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 23:26:47 -0800 (PST)
From:   Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To:     linux-kernel@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>
Cc:     linux-perf-users@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert O'Callahan <rocallahan@gmail.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: [PATCH] x86/perf: Default freeze_on_smi on for Comet Lake and later.
Date:   Fri, 21 Jan 2022 23:26:44 -0800
Message-Id: <20220122072644.92292-1-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beginning in Comet Lake, Intel extended the concept of privilege rings to
SMM.[0] A side effect of this is that events caused by execution of code
in SMM are now visible to performance counters with IA32_PERFEVTSELx.USR
set.

rr[1] depends on exact counts of performance events for the user space
tracee, so this change in behavior is fatal for us. It is, however, easily
corrected by setting IA32_DEBUGCTL.FREEZE_WHILE_SMM to 1 (visible in sysfs
as /sys/devices/cpu/freeze_on_smi). While we can and will tell our users to
set freeze_on_smi manually when appropriate, because observing events in
SMM is rarely useful to anyone, we propose to change the default value of
this switch.

In this patch I have assumed that all non-Atom Intel microarchitectures
starting with Comet Lake behave like this but it would be good for someone
at Intel to verify that.

[0] See the Intel white paper "Trustworthy SMM on the Intel vPro Platform"
at https://bugzilla.kernel.org/attachment.cgi?id=300300, particularly the
end of page 5.

[1] https://rr-project.org/

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 arch/x86/events/intel/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fd9f908debe5..9604e19c8761 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6094,6 +6094,11 @@ __init int intel_pmu_init(void)
 			x86_pmu.commit_scheduling = intel_tfa_commit_scheduling;
 		}
 
+		if (boot_cpu_data.x86_model == INTEL_FAM6_COMETLAKE_L ||
+		    boot_cpu_data.x86_model == INTEL_FAM6_COMETLAKE) {
+			x86_pmu.attr_freeze_on_smi = 1;
+		}
+
 		pr_cont("Skylake events, ");
 		name = "skylake";
 		break;
@@ -6135,6 +6140,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.num_topdown_events = 4;
 		x86_pmu.update_topdown_event = icl_update_topdown_event;
 		x86_pmu.set_topdown_event_period = icl_set_topdown_event_period;
+		x86_pmu.attr_freeze_on_smi = 1;
 		pr_cont("Icelake events, ");
 		name = "icelake";
 		break;
@@ -6172,6 +6178,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.num_topdown_events = 8;
 		x86_pmu.update_topdown_event = icl_update_topdown_event;
 		x86_pmu.set_topdown_event_period = icl_set_topdown_event_period;
+		x86_pmu.attr_freeze_on_smi = 1;
 		pr_cont("Sapphire Rapids events, ");
 		name = "sapphire_rapids";
 		break;
@@ -6217,6 +6224,7 @@ __init int intel_pmu_init(void)
 		 * x86_pmu.rtm_abort_event.
 		 */
 		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xc9, .umask=0x04);
+		x86_pmu.attr_freeze_on_smi = 1;
 
 		td_attr = adl_hybrid_events_attrs;
 		mem_attr = adl_hybrid_mem_attrs;
-- 
2.34.1

