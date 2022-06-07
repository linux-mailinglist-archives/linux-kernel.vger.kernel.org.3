Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7385423E1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386804AbiFHAkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 20:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455541AbiFGXSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:18:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DC13D11F0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654636837; x=1686172837;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yqRAsG56rYYj2A4jgXo6P8t9HyyNEcw84/HV/XhestQ=;
  b=Ag2tCaixSVe9VF9vz5k2b/Qqnl/CRlnuKnfwU2nak2JNMOZWCBQKmUxW
   IY2uFkx8/jLzr9TLHWYTyNbR+Pgc/iPgV14I+GKvLKvCzBFtlM5B4/eJa
   50FKJT/03hxQ3llEy5eEaFU9GNhsU2xeXEvPzhIt2cU+bVa4Ml5fHB8y/
   7fl9KzHufkvAIk6M9dYFa/mFYmGmYtNFMIm87R2DTcABXhtn+QHX02sD8
   9OyUVPLHNOmL4Hpn4DJt9IDXk9F0Gl/6KBpYricIxq8ejoBy224TemeH3
   VnYxa1fbPLC2Pj8AskuW/wYs8t3cZWuxYPaWlSQVvyk8TlwrrKqLDh7xw
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="363091753"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="363091753"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 14:20:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="826558517"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 14:20:21 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH] RAS/CEC: Reduce default threshold to offline a page to "2"
Date:   Tue,  7 Jun 2022 14:20:15 -0700
Message-Id: <20220607212015.175591-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A large scale study of memory errors in data centers showed that it is
best to aggressively take pages with corrected errors offline. This is
the best strategy of using corrected errors as a predictor of future
uncorrected errors.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---
Here's the link to the study. I thought of putting into the code
comment, or the commit comment. But these links are sometimes changed
as website is re-organised, making the link stale.

https://www.intel.com/content/dam/www/public/us/en/documents/intel-and-samsung-mrt-improving-memory-reliability-at-data-centers.pdf

The paper has two recommendations:
1) Change threshold to "2".
2) Do very smart platform dependent things

This commit only addresses the first :-)
---
 drivers/ras/cec.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 42f2fc0bc8a9..5d614c383ccf 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -125,8 +125,11 @@ static struct ce_array {
 static DEFINE_MUTEX(ce_mutex);
 static u64 dfs_pfn;
 
-/* Amount of errors after which we offline */
-static u64 action_threshold = COUNT_MASK;
+/*
+ * Number of errors after which we offline. Default is to aggressively
+ * offline the page when a second error is seen.
+ */
+static u64 action_threshold = 2;
 
 /* Each element "decays" each decay_interval which is 24hrs by default. */
 #define CEC_DECAY_DEFAULT_INTERVAL	24 * 60 * 60	/* 24 hrs */
-- 
2.35.3

