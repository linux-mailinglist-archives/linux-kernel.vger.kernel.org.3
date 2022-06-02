Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB8B53BA72
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbiFBOGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbiFBOGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:06:25 -0400
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D298E297520
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 07:06:23 -0700 (PDT)
Received: by mail-pg1-f196.google.com with SMTP id 7so4050047pga.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 07:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/0yiZs2/fz+30ziK+HHm729xgVYWVmyc0fVnJqz2Ud8=;
        b=hsvJEJxFWPFWQi9whOxNwwYUUGpwyteOeAyRVq9wpvJJ3bH+nJvf8dYDYDy+cIGcPA
         eKGwPDi4hjtY/WlHfGw/lq1fiXnl/cZRrkXFseJaukiCxv6Ei/YkNS2Ot0c5IVBBbBMk
         2xTNcBAV9DLx1i1md+SsAUW9opGh72vmBIZ1SUlL9pIvS1R8Q5GHUQOzvGT4R0LontKp
         +amfo7/vGCodCK440mY2NypLENDCGH5TyFuD7yfb2640/9CGUpdn+KLdt6758y8V7+jV
         dsbX7yRBe+zdx7qDJSSpf/pBo7QhMuM0MtilMoh+9U2BTFHxcoBIOHBAy+hjXv6769vh
         K0Gw==
X-Gm-Message-State: AOAM533C6fgegFZr3rDxdFMC7GXPp1o7F8Z4l9XXLEgT5P/kekA7rIV9
        C+LKbyGxzJ5h3kI0yxNdJF8vruC3bZ6p7Eg=
X-Google-Smtp-Source: ABdhPJzA7WgQqdSUUuilLorl7aIoC38YrT/RWOnrx2YNztgiFU9ONLnM0plMXgtIBNbs3WOjHhDZRg==
X-Received: by 2002:a62:798b:0:b0:51b:a8fd:a459 with SMTP id u133-20020a62798b000000b0051ba8fda459mr10719904pfc.37.1654178782842;
        Thu, 02 Jun 2022 07:06:22 -0700 (PDT)
Received: from localhost.localdomain (ns1003916.ip-51-81-154.us. [51.81.154.37])
        by smtp.gmail.com with ESMTPSA id c8-20020a170902d48800b00163be997587sm3595970plg.100.2022.06.02.07.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 07:06:22 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     rostedt@goodmis.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, sunliming@kylinos.cn,
        kelulanainsley@gmail.com
Subject: [PATCH V2] tracing: Simplify conditional compilation code in tracing_set_tracer()
Date:   Thu,  2 Jun 2022 22:06:13 +0800
Message-Id: <20220602140613.545069-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two conditional compilation directives "#ifdef CONFIG_TRACER_MAX_TRACE"
are used consecutively, and no other code in between. Simplify conditional
the compilation code and only use one "#ifdef CONFIG_TRACER_MAX_TRACE".

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 kernel/trace/trace.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f400800bc910..dc959e339512 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6430,9 +6430,7 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 		synchronize_rcu();
 		free_snapshot(tr);
 	}
-#endif
 
-#ifdef CONFIG_TRACER_MAX_TRACE
 	if (t->use_max_tr && !had_max_tr) {
 		ret = tracing_alloc_snapshot_instance(tr);
 		if (ret < 0)
-- 
2.25.1

