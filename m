Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF02584E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 11:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbiG2J4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 05:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiG2J4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 05:56:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AB839B88
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 02:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659088571; x=1690624571;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hd4yBeblcxQsVx+6FcSZN/wuJ4PAllghkJOygeOK/VI=;
  b=W4df7bcj2ByLeJb+pUsvmby/QejMfrx+YRZwXFkXliqwjIzIFT+egC09
   3qnpKWSvwOV25GRFbx1LHY8vVY7FC8xBlLn/oyQd5mn1YrpS14x54tYv+
   R8B1/eTUrPIvRKfdVnc1vhnuv369gQ7WERDqgAPhZzdNgCBMQz8AoGEoc
   6eD7spWEME/AdFPkdYc81t7IZEIkZGi2tMIEVGWla7zX9ntnVHQErfSYR
   l0dNDB/5TRAySUOy9g7Y3sTwTvsuct7LanhJcBD8AA7xMVQHJFKfZEDjj
   Sm908N4UtyRMzRvLlVWXarw85TaXIRzK+RS2M4aIvq3u35Ep1h1pFMVdv
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="375036989"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="375036989"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 02:56:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="629315473"
Received: from sunyi-station.sh.intel.com (HELO sunyi-station..) ([10.239.159.10])
  by orsmga008.jf.intel.com with ESMTP; 29 Jul 2022 02:56:09 -0700
From:   Yi Sun <yi.sun@intel.com>
To:     dave.hansen@intel.com, sohil.mehta@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        david.laight@aculab.com
Cc:     heng.su@intel.com, yi.sun@intel.com
Subject: [PATCH v2 0/2] x86: Add xsave/xrstor Latency Trace Events and Consuming Script
Date:   Fri, 29 Jul 2022 17:56:06 +0800
Message-Id: <20220729095608.1475138-1-yi.sun@intel.com>
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

- Change from v1 to v2:
  - Reword the comments. (Laight, David; Mehta, Sohil)
  - Rename all variable 'dtsc' to 'latency'. (Mehta, Sohil)

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

