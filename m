Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27952586380
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 06:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239346AbiHAE2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 00:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239256AbiHAE2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 00:28:18 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF81DFD2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:28:13 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso10710523pjd.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BbAH2OjARx+sGC5hf2wT2Wik++XxhkGMe8jaPc24Anw=;
        b=IczVJ2eKvmP1G8pKdOptWmdZQ50McO+PEJnY9lhMh9n3yBOci29Hy7BfOVJaA96C33
         HIKcza5nQHSjytEj3bEsizWtqvT0dDNntorVhqwoPgzcm1ViswS0EoJ9KDOe19hR0aKC
         F9MTAobqpUKmNLaxX448BoW9xynm3SDQ+NwFI2Z3sCwNgJSov2CgF6Xid1OU+QMPLDcg
         yhzFbqgbf26Dv6fYpfnPqi2wFMd7mX1YT/u94gJEpjMaCpAwrJzKtr+nMOk9/xGBGSsx
         czxVrP9M0yVeJe/bWpT0px2MKBRptjYW0MFTAMxNb8mHgYzA4HzfbstW2W3MsMUWm7+g
         BLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BbAH2OjARx+sGC5hf2wT2Wik++XxhkGMe8jaPc24Anw=;
        b=StQZZofpnWvxJpykH2XQsAD5W6w8qiNc98296GCj3SLsJBe9Gak5z+WTyrhRqZqoKD
         fUPdY+G8U8WC6crcO08+0V1nyOW+eo4V8K0nICJAMq+6FDi47S4B8h9N1fbNGc1J5XzK
         3VWlqecs0dlzQAcul1LDFON5UouUZe1j1BP0dECeAizRtj/JlYjA+z/u5gydAaA2DXv0
         D0WupDpr2fvDnRNryLiQPFQVW00bgc3JNweLFZkK/AzgCQKYJ8bsWSXhR9aUjQLv7Oel
         AJz/ynV/r773mu3mBL3bte8hDYibsZwvuyNohn6fD534Scdwu3w45auSkeH5JsYEcpGZ
         mrgA==
X-Gm-Message-State: ACgBeo1MBU8QUjXxOEYkuTL7fhV1pA82BWX/Gb9gkvVVIWHXgXSSLWfS
        liaQaP9NlebVMLpEpgJkpovYvw==
X-Google-Smtp-Source: AA6agR42VQvDZQLNDhWgGmDrWl43U9P1MPEvqcTr204dMPM1bxfhkCHoUMDjEe1mJQD53KUFgT8eZA==
X-Received: by 2002:a17:903:2589:b0:16d:c26c:d641 with SMTP id jb9-20020a170903258900b0016dc26cd641mr14829718plb.8.1659328093055;
        Sun, 31 Jul 2022 21:28:13 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id ot10-20020a17090b3b4a00b001f326ead012sm7012202pjb.37.2022.07.31.21.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 21:28:12 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 03/10] sched/fair: reset sched_avg last_update_time before set_task_rq()
Date:   Mon,  1 Aug 2022 12:27:38 +0800
Message-Id: <20220801042745.7794-4-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801042745.7794-1-zhouchengming@bytedance.com>
References: <20220801042745.7794-1-zhouchengming@bytedance.com>
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

set_task_rq() -> set_task_rq_fair() will try to synchronize the blocked
task's sched_avg when migrate, which is not needed for already detached
task.

task_change_group_fair() will detached the task sched_avg from prev cfs_rq
first, so reset sched_avg last_update_time before set_task_rq() to avoid that.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 89626b115660..948b4cd2a024 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11664,12 +11664,12 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 static void task_change_group_fair(struct task_struct *p)
 {
 	detach_task_cfs_rq(p);
-	set_task_rq(p, task_cpu(p));
 
 #ifdef CONFIG_SMP
 	/* Tell se's cfs_rq has been changed -- migrated */
 	p->se.avg.last_update_time = 0;
 #endif
+	set_task_rq(p, task_cpu(p));
 	attach_task_cfs_rq(p);
 }
 
-- 
2.36.1

