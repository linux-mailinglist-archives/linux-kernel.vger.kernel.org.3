Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872B75690E7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbiGFRnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbiGFRm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:42:58 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC53255AB;
        Wed,  6 Jul 2022 10:42:57 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id ck6so19263374qtb.7;
        Wed, 06 Jul 2022 10:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HRbOPX+WUhFrYKzoluCaxZY8LvvDK+k9pUsQcmDb/F4=;
        b=Pxoxj03ulPHDq4s/o3TDl5U4j+O7JiUekxDtdlCXDdGnjrsbJnMEZGTURMn861MU7e
         BQP60+I9xORkdZAwAYzG4TIX7IaP+Mfkvhi0ATpmszHnbJZMq2nKTPlM7VhuvEZO+66l
         s+uHKfOUcetPpF5ybi67JsxkLL2oztdS4Oldr13AxJlaT9ZHH9UYHbvQpZVxLwAGguki
         XCJA2QMrffL6IPiE3sbKQVu/jLDukYhiUhKk0yrE1Yi9QadotWeHxAEtBkhCe4tpR/qZ
         h3nmaPO//KzjDQEfn0QcdkCxFcWawqlTa2ZRWrYHNbt+kTclrt9Bq3PRCK0fLn+em/It
         +tfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HRbOPX+WUhFrYKzoluCaxZY8LvvDK+k9pUsQcmDb/F4=;
        b=23bx2eciEP2qDifSi8862pfKTiGVMtAAoSe5FmAgCIdKceTHsJ9tuj35Fr/t7NI27k
         FsL3vAi+PypU01zBB0ljVj/qjK3iiossOP6YJ1xieycAJwYQyzMYTJHlhysU4K3YiWjv
         i7gjNPHs5JpuyrWrBP4Pln8Vlt+TWMZKeyTL08rQLevYdNvM8flSE1ywhB2FxBqRZWW5
         S97E5rqkqYngJCHmNhGO4RZdQxNgH2tDsm3JW4CNgtEmvNM3iVljkU7YleepptdZRoiU
         VKhJhmHMjBVtV1lW+GWP6D1nJiMyOtOzHEx3GGM07DdRF3yymX+rTZZOEY1QBXmmhEBQ
         kIyA==
X-Gm-Message-State: AJIora8mKyz8LJVBIC5k0Si9uToT25Ehg8ytP5F4YKjUpUFbl3iFeBVv
        VsSPwcGShcLuligXny+g6Z4XI/HTKbsz1w==
X-Google-Smtp-Source: AGRyM1sYo9q4pC/HP6vE7tooa9UhswxdS7S6YLHmNuAfjoqgpdDE4ytFctniTnj4EBTjrzSoMj71LA==
X-Received: by 2002:ac8:5a47:0:b0:31d:2388:48dc with SMTP id o7-20020ac85a47000000b0031d238848dcmr33826913qta.80.1657129376423;
        Wed, 06 Jul 2022 10:42:56 -0700 (PDT)
Received: from localhost (c-69-254-185-160.hsd1.ar.comcast.net. [69.254.185.160])
        by smtp.gmail.com with ESMTPSA id k1-20020a05620a414100b006af039ff090sm33393108qko.97.2022.07.06.10.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 10:42:56 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v2 00/10] lib: cleanup bitmap-related headers
Date:   Wed,  6 Jul 2022 10:42:43 -0700
Message-Id: <20220706174253.4175492-1-yury.norov@gmail.com>
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

This series unifies declarations of bitmap-related functions and aligns
return types with values that actually returned. Also, it moves one-liner
wrappers around cpumask functions into headers, so that compiler has a
chance to optimize better.

With this series, GCC 11.2 for ARM64 with kernel v5.19-rc4:
add/remove: 15/7 grow/shrink: 461/164 up/down: 14844/-4580 (10264)

This +10K didn't surprise me because  modern compilers are more aggressive
in inlining, loop unrolling, and other techniques that increase size of
the image.

v1: https://lore.kernel.org/linux-mm/YsAzU3g2QpgmIGre@smile.fi.intel.com/T/
v2: - Align whitespaces in headers;
    - Make bitmap_weight() unsigned long consistently;
    - Pick 2 patches from Ingo's sched/headers series [1] that split
      linux/gfp.h, and drop my similar patch for it.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/log/?h=sched/headers

Ingo Molnar (2):
  headers/deps: mm: Optimize <linux/gfp.h> header dependencies
  headers/deps: mm: Split <linux/gfp_types.h> out of <linux/gfp.h>

Yury Norov (8):
  arm: align find_bit declarations with generic kernel
  lib/bitmap: change return types to bool where appropriate
  lib/bitmap: change type of bitmap_weight to unsigned long
  cpumask: change return types to bool where appropriate
  lib/cpumask: change return types to unsigned where appropriate
  lib/cpumask: move trivial wrappers around find_bit to the header
  headers/deps: mm: align MANITAINERS and Docs with new gfp.h structure
  lib/cpumask: move some one-line wrappers to header file

 Documentation/core-api/mm-api.rst |   8 +-
 MAINTAINERS                       |   1 +
 arch/arm/include/asm/bitops.h     |  18 +-
 include/linux/bitmap.h            |  13 +-
 include/linux/cpumask.h           | 125 +++++++++--
 include/linux/gfp.h               | 348 +-----------------------------
 include/linux/gfp_types.h         | 348 ++++++++++++++++++++++++++++++
 lib/bitmap.c                      |   9 +-
 lib/cpumask.c                     |  97 +--------
 tools/include/linux/bitmap.h      |  12 +-
 tools/lib/bitmap.c                |   6 +-
 11 files changed, 494 insertions(+), 491 deletions(-)
 create mode 100644 include/linux/gfp_types.h

-- 
2.34.1

