Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80DF49AD98
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445110AbiAYH0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:26:38 -0500
Received: from esa11.hc1455-7.c3s2.iphmx.com ([207.54.90.137]:19240 "EHLO
        esa11.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1443751AbiAYHWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:22:01 -0500
IronPort-SDR: Mh03SH5ExviKiI/Fr6lksYIWcTGsdTkHkc1yUpzP3W6ION5HJcpbtVZ2cz2saxRuaVv8AggJVB
 hB7qriSt1dwzGS2SS6/hdrmDQn6mJzC1eJBlJtr4WJJzBvv9xRUG7Fv6yLJ1vey44h547he5If
 Kp9K5/7xfk9iq6SxLGmF/HU4wVwaZP6HQ5buq2tHqZ2hNBpYQZtY/cVyMVhg7E+REeyu01JdBd
 f11FzNrrHBeSe+qzW6dM0BpB8oMDLNVJClUp68bWr8S/8Qcdwb1KkzhIWHry3UtTdZ15e8M6pg
 F5tWtZGap0vzno3/IGHrlu5z
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="40059904"
X-IronPort-AV: E=Sophos;i="5.88,314,1635174000"; 
   d="scan'208";a="40059904"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 25 Jan 2022 16:14:42 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id E711ECD6C1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:14:41 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 274F2E6544
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:14:41 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id E2062400C1BBE;
        Tue, 25 Jan 2022 16:14:40 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH 8/8] docs: ABI: Add sysfs documentation interface of hardware prefetch control driver
Date:   Tue, 25 Jan 2022 16:14:14 +0900
Message-Id: <20220125071414.811344-9-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220125071414.811344-1-tarumizu.kohei@fujitsu.com>
References: <20220125071414.811344-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This describes the sysfs interface implemented on the hardware prefetch
control driver.

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 61f5676a7429..66b4023b2ed1 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -681,3 +681,96 @@ Description:
 		(RO) the list of CPUs that are isolated and don't
 		participate in load balancing. These CPUs are set by
 		boot parameter "isolcpus=".
+
+What:		/sys/devices/system/cpu/cpu*/cache/index[0,2]/prefetch_control
+Date:		January 2022
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Parameters for CPU's hardware prefetch control
+
+		This sysfs interface provides Hardware Prefetch control
+		attribute file by using implementation defined registers.
+		This file exists in every CPU's cache/index[0,2] directory.
+		Each attribute file corresponds to the cache level of the
+		parent index directory.
+
+		prefetch_control: (RW) This file allows user to control
+		several options described below. Which options are available
+		depends on the CPU.
+
+		  * hardware_prefetcher_enable:
+		    The enablement status of prefetcher, "enable" or "disable".
+
+		  * ip_prefetcher_enable:
+		    The enablement status of prefetcher, "enable" or "disable".
+
+		  * adjacent_cache_line_prefetcher_enable:
+		    The enablement status of prefetcher, "enable" or "disable".
+
+		  * stream_detect_prefetcher_enable:
+		    The enablement status of prefetcher, "enable" or "disable".
+
+		  * stream_detect_prefetcher_strong:
+		    The strongness status of prefetcher, "strong" or "weak".
+
+		  * stream_detect_prefetcher_dist:
+		    The current prefetcher distance value in bytes or the "auto".
+		    This value is a multiples of a specific value, depending on
+		    the CPU.
+
+		    Write either a value in byte or the string "auto" to this
+		    parameter. If you write a value less than multiples of a
+		    specific value, it is rounded up.
+
+		- Supported processors
+
+		    This sysfs interface is available on several processors, x86
+		    and ARM64. Currently, the following processors are supported:
+
+			- x86 processor
+			    - INTEL_FAM6_BROADWELL_X
+
+			- ARM64 processor
+			    - FUJITSU_CPU_PART_A64FX
+
+		- Attribute mapping
+
+		    Some Intel processors have MSR 0x1a4. This register has several
+		    specifications depending on the model. This interface provides
+		    a one-to-one option to control all the tunable parameters the
+		    CPU provides of the following.
+
+			- "* Hardware Prefetcher Disable (R/W)"
+			    corresponds to the attribute "hardware_prefetcher_enable"
+
+			- "* Adjacent Cache Line Prefetcher Disable (R/W)"
+			    corresponds to the attribute "adjacent_cache_line_prefetcher_enable"
+
+			- "* IP Prefetcher Disable (R/W)"
+			    corresponds to the attribute "ip_prefetcher_enable"
+
+		    The processor A64FX has register IMP_PF_STREAM_DETECT_CTRL_EL0
+		    for Hardware Prefetch Control. This attribute maps each
+		    specification to the following.
+
+			- "L*PF_DIS": enablement of hardware prefetcher
+			    corresponds to the attribute "stream_detect_prefetcher_enable"
+
+			- "L*W": strongness of hardware prefetcher
+			    corresponds to the attribute "stream_detect_prefetcher_strong"
+
+			- "L*_DIST": distance of hardware prefetcher
+			    corresponds to the attribute "stream_detect_prefetcher_dist"
+
+		- Example::
+
+		    # cat /sys/devices/system/cpu/cpu0/cache/index0/prefetch_control
+
+		    > hardware_prefetcher_enable=enable
+		    > ip_prefetcher_enable=enable
+
+		    # echo "hardware_prefetcher_enable=disable" > /sys/devices/system/cpu/cpu0/cache/index0/prefetch_control
+
+		    # cat /sys/devices/system/cpu/cpu0/cache/index2/prefetch_control
+
+		    > hardware_prefetcher_enable=disable
+		    > ip_prefetcher_enable=enable
-- 
2.27.0

