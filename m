Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3734C6F13
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbiB1OPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbiB1OPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:15:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9427427DA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646057670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2exk6k2NFpFhRNyzQ86mHmzJ2MpkNYTiFBpW3kB7MP4=;
        b=hd4GTx91nRAyb79hITLEObffMscAFmMwkUeHqmmjhxWQMC7FWmuFQW+lUxDdpfVGRefmDR
        IGWc+tZ9sLvE7tSpKkfpXbVj5VrNGWzh3XqRZ26NGe7hBDOP9BzSR3z3+rB76KPABTBLDh
        iPtYIHHPDEP8iTnHCK8AebGTStGDRUA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-Haln9fVGOfKsrx7ySTiH4Q-1; Mon, 28 Feb 2022 09:14:28 -0500
X-MC-Unique: Haln9fVGOfKsrx7ySTiH4Q-1
Received: by mail-wr1-f69.google.com with SMTP id k20-20020adfc714000000b001e305cd1597so2122678wrg.19
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:14:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2exk6k2NFpFhRNyzQ86mHmzJ2MpkNYTiFBpW3kB7MP4=;
        b=7AqLVPLaFEiB79uJGG6RVp61uvl6Jo+TUHFWiMUasplpD/m1GBrIZcpu4dW7C3uEml
         IwK38Fos+glk/vvaYB2mhcaiR3eeXMec7YXX39YWPZCnvI7y65vSKOVPLxs0pwlTpo8J
         geQU67MA8VlnRj0Pu0Xf7lwOxs+HaOjPmSWBHERDi6BbhZa5lIo+B8yYfe1mzLjDBTiE
         CllezR8f8bBSUBUTHF+8tdtb9mOFi6eJVpVN/3WVjNFX93gGsZvIwKmTmMqhNbokIxFJ
         6j0klSfe+tgH8Zk5m4jTrf+5gChpUkfaFmJW2gqKw3LiJ7WGLPiL5yac2T8agJCC5y5g
         +FHA==
X-Gm-Message-State: AOAM531b75Gd6Jj9FQXGGcQVeZDSXDAM52wUcLCrmxqCgtb6DEr34JW8
        gZbdUZMbnoQXoLVhjt1Wahu6pvuoeM9lMgRyex0IW2FQLbf70LsJZjx3cX5MJO/Ky3vCqEq2HYm
        ZtomU1hPVlTOkMo4RfY0Ou0Sy
X-Received: by 2002:a5d:6a87:0:b0:1ed:e3e1:e305 with SMTP id s7-20020a5d6a87000000b001ede3e1e305mr15444415wru.334.1646057667606;
        Mon, 28 Feb 2022 06:14:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSweu/vDqttlW8UujeQjHYYvx1IqL/6xa8QGq+PfI8fILt/wD4u5iEdt+ypDzwLNmxlCWi9Q==
X-Received: by 2002:a5d:6a87:0:b0:1ed:e3e1:e305 with SMTP id s7-20020a5d6a87000000b001ede3e1e305mr15444400wru.334.1646057667415;
        Mon, 28 Feb 2022 06:14:27 -0800 (PST)
Received: from vian.redhat.com ([2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c268900b00381394d74a1sm10342072wmt.9.2022.02.28.06.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 06:14:27 -0800 (PST)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     rostedt@goodmis.org, bristot@kernel.org, paulmck@kernel.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        mtosatti@redhat.com, Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH] tracing/osnoise: Force quiescent states while tracing
Date:   Mon, 28 Feb 2022 15:14:23 +0100
Message-Id: <20220228141423.259691-1-nsaenzju@redhat.com>
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

At the moment running osnoise on an isolated CPU and a PREEMPT_RCU
kernel might have the side effect of extending grace periods too much.
This will eventually entice RCU to schedule a task on the isolated CPU
to end the overly extended grace period, adding unwarranted noise to the
CPU being traced in the process.

So, check if we're the only ones running on this isolated CPU and that
we're on a PREEMPT_RCU setup. If so, let's force quiescent states in
between measurements.

Non-PREEMPT_RCU setups don't need to worry about this as osnoise main
loop's cond_resched() will go though a quiescent state for them.

Note that this same exact problem is what extended quiescent states were
created for. But adapting them to this specific use-case isn't trivial
as it'll imply reworking entry/exit and dynticks/context tracking code.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 kernel/trace/trace_osnoise.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 870a08da5b48..4928358f6e88 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -21,7 +21,9 @@
 #include <linux/uaccess.h>
 #include <linux/cpumask.h>
 #include <linux/delay.h>
+#include <linux/tick.h>
 #include <linux/sched/clock.h>
+#include <linux/sched/isolation.h>
 #include <uapi/linux/sched/types.h>
 #include <linux/sched.h>
 #include "trace.h"
@@ -1295,6 +1297,7 @@ static int run_osnoise(void)
 	struct osnoise_sample s;
 	unsigned int threshold;
 	u64 runtime, stop_in;
+	unsigned long flags;
 	u64 sum_noise = 0;
 	int hw_count = 0;
 	int ret = -1;
@@ -1386,6 +1389,22 @@ static int run_osnoise(void)
 					osnoise_stop_tracing();
 		}
 
+		/*
+		 * Check if we're the only ones running on this nohz_full CPU
+		 * and that we're on a PREEMPT_RCU setup. If so, let's fake a
+		 * QS since there is no way for RCU to know we're not making
+		 * use of it.
+		 *
+		 * Otherwise it'll be done through cond_resched().
+		 */
+		if (IS_ENABLED(CONFIG_PREEMPT_RCU) &&
+		    !housekeeping_cpu(raw_smp_processor_id(), HK_FLAG_MISC) &&
+		    tick_nohz_tick_stopped()) {
+			local_irq_save(flags);
+			rcu_momentary_dyntick_idle();
+			local_irq_restore(flags);
+		}
+
 		/*
 		 * For the non-preemptive kernel config: let threads runs, if
 		 * they so wish.
-- 
2.35.1

