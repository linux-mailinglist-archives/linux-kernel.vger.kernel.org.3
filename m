Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268DA53E806
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbiFFKTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbiFFKT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:19:26 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B7A115CB8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:19:24 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id z17so12345961pff.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 03:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4akhw7wybTZyWH6tXqtxZK6m2uwvnVK6i/fg5yqCKis=;
        b=ODOAFqzeTzA3Pd7iDw4CT/qwXD8MzP35PnNskC0PUbDh98OG6ny7+OtpDOjCXMXoI5
         mr2wAAIwc3ToD7suonCFspVSoU0Jnl43mhCVLkyqm3vINxbRrk/mabGeGtRzc/u95fdV
         DC1reKM7dlxreJF23iIyimwtVCaepExf6YfD3ofRwyKCZ1dK25+IfbKmJSRa+bz+hsgI
         IZJ2UMWy//AgFz5Pvgc4wfIW6eB24XlM86TghFnCF4CTzyO/LUiWKSHU3zQbApwTMwyH
         FBIpJG1tdvqKiY/uQDhr5KGkn2kKgwp4XDtce6fuAXz12xEE4doHxUXOaC63wuHOTtkn
         nSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4akhw7wybTZyWH6tXqtxZK6m2uwvnVK6i/fg5yqCKis=;
        b=nrGfFkc1le9h7Z515FhcWY9C8/kXrMPYYhvg4TkQOBY4O7z3fHIrYCeHdDKuMOg8uJ
         NGxJHUfAydb8nubD1hduUvZDF9t9kzUmNbarKHmcBuEFAk0aTKYogV2mEhXMxzn2huB9
         2DjuXUhSKSTzNkVvysKqOkamOn5WBjpwsP9WT/uWklLPUdC1KuukuPXTFXUA4ekDEqyv
         4asAHDMTtNGBcdLmq7i4QVf6NZKyHl0eEan7tjW2qjY0ioNTeGMokcD/W5yzxZPm1r0n
         snWEOWz9GXFFArfWoawugp5vP+vcSjG4uF6WlsUNwswsGfw4FrJoI/0NLRdACTP2SrhV
         5QbQ==
X-Gm-Message-State: AOAM533aQdjgC+JqtiJCkWOSi2EXwRmU5d0SR+gkIyVPYqVJZLSAEKPK
        hTnseez/84iTTAjySoGL0LffF1sN6cHi+A==
X-Google-Smtp-Source: ABdhPJwmlZYDlrAKDbgSY+ucVxuP2JISTMWI6gieyMpwePhsCUAiN0T+VbPMbWYPlSjR/p4E89IrnA==
X-Received: by 2002:a63:401:0:b0:3fc:8810:f0ae with SMTP id 1-20020a630401000000b003fc8810f0aemr20306681pge.335.1654510764369;
        Mon, 06 Jun 2022 03:19:24 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id o13-20020a170902d4cd00b0015e8d4eb2aesm10234887plg.248.2022.06.06.03.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 03:19:24 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ferdinand.blomqvist@gmail.com, tglx@linutronix.de,
        Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PATCH 1/2] rslib: Replace hard-coded 1 with alpha_to[0]
Date:   Mon,  6 Jun 2022 18:19:00 +0800
Message-Id: <20220606101901.83538-1-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220605073857.126497-1-zhangboyang.id@gmail.com>
References: <20220605073857.126497-1-zhangboyang.id@gmail.com>
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

