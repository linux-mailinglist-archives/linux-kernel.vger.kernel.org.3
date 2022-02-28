Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EEF4C6F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbiB1ORD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbiB1ORB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:17:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F1497E598
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646057781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uTY2Fiqoq+77FMz0RxZmNB2TyxpIxrrHnBeosv2dWAE=;
        b=LyA5RD+qBaMHM7p6SBTEjczGjRDSfG7wQNdcWjrVec30pJBApCwAn+tHxRSN6bQ+yhn9Xo
        7AQm9YGR806lu/jQTM0f5yQUprm0Ar+xIwPvoWQEqjXZJHnKMZRZyUS1wjAk7XMWIi6h1k
        au6DzNDnS8pVdJvB40VHLut3Qb77GHY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-gJFweBVsOZGW3xUBwBKW3Q-1; Mon, 28 Feb 2022 09:16:20 -0500
X-MC-Unique: gJFweBVsOZGW3xUBwBKW3Q-1
Received: by mail-wm1-f71.google.com with SMTP id m21-20020a7bcf35000000b00380e364b5d2so6162545wmg.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:16:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uTY2Fiqoq+77FMz0RxZmNB2TyxpIxrrHnBeosv2dWAE=;
        b=0GtjDvELcwV7uks2rX+pjFbYFqMOomdOAHIjWVlmyVW7PexS2UzaFydcYB++PVi1VT
         zQIPDvpyFwelHWTt3BCNWqZXVNd9DvwqsdEokcwFuNz2AM8/bxBTXShpqDSHVt/yFb5J
         f50maBvAZ1ILITUSmslEHu5hHMpTm4aDYsDxmIOMXqG07W2+ebUyz2xZ3USlzcegdy2o
         oY4SZRaIAO9Kuw/QOZpnWV7N3LE2Zk6pBzGiFhEq5imMx1tMG044Hz4Y5TC9O2WfvutF
         USfbGHyZXHnpkwRA8mcq3g9H1xN7YDYjLQKZuIQzWXVf52kyVRILqrbPfBVkW561VW8J
         sjhA==
X-Gm-Message-State: AOAM531O4PxdaP1Sb4CKQzwDEB9DAUJY27ZdVGSwCSz8IEioF7HJN5SU
        WG8Vc+gillCJZNaW6H/9Krm7u+S8sTSpxqBDBQTLicc6T3EtClJxXHie/qLAf+fVnT+d0tA733s
        DNaK+zE21ipE7v1xvHdxusDVu
X-Received: by 2002:adf:8bd4:0:b0:1ed:c1f8:3473 with SMTP id w20-20020adf8bd4000000b001edc1f83473mr16832475wra.435.1646057779277;
        Mon, 28 Feb 2022 06:16:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzW/qVDovOdFss0cTZ0xO90apmf6fPcN1VUOx+bYPfpTUVJBXDpDMb9zAjylj0kCXmhlJN61g==
X-Received: by 2002:adf:8bd4:0:b0:1ed:c1f8:3473 with SMTP id w20-20020adf8bd4000000b001edc1f83473mr16832459wra.435.1646057779120;
        Mon, 28 Feb 2022 06:16:19 -0800 (PST)
Received: from vian.redhat.com ([2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05600c3caa00b00380deeaae72sm17374wmb.1.2022.02.28.06.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 06:16:18 -0800 (PST)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     mingo@redhat.com, peterz@infradead.org, frederic@kernel.org,
        rostedt@goodmis.org
Cc:     tglx@linutronix.de, mtosatti@redhat.com, bristot@redhat.com,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [RESEND PATCH 2/2] tracing: Avoid isolated CPUs when queueing fsnotify irqwork
Date:   Mon, 28 Feb 2022 15:15:51 +0100
Message-Id: <20220228141550.260119-2-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228141550.260119-1-nsaenzju@redhat.com>
References: <20220228141550.260119-1-nsaenzju@redhat.com>
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

Ftrace's fsnotify irq_work doesn't need to be run locally, so avoid
doing so when the CPU is isolated.

Note that this is especially bad when tracing an isolated CPU, as the
noise from running the irq_work might be bigger than what was actually
meant to be traced.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 kernel/trace/trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7c85ce9ffdc3..2a3b969708a7 100644
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
@@ -1724,7 +1725,7 @@ void latency_fsnotify(struct trace_array *tr)
 	 * possible that we are called from __schedule() or do_idle(), which
 	 * could cause a deadlock.
 	 */
-	irq_work_queue(&tr->fsnotify_irqwork);
+	irq_work_queue_on(&tr->fsnotify_irqwork, housekeeping_any_cpu(HK_FLAG_MISC));
 }
 
 #elif defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)	\
-- 
2.35.1

