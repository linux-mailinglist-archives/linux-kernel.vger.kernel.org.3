Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E5C4EB1EB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239732AbiC2Qls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239731AbiC2Qlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:41:44 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047DFD76E6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:39:57 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id u22so16370937pfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zn3k0xfRpBKKjR/NQRBIXL4/yg6sQi2dLv6gXZ5xbYg=;
        b=pEBReeRd7StGioMrYnVsENfof+Dl/Hnt+YYKqKOonpvKgOta7s5pnN/GpoePEr3dzV
         iTDedOKV1C7SOsiB5fVmA4H9hQvbYlGOouzFQeSGXl279HA5AaF0E2lp/XtklfWra05y
         viszAjTq0RL1tmBCB8A+q269HbrowuGlkoeuQswxhpAtiEN8odKvWp1mYS5fkfsiJN4L
         u+7y29Uh0J2YTTllZqvZHhBS6+S/PzrM3dcjaFds8MBDg+3hn8Rt7zk4TtkU0/7axB2J
         MzE7CVWeyiYrZ6981phVUeREfpLlvBjdeX+OSCWBCPjgzTNrZtSqduuajVLdux/eGx22
         n35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zn3k0xfRpBKKjR/NQRBIXL4/yg6sQi2dLv6gXZ5xbYg=;
        b=PmyRtm9hNHo+1XjiqFAa369tQTIP8FlH0UzBpq/b5NX66xPJ7Kve681YHIEQJ/on3G
         /U2csAswglbRvp7FW632bU0cXK2cAu9bn2U8bl/2ZzsK9LVeaMLNXfXr9cYI+7Vu+vyX
         zLCwFRT8IX6gdFFSLpNc15Xjvxhx/1Ht1knm6HAnH5rau/KtQ0Njz0RkgSe2zc99o0MZ
         TWqpAL1P72QmDluaRTn9OfXwnqmWXTomQGrzMGBxlUIbLWutjPrRBN97jh4dp3DqYUF6
         pi8mzKlsjhfmhmQvgSd+xJeyoEgHgPuvPl9AhjXCCrxsSQU0FsIKUtj2KH21Zqhhj4e2
         wqPg==
X-Gm-Message-State: AOAM530Pne60mOuIjQi3q4+Igj7VKEQUtU3rWxzR77ZG6yVo9LroqsCc
        3z6DuMc7/tuors6VUQt7NU/+7HauO38=
X-Google-Smtp-Source: ABdhPJy/ExKXSXNUbWFTenDHzvqEUX2aljOKSojax93HUBO9wC6mGlok+/r5Y/5Rv0dL5iYVupU+4g==
X-Received: by 2002:a63:7804:0:b0:398:1338:86a with SMTP id t4-20020a637804000000b003981338086amr2608992pgc.575.1648571996465;
        Tue, 29 Mar 2022 09:39:56 -0700 (PDT)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090a178700b001c97d3614e5sm3382093pja.33.2022.03.29.09.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 09:39:55 -0700 (PDT)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH 2/3] tracing: make tracepoint_printk_key public
Date:   Wed, 30 Mar 2022 00:39:30 +0800
Message-Id: <20220329163931.710555-3-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329163931.710555-1-xiehuan09@gmail.com>
References: <20220329163931.710555-1-xiehuan09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syscall tracepoints need tracepoint_printk_key for the tp_printk work.

Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
---
 kernel/trace/trace.c | 2 +-
 kernel/trace/trace.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 867f00473f9f..8efee5d339b9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -88,7 +88,7 @@ void __init disable_tracing_selftest(const char *reason)
 struct trace_iterator *tracepoint_print_iter;
 int tracepoint_printk;
 static bool tracepoint_printk_stop_on_boot __initdata;
-static DEFINE_STATIC_KEY_FALSE(tracepoint_printk_key);
+DEFINE_STATIC_KEY_FALSE(tracepoint_printk_key);
 
 /* For tracers that don't implement custom flags */
 static struct tracer_opt dummy_tracer_opt[] = {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 7ce345699ac2..f44a9510209c 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1524,6 +1524,7 @@ static inline void *event_file_data(struct file *filp)
 extern struct mutex event_mutex;
 extern struct list_head ftrace_events;
 extern spinlock_t tracepoint_iter_lock;
+DECLARE_STATIC_KEY_FALSE(tracepoint_printk_key);
 
 extern const struct file_operations event_trigger_fops;
 extern const struct file_operations event_hist_fops;
-- 
2.25.1

