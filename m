Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4759B4E3A01
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiCVIAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiCVIAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:00:54 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64D65A5A1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:59:26 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id b67so13420429qkc.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mwOby9IVwYJiCSfVcktnzuwgksnwt4ejyOiDrK7Boqc=;
        b=Ova7SGpSJ7NF6kHqOnkA8W+/64yrl1WL/dF0LltcbckpdSux3J8hjlcnKanzu7dHKI
         HaCJB/OJsZA/8ejdupwJrke4RBInT8UJd06Pb91hkAzsCsMn60rJ+h+m4+Oe4kLHc3Ls
         zhDdwbAH1ZBI5KdUdpk/8fhBfYogp6t7RRA2KQe+H7MTUBxaXO90ke2m3y3KnzzDFah3
         tEx2TZbnk0giHWUgbXgNar9XoE3dFIcWhtkX/nAWkrPzbnqVgiRpes586KuoJuJEsi+D
         iplsMwpI2LbGiFmVu/PzFpFEWsxx4oleHsBXgtt6ro8kedJ2yWm/fqgvs8dSoX6WDtWL
         UhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mwOby9IVwYJiCSfVcktnzuwgksnwt4ejyOiDrK7Boqc=;
        b=DmvvN11efefoUeQ2qzQ4ACVGeg/B51XwAR+HAF5uNx8PD3Hi/lWENFNdz10lT45e6R
         5+HE7djdRqHt7lzWhIGs4fCgCsqOHMyok6oMn3BoHt1iGS3PfaM+ANBZOb5W9WFFXgUc
         FJ9Z8U/VWzCLhwpJbTSXIpQ9reMcHogO2808lGKXk3DlsiM4td4KA1AG3NZxyyKS3Pwh
         kaTjJspmGjSqtsua4OHPKQSXT7l1ov6WgckGwtD+387dfEkwjm4pRMcoz3qeCc4Q7s1b
         aNtr6QftXc9DfRASI+Rw7YE1iBUTj3LwQhncDJjr/NXphsWX0bHh4QnkyIgcgU2HIqW8
         xM9A==
X-Gm-Message-State: AOAM533ctY/1/8ujV3rg3i4tMaZhwC793HKyTi23Se+hiCNzxigtmMEq
        Bnnjol9YPCC0b8uJ7nHJo74=
X-Google-Smtp-Source: ABdhPJwDX3Wucs4JsC7GHfKymDfnnUli4DVPYCEkwVuUuYMEHJmndYOskvta09i3l0gzRCYQ+9QuGg==
X-Received: by 2002:a05:620a:144c:b0:67d:f6b5:1e9c with SMTP id i12-20020a05620a144c00b0067df6b51e9cmr14606576qkl.704.1647935966005;
        Tue, 22 Mar 2022 00:59:26 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 64-20020a370343000000b0067b31f32693sm8933455qkd.109.2022.03.22.00.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 00:59:25 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     Julia.Lawall@inria.fr
Cc:     nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        cocci@inria.fr, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] coccicheck: Add redundant return variable test
Date:   Tue, 22 Mar 2022 07:59:15 +0000
Message-Id: <20220322075915.2338847-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Minghao Chi <chi.minghao@zte.com.cn>

This semantic patch looks for variables that are only used
as parameter returned by the function.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 scripts/coccinelle/misc/redundant.cocci | 57 +++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 scripts/coccinelle/misc/redundant.cocci

diff --git a/scripts/coccinelle/misc/redundant.cocci b/scripts/coccinelle/misc/redundant.cocci
new file mode 100644
index 000000000000..57a4546783cb
--- /dev/null
+++ b/scripts/coccinelle/misc/redundant.cocci
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Remove redundant variables and return the value directly.
+///
+// Confidence: Moderate
+// Copyright: (C) 2022 Minghao Chi, ZTE.
+// URL: http://coccinelle.lip6.fr/
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual report
+virtual org
+
+@dislike@
+position p;
+identifier var;
+expression E;
+@@
+
+if(...)
+{
+ var = E;@p
+ return var;
+}
+
+@hope@
+identifier var, stru;
+expression E;
+position p!=dislike.p, p2;
+Type T;
+constant C;
+@@
+
+...when != T* var
+   when != struct stru* var;
+   when != var=C
+(
+ var = E;@p
+ return var;@p2
+)
+
+@script:python depends on report@
+p << hope.p;
+p2 << hope.p2;
+var << hope.var;
+@@
+
+coccilib.report.print_report(p[0], "Redundant variable: \"" + var + "\". Return \"" + var + "\" on line " + p2[0].line)
+
+@script:python depends on org@
+p << hope.p;
+p2 << hope.p2;
+var << hope.var;
+@@
+
+cocci.print_main("redundant \"" + var + "\" variable", p)
+cocci.print_sec("return " + var + " here ", p2)
-- 
2.25.1


