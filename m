Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A6646DCC0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240069AbhLHUPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:15:06 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:38504 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236644AbhLHUPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:15:04 -0500
Received: by mail-ot1-f53.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso3911228ota.5;
        Wed, 08 Dec 2021 12:11:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gs33L1/6raqSK9QUUTnv7TCH3v7KbK1ze/ld1T0DSZo=;
        b=B/w+6pY2y8+0kS2I6IcKc66NFyao1W38QrtxDr9SSrdUOd07fOl0wN+H3z1AGIfCmM
         mc6xj/G0zsU4SnjPG6hVo+2jtBC5AydB+u+QPVY3FrmiEan76cx3L0cWiDnIuTmn9loi
         ofr1UuNuzkvW1oIi6TfNxj2jDJ30pUKeNZwSEsQkCdWkJnFpn5idjM2QLn4hG3s0E6fz
         v9Cz6FqgHZh3Oo3wavQyHvKaopiGOoYFh6/Qd0pGx/fpSwOxOB/RDNyY0aqz7F+8saVL
         eUiSUHLTSHranVO9G/JWf+pPE43sTU3+AJ2CpkRjht2pWX5FV9OraGCLCKSiv8Ky7tSy
         Kr5g==
X-Gm-Message-State: AOAM530H/RBbdtufQg3gG9C7Agk5cqoYet7YK1wxUuugSvqcgmMFtlf5
        hePKjV6ytlzmypAVDsdNow==
X-Google-Smtp-Source: ABdhPJzTkAp++P+k4YZ8yivYOkuhUUlUlVJBOscVMAisWtQ4rlwNPi6M2Nify7bCMowWee8PHJw04Q==
X-Received: by 2002:a9d:750c:: with SMTP id r12mr1428810otk.273.1638994291415;
        Wed, 08 Dec 2021 12:11:31 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id o2sm927926oik.11.2021.12.08.12.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 12:11:30 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vince Weaver <vincent.weaver@maine.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v13 3/5] arm64: perf: Add userspace counter access disable switch
Date:   Wed,  8 Dec 2021 14:11:22 -0600
Message-Id: <20211208201124.310740-4-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211208201124.310740-1-robh@kernel.org>
References: <20211208201124.310740-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like x86, some users may want to disable userspace PMU counter
altogether. Add a sysctl 'perf_user_access' file to control userspace
counter access. The default is '0' which is disabled. Writing '1'
enables access.

Note that x86 supports globally enabling user access by writing '2' to
/sys/bus/event_source/devices/cpu/rdpmc. As there's not existing
userspace support to worry about, this shouldn't be necessary for Arm.
It could be added later if the need arises.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-perf-users@vger.kernel.org
Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v11:
 - Move custom handler to next patch
v10:
 - Add documentation
 - Use a custom handler (needed on the next patch)
v9:
 - Use sysctl instead of sysfs attr
 - Default to disabled
v8:
 - New patch
---
 Documentation/admin-guide/sysctl/kernel.rst | 11 +++++++++++
 arch/arm64/kernel/perf_event.c              | 17 +++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 426162009ce9..346a0dba5703 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -905,6 +905,17 @@ enabled, otherwise writing to this file will return ``-EBUSY``.
 The default value is 8.
 
 
+perf_user_access (arm64 only)
+=================================
+
+Controls user space access for reading perf event counters. When set to 1,
+user space can read performance monitor counter registers directly.
+
+The default value is 0 (access disabled).
+
+See Documentation/arm64/perf.rst for more information.
+
+
 pid_max
 =======
 
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index b4044469527e..6ae20c4217af 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -286,6 +286,8 @@ static const struct attribute_group armv8_pmuv3_events_attr_group = {
 PMU_FORMAT_ATTR(event, "config:0-15");
 PMU_FORMAT_ATTR(long, "config1:0");
 
+static int sysctl_perf_user_access __read_mostly;
+
 static inline bool armv8pmu_event_is_64bit(struct perf_event *event)
 {
 	return event->attr.config1 & 0x1;
@@ -1104,6 +1106,19 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
 	return probe.present ? 0 : -ENODEV;
 }
 
+static struct ctl_table armv8_pmu_sysctl_table[] = {
+	{
+		.procname       = "perf_user_access",
+		.data		= &sysctl_perf_user_access,
+		.maxlen		= sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{ }
+};
+
 static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 			  int (*map_event)(struct perf_event *event),
 			  const struct attribute_group *events,
@@ -1136,6 +1151,8 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_CAPS] = caps ?
 			caps : &armv8_pmuv3_caps_attr_group;
 
+	register_sysctl("kernel", armv8_pmu_sysctl_table);
+
 	return 0;
 }
 
-- 
2.32.0

