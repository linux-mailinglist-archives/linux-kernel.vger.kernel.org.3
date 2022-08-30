Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9C85A6BF3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiH3SUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiH3SUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:20:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ACE1263B;
        Tue, 30 Aug 2022 11:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661883608; x=1693419608;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NS+t2d7qBhpf7vMOnJnro7EXydS34neeOz6bAzGqb/I=;
  b=ZIekJh6zDBQzJr33bqhQ49DqPHC1eJcn/kk65Vnq/wMN0WRaA8u6nKso
   m7V5e+6hkj+MBHAaESgxkSK9XUkz981uaxW521pXuxdGP2EHAFxiYzskF
   phqv90OrSgiQVr/NiXOlNhf2esej1qELC1oURac9rqwoj75y3bTDft+Bn
   MsUlJ9hLuqK+EsYYoBA1+dctM2MSpYoicSB7OWEC88C6a9AOnN7oMfIhC
   nVoQ7YhoM42wy4ssqtEqaDzOpJUaAFVvIzQUvpEUZLl4OuukMIDDC9BY3
   Re/puLh5brS318TSIkz9KSxHJZwwD37Mu3Tf3OaqWd0d0YoXJOI950d27
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="275667791"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="275667791"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 11:20:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="680144468"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 30 Aug 2022 11:20:07 -0700
Received: from otcpl-manager.jf.intel.com (otcpl-manager.jf.intel.com [10.54.77.24])
        by linux.intel.com (Postfix) with ESMTP id 998E1580871;
        Tue, 30 Aug 2022 11:20:07 -0700 (PDT)
From:   Gayatri Kammela <gayatri.kammela@linux.intel.com>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, irenic.rajneesh@gmail.com,
        Gayatri Kammela <gayatri.kammela@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Box <david.e.box@intel.com>
Subject: [PATCH v1] platform/x86/intel: pmc/core: Add Raptor Lake support to pmc core driver
Date:   Tue, 30 Aug 2022 11:20:01 -0700
Message-Id: <20220830182001.3693030-1-gayatri.kammela@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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

Add Raptor Lake client parts (both RPL and RPL_S) support to pmc core
driver. Raptor Lake client parts reuse all the Alder Lake PCH IPs.

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Box <david.e.box@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index a1fe1e0dcf4a..17ec5825d13d 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1914,6 +1914,8 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&tgl_reg_map),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_reg_map),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &tgl_reg_map),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_reg_map),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&adl_reg_map),
 	{}
 };
 

base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
-- 
2.25.1

