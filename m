Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6665691A4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbiGFSXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiGFSXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:23:04 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7B720193
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:23:03 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id ay10so19426652qtb.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tec8Pa6+4aUBm7TR1OiqeNa6UoFtj7s3ohyHFfAvUcY=;
        b=liJUqlVUP/V3F/KatPRarEzCwnL/FqEy36rqiMMklCWcJMIs6ILOVuE4H3OYdpKROq
         ld87lD7HInYelDTb7kjePfisvfAJqZBJpFAYQZO5YvZsZ9HwlC5bXHBXh/KHJhYlvywR
         W2MugFRwpQk5t/kVIbbDy6k/6ssnQaGW7HU29GBprffPMmXMG0F0G2Xxhl7JdPxG4tTe
         65oVfOyEsSz0303P6+gyGlqvyOVyHlJ50QSSD12TSDQDmE7Xz9t4Jq/kC/odJhzxKVQo
         i836Hp24FEoH10Ad+pD08rz6WWtH3szlKDYirshUq9S5Qmy99IxIVHqaik4N8QW8B8lw
         /jBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tec8Pa6+4aUBm7TR1OiqeNa6UoFtj7s3ohyHFfAvUcY=;
        b=EAaU3POByYhIDXf03ZOt9J2zoFJIAQC2ApndvJLun3taqu9xyOczobW1GyaTbyy3Er
         N6L0eWDhnzz8vDM7LuoX9erOe4FYShyQf/ZaJSTygj4LjzBn8tdEk/2SHizuh1njBGt4
         F9kGDqTN/bWtSANt39GXVmUHZxSxinfZCZsmIsDHzKFrXwfkIiChBJUBhhmrrthMrPbu
         DLAUi0FBi8lekkCLik+x0eBOtNsigT0JInpOVOndPppMptjW6UDRc0MFWsBtlwI65dmk
         ebjUix5uhhqRZO7k1hgVjQee7/KsS2xiJYDuftOP6N8F8/YgrEfLikg1hXzHAAtKn+uI
         bjVw==
X-Gm-Message-State: AJIora/trjYX1eETS7TUx1ZukbELPCYD5jTPQGGKZusa9RWPxgnOBOyR
        QZJvFQAKUBLOKH8+3Qzcmrnm1dcJ16QGSw==
X-Google-Smtp-Source: AGRyM1tSNpvVO+OEV1NpkndhEzaNeGVlNgBrfIM5uF3RaupKWCA2eMT1W3zFihDWENJdIhMPxBzNXw==
X-Received: by 2002:a05:622a:1014:b0:319:7601:c22 with SMTP id d20-20020a05622a101400b0031976010c22mr33923749qte.509.1657131782457;
        Wed, 06 Jul 2022 11:23:02 -0700 (PDT)
Received: from localhost (c-69-254-185-160.hsd1.fl.comcast.net. [69.254.185.160])
        by smtp.gmail.com with ESMTPSA id g11-20020ac8480b000000b003051ba1f8bcsm24083569qtq.15.2022.07.06.11.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:23:01 -0700 (PDT)
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
Subject: [PATCH 0/5] lib/find: add find_nth_bit()
Date:   Wed,  6 Jul 2022 11:22:55 -0700
Message-Id: <20220706182300.70862-1-yury.norov@gmail.com>
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

On top of "lib: cleanup bitmap-related headers":
https://lkml.org/lkml/2022/7/6/1202

Yury Norov (5):
  lib: add find_nth(,and,andnot)_bit()
  lib/bitmap: add tests for find_nth_bit()
  remove bitmap_ord_to_pos
  cpumask: add cpumask_nth_{,and,andnot}
  lib/nodemask: inline next_node_in() and node_random()

 MAINTAINERS              |  1 -
 include/linux/bitmap.h   |  1 -
 include/linux/bitops.h   | 19 ++++++++++
 include/linux/cpumask.h  | 44 ++++++++++++++++++++++
 include/linux/find.h     | 79 ++++++++++++++++++++++++++++++++++++++++
 include/linux/nodemask.h | 27 +++++++++++---
 lib/Makefile             |  2 +-
 lib/bitmap.c             | 36 ++----------------
 lib/cpumask.c            | 26 ++++++-------
 lib/find_bit.c           | 20 ++++++++++
 lib/find_bit_benchmark.c | 17 +++++++++
 lib/nodemask.c           | 31 ----------------
 lib/test_bitmap.c        | 36 +++++++++++++++++-
 13 files changed, 250 insertions(+), 89 deletions(-)
 delete mode 100644 lib/nodemask.c

-- 
2.34.1

