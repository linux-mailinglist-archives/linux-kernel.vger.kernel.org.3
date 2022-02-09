Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191234AED63
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236094AbiBII4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:56:42 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbiBII4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:56:37 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE4BC10369B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 00:56:34 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id o12so1064628qke.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 00:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZXandK+emcY9j+lknNJmYnpgD6ghtFPnYBrNZbHY5Mk=;
        b=pIAfjdpVAhfLDWMrG4eyoRHalCKigC93SJzURinIMyuKtXebHbo7CQ5M/uqpuv1J2V
         QMd85G/uFjj48hBFlU6EGtDybguIz8IafdQ1KfyR/IPR0u5rQEuh1BCY6yJrS3USlGDe
         dxJcqhVN1HxJtQZJpDDSjrNOOFUPZ6OAS4NV2gR8U8Q/Dg+gJ03ORViNPjfE+Z+xIRqQ
         siXr2oq+ciC9vl6wnFH5pWQ+ePwHS0TUw/BSXULl7L+SUY44qdWamtwEp62swhiI3zHj
         iwcsu7OTnxx/cEY35qriy/isQjN+gFruCE68vX5NKBFddRfwnLur0qyomobmrLEhsKum
         SqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZXandK+emcY9j+lknNJmYnpgD6ghtFPnYBrNZbHY5Mk=;
        b=UjQDO6Y8AGYwDZzUqf7/PPDk4WNXp0oprsZn5Tf57cZbSPZIRw9K5Mpg2dwo/MUbWs
         xpStaAZA0yNxxzO2RZyv8WBH7UvT9My+TThd8Me+e2fMFoZZXyZJX3NAD4MCjldPCqPN
         hl0bV9vTF6N2rAviVi+RT70Iq6HRz6xcmf38we/9skNMr0BnAZOEVYFjUh0W1O5EvBXS
         +dCOYOaoJoa9F/exCQiThlpZbVxckUm534eBiGOMMAiQgytJd0e4I7WHXvahi49rjQDv
         3wQlA0IIJeuEPZKTgNM0vwTNGYiXaCBQr1+etzgI6VAkNV51YDuE8cWXrMYCg1V7x6w0
         kcdg==
X-Gm-Message-State: AOAM5334+Swv/53oUhd5H/jWiYp/ggBqkaymWmNuPyG3AF/gD4rapOcO
        Xbta5NL+BcuBlHfW8zr2XbM=
X-Google-Smtp-Source: ABdhPJyqcybfIkYqyHz+e3zwbI+JWbs8XjkGw/GjKf5GoLAsKQqh1ZSUguwnesxj8TLFIR9i7InrEg==
X-Received: by 2002:a05:620a:16d3:: with SMTP id a19mr516513qkn.107.1644396971097;
        Wed, 09 Feb 2022 00:56:11 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k6sm8763048qko.68.2022.02.09.00.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 00:56:10 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     fweisbec@gmail.com
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] tick/sched: use min() to make code cleaner
Date:   Wed,  9 Feb 2022 08:56:04 +0000
Message-Id: <20220209085604.1561628-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Use min() in order to make code cleaner.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 kernel/time/tick-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index c89f50a7e690..31064f85a9fd 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -822,7 +822,7 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 		next_tmr = get_next_timer_interrupt(basejiff, basemono);
 		ts->next_timer = next_tmr;
 		/* Take the next rcu event into account */
-		next_tick = next_rcu < next_tmr ? next_rcu : next_tmr;
+		next_tick = min(next_rcu, next_tmr);
 	}
 
 	/*
-- 
2.25.1

