Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0695B522055
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347087AbiEJQBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347234AbiEJPwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:52:06 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C9C18E34
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:47:56 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id t16so13810793qtr.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pU7kC1SMo4mlTP7fmR59ozkw+4jH/4NJrCGuFJdf6A4=;
        b=jeTHL+zkb3ae98nnxoN+7AqqNSKIUvIKbCWy+KKPO0Yy+e0/IyD3M34Wwav9VY1MqP
         qBtHfminh+20L3UJ7VVq6aII3BSzarzWFYYI7OVAvt/38fBzk2Sj1ujp/Gqfvf4NmXRy
         HlohiNCPcThYZxFcUkOF3g0Imw0+5WTe7k0AUNXstVavNcPvzbP1hoHfGqYsWW7MEt8W
         dDl/3v4Lqf0fmdzWHiAjG2zocG+y6zMvXRrjwN64xPnmf1YdjS2EwK4u++MG6hvtG8XA
         BmSmG3hQvIkRhuqg3H3SPE5VwjKil3ri3u6auyhPuo5T7/ZWE9oDA+/k3R+Va+ocz6aP
         VZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pU7kC1SMo4mlTP7fmR59ozkw+4jH/4NJrCGuFJdf6A4=;
        b=rJ9ngJ7YveZCG19/bjz20JbBmqH6KWdLGbVX5DaMI1zpPcFFhwHbZ+PzdcA8Jk5VMV
         00qt5Apc9YV3iFZKNrYuwrlLhcL32CpotJLQNLQFOF//1S2EjEu4mrwWhG0wyrA9Byem
         rIbtT1dhrWCGZ8utrbjDIFOdeZc7yGTCvfM0FdXw9hJPb6uY6XLBjHMsjO0fmbXXEiKI
         j7wSpsrWyH/Fa1tADDrJG719ajWKJRdmeNxWEsQdKi3EwmvVseW3BqwzSyOrwxetqbVm
         ybChyx7botsZIGz2sIzisVUmRvnGY9L5E1dmUpvEh8EJDcpPAe0XQCXVWNqxWS34Ldm2
         NMSg==
X-Gm-Message-State: AOAM530QO6vwpW4wRM5mNhkwj9DGPYi4hKbCESf3A7CZGQIu4zuqxcln
        LmxU1Z3uWvDvlQhSnYLIQcc=
X-Google-Smtp-Source: ABdhPJy2pJ02ApIgBhzwy2wz2hCj3CKDavdxJ7zOVAt2upsy4uouBW6BbQL5+JNwjE1EnvY1ZSwPkQ==
X-Received: by 2002:a05:622a:587:b0:2f3:ced4:60ba with SMTP id c7-20020a05622a058700b002f3ced460bamr15492635qtb.493.1652197675159;
        Tue, 10 May 2022 08:47:55 -0700 (PDT)
Received: from localhost ([98.242.65.84])
        by smtp.gmail.com with ESMTPSA id d16-20020ac851d0000000b002f39b99f6bbsm9527839qtn.85.2022.05.10.08.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:47:54 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, cocci@inria.fr
Subject: [PATCH 01/22] introduce bitmap.cocci
Date:   Tue, 10 May 2022 08:47:29 -0700
Message-Id: <20220510154750.212913-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220510154750.212913-1-yury.norov@gmail.com>
References: <20220510154750.212913-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using bitmap_weight() to compare weight of bitmap against a number or
expression is common but wrong pattern. The more efficient way is to
use bitmap_weight_{empty,full,gt,lt,ge,le,eq} as appropriate.

This patch adds cocci script to test sources for this.

Because for short bitmaps there's no performance adwantage of conditional
bitmap_weight over regular one, and because readability of latter
may be considered better, bitmap_weight_{gt,lt,ge,le,eq} cases are
marked with WARNING.

CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC: Julia Lawall <Julia.Lawall@inria.fr>
CC: Nicolas Palix <nicolas.palix@imag.fr>
CC: linux-kernel@vger.kernel.org
CC: cocci@inria.fr
CC: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 MAINTAINERS                         |   1 +
 scripts/coccinelle/api/bitmap.cocci | 104 ++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 scripts/coccinelle/api/bitmap.cocci

diff --git a/MAINTAINERS b/MAINTAINERS
index f57e6d38a542..17fd10824636 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3523,6 +3523,7 @@ F:	lib/find_bit.c
 F:	lib/find_bit_benchmark.c
 F:	lib/nodemask.c
 F:	lib/test_bitmap.c
+F:	scripts/coccinelle/api/bitmap.cocci
 F:	tools/include/linux/bitmap.h
 F:	tools/include/linux/find.h
 F:	tools/lib/bitmap.c
diff --git a/scripts/coccinelle/api/bitmap.cocci b/scripts/coccinelle/api/bitmap.cocci
new file mode 100644
index 000000000000..24ff1809ba1f
--- /dev/null
+++ b/scripts/coccinelle/api/bitmap.cocci
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use bitmap_empty rather than bitmap_weight() == 0 etc
+///
+// Confidence: High
+// Copyright: (C) 2022 Yury Norov
+// URL: http://coccinelle.lip6.fr/
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual org
+virtual report
+virtual context
+virtual patch
+
+@rfull depends on !patch@
+position p;
+expression E1, E2;
+binary operator cmp = {==, !=, <};
+@@
+
+ bitmap_weight(E1,E2) cmp@p E2
+
+@script:python depends on report@
+p << rfull.p;
+@@
+
+coccilib.report.print_report(p[0], "ERROR: use bitmap_full()")
+
+@script:python depends on org@
+p << rfull.p;
+@@
+
+@rempty1 depends on !patch@
+position p;
+statement S;
+@@
+
+ if (bitmap_weight@p(...)) S
+
+@script:python depends on report@
+p << rempty1.p;
+@@
+
+for p0 in p:
+        coccilib.report.print_report(p0, "ERROR: use !bitmap_empty()")
+
+@script:python depends on org@
+p << rempty1.p;
+@@
+
+@rempty depends on !patch@
+position p;
+@@
+
+	bitmap_weight@p(...) == 0
+
+@script:python depends on report@
+p << rempty.p;
+@@
+
+for p0 in p:
+        coccilib.report.print_report(p0, "ERROR: use bitmap_empty()")
+
+@script:python depends on org@
+p << rempty.p;
+@@
+
+@not_rempty depends on !patch@
+position p;
+@@
+
+ bitmap_weight(...) @p> 0
+
+@script:python depends on report@
+p << not_rempty.p;
+@@
+
+for p0 in p:
+        coccilib.report.print_report(p0, "ERROR: use \"!bitmap_empty()\"")
+
+@script:python depends on org@
+p << not_rempty.p;
+@@
+
+
+@rcmp depends on !patch@
+expression exp;
+binary operator cmp = {>, <, >=, <=, ==, !=};
+position p;
+@@
+
+ bitmap_weight(...) cmp@p exp
+
+@script:python depends on report@
+p << rcmp.p;
+@@
+
+for p0 in p:
+        coccilib.report.print_report(p0,
+		"WARNING: use bitmap_weight_{gt,lt,ge,le,eq} as appropriate")
+
+@script:python depends on org@
+p << rcmp.p;
+@@
-- 
2.32.0

