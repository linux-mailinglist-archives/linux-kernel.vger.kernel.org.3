Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2523522061
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347016AbiEJQBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347235AbiEJPwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:52:06 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9EF192B7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:47:57 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id p4so13818002qtq.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZBCHbbVfn2W7GCIwQZshDqoULkmiIrMZcuv1e33Ldn0=;
        b=dQ1GWa7V+6A4Ba0P/Loz6vdV8JkdlmKJOFYNtQyPpOLMo+TUFCoGk3C/oxbyjIEUR9
         qF8YHJmazC8RFIO7AvVXR3xUfjNQprYyQiXRQ7saJ8W/DkT0ozzAasW7JG9L2ALUYFkp
         1TQXGYSjQpdi8zpVvuxcZdxEJNTnzJv26oWSGrcJIyHWNod9AjDbXvzlay+wvTIF2anN
         lViq1b7ZCcsfVpRDVzOcNeOEVCXUbStQRloVX3eRJMtCSoFzL4Bs0SRTHObbsJITWZtZ
         +1NYpYaxGJfQv++ZyHlLTWtyWsO8HylA0GPqD6YiSYpwm79JUee4tVWS6sVbTTj2+oRb
         QF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZBCHbbVfn2W7GCIwQZshDqoULkmiIrMZcuv1e33Ldn0=;
        b=U+M7+c8Oxh+WvJZ2ebk2G0Wnm2MlWMIq7suIMWpm9H3G0ZpRQ2s7OeZ+pZ/aElK+XE
         Ka2NVOXS91bymW8PyiFtvm/mnxpIqHT5I6gj1eepZdFGwhhlLMG0snuvVD0evgvEFnkW
         wuASZK3DJkvZP5LuRGRdskyLJ3Bxeej8IBDCacEfDe44oOXUG/waYPJRk5UGUXYOdDMI
         3QAcqz3wR9Toz5PvXYvErSJkPTqPGNZiJU8KubJ+fFwEPFMOvYM46N2sQnNuY8ZW6Uns
         V8DwCk+c/nIprCKlcZGlHTBxh+AUT1hC4poYBpP/uSlMiW/naQo/Tn8MDJmrG2byLFYd
         0IIA==
X-Gm-Message-State: AOAM533KJiHjRKGMz2rkxmg1fDhu0TwdKQunhuapXtqUjNYc/jyZkSiB
        BtQxV8KmlWXt2hoxE4mY5cE=
X-Google-Smtp-Source: ABdhPJyJdQoZPyN3OxTbCUAfBqM+mpRRLD8sKoA6zBSO0+BMr1gYl5dyLfJnD+oibRJ+xp3OG2oVWg==
X-Received: by 2002:ac8:7d86:0:b0:2f3:c523:19a2 with SMTP id c6-20020ac87d86000000b002f3c52319a2mr20026391qtd.566.1652197676437;
        Tue, 10 May 2022 08:47:56 -0700 (PDT)
Received: from localhost ([98.242.65.84])
        by smtp.gmail.com with ESMTPSA id e13-20020a05620a014d00b0069fc13ce23esm8906393qkn.111.2022.05.10.08.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:47:56 -0700 (PDT)
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
Subject: [PATCH 02/22] introduce cpumask.cocci
Date:   Tue, 10 May 2022 08:47:30 -0700
Message-Id: <20220510154750.212913-3-yury.norov@gmail.com>
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

Using cpumask_weight() to compare weight of cpumask against a number
or expression is common but wrong pattern. The more efficient way is
to use cpumask_weight_{empty,full,gt,lt,ge,le,eq} as appropriate.

This patch adds cocci script to test sources for this.

CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Julia Lawall <Julia.Lawall@inria.fr>
CC: Nicolas Palix <nicolas.palix@imag.fr>
CC: Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC: linux-kernel@vger.kernel.org
CC: cocci@inria.fr
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 MAINTAINERS                          |  1 +
 scripts/coccinelle/api/cpumask.cocci | 51 ++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 scripts/coccinelle/api/cpumask.cocci

diff --git a/MAINTAINERS b/MAINTAINERS
index 17fd10824636..ecd97fdd5d67 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3524,6 +3524,7 @@ F:	lib/find_bit_benchmark.c
 F:	lib/nodemask.c
 F:	lib/test_bitmap.c
 F:	scripts/coccinelle/api/bitmap.cocci
+F:	scripts/coccinelle/api/cpumask.cocci
 F:	tools/include/linux/bitmap.h
 F:	tools/include/linux/find.h
 F:	tools/lib/bitmap.c
diff --git a/scripts/coccinelle/api/cpumask.cocci b/scripts/coccinelle/api/cpumask.cocci
new file mode 100644
index 000000000000..2eb930dbe9c4
--- /dev/null
+++ b/scripts/coccinelle/api/cpumask.cocci
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use cpumask_empty rather than cpumask_weight() == 0 etc
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
+if (cpumask_weight@p(...)) S
+
+@script:python depends on report@
+p << rempty1.p;
+@@
+
+for p0 in p:
+        coccilib.report.print_report(p0, "ERROR: use !cpumask_empty()")
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
+ cpumask_weight(...) cmp@p exp
+
+@script:python depends on report@
+p << rcmp.p;
+@@
+
+for p0 in p:
+        coccilib.report.print_report(p0,
+		"ERROR: use cpumask_weight_{empty,full,gt,lt,ge,le,eq} as appropriate")
+
+@script:python depends on org@
+p << rcmp.p;
+@@
-- 
2.32.0

