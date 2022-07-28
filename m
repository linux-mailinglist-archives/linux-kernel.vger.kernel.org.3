Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC555822E4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiG0JOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiG0JOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:14:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D81627A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658913216; x=1690449216;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m1SaoX9uSfbY4s1EjmnVRFaXJa0od/V0m4Hy6L3DAng=;
  b=BKqB3Z7zoykG+VFg65r0QbvqVcZtl9RCqaSZI6CApwPvMydRZ3xdSUsS
   EBlBWezx2Dymc8PVSCzntNFE6E5cTpQS7EgCa8mf8AOdwi45UsQEPu0Mn
   w7Q3GKFcQwOWvypT+6aW0QM29v2fOxDV5zInmiauJj2LVMKhInpX2b160
   v8SymIP6Apx/uuZNr/edq8WMMynUMTSciMBrv+cApnkIveKuAEty9ZnWh
   cSihvJjObXYojndSM/B0G2bhfP5Vd699noGjgVuOCjr5cDXrI1rciYjZE
   quiXBmFNvM0RWQUhoxWQ/e3fBkU10xMUkQRaog9QYwvp3msEY8TPfSK0X
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="288196872"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="288196872"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 02:13:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="659113574"
Received: from q.bj.intel.com ([10.238.154.102])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jul 2022 02:13:34 -0700
From:   shaoqin.huang@intel.com
To:     rppt@kernel.org
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] memblock test: Modify the obsolete description in README
Date:   Wed, 27 Jul 2022 18:16:15 -0600
Message-Id: <20220728001615.19099-1-shaoqin.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaoqin Huang <shaoqin.huang@intel.com>

The VERBOSE option in Makefile has been moved, but there still have the
description left in README. For now, we use `-v` options when running
memblock test to print information, so also add some description about
it.

Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
---
 tools/testing/memblock/README | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/testing/memblock/README b/tools/testing/memblock/README
index 058146b528a5..f39cc0aa6b76 100644
--- a/tools/testing/memblock/README
+++ b/tools/testing/memblock/README
@@ -33,20 +33,21 @@ To run the tests, build the main target and run it:
 
 $ make && ./main
 
-A successful run produces no output. It is also possible to override different
-configuration parameters. For example, to include verbose output, specify the
-VERBOSE flag when building the main target:
+A successful run produces no output. It it also possible to override different
+configuration parameters. For example, to simulate enabled NUMA, use:
 
-$ make VERBOSE=1
+$ make NUMA=1
 
-This will print information about which functions are being tested and the
-number of test cases that passed.
+For the full list of options, see `make help`.
 
-To simulate enabled NUMA, use:
+It is also possible to pass options at run time. For example:
 
-$ make NUMA=1
+$ ./main -v
 
-For the full list of options, see `make help`.
+This will print information about which functions are being tested and the
+number of test cases that passed.
+
+For the full list of options, see `./main --help`.
 
 Project structure
 =================
-- 
2.30.2

