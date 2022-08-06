Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2084258B6C8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 18:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbiHFQZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 12:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiHFQZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 12:25:31 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307E11057E
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 09:25:28 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id v16-20020a17090abb9000b001f25244c65dso10866178pjr.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 09:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=4akhw7wybTZyWH6tXqtxZK6m2uwvnVK6i/fg5yqCKis=;
        b=b8XPMJIr1Kgg2dGOR27KlaTRLM6gL2PtCzD8IXcknbeGsz3gpmRwYrbnHeoPbXHdKJ
         pq7nB331ZAfrtXut6OVMWX9YoyQRS/T12bwSQKUZeSIILBNSApUxhEYJAVkyzf+VP1qk
         WE8W20fP4FenpD+BZTqIshUyvkkuyz88iT8HNCr+vjj3phUc96mpqfl2/crG2LfROiDU
         NK/mUbws2tlZMyUr9QbjxfXh2JPH5+o4wB7UlHOmxGZPk7o9Ufn+9y6j3E3HiOmSOKHa
         fswC+7ZzDFQoY5qK3V9AQqzLBmOThd/UxcHRMpSfJ3use8RBL/Q/hW8NFSCTZvO3RVQh
         MI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=4akhw7wybTZyWH6tXqtxZK6m2uwvnVK6i/fg5yqCKis=;
        b=ooyFp3DVKIwNR2xXkOiq8HhvTYp5dMRu6M5Y9Qxady2lkUPQgi0zaixG5ZVMOcOZZk
         7sTWii8ea0Gyd248il82CjeLP+OEMC7bngTYkJdP0fmyxfa5AjZ3n/u8K/0ZbuiemxXI
         77STDEQTuGXS+Jgnboa5f3nMHdlC6rKQ2Pu56AkqiMGlGTLwp3ZQgXgAbQ7jSFeRMta0
         A4Qg2MbyGSdfuW6b7Ee4Zt1k/7HZfV2oYXy3gbuN7e6BFkQM4ItnRPiFb27v6Uj70ch0
         qv6emZWVzBKCkTnsLmlQkvmQ9yMca/zGCtxsrpvWlSZ/ry7tDSzDOzVu+0uMZpsUmi1r
         LKfw==
X-Gm-Message-State: ACgBeo3jBXh/Bz+1rlzCv4cZbjZCiaTTJoYb9nUcIf7QCE+7PlVW7yuH
        GY/COWJ5M3ztSNAIHnSGtRQ=
X-Google-Smtp-Source: AA6agR4BIqC1PUplAkI53wIgGR2625Bz1/VUZPxTPdKi5KO5/d1J+mh6UKd1lZWifzbCSvXXkG3sOg==
X-Received: by 2002:a17:903:40c4:b0:16d:d2a9:43ae with SMTP id t4-20020a17090340c400b0016dd2a943aemr11525195pld.57.1659803128418;
        Sat, 06 Aug 2022 09:25:28 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id s1-20020a17090a2f0100b001f04479017fsm4990927pjd.29.2022.08.06.09.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 09:25:28 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PATCH RESEND V3 2/6] rslib: Replace hard-coded 1 with alpha_to[0]
Date:   Sun,  7 Aug 2022 00:25:06 +0800
Message-Id: <20220806162510.157196-3-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220806162510.157196-1-zhangboyang.id@gmail.com>
References: <20220806162510.157196-1-zhangboyang.id@gmail.com>
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

Currently the rslib allows customizing the finite field by the `gffunc'
parameter of init_rs_non_canonical(). However, there are several places
in rslib use hard-coded 1 instead of alpha_to[0], leading to errors if
gffunc(0) != 1. This patch fixes the problem. One of such `gffunc' might
be gffunc'(x) = swab16(gffunc(swab16(x))), as gffunc'(0) = swab16(1).
This special gffunc'(x) is useful when implementing RS coder for
16 bit foreign-endian symbols.

Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
---
 lib/reed_solomon/decode_rs.c    | 4 ++--
 lib/reed_solomon/reed_solomon.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
index 805de84ae83d..6c1d53d1b702 100644
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -104,7 +104,7 @@
 
  decode:
 	memset(&lambda[1], 0, nroots * sizeof(lambda[0]));
-	lambda[0] = 1;
+	lambda[0] = alpha_to[0];
 
 	if (no_eras > 0) {
 		/* Init lambda to be the erasure locator polynomial */
@@ -198,7 +198,7 @@
 	memcpy(&reg[1], &lambda[1], nroots * sizeof(reg[0]));
 	count = 0;		/* Number of roots of lambda(x) */
 	for (i = 1, k = iprim - 1; i <= nn; i++, k = rs_modnn(rs, k + iprim)) {
-		q = 1;		/* lambda[0] is always 0 */
+		q = alpha_to[0];	/* lambda[0] is always 0 */
 		for (j = deg_lambda; j > 0; j--) {
 			if (reg[j] != nn) {
 				reg[j] = rs_modnn(rs, reg[j] + j);
diff --git a/lib/reed_solomon/reed_solomon.c b/lib/reed_solomon/reed_solomon.c
index bbc01bad3053..bb4f44c8edba 100644
--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -131,9 +131,9 @@ static struct rs_codec *codec_init(int symsize, int gfpoly, int (*gffunc)(int),
 	rs->iprim = iprim / prim;
 
 	/* Form RS code generator polynomial from its roots */
-	rs->genpoly[0] = 1;
+	rs->genpoly[0] = rs->alpha_to[0];
 	for (i = 0, root = fcr * prim; i < nroots; i++, root += prim) {
-		rs->genpoly[i + 1] = 1;
+		rs->genpoly[i + 1] = rs->alpha_to[0];
 		/* Multiply rs->genpoly[] by  @**(root + x) */
 		for (j = i; j > 0; j--) {
 			if (rs->genpoly[j] != 0) {
-- 
2.30.2

