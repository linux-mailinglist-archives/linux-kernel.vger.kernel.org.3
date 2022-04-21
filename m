Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64346509ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiDULlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244998AbiDULlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:41:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3E02BB37
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 04:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650541123; x=1682077123;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MVIx/sHIEgO1dkAuJU+YX9nK4jl1uGAeDl15aPmqOWY=;
  b=RGrLMhJV6g2ahFNIkLX3gNhFtRXO5dz80H4HeC8mBozE1I4yPAiMWz1B
   OPrUSBEMC6ZDf+EjW1l+o2JyfLlz0XO0wTAiFHD/jnsDzCOKZgjZlC2aP
   HAnbq5S2HTpahY7hKZkjIB9+mnATtu0Q3SgBQLvX/YYqSGprWzsq19A97
   Fs3l/BRN+ENhxJLMk7wiCrYd4Ujn63nBAb2xGaf1qzde9lFNkYnzXX7vl
   wYzOyeCcIHQxnnG1pxu9N6MhMC8pGNue/fonp6jPmj36Z08iFRnGtHU9e
   w8kHQ8029xilhfEDkgBPJZrpJjHuBTQjCcbFuPH3TiVU1B+dTLTxR87ax
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="264492175"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="264492175"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 04:38:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="703047905"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2022 04:38:41 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Jacob jun Pan <jacob.jun.pan@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/4] iommu/vt-d: Some fine tuning of SVA
Date:   Thu, 21 Apr 2022 19:35:54 +0800
Message-Id: <20220421113558.3504874-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Change log:

v2:
 - Move snoop control capability check into a separated patch.
 - Return false if the caller opt-in setting PGSNP with a flag.
 - Add a Fixes tag for "iommu/vt-d: Drop stop marker messages" as it is
   required by the iopf framework.

v1: initial post
 - https://lore.kernel.org/linux-iommu/20220416123049.879969-1-baolu.lu@linux.intel.com/ 

Lu Baolu (4):
  iommu/vt-d: Check before setting PGSNP bit in pasid table entry
  iommu/vt-d: Set PGSNP bit in pasid table entry for SVA binding
  iommu/vt-d: Drop stop marker messages
  iommu/vt-d: Size Page Request Queue to avoid overflow condition

 include/linux/intel-svm.h   |  2 +-
 drivers/iommu/intel/pasid.c | 13 ++++++++++---
 drivers/iommu/intel/svm.c   | 13 ++++++++++---
 3 files changed, 21 insertions(+), 7 deletions(-)

-- 
2.25.1

