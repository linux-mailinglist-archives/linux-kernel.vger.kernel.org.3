Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AF558A4D2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 04:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbiHECq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 22:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbiHECq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 22:46:57 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C91220F6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 19:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659667616; x=1691203616;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K2D2NgQZQ3nHWc3gX8mSISPH0s8sla4YEIqVoj8SL2s=;
  b=HG2XR2N0byTY2/SCjx4sgHGLzCg0e+3E07C1A65PYPXq93n4Br2Q26RW
   Wf8+iWYDQD4CtcCYQurkWJEfgffLeYR8AWsMNx+UkOqs8S2aQ1zsgNQRD
   xIknuniFnrHvPGXKnhRAQ7Dcqhc2MLgVMtIDtatTkDRnrijewLTyH8SSe
   8UFss4xhbYLMqWJYnzHwYyukux0vcFwR16fYxJEZdgHENxaXdr+NWrqG7
   /dYUZ0N0vMcIm6VxxoOpmtEOus/jAVTioiJfpQbwlb9mELoexdY2vbCIY
   ZpiGyA0bgioFMl7ALNNUV9y+YM5wjTGOKXjg4CZ04OpW7/fk8uZUTCYrD
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="351819021"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="351819021"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 19:46:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="662814893"
Received: from sunyi-station.sh.intel.com (HELO sunyi-station..) ([10.239.159.10])
  by fmsmga008.fm.intel.com with ESMTP; 04 Aug 2022 19:46:53 -0700
From:   Yi Sun <yi.sun@intel.com>
To:     dave.hansen@intel.com, sohil.mehta@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        david.laight@aculab.com, mingo@kernel.org, andrii@kernel.org
Cc:     heng.su@intel.com, yi.sun@intel.com
Subject: [PATCH v3 0/2] x86: Add xsave/xrstor Latency Trace Events and Consuming Script
Date:   Fri,  5 Aug 2022 10:46:50 +0800
Message-Id: <20220805024652.2194190-1-yi.sun@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces trace events which can dump the latency of
instructions xsave and xrstor for x86 platform to tell when
XSAVE/XRSTOR are getting more or less expensive, and get out the
RFBM and XINUSE to figure out the reason.

We did bunch of internal testing, compared several optional latency
calculation approaches. We believe it can be a more optimized one.

Also, the series introduces a script to consume trace log, which
leverage sqlite3 to show statistics data such as max, min, latency
and 97% tail latency.

This series has gone through several versions of peer-reviewed
internally. All patches have review tags. It's ready for review by
the x86@kernel.org maintainers.

- Change from v2 to v3:
  - Move the script xsave-latency-trace.sh to folder tools/testing/fpu/
    (Ingo Molnar)

- Change from v1 to v2:
  - Reword the comments. (Laight, David; Mehta, Sohil)
  - Rename all variable 'dtsc' to 'latency'. (Mehta, Sohil)

Yi Sun (2):
  x86/fpu: Measure the Latency of XSAVE and XRSTOR
  scripts/x86: Add script to consume trace log of xsave latency

 arch/x86/include/asm/trace/fpu.h         |  35 ++++
 arch/x86/kernel/fpu/xstate.h             |  49 ++++-
 tools/testing/fpu/xsave-latency-trace.sh | 227 +++++++++++++++++++++++
 3 files changed, 306 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/fpu/xsave-latency-trace.sh

-- 
2.34.1

