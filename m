Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F089359B7B8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 04:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbiHVCeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 22:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiHVCeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 22:34:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51C822BED
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 19:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661135646; x=1692671646;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TJaa7NPIQMMfRVxnqj/u/WhocpvUjB4OFaLsFLxwmS0=;
  b=jdhE0usXc07BA/2g/chfwU0ey7uTF25hFSex6fxLEk1gDBYSvSJUwmT2
   OU+DpLDQMH69tbe3P2gg4uAzCmzlaKz1ODfY5vy0K659W/+IoTqJGN2ZQ
   7iL8X/1lswJvC51YRCSid15AnqybHIWZGIVZGfsW/Ui97A2hpOR53iVyE
   23uqZIqVRHSYYydkHwU3juTtoB09P3Vtmdc+lCVM6MVv4dg+QsJbjFp59
   I0Wjk8xE0UTS8uxllqsL1NSVoJb2kVoqMmrkUwrnBg2zYCvkD5ezKTYaQ
   0bjTa5ImFTvhicxzczl058ER2HYKHKCmqSmBiAshU0ysAm6B8D8A07dJf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="290861421"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="290861421"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 19:34:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="936850985"
Received: from q.bj.intel.com ([10.238.154.102])
  by fmsmga005.fm.intel.com with ESMTP; 21 Aug 2022 19:34:04 -0700
From:   shaoqin.huang@intel.com
To:     rppt@kernel.org
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add tests trying to memblock_add() or memblock_reserve() 129th region
Date:   Mon, 22 Aug 2022 10:33:25 +0800
Message-Id: <20220822023332.127633-1-shaoqin.huang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

Shaoqin Huang (3):
  memblock test: Add test to memblock_add() 129th region
  memblock test: Add test to memblock_reserve() 129th region
  memblock test: Update TODO list

 tools/testing/memblock/TODO              |  11 +-
 tools/testing/memblock/tests/basic_api.c | 169 +++++++++++++++++++++++
 tools/testing/memblock/tests/common.c    |   7 +-
 tools/testing/memblock/tests/common.h    |   3 +
 4 files changed, 179 insertions(+), 11 deletions(-)

-- 
2.34.1

