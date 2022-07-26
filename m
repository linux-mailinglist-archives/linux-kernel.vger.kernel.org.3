Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B892B581500
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238868AbiGZOUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbiGZOUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:20:43 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7935725C6D;
        Tue, 26 Jul 2022 07:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658845242; x=1690381242;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GlQ9wisk+Ne/nPJz0ZTYMldQTFRMHyp+0I/clyx38i8=;
  b=Pr+K625bt3NQ+sJD5Jty0DD4ydeIgO+zjBM625nVadf6aXsqoZL2x/zk
   /116s47ivrcQoUsrKQLDxSnvsO0/duWDxdPDhwmCgIn7H28mn3ZsvZ2cq
   9A97IhXkIUXIIZfi1yhPf4LhyU5JMelcF7n8WnAvtzhs7CIesBIGa7f1u
   mn6fh+5BZe2zxcHPsC0rf7WUwsTR2E2vfW6G9IP1j+7dzuE1RRKjFT+u0
   RaLDgXLFU07oiyUTvHB9hGP/UneNVPPrytUv2gkoW7H+y4A5Xb6r7PU1t
   wSz8F03ynTUdX8b++p0eCYjG1afeiazMM0SSxiFvnEu9YcGCDKfWOHJPa
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="267731544"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="267731544"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 07:20:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="742249865"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jul 2022 07:20:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7651CF1; Tue, 26 Jul 2022 17:20:50 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tomislav Denis <tomislav.denis@avl.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: pressure: dlhl60d: Don't take garbage into consideration when reading data
Date:   Tue, 26 Jul 2022 17:20:48 +0300
Message-Id: <20220726142048.4494-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both pressure and temperature are 24-bit long. Use proper accessors
instead of overlapping readings.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/pressure/dlhl60d.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60d.c
index 5f6bb3603a8b..f0b0d198c6d4 100644
--- a/drivers/iio/pressure/dlhl60d.c
+++ b/drivers/iio/pressure/dlhl60d.c
@@ -129,9 +129,8 @@ static int dlh_read_direct(struct dlh_state *st,
 	if (ret)
 		return ret;
 
-	*pressure = get_unaligned_be32(&st->rx_buf[1]) >> 8;
-	*temperature = get_unaligned_be32(&st->rx_buf[3]) &
-		GENMASK(DLH_NUM_TEMP_BITS - 1, 0);
+	*pressure = get_unaligned_be24(&st->rx_buf[1]);
+	*temperature = get_unaligned_be24(&st->rx_buf[4]);
 
 	return 0;
 }
-- 
2.35.1

