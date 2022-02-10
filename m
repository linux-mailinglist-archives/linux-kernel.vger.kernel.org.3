Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32A44B1A21
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346162AbiBKAJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:09:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346149AbiBKAJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:09:07 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9C82734
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:09:07 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id s18so9475391ioa.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4opLWPM2zNGxYK/Q3wpGKFEipyHS9bpsKAz2hDFfcuU=;
        b=Wc1DpM2btDFmtN2luf7HF0t4hU44TIGq/0YL0bpQa6g+iE8hZBeyWR92RUacj652vT
         xTeWUzCzvTHlJzr3SFJuRLsV9NQaWHOLGUB9F8QWcCEv36Iz7c7sVdetuTXYoqfu2Xo2
         2bLumF+y0+7NHCuNnuvWraBPfeGbS2BODGTmwgjbZdGEZV7P3V4faUYlSK5hlqIOQ9SL
         OOWmkUgaoa892REhSeotBEng3Rz/QPBMv0BGWqzsAdVEHT/kGDjwr43k+E7DXLkjcWXB
         ijOPcoOAyAU22WMkLEB0E3iCCK6HFjZUcR6/2zVmaKNY3u07dpAQUstPDRGeps8VWJjX
         eftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4opLWPM2zNGxYK/Q3wpGKFEipyHS9bpsKAz2hDFfcuU=;
        b=h2OXAva7WB4xinFY3uYLRZ3CrdUQxHr4SOHqzhyCI1yoKjiTe5OioMuF7u1S8znFm1
         vUD6NKMPo0MEqhhs9wtpPTLIqxrcb2mJeVOzZ1OhSUAaZaP7bmTj7gKBj1wdNr2LeaqL
         XBo+KIKKn7XXqPoBUguG4qYTLKruEh0rkZIXdLjlmAaunI4NnwZMgbgDiqu+dRYrR7t4
         byJzz9M4DjzNgnWaPujqATpS4x5eysC05dNdL2tTCQYdIBX6EtT4Ua0aeBYbXPDhH0um
         XPrpT45PFG1hXSJZySwU5I4fkjqeMRCw5RzdDysNPTRpcH5U9ZIyFuafrgC1kHcOvipj
         D4Ow==
X-Gm-Message-State: AOAM5335gd8e0kUIk4YrrftLMiSumpWuaEeAP+4ut5HI6xz2VXvvg6LJ
        TRTkigd0/9AhgHKtL3o4SBI=
X-Google-Smtp-Source: ABdhPJzOtCPYAM7lNC3ivI+eGe1Vm96G5CP/MEuWyQgdhttuG5n0Y7IOVFiufLeO2bodUS0FCAeGyA==
X-Received: by 2002:a05:6602:1407:: with SMTP id t7mr5040293iov.82.1644538147202;
        Thu, 10 Feb 2022 16:09:07 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id t2sm7942285ilp.49.2022.02.10.16.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:09:06 -0800 (PST)
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
Subject: [PATCH 35/49] cpumask: add cpumask_weight_{eq,gt,ge,lt,le}
Date:   Thu, 10 Feb 2022 14:49:19 -0800
Message-Id: <20220210224933.379149-36-yury.norov@gmail.com>
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
index 6b06c698cd2a..0037297c542a 100644
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
2.32.0

