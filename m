Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14435690F8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbiGFRnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiGFRnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:43:03 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033D2255AB;
        Wed,  6 Jul 2022 10:43:02 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id b125so11570337qkg.11;
        Wed, 06 Jul 2022 10:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JCJEdfzYxuANLNWAxL8CQ7FpG0f6ZAq5X4D5qi7db0c=;
        b=DlO/3qfZ5SSLrurU8TbdBO3ykda2jyUu5uXNtEnQ4tu3AGC7cNFHyY+D2NSEg6ZaBG
         1f6immiGZzz70rKonuz5vWo1KVSlX0yJmmc0sbvOGdHX1cC0RmG10khnUrBzCRi8xfdj
         e1IOH+ymxc4QGC09nAE3BsZS/vpSFggfxT/Ju/dUGOqNC9xdApSAk20YhCGMFyCt+7uv
         KSrryPl+vZMQccCl8cj7RgYIjlZjztJPJYwO+odSVn9Y0JMChn/k/c7/UCgw3I8NwDH/
         MWN1A/cf2aveIjoTbKiyR2goy4betfbXx4oxkhBynEasZGgcFPpIIdLcbAcok+M/6nbs
         SwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JCJEdfzYxuANLNWAxL8CQ7FpG0f6ZAq5X4D5qi7db0c=;
        b=tahzNX2ZBi2u7WpC/wFhk6D+gBAMJctkiPJB+8mBTbo9BR6aHpgn5reqYwuKmTawWe
         fks6mufVpx8dZUlzQtI4L39rznv+To1harJFOVhx8cha4mvd6FO8o1MlH5TFK1AKy7y/
         gHd2ZwpKIafs7+3XK6G4brb9F6xbtXgamwGXZv1/6DrLjOfPfr3ly+ko9yWoUdKLUuVo
         /TXIgCgPOajApnxZyP/ArruyY1AlVOb8KaW1XHbYs/vvU0DVHu1WOycXAadEZjMkAscN
         P39FSK7kCGwbmhZt2+dnXBj0eOe92xXsjJ0h96SGBMrRyUilgAK2hiocEurTFYNFxyEC
         j9cA==
X-Gm-Message-State: AJIora9X/mxRCvqTgtw0idpNXvWunWOsTDPCyk60yAS0zTYEb3mQSIlC
        N47+gPVGInpaHfWba++PpENTI38pUXyXyA==
X-Google-Smtp-Source: AGRyM1s+B46jQkrgWjQT9gY1k2Eac7Vkm7juIehWaTjcv9o5gxS0vNO3Xns1iF8qG2/K8x0tu2kPTQ==
X-Received: by 2002:a05:620a:4505:b0:6b3:7c51:537c with SMTP id t5-20020a05620a450500b006b37c51537cmr11461188qkp.69.1657129380906;
        Wed, 06 Jul 2022 10:43:00 -0700 (PDT)
Received: from localhost (c-69-254-185-160.hsd1.ar.comcast.net. [69.254.185.160])
        by smtp.gmail.com with ESMTPSA id a21-20020a05620a16d500b006a7502d0070sm28319377qkn.21.2022.07.06.10.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 10:43:00 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 04/10] cpumask: change return types to bool where appropriate
Date:   Wed,  6 Jul 2022 10:42:47 -0700
Message-Id: <20220706174253.4175492-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706174253.4175492-1-yury.norov@gmail.com>
References: <20220706174253.4175492-1-yury.norov@gmail.com>
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

Some cpumask functions have integer return types where return values
are naturally booleans.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index fe29ac7cc469..b54e27d9da6b 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -372,9 +372,9 @@ static __always_inline void __cpumask_clear_cpu(int cpu, struct cpumask *dstp)
  * @cpu: cpu number (< nr_cpu_ids)
  * @cpumask: the cpumask pointer
  *
- * Returns 1 if @cpu is set in @cpumask, else returns 0
+ * Returns true if @cpu is set in @cpumask, else returns false
  */
-static __always_inline int cpumask_test_cpu(int cpu, const struct cpumask *cpumask)
+static __always_inline bool cpumask_test_cpu(int cpu, const struct cpumask *cpumask)
 {
 	return test_bit(cpumask_check(cpu), cpumask_bits((cpumask)));
 }
@@ -384,11 +384,11 @@ static __always_inline int cpumask_test_cpu(int cpu, const struct cpumask *cpuma
  * @cpu: cpu number (< nr_cpu_ids)
  * @cpumask: the cpumask pointer
  *
- * Returns 1 if @cpu is set in old bitmap of @cpumask, else returns 0
+ * Returns true if @cpu is set in old bitmap of @cpumask, else returns false
  *
  * test_and_set_bit wrapper for cpumasks.
  */
-static __always_inline int cpumask_test_and_set_cpu(int cpu, struct cpumask *cpumask)
+static __always_inline bool cpumask_test_and_set_cpu(int cpu, struct cpumask *cpumask)
 {
 	return test_and_set_bit(cpumask_check(cpu), cpumask_bits(cpumask));
 }
@@ -398,11 +398,11 @@ static __always_inline int cpumask_test_and_set_cpu(int cpu, struct cpumask *cpu
  * @cpu: cpu number (< nr_cpu_ids)
  * @cpumask: the cpumask pointer
  *
- * Returns 1 if @cpu is set in old bitmap of @cpumask, else returns 0
+ * Returns true if @cpu is set in old bitmap of @cpumask, else returns false
  *
  * test_and_clear_bit wrapper for cpumasks.
  */
-static __always_inline int cpumask_test_and_clear_cpu(int cpu, struct cpumask *cpumask)
+static __always_inline bool cpumask_test_and_clear_cpu(int cpu, struct cpumask *cpumask)
 {
 	return test_and_clear_bit(cpumask_check(cpu), cpumask_bits(cpumask));
 }
@@ -431,9 +431,9 @@ static inline void cpumask_clear(struct cpumask *dstp)
  * @src1p: the first input
  * @src2p: the second input
  *
- * If *@dstp is empty, returns 0, else returns 1
+ * If *@dstp is empty, returns false, else returns true
  */
-static inline int cpumask_and(struct cpumask *dstp,
+static inline bool cpumask_and(struct cpumask *dstp,
 			       const struct cpumask *src1p,
 			       const struct cpumask *src2p)
 {
@@ -474,9 +474,9 @@ static inline void cpumask_xor(struct cpumask *dstp,
  * @src1p: the first input
  * @src2p: the second input
  *
- * If *@dstp is empty, returns 0, else returns 1
+ * If *@dstp is empty, returns false, else returns true
  */
-static inline int cpumask_andnot(struct cpumask *dstp,
+static inline bool cpumask_andnot(struct cpumask *dstp,
 				  const struct cpumask *src1p,
 				  const struct cpumask *src2p)
 {
@@ -539,9 +539,9 @@ static inline bool cpumask_intersects(const struct cpumask *src1p,
  * @src1p: the first input
  * @src2p: the second input
  *
- * Returns 1 if *@src1p is a subset of *@src2p, else returns 0
+ * Returns true if *@src1p is a subset of *@src2p, else returns false
  */
-static inline int cpumask_subset(const struct cpumask *src1p,
+static inline bool cpumask_subset(const struct cpumask *src1p,
 				 const struct cpumask *src2p)
 {
 	return bitmap_subset(cpumask_bits(src1p), cpumask_bits(src2p),
-- 
2.34.1

