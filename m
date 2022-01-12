Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCC948CA64
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 18:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344270AbiALRuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 12:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344044AbiALRuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 12:50:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F80C06173F;
        Wed, 12 Jan 2022 09:50:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A2FCB82025;
        Wed, 12 Jan 2022 17:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978DAC36AEA;
        Wed, 12 Jan 2022 17:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642009803;
        bh=Z0Rl1UoN9N17xgQ6MEb+B6+A/2Qrjg74rAJxXxT4OT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P0XleWHkyMR/4cxnd/lE5N9yckMOtMzpOYqJLwTwS5ZecdNl1fYAanfjJIAP9frdI
         KmZznXmtAvdBXPmvXfHu2S7U6RhvYnbrNAnWhDXBAcx32N+S5oY48TR3ateaHQ3p6E
         H7UJ++2s/fAL+HpTOr83A3y8tQLxjTG4TjRHbjHgPyZwuIsQP1JaFZbEBcD6VKz44z
         4RSXRUWPJZiY/qW6/+OfZNtGHi7/t7Pg757R+sHvLuU5sdMVqFfsI3Iqr/zRrmkjk/
         5tuhyKhB3aDx2s9pFxnqUJpqv9BStl2tquE+FqWTlMC4AMx1NhERdcOJxbShP7jA8q
         sVfkYinUCXqhQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DDADB40714; Wed, 12 Jan 2022 14:50:01 -0300 (-03)
Date:   Wed, 12 Jan 2022 14:50:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [RFC PATCH] perf pmu-events: Don't lower case MetricExpr
Message-ID: <Yd8UySEClsWdzKF5@kernel.org>
References: <20211126071305.3733878-1-irogers@google.com>
 <CAP-5=fU2kEq3T8UCpX0tAmwcGhZ+1h92uRPbzyuLDNpeCD7ffQ@mail.gmail.com>
 <Yd8To1ASO73135LK@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yd8To1ASO73135LK@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 12, 2022 at 02:45:07PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Jan 12, 2022 at 09:22:51AM -0800, Ian Rogers escreveu:
> > On Thu, Nov 25, 2021 at 11:13 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > This patch changes MetricExpr to be written out in the same case. This
> > > enables events in metrics to use modifiers like 'G' which currently
> > > yield parse errors when made lower case. To keep tests passing the
> > > literal #smt_on is compared in a non-case sensitive way - #SMT_on is
> > > present in at least SkylakeX metrics.
> > 
> > Ping.
> 
> I tried applying 20211124001231.3277836-1-irogers@google.com on top of
> your perf_cpu series, it failed, will check.
> 
> BTW, I got the two other patches in that series:
> 
> ⬢[acme@toolbox perf]$ git log --oneline -2
> 6dd8646939a770e4 (HEAD -> perf/core) perf tools: Probe non-deprecated sysfs path 1st
> 0ce05781f4905fcf perf tools: Fix SMT fallback with large core counts
> ⬢[acme@toolbox perf]$

It was due to that cpu__max_present_cpu().cpu;

Fixed, applied.

- Arnaldo

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index e808738493e219fd..c94fb9bef919f5cb 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -405,12 +405,17 @@ double expr_id_data__source_count(const struct expr_id_data *data)
 double expr__get_literal(const char *literal)
 {
 	static struct cpu_topology *topology;
+	double result = NAN;
 
-	if (!strcmp("#smt_on", literal))
-		return smt_on() > 0 ? 1.0 : 0.0;
+	if (!strcmp("#smt_on", literal)) {
+		result = smt_on() > 0 ? 1.0 : 0.0;
+		goto out;
+	}
 
-	if (!strcmp("#num_cpus", literal))
-		return cpu__max_present_cpu().cpu;
+	if (!strcmp("#num_cpus", literal)) {
+		result = cpu__max_present_cpu().cpu;
+		goto out;
+	}
 
 	/*
 	 * Assume that topology strings are consistent, such as CPUs "0-1"
@@ -422,16 +427,24 @@ double expr__get_literal(const char *literal)
 		topology = cpu_topology__new();
 		if (!topology) {
 			pr_err("Error creating CPU topology");
-			return NAN;
+			goto out;
 		}
 	}
-	if (!strcmp("#num_packages", literal))
-		return topology->package_cpus_lists;
-	if (!strcmp("#num_dies", literal))
-		return topology->die_cpus_lists;
-	if (!strcmp("#num_cores", literal))
-		return topology->core_cpus_lists;
+	if (!strcmp("#num_packages", literal)) {
+		result = topology->package_cpus_lists;
+		goto out;
+	}
+	if (!strcmp("#num_dies", literal)) {
+		result = topology->die_cpus_lists;
+		goto out;
+	}
+	if (!strcmp("#num_cores", literal)) {
+		result = topology->core_cpus_lists;
+		goto out;
+	}
 
 	pr_err("Unrecognized literal '%s'", literal);
-	return NAN;
+out:
+	pr_debug2("literal: %s = %f\n", literal, result);
+	return result;
 }
