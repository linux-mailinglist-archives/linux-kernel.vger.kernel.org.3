Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09916586824
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiHALaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiHALaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:30:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FDDF38;
        Mon,  1 Aug 2022 04:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659353413; x=1690889413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mlYxe9gaRcgUxVknwnoNrUFSbJOlEiaAojDJfMv751I=;
  b=cfHfDhsYXG8TS9Cw8EoSJEOQ4r1xfytZBCmLTw/SluCq7sFa/n2QcNd0
   j6ERpwiXC/NUz+NQUUgByowWIVra7xFOkW3qRb2un185O0YbOam1VvI5A
   MSyG6rcSdR63+dYQ9qBXDaG9DU/4ogKNTxUC+rNR4lVKjo/PkVwC9Zk7V
   Br4frCtpHO1AKdiz4UVmRfQXejoYxd9VJe0HoXF8X1iwdgnn693n7cbJT
   lMmFRVWXzEVfymUI12O6WN7/l6wv4OqzrZfvSO7WAJTawz8LNBOwddrFH
   dxvpI5zs/3Bh3+z2hEAzEUReond/bzXalxMi4BgnlqNvB5YKzi5nPIO9M
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="314947188"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="314947188"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 04:30:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="630205468"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 01 Aug 2022 04:30:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1859B1D0; Mon,  1 Aug 2022 14:30:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>
Subject: [PATCH v1 2/4] platform/x86: pmc_atom: Improve quirk message to be less cryptic
Date:   Mon,  1 Aug 2022 14:30:16 +0300
Message-Id: <20220801113018.9882-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801113018.9882-1-andriy.shevchenko@linux.intel.com>
References: <20220801113018.9882-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not everyone can get what "critclks" means in the message, improve
it to make less cryptic.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/pmc_atom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
index c220172fefbb..4c3d6b48d2f0 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -354,7 +354,7 @@ static bool pmc_clk_is_critical = true;
 
 static int dmi_callback(const struct dmi_system_id *d)
 {
-	pr_info("%s critclks quirk enabled\n", d->ident);
+	pr_info("%s: PMC critical clocks quirk enabled\n", d->ident);
 
 	return 1;
 }
-- 
2.35.1

