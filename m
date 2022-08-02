Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20BA5884FA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 01:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiHBX7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 19:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbiHBX7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 19:59:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35B1F26;
        Tue,  2 Aug 2022 16:59:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EEC3B810B0;
        Tue,  2 Aug 2022 23:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A64C433D6;
        Tue,  2 Aug 2022 23:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659484752;
        bh=3zynVtkDTgujG6R3R69iXj5aRl1n7katXwRdfFIKYVU=;
        h=From:To:Cc:Subject:Date:From;
        b=lwQpMzUW187ua3mOPz/2EXN0B423TQ663ztoXSvhJfMLaI8I9ZxFsAwFtWvvux2Fh
         ZkqEO7RQxMyRzZysyPAWAocJNE61zPnA7Etc93WeRqUpRTwL3DdNaKHCXzaXmDEHX4
         2M0WpIxZCSc1llZW4YauF95ZNKfpzD4oJFAuBFOd8u8+etcQLkf0e+Zi0MhYlXFKGs
         /uICmovnkr1CoV3JsFTacYSzZrmnpjqz+vBXV3zy5tWGjfxLrJ44PdqKtc0BpLXt4N
         hcgr9QQVFZjuim4PV3yuNSJB9DvG9kqSVI5JW/dHW7OxYPO1S7URQhr/PA4dcXC6Va
         RxI/hgE6WLgDA==
From:   broonie@kernel.org
To:     Yury Norov <yury.norov@gmail.com>
Cc:     "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bitmap tree with the random tree
Date:   Wed,  3 Aug 2022 00:59:03 +0100
Message-Id: <20220802235903.2660083-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the bitmap tree got a conflict in:

arch/powerpc/include/asm/archrandom.h

between commit:

  d349ab99eec7a ("random: handle archrandom with multiple longs")

from the random tree and commit:

  3e731203153de ("powerpc: drop dependency on <asm/machdep.h> in archrandom.h")

from the bitmap tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/powerpc/include/asm/archrandom.h
index 564859e6a807c,21def59ef1a68..0000000000000
--- a/arch/powerpc/include/asm/archrandom.h
+++ b/arch/powerpc/include/asm/archrandom.h
@@@ -2,22 -2,41 +2,17 @@@
  #ifndef _ASM_POWERPC_ARCHRANDOM_H
  #define _ASM_POWERPC_ARCHRANDOM_H
  
 -#ifdef CONFIG_ARCH_RANDOM
 +#include <asm/machdep.h>
  
 -bool __must_check arch_get_random_seed_long(unsigned long *v);
 -
 -static inline bool __must_check arch_get_random_long(unsigned long *v)
 +static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t max_longs)
  {
 -	return false;
 +	return 0;
  }
  
- static inline size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs)
 -static inline bool __must_check arch_get_random_int(unsigned int *v)
--{
- 	if (max_longs && ppc_md.get_random_seed && ppc_md.get_random_seed(v))
- 		return 1;
- 	return 0;
 -	return false;
 -}
 -
 -
 -static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
 -{
 -	unsigned long val;
 -	bool rc;
 -
 -	rc = arch_get_random_seed_long(&val);
 -	if (rc)
 -		*v = val;
 -
 -	return rc;
--}
 -#endif /* CONFIG_ARCH_RANDOM */
++size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs);
  
  #ifdef CONFIG_PPC_POWERNV
 -int powernv_hwrng_present(void);
 -int powernv_get_random_long(unsigned long *v);
 -int powernv_get_random_real_mode(unsigned long *v);
 -#else
 -static inline int powernv_hwrng_present(void) { return 0; }
 -static inline int powernv_get_random_real_mode(unsigned long *v) { return 0; }
 +int pnv_get_random_long(unsigned long *v);
  #endif
  
  #endif /* _ASM_POWERPC_ARCHRANDOM_H */
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 3b1cf9ca4814b..951822145600e 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -172,12 +172,12 @@ void (*pm_power_off)(void);
 EXPORT_SYMBOL_GPL(pm_power_off);
 
 #ifdef CONFIG_ARCH_RANDOM
-bool __must_check arch_get_random_seed_long(unsigned long *v)
+size_T __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs)
 {
-	if (ppc_md.get_random_seed)
-		return ppc_md.get_random_seed(v);
+	if (max_longs && ppc_md.get_random_seed && ppc_md.get_random_seed(v))
+		return 1;
 
-	return false;
+	return 0;
 }
 EXPORT_SYMBOL(arch_get_random_seed_long);
 
