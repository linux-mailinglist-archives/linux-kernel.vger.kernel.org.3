Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE3151EEED
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 18:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbiEHQWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 12:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbiEHQWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 12:22:49 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DEBC3F
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 09:18:59 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c9so11102466plh.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 09:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QWhBNZogHnlvklmcU4nt0RMjAacSV4GHQXRxhMD3Rlo=;
        b=pZqYl9oApiyD69ykUKFSXDUrectgXO2RIH+N2EDpEVnmkQRU9LlGQX//uCvUD7Kmhu
         8CJDHcK4IvpPlBArsCKeTKkW+YPVJhlSjrZBLHJ3bIPcePRep2hyVsnjfpODBmGeexNw
         bJLU69fGwpVWJU1ynYkA6ibtP7WCO8ynyKfZXxHpEDq6znFA6P0/H8HoGLui2Im/uDn4
         5IAF81xo7qWbK8aaJMizfybHv5B546fURyOzAXSEZ9UI+J3St2xC/r0YVUwPuK70fmOX
         JhIGf4n50Rrdh8tB+7UvbXSsqRk9zAGpKaICajsd//gY5mFJ79x+V6HYNrSSHLCG4rDw
         2Cbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QWhBNZogHnlvklmcU4nt0RMjAacSV4GHQXRxhMD3Rlo=;
        b=B9t298alOoEutFD+1eC8+n/5iRlUC5V9F+zGRD5UJNBGkK4MgB52GpJAAfAxA2iIJM
         C7YrvQHYg+mgAbLa693onhn+3//4esn26G7QLo+IkAilE4XqBSxWdKxwvvhvJWuQr8Dh
         iZbV0BKmSSRYujX07riQFpMj3qudH48QYZdYVtoJYuvP4GJBQL2RS/oBTjRTLHeX7NbY
         a96yo0lg5wCX+G5Niet5XYkwQLarXwZzyqJZwxp7xjkk34c8SMG3K8qwbsk/mXISbXqp
         1AwAY8NlU0mztpQ3+2+w+SX7hJCLTnjaFrkpNFmkT2ONk/GAYVEZ4sog/tlV3R/xGdyC
         Ur7A==
X-Gm-Message-State: AOAM533mAhgFyQMMaMrBIcYhDznHuSqNHJrBrkIrXF33eaozYdnzvIRM
        HKEdw+9SMK1DQa1wnZIWHL8=
X-Google-Smtp-Source: ABdhPJxjksflt8YPBPBXZnb+99bTJxcM/VykyLiI9A347MMsKrAaLOA1VhPRDJMVt2b2dGWqMDJbfw==
X-Received: by 2002:a17:90b:2311:b0:1d9:277e:edad with SMTP id mt17-20020a17090b231100b001d9277eedadmr14136254pjb.190.1652026738706;
        Sun, 08 May 2022 09:18:58 -0700 (PDT)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id d15-20020a170902b70f00b0015ea0a679ddsm5320291pls.251.2022.05.08.09.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 09:18:58 -0700 (PDT)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH] tracing: Fix possible crash in ftrace_free_ftrace_ops()
Date:   Mon,  9 May 2022 00:18:27 +0800
Message-Id: <20220508161827.1014186-1-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Currently if the ftrace_allocate_ftrace_ops() return -ENOMEM,
the ftrace_free_ftrace_ops() will kfree(NULL).
 
trace_array_create()
{
	...
	if (ftrace_allocate_ftrace_ops(tr) < 0)
		goto out_free_tr;
	...
out_free_tr:
        ftrace_free_ftrace_ops(tr);
	...
}

ftrace_allocate_ftrace_ops()
{
	...
	ops = kzalloc(sizeof(*ops), GFP_KERNEL);
        if (!ops)
                return -ENOMEM;
	...
}

ftrace_free_ftrace_ops()
{
        kfree(tr->ops);
        tr->ops = NULL;
}

Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
---
 kernel/trace/trace_functions.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 9f1bfbe105e8..d186d6101695 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -73,6 +73,9 @@ int ftrace_allocate_ftrace_ops(struct trace_array *tr)
 
 void ftrace_free_ftrace_ops(struct trace_array *tr)
 {
+	if (!tr->ops)
+		return;
+
 	kfree(tr->ops);
 	tr->ops = NULL;
 }
-- 
2.25.1

