Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED4B57ECC8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 10:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbiGWIiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 04:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiGWIiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 04:38:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8041848E90
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 01:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658565483; x=1690101483;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rvkbXApgbYvoT35DVK8UPrvY0x1DFJLYDvxFgRbEEhw=;
  b=fRS199qOsyPWcB3hX6iRPbgQNPIk7i2+J9ldZ/xWMW8e9L6H3GI4oVAq
   xDjHJVS5aivRQT1B6l6qjAUj4oERtcqFAHjUjfZhgLV4WTHumW4Xn+PwH
   vNnixN+NvwlZ4wCcSIhx+yIVnEAdNvWLmnzf5Rn1ordYUD7p2Y8Ik2RSK
   4Z7LMhVS/tod6PziFC9snGov8NAjLjC/xkF8suVvVJPVX7xnUShR1/vzB
   TLjWgiquPsImo8iBmvixVeOWlEokGbtlXINloSyiQQrhBv7yfIJjQCNUA
   N0JpVIu4x1HW133e8+R7Hz9iYNp4y6EFg+7Jv9XPK+6bWt5DX5nPXNBl2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="285002862"
X-IronPort-AV: E=Sophos;i="5.93,187,1654585200"; 
   d="scan'208";a="285002862"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 01:38:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,187,1654585200"; 
   d="scan'208";a="574436590"
Received: from sunyi-station.sh.intel.com (HELO sunyi-station..) ([10.239.159.10])
  by orsmga006.jf.intel.com with ESMTP; 23 Jul 2022 01:38:01 -0700
From:   Yi Sun <yi.sun@intel.com>
To:     dave.hansen@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     sohil.mehta@intel.com, tony.luck@intel.com, heng.su@intel.com,
        yi.sun@intel.com
Subject: [PATCH 0/2] x86: Add xsave/xrstor Latency Trace Events and Consuming Script
Date:   Sat, 23 Jul 2022 16:37:58 +0800
Message-Id: <20220723083800.824442-1-yi.sun@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces trace events which can dump the latency of
instructions xsave and xrstor for x86 platform. In internal testing
we compared several optional latency calculation method, believe
it can be a more optimized approach to get the latency.

Also, the series introduces a script to consume trace log, which
leverage sqlite3 to show statistics data such as max, min, latency
and 97% tail latency.

This series has gone through several versions of peer-reviewed
internally. All patches have review tags. It's ready for review by
the x86@kernel.org maintainers.

Yi Sun (2):
  x86/fpu: Measure the Latency of XSAVE and XRSTOR
  scripts/x86: Add script to consume trace log of xsave latency

 arch/x86/include/asm/trace/fpu.h   |  35 +++++
 before submission.               

 arch/x86/kernel/fpu/xstate.h       |  49 ++++++-
 scripts/x86/xsave-latency-trace.sh | 227 +++++++++++++++++++++++++++++
 3 files changed, 306 insertions(+), 5 deletions(-)
 create mode 100755 scripts/x86/xsave-latency-trace.sh

-- 
2.34.1

