Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABD0500289
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239325AbiDMXYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239303AbiDMXYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:24:34 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDF85EDE6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:21:57 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id l127so1580625pfl.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UM9NtFS2C2cjktUEm9aNoAq0M5aZEQyz1ml6+NlYQKY=;
        b=bxQ7mfJ64M61VNHKr5eU+RnJ0hXl2IfEGPvH8gf4KyvXd46WJYpDShYsvoPZMHZ36j
         yIlQ23iL8hlK5cnBXgrEDWSZuHluDlIvNRZEsjjHJ2ZO1rKHSz0P6/dT0Q0peDZlU/Tj
         d44pmAVX3yzgZrmMYNX0uYYuH3RLC/F7t3Jqy1VhjQWZT9hfkFzNO5VEL5nz871cBMy6
         IMWwRkPKAJ3ODVPYbeFER3079hJLHH04ZEJFhZTpwX2fIDqFoa9v/D34ITh1E/awXKUm
         KJJ0iF84bylRjSVysU4wbSuUNL0fkG5UmLh1jWCDygLjgixwWtxJnQSF+8iQIjr5ARJ9
         WhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UM9NtFS2C2cjktUEm9aNoAq0M5aZEQyz1ml6+NlYQKY=;
        b=WDZ6mTKmWb3K4RrYwntSt8bacQn+TiiU1qEQPs0Wt3BGVr4f98tMa/IsXXJBhyZN9G
         XiZVA+PJUKyjmj7BWHiDqL8aUu37iwIolsIn2bXD+hU1Cx2rxNf5xQBI38B381oPxqPp
         sV9Qnpt7js02PwqkAWFvCB6Zrr6X+gxDi7BKti8XVPNrhAvaS6hk47cOE3CAJhgsQRhV
         nIWGFNTB0majtDc1rfYwqDzL6plClntiQ1VR7WWOoIHvxHI3pWVpapiWmVjg0fClySjH
         AaPIV0F/iJGOGviac7sDwBJ2kquUhJHTYVLDbgrxspUWryr9pVwPOE1TxH8XxYQ1t4KJ
         HN9Q==
X-Gm-Message-State: AOAM533MtcCe4cWdI487+ab9x0lTPzeOecxvrAjSqJkUae3vTp4EUTxK
        uTh2pWLzV9OeP6tEEFYRNJrMk+PSOt4=
X-Google-Smtp-Source: ABdhPJyjFLIH5wU3fz1hztdDroHH3ZMnRuFklUDMTKCYbRlVsU6rJtmXoM80Qipw6lRHnPGwwbGWNg==
X-Received: by 2002:a05:6a00:228b:b0:4fa:e12b:2c7b with SMTP id f11-20020a056a00228b00b004fae12b2c7bmr11919291pfe.79.1649892116558;
        Wed, 13 Apr 2022 16:21:56 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:400:e00:389b:6ba3:7cbd:d8d])
        by smtp.gmail.com with ESMTPSA id b2-20020a6541c2000000b0039d1280084asm171811pgq.26.2022.04.13.16.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:21:55 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: localize labels used in memmove
Date:   Wed, 13 Apr 2022 16:21:42 -0700
Message-Id: <20220413232142.1210744-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Internal labels in the memmove implementation don't need to be visible,
localize them by prefixing their names with '.L'.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/lib/memcopy.S | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/xtensa/lib/memcopy.S b/arch/xtensa/lib/memcopy.S
index 582d817979ed..b20d206bcb71 100644
--- a/arch/xtensa/lib/memcopy.S
+++ b/arch/xtensa/lib/memcopy.S
@@ -402,13 +402,13 @@ WEAK(memmove)
 	 */
 	# copy 16 bytes per iteration for word-aligned dst and word-aligned src
 #if XCHAL_HAVE_LOOPS
-	loopnez	a7, .backLoop1done
+	loopnez	a7, .LbackLoop1done
 #else /* !XCHAL_HAVE_LOOPS */
-	beqz	a7, .backLoop1done
+	beqz	a7, .LbackLoop1done
 	slli	a8, a7, 4
 	sub	a8, a3, a8	# a8 = start of first 16B source chunk
 #endif /* !XCHAL_HAVE_LOOPS */
-.backLoop1:
+.LbackLoop1:
 	addi	a3, a3, -16
 	l32i	a7, a3, 12
 	l32i	a6, a3,  8
@@ -420,9 +420,9 @@ WEAK(memmove)
 	s32i	a7, a5,  4
 	s32i	a6, a5,  0
 #if !XCHAL_HAVE_LOOPS
-	bne	a3, a8, .backLoop1  # continue loop if a3:src != a8:src_start
+	bne	a3, a8, .LbackLoop1  # continue loop if a3:src != a8:src_start
 #endif /* !XCHAL_HAVE_LOOPS */
-.backLoop1done:
+.LbackLoop1done:
 	bbci.l	a4, 3, .Lback2
 	# copy 8 bytes
 	addi	a3, a3, -8
@@ -479,13 +479,13 @@ WEAK(memmove)
 #endif
 	l32i	a6, a3, 0	# load first word
 #if XCHAL_HAVE_LOOPS
-	loopnez	a7, .backLoop2done
+	loopnez	a7, .LbackLoop2done
 #else /* !XCHAL_HAVE_LOOPS */
-	beqz	a7, .backLoop2done
+	beqz	a7, .LbackLoop2done
 	slli	a10, a7, 4
 	sub	a10, a3, a10	# a10 = start of first 16B source chunk
 #endif /* !XCHAL_HAVE_LOOPS */
-.backLoop2:
+.LbackLoop2:
 	addi	a3, a3, -16
 	l32i	a7, a3, 12
 	l32i	a8, a3,  8
@@ -501,9 +501,9 @@ WEAK(memmove)
 	__src_b	a9, a6, a9
 	s32i	a9, a5,  0
 #if !XCHAL_HAVE_LOOPS
-	bne	a3, a10, .backLoop2 # continue loop if a3:src != a10:src_start
+	bne	a3, a10, .LbackLoop2 # continue loop if a3:src != a10:src_start
 #endif /* !XCHAL_HAVE_LOOPS */
-.backLoop2done:
+.LbackLoop2done:
 	bbci.l	a4, 3, .Lback12
 	# copy 8 bytes
 	addi	a3, a3, -8
-- 
2.30.2

