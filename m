Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298644FC74F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 00:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbiDKWGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 18:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiDKWGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 18:06:03 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD2AB25
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 15:03:48 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d2d45c0df7so143791727b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 15:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=l2QzeSk04rscKqYK/6Xxv0lnCMF21ToL3+36JhEqxOk=;
        b=rTWRVsw0vZ1CY36WK2HHmooLmrx/ZBEWX94VoLqne5w3qh8vlPvD0EUyifsym2EkuH
         duKF6AT059+is+gLZ5ZfOUU1kkQ0/m6tX58AnzDWvOSYAG8TqrFYXG0wu3nqy/0alrAn
         Ibn16+RrmtgL78EaSf83YknOxoEV1vXB5knTOmZfejD3rTq82wi6Vzmo9mVbXX/0DipB
         9fVeodEVq641KnaX9+ES9ReGGQqsFJumjNcVx/gNbHFL3sCEnwrtjOYSybNpxVHOP5E/
         7BNGpPukNjat871qu1d/5IFfJqxbKu0vFCW1j1U5Zd0bIOQajZD3iFUMZv06OYHYAPZZ
         0S4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=l2QzeSk04rscKqYK/6Xxv0lnCMF21ToL3+36JhEqxOk=;
        b=jc52+8AFZuS45CECQpmFOINpb9+GGIybavbTGid9x5W79aYdkSi03c63eDu9ednQ8Y
         +MIcDrl+8OHCEGHoWuN7RZrEFTs7POaGWM/K2zYMe+Iarg4x9zMng8PKlReQHA01+lKy
         eIDerM2l7rA1Qy4B7UhrnVzAFK4b8EZ1VTM1iLUEsNt4gQXhpjxILYMrbzE8zRRrRZFi
         tjwdgvL4ecFqfM9LA7vW6bHKZCUSDj1VRSn09e5oCtTE9l19tMV/LaLfLVJt4OUy1BBH
         NdwrgRVNJ8r+CqGuKpb1oBsVGgkZpphU+H2Yj9ZelbNwoP7t/mPsXvRMdTK6pdw5g7cg
         qlEQ==
X-Gm-Message-State: AOAM5325y17hH+Q+tVIlswzinYFuPtcxOCiZzxEyFnRVYDiALXp7yWBW
        P7y9QHlz/JGEn+C/01Cn+0PtTz1Gh9s=
X-Google-Smtp-Source: ABdhPJwDLlkf85gP5BXpLbyFhFWAMCG10eECpoQO3suC9ziOOLNTGKW5qLuohyOKwHOWL6ThskypAEuFd9c=
X-Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2cd:202:9b6b:62a3:4704:a1d8])
 (user=khazhy job=sendgmr) by 2002:a25:6652:0:b0:641:25c9:9c04 with SMTP id
 z18-20020a256652000000b0064125c99c04mr8744992ybm.94.1649714627632; Mon, 11
 Apr 2022 15:03:47 -0700 (PDT)
Date:   Mon, 11 Apr 2022 15:03:35 -0700
Message-Id: <20220411220335.1235363-1-khazhy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH] dm mpath: fixup sched_clock() usage in historical selector
From:   Khazhismel Kumykov <khazhy@google.com>
To:     Mike Snitzer <snitzer@kernel.org>, Alasdair Kergon <agk@redhat.com>
Cc:     dm-devel@redhat.com, Khazhismel Kumykov <khazhy@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mixing sched_clock() and ktime_get_ns() will give bad results, don't do
it

Fixes: 2613eab11996 ("dm mpath: add Historical Service Time Path Selector")
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 drivers/md/dm-ps-historical-service-time.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-ps-historical-service-time.c b/drivers/md/dm-ps-historical-service-time.c
index 875bca30a0dd..82f2a06153dc 100644
--- a/drivers/md/dm-ps-historical-service-time.c
+++ b/drivers/md/dm-ps-historical-service-time.c
@@ -27,7 +27,6 @@
 #include <linux/blkdev.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <linux/sched/clock.h>
 
 
 #define DM_MSG_PREFIX	"multipath historical-service-time"
@@ -433,7 +432,7 @@ static struct dm_path *hst_select_path(struct path_selector *ps,
 {
 	struct selector *s = ps->context;
 	struct path_info *pi = NULL, *best = NULL;
-	u64 time_now = sched_clock();
+	u64 time_now = ktime_get_ns();
 	struct dm_path *ret = NULL;
 	unsigned long flags;
 
@@ -474,7 +473,7 @@ static int hst_start_io(struct path_selector *ps, struct dm_path *path,
 
 static u64 path_service_time(struct path_info *pi, u64 start_time)
 {
-	u64 sched_now = ktime_get_ns();
+	u64 now = ktime_get_ns();
 
 	/* if a previous disk request has finished after this IO was
 	 * sent to the hardware, pretend the submission happened
@@ -483,11 +482,11 @@ static u64 path_service_time(struct path_info *pi, u64 start_time)
 	if (time_after64(pi->last_finish, start_time))
 		start_time = pi->last_finish;
 
-	pi->last_finish = sched_now;
-	if (time_before64(sched_now, start_time))
+	pi->last_finish = now;
+	if (time_before64(now, start_time))
 		return 0;
 
-	return sched_now - start_time;
+	return now - start_time;
 }
 
 static int hst_end_io(struct path_selector *ps, struct dm_path *path,
-- 
2.35.1.1178.g4f1659d476-goog

