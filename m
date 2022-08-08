Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D42858CD51
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244139AbiHHSFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244249AbiHHSFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:05:43 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B96718E10
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 11:05:37 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f28so8773378pfk.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 11:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=fAExR7rEhAmsHTdQ6bGQP8L31D4AzKuxXqzcq+va14U=;
        b=a9xsX+5Q4q3PyZyQPqL00FqOVZVkSlBc+tQwRqFCH3Gc3Tf9NZD3GQ/c1wmwaNtaTP
         32MuVlRhlccQJdUYtmEy0piMSJRtGa5IAWeXEf9s+0bbRReUIu9dp1QzqoSm4m8MgaNe
         gC0qmPifKpGme3yZjajhg3WLC6SBnl2CmIgJwQNWPXuT1KEJplGTEi93uamYLxZg5oAR
         1NMnrdVACvo6Z+xX6VJbebAZhjwF3BkssTANgpqqwOYhxXFwCfxnqCQw2uugZ8yP0wrA
         LfqEc+V7mCXla9OE/5IVqW12BwDoW4p9xkcrpIhmomCCq8ZYBKcDE/SoocrvR5qE1G6z
         rMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=fAExR7rEhAmsHTdQ6bGQP8L31D4AzKuxXqzcq+va14U=;
        b=PB+zuX29krbsO3ScdynPwnqOiao9HazaIYQvkbPklEdDBmss39hRC4v1fyD4ZRmjBn
         /Cuj0lAKJ9LdUDqMByEQpAJwPR3vUkd3+lgL/mwGdcN9ebbCoFHoGN2kRfrS32VGs0ht
         YyKM8ej8bbdvRncMRpkQHfhsV7Z0KjAYRD17jbcyDRpYKDcm8Iss78ZLIlGSDK5myTmI
         XGy23ka433gTN5ZaoL1AXYjpX9IyuzyHAj4GkvkdnOIm/ZSiasm68wSHrdsM2QdrbC4j
         ca2oLEcBxc3huxGA1ths/bfQyj+EKvsqT76Zpi6+xlRv2mkRYBUyZI/SqHHoYoiqSiHO
         sFAg==
X-Gm-Message-State: ACgBeo0PtzmN3SjmReSLfyRtcZ68bzfKUoLXeAM2xVPdTRlLg+gAa3/V
        rI/hUtxrzbap3xsBo26HV4ps7htFjSU=
X-Google-Smtp-Source: AA6agR5bxVtozjJhu1pCmJIZo+8zLNcsWwnjzOGazK4mArolzDC5jXzxVIyznsh+/9jabQ1WBH+x6Q==
X-Received: by 2002:a65:6bd6:0:b0:39d:4f85:9ecf with SMTP id e22-20020a656bd6000000b0039d4f859ecfmr16815735pgw.336.1659981936348;
        Mon, 08 Aug 2022 11:05:36 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:4d4b:1a9e:22cf:3f7e])
        by smtp.gmail.com with ESMTPSA id a4-20020a62d404000000b0052553215444sm8999156pfh.101.2022.08.08.11.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 11:05:36 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        James Morris <jmorris@namei.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH RESEND] perf/core: Call LSM hook after copying perf_event_attr
Date:   Mon,  8 Aug 2022 11:05:34 -0700
Message-Id: <20220808180534.594471-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
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

It passes the attr struct to the security_perf_event_open() but it's
not initialized yet.

Fixes: da97e18458fb ("perf_event: Add support for LSM and SELinux checks")
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4d8c335a07db..6bf4e3078b29 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12047,12 +12047,12 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (flags & ~PERF_FLAG_ALL)
 		return -EINVAL;
 
-	/* Do we allow access to perf_event_open(2) ? */
-	err = security_perf_event_open(&attr, PERF_SECURITY_OPEN);
+	err = perf_copy_attr(attr_uptr, &attr);
 	if (err)
 		return err;
 
-	err = perf_copy_attr(attr_uptr, &attr);
+	/* Do we allow access to perf_event_open(2) ? */
+	err = security_perf_event_open(&attr, PERF_SECURITY_OPEN);
 	if (err)
 		return err;
 
-- 
2.37.1.559.g78731f0fdb-goog

