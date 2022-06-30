Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CFB562335
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 21:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbiF3Tcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 15:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236406AbiF3Tcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:32:32 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D065A43AE9;
        Thu, 30 Jun 2022 12:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656617551; x=1688153551;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ocg7Ykq5fMHXKIUVNuvhYpRmb19A+aY/BAHlP7Tz+b0=;
  b=JZSRDE29iMLpha5Il7V7FIhJSPlrQmvi7jjMvKF5f0j1onueDYglOYtt
   vkwbqo83OyIjoHWgxB3PAJ+NjEhcg15mYgHRXHHmKWZCAdxFIrmICgepL
   vj2aH9FwDd7ISLU/Ibm1dof7jRbA3/8Tw43i5X+KxYvvIXy7Ls1xMq6oD
   aCeIk2MWwzKYIK+0NTJYGutks9DEwHcCDW/fieP8nZ4iyld/91qikNO5G
   sZvdEGbhG5vu4+YHb5JixFFR3ZbGjUld+aM8GtwyLOmSD4IbjY9lNHyta
   OQNTswOUbufLJp8pcKlkqnzYud34qDz4afYa2zniqs4s+2uzR31q8LmuM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="262849192"
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="262849192"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 12:32:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="837728457"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jun 2022 12:32:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C641411E; Thu, 30 Jun 2022 22:32:35 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Subject: [PATCH v1 1/1] platform/x86: asus-wireless: Replace open coded acpi_match_device()
Date:   Thu, 30 Jun 2022 22:32:34 +0300
Message-Id: <20220630193234.3499-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded acpi_match_device() in asus_wireless_add().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/asus-wireless.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/asus-wireless.c b/drivers/platform/x86/asus-wireless.c
index d3e7171928e5..2281a3b7d958 100644
--- a/drivers/platform/x86/asus-wireless.c
+++ b/drivers/platform/x86/asus-wireless.c
@@ -148,13 +148,9 @@ static int asus_wireless_add(struct acpi_device *adev)
 	if (err)
 		return err;
 
-	for (id = device_ids; id->id[0]; id++) {
-		if (!strcmp((char *) id->id, acpi_device_hid(adev))) {
-			data->hswc_params =
-				(const struct hswc_params *)id->driver_data;
-			break;
-		}
-	}
+	id = acpi_match_device(adev, device_ids);
+	if (id)
+		data->hswc_params = (const struct hswc_params *)id->driver_data;
 	if (!data->hswc_params)
 		return 0;
 
-- 
2.35.1

