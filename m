Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFC0525CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377942AbiEMHxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377939AbiEMHxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:53:34 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 369619B186
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 00:53:30 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 3FC631E80C96;
        Fri, 13 May 2022 15:47:47 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1B9KQIwIbOZ6; Fri, 13 May 2022 15:47:44 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id F2E341E80C93;
        Fri, 13 May 2022 15:47:43 +0800 (CST)
From:   liqiong <liqiong@nfschina.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, hukun@nfschina.com,
        qixu@nfschina.com, yuzhe@nfschina.com, renyu@nfschina.com,
        liqiong <liqiong@nfschina.com>
Subject: [PATCH] kernel/trace: cleanup code, remove init "char *name"
Date:   Fri, 13 May 2022 15:52:21 +0800
Message-Id: <20220513075221.26275-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer is assigned to "type->name" anyway. no need to
initialize with "preemption".

Signed-off-by: liqiong <liqiong@nfschina.com>
---
 kernel/trace/trace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 64649990a66a..d511581cfafd 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4273,9 +4273,7 @@ print_trace_header(struct seq_file *m, struct trace_iterator *iter)
 	struct tracer *type = iter->trace;
 	unsigned long entries;
 	unsigned long total;
-	const char *name = "preemption";
-
-	name = type->name;
+	const char *name = type->name;
 
 	get_total_entries(buf, &total, &entries);
 
-- 
2.25.1

