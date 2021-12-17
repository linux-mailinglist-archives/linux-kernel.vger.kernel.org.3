Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E2F478FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbhLQPbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:31:48 -0500
Received: from foss.arm.com ([217.140.110.172]:58890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238766AbhLQPbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:31:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AC061042;
        Fri, 17 Dec 2021 07:31:12 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C32973F774;
        Fri, 17 Dec 2021 07:31:10 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, suravee.suthikulpanit@amd.com,
        baolu.lu@linux.intel.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com,
        linux-mm@kvack.org, hch@lst.de, thierry.reding@gmail.com
Subject: [PATCH v3 0/9] iommu: refactor flush queues into iommu-dma
Date:   Fri, 17 Dec 2021 15:30:54 +0000
Message-Id: <cover.1639753638.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1: https://lore.kernel.org/linux-iommu/cover.1637671820.git.robin.murphy@arm.com/
v2: https://lore.kernel.org/linux-iommu/cover.1639157090.git.robin.murphy@arm.com/

Hi all,

Just another quick update addressing the trivial nits and picking up the
review tags so far. The previous Tegra DRM fixes for the initial kbuild
issues have been picked up, so I've posted a final fix separately[1] for
the others subsequently reported on v2. I've confirmed that arm64
allmodconfig builds cleanly with that, and nothing else jumped out from
a manual audit of iova.h includers. At worst we could hold off applying
the last patch (or the last two, logically), or temporarily reinstate
the dma-iommu.h include, if we're worried about issues in linux-next
until the DRM tree has caught up.

Thanks
Robin.

[1] https://lore.kernel.org/linux-iommu/dc81eec74be9064e33247257b1fe439b0f6ec78d.1639664721.git.robin.murphy@arm.com/

Matthew Wilcox (Oracle) (2):
  iommu/amd: Use put_pages_list
  iommu/vt-d: Use put_pages_list

Robin Murphy (6):
  iommu/iova: Squash entry_dtor abstraction
  iommu/iova: Squash flush_cb abstraction
  iommu/amd: Simplify pagetable freeing
  iommu/iova: Consolidate flush queue code
  iommu/iova: Move flush queue code to iommu-dma
  iommu: Move flush queue data into iommu_dma_cookie

Xiongfeng Wang (1):
  iommu/iova: Fix race between FQ timeout and teardown

 drivers/iommu/amd/io_pgtable.c | 120 ++++++---------
 drivers/iommu/dma-iommu.c      | 266 +++++++++++++++++++++++++++------
 drivers/iommu/intel/iommu.c    |  89 ++++-------
 drivers/iommu/iova.c           | 200 -------------------------
 include/linux/iommu.h          |   3 +-
 include/linux/iova.h           |  69 +--------
 6 files changed, 297 insertions(+), 450 deletions(-)

-- 
2.28.0.dirty

