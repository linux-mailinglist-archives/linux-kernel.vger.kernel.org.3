Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189FE5883B4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 23:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbiHBVlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 17:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiHBVlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 17:41:11 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A665A1276B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 14:41:08 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31f3959ba41so128305177b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2Oj7GKF36foN2xzCMJsEg/+ZHnZe2AIMZ3VLvOtF3gc=;
        b=l6RqDs+6IFXZysUKYya+R2SsHON0bu+fj6nv8FJ2gUbVtp4O/HIgYSN/38/CqG5HRu
         au7OcsDePs0imDGdkEyVhyIIUQ/OrQE5M681LoehpxdcXXlSSJh1djFJyTMxKdSctxWH
         VoMCamxtk3CGNmlLDmDw28s43YK55CBM06tLbJ/wnYt99tryonQLpqEPRUZZXESrkMpH
         k57YmQNgepcAKV1U1GCP1z2le0W08M7mAf7wPTe40UWcP+KwVQbNEBhXumli6b6X0b+P
         S7oY8JYeBGskER/uu1K3oFT77WVw/lFLLCe8C6ebdRV2S6erXziWBElZhCAxem+WN/NR
         GGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2Oj7GKF36foN2xzCMJsEg/+ZHnZe2AIMZ3VLvOtF3gc=;
        b=xz/0w8C2FJP2eexRmgZqAKV9k3Wusi1f5zXdX5uk2dcp8dP2h+IlmI5Q2fW0mE6ol4
         IqD6IvjyRXAPwHot1O8M25199JgFxNnDx28tF89uEX1D6kF8UJnLrkcwJdZvVJRpzDbk
         8n1zS8wq/hXw2OKrIutjNVCin892GE1hqVT/UE5pelNRGlqLT5Xl28nS42oCxZg3747j
         x5oQKHB8ACwYlelueDr/uFwfUET32rtIWYc0/+yWsNKEv+0FH1CrbP+njmehixT7av6T
         Ah9edMsTOTU5Ph/lJPCBW4GgdeAW18tQt1STlTfpFLPgqQBxQ9sww2e+2OVmiovlacC6
         p4jw==
X-Gm-Message-State: ACgBeo0kS8Tk4S66352/V+SAClizV5mE+w/ksHjFaWiVgRxf+j++Er1a
        Xdsht/Tcx2eUOaMbu0h0lInJsgfuf/Z4iw==
X-Google-Smtp-Source: AA6agR6Vs262m5nFKDt9CTk3P/SK98G7ukbrd1D6Cs+bJ4KZWuTMBmzg2Wx+c9W98khx+AByTZ6h4VJylbwedw==
X-Received: from neelnatu0.svl.corp.google.com ([2620:15c:2cd:202:52da:b54:3437:6f63])
 (user=neelnatu job=sendgmr) by 2002:a25:c9c4:0:b0:66f:e085:7ef2 with SMTP id
 z187-20020a25c9c4000000b0066fe0857ef2mr18101965ybf.166.1659476467926; Tue, 02
 Aug 2022 14:41:07 -0700 (PDT)
Date:   Tue,  2 Aug 2022 14:40:41 -0700
Message-Id: <20220802214041.2656586-1-neelnatu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH] sched, cpumask: don't leak impossible cpus via for_each_cpu_wrap().
From:   Neel Natu <neelnatu@google.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     Neel Natu <neelnatu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value of 'nr_cpumask_bits' is dependent on CONFIG_CPUMASK_OFFSTACK.
This in turn can change the set of cpus visited by for_each_cpu_wrap()
with a mask that has bits set in the range [nr_cpu_ids, NR_CPUS).

Specifically on !CONFIG_CPUMASK_OFFSTACK kernels the API can iterate
over cpus outside the 'cpu_possible_mask'.

Fix this to make its behavior match for_each_cpu() which always limits
the iteration to the range [0, nr_cpu_ids).

Signed-off-by: Neel Natu <neelnatu@google.com>
---
 include/linux/cpumask.h | 2 +-
 lib/cpumask.c           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index fe29ac7cc469..2a308cfc43da 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -303,7 +303,7 @@ extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool
  */
 #define for_each_cpu_wrap(cpu, mask, start)					\
 	for ((cpu) = cpumask_next_wrap((start)-1, (mask), (start), false);	\
-	     (cpu) < nr_cpumask_bits;						\
+	     (cpu) < nr_cpu_ids;						\
 	     (cpu) = cpumask_next_wrap((cpu), (mask), (start), true))
 
 /**
diff --git a/lib/cpumask.c b/lib/cpumask.c
index a971a82d2f43..d47937fb49eb 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -82,9 +82,9 @@ int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
 	next = cpumask_next(n, mask);
 
 	if (wrap && n < start && next >= start) {
-		return nr_cpumask_bits;
+		return nr_cpu_ids;
 
-	} else if (next >= nr_cpumask_bits) {
+	} else if (next >= nr_cpu_ids) {
 		wrap = true;
 		n = -1;
 		goto again;
-- 
2.37.1.455.g008518b4e5-goog

