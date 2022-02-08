Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8334ADD28
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381260AbiBHPmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380496AbiBHPmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:42:05 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243B5C061579;
        Tue,  8 Feb 2022 07:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644334924; x=1675870924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BBHDjqfyaSPl634ZRAOSij7CSpaHG3dPzGkwpuFKawc=;
  b=ePt6HOWdREvGhdvGKJ9ZKk9E3vLRANvcptYBWz5wFaJ92DGPKoTFYDqA
   V6GPgsn6Z+Jo6h08DnAjlGg8PNjifYl5XlIy/d3BHAqT1vMdMLjF6jCbx
   jhryFb3ZO+waxZ8EYB21OwVl26Ui66Cl7hyAegyt53RraI8O0h1Gc+ERA
   711NYpNH34gI0IUFZmqUJyBA4sfWCdnSRIuwZ97GbyuIeF9pHE25koveL
   pcMNpZVvQxM3AmXOi0G7cy2IiwTaFoEb5yB9uqOUYqdKPEOZMjaktA5bO
   e4xiezWkUv1r1fPORCoWDjtRWb8/IAV8P1iaUTcGUTGB6EU7uM6clbQ/o
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="236378325"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="236378325"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 07:42:02 -0800
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="601273941"
Received: from mgorzkow-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.139.232])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 07:41:55 -0800
From:   Iwona Winiarska <iwona.winiarska@intel.com>
To:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zev Weiss <zweiss@equinix.com>,
        David Muller <d.mueller@elsoft.ch>,
        Dave Hansen <dave.hansen@intel.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>
Subject: [PATCH v8 12/13] docs: hwmon: Document PECI drivers
Date:   Tue,  8 Feb 2022 16:36:38 +0100
Message-Id: <20220208153639.255278-13-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208153639.255278-1-iwona.winiarska@intel.com>
References: <20220208153639.255278-1-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Add documentation for peci-cputemp driver that provides DTS thermal
readings for CPU packages and CPU cores, and peci-dimmtemp driver that
provides Temperature Sensor on DIMM readings.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Co-developed-by: Iwona Winiarska <iwona.winiarska@intel.com>
Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/index.rst         |  2 +
 Documentation/hwmon/peci-cputemp.rst  | 90 +++++++++++++++++++++++++++
 Documentation/hwmon/peci-dimmtemp.rst | 57 +++++++++++++++++
 MAINTAINERS                           |  2 +
 4 files changed, 151 insertions(+)
 create mode 100644 Documentation/hwmon/peci-cputemp.rst
 create mode 100644 Documentation/hwmon/peci-dimmtemp.rst

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index df20022c741f..f387f661e1d7 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -161,6 +161,8 @@ Hardware Monitoring Kernel Drivers
    pcf8591
    pim4328
    pm6764tr
+   peci-cputemp
+   peci-dimmtemp
    pmbus
    powr1220
    pxe1610
