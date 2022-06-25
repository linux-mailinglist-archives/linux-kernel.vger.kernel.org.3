Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DB655AA3D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 14:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiFYM4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 08:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiFYM4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 08:56:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ACB18362
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 05:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656161790; x=1687697790;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S3kTFxDx/UlQ4ttkSgT0OD0LBtEA6KOASNkdzOFb+uw=;
  b=H6WxCrcYp5INSCdtEI8dHR1v9lOMT6G/X/kin9tduJ9z2DsmMHDRMpY4
   ckKGYzFJsvV7otDu21F2KCK8zeRGCjQAlzgJcsIt0c8fuDZsJouqUgeS5
   XEmoV0qHuUnZQNxb4d96HY8I/JYHPGDQfMGqXEFeCxhYBswPWz/PiWlHN
   qQdayAcbrrFdLOupdpLN6dWm/vE8nsRNilV5OYF7ypJD2Q0VLv/rfsYRq
   6wPVRR1BsJPC/8kaK0Vv4ulkcPKZwfJ1BBLg+Wr4faLkpOUGqVlp9Q5hc
   /wQ0EqZIX/UGSGYug3oslhEMdG8khEOulkYvfplnwteXmgbo7PcGTZbyp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="278727935"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="278727935"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 05:56:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="586890349"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 25 Jun 2022 05:56:27 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Steve Wahl <steve.wahl@hpe.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>, iommu@lists.linux.dev,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v1 0/6] iommu/vt-d: Reset DMAR_UNITS_SUPPORTED
Date:   Sat, 25 Jun 2022 20:51:58 +0800
Message-Id: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This is a follow-up series of changes proposed by this patch:

https://lore.kernel.org/linux-iommu/20220615183650.32075-1-steve.wahl@hpe.com/

It removes several static arrays of size DMAR_UNITS_SUPPORTED and sets
the DMAR_UNITS_SUPPORTED to 1024.

Please help review and suggest.

Best regards,
baolu

Lu Baolu (6):
  iommu/vt-d: Remove unused domain_get_iommu()
  iommu/vt-d: Use IDA interface to manage iommu sequence id
  iommu/vt-d: Refactor iommu information of each domain
  iommu/vt-d: Add VTD_FLAG_IOMMU_PROBED flag
  iommu/vt-d: Remove global g_iommus array
  iommu/vt-d: Make DMAR_UNITS_SUPPORTED default 1024

 include/linux/dmar.h        |   6 +-
 drivers/iommu/intel/iommu.h |  29 ++++--
 drivers/iommu/intel/dmar.c  |  33 ++-----
 drivers/iommu/intel/iommu.c | 188 ++++++++++++++----------------------
 drivers/iommu/intel/pasid.c |   2 +-
 drivers/iommu/intel/svm.c   |   2 +-
 6 files changed, 103 insertions(+), 157 deletions(-)

-- 
2.25.1

