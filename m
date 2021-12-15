Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710844757AF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbhLOLVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhLOLVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:21:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEA5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 03:21:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B046B81EC5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920ABC34605;
        Wed, 15 Dec 2021 11:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639567288;
        bh=/tc4XfmOU17H2sh1wj8kjCXk5JW0PN7jFtv/OiIdmYk=;
        h=Date:From:To:Cc:Subject:From;
        b=i9T9e1RBAQwI8cQ1eOLXeUnqMmtWbeSi2itcXnCqEijtudck/BqqfY2CKLEiSxs58
         rgkNHxUAMATp6qk8tuUDyvx77/14rVXNtOZOQ+9oQ6npviNAEajtVQT6UYHMc3wVfx
         aEVjjaohE3/KpCTdcftbSK69W1yrlaEcCVd3Rk1JRyRr/eA21lW9Q8lurt4T8TNu7R
         JbFdAgWm4mtNngd7MRQe87A8oLAbZkxYW2N6hvnz6JikLe4zORgtlyLKrGWuyvPHS5
         hURzlzGKsaP18ypzlguLYnTa9qQFl0shHmpkpCuiVTp5AvhymnGrGYPCJfZDghE7hy
         BK7YW7mFfk5Sw==
Date:   Wed, 15 Dec 2021 11:21:24 +0000
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.17
Message-ID: <20211215112124.GC16765@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Please pull these Arm SMMU updates for 5.17.

Once again, there's not a lot here. In fact, it's mostly a combination
of non-critical fixes and DT compatible string additions. Summary in
the tag.

Cheers,

Will

--->8

The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:

  Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to 477436699e7801276fa7306e20318156cb535249:

  Revert "iommu/arm-smmu-v3: Decrease the queue size of evtq and priq" (2021-12-15 10:14:06 +0000)

----------------------------------------------------------------
Arm SMMU updates for 5.17

- Revert evtq and priq back to their former sizes

- Return early on short-descriptor page-table allocation failure

- Fix page fault reporting for Adreno GPU on SMMUv2

- Make SMMUv3 MMU notifier ops 'const'

- Numerous new compatible strings for Qualcomm SMMUv2 implementations

----------------------------------------------------------------
David Heidelberg (1):
      dt-bindings: arm-smmu: Add compatible for the SDX55 SoC

Rikard Falkeborn (1):
      iommu/arm-smmu-v3: Constify arm_smmu_mmu_notifier_ops

Rob Clark (1):
      iommu/arm-smmu-qcom: Fix TTBR0 read

Vinod Koul (2):
      dt-bindings: arm-smmu: Add compatible for SM8450 SoC
      iommu: arm-smmu-impl: Add SM8450 qcom iommu implementation

Yunfei Wang (1):
      iommu/io-pgtable-arm-v7s: Add error handle for page table allocation failure

Zhou Wang (1):
      Revert "iommu/arm-smmu-v3: Decrease the queue size of evtq and priq"

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c       | 2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h           | 5 ++---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c            | 3 ++-
 drivers/iommu/io-pgtable-arm-v7s.c                    | 6 +++++-
 5 files changed, 12 insertions(+), 6 deletions(-)

