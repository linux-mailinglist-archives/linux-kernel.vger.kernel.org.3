Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF795A5902
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 03:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiH3BvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 21:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiH3BvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 21:51:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E41476753
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 18:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661824266; x=1693360266;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TJaa7NPIQMMfRVxnqj/u/WhocpvUjB4OFaLsFLxwmS0=;
  b=MxS9b1WGStjS5NX76Rt1Z83zwyMh0sgOFCbviJ9wOHHhBB7jZeEy/xjZ
   RfM1qK/tCEniFcZOAi/edlRAOKBQUbwSpxZ8eYU0O7yWvNCFtr3PPOQvm
   NWQ/j/He/WLV54jI2H9D/1UR7gSoaCO+QRdfDqHHRwYUdf1X3yCXY/0YS
   +0KhLA0eE1Ig1y1vAym2QLzVexUgudTUgeRZbxM0MONW+Qwt4pRri68sW
   NHsJ5llixWGghvY6B474USxKBR5cTuA6qAXNHAOVUhTVnWnBi2qw7bzuy
   fP7FznanIUppQJq6PuJNw+Gj8v7D12mlKoaIUyXKDG4p/alDzIH3k84+N
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="381349102"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="381349102"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 18:51:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="641167025"
Received: from q.bj.intel.com ([10.238.154.102])
  by orsmga008.jf.intel.com with ESMTP; 29 Aug 2022 18:51:03 -0700
From:   shaoqin.huang@intel.com
To:     rppt@kernel.org
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 0/3] Add tests trying to memblock_add() or memblock_reserve() 129th region
Date:   Tue, 30 Aug 2022 09:49:16 +0800
Message-Id: <20220830014925.162718-1-shaoqin.huang@intel.com>
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

