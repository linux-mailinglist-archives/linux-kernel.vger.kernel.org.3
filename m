Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279B4560C1D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 00:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiF2WNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 18:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiF2WNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:13:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFB6FE7;
        Wed, 29 Jun 2022 15:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656540787; x=1688076787;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VilICLeXUNd8OwmOBx6vGqhpkzlcDny7Upfx8BWGH5A=;
  b=A/phtUOlP0YocoudIZI1vIpniAVPDIwCqvDrTAHb5shAtZb2ZJI7ato9
   yHJrKTwy/pFuc0KrBzhl9qRvH4SlCmlOF9/vN3lZV5gZtogpo++MijSKC
   jNvxNzqyy5eY9AXPtv2oR41Dt7zz3DyC33DqQUuZUzZTyLdcxs6Yny2KQ
   h4cCGX8sY5rpv6p5FBAPkIELvOiWcSJqHKPcLNCMKLScDRL6sFBSoR11Q
   4IQVCFqJMGJABmz3giwbZzi0/kBNnBnOzZtGOG125t7z8wny8AzZMJRrF
   5SzZVsoj9WcwdE3I00pZfKGC+0pdUdho+Kh7ZjYqt4Xig+HWbxn0jrI3N
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="262578990"
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="262578990"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 15:13:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="658734736"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jun 2022 15:13:07 -0700
Received: from MeteorLakePO1.jf.intel.com (MeteorLakePO1.jf.intel.com [10.234.180.58])
        by linux.intel.com (Postfix) with ESMTP id 15771580B55;
        Wed, 29 Jun 2022 15:13:07 -0700 (PDT)
From:   Gayatri Kammela <gayatri.kammela@linux.intel.com>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, david.e.box@linux.intel.com,
        srinivas.pandruvada@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gayatri Kammela <gayatri.kammela@linux.intel.com>
Subject: [PATCH v1 0/4] Add Raptor Lake and PCI error recovery support
Date:   Wed, 29 Jun 2022 15:13:30 -0700
Message-Id: <20220629221334.434307-1-gayatri.kammela@linux.intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch set adds Raptor Lake support as well as PCI error recovery
support to PMT driver. It also has a rework patch and a fix for fixed
region handling.

Patch 1: Rework early hardware code
Patch 2: Add support for Raptor Lake
Patch 3: Fix fixed region handling
Patch 4: Add PCI error recovery support to Intel PMT

David E. Box (3):
  platform/x86/intel/vsec: Rework early hardware code
  platform/x86/intel/vsec: Add support for Raptor Lake
  platform/x86/intel/pmt: telemetry: Fix fixed region handling

Gayatri Kammela (1):
  platform/x86/intel/vsec: Add PCI error recovery support to Intel PMT

 drivers/platform/x86/intel/pmt/class.c     |  23 ++--
 drivers/platform/x86/intel/pmt/telemetry.c |  18 ++-
 drivers/platform/x86/intel/vsec.c          | 130 ++++++++++++++++-----
 drivers/platform/x86/intel/vsec.h          |  11 +-
 4 files changed, 136 insertions(+), 46 deletions(-)


base-commit: 03c765b0e3b4cb5063276b086c76f7a612856a9a
-- 
2.32.0
