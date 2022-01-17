Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E6A491106
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 21:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242919AbiAQUjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 15:39:41 -0500
Received: from mail.efficios.com ([167.114.26.124]:46622 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiAQUjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 15:39:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 596C730492D;
        Mon, 17 Jan 2022 15:39:39 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WKMDQYRJ36QK; Mon, 17 Jan 2022 15:39:38 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id DAC393048F1;
        Mon, 17 Jan 2022 15:39:38 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DAC393048F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1642451978;
        bh=nncvokTdjsee5tzKxA/veggGUZZ9ULSWsY7QtAMw1Bc=;
        h=From:To:Date:Message-Id;
        b=qS0YDsnfsMJIFjJGNgV1ZQwET8nAOhiXqTaKq8a2BYoPAmqulJkIAE0Zwc1qnjjn8
         eS0LCqgfg5JduBuclgyMTvQmV169IlverXnckpDOq+u2mbRbHC37j/paSnXKeQW///
         GZMJBuURG7wdi2llPwxOgESblCsOVh5gz9ROJVaw8RlWxwQAS0MGQl6BONcPAh8DTj
         YNn3HBpFQi6L7MjLxyoDfj4c44jSePsRFGi/b2TOmgArLZKzgo8dY+C1yKDpIb3OJz
         TXga5zLQvNnEUHVIKSvPnI0+E9fVmMO6UEtMBEfbjlsBYlm5oDj56e3E4x3vGobYy8
         Bv7cBJCKUuZhw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ToEmXpaVHVXv; Mon, 17 Jan 2022 15:39:38 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 944833048EF;
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
Subject: [RFC PATCH 1/5] selftests/rseq: Remove useless assignment to cpu variable
Date:   Mon, 17 Jan 2022 15:39:21 -0500
Message-Id: <20220117203925.12164-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220117203925.12164-1-mathieu.desnoyers@efficios.com>
References: <20220117203925.12164-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/param_test.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index 699ad5f93c34..cc2cfc1da938 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -368,9 +368,7 @@ void *test_percpu_spinlock_thread(void *arg)
 		abort();
 	reps = thread_data->reps;
 	for (i = 0; i < reps; i++) {
-		int cpu = rseq_cpu_start();
-
-		cpu = rseq_this_cpu_lock(&data->lock);
+		int cpu = rseq_this_cpu_lock(&data->lock);
 		data->c[cpu].count++;
 		rseq_percpu_unlock(&data->lock, cpu);
 #ifndef BENCHMARK
-- 
2.17.1

