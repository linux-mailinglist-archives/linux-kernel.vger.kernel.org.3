Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D3F57EC60
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 08:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbiGWGu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 02:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiGWGuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 02:50:54 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A01C13D6B;
        Fri, 22 Jul 2022 23:50:54 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id h132so6054215pgc.10;
        Fri, 22 Jul 2022 23:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l4v2aTXl+r94Ki5y9Nv214lrHlci7yaq8A50wnapFyk=;
        b=Dvdhx8UljOWjIsY44+KN6OsLtG2OzMZXA7pqI/HIi3BILWVLBYWjLEr/7aA6UgJjkA
         gLPsYL2ZV1PtfiB2ft2cGgMCSxWPL1AYzW3ZmbzqslcrdyFZZSr3RwZ+ocFGJ5wP0kBR
         iTqp/fn0nS157VoIGSR4PmFEKG+y0qJbhoHY4gBMST8zwgQy9+vqZe4kiOluyqz7WRaw
         RCpcr0XJXe6BzXGXReB2kDDoAR/b65Esbe5s5r+y1rd1KlaUEjygVIVpfC/m2xAP8TjB
         //UM5BgJy1PcMqq7k39/7Q24Z6DI9zzOEgVRvoK6gSWFewYBK2rSdVJ4RWLgfH41xXjN
         PC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l4v2aTXl+r94Ki5y9Nv214lrHlci7yaq8A50wnapFyk=;
        b=wNW1fqIXFZCoS7A568bbrhbDFvCCQdj+06F0rz9RYxFTj043btaD2ZBPONERJgHv7i
         hSgAC5qk7aqUnMmelPAOmDRvXDMZCcO9FhdEgT5YwfmYvHa+VDBO0wGao/lK9drfOc2s
         xYRJZmhQPjI839XVFWaFQB9xdvOUUiZOP135nwQB2+8ebeSyMvzMKkcB81xbAt8U4u3I
         fZHxZJNHcbvjzyi7APg/FXJufKJFJ/ZONtuIJ9I3Byz9YV3gKynPpEFjguSJCxeJUq0Y
         tUnmQ82du16iCW4IKOX4apZ+bt7T/IkXGwF7piOzHmohdPfjqRx4sVgKT63l1BgFK6m/
         Mjww==
X-Gm-Message-State: AJIora+jSMgVxCHXjC80URIk3YX+JX+1w5dyGTYFvxHlBshkqm90D+EZ
        QUI5FMq3eOqCqey66xWsd2964LavkEsOAned
X-Google-Smtp-Source: AGRyM1smyiraAp99/2Uve2lT1ax5Hmd3rJU7SccvhCwhq1GtJhrzbqETu18W+0hvYtXvuqFN0IgmLw==
X-Received: by 2002:a65:6811:0:b0:415:b0c1:9dc3 with SMTP id l17-20020a656811000000b00415b0c19dc3mr2787877pgt.405.1658559053279;
        Fri, 22 Jul 2022 23:50:53 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:4bc1:46f0:2d64:481f:8207:d0c6])
        by smtp.gmail.com with ESMTPSA id f26-20020a631f1a000000b00415320bc31dsm4426375pgf.32.2022.07.22.23.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 23:50:52 -0700 (PDT)
From:   Anand Je Saipureddy <s.anandje1@gmail.com>
To:     linux-rt-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, cminyard@mvista.com,
        psiddaiah@mvista.com, Anand Je Saipureddy <s.anandje1@gmail.com>
Subject: [PATCH] ftrace: Fix improper usage of __trace_stack() function.
Date:   Sat, 23 Jul 2022 12:19:43 +0530
Message-Id: <20220723064943.16532-1-s.anandje1@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel/trace/trace_events_trigger.c --> stacktrace_trigger() -->
__trace_stack() is not defined as per the function definition.

With commit edbaaa13a660
("tracing: Merge irqflags + preemt counter, add RT bits")
the irqflags(flags) and preemption counter(preempt_count()) are
now should be evaluated early by tracing_gen_ctx().

This patch replaces the irqflags and preemption counter
with tracing_gen_ctx().

Fixes: 5e8446e3820c ("tracing: Dump stacktrace trigger to the corresponding instance")
Signed-off-by: Anand Je Saipureddy <s.anandje1@gmail.com>
Reviewed-by: Corey Minyard <cminyard@mvista.com>
---
 kernel/trace/trace_events_trigger.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 75fef9fcfd0f..3c6229f16e81 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1220,12 +1220,10 @@ stacktrace_trigger(struct event_trigger_data *data, void *rec,
 		   struct ring_buffer_event *event)
 {
 	struct trace_event_file *file = data->private_data;
-	unsigned long flags;
 
-	if (file) {
-		local_save_flags(flags);
-		__trace_stack(file->tr, STACK_SKIP, preempt_count());
-	} else
+	if (file)
+		__trace_stack(file->tr, tracing_gen_ctx(), STACK_SKIP);
+	else
 		trace_dump_stack(STACK_SKIP);
 }
 
-- 
2.25.1
This patch is applicable only for linux-stable-rt kernel of branch
v5.10-rt
