Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519F7507BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357967AbiDSVWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355594AbiDSVWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:22:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5117241309;
        Tue, 19 Apr 2022 14:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650403168; x=1681939168;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WhXECTf3/mPf+krPicUL/PhJxyTSG44MJLyCJeT0ht4=;
  b=ejZpCAkqmvj5PCJ91v7NMJiu4OHKU96vDSFkjEVZVboGFe+kSFhOB8RH
   iFuydr6kTT1uXLPkLqsX6/BUuMFN1ht5TUirOpcsT8w+dnvJHYZIuAqwN
   TBNP8c2oNLjAkJW5IUYZJlGn0VThyoul8JMVR1yi3EtiFsph3LnOEIKGd
   E8amrKICyGoDmPz7ZmAnpVaEAAYTLUqM5Y1urz07Hlrr///jVV4uIwi3G
   85lLRCu8BSYdGMd9Xaei42t6skMjb/RSHjo1+3nA4dUYcz9oPviMFuyF+
   vHxv93gQFrrxh/wrSo/2t39MAGLfmhIqBUwguhsofvFQ6r/+FlhrybvEq
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="263338484"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="263338484"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 14:19:28 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="530778373"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 14:19:27 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] ACPI, APEI, EINJ: Refuse to inject into the zero page
Date:   Tue, 19 Apr 2022 14:19:21 -0700
Message-Id: <20220419211921.2230752-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some validation tests dynamically inject errors into memory used by
applications to check that the system can recover from a variety of
poison consumption sceenarios.

But sometimes the virtual address picked by these tests is mapped to
the zero page.

This causes additional unexpected machine checks as other processes that
map the zero page also consume the poison.

Disallow injection to the zero page.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---
I picked -EADDRINUSE as a somewhat descriptive error code distinct
fromm -EINVAL used elsewhere in EINJ, but I'm not strongly attached
to it. Any other non -EINVAL value would be as good an indicator to
the validation tests that they shouldn't inject to this address.
---
 drivers/acpi/apei/einj.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 95cc2a9f3e05..d4326ec12d29 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -549,6 +549,9 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	     !arch_is_platform_page(base_addr)))
 		return -EINVAL;
 
+	if (is_zero_pfn(base_addr >> PAGE_SHIFT))
+		return -EADDRINUSE;
+
 inject:
 	mutex_lock(&einj_mutex);
 	rc = __einj_error_inject(type, flags, param1, param2, param3, param4);
-- 
2.35.1

