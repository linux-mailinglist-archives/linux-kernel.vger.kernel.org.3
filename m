Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D7F5917B6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 02:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbiHMACX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 20:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMACT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 20:02:19 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D4181B05
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 17:02:18 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 427C71224A7
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 00:02:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a304.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id E99E2122480
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 00:02:17 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1660348937; a=rsa-sha256;
        cv=none;
        b=1i7IqP1k4zF6oI1CW+pVHnVWsy787OpgUsC2xbK3RMzjoGtJ+Mbx8de+ihRnHL4bxVtFHD
        WtA5CZH0HuA/dOkNaNpNy+efMnoiG/YV6Vki89KwTbwj9SK0Nmsm39aPUql1oe/183ku/A
        k+kmYvx0lMWUAH8UJHSvA13cgWGHLSL61tv2Iu9KgIaMIM0Oqwjt2DJb/crcibx0+fXlaL
        DYVjP8xLhC1W7VSFsuSrPBFnJCNdAsZTHJqwOZFiaRlSFYj1CvnrneqNESwLCQ7PCpHYSz
        FlWoL30Q83JaJKdPpzrq4aWRRvT9fGUU2tRt1aYnvKDBAqXRbc1qNwrHQ5txYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1660348937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         dkim-signature; bh=t7PHLocZtJQm6FbYeKDRE3xVRDsAPJYsny4BWAcKVsM=;
        b=CVihp91Av+PNhNBAGqEYRcACwmpM+06aT4mAZ9DXewM22iX8o8dwELiUYxnEW59Lg4oPiF
        PBojD7/5h0MhtzdFgrtvrg/6m3RzT5lvw0+qaAFvnppzCVQTcOJUCi3uTl0cJZjjx0ucm3
        iQyQ4rU+0xB/+CXx+K5JM5y3IJo6TkxQpCYUxBbgzEmrXsIiZho/YVTPR069OuCOHSfGss
        C5The2bFOoN+nihgTFqrbEveJQGEePCUVFh1w14ba4FsB1P6cpA/XPNNHa53PRFPoxEueH
        Xh0RxVJso66fpKENlKjGW1kTXKA5a20CWXaIhw+G3d8hff4t6JUwyaPj5qBWLw==
ARC-Authentication-Results: i=1;
        rspamd-7c478d8c66-n4qvx;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Cure-Language: 54b55b7d51d71edc_1660348938173_1093724364
X-MC-Loop-Signature: 1660348938173:116764907
X-MC-Ingress-Time: 1660348938173
Received: from pdx1-sub0-mail-a304.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.124.238.80 (trex/6.7.1);
        Sat, 13 Aug 2022 00:02:18 +0000
Received: from kmjvbox (unknown [98.42.138.125])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a304.dreamhost.com (Postfix) with ESMTPSA id 4M4LMF4BH9zTB
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 17:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1660348937;
        bh=t7PHLocZtJQm6FbYeKDRE3xVRDsAPJYsny4BWAcKVsM=;
        h=Date:From:To:Subject:Content-Type;
        b=Tq1Z0l1lAnC721HRSNH7BlZmiGyxXZmcmux301x86XAhdbQ1ENLxDb0dxYCiHxR1w
         H6zjguJE3jOyEbo+wMmYMCHlGzrpNrfZPZJO+cMadpKFZqDBcQoRIPvcOIUlbwPB57
         wOTDB5efa+3uvT0CJ4edkc/8jRb7mwuGRw9nurkQ=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e00ce
        by kmjvbox (DragonFly Mail Agent v0.12);
        Fri, 12 Aug 2022 17:02:15 -0700
Date:   Fri, 12 Aug 2022 17:02:15 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Reaver <me@davidreaver.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] tracing: warn in trace_event_dyn_put_ref
Message-ID: <cover.1660347763.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,
I have systems that are regularly hitting a WARN in trace_event_dyn_put_ref.

The exact message is:

WARNING: CPU: 1 PID: 30309 at kernel/trace/trace_dynevent.c:46 trace_event_dyn_put_ref+0x15/0x20

With the following stacktrace:

 perf_trace_init+0x8f/0xd0
 perf_tp_event_init+0x1f/0x40
 perf_try_init_event+0x4a/0x130
 perf_event_alloc+0x497/0xf40
 __do_sys_perf_event_open+0x1d4/0xf70
 __x64_sys_perf_event_open+0x20/0x30
 do_syscall_64+0x5c/0xc0
 entry_SYSCALL_64_after_hwframe+0x44/0xae

I've debugged this and think that it's caused by changes in 5.15 that
introduced a refcounter for dynamic events.

Specifically, perf_trace_init() manages the refcount for the events it
finds in the ftrace_events list.  However, perf_trace_event_init() ->
perf_trace_event_unreg() can decrement this count unexpectedly, if
perf_trace_event_open() encounters an error.

I'm able to reproduce reliably with the following shell script.  This is
from an Ubuntu 20.04 userland.  If the uprobes in the script don't line
up with exactly what's on your system, any should do.

--- >8 cut here 8< ---

#!/usr/bin/bash

# A simple-ish reproducer for trace_event_dyn_put_ref() WARN from
# perf_trace_init().  Triggering an -EINTR during uprobe attach is enough to
# land in the error case that does a double-decrement.

cleanup() {
        rm -f perf.data
        jobs -p | xargs -r kill -9 2>/dev/null
        perf probe -d '*'
        exit
}

setup() {
        perf probe -d '*' 2>/dev/null
        perf probe -x /proc/1/root/lib/x86_64-linux-gnu/libc.so.6 getaddrinfo
        perf probe -x /proc/1/root/lib/x86_64-linux-gnu/libc.so.6 getaddrinfo%return
        perf probe -x /proc/1/root/lib/x86_64-linux-gnu/libc.so.6 backtrace
        perf probe -x /proc/1/root/lib/x86_64-linux-gnu/libaudit.so.1 audit_log_acct_message
        perf probe -x /proc/1/root/lib/x86_64-linux-gnu/libaudit.so.1 audit_log_acct_message%return

}

setup

trap cleanup INT TERM

while true; do

  perf record -e 'task:task_newtask' \
    -e 'sched:sched_process_exit' \
    -e 'raw_syscalls:sys_enter' \
    -e 'raw_syscalls:sys_exit' \
    -e 'probe_libaudit:audit_log_acct_message' \
    -e 'probe_libaudit:audit_log_acct_message__return' \
    -e 'probe_libc:backtrace' \
    -e 'probe_libc:getaddrinfo' \
    -e 'probe_libc:getaddrinfo__return' \
    -a &
  sleep "0.$RANDOM"
  jobs -p | xargs -r kill -9
  rm -f perf.data

done

--- >8 cut here 8< ---

I'm sending along a patch that, when applied, does not warn when run
with the script above.  I've tested kprobes and uprobes with it a bit,
and did not observe any obvious regressions.  I don't have the full
battery of tests that you do, though.  However, if you do have something
else I should test against prior to submission, I'd be happy to do so.

That patch is in the e-mail that follows, and its commit message should
explain the approach to the solution, hopefully to your satisfaction.

Thanks,

-K


Krister Johansen (1):
  tracing: fix a WARN from trace_event_dyn_put_ref

 kernel/trace/trace_event_perf.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

-- 
2.25.1

