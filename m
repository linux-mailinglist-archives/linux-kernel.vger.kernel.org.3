Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303CD533F86
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241810AbiEYOsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiEYOsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:48:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D2B6CF59
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653490118; x=1685026118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+zf9BLb1YsbTyRecGKN57FpFRihXjMy/F9uE9o3MsKg=;
  b=etV9nnO3air4BNVBLHXuW550kAszXcHj8aDDS7Ukg4I8sERTZx4sJdYN
   KXCMbdlF4HkSacnEc3uF8aW3U7VR3wXoatfvWZgeeBuetAM1s5NlGbbY8
   jNlnm+gBIYAEJM3++kaLanTaAz8vWPDHfMcBcvUXZZAYJ65V1d3KK/OYr
   lICJf3Id9vmbZAr+RMNKJy80Yrjb0qow/kbILjW11JsdpjAKUb/AwOSZo
   S2jyrN7LFqSkzPKrMxkeqe8mbh8aCzz7tTcZYk21BMXOOC1BTWsgB9IJf
   yjUZFL2UZ1d/4gHHRJDDpbSfpxmE0oe0kRqbgWtZmGJhW6cMkDXGON6tR
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="253703392"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="253703392"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 07:48:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="549050144"
Received: from dev2.igk.intel.com ([10.237.148.94])
  by orsmga006.jf.intel.com with ESMTP; 25 May 2022 07:48:36 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Vineet Gupta <vgupta@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-snps-arc@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 1/2] ARC: bitops: Change __fls to return unsigned long
Date:   Wed, 25 May 2022 16:48:43 +0200
Message-Id: <20220525144844.1571705-2-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525144844.1571705-1-amadeuszx.slawinski@linux.intel.com>
References: <20220525144844.1571705-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per asm-generic definition and other architectures __fls should
return unsigned long.

No functional change is expected as return value should fit in unsigned
long.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 arch/arc/include/asm/bitops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/include/asm/bitops.h b/arch/arc/include/asm/bitops.h
index bdb7e190a294..4076607e7168 100644
--- a/arch/arc/include/asm/bitops.h
+++ b/arch/arc/include/asm/bitops.h
@@ -82,7 +82,7 @@ static inline __attribute__ ((const)) int fls(unsigned int x)
 /*
  * __fls: Similar to fls, but zero based (0-31)
  */
-static inline __attribute__ ((const)) int __fls(unsigned long x)
+static inline __attribute__ ((const)) unsigned long __fls(unsigned long x)
 {
 	if (!x)
 		return 0;
-- 
2.25.1

