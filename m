Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0F1577944
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 03:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiGRB2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 21:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiGRB2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 21:28:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055DA12D1D
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 18:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658107714; x=1689643714;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iSzfrdEqebPw4+c2ygjk35cjtYfG15dYAOW7Bi0/ihU=;
  b=m/MUC18u/DHVZfmTL2apwpjcGKHnaZXQlBWiq08iW/LhKtL33sTZavZW
   BlnK3IA7Y2XgKNaqzfJsZBUCNEqTpfrHrYlx9gvd8mjkICt90TBArAbhf
   khwE4nctI6/wTAAazo1PgeNLeprs90LCuHEX+wfL6mg6mnHq0EWuQa7AC
   V1T0aDZA/hCFhUrIxrXtwOsT+e8TBZK+Tq4NFYwtvXYGfrIQUPytalPlx
   4mbG1lR7EcUsvBNzVYeqNoQ5YRHSqZhHJFTwB6O7xubPKwj9bVFX/TveE
   MxYw/e7aUTXfye2wSnSISlnZ3fEUPQNoOKBMRCuFNJn75rDsKZ4yje9y1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="283673946"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="283673946"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:28:33 -0700
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="547294019"
Received: from spr.sh.intel.com ([10.239.53.122])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:28:30 -0700
From:   Chao Gao <chao.gao@intel.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc:     dave.hansen@intel.com, len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        ilpo.jarvinen@linux.intel.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, Chao Gao <chao.gao@intel.com>
Subject: [RFC v2 0/2] swiotlb performance optimizations
Date:   Mon, 18 Jul 2022 09:28:16 +0800
Message-Id: <20220718012818.107051-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intent of this post:
 Seek reviews from Intel reviewers and anyone else in the list
 interested in IO performance in confidential VMs. Need some acked-by
 reviewed-by tags before I can add swiotlb maintainers to "to/cc" lists
 and ask for a review from them.

Changes from v1 to v2:
- rebase to the latest dma-mapping tree.
- drop the duplicate patch for mitigating lock contention
- re-collect perf data

swiotlb is now widely used by confidential VMs. This series optimizes
swiotlb to reduce cache misses and lock contention during bounce buffer
allocation/free and memory bouncing to improve IO workload performance in
confidential VMs.

Here are some FIO tests we did to demonstrate the improvement.

Test setup
----------

A normal VM with 8vCPU and 32G memory, swiotlb is enabled by swiotlb=force.
FIO block size is 4K and iodepth is 256. Note that a normal VM is used so
that others lack of necessary hardware to host confidential VMs can reproduce
results below.

Results
-------

1 FIO job	read/write	IOPS (k)
vanilla		read		216 
		write		251 
optimized	read		250 
		write		270 

1-job FIO sequential read/write perf increase by 19% and 8% respectively.

Chao Gao (2):
  swiotlb: use bitmap to track free slots
  swiotlb: Allocate memory in a cache-friendly way

 include/linux/swiotlb.h |   8 ++-
 kernel/dma/swiotlb.c    | 127 +++++++++++++++++-----------------------
 2 files changed, 60 insertions(+), 75 deletions(-)

-- 
2.25.1

