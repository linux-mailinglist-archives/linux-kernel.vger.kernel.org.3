Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61ED467832
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381016AbhLCNb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:31:57 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56798 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380984AbhLCNbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:31:44 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 015231F46E3E
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638538100; bh=VPqzyMJ4YgGjezTgrVb27AbKlJKoOVuUq64nqSqojVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dbWtQNTnG/71ZTaMpLd4jiLALygP5VRTY56n1xardp6n1QVpYmNQ5xGAtHMJ8ndmS
         QUzp1pWTOHxmeO6BDY+vjxOdq0mPr68HlxsWhM5ihOTMdc6+kWnE2uXh+Sj/BOIdM9
         /e8crtL851aUIFcwTtk9AP3/wigSAYUZnbsGtqruhkB9Y7U2BbgV3JkZ9egq0WwlzX
         6Cw/c2mFLbJiN/tcvJVFJs0ZQIEcIBt1SHjGM71PtmHskpux0kJGBatZ6WHmXO3Mc0
         PERkKnfZK8JAfksBcv4MCrjnWS8S7m9HTiw52tXeZ8fioIg3yvm5gkGmTB/kqtLX2D
         TNVFsF8YGw+Fg==
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>
Cc:     =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH RESEND 1/2] selftests: futex: Make futex_waitv's invalid clockid test more robust
Date:   Fri,  3 Dec 2021 10:28:07 -0300
Message-Id: <20211203132808.16907-2-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211203132808.16907-1-andrealmeid@collabora.com>
References: <20211203132808.16907-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we use NULL for *waiters, we may be triggering a different error
path. Use a valid value for this arguments to make sure that the invalid
clockid is the one triggering the EINVAL return.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 tools/testing/selftests/futex/functional/futex_waitv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_waitv.c b/tools/testing/selftests/futex/functional/futex_waitv.c
index a94337f677e1..336b04dacd0e 100644
--- a/tools/testing/selftests/futex/functional/futex_waitv.c
+++ b/tools/testing/selftests/futex/functional/futex_waitv.c
@@ -217,12 +217,17 @@ int main(int argc, char *argv[])
 	}
 
 	/* Testing an invalid clockid */
+	waitv[0].uaddr = (uintptr_t)&futexes[0];
+	waitv[0].flags = FUTEX_PRIVATE_FLAG | FUTEX_32;
+	waitv[0].val = 0;
+	waitv[0].__reserved = 0;
+
 	if (clock_gettime(CLOCK_MONOTONIC, &to))
 		error("gettime64 failed\n", errno);
 
 	to.tv_sec++;
 
-	res = futex_waitv(NULL, NR_FUTEXES, 0, &to, CLOCK_TAI);
+	res = futex_waitv(waitv, 1, 0, &to, CLOCK_TAI);
 	if (res == EINVAL) {
 		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
 				      res ? errno : res,
-- 
2.34.1

