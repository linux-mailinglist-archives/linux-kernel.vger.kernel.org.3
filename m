Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1F4588026
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 18:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbiHBQVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 12:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbiHBQVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 12:21:02 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452EC1580A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 09:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659457261; x=1690993261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=odLe469vYRFFk0tiQE748w0fTOIT9bUrSyZmNxifBUU=;
  b=HTzSERYhYaeCC+3Cv42hmrZ60Vx8+DVEMFqUKI002FjbTY6Oma+Rva2F
   IiPYKwZxvT390I8J+tvF/DHFogpbCq1egFP04QxPtbOrcP7gz9rix8EIo
   psC6CLPu1gGUjavRBPEz+lcnGrnQgwn2VSLb0uKGlCANLYWVzpeZP+oNT
   3oqBuL57+xfHeTrQRoZMwYFUZXgyvICXVzEUBgVzOY9UESompLwLeNTQ2
   9kZb6+Xm17YgpkJA29o7kDLnk4zL49hG1IPOI7W1xFep3+eS8lksZTaxE
   spfqxtenDtsccEQFCoNHvG10QcPk3RB5m5ogyeA93qmR/EmQ/eWtfXzTd
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="287014751"
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="287014751"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 09:18:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="602491098"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 09:18:49 -0700
Date:   Tue, 2 Aug 2022 09:18:47 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     bp@alien8.de, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, x86@kernel.org
Subject: [PATCH v2] RAS/CEC: Reduce offline page threshold for Intel systems
Message-ID: <YulOZ/Eso0bwUcC4@agluck-desk3.sc.intel.com>
References: <a871b8bd35604921b842dcd65aed0f6c@intel.com>
 <20220701191239.619940-1-tony.luck@intel.com>
 <YukTfuX3QmKV4msI@yaz-fattaah>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YukTfuX3QmKV4msI@yaz-fattaah>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A large scale study of memory errors on Intel systems in data centers
showed that aggressively taking pages with corrected errors offline is
the best strategy of using corrected errors as a predictor of future
uncorrected errors.

Set the threshold to "2" on Intel systems. AMD guidance is that this is
not necessary for their systems.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---

V2:
	Fix some spelling errors. 
	Add note to commit that AMD systems do not need this.
	Add Yazen's Reviewed-by tag.

 drivers/ras/cec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 42f2fc0bc8a9..321af498ee11 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -556,6 +556,14 @@ static int __init cec_init(void)
 	if (ce_arr.disabled)
 		return -ENODEV;
 
+	/*
+	 * Intel systems may avoid uncorrectable errors
+	 * if pages with corrected errors are aggressively
+	 * taken offline.
+	 */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		action_threshold = 2;
+
 	ce_arr.array = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!ce_arr.array) {
 		pr_err("Error allocating CE array page!\n");
-- 
2.35.3

