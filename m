Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DFC52D25A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237868AbiESMV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237930AbiESMVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:21:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE3F6341;
        Thu, 19 May 2022 05:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652962865; x=1684498865;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oBSyY7X6t4ROiq+8EMvXp6xQPws7d2kgaBMrTI4wyuU=;
  b=XWNeSRmhJDcQ9jhn0fJW5Ucc9pFbFStj1jTeTlsPkEQ6op4v0uuwb2yQ
   r6rcdDU56u7MfPRrHAR1RIdxL8+S881p2e6p0/eSciF1e1UesyqDbEm/w
   VvkCiQjrNRNs2o3BnyYEt98YCvk8RcLNXV9Y1OtYsN729Vvqf0OkICsZK
   jhHuvEeH2FCCmGmfb2xjRxZbHh3xnNq02V2SEGUZNeWTTbp0lQI+4AO8N
   jL2APZKhNA+c5tg2D1AqbC9Gye6AP+5mkNs6dIWefrTt0xcY119KrGL0J
   Hyx4ngLHFAzdeJkcCTjpq1tF9lUDuHcyICUHQeHrKK7Ro2oZoseZ9FfGV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="259755724"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="259755724"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 05:21:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="714956163"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 May 2022 05:21:02 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: intel_cht_int33fe: Set driver data
Date:   Thu, 19 May 2022 15:21:03 +0300
Message-Id: <20220519122103.78546-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Module removal fails because cht_int33fe_typec_remove()
tries to access driver data that does not exist. Fixing by
assigning the data at the end of probe.

Fixes: 915623a80b5a ("platform/x86: intel_cht_int33fe: Switch to DMI modalias based loading")
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/platform/x86/intel/chtwc_int33fe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel/chtwc_int33fe.c b/drivers/platform/x86/intel/chtwc_int33fe.c
index 0de509fbf0209..c52ac23e23315 100644
--- a/drivers/platform/x86/intel/chtwc_int33fe.c
+++ b/drivers/platform/x86/intel/chtwc_int33fe.c
@@ -389,6 +389,8 @@ static int cht_int33fe_typec_probe(struct platform_device *pdev)
 		goto out_unregister_fusb302;
 	}
 
+	platform_set_drvdata(pdev, data);
+
 	return 0;
 
 out_unregister_fusb302:
-- 
2.35.1

