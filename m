Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB12533F87
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244902AbiEYOss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241507AbiEYOsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:48:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1FF6CF4C
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653490120; x=1685026120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3tpP5OcS3DtXXabkYSPMX7+If5Ij31PZoojd2jKhDdY=;
  b=QIJXgonqw2Gat882ytA3jvTvvcBFJtyVehF2GGTV9jmtY7R3b/cm4Xu+
   Q8OOjDt14nLs1trRWdCASI0DyRu16Hp6XSj7YkAB6Nk7z+WUlU/soi567
   hWwJ0gUNORerWvpFAE26THAXVJkMWNwlD3oGWbSazTDo7lxgRIX7QHDGS
   6pi6Hxbt4LH9dQrCk7qdyR1na34KtXD2yAlBqjVIp0huR4sTU9jZhOW9J
   iKqkFxKCNylNsWZSa5PjGIGE60hwuM1cqAmUTLe1IgxSqmBwZGaIqBy0K
   94e706yqoTWDmxJdCTUrNZU7uubkXyAicV6EGFUCRYWcIKHLy8mZOjN8A
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="253703400"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="253703400"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 07:48:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="549050157"
Received: from dev2.igk.intel.com ([10.237.148.94])
  by orsmga006.jf.intel.com with ESMTP; 25 May 2022 07:48:38 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Vineet Gupta <vgupta@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-snps-arc@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 2/2] m68k: bitops: Change __fls to return and accept unsigned long
Date:   Wed, 25 May 2022 16:48:44 +0200
Message-Id: <20220525144844.1571705-3-amadeuszx.slawinski@linux.intel.com>
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
return and accept unsigned long as its parameter.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 arch/m68k/include/asm/bitops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index 51283db53667..87c2cd66a9ce 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -510,7 +510,7 @@ static inline int fls(unsigned int x)
 	return 32 - cnt;
 }
 
-static inline int __fls(int x)
+static inline unsigned long __fls(unsigned long x)
 {
 	return fls(x) - 1;
 }
-- 
2.25.1

