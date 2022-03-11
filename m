Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC784D6A14
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiCKWpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 17:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiCKWph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:45:37 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AE7148671;
        Fri, 11 Mar 2022 14:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647037276; x=1678573276;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aXpYOn6ZRsuTaRkD1g4T1EgJ06+xggd+9isCrVZMGXo=;
  b=jCTUM9rslUpRnz45xGT2RwDUDP2tWm08aBSkI43AnadT+f/cs7bj+kin
   lZqpAolIykE9Q8A24aUuRK9WUPzQAWTbta+kbJX5z9u+nqJHqX5ng5d/6
   qhbzOSLDgmSpD9DTvlFdhlhEh0M/+WIHDxgEutJCkyGVCp2Vkc9tMXUJK
   Plr9npeesT798LIY44r8vnSjW2PKmaotEwDdjjI0UnGPW5we9HXLmxB/t
   IG71vcLUjcWrC+0u9wgw4b3ddjQBqisseijRRQ+ipOEH5S1TISwJPGGi7
   C5Zb4NaDGG/4mviq1wTD/LLhAyYhPReVgiKnW0oIGtF/LTJwIneJ2iKkf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="255853491"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="255853491"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 14:14:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="496896178"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga003.jf.intel.com with ESMTP; 11 Mar 2022 14:14:14 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, corbet@lwn.net
Cc:     linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] documentation: thermal: DPTF Documentation
Date:   Fri, 11 Mar 2022 14:14:13 -0800
Message-Id: <20220311221413.714859-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Intel Dynamic Platform and Thermal Framework (DPTF)
ABI.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/driver-api/thermal/index.rst    |   1 +
 .../driver-api/thermal/intel_dptf.rst         | 272 ++++++++++++++++++
 2 files changed, 273 insertions(+)
 create mode 100644 Documentation/driver-api/thermal/intel_dptf.rst

diff --git a/Documentation/driver-api/thermal/index.rst b/Documentation/driver-api/thermal/index.rst
index 4cb0b9b6bfb8..030306ffa408 100644
--- a/Documentation/driver-api/thermal/index.rst
+++ b/Documentation/driver-api/thermal/index.rst
@@ -17,3 +17,4 @@ Thermal
    intel_powerclamp
    nouveau_thermal
    x86_pkg_temperature_thermal
