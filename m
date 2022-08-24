Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1902A59F5B6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiHXIuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbiHXItr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:49:47 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A028A1E2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661330982; x=1692866982;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4kZqvFG4tMiUnKB0w/rq1VrH8DwwrNQlje7Rk/MmMEQ=;
  b=ZuhcXayYC0xOYzdcpbiiObQxW+ta6+5H3uOUjvtU2JGD+V4rN3I+3TDu
   grwlu3SHZLI74udAfByYQcOh/3JvGdGV9YD5Dc8+JSNVI4xt4wjcD/p4v
   TgH9YfyVlPXrlkJH/vKLdCDF3S3RxMzKF3j9Ljf/Tv31e5PRO9MjHESzq
   0LMVDrNkvjdWuZawbg2oux8I4qiY6X4C4DnaNxy7YnX6DzjnR82fCrL8K
   tEAd5XBIBjHWaKlBYjgoe0wnnaSIgQb4WUxXsqJUv0mGynaHtSyADnJiA
   7wK2wGX3YHHaNC+M+5k/UxYpMn2+QjyqD++BUDepeknRDb3JT+8lkP8+v
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,260,1654531200"; 
   d="scan'208";a="207973719"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2022 16:49:40 +0800
IronPort-SDR: bA2WFiaiXE2bPlpWnmrqAVV3vj2MAImSEz2m/xbuqoB1wFHFNZf9zURqRAOd3Rxm8EBsFvBY5y
 /HSZ0fvmsgLW771aNS1VpueRrzFEGpEgojTN+apAKtXoDZnzUHFENnFcf1ownkECelRxum8m0H
 tbIPDhf4QdN4a+7MnTRqFb5Xb0nY/Fv51WbHqLBBaKQ39OcSQ0u06m13yR3ASkO3SmIaToi4xu
 udwp508b9NopLSJRnfIYtZZf9LyBVDaOiDRMoHtXiKFXG7zzIyzlyPkJ6ZM/0WubxvkCuAD/ll
 gAM3eISBnkEgyHcz/HDGd7yi
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2022 01:10:18 -0700
IronPort-SDR: aYy2ngGZRuaX5ZfUaVy9yvWD6gCrfGdmzX0SPZuoL8pJkiUMnuvy4EgHMN6Lc9MNN3IxeS834n
 mYPhxj5L67mTOCYOzq1s7Ll23K91bcy67c1imwcelZ79fzjufyor3NguFArPAV3FCH8hQBwXf7
 qUC6KnkHFJMI0KYBl9BFQk+0zZbTuZ7NrgSjbSjKhKTWu3risa3NNgyfeWdY9eE9oks5ZGMRZ9
 xIb1xOLPu3SS2eDJE4ByQc/JM85yGuU1kl9C0P7RAn/+jvvvQc6OPIsXNFrVN3DgHRIxkRUSph
 pYQ=
WDCIronportException: Internal
Received: from bsq92j3.ad.shared (HELO naota-xeon.wdc.com) ([10.225.50.4])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Aug 2022 01:49:38 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH] x86/mm: disable instrumentations of mm/pgprot.c
Date:   Wed, 24 Aug 2022 17:47:26 +0900
Message-Id: <20220824084726.2174758-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 4867fbbdd6b3 ("x86/mm: move protection_map[] inside the
platform") moved accesses to protection_map[] from mem_encrypt_amd.c to
pgprot.c. As a result, the accesses are now targets of KASAN (and other
instrumentations), leading to the crash during the boot process.

Disable the instrumentations for pgprot.c like commit 67bb8e999e0a
("x86/mm: Disable various instrumentations of mm/mem_encrypt.c and
mm/tlb.c").

Before this patch, my AMD machine cannot boot since v6.0-rc1 with KASAN
enabled, without anything printed. After the change, it successfully boots
up.

Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 arch/x86/mm/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index f8220fd2c169..829c1409ffbd 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -4,10 +4,12 @@ KCOV_INSTRUMENT_tlb.o			:= n
 KCOV_INSTRUMENT_mem_encrypt.o		:= n
 KCOV_INSTRUMENT_mem_encrypt_amd.o	:= n
 KCOV_INSTRUMENT_mem_encrypt_identity.o	:= n
+KCOV_INSTRUMENT_pgprot.o		:= n
 
 KASAN_SANITIZE_mem_encrypt.o		:= n
 KASAN_SANITIZE_mem_encrypt_amd.o	:= n
 KASAN_SANITIZE_mem_encrypt_identity.o	:= n
+KASAN_SANITIZE_pgprot.o		:= n
 
 # Disable KCSAN entirely, because otherwise we get warnings that some functions
 # reference __initdata sections.
@@ -17,6 +19,7 @@ ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_mem_encrypt.o		= -pg
 CFLAGS_REMOVE_mem_encrypt_amd.o		= -pg
 CFLAGS_REMOVE_mem_encrypt_identity.o	= -pg
+CFLAGS_REMOVE_pgprot.o			= -pg
 endif
 
 obj-y				:=  init.o init_$(BITS).o fault.o ioremap.o extable.o mmap.o \
-- 
2.37.2

