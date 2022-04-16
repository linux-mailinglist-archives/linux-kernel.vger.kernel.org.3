Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2A150369F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 14:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiDPMgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 08:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiDPMgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 08:36:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B1CFE427
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 05:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650112411; x=1681648411;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7N6FnAhDTh9ImILbJI2DEaBF3CJE+gkTHPbZ8SbtD5E=;
  b=nc6c5FQtQkECi9qvoqj7z1/1D5vRYJKUJXPUcXOl15rw7suz+UqXcM2J
   jRVohlOBjQRI8Ruh1/YMVwsnoxlozp/p8jDQrPJmU8NdXw4vQDrEE/Oa4
   vvlCiSx/NC+P0UI/dccU7gqrwV2ZAf+ldaGYmafPQunmtFXeMIfbRdu+W
   A8HAk3I6n1rJQo2ce8mcxXZT1hzVZikc1C9QRYcsIz+KB2QoDrNlbToGm
   O5O+hrnYkML5Z3PW7OjF6RIDvlYGkWZe39Tt2VV5sAglfMbo8LHTKK79F
   7D401orXAPwwYgD67e2bOAjv07LghNoxFMCswdFqDBtc6VlKa3MV6JEmz
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="243221099"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="243221099"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 05:33:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="701332462"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2022 05:33:29 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Jacob jun Pan <jacob.jun.pan@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/3] iommu/vt-d: Some fine tuning of SVA
Date:   Sat, 16 Apr 2022 20:30:46 +0800
Message-Id: <20220416123049.879969-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This includes several tunings of Intel SVA implementation. I plan to
target them for v5.19. Please help to review.

Best regards,
baolu


Lu Baolu (3):
  iommu/vt-d: Set PGSNP bit in pasid table entry for sva binding
  iommu/vt-d: Drop stop marker messages
  iommu/vt-d: Size Page Request Queue to avoid overflow condition

 include/linux/intel-svm.h   | 2 +-
 drivers/iommu/intel/pasid.c | 2 +-
 drivers/iommu/intel/svm.c   | 5 +++++
 3 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.25.1

