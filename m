Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B83511ED9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243883AbiD0RLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243845AbiD0RLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:11:30 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66C52E9FC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:08:17 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id k27so2698664edk.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZkmevGa0S+kHSd+kuDI459P4jPVZOZ4GNeicenq/YJM=;
        b=jYLpSKtFJ2fPli+qfGHE6JgCsxkugVA1nfeVHdyGex7DKh4H4AH6O/YEc1bN54OjlP
         Sri028H4WkleHLuiPln/N58jfYJrpt6T4Q3pH5917RVUrZmBu5pLMdi2k6Md8L8tkQKX
         gHi0ostP7xCfbOCrUjgIghwulOLRzxiXqXZPan0WHLCY/qY3aXIk949Q6dkeKzQ5dxdK
         7mR4kFEOsDYhj9Bf7fMMYQWNCnITj52dvvbLa/l6pUhzN6JkNvznqtSpeHv8ONhOJoaK
         V53eFpsgAcM1uTLSZCVes5G7OMvGEobipLSYhF53y0cuFTYo/bINL/qXkvQRHtdzdUqc
         v0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZkmevGa0S+kHSd+kuDI459P4jPVZOZ4GNeicenq/YJM=;
        b=x9L7KOxLkNwPw+j8elyxMZeq46QR1+OH6JzlXGSLDe8n3WR5J3gW7HAqqumPCb01YR
         m1tN3D0yYHS4gvt/U3zUrvlM3d5yn/lmsY7qwTOTPqVRr+X5HkGKwGsqKJHkEocL3ozx
         BjBRKkIYasFPyH78XS7ayclcVomR0xbD/RX3qRA69tuMng2uWHS5PELi7+QGAk7sUFf3
         dDsYXdYAkOlSheZSYAWIuJDHB42zOUgWdYSj2OC3HCDxaG+mScpmVqt+3qDsjIxuZ3wb
         zCGLkMcV0r4PNHYMbrUtmEcDsaHwsG9zWwYatgb3ilqOuduNfByArT6EuZEi+T49c+52
         4kEQ==
X-Gm-Message-State: AOAM532KK8nhlui1rhdwu+eNlj7MemRvmZh5caQENKQirPYluwTYAIoG
        fo8ZbVTeWTNMmae8EAk/x9g=
X-Google-Smtp-Source: ABdhPJxT7SgdBj/cr4MJnQt9yVWBjg9i0492QrjVRkTMxY4GFZ7Edo82tCioSiLPo/K3nL60SJyl/w==
X-Received: by 2002:a05:6402:51d0:b0:426:110e:5d05 with SMTP id r16-20020a05640251d000b00426110e5d05mr6113858edd.384.1651079296239;
        Wed, 27 Apr 2022 10:08:16 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id z3-20020a50cd03000000b00425d72fd0besm6694359edi.97.2022.04.27.10.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 10:08:15 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH v2 2/4] tracing: Remove usage of list iterator variable after the loop
Date:   Wed, 27 Apr 2022 19:07:32 +0200
Message-Id: <20220427170734.819891-3-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427170734.819891-1-jakobkoschel@gmail.com>
References: <20220427170734.819891-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to limit the scope of a list iterator to the list
traversal loop, use a dedicated pointer to point to the found element
[1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 kernel/trace/trace_events.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index e11e167b7809..e4a442060707 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1723,9 +1723,9 @@ static LIST_HEAD(event_subsystems);
 
 static int subsystem_open(struct inode *inode, struct file *filp)
 {
+	struct trace_subsystem_dir *dir = NULL, *iter_dir;
+	struct trace_array *tr = NULL, *iter_tr;
 	struct event_subsystem *system = NULL;
-	struct trace_subsystem_dir *dir = NULL; /* Initialize for gcc */
-	struct trace_array *tr;
 	int ret;
 
 	if (tracing_is_disabled())
@@ -1734,10 +1734,12 @@ static int subsystem_open(struct inode *inode, struct file *filp)
 	/* Make sure the system still exists */
 	mutex_lock(&event_mutex);
 	mutex_lock(&trace_types_lock);
-	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
-		list_for_each_entry(dir, &tr->systems, list) {
-			if (dir == inode->i_private) {
+	list_for_each_entry(iter_tr, &ftrace_trace_arrays, list) {
+		list_for_each_entry(iter_dir, &iter_tr->systems, list) {
+			if (iter_dir == inode->i_private) {
 				/* Don't open systems with no events */
+				tr = iter_tr;
+				dir = iter_dir;
 				if (dir->nr_events) {
 					__get_system_dir(dir);
 					system = dir->subsystem;
@@ -1753,9 +1755,6 @@ static int subsystem_open(struct inode *inode, struct file *filp)
 	if (!system)
 		return -ENODEV;
 
-	/* Some versions of gcc think dir can be uninitialized here */
-	WARN_ON(!dir);
-
 	/* Still need to increment the ref count of the system */
 	if (trace_array_get(tr) < 0) {
 		put_system(dir);
-- 
2.25.1

