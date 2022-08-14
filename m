Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46390591FFC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 16:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbiHNOF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 10:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238931AbiHNOFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 10:05:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F3E265F
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 07:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660485923; x=1692021923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9fAAJ+0Y6IupPR1Maei1hF/1z3rRhAIksVvzcmYEB40=;
  b=NBa7eQzEKXtZLSQYm8ok44aZczJwW+cZEArb4bvt8H33xD21rjv5Kequ
   2QvmjnMI88XbmhfEzg8ibBaPuaVo/5H/bG7464btGwKcu7Xp4/tXqLPI6
   pDzLP5T+BAtVOON6RSQig3bwxt3gk0AQFWonv9A816j31bYqR3xysutCR
   URnx2xj9RzziT33LaDDsOj+jGbAHpAYqqT10GTVB+6iW0gI+GZEw/502H
   bM+rWhKkzir/TiPZbrlZhpArx1LUXKEulxe+YvJ1OJtlIuzRzM3Z7qdzy
   6Puwgv/Y6jXSDAg7IuCKtdnEjKxOBqZCYbFteluasuxp/e0WV6uVqLEDf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="278784433"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="278784433"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 07:05:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="639385151"
Received: from sse-cse-haiyue-nuc.sh.intel.com ([10.239.241.114])
  by orsmga001.jf.intel.com with ESMTP; 14 Aug 2022 07:05:20 -0700
From:   Haiyue Wang <haiyue.wang@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, david@redhat.com, linmiaohe@huawei.com,
        ying.huang@intel.com, songmuchun@bytedance.com,
        naoya.horiguchi@linux.dev, alex.sierra@amd.com,
        Haiyue Wang <haiyue.wang@intel.com>
Subject: [PATCH v2 0/3] fix follow_page related issues
Date:   Sun, 14 Aug 2022 22:05:31 +0800
Message-Id: <20220814140534.363348-1-haiyue.wang@intel.com>
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

v2: Add the Non-LRU pages fix with two patches, so that
    'mm: migration: fix the FOLL_GET' can be applied directly
    on linux-5.19 stable branch.

Haiyue Wang (3):
  mm: revert handling Non-LRU pages returned by follow_page
  mm: migration: fix the FOLL_GET failure on following huge page
  mm: handling Non-LRU pages returned by follow_page

 mm/huge_memory.c |  4 ++--
 mm/ksm.c         | 16 +++++++++++++---
 mm/migrate.c     | 20 +++++++++++++++-----
 3 files changed, 30 insertions(+), 10 deletions(-)

-- 
2.37.2

