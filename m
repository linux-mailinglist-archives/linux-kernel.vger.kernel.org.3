Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A5B5927A6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiHOB7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiHOB64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:58:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A6C12AB3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 18:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660528736; x=1692064736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oI6Y/L8l9dauwG68bQ11LVdS0Udl7+FVb4OvAc1pUmE=;
  b=lPFkJCaJaT1aC7dMFdbSRdObgyjQYEeuHK86OZ9i054yJaXp0WrTKhEE
   QmFe8cTuIkmeGJVWY6L+RfFe7uknsHW1HL1Uq3oJhAhZSisS+1NFrXbr3
   3Y/e3enLWdJb4CG1Oxte/e8NtUkfBYQjDLbw+Rx61hBzx87ppnP3Q4Far
   soXv9VmcEAev5WuXW1KVcfycQs/wc3Hz0biNJ5lOPC3ajVyPHooGgdrva
   1Nod1wWwRtdLn7DIWVSeh3R6pX9nvj72+2i670itPPhFhO5ew5gUHsYYZ
   ltVUiF7PN/kxStN30ZBEO1t3LEghcty1i8QINlIrFTMtP7oG4E0qV0nu2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="292667546"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="292667546"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 18:58:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="557132003"
Received: from sse-cse-haiyue-nuc.sh.intel.com ([10.239.241.114])
  by orsmga003.jf.intel.com with ESMTP; 14 Aug 2022 18:58:52 -0700
From:   Haiyue Wang <haiyue.wang@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, david@redhat.com, linmiaohe@huawei.com,
        ying.huang@intel.com, songmuchun@bytedance.com,
        naoya.horiguchi@linux.dev, alex.sierra@amd.com,
        Haiyue Wang <haiyue.wang@intel.com>
Subject: [PATCH v4 0/2] fix follow_page related issues
Date:   Mon, 15 Aug 2022 09:59:07 +0800
Message-Id: <20220815015909.439623-1-haiyue.wang@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220812084921.409142-1-haiyue.wang@intel.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4: add '()' for the function for readability.
    add more words about the Non-LRU pages fix in commit message.

v3: Merge the fix for handling Non-LRU pages into one patch.
    Drop the break_ksm zone device page check.

v2: Add the Non-LRU pages fix with two patches, so that
    'mm: migration: fix the FOLL_GET' can be applied directly
    on linux-5.19 stable branch.

Haiyue Wang (2):
  mm: migration: fix the FOLL_GET failure on following huge page
  mm: fix the handling Non-LRU pages returned by follow_page

 mm/huge_memory.c |  4 ++--
 mm/ksm.c         | 12 +++++++++---
 mm/migrate.c     | 20 +++++++++++++++-----
 3 files changed, 26 insertions(+), 10 deletions(-)

-- 
2.37.2

