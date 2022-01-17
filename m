Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D6049110B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 21:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243160AbiAQUjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 15:39:48 -0500
Received: from mail.efficios.com ([167.114.26.124]:46642 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbiAQUjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 15:39:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5EDA6304AB5;
        Mon, 17 Jan 2022 15:39:39 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1E9gyScGOIpY; Mon, 17 Jan 2022 15:39:38 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A7FFA3048F0;
        Mon, 17 Jan 2022 15:39:38 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A7FFA3048F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1642451978;
        bh=fA1tSXSI/GSpIODrqN7cBniamSWFZWSgV+id3EAP820=;
        h=From:To:Date:Message-Id;
        b=YPSvp4SCq69YIMqWnDGpaLUoa6FJcXstKl1Zafgj8D6D/SdPad4iZqTceYwIscQtv
         APkVmPDbYR/rQfwa3DeLA+8mr2r9xZb5CdNofqX0TUseIDIAmS3emWIdQJVL3okIP9
         spM6KIx6+kZ+bJWBKnu4vfyh/Ndcrfs1zRfaxAZVwpPWba271/nUMgSeBn7Y7IEn2s
         1biP39D6gX8mCMgqKJB22qrYU6mAXMuD3YmhndhFHgLA0Rg2v9XtKg3RCnI8KwAqu8
         b6iwEF2zIPnYO2c8RznsQA6MuhAFxwKGi8QHwR1wLLIfbdaSqZDuofzOWymoa4aJrK
         xsb02PFAFX4yw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zchlrbzLWw3J; Mon, 17 Jan 2022 15:39:38 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 2611F304866;
        Mon, 17 Jan 2022 15:39:38 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 0/5] RSEQ selftests uplift for glibc-2.35 compatibility
Date:   Mon, 17 Jan 2022 15:39:20 -0500
Message-Id: <20220117203925.12164-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

glibc-2.35 will be released on 2022-02-01. It introduces a user-space ABI
based on the thread pointer to access a reserved area of the TCB.

The rseq selftests originally expected the rseq thread data to sit in a
__rseq_abi TLS variable.

Considering that the rseq ABI only allows a single rseq registration per
thread, both cannot actively coexist in a process.

Adapt the selftests librseq implementation to become compatible with
glibc-2.35. Keep a fallback implementation based on TLS available when
an older glibc is detected.

Feedback is welcome,

Thanks,

Mathieu

Mathieu Desnoyers (5):
  selftests/rseq: Remove useless assignment to cpu variable
  selftests/rseq: Remove volatile from __rseq_abi
  selftests/rseq: Introduce rseq_get_abi() helper
  selftests/rseq: Introduce thread pointer getters
  selftests/rseq: Uplift rseq selftests for compatibility with
    glibc-2.35

 tools/testing/selftests/rseq/Makefile         |   2 +-
 tools/testing/selftests/rseq/param_test.c     |   4 +-
 tools/testing/selftests/rseq/rseq-arm.h       |  32 ++--
 tools/testing/selftests/rseq/rseq-arm64.h     |  32 ++--
 .../rseq/rseq-generic-thread-pointer.h        |  25 +++
 tools/testing/selftests/rseq/rseq-mips.h      |  32 ++--
 .../selftests/rseq/rseq-ppc-thread-pointer.h  |  30 ++++
 tools/testing/selftests/rseq/rseq-ppc.h       |  32 ++--
 tools/testing/selftests/rseq/rseq-s390.h      |  24 +--
 .../selftests/rseq/rseq-thread-pointer.h      |  19 +++
 .../selftests/rseq/rseq-x86-thread-pointer.h  |  40 +++++
 tools/testing/selftests/rseq/rseq-x86.h       |  30 ++--
 tools/testing/selftests/rseq/rseq.c           | 161 +++++++++---------
 tools/testing/selftests/rseq/rseq.h           |  24 ++-
 14 files changed, 302 insertions(+), 185 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/rseq-generic-thread-pointer.h
 create mode 100644 tools/testing/selftests/rseq/rseq-ppc-thread-pointer.h
 create mode 100644 tools/testing/selftests/rseq/rseq-thread-pointer.h
 create mode 100644 tools/testing/selftests/rseq/rseq-x86-thread-pointer.h

-- 
2.17.1

