Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA824974AD
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239606AbiAWSmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239887AbiAWSlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:41:52 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3D5C0613EC
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:41:41 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id v74so10524110pfc.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FpGkB1VQhnPPql1nIYBbXxejidNq19lPQtdnhOiEEDw=;
        b=XYd+pCzi4ZT+GjuWIA7KOpvcIA55kJ1GGwxi03S/32tAG3rkcZiB6MrLqmUrT7RkbE
         lx85QVKw/hzQx8cm441C9mDFEmr1tF/DCu+iMUyOHcf4tDdo/Sx183QfU3mCjyZ0V2oe
         nfNCIUq8w60/gcYRa0dScV70cJ3uIRN0tikaeTF21C1rJNdJPj/ATljgmjHMfpz9maBQ
         A/msWA6jpi+qqcrHKcXuLyGqy+ohgcCuwn551sxDj/UP0PDvOkaUbl7cJIQ1JGpUeMKQ
         HWzg2mcpuNVpexCE8PHN6NejQ+tZ7B87H9A5mVliwZ3ln09IhDFVTargeNi9UYHA14g+
         Rjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FpGkB1VQhnPPql1nIYBbXxejidNq19lPQtdnhOiEEDw=;
        b=jsEG/fy0KN3sCl/CgnW+bSMoSAMlnS/55c+/mxNacN5VmpSdgyrcPmA2l7KitcZUoq
         E8FWomu5bgR7v542Y0j0iKSGEAfElYTGDrN9UhQrbu+8BX82RtmDRRxE13ofzKn0uooJ
         qNE2NUQQBcDQjDs/Tvu90TbX9nzuA6F5eBwft55fFTxUm7aF5gjfjUrU5HpgfBtpIwCb
         +yQY4mQoJawmILfDG9VnH01q4nvV2hyBCnAq/UZTEyyTnjuakeKFXQojfEftw/olOEK4
         LMsw9XjdZW/4frplJnPp2TB8lGZZLMh7o51fnV9tSr01AmMNMJyPW8K1YqWHRb9EBOCD
         sEZw==
X-Gm-Message-State: AOAM532BZgFmLAVKP2lTWYn5ponjcFf3ygc0yNliyaICfDx1OIRXO2MJ
        e4q0M+wc/IlDljGVp+24bQk=
X-Google-Smtp-Source: ABdhPJxDuWuravBMI+rpmbnMCNC8EfAtpHxg3yYmz60gSnxCSHRycBJIQK5jLyWBzwNUeovtznVXXg==
X-Received: by 2002:a63:3fc5:: with SMTP id m188mr9367408pga.307.1642963301119;
        Sun, 23 Jan 2022 10:41:41 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id x1sm2314965pfh.167.2022.01.23.10.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:41:40 -0800 (PST)
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
Subject: [PATCH 36/54] lib/cpumask: add cpumask_weight_{eq,gt,ge,lt,le}
Date:   Sun, 23 Jan 2022 10:39:07 -0800
Message-Id: <20220123183925.1052919-37-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In many cases people use cpumask_weight() to compare the result against
some number or expression:

	if (cpumask_weight(...) > 1)
		do_something();

It may be significantly improved for large cpumasks: if first few words
count set bits to a number greater than given, we can stop counting and
immediately return.

The same idea would work in other direction: if we know that the number
of set bits that we counted so far is small enough, so that it would be
smaller than required number even if all bits of the rest of the cpumask
are set, we can stop counting earlier.

This patch adds cpumask_weight_{eq, gt, ge, lt, le} helpers based on
corresponding bitmap functions. The following patches apply new functions
where appropriate.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 50 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 64dae70d31f5..1906e3225737 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -575,6 +575,56 @@ static inline unsigned int cpumask_weight(const struct cpumask *srcp)
 	return bitmap_weight(cpumask_bits(srcp), nr_cpumask_bits);
 }
 
+/**
+ * cpumask_weight_eq - Check if # of bits in *srcp is equal to a given number
+ * @srcp: the cpumask to count bits (< nr_cpu_ids) in.
+ * @num: the number to check.
+ */
+static inline bool cpumask_weight_eq(const struct cpumask *srcp, unsigned int num)
+{
+	return bitmap_weight_eq(cpumask_bits(srcp), nr_cpumask_bits, num);
+}
+
+/**
+ * cpumask_weight_gt - Check if # of bits in *srcp is greater than a given number
+ * @srcp: the cpumask to count bits (< nr_cpu_ids) in.
+ * @num: the number to check.
+ */
+static inline bool cpumask_weight_gt(const struct cpumask *srcp, int num)
+{
+	return bitmap_weight_gt(cpumask_bits(srcp), nr_cpumask_bits, num);
+}
+
+/**
+ * cpumask_weight_ge - Check if # of bits in *srcp is greater than or equal to a given number
+ * @srcp: the cpumask to count bits (< nr_cpu_ids) in.
+ * @num: the number to check.
+ */
+static inline bool cpumask_weight_ge(const struct cpumask *srcp, int num)
+{
+	return bitmap_weight_ge(cpumask_bits(srcp), nr_cpumask_bits, num);
+}
+
+/**
+ * cpumask_weight_lt - Check if # of bits in *srcp is less than a given number
+ * @srcp: the cpumask to count bits (< nr_cpu_ids) in.
+ * @num: the number to check.
+ */
+static inline bool cpumask_weight_lt(const struct cpumask *srcp, int num)
+{
+	return bitmap_weight_lt(cpumask_bits(srcp), nr_cpumask_bits, num);
+}
+
+/**
+ * cpumask_weight_le - Check if # of bits in *srcp is less than or equal to a given number
+ * @srcp: the cpumask to count bits (< nr_cpu_ids) in.
+ * @num: the number to check.
+ */
+static inline bool cpumask_weight_le(const struct cpumask *srcp, int num)
+{
+	return bitmap_weight_le(cpumask_bits(srcp), nr_cpumask_bits, num);
+}
+
 /**
  * cpumask_shift_right - *dstp = *srcp >> n
  * @dstp: the cpumask result
-- 
2.30.2

