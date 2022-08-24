Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C44159F0E1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 03:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbiHXB0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 21:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiHXB0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 21:26:30 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05C783BEF
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:26:27 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id n21so11666099qkk.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=WSyI27urdzmwf9tUOgfmrDnxqX6zE0JEBEtl4DHjE1s=;
        b=BpHByFU8/H8TQoKF8x5gFZYmxMraso/cZxYbqIq9+p9rCRKrW6M6eChIXbLLzxF60F
         ht6ltF5L2sVipASa4yS8SGOMpalaIo9Qvzi3O3bQPVFXBbMPuj+5fj3ie/tb4i7EqLT1
         5I0mHz5X5cbzZkvsVOvxJACmIc1zuQ6s4i0wsOC+XsTQaKZDX1LMV9V5m0R35jYO877q
         QjMYurcpnilBnmM0M69Vz1UY3nhhGqUtt6nKITNOBdIDjMRTxYoci+RfNRpLT8V006RN
         W5fjK/Kn6MFtLtnMa44v8vxPaa7A0lYx6QHN0CPnDQYEZeiclVRsBIhYxRDqQpM6nzew
         mw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=WSyI27urdzmwf9tUOgfmrDnxqX6zE0JEBEtl4DHjE1s=;
        b=2EBlVP77tSEQiP4g7x9bdNKfhfqTUG69t0oL2gZezBGnJobPwInEw3T7XwSFevSnOZ
         6nxXQx3ERQ2bY19muoMQS/g75Z0KTXS6QwXp7UVof95DtE+T48dvTipPRDB5DuK2qblP
         mYAh9iRuYMkSkA9H93GcfsCmRhYWgMgJJtqJhGDgjsHqwCK1znwPCSx/GExXIez6zxKB
         sRoPbnHc0iShYBOQuXnaG5qLiB2NhsTEv+1d1xl7NrqyarzGU3wv+qMpSCM9IVEHMEp9
         r2IhJYJ0OcXNzmrZbZvGmDHgxeKJx9ij0PF2JFTyQ/ite7s25esvLZqi7x47aow2vGqx
         g5Uw==
X-Gm-Message-State: ACgBeo1O/dLV6EV5E4b3gaY+DnXhO5UhPQnuTiT+DCS6I8B0Sv5N0XHk
        O9Oc+Rd6lfrY7cmlWutm50c=
X-Google-Smtp-Source: AA6agR4Xg/pZtN2U59AhEJUjQdoX9ikiFpQKQ249+PLQntnFuil7UbJQVH7yQSqO536/N/CJhT44Yw==
X-Received: by 2002:a05:620a:2947:b0:6bb:5ff8:bb77 with SMTP id n7-20020a05620a294700b006bb5ff8bb77mr17322558qkp.537.1661304386738;
        Tue, 23 Aug 2022 18:26:26 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:9de8:f9bd:9f64:5017])
        by smtp.gmail.com with ESMTPSA id ez14-20020a05622a4c8e00b00342eff84177sm12327814qtb.29.2022.08.23.18.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 18:26:26 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Klimov <aklimov@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
Subject: [PATCH v2 0/4] lib: optimize find_bit() functions
Date:   Tue, 23 Aug 2022 18:26:21 -0700
Message-Id: <20220824012624.2826445-1-yury.norov@gmail.com>
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

  #define BIT_FIND_BODY(addr, size, start, EXPRESSION)		\
  	BIT_FIND_SETUP(addr, size, start)			\
  	BIT_FIND_FIRST_WORD(addr, size, start, EXPRESSION)	\
  	BIT_WORD_LOOP(addr, size, idx, val, EXPRESSION)		\
  	return size;						\
  found:	BIT_WORD_SWAB(val);				\
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
performance benchmark. See the last patch for some statistics.

v1: https://lore.kernel.org/all/20220728161208.865420-2-yury.norov@gmail.com/T/

Yury Norov (3):
  lib/find_bit: introduce FIND_FIRST_BIT() macro
  lib/find_bit: create find_first_zero_bit_le()
  lib/find_bit: optimize find_next_bit() functions

 MAINTAINERS          |   2 +
 include/linux/find.h |  46 +++++++++++++------
 lib/Makefile         |   1 +
 lib/find_bit.c       | 104 ++++++++++++-------------------------------
 lib/find_bit.h       |  45 +++++++++++++++++++
 lib/find_bit_be.c    |  42 +++++++++++++++++
 6 files changed, 152 insertions(+), 88 deletions(-)
 create mode 100644 lib/find_bit.h
 create mode 100644 lib/find_bit_be.c

-- 
2.34.1

