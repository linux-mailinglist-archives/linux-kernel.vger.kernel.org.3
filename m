Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7170E5709BB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 20:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiGKSKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 14:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiGKSKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 14:10:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BBC13D19
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 11:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657563045; x=1689099045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hsOLQf/Ey5fXFw8rD7/ny7InOv0adjlq6qZFdlk12V4=;
  b=ly6asgvG0oDTMpT/XjKmdQpAYV0hFFzAPJfNYIUoqdmVx2vlN6HyyJN2
   9sjeIuqjL+IbagGZWKvktJ4GXc9uPQHpAfp+JyYMhfhlMSHf3UnOZxsSE
   Wv/Oa7djSb3IGWpR7mcom3BsselAfa94yuxtkhkzXTFR5JOih3+gyX4Ri
   Kc0apJfSmN/cWxPYwwnqtqVowzKFZnKiJz17VTXv7R05QjrIENHN9LrbY
   mgQaf7sOYOL45VHi4Us44uUE/brOMvuGixlCiBO7fU1QZ7det0+1pwPBj
   ApXSfTdneDCpiVWO9BJkJo0bO4NLJw1nK5FG+gwm1men/vzAxT8YBu/mf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="285477397"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="285477397"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 11:10:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="921884666"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jul 2022 11:10:43 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 26BIAfWt032629;
        Mon, 11 Jul 2022 19:10:42 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] lib/bitmap: fix off-by-one in bitmap_to_arr64()
Date:   Mon, 11 Jul 2022 20:09:29 +0200
Message-Id: <20220711180930.28271-2-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711180930.28271-1-alexandr.lobakin@intel.com>
References: <20220711180930.28271-1-alexandr.lobakin@intel.com>
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

GENMASK*() family takes the first and the last bits of the mask
*including* them. So, with the current code bitmap_to_arr64()
doesn't clear the tail properly:

nbits %  exp             mask                must be
1        GENMASK(1, 0)   0x3                 0x1
...
63       GENMASK(63, 0)  0xffffffffffffffff  0x7fffffffffffffff

This was found by making the function always available instead of
32-bit BE systems only (for reusing in some new functionality).
Turn the number of bits into the last bit set by subtracting 1.
@nbits is already checked to be positive beforehand.

Fixes: 0a97953fd221 ("lib: add bitmap_{from,to}_arr64")
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 lib/bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index b18e31ea6e66..e903e13c62e1 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1564,7 +1564,7 @@ void bitmap_to_arr64(u64 *buf, const unsigned long *bitmap, unsigned int nbits)
 
 	/* Clear tail bits in the last element of array beyond nbits. */
 	if (nbits % 64)
-		buf[-1] &= GENMASK_ULL(nbits % 64, 0);
+		buf[-1] &= GENMASK_ULL((nbits - 1) % 64, 0);
 }
 EXPORT_SYMBOL(bitmap_to_arr64);
 #endif
-- 
2.36.1

