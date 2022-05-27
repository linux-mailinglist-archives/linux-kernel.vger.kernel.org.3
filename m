Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8193536254
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354246AbiE0MRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352575AbiE0MDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:03:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B279146766;
        Fri, 27 May 2022 04:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653652413; x=1685188413;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PLSGSElS+sb7LwGXdt/dcalTmumgey26T1nkiNfjmgo=;
  b=HXZl34fb35ca7l+fR027e1dv6/baoKuyQUkYbsD/LHXFLV4tyXMwnYjS
   tVX88kfQqsv6gYj9MLSCPCXnPvVInva2d6lMiA+zB1HremBJ7Yc6XttCP
   CzCwy6uNtlkCFu3QlPYymdDd9kFioxbyMKoxoCQXErpgsTw6h8u11Dvz1
   FHYGluYJ50R8OMlXRehuzjPkI8hI00EQDtWg3A502FMkYZbflIYsjCWkz
   lBv0VnzHSmldHo2hL8W3dKiKaIOPND2JfoWA2bzWkn2QmP3hWhURaZRaq
   hECPH8zcfP8d3gSjdlrHG5Upw1LjDDlLVNF6hv2Ns5z5kRuU+kRwz3L9J
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="274464803"
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="274464803"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 04:53:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="746889566"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orsmga005.jf.intel.com with ESMTP; 27 May 2022 04:53:30 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Vineet Gupta <vgupta@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        linux-snps-arc@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH v2 0/3] bitops: __fls adjustments
Date:   Fri, 27 May 2022 13:53:42 +0200
Message-Id: <20220527115345.2588775-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently on few architectures __fls is defined incorrectly. Fix this
by adjusting declarations to asm-generic ones.

As far as I can tell there should be no functional changes, but I don't
have devices to test it, so it was only compile tested.

Changes in v2:
  - change both declarations in ARC header (pointed by Guenter Roeck)
  - also change sparc64 declaration (pointed by Guenter Roeck)

Amadeusz Sławiński (3):
  ARC: bitops: Change __fls to return unsigned long
  m68k: bitops: Change __fls to return and accept unsigned long
  sparc64: bitops: Change __fls to return unsigned long

 arch/arc/include/asm/bitops.h      | 4 ++--
 arch/m68k/include/asm/bitops.h     | 2 +-
 arch/sparc/include/asm/bitops_64.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.25.1

