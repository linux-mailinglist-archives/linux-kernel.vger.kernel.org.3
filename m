Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC64A4B1CD1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 04:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346000AbiBKDHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 22:07:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238176AbiBKDGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 22:06:55 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B751E2647
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 19:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644548813; x=1676084813;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CfAPPn4CPgGS2bE7xNJZrnMTTobRXydSSnt+IPub/Ow=;
  b=CUTRlhn+C5mZ+o4tVdXbOQvB2wedPfUrvi75IfuIiIYXyT/H3S/8hk29
   rWh5jjHGGibNNi7EjhwxvWVTOq/b9+5dlRFlRIEyA5Pcv3BipWror4bZn
   ojkOi3jUFgzTDEOzBnKAU+AZGdpaMMlt0OD5PPUeg5Ern3gj1WZxxW8/J
   ULzgiidXuiBI6JUkVzg1sOhvnPZJO3gpCNDvOzU8quhDZY+YHfiXj/Kj2
   zYJvB91RsFW54pU1L4cbPbp3BKUrcz684gFl3vX5pHmebE5vWY/pBzgqk
   JU6DN2SZbgRssKfXkQZcwQ/0IarEc7Mq79llwHoBUGCCyWL3kMCvnsCBP
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="230289508"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="230289508"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 19:06:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="483062803"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga003.jf.intel.com with ESMTP; 10 Feb 2022 19:06:50 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Airlie <airlied@linux.ie>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Nathan Myers <ncm@cantrip.org>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/2] Replace intel_iommu_gfx_mapped with device_iommu_mapped()
Date:   Fri, 11 Feb 2022 11:05:29 +0800
Message-Id: <20220211030531.2398789-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This follows commit cca084692394a ("drm/i915: Use per device iommu check")
to convert intel_iommu_gfx_mapped use in agp/intel to device_iommu_mapped().
With this changed, the export intel_iommu_gfx_mapped could be removed.

Best regards,
baolu

Lu Baolu (2):
  agp/intel: Use per device iommu check
  iommu/vt-d: Remove unnecessary exported symbol

 include/linux/intel-iommu.h  |  1 -
 drivers/char/agp/intel-gtt.c | 17 +++++++----------
 drivers/iommu/intel/iommu.c  |  6 ------
 3 files changed, 7 insertions(+), 17 deletions(-)

-- 
2.25.1

