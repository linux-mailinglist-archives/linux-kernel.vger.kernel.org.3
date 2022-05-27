Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBB5536247
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354035AbiE0MRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352588AbiE0MD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:03:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D63149164;
        Fri, 27 May 2022 04:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653652415; x=1685188415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZtvwdBswObarSG+JCXhEU2uLIuCFq0FhxZEUfuA19u0=;
  b=JkHtmSU14EYPemC5M4HQJJx9j/G/ZQU1yT9zaveePaTwWc4O0JWdDAfE
   pneG/5C1mO8ytIuuErHVG38kE/5YSAmTd1cyRxVOQnH1cGnP0SRaJcvy9
   4bmtMBYJh/TrOX2CZbwGEzsrdX6gJ3Rr9HK1E+0BRP0JuyEmD1Xfp3KC/
   SBS0wo2jKbrM01rHxFjjLnbGI1bWGnhT7jh9R8tQHmif8jGwpLlziZhn3
   ibq/JsMOPngsC7jiWfBdxat8is/o/NXi+7kI4hOIxE37mqZ13Snptdd42
   M/t0RMrK8v2Okg5GdBlWKz6+0yhtbi5BFhAHW0BmmezFgRzEptFL17fRE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="274464808"
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="274464808"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 04:53:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="746889599"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orsmga005.jf.intel.com with ESMTP; 27 May 2022 04:53:32 -0700
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
        <amadeuszx.slawinski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v2 1/3] ARC: bitops: Change __fls to return unsigned long
Date:   Fri, 27 May 2022 13:53:43 +0200
Message-Id: <20220527115345.2588775-2-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220527115345.2588775-1-amadeuszx.slawinski@linux.intel.com>
References: <20220527115345.2588775-1-amadeuszx.slawinski@linux.intel.com>
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

As per asm-generic definition and other architectures __fls should
return unsigned long.

No functional change is expected as return value should fit in unsigned
long.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 arch/arc/include/asm/bitops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arc/include/asm/bitops.h b/arch/arc/include/asm/bitops.h
index bdb7e190a294..f5a936496f06 100644
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
@@ -131,7 +131,7 @@ static inline __attribute__ ((const)) int fls(unsigned int x)
 /*
  * __fls: Similar to fls, but zero based (0-31). Also 0 if no bit set
  */
-static inline __attribute__ ((const)) int __fls(unsigned long x)
+static inline __attribute__ ((const)) unsigned long __fls(unsigned long x)
 {
 	/* FLS insn has exactly same semantics as the API */
 	return	__builtin_arc_fls(x);
-- 
2.25.1

