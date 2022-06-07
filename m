Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B387353FE63
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243509AbiFGMI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243448AbiFGMH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:07:57 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2328CB07;
        Tue,  7 Jun 2022 05:07:52 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="63506366"
X-IronPort-AV: E=Sophos;i="5.91,283,1647270000"; 
   d="scan'208";a="63506366"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 07 Jun 2022 21:07:50 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 6843CC68A4;
        Tue,  7 Jun 2022 21:07:49 +0900 (JST)
Received: from oym-om4.fujitsu.com (oym-om4.o.css.fujitsu.com [10.85.58.164])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 90D6CFA56;
        Tue,  7 Jun 2022 21:07:48 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om4.fujitsu.com (Postfix) with ESMTP id 3A50640080208;
        Tue,  7 Jun 2022 21:07:48 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, rafael@kernel.org, lenb@kernel.org,
        gregkh@linuxfoundation.org, mchehab+huawei@kernel.org,
        eugenis@google.com, tony.luck@intel.com, pcc@google.com,
        peterz@infradead.org, marcos@orca.pet, marcan@marcan.st,
        linus.walleij@linaro.org, nicolas.ferre@microchip.com,
        conor.dooley@microchip.com, arnd@arndb.de, ast@kernel.org,
        peter.chen@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v5 6/6] docs: ABI: Add sysfs documentation interface of hardware prefetch control driver
Date:   Tue,  7 Jun 2022 21:05:30 +0900
Message-Id: <20220607120530.2447112-7-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
References: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
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

