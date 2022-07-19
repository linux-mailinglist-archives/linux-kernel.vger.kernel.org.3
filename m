Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0055795AC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237175AbiGSI40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237159AbiGSI4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:56:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086561FCEB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:56:21 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 966A434B89;
        Tue, 19 Jul 2022 08:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658220980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GIWvK6SdOkdTzLJ2dgaOPeK8zxVvAr1FGwnG8t4MDVQ=;
        b=lA27UtdXd6BYpr2fHMRc/+rXqPbnU+dk/9tcQBYL1Ih5iPFQObdKP0+89QKxemOIfrN2U1
        iWJrxg+EwpXCsDi9f7VRoVs575XFLbh3gBYaXxl1LUIam8/jE1v2aHN6KTjGWkaKfm0Ar/
        7miOWPk1Pr95yUc5pQfqiOZOGac+P/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658220980;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GIWvK6SdOkdTzLJ2dgaOPeK8zxVvAr1FGwnG8t4MDVQ=;
        b=Fb1TUitTC+JzYVidc8leyHcSjUHGwt76YjXhpmpPOzR3/+zlHG6jMt295m3I1pIPHkSrvt
        BK86lzVaBGlQjVDQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7405F2C141;
        Tue, 19 Jul 2022 08:56:20 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] posix-timers: make do_clock_gettime() static
Date:   Tue, 19 Jul 2022 10:56:20 +0200
Message-Id: <20220719085620.30567-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_clock_gettime() is used only in posix-stubs.c, so make it static. It avoids
a compiler warning too:
time/posix-stubs.c:73:5: warning: no previous prototype for ‘do_clock_gettime’ [-Wmissing-prototypes]

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 kernel/time/posix-stubs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index fcb3b21d8bdc..90ea5f373e50 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -70,7 +70,7 @@ SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,
 	return do_sys_settimeofday64(&new_tp, NULL);
 }
 
-int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
+static int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
 {
 	switch (which_clock) {
 	case CLOCK_REALTIME:
@@ -90,6 +90,7 @@ int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
 
 	return 0;
 }
+
 SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
 		struct __kernel_timespec __user *, tp)
 {
-- 
2.37.1

