Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC814D1494
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345787AbiCHKTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344149AbiCHKTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:19:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498F921804
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 02:18:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F10D5B817D3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78646C340F5;
        Tue,  8 Mar 2022 10:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646734695;
        bh=RVm+u++xiJMcvCjfVFFJLnTbinzhAa77XmTYfnikpH4=;
        h=Date:From:To:Cc:Subject:From;
        b=Q1OMohd5ioeyo0mcG+oVM+bQiMHlDYJrc2anSe4WEDbA2XgTYjH8Zh08JPtjuoV0/
         YP2UHN+XvydgfiMwAkoflPIi0AORaagTtNOIxAUA4JbOvf8So2VkYY3ydC6bO+6h1u
         MehkGIcjyqfEHRF2uFqlZKqb7hSd59reJ8G15ixyjVy0WWWitpwgKNadRnDFeP7fSQ
         EqzRmvXum19u8l9GiILE4edDHfYoLemby3NaGl0FRaUpwXYffnmBu74O045c4dgVDa
         ryBfCi5FpgU4J9QsOIRj4RhTO3zU3FCtZL94YPN8kUqidf8ltuUFznevRv3NIzCFyz
         pszAxC/eKhZRQ==
Date:   Tue, 8 Mar 2022 10:18:10 +0000
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.18
Message-ID: <20220308101810.GB31063@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Please pull this handful of Arm SMMU updates for 5.18. Summary in the tag.

Cheers,

Will

--->8

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to 97dfad194ca8de04c7292d4f4c8dc493c0d20f85:

  iommu/arm-smmu: Account for PMU interrupts (2022-03-07 21:09:39 +0000)

----------------------------------------------------------------
Arm SMMU updates for 5.18

- Fix SMMUv3 soft lockup during continuous stream of events

- Fix error path for Qualcomm SMMU probe()

- Rework SMMU IRQ setup to prepare the ground for PMU support

- Minor cleanups and refactoring

----------------------------------------------------------------
Andy Shevchenko (1):
      perf/smmuv3: Don't cast parameter in bit operations

Christophe JAILLET (2):
      iommu/arm-smmu-v3: Avoid open coded arithmetic in memory allocation
      iommu/arm-smmu-v3: Simplify memory allocation

Miaoqian Lin (1):
      iommu/arm-smmu: Add missing pm_runtime_disable() in qcom_iommu_device_probe

Robin Murphy (1):
      iommu/arm-smmu: Account for PMU interrupts

Zhou Guanghui (1):
      iommu/arm-smmu-v3: fix event handling soft lockup

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 27 +++------
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 93 ++++++++++++++---------------
 drivers/iommu/arm/arm-smmu/arm-smmu.h       |  5 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 10 +++-
 drivers/perf/arm_smmuv3_pmu.c               |  4 +-
 5 files changed, 64 insertions(+), 75 deletions(-)
