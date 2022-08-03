Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA62588C9B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 15:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbiHCNCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 09:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiHCNCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:02:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F76113E35
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 06:02:36 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so1967319pjf.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 06:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=/Ry3zzDkv6XblXGEI6RBqshIKSFKVZmsLhV6TX/Fy9g=;
        b=GW+ly3iz+GWMy2FTnmCGJIGHfhDH3ahknX2uZ6/Mjd61PGwJ249V9oOBjQtuK6oqQG
         C4wyHN51PIw0gKu1ZRCz2NXBrqYJXHex39uGxW88BR/ubvcepRE9iTJ9626Lq30TNZSF
         pkgCc6NhLegVECcWldgscZFOpDW+82nXM45YDZBV4czQYzAx0gaVZpwUiwTERLMhXjJo
         O+yd8DJXKW2k7HjnqUL2SZXfD+8+VX7CS80zJ9I0Tf1JamUAeGbucsH9KxRBbwdM9MJH
         3/SpdkLV1OCcC7Ek8qS/Fc65zm2a5vCYiHqtiyUxKILWjaleG/02U7S+8s6lfZoyP6UA
         uRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=/Ry3zzDkv6XblXGEI6RBqshIKSFKVZmsLhV6TX/Fy9g=;
        b=6CdoDdy3KBLJ0nh+ZQvdxgSUYl94GRyfKG/FHISwA2q3h9ReLVSBbRp+aN3REFu4mP
         odcRvN+c3jEnjjuVFFXeKwVE8rWWRw/+yxQ5OSd0uszLEcEP/dsx7u0g38Op1EWYlGz9
         bG5zYebVZw2tj5QRWbdfoBEOkUmrkoUpVCNdvt8u43IDcJ6PjgUECyR8nqk8KnTFYmRy
         t2vbXTUcXFG3fkNk+HfAQEHzQhBU39RFnm0RIg50PaupE/VLfzMmWtuPNUXN+DeSlvxD
         T9wJxuDKEhIlKC7U78KvICEUtoIv4cknk0SZ/Qsq1ZwSBjzQUUT19KLD15EczCD3O2jS
         wtaw==
X-Gm-Message-State: ACgBeo2U7+WiEyzDMxIOU8AmyxJFvlG+ZEXNQnbzE18waxNYuHnv9rAJ
        nY6IsoKiC128jk++rob/vKkSOA==
X-Google-Smtp-Source: AA6agR7F7CtHGW/mosj8VeMFYeR+Ew9PGPNdUTeRqY12r4rTkXbJjch3JLbnhAlv7SBnqMZ2wX4cSQ==
X-Received: by 2002:a17:90b:3a90:b0:1f2:edfe:db4 with SMTP id om16-20020a17090b3a9000b001f2edfe0db4mr4750561pjb.105.1659531755942;
        Wed, 03 Aug 2022 06:02:35 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id w126-20020a623084000000b0052d417039c2sm7870775pfw.133.2022.08.03.06.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 06:02:35 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH RESEND v2] sched/fair: Remove unused parameter idle of _nohz_idle_balance()
Date:   Wed,  3 Aug 2022 21:02:23 +0800
Message-Id: <20220803130223.70419-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 v2:
 - Modify the commit format, suggested by Vincent Guittot.
---
---
 kernel/sched/fair.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 914096c5b1ae..42f5b078d839 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10916,8 +10916,7 @@ static bool update_nohz_stats(struct rq *rq)
  * can be a simple update of blocked load or a complete load balance with
  * tasks movement depending of flags.
  */
-static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
-			       enum cpu_idle_type idle)
+static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags)
 {
 	/* Earliest time when we have to do rebalance again */
 	unsigned long now = jiffies;
@@ -11032,7 +11031,7 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 	if (idle != CPU_IDLE)
 		return false;
 
-	_nohz_idle_balance(this_rq, flags, idle);
+	_nohz_idle_balance(this_rq, flags);
 
 	return true;
 }
@@ -11052,7 +11051,7 @@ void nohz_run_idle_balance(int cpu)
 	 * (ie NOHZ_STATS_KICK set) and will do the same.
 	 */
 	if ((flags == NOHZ_NEWILB_KICK) && !need_resched())
-		_nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK, CPU_IDLE);
+		_nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK);
 }
 
 static void nohz_newidle_balance(struct rq *this_rq)
-- 
2.32.0

