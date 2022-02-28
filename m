Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68DC4C6F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiB1ORB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbiB1ORA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:17:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF5477E09E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646057781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=I+f/x4Y/wmVIN8Cbn3p8D0BtiZp8EWex0M/z/B6xZa0=;
        b=YC4jfEVq29HwFnVpi/cEcvNrnstRhZ5yjFwm+isMtEBAw/fbhyQA9x4l16fFJ8UdvMezTm
        XUgrPYgHU+eE0HzF8ZrD7gnPdnyYpscXzcQYvJkhJdA/mKqsRxQd5GjKjwGQ86PhD3txZI
        XLExtk5zmcC66PrT/6rXp/0csnhwkSM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-gNnIFXtCMBWGwb5FeKZ2oA-1; Mon, 28 Feb 2022 09:16:19 -0500
X-MC-Unique: gNnIFXtCMBWGwb5FeKZ2oA-1
Received: by mail-wr1-f72.google.com with SMTP id c5-20020adffb05000000b001edbbefe96dso2134049wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:16:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I+f/x4Y/wmVIN8Cbn3p8D0BtiZp8EWex0M/z/B6xZa0=;
        b=1gJMVgajykpKg2zVT0Qz037Vo7GiNrZDV998C3B3k+CVAcP+yJCjnG192qL8oF4vKd
         L9q/2E0zKvn3cOPP10ZvPgjyAr0vBbko0cXRX4yUIJQpTSZBHK8rkSlF/sb59UOatWP8
         utnhIx1XxjsYdPOJwUjxSHCMWNpmZmU0S6HnKcVdgx1lbT/M8keoPWgxXfQst/OF6igQ
         n7DyLplT0Ac6N/xKAWeK3FgMnKaSh1oToDm8J8mz9Orbv8TuEIRElmXis+OcmtL5/LRL
         1nybzIUVUV2Xr7uJE4BKgajd9hFCsIZ6IzxPpgupSlxBhX6bZx1rn3t+xE8pAqw8LpSl
         Igag==
X-Gm-Message-State: AOAM530byqcCsmC2XbRbfow/8C1v/9zL6Onq2Q+2TIgcXXZwwcDjvjX2
        lN+HmhtMzGtYNRivehgq0r3JBG8fBaG5P3MFEa2K2eLIPjirTs6nhpeAAhb3WwQsskZ9zVhDJO+
        6MKG8F1JS3y8q6Ob6id98jKFy
X-Received: by 2002:a05:600c:4fc4:b0:37c:9116:ef3d with SMTP id o4-20020a05600c4fc400b0037c9116ef3dmr13052127wmq.167.1646057778507;
        Mon, 28 Feb 2022 06:16:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysEMmE7YIz/6B/6hY52k2dU9Jx3a/q7CW8t1JrXQEhrziPCLAZoFFzKSwtjtd0+Qpu5VbG9Q==
X-Received: by 2002:a05:600c:4fc4:b0:37c:9116:ef3d with SMTP id o4-20020a05600c4fc400b0037c9116ef3dmr13052108wmq.167.1646057778301;
        Mon, 28 Feb 2022 06:16:18 -0800 (PST)
Received: from vian.redhat.com ([2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05600c3caa00b00380deeaae72sm17374wmb.1.2022.02.28.06.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 06:16:17 -0800 (PST)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     mingo@redhat.com, peterz@infradead.org, frederic@kernel.org,
        rostedt@goodmis.org
Cc:     tglx@linutronix.de, mtosatti@redhat.com, bristot@redhat.com,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [RESEND PATCH 1/2] sched/isolation: Use raw_smp_processor_id() in housekeeping_any_cpu()
Date:   Mon, 28 Feb 2022 15:15:50 +0100
Message-Id: <20220228141550.260119-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

housekeeping_any_cpu() will return a housekeeping CPU. That's it. It'll
try to optimize for NUMA locality and to use the local CPU when
possible, but it's not a requisite.

So let's use raw_smp_processor_id() instead of its vanilla counterpart
in order to allow users to query for housekeeping CPUs without having to
disable preemption.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---

NOTE: Resent as I forgot to CC the linux mailing list.

 include/linux/sched/isolation.h | 2 +-
 kernel/sched/isolation.c        | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 8c15abd67aed..0c09ff1e4599 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -31,7 +31,7 @@ extern void __init housekeeping_init(void);
 
 static inline int housekeeping_any_cpu(enum hk_type type)
 {
-	return smp_processor_id();
+	return raw_smp_processor_id();
 }
 
 static inline const struct cpumask *housekeeping_cpumask(enum hk_type type)
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index b4d10815c45a..3b8e1d47bbc0 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -43,14 +43,15 @@ int housekeeping_any_cpu(enum hk_type type)
 
 	if (static_branch_unlikely(&housekeeping_overridden)) {
 		if (housekeeping.flags & BIT(type)) {
-			cpu = sched_numa_find_closest(housekeeping.cpumasks[type], smp_processor_id());
+			cpu = sched_numa_find_closest(housekeeping.cpumasks[type],
+						      raw_smp_processor_id());
 			if (cpu < nr_cpu_ids)
 				return cpu;
 
 			return cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
 		}
 	}
-	return smp_processor_id();
+	return raw_smp_processor_id();
 }
 EXPORT_SYMBOL_GPL(housekeeping_any_cpu);
 
-- 
2.35.1

