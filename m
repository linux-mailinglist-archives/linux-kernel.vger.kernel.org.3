Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679F95AB31D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238966AbiIBOMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238908AbiIBOLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:11:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 794C2BF48
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:39:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7EFAD6E;
        Fri,  2 Sep 2022 05:40:45 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4AC3B3F766;
        Fri,  2 Sep 2022 05:40:38 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Achin Gupta <achin.gupta@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: [PATCH v2 00/10] firmware: arm_ffa: Refactoring and initial/minor v1.1 update
Date:   Fri,  2 Sep 2022 13:40:22 +0100
Message-Id: <20220902124032.788488-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This series is just some refactoring in preparation to add FF-A v1.1
support. It doesn't have any memory layout or notification changes
supported in v1.1 yet.

Regards,
Sudeep

v1[1]->v2:
	- Merged dropping of ffa_ops in optee_ffa structure and using
	  ffa_dev->ops into single patch
	- Added separate patch(didn't fit any patch strictly to fit in)
	  to rename ffa_dev_ops as ffa_ops as suggested by Sumit
	- Fixed some minor comments, handling size > structure size in
	  partition_info_get and added extra parameter to ffa_features
	  to get both possible output/interface properties.

[1] https://lore.kernel.org/all/20220830100700.344594-1-sudeep.holla@arm.com/

Sudeep Holla (10):
  firmware: arm_ffa: Add pointer to the ffa_dev_ops in struct ffa_dev
  tee: optee: Drop ffa_ops in optee_ffa structure using ffa_dev->ops directly
  firmware: arm_ffa: Remove ffa_dev_ops_get()
  firmware: arm_ffa: Add support for querying FF-A features
  firmware: arm_ffa: Use FFA_FEATURES to detect if native versions are supported
  firmware: arm_ffa: Make memory apis ffa_device independent
  firmware: arm_ffa: Rename ffa_dev_ops as ffa_ops
  firmware: arm_ffa: Add v1.1 get_partition_info support
  firmware: arm_ffa: Set up 32bit execution mode flag using partiion property
  firmware: arm_ffa: Split up ffa_ops into info, message and memory operations

 drivers/firmware/arm_ffa/bus.c    |   4 +-
 drivers/firmware/arm_ffa/driver.c | 130 +++++++++++++++++++++++-------
 drivers/tee/optee/ffa_abi.c       |  46 +++++------
 drivers/tee/optee/optee_private.h |   1 -
 include/linux/arm_ffa.h           |  36 ++++++---
 5 files changed, 150 insertions(+), 67 deletions(-)

-- 
2.37.3

