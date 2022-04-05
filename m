Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C064F4F6E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838082AbiDFAuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573050AbiDERt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:49:29 -0400
X-Greylist: delayed 401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Apr 2022 10:47:27 PDT
Received: from euporie.uberspace.de (euporie.uberspace.de [185.26.156.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A435AD1114
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:47:26 -0700 (PDT)
Received: (qmail 18699 invoked by uid 989); 5 Apr 2022 17:40:44 -0000
Authentication-Results: euporie.uberspace.de;
        auth=pass (plain)
From:   Florian Fischer <florian.fischer@muhq.space>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Florian Schmaus <flow@cs.fau.de>
Subject: [RFC] perf stat: add rusage utime and stime events
Date:   Tue,  5 Apr 2022 19:40:27 +0200
Message-Id: <20220405174028.1675025-1-florian.fischer@muhq.space>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: +
X-Rspamd-Report: R_MISSING_CHARSET(0.5) MIME_GOOD(-0.1) MID_CONTAINS_FROM(1) BAYES_HAM(-0.066982)
X-Rspamd-Score: 1.333017
Received: from unknown (HELO unkown) (::1)
        by euporie.uberspace.de (Haraka/2.8.28) with ESMTPSA; Tue, 05 Apr 2022 19:40:44 +0200
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hallo everyone,

this is my first time sending out patches to the linux kernel repo so I am not
really confident in doing the correct thing.

This patch adds new internal events to perf stat exposing the ru_utime and
ru_stime reported by rusage.

During some benchmarking using perf it bothered me that I could not easily
retrieve the times spent in user or kernel mode from perf stat when using the
machine readable output.

But perf definitely knows about those values because in the human readable output
they are present.

Therefore I exposed the times reported by rusage via the new tool events:
rusage_user_time and rusage_system_time.

tools/perf/builtin-stat.c      | 41 ++++++++++++++++++++++++++++++++---------
tools/perf/util/evsel.c        | 19 ++++++++++++-------
tools/perf/util/evsel.h        |  4 ++++
tools/perf/util/parse-events.c | 44 ++++++++++++++++++++++++++++++++++++++------
tools/perf/util/parse-events.l |  2 ++
tools/perf/util/stat-shadow.c  |  2 ++
tools/perf/util/stat.h         | 19 +++++++++++++++++++
7 files changed, 109 insertions(+), 22 deletions(-)

The changes are mostly inspired by the code for the only other available tool
event 'duration_time'.

For now rusage_* events are not usable with metrics (as far as I understand).

The patch applies cleanly on linux-next/next-20220405.

And I send this emails to anyone mentioned in the MAINTAINERS file.
Sorry for the possible unnecessary email spam :)

Florian Fischer

