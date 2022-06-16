Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5C154E837
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbiFPRAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239381AbiFPQ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:58:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7F43E5C5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655398711; x=1686934711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HDhkQjB1m5InUrtWZxmERWvNg1OJJDFC7pB+LdGiCZo=;
  b=i26k5of7SybPkqNtwfHQ9vCSaDdCgYs4rdgQneEqbh26SPsNQmLJA5OE
   lTuAjjVHrya83OkZNHtnAffN3fI28qrOO2LbuZy4p4NV5mZ6VkjBitZ5Q
   zB5Cu5xfQdRK8cPKPUJOPJhG08WhufWCqeunSgnhd3dgITla4lJLNFpxW
   Lf3C+B+baPQgTJ38lglCxo4A0hwv8EEc62tuA/R9b4QU8U+79O25WfZVI
   DxVUbBcqXE7bZgVyzJpNLJyk/vle8rXa2pynxfAX/gqcmNPH2agzfWhug
   vssNeX69xEUtpvKnBIdphGo577ZtodOiHFgzDXpTHQyk7UnuKSu/pmHRn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="276870461"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="276870461"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 09:58:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="559894733"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 16 Jun 2022 09:58:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B82715E2; Thu, 16 Jun 2022 19:58:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v1 10/11] mfd: intel_soc_pmic_bxtwc: Drop unneeded casting
Date:   Thu, 16 Jun 2022 19:58:22 +0300
Message-Id: <20220616165823.4919-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
References: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The casting from size_t to ssize_t is not needed in addr_store(),
drop it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 4e890f095721..953f535a3c93 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -348,7 +348,7 @@ static ssize_t addr_store(struct device *dev,
 		return ret;
 	}
 
-	return (ssize_t)count;
+	return count;
 }
 
 static ssize_t val_show(struct device *dev,
-- 
2.35.1

