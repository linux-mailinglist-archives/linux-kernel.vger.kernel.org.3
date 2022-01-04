Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5BD48429A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbiADNik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:38:40 -0500
Received: from mga12.intel.com ([192.55.52.136]:45362 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229700AbiADNij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641303519; x=1672839519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VgbAQpftXwrGIO11WeKJEI86gSonJP5etagd1SMrm8M=;
  b=Ahk9LesHPnUAFKHYPC486vFphD2fGNimG6qRD5+nXXTO6wPbTWzzJEZN
   5S3FGaDKkaRzR+13vxUMP9Xb0t+TWTr+8w8dcjdbxinl6c4i5+0VhQ7TH
   JlQKenV1ZDQik2hcZXwCfU7XmY9L1XGwP2UHQqKEQZCYmoItt3baTPlOE
   IM1A96FW9XOX50eI+BBYXxyKOdepqCwp3Ci4aPc4RzrfzVQkYtn4L3n9E
   pubqsWZqj25BPUsddCSHaEBtakufkv2sOKbDnRAK+oIcLE4jM75dvfYeH
   yujtOV+zRl/nagfsh09jy7cUyxBhGEVzQwyB58lQsLPJdqfwKrBGYdhTa
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="222216293"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="222216293"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 05:38:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="760439210"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2022 05:38:35 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0249B512; Tue,  4 Jan 2022 15:38:45 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>
Subject: [PATCH v1 5/5] thunderbolt: Drop duplicate NULL checks around nvmem_unregister()
Date:   Tue,  4 Jan 2022 15:38:43 +0200
Message-Id: <20220104133843.44272-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220104133843.44272-1-andriy.shevchenko@linux.intel.com>
References: <20220104133843.44272-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since nvmem_unregister() checks for NULL, no need to repeat in
the caller. Drop duplicate NULL checks.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/thunderbolt/nvm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
index 3a5336913cca..b3f310389378 100644
--- a/drivers/thunderbolt/nvm.c
+++ b/drivers/thunderbolt/nvm.c
@@ -154,10 +154,8 @@ int tb_nvm_add_non_active(struct tb_nvm *nvm, size_t size,
 void tb_nvm_free(struct tb_nvm *nvm)
 {
 	if (nvm) {
-		if (nvm->non_active)
-			nvmem_unregister(nvm->non_active);
-		if (nvm->active)
-			nvmem_unregister(nvm->active);
+		nvmem_unregister(nvm->non_active);
+		nvmem_unregister(nvm->active);
 		vfree(nvm->buf);
 		ida_simple_remove(&nvm_ida, nvm->id);
 	}
-- 
2.34.1