diff --git a/Documentation/hwmon/peci-cputemp.rst b/Documentation/hwmon/peci-cputemp.rst
new file mode 100644
index 000000000000..fe0422248dc5
--- /dev/null
+++ b/Documentation/hwmon/peci-cputemp.rst
@@ -0,0 +1,90 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+Kernel driver peci-cputemp
+==========================
+
+Supported chips:
+	One of Intel server CPUs listed below which is connected to a PECI bus.
+		* Intel Xeon E5/E7 v3 server processors
+			Intel Xeon E5-14xx v3 family
+			Intel Xeon E5-24xx v3 family
+			Intel Xeon E5-16xx v3 family
+			Intel Xeon E5-26xx v3 family
+			Intel Xeon E5-46xx v3 family
+			Intel Xeon E7-48xx v3 family
+			Intel Xeon E7-88xx v3 family
+		* Intel Xeon E5/E7 v4 server processors
+			Intel Xeon E5-16xx v4 family
+			Intel Xeon E5-26xx v4 family
+			Intel Xeon E5-46xx v4 family
+			Intel Xeon E7-48xx v4 family
+			Intel Xeon E7-88xx v4 family
+		* Intel Xeon Scalable server processors
+			Intel Xeon D family
+			Intel Xeon Bronze family
+			Intel Xeon Silver family
+			Intel Xeon Gold family
+			Intel Xeon Platinum family
+
+	Datasheet: Available from http://www.intel.com/design/literature.htm
+
+Author: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
+
+Description
+-----------
+
+This driver implements a generic PECI hwmon feature which provides Digital
+Thermal Sensor (DTS) thermal readings of the CPU package and CPU cores that are
+accessible via the processor PECI interface.
+
+All temperature values are given in millidegree Celsius and will be measurable
+only when the target CPU is powered on.
+
+Sysfs interface
+-------------------
+
+======================= =======================================================
+temp1_label		"Die"
+temp1_input		Provides current die temperature of the CPU package.
+temp1_max		Provides thermal control temperature of the CPU package
+			which is also known as Tcontrol.
+temp1_crit		Provides shutdown temperature of the CPU package which
+			is also known as the maximum processor junction
+			temperature, Tjmax or Tprochot.
+temp1_crit_hyst		Provides the hysteresis value from Tcontrol to Tjmax of
+			the CPU package.
+
+temp2_label		"DTS"
+temp2_input		Provides current temperature of the CPU package scaled
+			to match DTS thermal profile.
+temp2_max		Provides thermal control temperature of the CPU package
+			which is also known as Tcontrol.
+temp2_crit		Provides shutdown temperature of the CPU package which
+			is also known as the maximum processor junction
+			temperature, Tjmax or Tprochot.
+temp2_crit_hyst		Provides the hysteresis value from Tcontrol to Tjmax of
+			the CPU package.
+
+temp3_label		"Tcontrol"
+temp3_input		Provides current Tcontrol temperature of the CPU
+			package which is also known as Fan Temperature target.
+			Indicates the relative value from thermal monitor trip
+			temperature at which fans should be engaged.
+temp3_crit		Provides Tcontrol critical value of the CPU package
+			which is same to Tjmax.
+
+temp4_label		"Tthrottle"
+temp4_input		Provides current Tthrottle temperature of the CPU
+			package. Used for throttling temperature. If this value
+			is allowed and lower than Tjmax - the throttle will
+			occur and reported at lower than Tjmax.
+
+temp5_label		"Tjmax"
+temp5_input		Provides the maximum junction temperature, Tjmax of the
+			CPU package.
+
+temp[6-N]_label		Provides string "Core X", where X is resolved core
+			number.
+temp[6-N]_input		Provides current temperature of each core.
+
+======================= =======================================================
diff --git a/Documentation/hwmon/peci-dimmtemp.rst b/Documentation/hwmon/peci-dimmtemp.rst
new file mode 100644
index 000000000000..e562aed620de
--- /dev/null
+++ b/Documentation/hwmon/peci-dimmtemp.rst
@@ -0,0 +1,57 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver peci-dimmtemp
+===========================
+
+Supported chips:
+	One of Intel server CPUs listed below which is connected to a PECI bus.
+		* Intel Xeon E5/E7 v3 server processors
+			Intel Xeon E5-14xx v3 family
+			Intel Xeon E5-24xx v3 family
+			Intel Xeon E5-16xx v3 family
+			Intel Xeon E5-26xx v3 family
+			Intel Xeon E5-46xx v3 family
+			Intel Xeon E7-48xx v3 family
+			Intel Xeon E7-88xx v3 family
+		* Intel Xeon E5/E7 v4 server processors
+			Intel Xeon E5-16xx v4 family
+			Intel Xeon E5-26xx v4 family
+			Intel Xeon E5-46xx v4 family
+			Intel Xeon E7-48xx v4 family
+			Intel Xeon E7-88xx v4 family
+		* Intel Xeon Scalable server processors
+			Intel Xeon D family
+			Intel Xeon Bronze family
+			Intel Xeon Silver family
+			Intel Xeon Gold family
+			Intel Xeon Platinum family
+
+	Datasheet: Available from http://www.intel.com/design/literature.htm
+
+Author: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
+
+Description
+-----------
+
+This driver implements a generic PECI hwmon feature which provides
+Temperature sensor on DIMM readings that are accessible via the processor PECI interface.
+
+All temperature values are given in millidegree Celsius and will be measurable
+only when the target CPU is powered on.
+
+Sysfs interface
+-------------------
+
+======================= =======================================================
+
+temp[N]_label		Provides string "DIMM CI", where C is DIMM channel and
+			I is DIMM index of the populated DIMM.
+temp[N]_input		Provides current temperature of the populated DIMM.
+temp[N]_max		Provides thermal control temperature of the DIMM.
+temp[N]_crit		Provides shutdown temperature of the DIMM.
+
+======================= =======================================================
+
+Note:
+	DIMM temperature attributes will appear when the client CPU's BIOS
+	completes memory training and testing.
diff --git a/MAINTAINERS b/MAINTAINERS
index b2d0b0b58da9..c666ef7ea5a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15113,6 +15113,8 @@ PECI HARDWARE MONITORING DRIVERS
 M:	Iwona Winiarska <iwona.winiarska@intel.com>
 L:	linux-hwmon@vger.kernel.org
 S:	Supported
+F:	Documentation/hwmon/peci-cputemp.rst
+F:	Documentation/hwmon/peci-dimmtemp.rst
 F:	drivers/hwmon/peci/
 
 PECI SUBSYSTEM
-- 
2.34.1

