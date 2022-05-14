Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C921F526ED0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiENC7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 22:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiENC6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 22:58:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C11E3A2531
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 18:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652492797; x=1684028797;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q4OHxOkBcZ+3CvVCvY0m+wxDlD8i3ZcBOa66oWnNSzg=;
  b=fS0tiTIlHN/rXK09vydbfoIzwYSBe1egHqUCaNQ6ubAz3LB9V62LvYX2
   uSt49kida25Cd5S4iXHr+HZpZ+OKNpzf6kKw+QQvHzOieqhw+JPZlxLXH
   QrSrriapt2K7S0glU1jPNnX5NzY35QYRaJnp7BpfInQa+s9moN69D64F8
   WcEMsfn1lbkt/J0FrPuLXcUR7gYs26amnjPixEohiLIg+xPvWUyP0+wH7
   GBRqiZaHVjOpql986qge+64Blbj0ZHGSqpKnsXLxUDH3v4HTld4KUXq0c
   aeHTjQvStdGZf+sMyZdXfQdruHbb0pGbytajG0djA/lHbKypkBLXERX1M
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="270387987"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="270387987"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 18:46:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="712630756"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 13 May 2022 18:46:31 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ning Sun <ning.sun@intel.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Steve Wahl <steve.wahl@hpe.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/7] iommu/vt-d: Make intel-iommu.h private
Date:   Sat, 14 May 2022 09:43:15 +0800
Message-Id: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

The include/linux/intel-iommu.h should be private to the Intel IOMMU
driver. Other drivers or components should interact with the IOMMU
drivers through the kAPIs provided by the iommu core.

This series cleanups all includes of intel-iommu.h outside of the Intel
IOMMU driver and move this header from include/linux to
drivers/iommu/intel/.

No functional changes intended. Please help to review and suggest.

Best regards,
baolu

Lu Baolu (7):
  iommu/vt-d: Move trace/events/intel_iommu.h under iommu
  agp/intel: Use per device iommu check
  iommu/vt-d: Remove unnecessary exported symbol
  drm/i915: Remove unnecessary include
  KVM: x86: Remove unnecessary include
  x86/boot/tboot: Move tboot_force_iommu() to Intel IOMMU
  iommu/vt-d: Move include/linux/intel_iommu.h under iommu

 include/linux/tboot.h                         |  2 --
 drivers/gpu/drm/i915/i915_drv.h               |  1 -
 .../iommu/intel/iommu.h                       |  1 -
 .../iommu/intel/trace.h                       |  7 +++++-
 arch/x86/kernel/tboot.c                       | 15 -------------
 arch/x86/kvm/x86.c                            |  1 -
 drivers/char/agp/intel-gtt.c                  | 17 ++++++--------
 drivers/gpu/drm/i915/display/intel_display.c  |  1 -
 .../gpu/drm/i915/gem/i915_gem_execbuffer.c    |  1 -
 drivers/iommu/intel/cap_audit.c               |  2 +-
 drivers/iommu/intel/debugfs.c                 |  2 +-
 drivers/iommu/intel/dmar.c                    |  4 ++--
 drivers/iommu/intel/iommu.c                   | 22 +++++++++++++------
 drivers/iommu/intel/irq_remapping.c           |  2 +-
 drivers/iommu/intel/pasid.c                   |  2 +-
 drivers/iommu/intel/perf.c                    |  2 +-
 drivers/iommu/intel/svm.c                     |  4 ++--
 drivers/iommu/intel/trace.c                   |  2 +-
 MAINTAINERS                                   |  1 -
 19 files changed, 38 insertions(+), 51 deletions(-)
 rename include/linux/intel-iommu.h => drivers/iommu/intel/iommu.h (99%)
 rename include/trace/events/intel_iommu.h => drivers/iommu/intel/trace.h (93%)

-- 
2.25.1

