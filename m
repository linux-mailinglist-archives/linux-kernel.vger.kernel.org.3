Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28784B6CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbiBOMwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:52:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiBOMwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:52:16 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF671AF2A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:52:06 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id om7so17311479pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M4vOG1MxIcvAeIUiKHRfizxs2Ti0mOYROHB7Jdcc1G0=;
        b=FlVko+8xIgFVOZG5EwFzWNjkKIG1XeNaQKgP8zS7KdfKbcf4CXI4Xcs4H82OGFyVDg
         UmfUvZbQT3hPMfC00YtmvC0nQrK9UdYdpjBrGNgJBDvkDTI4ywv5qmh2tIdPmifH6vC/
         zlvunXnrDklwPDDh+t1/qZ802BPpVNxWssBkRtXxpzqU9K4/rotCBr69G6/yZZQS4vl1
         9h1sA7Wan/LUTcUq7mY75MVrKzzPpS6WWJnibwjS+oW5nqmEi2UZSut8iiAsxZe8SIXs
         t1ChQGqPqo7JV9HT/8Wd9g3LS4nlZs14JfW76UdKkTjEtOTtYceWH+RmqrP47H7LvOG/
         aJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M4vOG1MxIcvAeIUiKHRfizxs2Ti0mOYROHB7Jdcc1G0=;
        b=7GtH58xZ9Gjrdw3o/gDSE+CMZzia/CBcldAgaJVm7wSsEI/xtdw+vivDL9STcTPI4U
         bgE4u06EzoNcWPU1g5pUe99Orq8/I2FShuuXnM4e/c3BH2UBAK544nS6D/tsDJFLMWvR
         k6r6bfBcotQeDoG/CjWrIO7sP8PgDX/FmSBFrhWriSX9NThhjDw0EFMdbqXlPj0N0Ag/
         7AMh3jONJMPLuI+DdpcIqxxdEJWKeigBQ2RCGKFUFUzXzeYB5p6rT2p6xf4loT6xAhS/
         T7E+s+7s1ufzt7tgmAgWxELrsUgLHZEMBaAiERKJd+p3S4JikGUSVA0OuEDqXt1V7WMk
         Jlug==
X-Gm-Message-State: AOAM532+kPKBR9iMwJkbo8HFjtfqbPB9MVY0x42TG3ZS3RrBrp/tjR5X
        Z4fQQRRrhJz5uvUAYU6dccQd5g==
X-Google-Smtp-Source: ABdhPJzGgZIzImzhFzA6LpGu+vqxtNbu6DH6NDgvnUsjY1XzvgGw4rpM8skk9KBzneHLkNZJfP6SnA==
X-Received: by 2002:a17:902:b692:: with SMTP id c18mr4102998pls.85.1644929526212;
        Tue, 15 Feb 2022 04:52:06 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id x126sm25580764pfb.117.2022.02.15.04.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 04:52:05 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Minye Zhu <zhuminye@bytedance.com>
Subject: [PATCH v2] sched/cpuacct: fix charge percpu cpuusage
Date:   Tue, 15 Feb 2022 20:51:57 +0800
Message-Id: <20220215125157.78386-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpuacct_account_field() is always called by the current task
itself, so it's ok to use __this_cpu_add() to charge the tick time.

But cpuacct_charge() maybe called by update_curr() in load_balance()
on a random CPU, different from the CPU on which the task is running.
So __this_cpu_add() will charge that cputime to a random incorrect CPU.

Fixes: 73e6aafd9ea8 ("sched/cpuacct: Simplify the cpuacct code")
Reported-by: Minye Zhu <zhuminye@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/cpuacct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 3d06c5e4220d..75fbc212cb71 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -335,11 +335,12 @@ static struct cftype files[] = {
 void cpuacct_charge(struct task_struct *tsk, u64 cputime)
 {
 	struct cpuacct *ca;
+	unsigned int cpu = task_cpu(tsk);
 
 	rcu_read_lock();
 
 	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
-		__this_cpu_add(*ca->cpuusage, cputime);
+		*per_cpu_ptr(ca->cpuusage, cpu) += cputime;
 
 	rcu_read_unlock();
 }
-- 
2.20.1

