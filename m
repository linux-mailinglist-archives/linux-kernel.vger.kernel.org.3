Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BF55AA5FB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 04:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbiIBCkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 22:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbiIBCkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 22:40:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5642F65D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 19:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662086424; x=1693622424;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=impd6WjP2thIEehJI5+uZ5bcDT4a9RhBaFzwyQItnEg=;
  b=JYlsEAEMgaTliH9qP+vSuMBUKREqsl5fv4ks+ptO96PA2q82244ZTlZD
   jkiBvvSAkh3Sqw8DSblCmtra9B4N1qpDcheZUwpiARldy6PgwhmVYHs0A
   2o65KEUHqvo0QwSjQgCDY3QcVTnvcIh6GaYyo8aIdIyJSMyOedIWd8rgJ
   Ab90dFhvJrpOGls/pVQaSSK4lAXwig4skUFnFix4//O1Dw1VXbLrRgMP0
   hkvV0Yy5kHFIwMWYnZFVMIjIKlFMkaoT0dmngCT/bhrS09+NHIhgtrEdV
   EZPt53vLXZh6mXjQxIvwv5/IbyJpoE7tkjwpqBiJGowx6HsZOKfx5BCHc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="357594043"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="357594043"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 19:40:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="589841424"
Received: from q.bj.intel.com ([10.238.154.102])
  by orsmga006.jf.intel.com with ESMTP; 01 Sep 2022 19:40:21 -0700
From:   shaoqin.huang@intel.com
To:     rppt@kernel.org
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v2 0/3] Add tests trying to memblock_add() or memblock_reserve() 129th region
Date:   Fri,  2 Sep 2022 10:39:58 +0800
Message-Id: <20220902024007.58041-1-shaoqin.huang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaoqin Huang <shaoqin.huang@intel.com>

These tests is aimed for testing the memblock_double_array() can work normal. It
will using the dummy_physical_memory_init() to add the valid memory region into
the memblock.memory, and this memory region will be choosed when
memblock_double_array() to allocate the new memory region to double the regions.
Thus the new memory.regions or reserved.regions will occupy the valid memory
region, and the memory.max and reserved.max also being doubled. Check all of
these changed stuff, to make sure it actually success.

Changelog:
----------
v2:
  - Modify the get_memory_block_base() to dummy_physical_memory_base().
  - memory_add() the memory which is allocated from dummy_physical_memory_init()
  instead of some faked memory.
  - Add more comments to illustrate the test process.
  - Add a function dummy_physical_memory_cleanup_many() to free multiple memory
  which is allocated from dummy_physical_memory_init().

Shaoqin Huang (3):
  memblock test: Add test to memblock_add() 129th region
  memblock test: Add test to memblock_reserve() 129th region
  memblock test: Update TODO list

 tools/testing/memblock/TODO              |  11 +-
 tools/testing/memblock/tests/basic_api.c | 187 +++++++++++++++++++++++
 tools/testing/memblock/tests/common.c    |  15 +-
 tools/testing/memblock/tests/common.h    |   4 +
 4 files changed, 206 insertions(+), 11 deletions(-)

-- 
2.34.1

