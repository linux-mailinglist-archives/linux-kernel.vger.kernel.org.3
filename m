Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70985884C3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 01:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbiHBXgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 19:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiHBXgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 19:36:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F5D12085;
        Tue,  2 Aug 2022 16:36:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E8F5B82082;
        Tue,  2 Aug 2022 23:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9FDC433D6;
        Tue,  2 Aug 2022 23:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659483369;
        bh=v5BpfTeeUnEg5aiY3JXzeQ9+oVLGf+XXAtusafcmUKA=;
        h=From:To:Cc:Subject:Date:From;
        b=GX4S/1RupGvypi9o/4VEONNJk88b0p04HGabcMEcfKRKtQJmeeL+ykEK5fulPVy9X
         LbDT3ayL+TirezyrK0cMuJLOp0U9SanhjUy+9EIr4Gsm9bwZrApLl//QJzzXJejtNx
         Mx+B3ey6NIYLzE1sl99YPrUYWB3ocg5jDZ61xLXzxQkbkHmf4zJOahSnMUsD6uE0EZ
         ixt8GnMEqhTuJ9aEB/TIfPmqxDJUhM0h+69r1moi1xgWA/hj7iq+lFP9jHrhsgdE7i
         mRPY0279OXn99EbYZvqk9W3DfIsezjYByT8FoaAWR+Rf5FBcvanqixiJkHCemNjluo
         HDRSWyuLPnjHA==
From:   broonie@kernel.org
To:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-s390@vger.kernel.org
Subject: linux-next: manual merge of the random tree with the s390-fixes tree
Date:   Wed,  3 Aug 2022 00:35:59 +0100
Message-Id: <20220802233559.2606732-1-broonie@kernel.org>
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

Today's linux-next merge of the random tree got a conflict in:

  arch/s390/include/asm/archrandom.h

between commit:

  918e75f77af7d ("s390/archrandom: prevent CPACF trng invocations in interrupt context")

from the s390-fixes tree and commit:

  d349ab99eec7a ("random: handle archrandom with multiple longs")

from the random tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/s390/include/asm/archrandom.h
index 4120c428dc378,cf5e000df0a14..0000000000000
--- a/arch/s390/include/asm/archrandom.h
+++ b/arch/s390/include/asm/archrandom.h
@@@ -11,47 -11,26 +11,28 @@@
  #ifndef _ASM_S390_ARCHRANDOM_H
  #define _ASM_S390_ARCHRANDOM_H
  
- #ifdef CONFIG_ARCH_RANDOM
- 
  #include <linux/static_key.h>
 +#include <linux/preempt.h>
  #include <linux/atomic.h>
  #include <asm/cpacf.h>
  
  DECLARE_STATIC_KEY_FALSE(s390_arch_random_available);
  extern atomic64_t s390_arch_random_counter;
  
- static inline bool __must_check arch_get_random_long(unsigned long *v)
- {
- 	return false;
- }
- 
- static inline bool __must_check arch_get_random_int(unsigned int *v)
- {
- 	return false;
- }
- 
- static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
+ static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t max_longs)
  {
- 	if (static_branch_likely(&s390_arch_random_available) &&
- 	    in_task()) {
- 		cpacf_trng(NULL, 0, (u8 *)v, sizeof(*v));
- 		atomic64_add(sizeof(*v), &s390_arch_random_counter);
- 		return true;
- 	}
- 	return false;
+ 	return 0;
  }
  
- static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
+ static inline size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs)
  {
 -	if (static_branch_likely(&s390_arch_random_available)) {
 +	if (static_branch_likely(&s390_arch_random_available) &&
 +	    in_task()) {
- 		cpacf_trng(NULL, 0, (u8 *)v, sizeof(*v));
- 		atomic64_add(sizeof(*v), &s390_arch_random_counter);
- 		return true;
+ 		cpacf_trng(NULL, 0, (u8 *)v, max_longs * sizeof(*v));
+ 		atomic64_add(max_longs * sizeof(*v), &s390_arch_random_counter);
+ 		return max_longs;
  	}
- 	return false;
+ 	return 0;
  }
  
- #endif /* CONFIG_ARCH_RANDOM */
  #endif /* _ASM_S390_ARCHRANDOM_H */
