Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7804D4974C5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240082AbiAWSnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240198AbiAWSmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:42:38 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EA7C0617A3;
        Sun, 23 Jan 2022 10:42:35 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so13570149pju.2;
        Sun, 23 Jan 2022 10:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CXYULLi3PASNYDuyMVe1ZOcJwgtgVdN/yE5O/a0uB5k=;
        b=EBlwI85Bbp4dt/mAkId3TjlgUi1+WVSFLBzAsO6qdsN8OkWVycPY02ONEgCFCYtrPp
         9jbRHmFFtKBqEEjSp2REFIp2gGt8TEbu7plsGMtxXUVV4SRs1bPYmhg5rdarJyC4wXJN
         O48VL6MBCdRj5GGLnF99bJTQrJ+Kawn/ILuPZJAoyt6GL/arqg/3zlZwBxXs95JKY1W7
         Lbtw1M3Y+nph1ONbaomtxJgVBDMJzKL7wpXIBhykwVGCfEuYZmfcjswjIEu/L7++/KsT
         etT1Sa2eUvukmUwrooVJYG25UOejsWMPwDkQ0l3X/ZXgECdi/lDg7/nYtQ6fs/q9cR39
         ILmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CXYULLi3PASNYDuyMVe1ZOcJwgtgVdN/yE5O/a0uB5k=;
        b=tNdBwuMUYFFCQjpySmZdl/3fNT0456rjTAFlaOIYnYo4tyCkL2AdhbjlOb367kXEIT
         gclsmNS41YwtmKaQEzu4eso3y5OjHes33aENq/iYIhb2lAI9rORTRJuowSLxsfU8SL0z
         rCC9bUFmO7zoP/kiBn7TJDq2AdxMV8XDWVM/QMK06rcfLuwODMwu4W2n+97a1srZV5Wo
         gGRDDXXvJRpsNSWa4YgA+BObrpWyjHhtayAgg+yMQ/vXkhEC1ODrjd5T9YxllCzC+LZc
         OXgRXxu9SJfbJwgjdyd96Rnb3BgzxjHZNErtMcE6e4RGQS0lRbzWxfeQz3hVaAqyuFsL
         F7cA==
X-Gm-Message-State: AOAM531mutAlUktWjIbvlqlVrlkC7XgfRqFMXFjdBLt0SMu9hrmX34B/
        HjxHGYhTNZmo1xT5wK6ul4E=
X-Google-Smtp-Source: ABdhPJxe/Ur2GuzvwBNqJcV/GLr6+a9GVwBzRQRxs4BSKqFLKxjVBkWf1QQy0aITY9KZJJVXij7Tpw==
X-Received: by 2002:a17:90b:3508:: with SMTP id ls8mr4353610pjb.214.1642963354651;
        Sun, 23 Jan 2022 10:42:34 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id d18sm13944708pfv.173.2022.01.23.10.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:42:34 -0800 (PST)
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
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 53/54] tools/bitmap: sync bitmap_weight
Date:   Sun, 23 Jan 2022 10:39:24 -0800
Message-Id: <20220123183925.1052919-54-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pull bitmap_weight_{cmp,eq,gt,ge,lt,le} from mother kernel and
use where applicable.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 tools/include/linux/bitmap.h | 44 ++++++++++++++++++++++++++++++++++++
 tools/lib/bitmap.c           | 20 ++++++++++++++++
 tools/perf/util/pmu.c        |  2 +-
 3 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index ea97804d04d4..e8ae9a85d555 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -12,6 +12,8 @@
 	unsigned long name[BITS_TO_LONGS(bits)]
 
 int __bitmap_weight(const unsigned long *bitmap, int bits);
+int __bitmap_weight_cmp(const unsigned long *bitmap, unsigned int bits,
+			 unsigned int num);
 void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, int bits);
 int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
@@ -68,6 +70,48 @@ static inline int bitmap_weight(const unsigned long *src, unsigned int nbits)
 	return __bitmap_weight(src, nbits);
 }
 
+static __always_inline
+int bitmap_weight_cmp(const unsigned long *src, unsigned int nbits, int num)
+{
+	if (num > (int)nbits || num < 0)
+		return -num;
+
+	if (small_const_nbits(nbits))
+		return hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits)) - num;
+
+	return __bitmap_weight_cmp(src, nbits, num);
+}
+
+static __always_inline
+bool bitmap_weight_eq(const unsigned long *src, unsigned int nbits, int num)
+{
+	return bitmap_weight_cmp(src, nbits, num) == 0;
+}
+
+static __always_inline
+bool bitmap_weight_gt(const unsigned long *src, unsigned int nbits, int num)
+{
+	return bitmap_weight_cmp(src, nbits, num) > 0;
+}
+
+static __always_inline
+bool bitmap_weight_ge(const unsigned long *src, unsigned int nbits, int num)
+{
+	return bitmap_weight_cmp(src, nbits, num - 1) > 0;
+}
+
+static __always_inline
+bool bitmap_weight_lt(const unsigned long *src, unsigned int nbits, int num)
+{
+	return bitmap_weight_cmp(src, nbits, num - 1) <= 0;
+}
+
+static __always_inline
+bool bitmap_weight_le(const unsigned long *src, unsigned int nbits, int num)
+{
+	return bitmap_weight_cmp(src, nbits, num) <= 0;
+}
+
 static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
 			     const unsigned long *src2, unsigned int nbits)
 {
diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index db466ef7be9d..06e58fee8523 100644
--- a/tools/lib/bitmap.c
+++ b/tools/lib/bitmap.c
@@ -18,6 +18,26 @@ int __bitmap_weight(const unsigned long *bitmap, int bits)
 	return w;
 }
 
+int __bitmap_weight_cmp(const unsigned long *bitmap, unsigned int bits, int num)
+{
+	unsigned int k, w, lim = bits / BITS_PER_LONG;
+
+	for (k = 0, w = 0; k < lim; k++) {
+		if (w + bits - k * BITS_PER_LONG < num)
+			goto out;
+
+		w += hweight_long(bitmap[k]);
+
+		if (w > num)
+			goto out;
+	}
+
+	if (bits % BITS_PER_LONG)
+		w += hweight_long(bitmap[k] & BITMAP_LAST_WORD_MASK(bits));
+out:
+	return w - num;
+}
+
 void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, int bits)
 {
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 8dfbba15aeb8..2c26cdd7f9b0 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1314,7 +1314,7 @@ static int pmu_config_term(const char *pmu_name,
 	 */
 	if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM) {
 		if (term->no_value &&
-		    bitmap_weight(format->bits, PERF_PMU_FORMAT_BITS) > 1) {
+		    bitmap_weight_gt(format->bits, PERF_PMU_FORMAT_BITS, 1)) {
 			if (err) {
 				parse_events_error__handle(err, term->err_val,
 					   strdup("no value assigned for term"),
-- 
2.30.2

