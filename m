Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0230E51957F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 04:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344046AbiEDCfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 22:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiEDCfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 22:35:45 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D1115FC4
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 19:32:11 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 7so59326pga.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 19:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ct+kTpdK+KwuUAxZJZaOszqpOqe143sz8PmvWd444N0=;
        b=TgUE2ij8XbXpSw46iL47THJ2ZdaS1FVWXiO3IK0v2rGlxGlgC4MGLoFlHXssY+uCBJ
         mnfwNLcwvC7MTwRYvZxWXkBVfbTN88ZF7W3oXRI/sXtbSwbsGFOOBVF7zh4gElW1FByK
         og6/yPbLTtK4f6NevxJPhLn67ilyzyitJhCsRlbLAhKAd26HE49AeD94l45PBM3PVG81
         IzuobFwai+pfWZ71mLhnzphELOSJml9HajLnLaxgaupK/BqNpC3vpHFb+bfueRm6xdHV
         ZkfV6/FFE6Rvkz33AExzZfJF+c1/AJE6/V42LlmjpuTwv+wAVpat6CZVi4OKhGyJzyTq
         CSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ct+kTpdK+KwuUAxZJZaOszqpOqe143sz8PmvWd444N0=;
        b=pX2iu8qMqybxZLH/8oaavqCvBGixNavv6J6jegyq+gKlWmJ3KdEhb5wy4uj5hqLAyq
         h5AH2MLWAnsQ7nSo0Ds21IuhC+/TVLix3BgpaO5Rq4iDRMk5futKVP8+eVw2EAQzSgjf
         xKbGPXODpTjuBLi2k6lqPIbjRfqCSGZK4AWFxPlERiz2WtmCRWna1ipnffVT5Go49G8n
         GM1xuwsuITfZGs4UHNBjiQmFFtiboQHbNTaY8Xl8BYheutwWX/HqbJU9dhakLkK1vDtb
         44GTxUw3gu1ahwhBkN96LqHADaiR3d+ss/Y/Ka2YOUxE84S+gOaC0Y+l15Qlj1tk0RRv
         s7Dw==
X-Gm-Message-State: AOAM5319heS3MKLUgdGc7aKyTZWQLuZlj7HxjH2KXKHUPf2ZfHfUq8g+
        efEHaFcAxodq/tfmTfiYZlegUgYE96+YalCW
X-Google-Smtp-Source: ABdhPJzAItQssxQJoe6qs6wtlwxBs+6OFIrerzXkQsvX6CeXby1pmJJgLKoo1zyfyL/2j0eJEBE/7A==
X-Received: by 2002:a62:d144:0:b0:50d:f07a:3eb8 with SMTP id t4-20020a62d144000000b0050df07a3eb8mr11203956pfl.25.1651631530704;
        Tue, 03 May 2022 19:32:10 -0700 (PDT)
Received: from localhost.localdomain ([125.131.156.123])
        by smtp.gmail.com with ESMTPSA id ev17-20020a17090aead100b001cb6527ca39sm2099176pjb.0.2022.05.03.19.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 19:32:10 -0700 (PDT)
From:   Wonhyuk Yang <vvghjk1234@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Wonhyuk Yang <vvghjk1234@gmail.com>,
        Baik Song An <bsahn@etri.re.kr>,
        Hong Yeon Kim <kimhy@etri.re.kr>,
        Taeung Song <taeung@reallinux.co.kr>, linuxgeek@linuxgeek.io,
        linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: Fix type of cpu in trace event
Date:   Wed,  4 May 2022 11:32:03 +0900
Message-Id: <20220504023204.598531-1-vvghjk1234@gmail.com>
X-Mailer: git-send-email 2.30.2
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

The trace event "workqueue_queue_work" use unsigned int type for
req_cpu, cpu. This casue confusing cpu number like below log.

$ cat /sys/kernel/debug/tracing/trace
cat-317  [001] ...: workqueue_queue_work: ... req_cpu=8192 cpu=4294967295

So, change unsigned type to signed type in the trace event. After
applying this patch, cpu number will be printed as -1 instead of
4294967295 as folllows.

$ cat /sys/kernel/debug/tracing/trace
cat-1338  [002] ...: workqueue_queue_work: ... req_cpu=8192 cpu=-1

Cc: Baik Song An <bsahn@etri.re.kr>
Cc: Hong Yeon Kim <kimhy@etri.re.kr>
Cc: Taeung Song <taeung@reallinux.co.kr>
Cc: linuxgeek@linuxgeek.io
Signed-off-by: Wonhyuk Yang <vvghjk1234@gmail.com>
---
 include/trace/events/workqueue.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/workqueue.h b/include/trace/events/workqueue.h
index 6154a2e72bce..262d52021c23 100644
--- a/include/trace/events/workqueue.h
+++ b/include/trace/events/workqueue.h
@@ -22,7 +22,7 @@ struct pool_workqueue;
  */
 TRACE_EVENT(workqueue_queue_work,
 
-	TP_PROTO(unsigned int req_cpu, struct pool_workqueue *pwq,
+	TP_PROTO(int req_cpu, struct pool_workqueue *pwq,
 		 struct work_struct *work),
 
 	TP_ARGS(req_cpu, pwq, work),
@@ -31,8 +31,8 @@ TRACE_EVENT(workqueue_queue_work,
 		__field( void *,	work	)
 		__field( void *,	function)
 		__string( workqueue,	pwq->wq->name)
-		__field( unsigned int,	req_cpu	)
-		__field( unsigned int,	cpu	)
+		__field( int,	req_cpu	)
+		__field( int,	cpu	)
 	),
 
 	TP_fast_assign(
@@ -43,7 +43,7 @@ TRACE_EVENT(workqueue_queue_work,
 		__entry->cpu		= pwq->pool->cpu;
 	),
 
-	TP_printk("work struct=%p function=%ps workqueue=%s req_cpu=%u cpu=%u",
+	TP_printk("work struct=%p function=%ps workqueue=%s req_cpu=%d cpu=%d",
 		  __entry->work, __entry->function, __get_str(workqueue),
 		  __entry->req_cpu, __entry->cpu)
 );
-- 
2.30.2

