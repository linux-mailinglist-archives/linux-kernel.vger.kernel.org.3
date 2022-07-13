Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FDF5730F9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbiGMIYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235790AbiGMIYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:24:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6C8F2E1A;
        Wed, 13 Jul 2022 01:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657700513; x=1689236513;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/BVwHgKbbxWOqSuXtN/RD7Dtr4NeHdsRx9vnZHO82v4=;
  b=l+pruWcJxMkZb8wXFfkpPIWJN8xlk4ryqSVkOENpIlJvFH1qzwQcoslf
   fF3sCUpoN0AfmtBY8igWIp/t24msCYvx8kBnfVZ1iwO9wso0/TdF1lM5t
   Wbx4BJKQtwamCAxfLwOLSx4eYN+Yq5rvuNbMN6OY4bhwwoBCjkjT1893k
   VKfd09Gr0AXtlipAwJzAfSd7DgDJDl/EfGk+4NkptS30Ouw4pWRuWrYqJ
   q9ZV+wz1Hwh9LB9rUeqKhtCJSzhNUsf2wZK/oYCX/haAyvbTuqtKCuqim
   7fo8YqSaDROQxCSjtQBC1YVTXGPM06wRAV/SemoxcQfLMsc+Jz3+dJNvj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="285173583"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="285173583"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 01:21:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="653277737"
Received: from dmi-pnp-i7.sh.intel.com ([10.239.159.145])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jul 2022 01:21:28 -0700
From:   Dapeng Mi <dapeng1.mi@intel.com>
To:     rafael@kernel.org, mst@redhat.com, arnd@arndb.de,
        bvanassche@acm.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Dapeng Mi <dapeng1.mi@intel.com>
Subject: [PATCH] cpuidle: Move cpuidle driver forward before acpi driver in Makefile
Date:   Wed, 13 Jul 2022 16:24:26 +0800
Message-Id: <20220713082426.850911-1-dapeng1.mi@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As long as Kconfig ACPI_PROCESSOR is enabled, ACPI_PROCESSOR would
select ACPI_PROCESSOR_IDLE and acpi_idle driver is enabled. But
in current driver loading order acpi_idle driver is always loaded
before cpuidle_haltpoll driver. This leads to cpuidle_hatpoll driver
has no chance to be loaded when it's enabled.

Thus, move cpuidle driver forward before acpi driver and make
cpuidle-hatpoll driver has a chance to be run when it's enabled.

Signed-off-by: Dapeng Mi <dapeng1.mi@intel.com>
---
 drivers/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 9a30842b22c5..921ed481b520 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -26,6 +26,7 @@ obj-y				+= idle/
 # IPMI must come before ACPI in order to provide IPMI opregion support
 obj-y				+= char/ipmi/
 
+obj-$(CONFIG_CPU_IDLE)		+= cpuidle/
 obj-$(CONFIG_ACPI)		+= acpi/
 
 # PnP must come after ACPI since it will eventually need to check if acpi
@@ -126,7 +127,6 @@ obj-$(CONFIG_EDAC)		+= edac/
 obj-$(CONFIG_EISA)		+= eisa/
 obj-$(CONFIG_PM_OPP)		+= opp/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
-obj-$(CONFIG_CPU_IDLE)		+= cpuidle/
 obj-y				+= mmc/
 obj-y				+= ufs/
 obj-$(CONFIG_MEMSTICK)		+= memstick/
-- 
2.30.2

