Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7105A4C8AC8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 12:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiCALb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 06:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbiCALbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:31:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10A0B47AC4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 03:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646134270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5HepxbpN83DIqhMjscBSIvi4DPm0dpQVM/jHxq0zEcE=;
        b=hrWYkIAeqUyH+d+wJDvemH6tgu6fceH590pWb0NW/9BqFvHtv2TIUXBGYFMBLDQGncdhn0
        RDXrZpm3Kv0nO+Dr2+8esfV0Ru1OBC/R94bvRTzjzBWd7ZkxpYJDWdOwT2xPsR5/jWpSwa
        hRJRtcbKDQul99b7VldGJpC1jeaIPyE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-HaXInFRVMQ2Bz4UfJ9xirg-1; Tue, 01 Mar 2022 06:31:09 -0500
X-MC-Unique: HaXInFRVMQ2Bz4UfJ9xirg-1
Received: by mail-wm1-f72.google.com with SMTP id p35-20020a05600c1da300b0038151176781so1064409wms.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 03:31:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5HepxbpN83DIqhMjscBSIvi4DPm0dpQVM/jHxq0zEcE=;
        b=eVOlzMQtQckEuNLzWR4MG7kIgn0Hq4hiIxHOPvYPzV4q32xKRnL0Hs7pWKYPxiFBCf
         hkcQiYd9qYuFb5uMUlFczfY9oP3C0c5HBEBOapKth8cYA35v9HA4TXRPqd8a61gCWdn+
         0KVlTlUXmH/681EGt8a/njm/aCGlceGdTnW0BBLukYy+UaU6ImrRGiLpicatibDHXeBx
         ns4EF1rE0agdzH2hFBL0BtXKbfRSHtyjEqnRqoYEXK9NWj518Q+YfQVcCFFo37MsQxyF
         3sOxm4r5ZgKKLuKU27D+U9+zZRUu/iYosypmUGqxrpZLobuBs9iOK4UmDXd+6kwJqtYG
         H4lA==
X-Gm-Message-State: AOAM531ZSeq8tmCKi9Cc8cHFvmMwQ8Jkftd9fZsDZ4s9RJMW9S9j+jBM
        XG4u/sOiIFpNWY+DAGWL69VPIfK4IIcIWYPKkMg8Ks4Fg4eMgHqOqm0HSgfR8BXN2lCL0GpKGHU
        tl/N7cBleGyX38hggGcvxENb7
X-Received: by 2002:a05:600c:35c4:b0:381:782e:9645 with SMTP id r4-20020a05600c35c400b00381782e9645mr5407323wmq.63.1646134268027;
        Tue, 01 Mar 2022 03:31:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwk0Dx3Q8cHuVfFkxp4ENLl3euwKFEBu2FIYalvl46CtUefBv2zFAewdqkEFwpSVChJLDaMgw==
X-Received: by 2002:a05:600c:35c4:b0:381:782e:9645 with SMTP id r4-20020a05600c35c400b00381782e9645mr5407305wmq.63.1646134267847;
        Tue, 01 Mar 2022 03:31:07 -0800 (PST)
Received: from vian.redhat.com ([2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8])
        by smtp.gmail.com with ESMTPSA id l6-20020adfa386000000b001ede14dcd74sm13609131wrb.104.2022.03.01.03.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 03:31:07 -0800 (PST)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     mingo@redhat.com, peterz@infradead.org, frederic@kernel.org,
        rostedt@goodmis.org
Cc:     tglx@linutronix.de, mtosatti@redhat.com, bristot@redhat.com,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH v2 2/2] tracing: Avoid isolated CPUs when queueing fsnotify irqwork
Date:   Tue,  1 Mar 2022 12:30:53 +0100
Message-Id: <20220301113053.141514-2-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301113053.141514-1-nsaenzju@redhat.com>
References: <20220301113053.141514-1-nsaenzju@redhat.com>
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

There isn't any need for this irq_work to be run locally, so avoid doing
so when the CPU is isolated.

Note that this is especially bad as queueing it into a local isolated
CPU might add noise to what was meant to be traced in the first place.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---

Changes since v1:
 - Rebase to cater for:
     04d4e665a609 ("sched/isolation: Use single feature type while
     referring to housekeeping cpumask")

 kernel/trace/trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bb2caf6aac01..250603b4eb3e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -12,6 +12,7 @@
  *  Copyright (C) 2004-2006 Ingo Molnar
  *  Copyright (C) 2004 Nadia Yvette Chambers
  */
+#include <linux/sched/isolation.h>
 #include <linux/ring_buffer.h>
 #include <generated/utsrelease.h>
 #include <linux/stacktrace.h>
@@ -1726,7 +1727,7 @@ void latency_fsnotify(struct trace_array *tr)
 	 * possible that we are called from __schedule() or do_idle(), which
 	 * could cause a deadlock.
 	 */
-	irq_work_queue(&tr->fsnotify_irqwork);
+	irq_work_queue_on(&tr->fsnotify_irqwork, housekeeping_any_cpu(HK_TYPE_MISC));
 }
 
 #elif defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)	\
-- 
2.35.1

