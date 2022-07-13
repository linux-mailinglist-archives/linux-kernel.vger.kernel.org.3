Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048345738C1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbiGMOZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbiGMOZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:25:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE8333341
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657722339; x=1689258339;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2Y8BF1Rg345QyJ8e8eE55+o9RRvwy3FhDzVO20P6JmI=;
  b=NxI4/4qJH8SoAawKMkknSSJu4cXYAQlkLQrdOzIp9WATE4Z/tgc5voI8
   oQC4TNv4IHvC+nD1u3BHng8YwYtCaUoXhNAj8PuZcQD6yBE1dK/ztn/u5
   6OyiLs0QQ5hUkZ4cwTPk/LIN9Bj5ETHtdl2Z2xQIl25kfmQV+hTK54wFF
   W8trJBGM2oUp9YuvMOo1Ywr1t0xaW/fxSEf9rK0zwmMsKEHMDuR2aFfA/
   Pq55ta+QMJ2Y231vLzwR+OzabeOZ3sDPafPBibjQApjs/9klIv8/puhiz
   uxgT83n4qs119d6bBhuIpwVePYraKxD8R12nVkUs67YlU8Nn3DmTSSi91
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="285968182"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="285968182"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 07:25:38 -0700
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="570643748"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 07:25:37 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 0/3] soundwire: allocate device_number with IDA
Date:   Wed, 13 Jul 2022 22:25:26 +0800
Message-Id: <20220713142529.17323-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_number is currently allocated in the scope of each bus and does
not need to be unique at the system level.
This leads e.g. on Dell devices with three or four Device1 on different
bus segments. To make the device_number unique at the system level, and
unified with the HDaudio/iDISP SDI values, this PRs allocates the
dev_number with an IDA restricted between 4 and 11 (inclusive).

Pierre-Louis Bossart (3):
  soundwire: bus: rename sdw_ida as sdw_bus_ida
  soundwire: bus: allow device number to be unique at system level
  soundwire: intel: set dev_num_ida_min

 drivers/soundwire/bus.c       | 29 ++++++++++++++++++++---------
 drivers/soundwire/intel.c     |  4 ++++
 include/linux/soundwire/sdw.h |  4 ++++
 3 files changed, 28 insertions(+), 9 deletions(-)

-- 
2.25.1

