Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E254F7A9E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243465AbiDGJAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbiDGJAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:00:25 -0400
Received: from euporie.uberspace.de (euporie.uberspace.de [185.26.156.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487E862101
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 01:58:20 -0700 (PDT)
Received: (qmail 17833 invoked by uid 989); 7 Apr 2022 08:58:18 -0000
Authentication-Results: euporie.uberspace.de;
        auth=pass (plain)
From:   Florian Fischer <florian.fischer@muhq.space>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Florian Schmaus <flow@cs.fau.de>
Subject: [RFC v3] perf stat: add rusage utime and stime events
Date:   Thu,  7 Apr 2022 10:57:18 +0200
Message-Id: <20220407085721.3289414-1-florian.fischer@muhq.space>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <69656438-8b9a-000b-0702-02dc480639f9@linux.intel.com>
References: <69656438-8b9a-000b-0702-02dc480639f9@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: +
X-Rspamd-Report: R_MISSING_CHARSET(0.5) MIME_GOOD(-0.1) MID_CONTAINS_FROM(1) BAYES_HAM(-0.001856)
X-Rspamd-Score: 1.398143
Received: from unknown (HELO unkown) (::1)
        by euporie.uberspace.de (Haraka/2.8.28) with ESMTPSA; Thu, 07 Apr 2022 10:58:18 +0200
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,FROM_SUSPICIOUS_NTLD,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds new internal events to perf stat exposing the utime and
stime in nanoseconds reported by rusage.

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
65225000,ns,ru_utime:u,65225000,100.00,,
6865000,ns,ru_stime:u,6865000,100.00,,
38705,,cache-misses:u,71189328,100.00,,

The changes are mostly inspired by the code for the only other available
tool event: 'duration_time'.

For now rusage_* events are not usable with metrics (as far as I understand).

The patch applies cleanly on linux-next/next-20220405.

[PATCH v3 1/3] perf stat: introduce stats for the user and system
[PATCH v3 2/3] perf stat: add rusage utime and stime events
[PATCH v3 3/3] perf list: print all available tool events

[v2]: Split up the changes into separate commits.

[v3]: * Use nanoseconds as suggested by Xing Zhengjun.
      * Squash [PATCH v2 2/4] and [PATCH v2 4/4], because it only adds the unit string 

Florian Fischer

