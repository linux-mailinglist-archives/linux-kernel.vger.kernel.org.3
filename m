Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB8A4C8AC7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 12:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbiCALby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 06:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbiCALbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:31:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3193747387
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 03:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646134269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FhZIq0cUe7PI3nHZJuPT6uvJTfMSZT0a6B5JQEBbb6w=;
        b=guVujwRPacsayKhm0hPhg40pB43M+WqWLUQEOn9VpUo/jpkL6Zqf6Jmo7rRuqVOsLnId0C
        sYHHHW2eTpfyw26gQykWKiLy9UThIbi/vwYhl9yF5bvb/Zc9Dywlv0jgGS2Eh1qqTlSMB2
        TjZPfCy2S6fhshTbp4n1JEcptQLrzUQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-gKA1UPrDMgyrB3qruPRrrQ-1; Tue, 01 Mar 2022 06:31:08 -0500
X-MC-Unique: gKA1UPrDMgyrB3qruPRrrQ-1
Received: by mail-wr1-f69.google.com with SMTP id f11-20020a5d664b000000b001ef8a2c2e1fso1964616wrw.15
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 03:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FhZIq0cUe7PI3nHZJuPT6uvJTfMSZT0a6B5JQEBbb6w=;
        b=dn47UXUwKmwHP5RlB+HamzOfBA3VQIWnJRdzHlgsv5niE5UMcU46jrfO0utaIL58R/
         YMihLB8sjRF6QlnGErRw1DiPGK4qxFrzeocUAQPN+99S2E71kdNLAyxCF5k09Oybos2+
         Tb40lo08bTm0y0sCiEUfCwcidN+GYVsog9+go5nwgX9BGeT7Q7ZO+OREil1uuLRqjVLt
         UZs0vyzRl6g0j0c5f454/7Lzp7vFXNq2r+K4f3q5H6tCi/+Jp2W2OpAE0rSYKJampkNT
         kx9zxvzqLSnwy6zTw+hF/tjZnzMQCveBVQJ8Jt3iA2SQUeSWwhi+cAoShqyO6GWKav1R
         pcnQ==
X-Gm-Message-State: AOAM533r7JgdLP8wxQuW2C8xY68EKIgqEdkEzYbela2NuXCkhS6D+L6t
        gkYlyArvyToE+MVN4y4ZAhjYs0GxNlQKfIMzbivig4g8hnVLGsMaDDDpRjuGiwmLtwBAzvto5KW
        r4njHjQ5kjzw9N6trHs9fCvIp
X-Received: by 2002:a05:600c:1552:b0:381:c7ac:84b1 with SMTP id f18-20020a05600c155200b00381c7ac84b1mr1502885wmg.77.1646134267162;
        Tue, 01 Mar 2022 03:31:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxk0z3Pv6z2c6ioiWELKws6oQKlsEAm4niMEjqa/O7ULG8M+QFqH2yF1wTn6iJl4y1zzvlGuw==
X-Received: by 2002:a05:600c:1552:b0:381:c7ac:84b1 with SMTP id f18-20020a05600c155200b00381c7ac84b1mr1502870wmg.77.1646134266915;
        Tue, 01 Mar 2022 03:31:06 -0800 (PST)
Received: from vian.redhat.com ([2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8])
        by smtp.gmail.com with ESMTPSA id l6-20020adfa386000000b001ede14dcd74sm13609131wrb.104.2022.03.01.03.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 03:31:06 -0800 (PST)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     mingo@redhat.com, peterz@infradead.org, frederic@kernel.org,
        rostedt@goodmis.org
Cc:     tglx@linutronix.de, mtosatti@redhat.com, bristot@redhat.com,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH v2 1/2] sched/isolation: use raw_smp_processor_id() in housekeeping_any_cpu()
Date:   Tue,  1 Mar 2022 12:30:52 +0100
Message-Id: <20220301113053.141514-1-nsaenzju@redhat.com>
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
try to optimize for NUMA locality and to use the local CPU, but it's not
a requisite.

So let's use raw_smp_processor_id() instead of its vanilla counterpart
in order to allow users to query for housekeeping CPUs without having to
disable preemption.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 include/linux/sched/isolation.h | 2 +-
 kernel/sched/isolation.c        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

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
index b4d10815c45a..c2c1f6d8bb5f 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -43,14 +43,14 @@ int housekeeping_any_cpu(enum hk_type type)
 
 	if (static_branch_unlikely(&housekeeping_overridden)) {
 		if (housekeeping.flags & BIT(type)) {
-			cpu = sched_numa_find_closest(housekeeping.cpumasks[type], smp_processor_id());
+			cpu = sched_numa_find_closest(housekeeping.cpumasks[type], raw_smp_processor_id());
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

