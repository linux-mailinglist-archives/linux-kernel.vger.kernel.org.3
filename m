Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D604EB1EA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239725AbiC2Qlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239713AbiC2Qlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:41:40 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BE7D3AD2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:39:53 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id u22so16370849pfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P1ZWeHzJnJATMrQxuRDR3Jq6LHpaaLa4xZY7ozAuw8U=;
        b=kSkXfnnRRg5oFbaP7RN9L1XFHs2Sz/aWI0DBYfHoFqsV1utVvyfaL46AQPZLzpec1n
         FUQBezhhSO5O2ED/ZXYoiDdg4Ud6gK0Al8ZJZG4LPhV2W4mcfmx0Nro8e61W8AjQzKff
         P7TwDTJLCmVbu7xriviKFBa0iIS808Njr8uBuLoJRI0xNi9sjT0ozXAp8krrLAfxyzZw
         /I8ykbVYwHFWf8u2iaKPnfPew2fAlghM6GS2Oq/ez1n2XXEn7Sh2E9MVyp39f7qut5xD
         tXVHlE6O9/NfHC9cdXjsIkgPaYRCSj33IdJScQmkWuZGW1ADa8ElW1viopEDGGkw/Gcf
         /bTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P1ZWeHzJnJATMrQxuRDR3Jq6LHpaaLa4xZY7ozAuw8U=;
        b=wdEs49Wh1cqkxXAGwcjVxZfdprtP8fq6pd8VWEWzP0JJiZh1hLaSUPDNFg+iuUq7Od
         LvW+u1X335dq+yoiE1Yrp3Yxp+Ped4YlOT+yRQhh4D66NCWo/u1rAyBt537E+kdPFhIk
         KFCkRhFDU3AW6W6tQASDY09oeQRHgv6QmgpYH2XLkhYN4VDk8E7A1DEHDqjNSSUurPGN
         gn+YIbFYMCLTKSM28JJ9wkMBAmYEjIBKq/owT1YnaTTFYnb4EtIC1TTkCBmgBDohReKa
         Ws9lHErL2h9ULRY4cETjP+84t1bP8fKbxE0yNUKnec57THw/wfMOlCLtMH450ZzZvjIw
         +Z3g==
X-Gm-Message-State: AOAM531PKgeTyUpj3tJYoa+Q2jbiiu16Na2WWEMjtLRW0jw42rvAHewI
        y3jV8rMCl60qs6X2pC1WvGZfMHjUoh0=
X-Google-Smtp-Source: ABdhPJxgPG8ZULgHaXmLYMZIxDi6H3LNsd06CyRRjKkfsEvZI6FOkx6fCztbKC0rW2FINrHd0JS/xQ==
X-Received: by 2002:a65:43c8:0:b0:378:7add:ec4c with SMTP id n8-20020a6543c8000000b003787addec4cmr2559099pgp.570.1648571993064;
        Tue, 29 Mar 2022 09:39:53 -0700 (PDT)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090a178700b001c97d3614e5sm3382093pja.33.2022.03.29.09.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 09:39:52 -0700 (PDT)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH 1/3] tracing: make tracepoint_iter_lock public
Date:   Wed, 30 Mar 2022 00:39:29 +0800
Message-Id: <20220329163931.710555-2-xiehuan09@gmail.com>
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

The syscall tracepoints need tracepoint_iter_lock for the tp_printk work.

Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
---
 kernel/trace/trace.c | 2 +-
 kernel/trace/trace.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index eaf7d30ca6f1..867f00473f9f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2833,7 +2833,7 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
 }
 EXPORT_SYMBOL_GPL(trace_event_buffer_lock_reserve);
 
-static DEFINE_SPINLOCK(tracepoint_iter_lock);
+DEFINE_SPINLOCK(tracepoint_iter_lock);
 static DEFINE_MUTEX(tracepoint_printk_mutex);
 
 static void output_printk(struct trace_event_buffer *fbuffer)
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 0f5e22238cd2..7ce345699ac2 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1523,6 +1523,7 @@ static inline void *event_file_data(struct file *filp)
 
 extern struct mutex event_mutex;
 extern struct list_head ftrace_events;
+extern spinlock_t tracepoint_iter_lock;
 
 extern const struct file_operations event_trigger_fops;
 extern const struct file_operations event_hist_fops;
-- 
2.25.1

