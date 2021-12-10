Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91AD4707C8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241486AbhLJR6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:58:36 -0500
Received: from foss.arm.com ([217.140.110.172]:45290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233393AbhLJR6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:58:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED03812FC;
        Fri, 10 Dec 2021 09:54:59 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B28663F73B;
        Fri, 10 Dec 2021 09:54:58 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, suravee.suthikulpanit@amd.com,
        baolu.lu@linux.intel.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com,
        linux-mm@kvack.org
Subject: [PATCH v2 00/11] iommu: refactor flush queues into iommu-dma
Date:   Fri, 10 Dec 2021 17:54:41 +0000
Message-Id: <cover.1639157090.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1: https://lore.kernel.org/linux-iommu/cover.1637671820.git.robin.murphy@arm.com/

Hi all,

Just a minor update, pulling in Xiongfeng's fix as a basis for the
subsequent patches moving that code around, and the Tegra DRM patch
previously posted separately. Plus commenting the subtlety in the AMD
pagetable code so it's hopefully easier to remember in future.

Given that no major issues have surfaced so far, hopefully this is on
track for 5.17 in parallel with the slab rework.

Thanks,
Robin.


Matthew Wilcox (Oracle) (2):
  iommu/amd: Use put_pages_list
  iommu/vt-d: Use put_pages_list

Robin Murphy (8):
  gpu: host1x: Add missing DMA API include
  drm/tegra: vic: Fix DMA API misuse
  iommu/iova: Squash entry_dtor abstraction
  iommu/iova: Squash flush_cb abstraction
  iommu/amd: Simplify pagetable freeing
  iommu/iova: Consolidate flush queue code
  iommu/iova: Move flush queue code to iommu-dma
  iommu: Move flush queue data into iommu_dma_cookie

Xiongfeng Wang (1):
  iommu/iova: Fix race between FQ timeout and teardown

 drivers/gpu/drm/tegra/vic.c    |   7 +-
 drivers/gpu/host1x/bus.c       |   1 +
 drivers/iommu/amd/io_pgtable.c | 120 ++++++---------
 drivers/iommu/dma-iommu.c      | 268 +++++++++++++++++++++++++++------
 drivers/iommu/intel/iommu.c    |  89 ++++-------
 drivers/iommu/iova.c           | 200 ------------------------
 include/linux/iommu.h          |   3 +-
 include/linux/iova.h           |  69 +--------
 8 files changed, 303 insertions(+), 454 deletions(-)

-- 
2.28.0.dirty

