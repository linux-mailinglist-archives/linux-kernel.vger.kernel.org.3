Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A85A522062
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346667AbiEJQAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347241AbiEJPwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:52:08 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2CF1A39D
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:47:58 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id h3so13813201qtn.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=et/xiYs/rsa/96PjCIfZq4Lkirm6fP+CXISc9QiPIK0=;
        b=IsDOgG2uagbr6NRW6ovKobMGvzpUOdJua8IomfIiNU6kDenE1Fu0AzzB5huYoyIsvM
         GSl1FP99vh+9EOCA2jtut5n00UVVVi+nImR31WrNC8RBBH61gz4c4CrrzfOdrYRluMqO
         Jjv9iPDqhRMZOXgb4joUBT6ed7fr9EBDeoSj3T1JobV6kw0/gQLLicraQZEnMONYFWol
         zed+b0HzJuKZzDuwmhmcMPniQkqvUuAv5H3zt3vjooHfAwp2dL3NH/OUkKUgOKc+wDoS
         XGJYn+r/V6HohEOATqEKIb8OtAbowchcKwtrUr6SaRzzdJQYSnRqmdjNkBQEdqfhM1Gc
         PKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=et/xiYs/rsa/96PjCIfZq4Lkirm6fP+CXISc9QiPIK0=;
        b=KCOkX03LOYDqgpQ27swjlOyEcK1RDb98DQmasD7OfMUYa3C6HHgWk3FpPrsnWCOpK3
         08+G2wOb6u9apDl4byDtNfzFkB9FF3gifjPp/hSVAHvXEAGF980XUCBV0U1o8eqRYs73
         2SVQnzQY5PW5RW11cq/V8T36Df6RlDumI1rxgAOuoiny7rPeXSwtm+DGWJzO4T+LHX81
         l2vXsxnLQHv9R/ews/Ue74Kll8ViHCgpbCT3c30sX1sa/Qc/VrwyXuvgbsrU+4jErVZa
         PNB5fQfqExh6HX819CBIOTWu0TUHCICHCN15VwdAFCxBqEvG7nOGuFO0x9mXO/gcP/cH
         /4wQ==
X-Gm-Message-State: AOAM533Zohp3YI4mRRzyh8qSj+h5nUf/wBYtcc7OY8ZfjsFlmE5DyWCL
        EjmBziPF6AMJL2zc2teMLlg=
X-Google-Smtp-Source: ABdhPJy4QPoN+Z2RE2YbnC2pYatWTGT1l1v59rnUGl7znoVFZudpny6dgHhL6zpVCHzzIASWFVjQxA==
X-Received: by 2002:ac8:58ce:0:b0:2f3:a42d:ae28 with SMTP id u14-20020ac858ce000000b002f3a42dae28mr20031817qta.416.1652197677684;
        Tue, 10 May 2022 08:47:57 -0700 (PDT)
Received: from localhost ([98.242.65.84])
        by smtp.gmail.com with ESMTPSA id p5-20020ac84085000000b002f39b99f67esm9922487qtl.24.2022.05.10.08.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:47:57 -0700 (PDT)
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
Subject: [PATCH 03/22] introduce nodemask.cocci
Date:   Tue, 10 May 2022 08:47:31 -0700
Message-Id: <20220510154750.212913-4-yury.norov@gmail.com>
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

Using nodemask_weight() to compare weight of nodemask against a number
or expression is common but wrong pattern. The more efficient way is
to use nodemask_weight_{empty,full,gt,lt,ge,le,eq} as appropriate.

This patch adds cocci script to test sources for this.

CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Julia Lawall <Julia.Lawall@inria.fr>
CC: Nicolas Palix <nicolas.palix@imag.fr>
CC: Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC: linux-kernel@vger.kernel.org
CC: cocci@inria.fr
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 MAINTAINERS                           |  1 +
 scripts/coccinelle/api/nodemask.cocci | 51 +++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 scripts/coccinelle/api/nodemask.cocci

diff --git a/MAINTAINERS b/MAINTAINERS
index ecd97fdd5d67..69f95d79e5a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3525,6 +3525,7 @@ F:	lib/nodemask.c
 F:	lib/test_bitmap.c
 F:	scripts/coccinelle/api/bitmap.cocci
 F:	scripts/coccinelle/api/cpumask.cocci
+F:	scripts/coccinelle/api/nodemask.cocci
 F:	tools/include/linux/bitmap.h
 F:	tools/include/linux/find.h
 F:	tools/lib/bitmap.c
diff --git a/scripts/coccinelle/api/nodemask.cocci b/scripts/coccinelle/api/nodemask.cocci
new file mode 100644
index 000000000000..1d8578640d97
--- /dev/null
+++ b/scripts/coccinelle/api/nodemask.cocci
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use nodes_empty rather than nodes_weight() == 0 etc
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
+@rempty1 depends on !patch@
+position p;
+statement S;
+@@
+
+if (nodes_weight@p(...)) S
+
+@script:python depends on report@
+p << rempty1.p;
+@@
+
+for p0 in p:
+        coccilib.report.print_report(p0, "ERROR: use !nodes_empty()")
+
+@script:python depends on org@
+p << rempty1.p;
+@@
+
+@rcmp depends on !patch@
+expression exp;
+binary operator cmp = {>, <, >=, <=, ==, !=};
+position p;
+@@
+
+ nodes_weight(...) cmp@p exp
+
+@script:python depends on report@
+p << rcmp.p;
+@@
+
+for p0 in p:
+        coccilib.report.print_report(p0,
+		"ERROR: use nodes_weight_{empty,full,gt,lt,ge,le,eq} as appropriate")
+
+@script:python depends on org@
+p << rcmp.p;
+@@
-- 
2.32.0

