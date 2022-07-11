Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2151156D401
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 06:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiGKErT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 00:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGKErQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 00:47:16 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107E05FB6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 21:47:15 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id r17so3462576qtx.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 21:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qKpfneDSj3EsL4GYiXg/kJBemuTg2dYhQqGiF/Pp+Pg=;
        b=BQB468npOuu044E47CPGZ3iNMI1f3KiVwHA+oWQ9vd4PlAumQqjGCTUvQ6lWw2DtHu
         er44+nShLZArTF1kTIaGvBs7xRxjyOxTqa8LXjv/3PDZDZOMLNbeYdGZdbNdeq6spFp6
         qG81g0Cl0NVkFYupBB9lfWXZZFNIXnUcMCMitwv8bV2ovvBGCpcX+/oOaizCd6LLuIGo
         7ZIfR56aFkXWepC19H7UqFbwJl4xizdiZEnpRPR+JcgQxXXrrz497/Xk5lQkNxdvVHND
         Z0f4MA6gahDts/HJiXlg48/IcL2WWDFRjz3lMuwJjoX85XI8d2mK4q8oAB+7Hc7OpmV3
         jp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qKpfneDSj3EsL4GYiXg/kJBemuTg2dYhQqGiF/Pp+Pg=;
        b=yU/E1Pr1SbKLdq8PTkoeYgnh6gczrV62033ZlKlbEbaxSPVy6WdJMK7cXk7VNFdvvN
         mxDCTm0Odrufl4PRmMoniOdYisqBDP+qE9mDpmD5bb1dwriLpChBvyNtz9+IsyQVXqpU
         l4NTWE6dV+t0FesKNI4XbNkmJEAfvZiwrw2cAPXB7gP4y+Lxa1XaStt6vDpnLJGWJhJd
         t8H0bMgAduA8HPsxlu4Fz5D71DNfGoJLs58y9Y9s8QtWmVDUyUG4erlEb9MLnnPNKgR5
         /KfHegW/oODCeLlooApObBZ9O9L2HI3i7UfPica7wMI4sF439hRAL0E2skR3rH+0Q38x
         QEog==
X-Gm-Message-State: AJIora8LLfX8+fldQh0pfoJhSvC+3RNLLahJq3uBUyi8rbK3bWZZJ/QQ
        DSQoGT5//CaJqc6XjvQ4SkiFzC0yYciv/g==
X-Google-Smtp-Source: AGRyM1sYxidI+3BbtFCWuTDkRoh/Du2xJIO0FdrBGGFSm05CJh/3eqOK9ARxdpTogo2CKA3Kp9DV8A==
X-Received: by 2002:ac8:5b85:0:b0:31c:b896:fb7d with SMTP id a5-20020ac85b85000000b0031cb896fb7dmr12444872qta.188.1657514833796;
        Sun, 10 Jul 2022 21:47:13 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:a22e:180:f963:1eff])
        by smtp.gmail.com with ESMTPSA id cd13-20020a05622a418d00b0031bf5677d96sm4810873qtb.84.2022.07.10.21.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 21:47:13 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v2 0/5] lib/find: add find_nth_bit()
Date:   Sun, 10 Jul 2022 21:47:06 -0700
Message-Id: <20220711044711.466822-1-yury.norov@gmail.com>
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

Kernel lacks for a function that searches for Nth bit in a bitmap.
Usually people do it like this:
        for_each_set_bit(bit, mask, size)
                if (--n == 0)
                        return bit;

Which is not so elegant, and very slow.

This series adds fast routines for this task, and applies them where
appropriate.

While here, move thin wrappers around find_bit() in nodemask.c to a
corresponding header, and because nodemask.c is empty after that,
remove it.

v1: https://lore.kernel.org/lkml/20220706182300.70862-4-yury.norov@gmail.com/T/
v2: - count Nth bit from 0 (was 1);
    - use 'invert' trick in _find_nth_bit(), as in _find_next_bit();
    - cleanup comments;
    - fns() is kept inline - looking at __ffs() generic implementation,
      I decided to keep it untouched.

Yury Norov (5):
  lib: add find_nth(,and,andnot)_bit()
  lib/bitmap: add tests for find_nth_bit()
  lib/bitmap: remove bitmap_ord_to_pos
  cpumask: add cpumask_nth_{,and,andnot}
  lib/nodemask: inline next_node_in() and node_random()

 MAINTAINERS              |  1 -
 include/linux/bitmap.h   |  1 -
 include/linux/bitops.h   | 19 +++++++++
 include/linux/cpumask.h  | 44 +++++++++++++++++++++
 include/linux/find.h     | 83 ++++++++++++++++++++++++++++++++++++++++
 include/linux/nodemask.h | 27 ++++++++++---
 lib/Makefile             |  2 +-
 lib/bitmap.c             | 36 ++---------------
 lib/cpumask.c            | 26 ++++++-------
 lib/find_bit.c           | 20 ++++++++++
 lib/find_bit_benchmark.c | 17 ++++++++
 lib/nodemask.c           | 31 ---------------
 lib/test_bitmap.c        | 36 ++++++++++++++++-
 13 files changed, 254 insertions(+), 89 deletions(-)
 delete mode 100644 lib/nodemask.c

-- 
2.34.1

