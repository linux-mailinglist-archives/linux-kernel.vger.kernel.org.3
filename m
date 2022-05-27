Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C3253623A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354159AbiE0MRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352379AbiE0MEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:04:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8235914A268;
        Fri, 27 May 2022 04:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653652420; x=1685188420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vuMs6VJt08rsTnYrQbFKCLWhZ1eIAOf5fKrz74zRkw0=;
  b=bkPxNI9RMPjF243yqx64n7hGe3o1zbhmam6Q7T1qyyzxjBNOFX8lWNfg
   dot/BQ94Zqm81fAZDBaH4pOwZIE8u8tvmhZ3qndsphXo9MBgxQ0TU7W0k
   7nzUAp0XhYocvZorU11YbtVxxMzxYEk6GjHJleObRv6In4hbjBnlgVVLj
   uRX+iDKGOZiA24toUMy98APepXn4YU/euI2g6NQNKwKdPyYlrww+iQPkt
   PifgNhOYiNCG/GbvY6g1rRTqszHzRSiCD0Neiht24KAavtr+XFBtMlQ9E
   RbwEzEWPCdj8VpodQTiREcAiG2Ma2S1aOvD5dv4iKIEtZFiTEZ9Njrd58
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="274464822"
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="274464822"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 04:53:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="746889640"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orsmga005.jf.intel.com with ESMTP; 27 May 2022 04:53:37 -0700
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
Subject: [PATCH v2 3/3] sparc64: bitops: Change __fls to return unsigned long
Date:   Fri, 27 May 2022 13:53:45 +0200
Message-Id: <20220527115345.2588775-4-amadeuszx.slawinski@linux.intel.com>
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
 arch/sparc/include/asm/bitops_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/bitops_64.h b/arch/sparc/include/asm/bitops_64.h
index 005a8ae858f1..cdac39bd7b32 100644
--- a/arch/sparc/include/asm/bitops_64.h
+++ b/arch/sparc/include/asm/bitops_64.h
@@ -24,7 +24,7 @@ void clear_bit(unsigned long nr, volatile unsigned long *addr);
 void change_bit(unsigned long nr, volatile unsigned long *addr);
 
 int fls(unsigned int word);
-int __fls(unsigned long word);
+unsigned long __fls(unsigned long word);
 
 #include <asm-generic/bitops/non-atomic.h>
 
-- 
2.25.1

