Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1E8595958
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbiHPLEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbiHPLD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:03:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B35F996E;
        Tue, 16 Aug 2022 03:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660644986; x=1692180986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nJljPCZZ6aUR0hItDYXXREgJNCgutz8/X/G4rnfyXUs=;
  b=WzO1vPJikVc74zTxKwcWq0LUW8LuKjm4bxjnw3Yb5LIpfBx+fZa6sNby
   liWneasXsbSQwWoT3+oXm0vbZfFnzPZeUiljJ/0SZQeaM5jM2MQz37Fm0
   jZGvc0xIZC8FADUgYIn+KemuyM3PI3m1H2Y+lDWxSJVHSXxsBZsM6wLEm
   EvZ6LeolSOEn//eJg7fcMvYw6jJj6Ad4Jcr/U7oJsjAWcyhQfybsB3ySq
   rqNj5UiGe2LEUmnkgfZrW4XfrOV+SOUEX2BNffBapmTwTZ9sAyVI54OSY
   0WYlQOGwmK+cJINKiBglbDBmeybjoMicaq18JiJwYc5sywu2m0++W7Mmp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="279141266"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="279141266"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 03:16:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="749260762"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 16 Aug 2022 03:16:21 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Utkarsh Patel <utkarsh.h.patel@intel.com>, rajmohan.mani@intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 2/6] ACPI: resource: Filter out the non memory resources in is_memory()
Date:   Tue, 16 Aug 2022 13:16:25 +0300
Message-Id: <20220816101629.69054-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220816101629.69054-1-heikki.krogerus@linux.intel.com>
References: <20220816101629.69054-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will generalise the function so it should become
useful in more places.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 510cdec375c4d..e644e90d18847 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -690,6 +690,9 @@ static int is_memory(struct acpi_resource *ares, void *not_used)
 
 	memset(&win, 0, sizeof(win));
 
+	if (acpi_dev_filter_resource_type(ares, IORESOURCE_MEM))
+		return 1;
+
 	return !(acpi_dev_resource_memory(ares, res)
 	       || acpi_dev_resource_address_space(ares, &win)
 	       || acpi_dev_resource_ext_address_space(ares, &win));
-- 
2.35.1

