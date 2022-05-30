Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DEF537709
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 10:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbiE3InE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiE3InC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:43:02 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E7B10FF8
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:43:01 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id f4so9560495pgf.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AcThocPJ0wzgCNB1hRmWCzKxPwFlNqlVWFyeNmHGLfE=;
        b=d3hfd5WFTV84IZ4yVXDIWkKdL2q9b1/279g6UCuN282BOKYmeawhyuFt/oZ05yo4D6
         NXBKb3hzM4d31LexOS8I7YIPE703jds2zcWxF6gstg0XWjjKa1bjwjcmAKLgk1/RP4Ll
         XFfk9taAkm+qsnKcufKotYWra3bqXU6VjkfSNKlQkNnQhx4cJs63GNLuoCSOhkghJVbE
         gh+DQm3amiLIKXUU8LMcEL+nFiQotQ3KvheVGHbfu6M7ncXdT9luJEG6DSJHnupOQtiv
         fYtUD1ElqjOz5fhnWiARMgp3I9zbyfSinQ9PcToO2z2XWueWSAXBFtbdCZw5ijXS5XM5
         tPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AcThocPJ0wzgCNB1hRmWCzKxPwFlNqlVWFyeNmHGLfE=;
        b=D3DOUt44PCFkG/g4s6FYvYoxnugDQTVJ9EH9hhkfgx89QkkN15afH43s2pI5R8yZKj
         GICBZpXkmGVEjHeVWkP0RNy4LzwKKp29DrESwkJrN3xDYjxhtvYVFMuIoMBLVF+q3tcg
         YeAkiicmr9wDG929tzKBdNeg5bapPaKflh5eW990srWpkpDd+wvIwkv9NdmFvSW2mm5e
         8JVwWuPDUy7onFDWGmW3nCGkaj8rU0v0D0DXocudAosagX1t9/PT3WvAU3JDWXjMAc+R
         rCXLR4/I6NEIS/c5nUrOr3sp57xrOd0xQ3XMT7YPaoTLbCQ3xOTFVf1zJfYSWmI6Dn5m
         9Tww==
X-Gm-Message-State: AOAM532RnO6lG6BujU4IICOIc0FE9I2M2y2J00Ja3d1U+Nukh7rbCJ5q
        cmgHWJHV4tHELpLFBVTmxqD50w==
X-Google-Smtp-Source: ABdhPJxxoORpS89tmPsGbAvPtcdHdNix7f7tRDqClS80bppvL2ZAh/01+CsvMFzMblRtki8rBOUPYA==
X-Received: by 2002:a65:5c0c:0:b0:3fa:b2c0:7935 with SMTP id u12-20020a655c0c000000b003fab2c07935mr25861870pgr.600.1653900180714;
        Mon, 30 May 2022 01:43:00 -0700 (PDT)
Received: from leo-build-box.lan ([46.249.98.195])
        by smtp.gmail.com with ESMTPSA id m11-20020a170902bb8b00b0015e8d4eb24fsm8462834pls.153.2022.05.30.01.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 01:43:00 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Joe Mario <jmario@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf c2c: Fix sorting in percent_rmt_hitm_cmp()
Date:   Mon, 30 May 2022 16:42:53 +0800
Message-Id: <20220530084253.750190-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function percent_rmt_hitm_cmp() wrongly uses local HITMs for
sorting remote HITMs.

Since this function is to sort cache lines for remote HITMs, this patch
changes to use 'rmt_hitm' field for correct sorting.

Fixes: 9cb3500afc09 ("perf c2c report: Add hitm/store percent related sort keys")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index c8230c48125f..e8280973d7b8 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -928,8 +928,8 @@ percent_rmt_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	double per_left;
 	double per_right;
 
-	per_left  = PERCENT(left, lcl_hitm);
-	per_right = PERCENT(right, lcl_hitm);
+	per_left  = PERCENT(left, rmt_hitm);
+	per_right = PERCENT(right, rmt_hitm);
 
 	return per_left - per_right;
 }
-- 
2.25.1

