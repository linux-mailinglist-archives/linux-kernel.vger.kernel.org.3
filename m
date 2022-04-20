Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE74B507F52
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 05:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbiDTDHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 23:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359153AbiDTDGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 23:06:36 -0400
X-Greylist: delayed 66 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Apr 2022 20:03:41 PDT
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84233A73B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:03:41 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="50159653"
X-IronPort-AV: E=Sophos;i="5.90,274,1643641200"; 
   d="scan'208";a="50159653"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP; 20 Apr 2022 12:02:31 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5ED49C9454
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 12:02:32 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 41A1CD976C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 12:02:31 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id F233C4060E7D0;
        Wed, 20 Apr 2022 12:02:30 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v3 9/9] docs: ABI: Add sysfs documentation interface of hardware prefetch control driver
Date:   Wed, 20 Apr 2022 12:02:23 +0900
Message-Id: <20220420030223.689259-10-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220420030223.689259-1-tarumizu.kohei@fujitsu.com>
References: <20220420030223.689259-1-tarumizu.kohei@fujitsu.com>
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

This describes the sysfs interface implemented by the hardware prefetch
control driver.

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 2ad01cad7f1c..0da4c1bac51e 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -688,3 +688,101 @@ Description:
 		(RO) the list of CPUs that are isolated and don't
 		participate in load balancing. These CPUs are set by
 		boot parameter "isolcpus=".
+
+What:		/sys/devices/system/cpu/cpu*/cache/index*/prefetch_control/hardware_prefetcher_enable
+		/sys/devices/system/cpu/cpu*/cache/index*/prefetch_control/ip_prefetcher_enable
+		/sys/devices/system/cpu/cpu*/cache/index*/prefetch_control/adjacent_cache_line_prefetcher_enable
+Date:		March 2022
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Parameters for some Intel CPU's hardware prefetch control
+
+		This sysfs interface provides Hardware Prefetch control
+		attribute for some Intel processors. Attributes are only
+		present if the particular cache implements the relevant
+		prefetcher controls.
+
+		*_prefetcher_enable:
+		    (RW) control this prefetcher's enablement state.
+		    Read returns current status:
+			0: this prefetcher is disabled
+			1: this prefetcher is enabled
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
+What:		/sys/devices/system/cpu/cpu*/cache/index*/prefetch_control/stream_detect_prefetcher_enable
+		/sys/devices/system/cpu/cpu*/cache/index*/prefetch_control/stream_detect_prefetcher_strength
+		/sys/devices/system/cpu/cpu*/cache/index*/prefetch_control/stream_detect_prefetcher_strength_available
+		/sys/devices/system/cpu/cpu*/cache/index*/prefetch_control/stream_detect_prefetcher_dist
+Date:		March 2022
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Parameters for A64FX's hardware prefetch control
+
+		This sysfs interface provides Hardware Prefetch control
+		attribute for the processor A64FX. Attributes are only
+		present if the particular cache implements the relevant
+		prefetcher controls.
+
+		stream_detect_prefetcher_enable:
+		    (RW) control the prefetcher's enablement state.
+		    Read returns current status:
+			0: this prefetcher is disabled
+			1: this prefetcher is enabled
+
+		stream_detect_prefetcher_strength:
+		    (RW) control the prefetcher operation's strongness state.
+		    Read returns current status:
+			weak: prefetch operation is weak
+			strong: prefetch operation is strong
+
+		    Strong prefetch operation is surely executed, if there is
+		    no corresponding data in cache.
+		    Weak prefetch operation allows the hardware not to execute
+		    operation depending on hardware state.
+
+
+		stream_detect_prefetcher_strength_available:
+		    (RO) displays a space separated list of available strongness
+		    state.
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
+		    The string "auto" have a special meaning. This means that
+		    instead of setting dist to a user-specified value, it
+		    operates using hardware-specific values.
+
+		- Attribute mapping
+
+		    The processor A64FX has register IMP_PF_STREAM_DETECT_CTRL_EL0
+		    for Hardware Prefetch Control. This attribute maps each
+		    specification to the following.
+
+			- "L*PF_DIS": enablement of hardware prefetcher
+			    corresponds to the "stream_detect_prefetcher_enable"
+
+			- "L*W": strongness of hardware prefetcher
+			    corresponds to "stream_detect_prefetcher_strength"
+			    and "stream_detect_prefetcher_strength_available"
+
+			- "L*_DIST": distance of hardware prefetcher
+			    corresponds to the "stream_detect_prefetcher_dist"
-- 
2.27.0

