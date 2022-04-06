Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E86E4F5CFD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiDFL7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiDFL6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:58:19 -0400
Received: from euporie.uberspace.de (euporie.uberspace.de [185.26.156.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FA43BE61A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 00:29:05 -0700 (PDT)
Received: (qmail 8173 invoked by uid 989); 6 Apr 2022 07:29:03 -0000
Authentication-Results: euporie.uberspace.de;
        auth=pass (plain)
From:   Florian Fischer <florian.fischer@muhq.space>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Florian Schmaus <flow@cs.fau.de>
Subject: [RFC v2] perf stat: add rusage utime and stime events
Date:   Wed,  6 Apr 2022 09:28:35 +0200
Message-Id: <20220406072839.107519-1-florian.fischer@muhq.space>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <YkybjsCKyWkDZGX+@kernel.org>
References: <YkybjsCKyWkDZGX+@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: +
X-Rspamd-Report: R_MISSING_CHARSET(0.5) MIME_GOOD(-0.1) MID_CONTAINS_FROM(1) BAYES_HAM(-0.054225)
X-Rspamd-Score: 1.345774
Received: from unknown (HELO unkown) (::1)
        by euporie.uberspace.de (Haraka/2.8.28) with ESMTPSA; Wed, 06 Apr 2022 09:29:03 +0200
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,FROM_SUSPICIOUS_NTLD,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds new internal events to perf stat exposing the utime and
stime reported by rusage.

During some benchmarking using perf it bothered me that I could not easily
retrieve the times spent in user or kernel mode from perf stat when using the
machine readable output.

But perf definitely knows about those values because in the human readable output
they are present.

Therefore I exposed the times reported by rusage via the new tool events:
rusage_user_time, rusage_system_time and their aliases ru_utime and ru_stime.

This allows to retrieved them in machine-readable output:

$ ./perf stat -x, -e duration_time,ru_utime,ru_stime,cache-misses -- grep -q -r duration_time tools/perf
72134524,ns,duration_time:u,72134524,100.00,,
65225,us,ru_utime:u,65225,100.00,,
6865,us,ru_stime:u,6865,100.00,,
38705,,cache-misses:u,71189328,100.00,,

The changes are mostly inspired by the code for the only other available
tool event: 'duration_time'.

For now rusage_* events are not usable with metrics (as far as I understand).

The patch applies cleanly on linux-next/next-20220405.

[PATCH v2 1/4] perf stat: introduce stats for the user and system
[PATCH v2 2/4] perf stat: add rusage utime and stime events
[PATCH v2 3/4] perf list: print all available tool events
[PATCH v2 4/4] perf util: add 'us' unit to the rusage time events

[v2]: Split up the changes into separate commits.

Florian Fischer

