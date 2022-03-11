Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753FC4D5F67
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbiCKKYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347898AbiCKKX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:23:59 -0500
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80A333E09
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:22:48 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="65516904"
X-IronPort-AV: E=Sophos;i="5.90,173,1643641200"; 
   d="scan'208";a="65516904"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 11 Mar 2022 19:21:43 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 4CAC2CA240
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 19:21:42 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 3B89EE14DF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 19:21:41 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id B8745406139BF;
        Fri, 11 Mar 2022 19:21:40 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v2 8/8] docs: ABI: Add sysfs documentation interface of hardware prefetch control driver
Date:   Fri, 11 Mar 2022 19:19:40 +0900
Message-Id: <20220311101940.3403607-9-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220311101940.3403607-1-tarumizu.kohei@fujitsu.com>
References: <20220311101940.3403607-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This describes the sysfs interface implemented on the hardware prefetch
control driver.

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 61f5676a7429..c1f6aa1322da 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -681,3 +681,92 @@ Description:
 		(RO) the list of CPUs that are isolated and don't
 		participate in load balancing. These CPUs are set by
 		boot parameter "isolcpus=".
+
+What:		/sys/devices/system/cpu/cpu*/cache/index[0,2]/prefetch_control
+		/sys/devices/system/cpu/cpu*/cache/index[0,2]/prefetch_control/hardware_prefetcher_enable
+		/sys/devices/system/cpu/cpu*/cache/index[0,2]/prefetch_control/ip_prefetcher_enable
+		/sys/devices/system/cpu/cpu*/cache/index[0,2]/prefetch_control/adjacent_cache_line_prefetcher_enable
+		/sys/devices/system/cpu/cpu*/cache/index[0,2]/prefetch_control/stream_detect_prefetcher_enable
+		/sys/devices/system/cpu/cpu*/cache/index[0,2]/prefetch_control/stream_detect_prefetcher_strong
+		/sys/devices/system/cpu/cpu*/cache/index[0,2]/prefetch_control/stream_detect_prefetcher_dist
+Date:		March 2022
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Parameters for CPU's hardware prefetch control
+
+		This sysfs interface provides Hardware Prefetch control
+		attribute file by using implementation defined registers.
+		These files exists in every CPU's cache/index[0,2] directory,
+		and these affect the cache level of the parent index directory.
+		Each attribute file exists depending on kind of processor and
+		cache level.
+
+		*_prefetcher_enable:
+		    (RW) control this prefetcher's enablement state.
+		    Read returns current status:
+			0: this prefetcher is disabled
+			1: this prefetcher is enabled
+
+		stream_detect_prefetcher_strong:
+		    (RW) control prefetcher operation's strongness state.
+		    Strong prefetch operation is surely executed, if there is
+		    no corresponding data in cache.
+		    Weak prefetch operation allows the hardware not to execute
+		    operation depending on hardware state.
+
+		    Read returns current status:
+			0: prefetch operation is weak
+			1: prefetch operation is strong
+
+		stream_detect_prefetcher_dist:
+		    (RW) control the prefetcher distance value.
+		    Read return current prefetcher distance value in bytes
+		    or the string "auto".
+
+		    Write either a value in byte or the string "auto" to this
+		    parameter. If you write a value less than multiples of a
+		    specific value, it is rounded up.
+
+		    The value 0 and the string "auto" are the same and have
+		    a special meaning. This means that instead of setting
+		    dist to a user-specified value, it operates using
+		    hardware-specific values.
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
+		    a one-to-one attribute file to control all the tunable
+		    parameters the CPU provides of the following.
+
+			- "* Hardware Prefetcher Disable (R/W)"
+			    corresponds to the "hardware_prefetcher_enable"
+
+			- "* Adjacent Cache Line Prefetcher Disable (R/W)"
+			    corresponds to the "adjacent_cache_line_prefetcher_enable"
+
+			- "* IP Prefetcher Disable (R/W)"
+			    corresponds to the "ip_prefetcher_enable"
+
+		    The processor A64FX has register IMP_PF_STREAM_DETECT_CTRL_EL0
+		    for Hardware Prefetch Control. This attribute maps each
+		    specification to the following.
+
+			- "L*PF_DIS": enablement of hardware prefetcher
+			    corresponds to the "stream_detect_prefetcher_enable"
+
+			- "L*W": strongness of hardware prefetcher
+			    corresponds to the "stream_detect_prefetcher_strong"
+
+			- "L*_DIST": distance of hardware prefetcher
+			    corresponds to the "stream_detect_prefetcher_dist"
-- 
2.27.0

