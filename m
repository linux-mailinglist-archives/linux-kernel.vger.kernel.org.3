Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EBD53B1C5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 04:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiFBCYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 22:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiFBCYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 22:24:13 -0400
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA73A70345
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 19:24:12 -0700 (PDT)
Received: by mail-pj1-f67.google.com with SMTP id gd1so3683545pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 19:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b52PV6mrU9o8+FvC9yaWVqERZDe2RTNVemxHy3gfmCE=;
        b=5MDn1eOEMgwIu6la4sQGzDw3UYJAuL+N0Tz8/a+a7g0ibJGAaSdpViFj0jWn33OmQq
         lyQf5gxrcczZsXVCrB6nemOmR6Op5+FhCTLSOdf1aPg8IyJlgCoBDp6yUW911PS5V2rU
         IYgXVa6QoeLMh9SsyNfHL9VlKtmMADb7PK9aKgJMV6AkTdrInq35WOZDR1XKMCU7T5ck
         lGRCZyVekl8GNBJyivfHEstuG5i8b4RdINQce8VTJmTi1Usmcd3PvvVBK2ZG/De+QTeD
         PfF3tKSE5Bx31OHrCPhKcl8WDtc8A+dO9vIqAfZceb+MiVfjIoBhVYMnpPrgkUJtJF3C
         0Few==
X-Gm-Message-State: AOAM532cjhwMayVkXoHuTDmbnOVvnGHwHqaxeVnDKSkoBYgzotNO0f3h
        pYD/SzGrbEOS2zmDpc85TA==
X-Google-Smtp-Source: ABdhPJxQppTvO4MMY1mRzCUBrJ6+UIYur/6bstk+DaSJO7cuoS6Zax8OiaUpTUeokBLuvJzuxLkh0A==
X-Received: by 2002:a17:902:ce87:b0:163:fc5e:398b with SMTP id f7-20020a170902ce8700b00163fc5e398bmr2392123plg.125.1654136652207;
        Wed, 01 Jun 2022 19:24:12 -0700 (PDT)
Received: from localhost.localdomain (ns1003916.ip-51-81-154.us. [51.81.154.37])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b001621a66b318sm2303787plg.130.2022.06.01.19.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 19:24:11 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     rostedt@goodmis.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, sunliming@kylinos.cn,
        kelulanainsley@gmail.com
Subject: [PATCH] tracing: Simplify conditional compilation code in tracing_set_tracer()
Date:   Thu,  2 Jun 2022 10:24:04 +0800
Message-Id: <20220602022404.508144-1-sunliming@kylinos.cn>
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

Two conditional compilation directives "#ifdef CONFIG_TRACER_SNAPSHOT"
are used consecutively, and no other code in between. Simplify conditional
the compilation code and only use one "#ifdef CONFIG_TRACER_SNAPSHOT".

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

