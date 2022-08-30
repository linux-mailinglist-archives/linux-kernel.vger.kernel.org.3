Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7C15A5968
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 04:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiH3C2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 22:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiH3C2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 22:28:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEDE9E2D8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 19:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661826491; x=1693362491;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PV46ZO0VLjczO45e44SLoi5r5B6ppa9WttRCbnrioCU=;
  b=YAE7fawYyNXtL0jfnlGjz4p1hG9p1+mdID8IDx0CJn38sTRX8DsSrH8y
   JJ5YhJ8Sn1JMgPZEf8tHq6OlHkLcvQKFejI9W6IZyHlF5I1bc2cDUkgfl
   5ubTSBp5Fc5soPGZ77MCigiHS5j2vJsQ6RP0XQuIusqU0l8w/HXtmkbiR
   DIaLxqVogSYJHq64TUTSsnBZtopwMrjPEzdSB9GRHea4uVKBsWdWBnon2
   BwWRo7DHbk6nd5QdN+r1XkAW2/ov2ncjHPkhdvgsdIwEQCXJ2+qysZzvm
   +ZfYX5Y5GrjGwINLypEJ1lCQB/QxrSkfzrH9Rdc1C29XDqAblsNFWoVZ5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="278076151"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="278076151"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 19:28:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="679857634"
Received: from sunyi-station.sh.intel.com (HELO sunyi-station..) ([10.239.159.10])
  by fmsmga004.fm.intel.com with ESMTP; 29 Aug 2022 19:28:09 -0700
From:   Yi Sun <yi.sun@intel.com>
To:     dave.hansen@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org
Cc:     sohil.mehta@intel.com, ak@linux.intel.com,
        ilpo.jarvinen@linux.intel.com, heng.su@intel.com, yi.sun@intel.com
Subject: [PATCH v4 0/2] x86: Add xsave/xrstor Latency Trace Events and Consuming Script
Date:   Tue, 30 Aug 2022 10:28:06 +0800
Message-Id: <20220830022808.1336447-1-yi.sun@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

- Change from v3 to v4:
  - Rebase patch set to the latest tag v6.0-rc3, replacing
    ALTERNATIVE_2 with ALTERNATIVE_3

- Change from v2 to v3:
  - Move the script xsave-latency-trace.sh to folder tools/testing/fpu/
    (Ingo Molnar)

- Change from v1 to v2:
  - Reword the comments. (Laight, David; Mehta, Sohil)
  - Rename all variable 'dtsc' to 'latency'. (Mehta, Sohil)

Yi Sun (2):
  x86/fpu: Measure the Latency of XSAVE and XRSTOR
  tools/testing/fpu: Add script to consume trace log of xsave latency

 arch/x86/include/asm/trace/fpu.h         |  35 ++++
 arch/x86/kernel/fpu/xstate.h             |  49 ++++-
 tools/testing/fpu/xsave-latency-trace.sh | 227 +++++++++++++++++++++++
 3 files changed, 306 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/fpu/xsave-latency-trace.sh

-- 
2.34.1

