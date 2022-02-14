Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809444B5CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiBNVfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:35:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiBNVfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:35:21 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0431C159EB3;
        Mon, 14 Feb 2022 13:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644874387; x=1676410387;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6nrphxgF8SY7mCC6VPn/wAB7S6cT013mVndDXmcmuMM=;
  b=QPo2lWwASfCHyYmyCRG022PTiq/AsmHEftQCM/vs4fuDdn3Zyb3sFceB
   fxj4JEaH1yUDLMYCrbsdf2JwS0MSquVChrLB5t6U9gLBZd662n6l1QSFW
   fW3dk27c3G+/yWylfp5fqa2jLYnFzaQ7k/GpQIraLlcPmhAKcUGO/6fnm
   pQBiXjpVy8wpDhkiISzISWtXYn7pD2Bl/hGQzfyemKjybUvATp74Hmv/2
   mfhodqrWSnWRBcszT0wsOSIotooH8s/aP0wqdFSAXv7IN08ODWUp0PLkh
   VPIHINOl6XZQOW/BrNSkiJa2fSTLo6L+5VRiuTuTfq8Zap3l7gofD+Dxi
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="313464611"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="313464611"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 13:33:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="703299450"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 14 Feb 2022 13:33:06 -0800
Received: from debox1-desk4.intel.com (unknown [10.255.228.161])
        by linux.intel.com (Postfix) with ESMTP id 1B194580638;
        Mon, 14 Feb 2022 13:33:06 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, david.e.box@linux.intel.com,
        mgross@linux.intel.com, rjw@rjwysocki.net,
        srinivas.pandruvada@intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 0/3] Add pm_runtime and DG2 support
Date:   Mon, 14 Feb 2022 13:32:55 -0800
Message-Id: <20220214213258.1929462-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds runtime pm support to the Intel Platform Monitoring
Technology (PMT) driver. This is needed by devices whose slots cannot go to
D3 without power gating the PMT endpoint. To do this, this series also
removes the current binary mmap support since the implementation doesn't
allow for a proper intercept point to perform runtime pm.

David E. Box (3):
  platform/x86/intel: pmt: Remove bin_attribute mmap support to runtime
    pm
  platform/x86/intel: vsec: Enable runtime D3
  platform/x86/intel: vsec: Add DG2 support

 .../ABI/testing/sysfs-class-intel_pmt         | 24 ++++++------
 drivers/platform/x86/intel/pmt/class.c        | 38 ++++---------------
 drivers/platform/x86/intel/pmt/class.h        |  3 ++
 drivers/platform/x86/intel/vsec.c             | 32 ++++++++++++++++
 4 files changed, 54 insertions(+), 43 deletions(-)

-- 
2.25.1

