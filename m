Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D534E56CE88
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 12:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiGJKTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 06:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGJKTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 06:19:31 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C626CDFA7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 03:19:30 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q5-20020a17090a304500b001efcc885cc4so2491544pjl.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 03:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JTO/DmGBufL49ATYRzH8WqFesN8Rd/U/UzMZUOX4HtY=;
        b=KcY04OwgjtjrAQBJcL1t87L2+zlUvsdD/xpH5ADiey8tNsplTZVxT6/z2VpxB1xdqs
         5O2faW//yvNUXnwc4tQZajQIOQKH+XMp5ghIHjl0w9pN/uKx3JENzEcO5Fnw1JanouFI
         2StQF53YJGPt7hvM7Ibv44l9la/sdhD6RbZeg57jsvKs7duklIubLPi955y5XyVqWR89
         Ehb0sIaGFiy7Ga1tis5a51MmuxN/KsHw8diNcMxLYpEEfJIPyw/Ec5gegd5dTvtIDpCG
         VERZ5XG9v7GejLRwZfxMYZVHBJkQI+aOXTsbYyGWttz0guhiTavgG78uiUUAS84UHVL7
         4b5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JTO/DmGBufL49ATYRzH8WqFesN8Rd/U/UzMZUOX4HtY=;
        b=yzGqaoklgwtMeQprGpJOKEn9goKhLpO/ybSajamiCGWgKy1dF91P71yoPROe+8tl3d
         6CKtU7DKbuizYC4YZDCMLdTmUNdK9v4Wv+zy2EkibJfMxImRkue+MH54VY4Mvs/Dz63F
         QjK0VbtmlztmyZ56mcPfRi4VxVKvbOcugvRK/7jlCOC85lwpPMIPXa78COOjjQD4/hkh
         RGjeGIqsbWjBIogWABIFe7cUQFYOmgPtNJnjWMcDODYbf0mWpYjZPq0F4diLHeqAKhgx
         nzTdlEJwF+rsHkkkWONC2lvlvxem2lXy8TqWJE/ow4TCMqKnghC3psnY+6eKTpYDkxpX
         6cvw==
X-Gm-Message-State: AJIora+1xE7KnoPyyC3vdalX2NBSq0XICX8088D5kLy9P9KiCo8Ws5gD
        ITaf/r/APWvw5kVW3jFwoV4SHg==
X-Google-Smtp-Source: AGRyM1uW/ijF/CNs4SQfNUtkDS/v0eJfHH+0//WJxxOvCxy6Qs5pLDnF/Ot+MMf7AA3yXBTn0j+jYg==
X-Received: by 2002:a17:902:d509:b0:16c:1664:8201 with SMTP id b9-20020a170902d50900b0016c16648201mr12861980plg.31.1657448370349;
        Sun, 10 Jul 2022 03:19:30 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id n7-20020a170903110700b0016c304612a0sm2469785plh.292.2022.07.10.03.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 03:19:29 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v2] sched/fair: Remove unused parameter idle of _nohz_idle_balance()
Date:   Sun, 10 Jul 2022 18:19:10 +0800
Message-Id: <20220710101910.8413-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7a82e5f52a35 ("sched/fair: Merge for each idle cpu loop of ILB")
has been merged. The parameter idle of _nohz_idle_balance()
is not used anymore so we can remove it.

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 77b2048a9326..8d4be2a95e37 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10682,8 +10682,7 @@ static bool update_nohz_stats(struct rq *rq)
  * can be a simple update of blocked load or a complete load balance with
  * tasks movement depending of flags.
  */
-static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
-			       enum cpu_idle_type idle)
+static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags)
 {
 	/* Earliest time when we have to do rebalance again */
 	unsigned long now = jiffies;
@@ -10798,7 +10797,7 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 	if (idle != CPU_IDLE)
 		return false;
 
-	_nohz_idle_balance(this_rq, flags, idle);
+	_nohz_idle_balance(this_rq, flags);
 
 	return true;
 }
@@ -10818,7 +10817,7 @@ void nohz_run_idle_balance(int cpu)
 	 * (ie NOHZ_STATS_KICK set) and will do the same.
 	 */
 	if ((flags == NOHZ_NEWILB_KICK) && !need_resched())
-		_nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK, CPU_IDLE);
+		_nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK);
 }
 
 static void nohz_newidle_balance(struct rq *this_rq)
-- 
2.32.0

