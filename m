Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88B0468073
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 00:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354057AbhLCXgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 18:36:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46229 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240573AbhLCXgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 18:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638574398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IzaeBgyHZORzIVTDqiO0f7UEpuHJc5xhZ5iFzR8LQew=;
        b=UMbvqt3Po0KClIbV2mT2xwmx5q8I8B0o+J6SFHlVPAz6+ymAHRC2spYUuB9BGS9wOHWWUf
        SUZergySs5zWPrQQlwOQGYOYt48+WwOmXQTasfK/q0r399TjF2uP9/GGZJUs788QMKsnc8
        EFEWTFzudMdkCJvEU8NBbpSoMGhAgE0=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-dezgsiNgNOycb_9buWa9VQ-1; Fri, 03 Dec 2021 18:33:17 -0500
X-MC-Unique: dezgsiNgNOycb_9buWa9VQ-1
Received: by mail-il1-f200.google.com with SMTP id s10-20020a056e021a0a00b0029e76c20cc0so3102303ild.23
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 15:33:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IzaeBgyHZORzIVTDqiO0f7UEpuHJc5xhZ5iFzR8LQew=;
        b=R8wnjBauleGyVPlf8CwzaWrY0H8lWUZCSfuCCdkuoIWqKwZhfShBLfe+XxnY3bq29f
         x+nyyNSmfSNlpp39Tq3sJZ4XcLz/hW6N+7Fn6Xx5hEabfS8LSvXwEPTV7IZIBjlU0/mq
         yH7nc14an2pq1FqeQ2XffWhOYnB1J1o7F35LwvIV4T6iXK4sWSeLjxQWLmzw8RPNuKZv
         L8jntQTud7/z4AoZ5Ans5BTeR1tHTOWjFXeyy3uhmRqhzhtD6x/cCX22uu8aj449Wjy/
         TWbYVYZPEtYuCmUv0b61EsqtROTSjVX9FjTBxP6lgfi0UBA5x/UtqflN9nkys+UmEZld
         XM4Q==
X-Gm-Message-State: AOAM531AckJA1P7mPXRddKfWf5yvan6jLGNYxVTuB8sMTtiJ4jb3Ebg2
        8/tvsJ3vqRhC2yjjV7IEHNQhlpEWIRwEbRBY3TBXOzzV56oiQYk42xeVtC0iFBurFfLMh8EQYqu
        PeSi9mW/kKARPd0+42sZF3bah
X-Received: by 2002:a92:c26c:: with SMTP id h12mr22149376ild.179.1638574396666;
        Fri, 03 Dec 2021 15:33:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLvDF5jRLvOhuEDIMo2DJ6HiCBQl5THbAQYaDEIOv5v4rKzGyiPiHLDf9VlCU5h5HQ3nWCGw==
X-Received: by 2002:a92:c26c:: with SMTP id h12mr22149350ild.179.1638574396170;
        Fri, 03 Dec 2021 15:33:16 -0800 (PST)
Received: from halaneylaptop.redhat.com (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id h1sm2857172iow.31.2021.12.03.15.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 15:33:15 -0800 (PST)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, frederic@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH] preempt/dynamic: Fix setup_preempt_mode() return value
Date:   Fri,  3 Dec 2021 17:32:03 -0600
Message-Id: <20211203233203.133581-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__setup() callbacks expect 1 for success and 0 for failure. Correct the
usage here to reflect that.

Fixes: 826bfeb37bb4 ("preempt/dynamic: Support dynamic preempt with preempt= boot option")
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3592942ea29c..d4f60583be6e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6730,11 +6730,11 @@ static int __init setup_preempt_mode(char *str)
 	int mode = sched_dynamic_mode(str);
 	if (mode < 0) {
 		pr_warn("Dynamic Preempt: unsupported mode: %s\n", str);
-		return 1;
+		return 0;
 	}
 
 	sched_dynamic_update(mode);
-	return 0;
+	return 1;
 }
 __setup("preempt=", setup_preempt_mode);
 
-- 
2.31.1

