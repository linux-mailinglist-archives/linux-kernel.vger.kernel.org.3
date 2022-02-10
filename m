Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598D84B1A85
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346417AbiBKAh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:37:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242949AbiBKAh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:37:56 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFF15F7C;
        Thu, 10 Feb 2022 16:37:56 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id s18so9531390ioa.12;
        Thu, 10 Feb 2022 16:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YsSFVcBAVgAnh1p0qtI8V/Jpa4hlZLllbwLcaFPQgA0=;
        b=cW/5wKGiWXoUhwkDkZDHsCqrs3nultWGlDM8mzcIOR/k2uTAprKe5yszATQTNPCSCJ
         1m7THR5JF2seGAiygdS0fr24QyEZT0sgAQ9wB5PCP4TWpuejgB2a01Q0MvyEJuc1shdA
         8CJ4yWoIsRObMajqGrLb7XTjEVviIfaKIgFnmab7Rbb4qJmhUzcNdYqczakRU0Ci90pn
         HqP+vbPkC+SeNc5JD+FFLVP2GkIQ8WDQIRlDpIQzZo52mMn00OCewffUksZ8Aol+2Bi+
         OejfdElRAWRhWleKV+UcqqDm0Zc49ACLla4SRERHQMkPyydvud7vDMi/NBzJxhFT+wlg
         2qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YsSFVcBAVgAnh1p0qtI8V/Jpa4hlZLllbwLcaFPQgA0=;
        b=2ZjnqgCD3j0TMjvn6h8UpEim5/VZECiOdeXMUy5SO7D+BRAeklrVmpMSxZxaEF6WOa
         UhbsHMa301YRH9W2lgs2Gkb/VSTP5ft5zwnnIoAJIVOj4Km4B0eXCPpJRTGSSt02g1eD
         CL0DpRETnK3Td4zHyxCAhLsJDrGSeze5aFjNb5WuLgnAvGlnA1noShbVW21zXPJSP5YX
         wK/Qwhq01XmsdGwP9+Lnd1b2ugUUdE7bS7Dh/ZAl/RyD7sEyVMeZY8V9Tahpu5Y/DGXt
         m4Z+/JD8f6F6l/SAwhPp9FI71RYBu62NXBvJ0MMd8CVSlT19mTE/8CC/hBLrfJS5N5Z1
         yQ0w==
X-Gm-Message-State: AOAM530SkE1r4qzasOEXBvdAJEN5FVpyC9ke9Lh5dttACyK2KfTuwrXj
        +2hDICgxkWTDz3BTZQoBUqg=
X-Google-Smtp-Source: ABdhPJw313nFWHa7NqEf6BSTSrIQf9t0LekjW6QyePAevB7Ed9CZMq3DGQ+dll3RTz0cTf9zJfAbpA==
X-Received: by 2002:a6b:d80c:: with SMTP id y12mr4955845iob.31.1644539875809;
        Thu, 10 Feb 2022 16:37:55 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id w11sm11664522ill.46.2022.02.10.16.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:37:55 -0800 (PST)
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
Subject: [PATCH 48/49] tools: bitmap: sync bitmap_weight
Date:   Thu, 10 Feb 2022 14:49:32 -0800
Message-Id: <20220210224933.379149-49-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210224933.379149-1-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
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

Pull bitmap_weight_{cmp,eq,gt,ge,lt,le} from mother kernel and
use where applicable.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 tools/include/linux/bitmap.h | 44 ++++++++++++++++++++++++++++++++++++
 tools/lib/bitmap.c           | 20 ++++++++++++++++
 tools/perf/util/pmu.c        |  2 +-
 3 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index ea97804d04d4..29bf54996a84 100644
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
+	if ((unsigned int)num > nbits)
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
2.32.0

