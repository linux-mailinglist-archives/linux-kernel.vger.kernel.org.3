Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6646E496468
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381885AbiAURrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:47:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:56027 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381822AbiAURrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:47:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642787272; x=1674323272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nR54sbM3jfoKwrWn8S3jngx1W/C1FuURDqkpU392O9Q=;
  b=ZZDJOWeYgd9HeVMT9YNs/IazsJ7Sp/0yd1DYjiJ8WgW7FjCKOGKmPHGP
   Xlk+JweIbptkrwkBVY6cn55hLybI61X1AbHVt66AadayikaVooEbuCABn
   y7Bh3lsP66fVO4Xs62YFkT01quUK8nYWhsAd2m/K5rDPcE176fYia9s8b
   rmdQgBHYDjG5NEDlSgSgwBu1juDeLHc7V+aChmx1w1UXHnPR+bAfkfqpJ
   XCq3Tk7T1inhaZBPvVXeAVwxQyLeVMdFn7zdtdMilAne5fScVODcltCAF
   UEdypCgVUBAeb2sa3hrlXQ7uHgI5gztlg5py4f+1aWFsf9tURYYonQWRQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="243302301"
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="243302301"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 09:47:51 -0800
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="623394788"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 09:47:51 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>,
        Ailin Xu <ailin.xu@intel.com>
Subject: [PATCH v2 1/6] x86/cpu: Add Xeon Icelake-D to list of CPUs that support PPIN
Date:   Fri, 21 Jan 2022 09:47:38 -0800
Message-Id: <20220121174743.1875294-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220121174743.1875294-1-tony.luck@intel.com>
References: <20220107225442.1690165-1-tony.luck@intel.com>
 <20220121174743.1875294-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missed adding the Icelake-D CPU to the list. It uses the same MSRs
to control and read the inventory number as all the other models.

Reported-by: Ailin Xu <ailin.xu@intel.com>
Fixes: dc6b025de95b ("x86/mce: Add Xeon Icelake to list of CPUs that support PPIN")
Cc: <stable@vger.kernel.org>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index bb9a46a804bf..baafbb37be67 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -486,6 +486,7 @@ static void intel_ppin_init(struct cpuinfo_x86 *c)
 	case INTEL_FAM6_BROADWELL_X:
 	case INTEL_FAM6_SKYLAKE_X:
 	case INTEL_FAM6_ICELAKE_X:
+	case INTEL_FAM6_ICELAKE_D:
 	case INTEL_FAM6_SAPPHIRERAPIDS_X:
 	case INTEL_FAM6_XEON_PHI_KNL:
 	case INTEL_FAM6_XEON_PHI_KNM:
-- 
2.31.1

