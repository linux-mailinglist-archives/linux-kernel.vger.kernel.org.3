Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3721590B86
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 07:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbiHLFeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 01:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbiHLFea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 01:34:30 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C2FA0259
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 22:34:29 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id j6so71116qkl.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 22:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=caCCypVCkkPwtyuZfjcpcNl53GHIrW+l2NO11GLmyxM=;
        b=MlvvCFjI4vAOgJApqcOpCVCnfzROg4g0phC8A4+nJbDRctVUBA5Tc7wNoqivDanYCu
         OLDL+cVJaPqhbUmJ338eul/ympcArE/tvPpTs707t56QoTZC571HZ6Kx9QyIR8CnU7kF
         Q36bKvHhzxkSVwdRuacdrIY8KEeCJi7eaFP441b7s9VVSrBFXjxSwOZKZvleUotkAlYN
         ijwrobL6c1f6zRdf2NftnGCsDuuWWjUhBIZo9co5FSVav4Anqe/mCItlVBuU+bnPUz24
         oz7mMmeUusFuTLAYqExe0hs+lrfMTjnflxiw6NzIWKv7XNGMXaP6ZnjxVrqGP9CdSxMS
         ilgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=caCCypVCkkPwtyuZfjcpcNl53GHIrW+l2NO11GLmyxM=;
        b=IWEtjjSpMcG8lqeek7SSxVyk+iaVpLX4g6NZJsbG/qEgQ0VkmagH+J60L5A/PzSB/c
         4KtKItNVMKMRp5W5q7zoQe7hK0ZYoCZedyIcrMF4puIrr6OLN7M508gbWLTCxOMCyuGj
         A3jNNaRyl87x+xtkgx/PlslH+l52x4W6gevoqyyFdN2jz+FCt7g1Ohtgu7XDUvrO1Mlv
         uHe4yn3Ie6xElqs1gwHVkA+JWSWBHGd8mjHR+eJGwqG0mUB+HRYtQkpRAJ85sB/2OFNn
         OAgBBVBsZNswaDyKyoOUmMOtWGdeNL0t4Rf4UR6xo+IZpQxFpSk9nBS2Rb5GeoBGfI0P
         RQqQ==
X-Gm-Message-State: ACgBeo1CPnhN5gPsLYHJaI+bB8uE/3qcjwhWy/OlZQtJ9rZbbLU+POdS
        L6zfZnnaAkr1l+SawoiDuHXxJyaUr24=
X-Google-Smtp-Source: AA6agR5KJDgMkSd/4Fc/xSzcXD4wXBkUryYD0ohy3AqwhNKbphvGk/iGVdAEHnrU9ro0+BtzZ0/lrQ==
X-Received: by 2002:a05:620a:372c:b0:6b6:133e:1f4b with SMTP id de44-20020a05620a372c00b006b6133e1f4bmr1738472qkb.358.1660282468186;
        Thu, 11 Aug 2022 22:34:28 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id n11-20020ac85a0b000000b00342eff84177sm1112505qta.29.2022.08.11.22.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 22:34:28 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] radix-tree: replace gfp.h inclusion with gfp_types.h
Date:   Thu, 11 Aug 2022 22:34:25 -0700
Message-Id: <20220812053425.2499799-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Radix tree header includes gfp.h for __GFP_BITS_SHIFT only. Now we
have gfp_types.h for this.

Fixes powerpc allmodconfig build:
   In file included from include/linux/nodemask.h:97,
                    from include/linux/mmzone.h:17,
                    from include/linux/gfp.h:7,
                    from include/linux/radix-tree.h:12,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/pci.h:35,
                    from arch/powerpc/kernel/prom_init.c:24:
   include/linux/random.h: In function 'add_latent_entropy':
>> include/linux/random.h:25:46: error: 'latent_entropy' undeclared (first use in this function); did you mean 'add_latent_entropy'?
      25 |         add_device_randomness((const void *)&latent_entropy, sizeof(latent_entropy));
         |                                              ^~~~~~~~~~~~~~
         |                                              add_latent_entropy
   include/linux/random.h:25:46: note: each undeclared identifier is reported only once for each function it appears in

Reported-by: kernel test robot <lkp@intel.com>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/radix-tree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
index f7c1d21c2f39..eae67015ce51 100644
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -9,7 +9,7 @@
 #define _LINUX_RADIX_TREE_H
 
 #include <linux/bitops.h>
-#include <linux/gfp.h>
+#include <linux/gfp_types.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/math.h>
-- 
2.34.1

