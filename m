Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3AC46139C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbhK2LNl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 Nov 2021 06:13:41 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:22942 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377058AbhK2LLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:11:37 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-4fYRxpcdNzqk5NfYYwgBxg-1; Mon, 29 Nov 2021 06:08:13 -0500
X-MC-Unique: 4fYRxpcdNzqk5NfYYwgBxg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83F30760C0;
        Mon, 29 Nov 2021 11:08:11 +0000 (UTC)
Received: from x1.com (unknown [10.22.8.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 906815D9DE;
        Mon, 29 Nov 2021 11:07:55 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tao Zhou <tao.zhou@linux.dev>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 00/14] RTLA: An interface for osnoise/timerlat tracers
Date:   Mon, 29 Nov 2021 12:07:38 +0100
Message-Id: <cover.1638182284.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rtla(1) is a meta-tool that includes a set of commands that
aims to analyze the real-time properties of Linux. But instead of
testing Linux as a black box, rtla leverages kernel tracing
capabilities to provide precise information about the properties
and root causes of unexpected results.

To start, it presents an interface to the osnoise and timerlat tracers.
In the future, it will also serve as home to the rtsl [1] and other
latency/noise tracers.

If you just want to run it, you can download the tarball here:
  - https://bristot.me/files/rtla/tarball/rtla-0.4.tar.bz2

To compile rtla on fedora you need:
  $ git clone git://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git
  $ cd libtraceevent/
  $ make
  $ sudo make install
  $ cd ..
  $ git clone git://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git
  $ cd libtracefs/
  $ make
  $ sudo make install
  $ cd ..
  $ sudo dnf install python3-docutils procps-devel
  $ cd $rtla_src
  $ make
  $ sudo make install

The tracing option (-t) depends some kernel patches that are
available at [2].

This tool was be discussed at the RT-MC during LPC2021 [3]

[1] rtsl: https://github.com/bristot/rtsl/
[2] https://lore.kernel.org/lkml/cover.1635533292.git.bristot@kernel.org/
[3] https://youtu.be/cZUzc0U1jJ4

Changes from V7:
  - Add README.txt with information about how to compile the tool
    (Steven)
  - Use $$($(PKG_CONFIG) --libs libtracefs) to find libtracefs on
    Makefile (Steven)
  - Fix *buffer[4096] (using buffer[4096]) on save_trace_to_file()
    (Steven)
Changes from v6:
  - Revisited osnoise option config functions
  - Properly handles offline CPUs
  - Some cleanups
  - Fixed an histogram allocation problem (Tao Zhou)
  - Revisited open()/read()/write() (Tao Zhou)
Changes from v5:
  - Fix retval check in save_trace_to_file() (Tao Zhou)
  - Fix goto logic in save_trace_to_file() (Tao Zhou)
  - Removed unused save_trace_pipe_to_file() function
  - Correctly handle an error on osnoise_set_* functions during
    "apply config" for all tools (Tao Zhou)
Changes from v3:
  - Add cross-compile support (Ahmed S. Darwish)
  - Move documentation to Documentation/tools/rtla (Jonathan Corbet)
  - Use .rst format for documentation (Jonathan Corbet)
  - Use include option from .rst to group common parts of the documentation
  - Makefile (main and doc) cleanups
Changes from v2:
  - Fix the miss conception of the "size" for kernel histograms (Steven/Tom)
  - Change the --skip-zeros to --with-zeros option as the former is better
    for humans (and the latter for computers to plot charts).
  - A lot of checkpatch fixes for the user-space part.
Changes from v1:
  - Fixes -t options on osnoise tracers (-t means --trace for all tools now)
  - Fixes --bucket-size references (not --bucket_size)

Daniel Bristot de Oliveira (14):
  rtla: Real-Time Linux Analysis tool
  rtla: Helper functions for rtla
  rtla: Add osnoise tool
  rtla/osnoise: Add osnoise top mode
  rtla/osnoise: Add the hist mode
  rtla: Add timerlat tool and timelart top mode
  rtla/timerlat: Add timerlat hist mode
  rtla: Add Documentation
  rtla: Add rtla osnoise man page
  rtla: Add rtla osnoise top documentation
  rtla: Add rtla osnoise hist documentation
  rtla: Add rtla timerlat documentation
  rtla: Add rtla timerlat top documentation
  rtla: Add rtla timerlat hist documentation

 Documentation/tools/rtla/Makefile             |   41 +
 Documentation/tools/rtla/common_appendix.rst  |   12 +
 .../tools/rtla/common_hist_options.rst        |   23 +
 Documentation/tools/rtla/common_options.rst   |   24 +
 .../tools/rtla/common_osnoise_description.rst |    8 +
 .../tools/rtla/common_osnoise_options.rst     |   17 +
 .../rtla/common_timerlat_description.rst      |   10 +
 .../tools/rtla/common_timerlat_options.rst    |   16 +
 .../tools/rtla/common_top_options.rst         |    3 +
 .../tools/rtla/rtla-osnoise-hist.rst          |   66 ++
 Documentation/tools/rtla/rtla-osnoise-top.rst |   61 +
 Documentation/tools/rtla/rtla-osnoise.rst     |   59 +
 .../tools/rtla/rtla-timerlat-hist.rst         |  106 ++
 .../tools/rtla/rtla-timerlat-top.rst          |  145 +++
 Documentation/tools/rtla/rtla-timerlat.rst    |   57 +
 Documentation/tools/rtla/rtla.rst             |   48 +
 tools/tracing/rtla/Makefile                   |  102 ++
 tools/tracing/rtla/README.txt                 |   36 +
 tools/tracing/rtla/src/osnoise.c              | 1017 +++++++++++++++++
 tools/tracing/rtla/src/osnoise.h              |   96 ++
 tools/tracing/rtla/src/osnoise_hist.c         |  799 +++++++++++++
 tools/tracing/rtla/src/osnoise_top.c          |  577 ++++++++++
 tools/tracing/rtla/src/rtla.c                 |   87 ++
 tools/tracing/rtla/src/timerlat.c             |   72 ++
 tools/tracing/rtla/src/timerlat.h             |    4 +
 tools/tracing/rtla/src/timerlat_hist.c        |  820 +++++++++++++
 tools/tracing/rtla/src/timerlat_top.c         |  615 ++++++++++
 tools/tracing/rtla/src/trace.c                |  192 ++++
 tools/tracing/rtla/src/trace.h                |   27 +
 tools/tracing/rtla/src/utils.c                |  433 +++++++
 tools/tracing/rtla/src/utils.h                |   56 +
 31 files changed, 5629 insertions(+)
 create mode 100644 Documentation/tools/rtla/Makefile
 create mode 100644 Documentation/tools/rtla/common_appendix.rst
 create mode 100644 Documentation/tools/rtla/common_hist_options.rst
 create mode 100644 Documentation/tools/rtla/common_options.rst
 create mode 100644 Documentation/tools/rtla/common_osnoise_description.rst
 create mode 100644 Documentation/tools/rtla/common_osnoise_options.rst
 create mode 100644 Documentation/tools/rtla/common_timerlat_description.rst
 create mode 100644 Documentation/tools/rtla/common_timerlat_options.rst
 create mode 100644 Documentation/tools/rtla/common_top_options.rst
 create mode 100644 Documentation/tools/rtla/rtla-osnoise-hist.rst
 create mode 100644 Documentation/tools/rtla/rtla-osnoise-top.rst
 create mode 100644 Documentation/tools/rtla/rtla-osnoise.rst
 create mode 100644 Documentation/tools/rtla/rtla-timerlat-hist.rst
 create mode 100644 Documentation/tools/rtla/rtla-timerlat-top.rst
 create mode 100644 Documentation/tools/rtla/rtla-timerlat.rst
 create mode 100644 Documentation/tools/rtla/rtla.rst
 create mode 100644 tools/tracing/rtla/Makefile
 create mode 100644 tools/tracing/rtla/README.txt
 create mode 100644 tools/tracing/rtla/src/osnoise.c
 create mode 100644 tools/tracing/rtla/src/osnoise.h
 create mode 100644 tools/tracing/rtla/src/osnoise_hist.c
 create mode 100644 tools/tracing/rtla/src/osnoise_top.c
 create mode 100644 tools/tracing/rtla/src/rtla.c
 create mode 100644 tools/tracing/rtla/src/timerlat.c
 create mode 100644 tools/tracing/rtla/src/timerlat.h
 create mode 100644 tools/tracing/rtla/src/timerlat_hist.c
 create mode 100644 tools/tracing/rtla/src/timerlat_top.c
 create mode 100644 tools/tracing/rtla/src/trace.c
 create mode 100644 tools/tracing/rtla/src/trace.h
 create mode 100644 tools/tracing/rtla/src/utils.c
 create mode 100644 tools/tracing/rtla/src/utils.h

-- 
2.31.1

