Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8C8534D81
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345048AbiEZKkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241731AbiEZKj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:39:57 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619D1CEB85
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:39:56 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c2so1123415plh.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1qF1kRC9LwiJlnC5OgZ6TWXKv8JNcRSCPefpgmCPVd0=;
        b=3prUM9x8qMxEGp9TN9u5j+Pn+QPRZ6vtKEOOTjfSve4w4ERlYmn9ZrUQHsNqu8f8Ys
         +BbC1CCUJCQyfky8idKRSKHXDe3b4jwQ4DFLjqVqnrY3Gh74XkTcQaBtmMMsJ+38b4if
         SAq6SEjqZYA/PkuEpM+RqqrWotZevQ1MMLXCPh0y6o/snlhbqUMfaByKL+2BLBE6delk
         DHAEYKLanbnXSXyOouIFC2/YQxPc4KEvgAYuulny8sv0JCXxu0nVg5FUqhHERU+MPspA
         SsXTlCuYc8sKKlTg/gdhOGzAJG5pKX01pv5fZIiH/1EMGcConD8j2sm1RyNgCZi3qlp1
         6cNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1qF1kRC9LwiJlnC5OgZ6TWXKv8JNcRSCPefpgmCPVd0=;
        b=FLqapcr7I97iioHKrsvTOm49IhkdnvwdnV5BiW1DhVKM6OgKllc+UTHl5onZ+KYl/C
         WGAoJpq1edj8d9EWoODks02aEYWPINa1UyGQekuecI9GOiP3MNhnKx6gpYluhLzk6PYl
         2tRlg6UUjb+iIUx11M0yhsvAgPfKhKlpM5+DXjG3wTtbSJRI/QtPNnptbyHb/rGLcP7K
         EuWr+4jvdWOP03a4E2Z1MOwT82VMPogFceq43WhOwSCmhaR9zZNypjxXzghBYvQMaj+0
         7QZQJ5E/kNleWBw+gFPxYHzCrv+t/+A4vszql8JbH4zH3gxUCx57FWzETJJQ9+FNCHT3
         eCBA==
X-Gm-Message-State: AOAM530VHuZT7Cm5mluJvOsRmxivz4PHi4vz6rBXSjQ2gs/2WRcEjdCr
        Z/cVu9U6efAC44EvEF9/5i5X7E9ntXMApw==
X-Google-Smtp-Source: ABdhPJxgjNHGHZhbqF3mCgZL1AIuiMiG/+kd4oHT3n+gConpQz+Ltl/AIjmdVxqrUx1rFXHmV1v20g==
X-Received: by 2002:a17:90b:3a89:b0:1de:bad4:b614 with SMTP id om9-20020a17090b3a8900b001debad4b614mr1919898pjb.139.1653561595952;
        Thu, 26 May 2022 03:39:55 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b0015e8d4eb23dsm1257311ple.135.2022.05.26.03.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 03:39:55 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, odin@uged.al
Cc:     linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 1/2] sched/fair: fix propagate during synchronous attach/detach
Date:   Thu, 26 May 2022 18:39:28 +0800
Message-Id: <20220526103929.14976-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220526103929.14976-1-zhouchengming@bytedance.com>
References: <20220526103929.14976-1-zhouchengming@bytedance.com>
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

When a task moves from/to a cfs_rq, we first detach/attach the load_avg
of se from/to that cfs_rq, then propagate the changes across the tg tree
to make it visible to the root, which did in update_load_avg().

But the current code will break when encountering a on_list cfs_rq,
can't propagate up to the root cfs_rq, that also mismatch with the
comment of propagate_entity_cfs_rq(), which says "Propagate the changes
of the sched_entity across the tg tree to make it visible to the root".

The second problem is that it won't update_load_avg() for throttled
cfs_rq, cause the load changes can't be propagated upwards.

    A
    |
    B  --> throttled cfs_rq
   /
  C

The prop_runnable_sum of C won't be propagated to B, so won't be
propagated to A.

Fixes: 0258bdfaff5b ("sched/fair: Fix unfairness caused by missing load decay")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 906b2c7c48d1..c6da204f3068 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11267,14 +11267,8 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 
-		if (!cfs_rq_throttled(cfs_rq)){
-			update_load_avg(cfs_rq, se, UPDATE_TG);
-			list_add_leaf_cfs_rq(cfs_rq);
-			continue;
-		}
-
-		if (list_add_leaf_cfs_rq(cfs_rq))
-			break;
+		update_load_avg(cfs_rq, se, UPDATE_TG);
+		list_add_leaf_cfs_rq(cfs_rq);
 	}
 }
 #else
-- 
2.36.1

