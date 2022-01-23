Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF474974BF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240174AbiAWSnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240144AbiAWSmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:42:22 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E7EC06177D
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:42:22 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id f8so13146029pgf.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uDMwxBm35O7PZhXWiy5lbRAhZckr6GgPEF1IMYcAF1M=;
        b=AixtNyS6WzA9hFKoRzjQ/Nln9Z2IsXf6Y7NSR+XlTdqyMMHMuAB2etyp7oOq8QIS23
         I5NqfG9LyPILw33K6lCPHGVtIDK4NaLmU8fQWqww30sYGKnx4PDt2aONbX5UMEU/mjhK
         E5zU6vYPgyNaxyMP8vXWHhTZDlaFuVqn8hGiPFJVtl9dQ0ESYF0VTL6Vxsn/otIIcGMK
         E7/QKttkC07gwR/Qm+a1n0sYX+y6sr6KITS56A52HAQbBPTaaKjVm1pCgLoux+lxSUVG
         63OBKz1TY9QXGAeTU5Oc1lyh/nXKFNj9zmcsV3DXXO8Acedl7zi7fw1xhVcB0FNayCMQ
         C5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uDMwxBm35O7PZhXWiy5lbRAhZckr6GgPEF1IMYcAF1M=;
        b=AgxYpJbsrRJaEszSfi7aubXIVvoBCYFrzDTgOidKgQKF5NiOog/kJkIYMxCshDy/Gp
         nONoYjnT6ONOmeND/1+2FZ/TWNP2fmqKfsL56vLNjUZSs6gSoQgOpPLX2NPoLzOa+p3y
         ZfQU0oanT9B4ja1fZ2sX62e/XsRpWcmv3VYEDyKXcsXRZlt8KRtn4oMQTjAS6OF0J1+k
         xUxJocX6BBpVG3kfIWIgG97gT3UB2Lmif/vLgf/4q4vrOyfxV6Dp5ZRLMXA8hL3LlWIR
         YojhQU9tqZ1EEb0+BdhI8ZdL18ztW7mXz9I9ZNi+xSRasuW5jRPFvWLUxsZbk3RZcpye
         GwPA==
X-Gm-Message-State: AOAM533/YIWOpehAlDRKoys2lQlY5L+g0mhuUWMAj+icD95VuV13x7jv
        7frnozPf9Dw5vRaBfojEuHI=
X-Google-Smtp-Source: ABdhPJwG05qeKKcQ0O7Z3UZL5849JmNqnV5VItZoESEHKIuMkhNSWZnyxQj1pjU7UR1Wcc2s8yUkKQ==
X-Received: by 2002:aa7:804c:0:b0:4bc:6ca6:4bac with SMTP id y12-20020aa7804c000000b004bc6ca64bacmr11151360pfm.52.1642963341772;
        Sun, 23 Jan 2022 10:42:21 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id q9sm13269180pfj.113.2022.01.23.10.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:42:21 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 49/54] lib/nodemask: add nodemask_weight_{eq,gt,ge,lt,le}
Date:   Sun, 23 Jan 2022 10:39:20 -0800
Message-Id: <20220123183925.1052919-50-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In many cases kernel code uses nodemask_weight() to compare the result
against some number or expression:

	if (nodes_weight(...) > 1)
		do_something();

It may be significantly improved for large nodemasks: if first few words
count set bits to a number greater than given, we can stop counting and
immediately return.

The same idea would work in other direction: if we know that the number
of set bits that we counted so far is small enough, so that it would be
smaller than required number even if all bits of the rest of the nodemask
are set, we can stop counting earlier.

This patch adds nodes_weight{eq, gt, ge, lt, le} helpers based on
corresponding bitmap functions. The following patches apply new functions
where appropriate.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/nodemask.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 567c3ddba2c4..197598e075e9 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -38,6 +38,11 @@
  * int nodes_empty(mask)		Is mask empty (no bits sets)?
  * int nodes_full(mask)			Is mask full (all bits sets)?
  * int nodes_weight(mask)		Hamming weight - number of set bits
+ * bool nodes_weight_eq(src, nbits, num) Hamming Weight is equal to num
+ * bool nodes_weight_gt(src, nbits, num) Hamming Weight is greater than num
+ * bool nodes_weight_ge(src, nbits, num) Hamming Weight is greater than or equal to num
+ * bool nodes_weight_lt(src, nbits, num) Hamming Weight is less than num
+ * bool nodes_weight_le(src, nbits, num) Hamming Weight is less than or equal to num
  *
  * void nodes_shift_right(dst, src, n)	Shift right
  * void nodes_shift_left(dst, src, n)	Shift left
@@ -240,6 +245,36 @@ static inline int __nodes_weight(const nodemask_t *srcp, unsigned int nbits)
 	return bitmap_weight(srcp->bits, nbits);
 }
 
+#define nodes_weight_eq(nodemask, num) __nodes_weight_eq(&(nodemask), MAX_NUMNODES, (num))
+static inline int __nodes_weight_eq(const nodemask_t *srcp, unsigned int nbits, int num)
+{
+	return bitmap_weight_eq(srcp->bits, nbits, num);
+}
+
+#define nodes_weight_gt(nodemask, num) __nodes_weight_gt(&(nodemask), MAX_NUMNODES, (num))
+static inline int __nodes_weight_gt(const nodemask_t *srcp, unsigned int nbits, int num)
+{
+	return bitmap_weight_gt(srcp->bits, nbits, num);
+}
+
+#define nodes_weight_ge(nodemask, num) __nodes_weight_ge(&(nodemask), MAX_NUMNODES, (num))
+static inline int __nodes_weight_ge(const nodemask_t *srcp, unsigned int nbits, int num)
+{
+	return bitmap_weight_ge(srcp->bits, nbits, num);
+}
+
+#define nodes_weight_lt(nodemask, num) __nodes_weight_lt(&(nodemask), MAX_NUMNODES, (num))
+static inline int __nodes_weight_lt(const nodemask_t *srcp, unsigned int nbits, int num)
+{
+	return bitmap_weight_lt(srcp->bits, nbits, num);
+}
+
+#define nodes_weight_le(nodemask, num) __nodes_weight_le(&(nodemask), MAX_NUMNODES, (num))
+static inline int __nodes_weight_le(const nodemask_t *srcp, unsigned int nbits, int num)
+{
+	return bitmap_weight_le(srcp->bits, nbits, num);
+}
+
 #define nodes_shift_right(dst, src, n) \
 			__nodes_shift_right(&(dst), &(src), (n), MAX_NUMNODES)
 static inline void __nodes_shift_right(nodemask_t *dstp,
-- 
2.30.2

