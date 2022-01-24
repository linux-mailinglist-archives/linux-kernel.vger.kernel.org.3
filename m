Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB1549877D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244835AbiAXSBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:01:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:41944 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244841AbiAXSAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:00:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643047232; x=1674583232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GQ5E0i+zBiGPpozPgnHLAnkyvtSeafp3A0mHCHJieDY=;
  b=aQlCK2Kk4zwsmu+vElfLBMXsITM8rTkMejV/LhKEM+PsPJ24mgX9U7Qo
   YNXkpC33aY763VFEUrMM4V2ucUVFqygvEMMjgnBNePvKnzbIjr6Db8F8Y
   mbcrB1iiRX8yEn0bp/xwnuTjFzv0raumScWJA/j4qF/9ozBzaujYAc1vl
   hupqwk0sYHJhQrEjiwm3f0HR1Jylxp69RJaMTqdxwxVAIu6qJ5D5gAre0
   WoJDUGhYwDTGmv4Q+6vvtRfrSiKztY4GHk3BEbs8FBCsG5ZYf4Mm5pgB5
   W3sP6y23eCSK8Qp9wGN6Xj4Cs9HMDUlxbckbA+NeZJWcMhkQvEaSw6x1v
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="244942117"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="244942117"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 10:00:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="766479413"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jan 2022 10:00:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8101BA51; Mon, 24 Jan 2022 20:00:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: [PATCH v2 5/5] thunderbolt: Drop duplicate NULL checks around nvmem_unregister()
Date:   Mon, 24 Jan 2022 20:00:40 +0200
Message-Id: <20220124180040.50660-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124180040.50660-1-andriy.shevchenko@linux.intel.com>
References: <20220124180040.50660-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since nvmem_unregister() checks for NULL, no need to repeat in
the caller. Drop duplicate NULL checks.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
v2: added tag (Mika)
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

