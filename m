Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752C15A395E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 19:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiH0R6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 13:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiH0R6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 13:58:16 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54427F32D8
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 10:58:10 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id j6so3430211qkl.10
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 10:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=VIkFpyC7MZhExmLqlrzsIInkcJ0/ZnrZ8S6+I/EQnYk=;
        b=XtKf9N8TN/0yjkKzfq4Wtz6xjDwYJ8VnByntVvYDnxeNDulAgmLMusPy4dOlv1NC9n
         fAa7NxMzaGgWSgxu39qyrSxXBsFY1OsJpVHcfEBdO8chiPWCrHJQRqomDHob7lgZkNHs
         qN6ZoNmMJmMxaHoLwcRwEE2zYLSLZLQX+kuBPQBvV4zXFsk6sA6+gnQVHAq/SslcXlsV
         iFzCHyVCekqFMFcN24meQSshaaJiitqbYGgQ6nWQ2fN2hWhKdSLZhw8incw64hGeCB16
         ecgaTqCTA8PDTfnuCoXYubQ6IRbbz6L/ktpVikNa265Pi76xP+WRcWwTHaTjVuDy/5yR
         i7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=VIkFpyC7MZhExmLqlrzsIInkcJ0/ZnrZ8S6+I/EQnYk=;
        b=dTAOSwA6PPB1f6D26urHlaVDZQsY1P9D7Aecq2wnevj6S/XH7ubZTkm2J/wdZDkGhN
         TVRbIPhhjhJ3fgxpjPqO57owCcVlU3btNTp6eJDRmKO/33qi06iGYeqzRLegCyx/wfWK
         eJ+e6bSMZIBJzY4/Mo5eyINgvgmdeaC53IDy1ntdJBpxQXb37NvOflhXg+w3l0oAmdy/
         BKCl/qpvgOR7Cjapb6RBTe6P7ydD7r0iYarBmLjffZG5Exu9UTY5Q4JIBfChhU0U0s+W
         hYLwsc2GPtdQv6Aapaop76TjejiX/DND6aPgcrdLfYYdqEzVw062epJ02mZELCk3fz0u
         Hx3w==
X-Gm-Message-State: ACgBeo3gaJQ6gwslf90lXKbMtilVbOkKGg0W/9j+drfq3ZEJHq+v5WgJ
        WiLE5eeU7gKg5Sa9BGcp5QA=
X-Google-Smtp-Source: AA6agR7aEqeWcY4TA4/n0FYQVhbw9yYnpMo+ZOX9BI6/enkdETZkrFyCYrPv7HT/KUUv3lbwkeMiiA==
X-Received: by 2002:a05:620a:4893:b0:6bb:869d:ecc9 with SMTP id ea19-20020a05620a489300b006bb869decc9mr3592665qkb.309.1661623089450;
        Sat, 27 Aug 2022 10:58:09 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:2454:ae5e:5655:e298])
        by smtp.gmail.com with ESMTPSA id y13-20020a05620a44cd00b006bb8b5b79efsm2460994qkp.129.2022.08.27.10.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 10:58:08 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Dennis Zhou <dennis@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v3 0/4] lib: optimize find_bit() functions
Date:   Sat, 27 Aug 2022 10:58:03 -0700
Message-Id: <20220827175807.4017673-1-yury.norov@gmail.com>
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

In the recent discussion, it was noticed that find_next_bit() functions may
be improved by adding wrappers around common __find_next_bit() in .c file.

As suggested by Linus, I tried the meta-programming trick with the
EXPRESSION macro, which is passed from wrapper into find_bit()
helpers:

  #define BIT_FIND_BODY(addr, size, start, EXPRESSION)          \
        BIT_FIND_SETUP(addr, size, start)                       \
        BIT_FIND_FIRST_WORD(addr, size, start, EXPRESSION)      \
        BIT_WORD_LOOP(addr, size, idx, val, EXPRESSION)         \
        return size;                                            \
  found:        BIT_WORD_SWAB(val);                             \
        return min((idx)*BITS_PER_LONG + __ffs(val), size)

  unsigned long _find_next_and_bit(const unsigned long *addr1,
                                 const unsigned long *addr2,
                                 unsigned long size,
                                 unsigned long start)
  { BIT_FIND_BODY(addr, size, start, addr1[idx] & addr2[idx]); }

I appreciated the potential of how the EXPRESSION works, but I don't like
that the resulting macro is constructed from pieces because it makes it
harder to understand what happens behind the ifdefery. Checkpatch isn't
happy as well because the final macro contains 'return' statement; and I
would agree that it's better to avoid it.

I spined the idea one more time, trying to make FIND helper a more or
less standard looking macros.

This new approach saves 10-11K of Image size, and is 15% faster in the
performance benchmark. See the 3rd patch for some statistics.

v1: https://lore.kernel.org/all/20220728161208.865420-2-yury.norov@gmail.com/T/
v2: https://lore.kernel.org/lkml/YwaXvphVpy5A7fSs@yury-laptop/t/
v3:
 - add a MUNGE parameter to FIND_{FIRST,NEXT}_BIT and keep all machinery
   in lib/find_bit.c;
 - rename EXPRESSION to FETCH, and add comments;
 - sync tools.

Yury Norov (4):
  lib/find_bit: introduce FIND_FIRST_BIT() macro
  lib/find_bit: create find_first_zero_bit_le()
  lib/find_bit: optimize find_next_bit() functions
  tools: sync find_bit() implementation

 include/linux/find.h       |  46 +++++++---
 lib/find_bit.c             | 178 ++++++++++++++++++++++---------------
 tools/include/linux/find.h |  61 +++----------
 tools/lib/find_bit.c       | 149 ++++++++++++++-----------------
 4 files changed, 220 insertions(+), 214 deletions(-)

-- 
2.34.1

