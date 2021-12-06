Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC514468FC0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 04:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236556AbhLFDmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 22:42:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54172 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236463AbhLFDmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 22:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638761919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=uOm7tN5HrbR54ETQmfV/zhJf1ohEr/VaMD2Ihr+NE0A=;
        b=UkEmORuAxSc5R7MhHE8CZvoPVDekYYkxpzRdV0UOJT3mXFqs29S/1DU4JIsYaO1Th1/NB6
        0yuOykYvUhI1LsU/lz5Chlt1EEw1zB7+ByajFUZ8LEpy4mWebbk0+AytPbQdLsGwwq3NSx
        4SfAXT+0KZp3O8qeHZB3Rk9gNsXn0VU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-Day9Yq-hOqaRjb6OQVYv5w-1; Sun, 05 Dec 2021 22:38:36 -0500
X-MC-Unique: Day9Yq-hOqaRjb6OQVYv5w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6284E81CCB4;
        Mon,  6 Dec 2021 03:38:35 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B1775ED25;
        Mon,  6 Dec 2021 03:38:21 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH-rcu] clocksource: Add a Kconfig option for WATCHDOG_MAX_SKEW
Date:   Sun,  5 Dec 2021 22:38:15 -0500
Message-Id: <20211206033815.871823-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A watchdog maximum skew of 100us may still be too small for
some systems or archs. It may also be too small when some kernel
debug config options are enabled.  So add a new Kconfig option
CLOCKSOURCE_WATCHDOG_MAX_SKEW_US to allow kernel builders to have more
control on the threshold for marking clocksource as unstable.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/time/Kconfig       | 9 +++++++++
 kernel/time/clocksource.c | 8 +++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 04bfd62f5e5c..27b7868b5c30 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -181,5 +181,14 @@ config HIGH_RES_TIMERS
 	  hardware is not capable then this option only increases
 	  the size of the kernel image.
 
+config CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
+	int "Clocksource watchdog maximum allowable skew (in μs)"
+	depends on CLOCKSOURCE_WATCHDOG
+	range 50 1000
+	default 100
+	help
+	  Specify the maximum amount of allowable watchdog skew in
+	  microseconds before reporting the clocksource to be unstable.
+
 endmenu
 endif
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index b7e52a642948..877a78bea9b0 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -107,7 +107,13 @@ static u64 suspend_start;
  * This delay could be due to SMIs, NMIs, or to VCPU preemptions.  Used as
  * a lower bound for cs->uncertainty_margin values when registering clocks.
  */
-#define WATCHDOG_MAX_SKEW (100 * NSEC_PER_USEC)
+#ifdef CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
+#define MAX_SKEW_USEC	CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
+#else
+#define MAX_SKEW_USEC	100
+#endif
+
+#define WATCHDOG_MAX_SKEW (MAX_SKEW_USEC * NSEC_PER_USEC)
 
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
 static void clocksource_watchdog_work(struct work_struct *work);
-- 
2.27.0

