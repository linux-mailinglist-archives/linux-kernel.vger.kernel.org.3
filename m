Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC2D470C33
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344335AbhLJVHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344319AbhLJVGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:06:49 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B35EC061B38
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:03:14 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l75-20020a25254e000000b005f763be2fecso18544209ybl.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nnsoF7alfMG2u6vExP/NPeuAkXbCgeva9LYGVb65vF8=;
        b=Ljuu7rH/x/W8WUSANm780H78gKevks1iPiLysgF1ufTxpTHJ/1eq0yzKkAu8S1hZ2V
         q/nJiGR5OvsdXEYF0Y3C1R/vUhDR/B8yNQfKhKvtu8pn4HY4ICFUNCGlTXeW8pVGeSkP
         67ITJWIERLHLVJahcWDFlEInIVLOc/M5hKgYrvuG1Wnm7qJu60hAeCrPYz4Rjt+vXXl9
         sAeDrOmyvFzIgtP+uk/484dHs7CR1qjRBzwqztTXbOE772nVQLeR0VARJfid8W7Z1ih/
         fzA6muyQBePQS4Q3AAPbzijvqOgxRPdCoE9JKRaT0DHgvBIjfkHmRS+htSoNnVao8Q1V
         GkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nnsoF7alfMG2u6vExP/NPeuAkXbCgeva9LYGVb65vF8=;
        b=Pr/8ZBWB8OVILU++7RtWNLp70Piuzr4D0L66BCLf3ABLgPN3BnGaAYW3/HR6LsOETR
         /J1onirPqrc2Cfs7dn71EiPtw69uIytkEnsuewi8yM4MRb+F+78UsOtovI0Hyps+BKEb
         6r9lbwQAJcZX/uf2sWF759AwxKjuKRacRF8aCOi9HrWKGAJrLX31HWoNxcix3SoXMqXk
         rdJkc3dU6lCZp8loVtXnV7K5xJzpVXOoYZ4fA6yLofEoNC30KG3LcpCoTdvoU3NX0QPn
         MIyYPW0/gFAJAzP51uejaQlCAmJr4SrXyzlU+EjHpw+KkEW+5PcQ3KQN0sHwDcyFz9NE
         jL8A==
X-Gm-Message-State: AOAM530krQ1aKqUr6fb5kokn7TKP7DuvE9uwG2rKm7eIw5vH8D3jP8HX
        VtI0fZHf3WI5SFyz9zuDYSWrykT7vP/B+FUUFnfOJN0B89aSTbSpeBKfnMXI/Mic227YZ+b7jrQ
        IC3jT9xnbkcjQo6O+F+mMVAqCPczeWUuzVSPpBeroIvraT63ns7nY7Xd2SnGhmbwUvWAzhiwB
X-Google-Smtp-Source: ABdhPJx37hWJP5mFiveLWf4+r03EkrS26MrE1hXIa/jvWFg/IOd52HIW7NMJgHytg1BypGiU5tMGlmvgh5Gv
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:7416:17a6:6678:d4d5])
 (user=eranian job=sendgmr) by 2002:a25:850f:: with SMTP id
 w15mr17353435ybk.553.1639170193314; Fri, 10 Dec 2021 13:03:13 -0800 (PST)
Date:   Fri, 10 Dec 2021 13:02:26 -0800
In-Reply-To: <20211210210229.2991238-1-eranian@google.com>
Message-Id: <20211210210229.2991238-12-eranian@google.com>
Mime-Version: 1.0
References: <20211210210229.2991238-1-eranian@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 11/14] perf evsel: Make evsel__env always return a valid env
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@amd.com>

It's possible to have an evsel and evsel->evlist populated without
an evsel->evlist->env, when, e.g., cmd_record is in its error path.

Future patches will add support for evsel__open_strerror to be able
to customize error messaging based on perf_env__{arch,cpuid}, so
let's have evsel__env return &perf_env instead of NULL in that case.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
 tools/perf/util/evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ac0127be0459..bb122979ef2c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2966,7 +2966,7 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 
 struct perf_env *evsel__env(struct evsel *evsel)
 {
-	if (evsel && evsel->evlist)
+	if (evsel && evsel->evlist && evsel->evlist->env)
 		return evsel->evlist->env;
 	return &perf_env;
 }
-- 
2.34.1.173.g76aa8bc2d0-goog

