Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA66750B00B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351403AbiDVGEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbiDVGE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:04:29 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2294F9F3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:01:35 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id z16so7042556pfh.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2n9bgZjee/cHocKFdQ/ER3Mjblog3S/SvSNshrOwXL8=;
        b=Q4rveyWTprPFmV5y3aqOmjdwFc70/+XQUE+lN+A6ZQSFib83/24eDeDm1JmH7ug2sz
         VEP6UOw+qBu9DbXQpFvZ9l9GjrV4elnCDhBT4YBA0DG83u/xHd4toJpAWxlvGimU9GMn
         M8mRzuk7YdVVQM0oPjszFaoGR6Dmw9XyyxeNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2n9bgZjee/cHocKFdQ/ER3Mjblog3S/SvSNshrOwXL8=;
        b=vtCqGPJrX9W82QergvpjFgGvF6MpMSLXOvv96G3TggMP5TqtCjU9d2tFj9A+Y3bE+D
         m3BVAwX0q2Lln6ZF7yt9h+y1sZBz6cI76XnkR5Q98OyE4K6DhFSwRcF+T3gb0klxXh49
         gJepBn+iV4XyeXMbeWspnBPxyrPijJZGz7M+mn5LE39WkQDN6wNNla4xGjIHH7Z2j9U/
         ML9FOwZvF8OmUPDnybJFtq5Vam/V2DBUSlLLstsvV1LIrojgXYMnuu0z7snCMMdLgwu8
         IulCticx55Ko9n3AlNso+AbZ9HlCSTB4oahHvkJPEqM11Se3LX/JquhJEimEwww75z1/
         mDkA==
X-Gm-Message-State: AOAM531ngnqX7tQyWIqxoa7TwxWIQhs3FV6vZ+1UNY5Cw6ut9ICEEdjh
        HGBbZnY27gxVHvloAYYKW8QQrIrS/Mbw5A==
X-Google-Smtp-Source: ABdhPJz1+Q5wZTCWBaxgzl66qEogbRIwuuWuXVJsIr6DWmG73SkFu/fbplrM8MupI+k5jZzPVCkk4A==
X-Received: by 2002:a05:6a00:4007:b0:50a:686b:5e03 with SMTP id by7-20020a056a00400700b0050a686b5e03mr3170039pfb.7.1650607295130;
        Thu, 21 Apr 2022 23:01:35 -0700 (PDT)
Received: from saltlake.i.sslab.ics.keio.ac.jp (sslab-relay.ics.keio.ac.jp. [131.113.126.173])
        by smtp.gmail.com with ESMTPSA id jp20-20020a17090ae45400b001cd4989fecasm4643556pjb.22.2022.04.21.23.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 23:01:34 -0700 (PDT)
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Cc:     mhiramat@kernel.org, keitasuzuki.park@sslab.ics.keio.ac.jp,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: Fix potential double free in create_var_ref()
Date:   Fri, 22 Apr 2022 06:00:25 +0000
Message-Id: <20220422060025.1436075-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In create_var_ref(), init_var_ref() is called to initialize the fields
of variable ref_field, which is allocated in the previous function call
to create_hist_field(). Function init_var_ref() allocates the
corresponding fields such as ref_field->system, but frees these fields
when the function encounters an error. The caller later calls
destroy_hist_field() to conduct error handling, which frees the fields
and the variable itself. This results in double free of the fields which
are already freed in the previous function.

Fix this by storing NULL to the corresponding fields when they are freed
in init_var_ref().

Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
---
 kernel/trace/trace_events_hist.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 44db5ba9cabb..a0e41906d9ce 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2093,8 +2093,11 @@ static int init_var_ref(struct hist_field *ref_field,
 	return err;
  free:
 	kfree(ref_field->system);
+	ref_field->system = NULL;
 	kfree(ref_field->event_name);
+	ref_field->event_name = NULL;
 	kfree(ref_field->name);
+	ref_field->name = NULL;
 
 	goto out;
 }
-- 
2.25.1

