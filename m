Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A0C5709BA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 20:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiGKSKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 14:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKSKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 14:10:45 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524F613CFC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 11:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657563044; x=1689099044;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vt8/DjslHCL4p3rAVCwPqTJm5pcwwqba5T1m8mlAAW8=;
  b=a+8f20w3R09IwCqi7Ytu7wO+UNMGNDaRlFD67PPfpd+GXz/jpoJ+CoUT
   T7S0NHR+4T9hEB05kLMdmwy7GMUmn3S+dkBSA1GeT8pxGZ7jAa33SLjJg
   vlXIEe6R4PaeigBY+7guc/+EVSlXYbTGiSPVcXb96hYG0xejqKwjFqfhf
   tzFHwPwf0bt1ZYGiPZe+Is/XCEQ3yyh1AfqeFht3OqbZ8lZiAtPPQ9ByA
   K2VmtP4onmg8pcrM3V0SOxm8wr6tKNStvz2YqQCmLQOTqX9n4cZshcUpg
   rQoJMx2t8hg5aWQLWGLCbf3aY0tcDGXBuZPA/rsibE+kxJSwX96hygGDB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="346418695"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="346418695"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 11:10:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="569876182"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga006.jf.intel.com with ESMTP; 11 Jul 2022 11:10:42 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 26BIAfWs032629;
        Mon, 11 Jul 2022 19:10:41 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] lib/bitmap: fix off-by-one in bitmap_to_arr64()
Date:   Mon, 11 Jul 2022 20:09:28 +0200
Message-Id: <20220711180930.28271-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix tail clearing in bitmap_to_arr64() for 32-bit BEs and expand
the tests to cover the bug being fixed.

Alexander Lobakin (2):
  lib/bitmap: fix off-by-one in bitmap_to_arr64()
  lib/test_bitmap: test the tail after bitmap_to_arr64()

 lib/bitmap.c      | 2 +-
 lib/test_bitmap.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)


base-commit: 32346491ddf24599decca06190ebca03ff9de7f8
-- 
2.36.1

