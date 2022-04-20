Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698D75085D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349581AbiDTK1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbiDTK1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:27:16 -0400
Received: from euporie.uberspace.de (euporie.uberspace.de [185.26.156.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C693F329
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:24:29 -0700 (PDT)
Received: (qmail 15605 invoked by uid 989); 20 Apr 2022 10:24:26 -0000
Authentication-Results: euporie.uberspace.de;
        auth=pass (plain)
From:   Florian Fischer <florian.fischer@muhq.space>
To:     linux-perf-users@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCHSET v4 next 0/3] perf stat: add user_time and system_time tool events
Date:   Wed, 20 Apr 2022 12:23:51 +0200
Message-Id: <20220420102354.468173-1-florian.fischer@muhq.space>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: +
X-Rspamd-Report: R_MISSING_CHARSET(0.5) MIME_GOOD(-0.1) MID_CONTAINS_FROM(1) BAYES_HAM(-0.151335)
X-Rspamd-Score: 1.248664
Received: from unknown (HELO unkown) (::1)
        by euporie.uberspace.de (Haraka/2.8.28) with ESMTPSA; Wed, 20 Apr 2022 12:24:26 +0200
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds new internal events to perf stat exposing the times spend
in user and kernel mode in nanoseconds reported by rusage.

During some benchmarking using perf it bothered me that I could not easily
retrieve those times from perf stat when using the machine readable output.

But perf definitely knows about those values because in the human readable output
they are present.

Therefore I exposed the times reported by rusage via the new tool events:
user_time and system_time.

This allows to retrieved them in machine-readable output:

$ ./perf stat -x, -e duration_time,user_time,system_time,cache-misses -- grep -q -r duration_time tools/perf
72134524,ns,duration_time:u,72134524,100.00,,
65225000,ns,user_time:u,65225000,100.00,,
6865000,ns,ssystem_time:u,6865000,100.00,,
38705,,cache-misses:u,71189328,100.00,,

The changes are mostly inspired by the code for the only other available
tool event: 'duration_time'.

For now the new user_time and system_time events are not usable with metrics
(as far as I understand).

The patch applies cleanly on linux-next/next-20220420.

[PATCH v4 1/3] perf stat: introduce stats for the user and system
[PATCH v4 2/3] perf stat: add user_time and system_time events
[PATCH v4 3/3] perf list: print all available tool events

[v2]: Split up the changes into separate commits.

[v3]: * Use nanoseconds as suggested by Xing Zhengjun.
      * Squash [PATCH v2 2/4] and [PATCH v2 4/4], because it only adds the unit string.

[v4]: * Simplify event names to only user_time and system_time as suggested by Ian Rogers.

Florian Fischer

