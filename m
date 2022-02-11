Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777EB4B29C8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350891AbiBKQKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:10:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350462AbiBKQJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:09:43 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79DFD85;
        Fri, 11 Feb 2022 08:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644595781; x=1676131781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EAVDU/Jvja+puiOGobrPyUB1vzkfjBUp8Z6eMe+Xnaw=;
  b=A3CuzhKu+EsuGu1u+kwXPiujJRZFlLlITKR104BGjmGU1UsdnZuXmkVS
   riL2F6naLIPXMEKzO0kdFQwZB0x7p2j3Jrlt4q6My2CeZYE5E4eaiVXp/
   jfDOEIr0mu4mj6vvQMxPs0KlRhIXQ60pvGjojy7HGztaC3ClGiGWt3qR8
   /irCvrmZSZFr8x85jt2N3Nv2SvuUY3Qqi3mGbPGNDnhOFD4t4Lsuvptac
   62axLJU948ryVmvrb/DEGANsb5JqHlTkxq60ZA+QVsjIDHVL6Mg/n/n/P
   4Kt0WRVlW7cPAavpk+Cu+jtB8wtHATFMTg8rbxAgUM1KTRGMhJfPfTYgp
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="249703812"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="249703812"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 08:09:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="630393712"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga002.fm.intel.com with ESMTP; 11 Feb 2022 08:09:39 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 6/6] Documentation/admin-guide/acpi: Add documentation for fine grain control
Date:   Fri, 11 Feb 2022 08:09:32 -0800
Message-Id: <20220211160932.3221873-7-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220211160932.3221873-1-srinivas.pandruvada@linux.intel.com>
References: <20220211160932.3221873-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the newly added attributes:
fine_grain_control
fan_speed_rpm

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../acpi/fan_performance_states.rst           | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/admin-guide/acpi/fan_performance_states.rst b/Documentation/admin-guide/acpi/fan_performance_states.rst
index 98fe5c333121..b9e4b4d146c1 100644
--- a/Documentation/admin-guide/acpi/fan_performance_states.rst
+++ b/Documentation/admin-guide/acpi/fan_performance_states.rst
@@ -60,3 +60,31 @@ For example::
 
 When a given field is not populated or its value provided by the platform
 firmware is invalid, the "not-defined" string is shown instead of the value.
+
+ACPI Fan Fine Grain Control
+=============================
+
+When _FIF object specifies support for fine grain control, then fan speed
+can be set from 0 to 100% with the recommended minimum "step size" via
+_FSL object. User can adjust fan speed using thermal sysfs cooling device.
+
+Here use can look at fan performance states for a reference speed (speed_rpm)
+and set it by changing cooling device cur_state. If the fine grain control
+is supported then user can also adjust to some other speeds which are
+not defined in the performance states.
+
+The support of fine grain control is presented via sysfs attribute
+"fine_grain_control". If fine grain control is present, this attribute
+will show "1" otherwise "0".
+
+This sysfs attribute is presented in the same directory as performance states.
+
+ACPI Fan Performance Feedback
+=============================
+
+The optional _FST object provides status information for the fan device.
+This includes field to provide current fan speed in revolutions per minute
+at which the fan is rotating.
+
+This speed is presented in the sysfs using the attribute "fan_speed_rpm",
+in the same directory as performance states.
-- 
2.34.1

