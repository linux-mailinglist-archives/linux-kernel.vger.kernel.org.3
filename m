Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A39F5709BC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 20:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiGKSKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 14:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiGKSKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 14:10:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2785F13CFC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 11:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657563046; x=1689099046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2UgWlqXP52d73V37I18PoM3YgCtTRhnO/y/nfymCtKM=;
  b=DBrpc1MDqC71A7aj1P3zMqezV7ZbUVSf2sEDCKUdnFqpNWUP8GHtcT4V
   nbiQqTcEm4cBtRs08QlPcnQbXPmToD/5kAZ91nLUOxOltc4viXgs5f/Vg
   GDBiM6Vq5n5VM8r62hhyKB2a9N9kjtX2BVkWr0nuaC+f8j0+UnrPJzZMo
   IESOvnGZFHFQr/DBltcKK5dfny1BiWrBMHZlhbyTHssTslvOP7YYJDyKF
   otWY1TSVP8XWXmVIftaF+bxbVvLxYFR7d50S5JpcH3L5BC4UoHqAC0v1n
   FITC+h4je62iouOgFOu8y1xC2Qrz/MzWYIePMf5X30+eBSgISJAcsbB+a
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="310341572"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="310341572"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 11:10:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="684477133"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jul 2022 11:10:43 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 26BIAfWu032629;
        Mon, 11 Jul 2022 19:10:42 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] lib/test_bitmap: test the tail after bitmap_to_arr64()
Date:   Mon, 11 Jul 2022 20:09:30 +0200
Message-Id: <20220711180930.28271-3-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711180930.28271-1-alexandr.lobakin@intel.com>
References: <20220711180930.28271-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, test_bitmap_arr64() only tests bitmap_to_arr64()'s sanity
by comparing the result of double-conversion (bm -> arr64 -> bm2)
with the input bitmap. However, this may be not enough when one side
hides bugs of the second one (e.g. tail clearing, which is being
performed by both).
Expand the tests and check the tail of the actual arr64 used as
a temporary buffer for double-converting.

Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 lib/test_bitmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index d5923a640457..086b1d1db1ca 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -604,6 +604,12 @@ static void __init test_bitmap_arr64(void)
 			pr_err("bitmap_copy_arr64(nbits == %d:"
 				" tail is not safely cleared: %d\n", nbits, next_bit);
 
+		if ((nbits % 64) &&
+		    (arr[(nbits - 1) / 64] & ~GENMASK_ULL((nbits - 1) % 64, 0)))
+			pr_err("bitmap_to_arr64(nbits == %d): tail is not safely cleared: 0x%016llx (must be 0x%016llx)\n",
+			       nbits, arr[(nbits - 1) / 64],
+			       GENMASK_ULL((nbits - 1) % 64, 0));
+
 		if (nbits < EXP1_IN_BITS - 64)
 			expect_eq_uint(arr[DIV_ROUND_UP(nbits, 64)], 0xa5a5a5a5);
 	}
-- 
2.36.1

