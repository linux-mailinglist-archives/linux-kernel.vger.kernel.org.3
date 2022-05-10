Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009E0520B51
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 04:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbiEJCi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 22:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbiEJCiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 22:38:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119F5238D45;
        Mon,  9 May 2022 19:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652150069; x=1683686069;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aG59bpzcw7VuXqVqyNvwTDxFVLD9poJVez6/A6PWsf4=;
  b=fdlBYOrIS5ZpaAIcUcyIoCv17+CT5RoaISYb1i29fqrW8KQ/N6jnJMSi
   sS/7bFA2g46dgVnfw1du8NBkL1YG3pV6MmIOGpeWaQQB6DMPjuJbY/ol1
   MALS9IlAFHyazdQIXIw3160bDsBkXWAKLiwa2va6K8w0Bxu5AECSipLpW
   hA4qTQUvSD2jbJGdxTU0pCdwwCSrueCT58qCubw3LkeLTfhziUAntHOyG
   f4GB2B+y7xTaHZQ6cmn+Q8U1aXZfurYxR9+TkORQoR5tqc13PdJY3Rnyg
   pIuwumkHItce4yBEdQnXfAcSF29Z6mdF7DdPr1cuyG70Pi7VQggqPQDUK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="266825596"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="266825596"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 19:34:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="570460804"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga007.fm.intel.com with ESMTP; 09 May 2022 19:34:28 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] tools/power/x86/intel-speed-select: Display error on turbo mode disabled
Date:   Mon,  9 May 2022 19:34:21 -0700
Message-Id: <20220510023421.3930540-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Intel SST turbo-freq feature to be enabled, the turbo mode on the
platform must be enabled also. If turbo mode is disabled, display error
while enabling turbo-freq feature.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
Since this is a trivial patch, I am not sending a PULL request.

 tools/power/x86/intel-speed-select/isst-config.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 060390e88e37..9d35614995ee 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1892,6 +1892,12 @@ static void set_fact_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 	int ret;
 	int status = *(int *)arg4;
 
+	if (status && no_turbo()) {
+		isst_display_error_info_message(1, "Turbo mode is disabled", 0, 0);
+		ret = -1;
+		goto disp_results;
+	}
+
 	ret = isst_get_ctdp_levels(cpu, &pkg_dev);
 	if (ret) {
 		isst_display_error_info_message(1, "Failed to get number of levels", 0, 0);
-- 
2.35.1

