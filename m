Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044FA4C01AD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiBVSyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiBVSyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:54:50 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF631375A3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645556064; x=1677092064;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P+VHI+n/RJFH+AzKfcSRwsfvLy40Ni3+5cBuLLVdhtI=;
  b=RG9QUJ6z1tFeyc+04raH/6sgSuTsj2SBDRHgzU8i7wIHaKCGFGrt6G7Z
   wA94SgUgQa+biqOy2PCQd3ibIw39VLnmDiE4ClBy9EcUUXg7xT+dQx3sH
   DvrNYC82vziKdp3BwOrS6IX1K2+hxSm+bWkFBUzmngl4UX7G+kkB12G01
   lHceL/auDGXwbAKP3ldflR+Y7QV2kqxV8aZ0t572zbxWd+kD3ZbgM3CoT
   JQzTbJ053qVEtt2itWRb/Vs9w2qcyyYIn24Vgh5ivcw70yzq8yKeBxfNO
   dFzczajZ64niWFO9slIw93jzd+mZ+7BpSgJ6QFN1RFMqwA3c/w71t+3Ya
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="315012964"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="315012964"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 10:54:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="508105487"
Received: from oux.sc.intel.com ([10.3.52.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 10:54:24 -0800
From:   Yian Chen <yian.chen@intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Yian Chen <yian.chen@intel.com>
Subject: [PATCH v2 0/2] Enable ATS for the devices in SATC table
Date:   Tue, 22 Feb 2022 10:54:14 -0800
Message-Id: <20220222185416.1722611-1-yian.chen@intel.com>
X-Mailer: git-send-email 2.25.1
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

The devices in BIOS SATC (SoC integrated Address Translation Cache)
table are all trusted devices to use ATS. This patch set enables
ATS for them.

---
v2:
  - Use dmar_find_matched_satc_unit() to avoid hard coded
    return value.
  - add static declaration for dmar_ats_supported()
    (the function modified from 
     dmar_find_matched_atsr_unit())
---

Yian Chen (2):
  iommu/vt-d: Enable ATS for the devices in SATC table
  iommu/vt-d: Declare dmar_ats_supported() as static function

 drivers/iommu/intel/iommu.c | 128 +++++++++++++++++++++++-------------
 include/linux/intel-iommu.h |   1 -
 2 files changed, 83 insertions(+), 46 deletions(-)

-- 
2.25.1

