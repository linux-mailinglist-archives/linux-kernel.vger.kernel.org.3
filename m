Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B4E46DCC2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240112AbhLHUPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:15:11 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:40562 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240071AbhLHUPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:15:07 -0500
Received: by mail-ot1-f53.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so3895938otj.7;
        Wed, 08 Dec 2021 12:11:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HfrUN45cqHgCg9PtoxrLRh/H00SV7ZMBqcSirS6LsG8=;
        b=VklFbMHEQT/a2RsTTjGSgdd0LIFi4b0AwHS76jL7jagexV3eRhwz22UWqsM1wv3DzS
         bBDbjM3mtPA063/EYznd/3avaFRPu5nve7uOSqND2jT75sWji3LFCPvFaC5Fvq7f3YAc
         KpUuNYdm2SMtGsuqs2f1KC0g+RjLCPgUHeGDAnw2szbBI3TiJHO05KuD4TT4jZJTUOg7
         rFPDdHIqNhjlXQkIr63RCZR35Ox6x07fr8c7Hc9bflSIqW+jvDaSl0rq9FSnNZxuqzLQ
         Rx9/BcwdNbbbHW0X8t/BFXO2PSaJ7IVJxSJKrt6uC/qjNrerC2sTjcriHZigkNxdGNMd
         x7ZQ==
X-Gm-Message-State: AOAM531nCSU+qew7ChV+X54lttfziIgskUz8+/ctQ4304jiFXe2K53/J
        T0r0jJNkHoN6HA01Y7QVz7STbS+o6w==
X-Google-Smtp-Source: ABdhPJxDVbsu/R+ZkLZstGVEnjuXnCzcMbNzLaZUGm/zjME28B1n39Bze0KAdBNmWudsmig1cuerSA==
X-Received: by 2002:a05:6830:2646:: with SMTP id f6mr1553396otu.182.1638994294507;
        Wed, 08 Dec 2021 12:11:34 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id o2sm927926oik.11.2021.12.08.12.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 12:11:33 -0800 (PST)
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
        linux-perf-users@vger.kernel.org,
        Raphael Gault <raphael.gault@arm.com>
Subject: [PATCH v13 5/5] Documentation: arm64: Document PMU counters access from userspace
Date:   Wed,  8 Dec 2021 14:11:24 -0600
Message-Id: <20211208201124.310740-6-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211208201124.310740-1-robh@kernel.org>
References: <20211208201124.310740-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

Add documentation to describe the access to the pmu hardware counters from
userspace.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v12:
 - Add note about accessing PMU registers and PMSELR_EL0 being zeroed
v11:
 - Rework chained event section to reflect 64-bit counter request may
   fail and 32-bit counters may be 64-bit with upper bits UNKNOWN.
v10:
 - Add details on perf_user_access sysctl
v9:
 - No change
v8:
 - Reword that config1:1 must always be set to request user access
v7:
 - Merge into existing arm64 perf.rst
v6:
  - Update the chained event section with attr.config1 details
v2:
  - Update links to test examples

Changes from Raphael's v4:
  - Convert to rSt
  - Update chained event status
  - Add section for heterogeneous systems
---
 Documentation/arm64/perf.rst | 78 +++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/perf.rst b/Documentation/arm64/perf.rst
index b567f177d385..1f87b57c2332 100644
--- a/Documentation/arm64/perf.rst
+++ b/Documentation/arm64/perf.rst
@@ -2,7 +2,10 @@
 
 .. _perf_index:
 
-=====================
+====
+Perf
+====
+
 Perf Event Attributes
 =====================
 
@@ -88,3 +91,76 @@ exclude_host. However when using !exclude_hv there is a small blackout
 window at the guest entry/exit where host events are not captured.
 
 On VHE systems there are no blackout windows.
+
+Perf Userspace PMU Hardware Counter Access
+==========================================
+
+Overview
+--------
+The perf userspace tool relies on the PMU to monitor events. It offers an
+abstraction layer over the hardware counters since the underlying
+implementation is cpu-dependent.
+Arm64 allows userspace tools to have access to the registers storing the
+hardware counters' values directly.
+
+This targets specifically self-monitoring tasks in order to reduce the overhead
+by directly accessing the registers without having to go through the kernel.
+
+How-to
+------
+The focus is set on the armv8 PMUv3 which makes sure that the access to the pmu
+registers is enabled and that the userspace has access to the relevant
+information in order to use them.
+
+In order to have access to the hardware counters, the global sysctl
+kernel/perf_user_access must first be enabled:
+
+.. code-block:: sh
+
+  echo 1 > /proc/sys/kernel/perf_user_access
+
+It is necessary to open the event using the perf tool interface with config1:1
+attr bit set: the sys_perf_event_open syscall returns a fd which can
+subsequently be used with the mmap syscall in order to retrieve a page of memory
+containing information about the event. The PMU driver uses this page to expose
+to the user the hardware counter's index and other necessary data. Using this
+index enables the user to access the PMU registers using the `mrs` instruction.
+Access to the PMU registers is only valid while the sequence lock is unchanged.
+In particular, the PMSELR_EL0 register is zeroed each time the sequence lock is
+changed.
+
+The userspace access is supported in libperf using the perf_evsel__mmap()
+and perf_evsel__read() functions. See `tools/lib/perf/tests/test-evsel.c`_ for
+an example.
+
+About heterogeneous systems
+---------------------------
+On heterogeneous systems such as big.LITTLE, userspace PMU counter access can
+only be enabled when the tasks are pinned to a homogeneous subset of cores and
+the corresponding PMU instance is opened by specifying the 'type' attribute.
+The use of generic event types is not supported in this case.
+
+Have a look at `tools/perf/arch/arm64/tests/user-events.c`_ for an example. It
+can be run using the perf tool to check that the access to the registers works
+correctly from userspace:
+
+.. code-block:: sh
+
+  perf test -v user
+
+About chained events and counter sizes
+--------------------------------------
+The user can request either a 32-bit (config1:0 == 0) or 64-bit (config1:0 == 1)
+counter along with userspace access. The sys_perf_event_open syscall will fail
+if a 64-bit counter is requested and the hardware doesn't support 64-bit
+counters. Chained events are not supported in conjunction with userspace counter
+access. If a 32-bit counter is requested on hardware with 64-bit counters, then
+userspace must treat the upper 32-bits read from the counter as UNKNOWN. The
+'pmc_width' field in the user page will indicate the valid width of the counter
+and should be used to mask the upper bits as needed.
+
+.. Links
+.. _tools/perf/arch/arm64/tests/user-events.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/arch/arm64/tests/user-events.c
+.. _tools/lib/perf/tests/test-evsel.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/perf/tests/test-evsel.c
-- 
2.32.0

