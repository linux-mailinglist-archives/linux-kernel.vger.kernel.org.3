Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097D44B29CD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350495AbiBKQJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:09:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349766AbiBKQJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:09:40 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A464721D;
        Fri, 11 Feb 2022 08:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644595779; x=1676131779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/s3WrC1VyQ0ot4B6GyjX4d2vaEYezW/7+rzPNjdE6R8=;
  b=Ydl9q5gtIoDWZbS9L71ryu/pqgZW6kwgNinFHfdUXs9G0Qgy2p9hXMLz
   QbGSECEtCjoYOBwW4oQLEDbitoPHLOo+6lUVYUJCukIhReZSjKLy0NGnR
   yIf8AtKpMqH9f2tS3EVd45tSvdVubsEcjBpHidJp1wm2QcDAp9xmaoZf9
   g3JZnhRak1NIPcx65DVW5aPMJC9TIYScl9ksPiXTk5FO2r46Gj8FwOGoy
   hRiX4BJ00oLk6jH0JPXHFmSBrQUY2N8yTLinWkj3Tx0+KtNzXVoaDEnjh
   pQ/FjrlGZY8tjf8KB7GhN1VWcwATOWPF6jtzPlx4wHZOHD2z9eVLMh2Mu
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="249703806"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="249703806"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 08:09:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="630393689"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga002.fm.intel.com with ESMTP; 11 Feb 2022 08:09:38 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 1/6] ACPI / fan: Fix error reporting to user space
Date:   Fri, 11 Feb 2022 08:09:27 -0800
Message-Id: <20220211160932.3221873-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220211160932.3221873-1-srinivas.pandruvada@linux.intel.com>
References: <20220211160932.3221873-1-srinivas.pandruvada@linux.intel.com>
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

When user get/set cur_state fails, it should be some negative error
value instead of whatever returned by acpi_evaluate_object() or from
acpi_execute_simple_method(). The return value from these apis is
some positive values greater than 0. For example if AE_NOT_FOUND
is returned it will be "5".

In other ACPI drivers, -ENODEV is returned when ACPI_FAILURE(status)
is true. Do the same thing here for thermal sysfs callbacks for
get and set for failures.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/fan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 5cd0ceb50bc8..098d64568d6d 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -107,7 +107,7 @@ static int fan_get_state_acpi4(struct acpi_device *device, unsigned long *state)
 	status = acpi_evaluate_object(device->handle, "_FST", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
 		dev_err(&device->dev, "Get fan state failed\n");
-		return status;
+		return -ENODEV;
 	}
 
 	obj = buffer.pointer;
@@ -195,7 +195,7 @@ static int fan_set_state_acpi4(struct acpi_device *device, unsigned long state)
 					    fan->fps[state].control);
 	if (ACPI_FAILURE(status)) {
 		dev_dbg(&device->dev, "Failed to set state by _FSL\n");
-		return status;
+		return -ENODEV;
 	}
 
 	return 0;
-- 
2.34.1

