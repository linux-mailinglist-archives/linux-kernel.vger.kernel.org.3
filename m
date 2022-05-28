Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518C55369F2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 03:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352031AbiE1B5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 21:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238672AbiE1B5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 21:57:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DE4BA187
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 18:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653703062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1uLC+oxcDJJvepGvd1tVraFd6/ac0FDp72aGh5ZnEtc=;
        b=SrTHV7M4JgZlUiW8gLOT6e4XsJRio9+mSimysNm+Gw/wlX9PWSEBu46Z19Z5zRZNdY7iE8
        iAsHT9SEnsFdx0BHDsI7hHyO4yY0CKUzoPnA98ZDB8yFw4ByKge/S6kmDlljnViU+WhsA2
        yQR3neeKvADUdfzwA+rWZn9qnm1skec=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-XtU76bs8N6eAyLxgcrHZAA-1; Fri, 27 May 2022 21:57:38 -0400
X-MC-Unique: XtU76bs8N6eAyLxgcrHZAA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 621D9800882;
        Sat, 28 May 2022 01:57:38 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8D1C40EC002;
        Sat, 28 May 2022 01:57:37 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Larabel <Michael@phoronix.com>,
        Joe Mario <jmario@redhat.com>,
        Michey Mehta <mimehta@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] clocksource: Make clocksource watchdog check with WATCHDOG_INTERVAL period
Date:   Fri, 27 May 2022 21:57:14 -0400
Message-Id: <20220528015714.109442-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit c86ff8c55b8a ("clocksource: Avoid accidental unstable
marking of clocksource"), a new WD_READ_SKIP value was introduced
as a possible return value of cs_watchdog_read() to skip the current
check. However, this has an undesriable side effect of extending the
time gap between csnow and cs_last to more than one WATCHDOG_INTERVAL
(0.5s) in case of intermittent WD_READ_SKIP's.

There was an instance of reported clocksource watchdog failure with
the time skew of 485us where the uncertainly threshold is 400us. In
that particular case, the (now - last) gap was about 2s. Looking at
the dmesg log, it was clear there was a successful cs_watchdog_read()
followed by 3 skips and then another successful cs_watchdog_read().

If there is an existing skew between the hpet (watchdog) and tsc
clocksource, enlarging the period by 4x will certainly increase the
measured skew causing it to exceed the threshold in this case. Fix
this variable period problem by resetting the CLOCK_SOURCE_WATCHDOG bit
after each WD_READ_SKIP to force the reloading of wd_last and cs_last
in the next round. This ensures that we have two consecutive successful
cs_watchdog_read()'s before checking the clock skew.

Fixes: c86ff8c55b8a ("clocksource: Avoid accidental unstable marking of clocksource")
Reported-by: Michael Larabel <Michael@phoronix.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/time/clocksource.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index cee5da1e54c4..173e052c12b6 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -411,9 +411,18 @@ static void clocksource_watchdog(struct timer_list *unused)
 		read_ret = cs_watchdog_read(cs, &csnow, &wdnow);
 
 		if (read_ret != WD_READ_SUCCESS) {
-			if (read_ret == WD_READ_UNSTABLE)
+			if (read_ret == WD_READ_UNSTABLE) {
 				/* Clock readout unreliable, so give it up. */
 				__clocksource_unstable(cs);
+			} else { /* WD_READ_SKIP */
+				/*
+				 * Watchdog clock unstable at the moment,
+				 * discard the stored wd_last and cs_last to
+				 * make sure the gap between now and last
+				 * is always one WATCHDOG_INTERVAL.
+				 */
+				cs->flags &= ~CLOCK_SOURCE_WATCHDOG;
+			}
 			continue;
 		}
 
-- 
2.31.1

