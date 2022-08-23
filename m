Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D734059D02A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 06:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239572AbiHWEqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 00:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238735AbiHWEqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 00:46:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207F754C88
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 21:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661229975; x=1692765975;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1hk3vPLt5LF/hGQ/U9Opw9PivdsoVIeWfL5vgv/ftqY=;
  b=Rxd690a3r1W2gq5BybUORqNdlOCkF6dWeAZo0rkW6MHjcqEINusWr+Gk
   AUuec3IcxUdNy3JUnH0ye4njUE/1qv7ueH5WuJzMIaDgmxb9bH8E7gWbw
   aNSwHFbBid/gVoRIIMFUWBgLg5usBPxC+PB4ueA/oXopU0kO5pfA99ncp
   bHx7YV06L3x4INYYabOnXg0B0fsnpbzrIiufHd9iAxmYKtlzCv+rlzfF2
   konU1ZV7Oe2Ioz+Ld4995gf4Ts5luONKVXtvHMTqOC5PBX5gFx6f+ZeqR
   IrrRlzXsNzXRPDOCIpkC6iqVA6SaDWEdwC5cEB+hoo9PYCxXW3e4PjoWS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="291146770"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="291146770"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 21:46:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="669855088"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 21:46:13 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 0/3] soundwire: allocate device_number with IDA
Date:   Tue, 23 Aug 2022 12:50:01 +0800
Message-Id: <20220823045004.2670658-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_number is currently allocated in the scope of each bus and does
not need to be unique at the system level.
This leads e.g. on Dell devices with three or four Device1 on different
bus segments. To make the device_number unique at the system level, and
unified with the HDaudio/iDISP SDI values, this series allocates the
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

