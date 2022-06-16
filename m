Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2566C54D6EE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350667AbiFPBSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344266AbiFPBSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:18:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EE11EC75
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 18:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655342289; x=1686878289;
  h=from:to:cc:subject:date:message-id;
  bh=8CRPZ+PI7GsA3Vg8iyD0FuvbPI2TYAjEUNZkKyYokU4=;
  b=i3ODMCaeUUTps3Mn7NFidWMG94IXXc8AzVv+WR/uAXliCkAxc6DAZ7vX
   3/3AjcgNULHH5EJ/gxo9yFA3iGJDCGdI0xJtHU0bRoW40FygAJk+MzZdB
   k8ru1sGZWg2YlKGy1c8+3n/7WC4kppO7gfgTGDWPIRNk73hNC7Uy2WVA0
   0b4QDNDfeEKvfsMgjA5diP6vId7PHFtdpilGypkcUo5csgG0kR5DX9504
   HnQKI/yj6/nM58LuoLwLeB74wVkOYMQz3Ikyv6I6g+sRZJymlrZs4vTT5
   6dnBNB9JQMu14IwxeYQ2IxVhXEvB56L5MzzYzcWOTwy1U6QRLXOBt5s1q
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="279195939"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="279195939"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 18:18:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="911939275"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 18:18:06 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com, peter.ujfalusi@linux.intel.com,
        ranjani.sridharan@linux.intel.com
Subject: [PATCH v2 0/2] ASoC/SoundWire: Intel: add sdw BE dai trigger
Date:   Thu, 16 Jun 2022 09:17:56 +0800
Message-Id: <20220616011758.21155-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For SOF IPC4, we need to set pipeline state in BE DAI trigger.
@Vinod, Could you ack if the soundwire patch looks good to you?
And we can go through the ASoC tree since the change is mainly on ASoC.

v2:
 - Change "#if IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE)" to
   "if (IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE))"

Bard Liao (2):
  soundwire: Intel: add trigger callback
  ASoC: SOF: Intel: add trigger callback into sdw_callback

 drivers/soundwire/intel.c           |  8 ++++++++
 include/linux/soundwire/sdw_intel.h |  1 +
 sound/soc/sof/intel/hda-dai.c       | 14 +++++++++++---
 sound/soc/sof/intel/hda.c           |  2 +-
 sound/soc/sof/intel/hda.h           |  1 +
 5 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.17.1

