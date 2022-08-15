Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA22592A08
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 09:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241255AbiHOHCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241267AbiHOHC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:02:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5721BEBF
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660546947; x=1692082947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zDz906ofjPYXdKHytM2ivc64ccd+83vvyKv2hXZsRy8=;
  b=aTBJ84Gkk+CAXl6SUjCCfBeMGf+edVf+J7dx6HybbVdbYU1nvItXPRb0
   iS3VEs/eYusNt4NHzYiMlUjtVBubVaSeNDjub7BxFmEovWaymu6YWHn8G
   JHlGzjt/Bn81sF8l9uepil8aOqhNDuRKj55ZrYNUcqYH+AuD1ySX5dYVp
   YfmEiF5ZVuSZCclclbXfv99nirwNIJhpszOq+DPL/jhmvghKx2vNa/lWr
   R12UOVijSaI1JKyDbAsTF7qtQMe2CG3lbjWf/uJo5xE42ATYWVVVRKoIM
   pnQ9oyqeewRcBRr97N4SaUe8UQI1NcyRetA9o00x9k8WQvH57SKMoEo3C
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="274960242"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="274960242"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 00:02:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="666566754"
Received: from sse-cse-haiyue-nuc.sh.intel.com ([10.239.241.114])
  by fmsmga008.fm.intel.com with ESMTP; 15 Aug 2022 00:02:25 -0700
From:   Haiyue Wang <haiyue.wang@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, david@redhat.com, apopple@nvidia.com,
        linmiaohe@huawei.com, ying.huang@intel.com,
        songmuchun@bytedance.com, naoya.horiguchi@linux.dev,
        alex.sierra@amd.com, Haiyue Wang <haiyue.wang@intel.com>
Subject: [PATCH v5 0/2] fix follow_page related issues
Date:   Mon, 15 Aug 2022 15:02:38 +0800
Message-Id: <20220815070240.470469-1-haiyue.wang@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220812084921.409142-1-haiyue.wang@intel.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5: reword the commit message for FOLL_GET with more information.

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

