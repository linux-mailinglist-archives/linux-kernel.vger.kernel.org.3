Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73E6544364
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbiFIF5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiFIF47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:56:59 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D3425294;
        Wed,  8 Jun 2022 22:56:58 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e66so20892353pgc.8;
        Wed, 08 Jun 2022 22:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t48NqpUqoX4+gRVwc3DRxSnbCSJD7GJFMSilwwZgUm0=;
        b=WQhGB9ZxhV5t0rqaftv19+LNiY9Y5xKvfh5magNXEKUBPWNTbILVWGSOBOPfqAZlNw
         58GPqT2ZiYR/3OZqzD2bcibKhtlMe/uhEJv64qXKGmKApRvbeIWjYgd+rXYYUGD5bvo1
         Wkh7FP/XjOoEC/f/qB4+bYM7CH8uBJFbSi4IV9Adl8jWMRYMivp0rvr0CSfM2OiXKzwU
         DBRJSceXAxSII12KVvc6effc6KtGGptAbrRviLKam5AeROScTVfLlYLnhYezyroGV+S2
         07nLlZkCi9oCBnYKUuJPPXIwSNBWLLAAYP3cP8ga13+EHLowFZwL30FzlOX8O+vNHe2a
         6QjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=t48NqpUqoX4+gRVwc3DRxSnbCSJD7GJFMSilwwZgUm0=;
        b=TJFO5cWabFU1knAEZ79Czecy2D7DewFzoapyT7F1lt0/W7oRHD4KYrEsA+YjCpiIBo
         mXN8Ajq0nWIGjmGPoT4RdxdS+e/wpL812W06mHUxZHUCTOKZnGvTbR9dSl81BRoh/ir1
         ZHHTaO945Bu0B3RDIMukjADJHFigWGsGc3o2ncZfBvLC4oIDa4mGyL+EFzZPFQamuhBf
         yssy1vHz9moHjk5HeRGRwNvcyazjKv+xfzcHdEKf64ukAPaVuIjvJMP8hpl0rD/WmoEL
         E8+hrxzPwr9CDBxRU3IxQy0oCYLg5flC6CClJFBBP0SwD3pHGd78kWJsymxBED3fmC5a
         aaTg==
X-Gm-Message-State: AOAM530j4x6beG0EWL8DW2JlMeWSK6hqz8JJpvIv9fWLTD07jb2J5bZd
        1acRRyTGaURAAf52qbbiTvhHxGncLt2YFA==
X-Google-Smtp-Source: ABdhPJzXvP2CcXNegnXk5ORsR37Jima8zVuRU34SrrY7ZQB+amBeuEZwzjnolsU9wG0PduGjRZ747w==
X-Received: by 2002:a05:6a00:24cc:b0:50d:58bf:5104 with SMTP id d12-20020a056a0024cc00b0050d58bf5104mr38607423pfv.36.1654754217725;
        Wed, 08 Jun 2022 22:56:57 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:cb0:2c32:ceaf:ea06:c5de])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b0016196bcf743sm9502413plk.275.2022.06.08.22.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 22:56:57 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 3/7] perf lock: Skip print_bad_events() if nothing bad
Date:   Wed,  8 Jun 2022 22:56:48 -0700
Message-Id: <20220609055652.938821-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220609055652.938821-1-namhyung@kernel.org>
References: <20220609055652.938821-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debug output is meaningful when there are bad lock sequences.
Skip it unless there's one or -v option is given.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 118a036a81fb..2337b09dd2cd 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -858,9 +858,16 @@ static void print_bad_events(int bad, int total)
 {
 	/* Output for debug, this have to be removed */
 	int i;
+	int broken = 0;
 	const char *name[4] =
 		{ "acquire", "acquired", "contended", "release" };
 
+	for (i = 0; i < BROKEN_MAX; i++)
+		broken += bad_hist[i];
+
+	if (broken == 0 && !verbose)
+		return;
+
 	pr_info("\n=== output for debug===\n\n");
 	pr_info("bad: %d, total: %d\n", bad, total);
 	pr_info("bad rate: %.2f %%\n", (double)bad / (double)total * 100);
-- 
2.36.1.255.ge46751e96f-goog