+   intel_dptf
diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentation/driver-api/thermal/intel_dptf.rst
new file mode 100644
index 000000000000..96668dca753a
--- /dev/null
+++ b/Documentation/driver-api/thermal/intel_dptf.rst
@@ -0,0 +1,272 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============================================================
+Intel(R) Dynamic Platform and Thermal Framework Sysfs Interface
+===============================================================
+
+:Copyright: |copy| 2022 Intel Corporation
+
+:Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
+
+Introduction
+------------
+
+Intel(R) Dynamic Platform and Thermal Framework (DPTF) is a platform
+level hardware/software solution for power and thermal management.
+
+As a container for multiple power/thermal technologies, DPTF provides
+a coordinated approach for different policies to effect the hardware
+state of a system.
+
+Since it is a platform level framework, this has several components.
+Some parts of the technology is implemented in the firmware and uses
+ACPI and PCI devices to expose various features for monitoring and
+control. Linux has a set of kernel drivers exposing hardware interface
+to user space. This allows user space thermal solutions like
+"Linux Thermal Daemon" to read platform specific thermal and power
+tables to deliver adequate performance while keeping the system under
+thermal limits.
+
+DPTF ACPI Drivers interface
+----------------------------
+
+:file:`/sys/bus/platform/devices/<N>/uuids`, where <N>
+=INT3400|INTC1040|INTC1041|INTC10A0
+
+``available_uuids`` (RO)
+	A set of UUIDs strings presenting available policies
+	which should be notified to the firmware when the
+	user space can support those policies.
+
+	UUID strings:
+
+	"42A441D6-AE6A-462b-A84B-4A8CE79027D3" : Passive 1
+
+	"3A95C389-E4B8-4629-A526-C52C88626BAE" : Active
+
+	"97C68AE7-15FA-499c-B8C9-5DA81D606E0A" : Critical
+
+	"63BE270F-1C11-48FD-A6F7-3AF253FF3E2D" : Adaptive performance
+
+	"5349962F-71E6-431D-9AE8-0A635B710AEE" : Emergency call
+
+	"9E04115A-AE87-4D1C-9500-0F3E340BFE75" : Passive 2
+
+	"F5A35014-C209-46A4-993A-EB56DE7530A1" : Power Boss
+
+	"6ED722A7-9240-48A5-B479-31EEF723D7CF" : Virtual Sensor
+
+	"16CAF1B7-DD38-40ED-B1C1-1B8A1913D531" : Cooling mode
+
+	"BE84BABF-C4D4-403D-B495-3128FD44dAC1" : HDC
+
+``current_uuid`` (RW)
+	User space can write strings from available UUIDs, one at a
+	time.
+
+:file:`/sys/bus/platform/devices/<N>/`, where <N>
+=INT3400|INTC1040|INTC1041|INTC10A0
+
+``imok`` (WO)
+	User space daemon write 1 to respond to firmware event
+	for sending keep alive notification. User space receives
+	THERMAL_EVENT_KEEP_ALIVE kobject uevent notification when
+	firmware calls for user space to respond with imok ACPI
+	method.
+
+``odvp*`` (RO)
+	Firmware thermal status variable values. Thermal tables
+	calls for different processing based on these variable
+	values.
+
+``data_vault`` (RO)
+	Binary thermal table. Refer to
+	https:/github.com/intel/thermal_daemon for decoding
+	thermal table.
+
+
+ACPI Thermal Relationship table interface
+------------------------------------------
+
+:file:`/dev/acpi_thermal_rel`
+
+	This device provides IOCTL interface to read standard ACPI
+	thermal relationship tables via ACPI methods _TRT and _ART.
+	These IOCTLs are defined in
+	drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.h
+
+	IOCTLs:
+
+	ACPI_THERMAL_GET_TRT_LEN: Get length of TRT table
+
+	ACPI_THERMAL_GET_ART_LEN: Get length of ART table
+
+	ACPI_THERMAL_GET_TRT_COUNT: Number of records in TRT table
+
+	ACPI_THERMAL_GET_ART_COUNT: Number of records in ART table
+
+	ACPI_THERMAL_GET_TRT: Read binary TRT table, length to read is
+	provided via argument to ioctl().
+
+	ACPI_THERMAL_GET_ART: Read binary ART table, length to read is
+	provided via argument to ioctl().
+
+DPTF ACPI Sensor drivers
+-------------------------
+
+DPTF Sensor drivers are presented as standard thermal sysfs thermal_zone.
+
+
+DPTF ACPI Cooling drivers
+--------------------------
+
+DPTF cooling drivers are presented as standard thermal sysfs cooling_device.
+
+
+DPTF Processor thermal PCI Driver interface
+--------------------------------------------
+
+:file:`/sys/bus/pci/devices/0000\:00\:04.0/power_limits/`
+
+Refer to Documentation/power/powercap/powercap.rst for powercap
+ABI.
+
+``power_limit_0_max_uw`` (RO)
+	Maximum powercap sysfs constraint_0_power_limit_uw for Intel RAPL
+
+``power_limit_0_step_uw`` (RO)
+	Power limit increment/decrements for Intel RAPL constraint 0 power limit
+
+``power_limit_0_min_uw`` (RO)
+	Minimum powercap sysfs constraint_0_power_limit_uw for Intel RAPL
+
+``power_limit_0_tmin_us`` (RO)
+	Minimum powercap sysfs constraint_0_time_window_us for Intel RAPL
+
+``power_limit_0_tmax_us`` (RO)
+	Maximum powercap sysfs constraint_0_time_window_us for Intel RAPL
+
+``power_limit_1_max_uw`` (RO)
+	Maximum powercap sysfs constraint_1_power_limit_uw for Intel RAPL
+
+``power_limit_1_step_uw`` (RO)
+	Power limit increment/decrements for Intel RAPL constraint 1 power limit
+
+``power_limit_1_min_uw`` (RO)
+	Minimum powercap sysfs constraint_1_power_limit_uw for Intel RAPL
+
+``power_limit_1_tmin_us`` (RO)
+	Minimum powercap sysfs constraint_1_time_window_us for Intel RAPL
+
+``power_limit_1_tmax_us`` (RO)
+	Maximum powercap sysfs constraint_1_time_window_us for Intel RAPL
+
+:file:`/sys/bus/pci/devices/0000\:00\:04.0/`
+
+``tcc_offset_degree_celsius`` (RW)
+	TCC offset from the critical temperature where hardware will throttle
+	CPU.
+
+:file:`/sys/bus/pci/devices/0000\:00\:04.0/workload_request`
+
+``workload_available_types`` (RO)
+	Available workload types. User space can specify one of the workload type
+	it is currently executing via workload_type. For example: idle, bursty,
+	sustained etc.
+
+``workload_type`` (RW)
+	User space can specify any one of the available workload type using
+	this interface.
+
+DPTF Processor thermal RFIM interface
+--------------------------------------------
+
+RFIM interface allows adjustment of FIVR (Fully Integrated Voltage Regulator)
+and DDR (Double Data Rate)frequencies to avoid RF interference with WiFi and 5G.
+
+Switching voltage regulators (VR) generate radiated EMI or RFI at the
+fundamental frequency and its harmonics. Some harmonics may interfere
+with very sensitive wireless receivers such as Wi-Fi and cellular that
+are integrated into host systems like notebook PCs.  One of mitigation
+methods is requesting SOC integrated VR (IVR) switching frequency to a
+small % and shift away the switching noise harmonic interference from
+radio channels.  OEM or ODMs can use the driver to control SOC IVR
+operation within the range where it does not impact IVR performance.
+
+DRAM devices of DDR IO interface and their power plane can generate EMI
+at the data rates. Similar to IVR control mechanism, Intel offers a
+mechanism by which DDR data rates can be changed if several conditions
+are met: there is strong RFI interference because of DDR; CPU power
+management has no other restriction in changing DDR data rates;
+PC ODMs enable this feature (real time DDR RFI Mitigation referred to as
+DDR-RFIM) for Wi-Fi from BIOS.
+
+
+FIVR attributes
+
+:file:`/sys/bus/pci/devices/0000\:00\:04.0/fivr/`
+
+``vco_ref_code_lo`` (RW)
+	The VCO reference code is an 11-bit field and controls the FIVR
+	switching frequency. This is the 3-bit LSB field.
+
+``vco_ref_code_hi`` (RW)
+	The VCO reference code is an 11-bit field and controls the FIVR
+	switching frequency. This is the 8-bit MSB field.
+
+``spread_spectrum_pct`` (RW)
+	Set the FIVR spread spectrum clocking percentage
+
+``spread_spectrum_clk_enable`` (RW)
+	Enable/disable of the FIVR spread spectrum clocking feature
+
+``rfi_vco_ref_code`` (RW)
+	This field is a read only status register which reflects the
+	current FIVR switching frequency
+
+``fivr_fffc_rev`` (RW)
+	This field indicated the revision of the FIVR HW.
+
+
+DVFS attributes
+
+:file:`/sys/bus/pci/devices/0000\:00\:04.0/dvfs/`
+
+``rfi_restriction_run_busy`` (RW)
+	Request the restriction of specific DDR data rate and set this
+	value 1. Self reset to 0 after operation.
+
+``rfi_restriction_err_code`` (RW)
+	0 :Request is accepted, 1:Feature disabled,
+	2: the request restricts more points than it is allowed
+
+``rfi_restriction_data_rate_Delta`` (RW)
+	Restricted DDR data rate for RFI protection: Lower Limit
+
+``rfi_restriction_data_rate_Base`` (RW)
+	Restricted DDR data rate for RFI protection: Upper Limit
+
+``ddr_data_rate_point_0`` (RO)
+	DDR data rate selection 1st point
+
+``ddr_data_rate_point_1`` (RO)
+	DDR data rate selection 2nd point
+
+``ddr_data_rate_point_2`` (RO)
+	DDR data rate selection 3rd point
+
+``ddr_data_rate_point_3`` (RO)
+	DDR data rate selection 4th point
+
+``rfi_disable (RW)``
+	Disable DDR rate change feature
+
+DPTF Power supply and Battery Interface
+----------------------------------------
+
+Refer to Documentation/ABI/testing/sysfs-platform-dptf
+
+DPTF Fan Control
+----------------------------------------
+
+Refer to Documentation/admin-guide/acpi/fan_performance_states.rst
-- 
2.31.1

