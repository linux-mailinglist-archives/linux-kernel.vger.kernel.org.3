Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CBA49D63A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbiAZXf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiAZXfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:35:39 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A93C06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:35:39 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id o131-20020a25d789000000b00614957c60dfso2410180ybg.15
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Qn0TA2rLT3xEjgoLHjAhHg096GrQrElpfNL3slBq/y0=;
        b=joLRWl9ALf3/u2Y3t2KAim2usx1sexp4BmoDVJJqKc3aOx3fI8GsZAkG/8k4fPATAy
         p5LBjC/XnKu1av7uHyWQnTusMLaeChk6F8VreKG9PzfKaPDnqiREDmlHyGZOczeKQBFK
         aCw1mztAXphF5sWdtvr9bymxnTHP/OVZBtgvY+cJBfaaPrRhEy89w19ygg4+qQCiFFId
         Q5Zp07ATjKESPW2OMMRYircZaxQuO17AdeLe9p+irvOTHbRMZA68xHw1A3/3hoMKvbCm
         PdkGSWND51fPAJNOdT6tbExeNRt6vAq94DOqlWZTVNadXIwngINR5L796Z4bsHzqMAyM
         BtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Qn0TA2rLT3xEjgoLHjAhHg096GrQrElpfNL3slBq/y0=;
        b=tki+wKcyLXGFG8cvglJawvINU3i7P2tExvysP/zLQIJQDKu3kMaUNmCsUgtgpu+oCh
         NFSb+bZPAIsg4B4DiSLwgljej4XmhOz583V/Rw4ia3PGKttqDcuZCPjwgMkxLiBQc6W4
         TB3UNQUPsllolpuk5GX7S6X0LgvciK/pXRQFIaVXsIXaFqsVIOhv0p93yeKKiLPefBOW
         rHPet9oUUXw+uo7UnaUVLHz63ufWTkQDPKnSiQar0NY4HtgU48aMBuW1jt9ogYoF0I3S
         JUVCtjx+FZ+R38PK8v6MbwEmrDfJOdixf1ps3E66RJN2iJgiXqh+V/6NV0/FjAtau28H
         +XmA==
X-Gm-Message-State: AOAM530vy0myiy6hjPLGB8h49anIS3iv1iB7G1Hi6wwDq1QIbUneaCgT
        FqJVUv7RVaAAgnAfHZF6SSvdwRtjSb+HEeH04v4OQ3BVhhQBVcFJvad9eRHoIUaJb27N+VyiFSz
        wsZIhxDOqtqDOaQvliGte25jGty48+7EMIlA3UBQHJvB3WMurZ1M4SVJgCglYX8NohfYk9Dko
X-Google-Smtp-Source: ABdhPJzvg8YibuvbNVAx95fvM0CnTRMhd8z0j204waNxx1b0plGtLJIyrBp7Z1EVMw0rAYPJSD5GsDu6nhnT
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:9ce0:6f20:c145:eac])
 (user=eranian job=sendgmr) by 2002:a25:3b90:: with SMTP id
 i138mr1962069yba.208.1643240138793; Wed, 26 Jan 2022 15:35:38 -0800 (PST)
Date:   Wed, 26 Jan 2022 15:34:51 -0800
In-Reply-To: <20220126233454.3362047-1-eranian@google.com>
Message-Id: <20220126233454.3362047-11-eranian@google.com>
Mime-Version: 1.0
References: <20220126233454.3362047-1-eranian@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v5 10/13] perf evsel: Make evsel__env always return a valid env
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com
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
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Richter <robert.richter@amd.com>
Cc: Stephane Eranian <eranian@google.com>
---
 tools/perf/util/evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 22d3267ce294..14b0e7ffa2c7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2965,7 +2965,7 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 
 struct perf_env *evsel__env(struct evsel *evsel)
 {
-	if (evsel && evsel->evlist)
+	if (evsel && evsel->evlist && evsel->evlist->env)
 		return evsel->evlist->env;
 	return &perf_env;
 }
-- 
2.35.0.rc0.227.g00780c9af4-goog

