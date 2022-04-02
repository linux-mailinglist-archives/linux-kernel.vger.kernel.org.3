Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9794F00B2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 12:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354425AbiDBKgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 06:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353429AbiDBKfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:35:50 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3BAFFB58
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 03:33:59 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g22so5685315edz.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 03:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GSFi2Vbaam24zbQ2UHEtgn0YLJt9Gjcf9TUTQdEKRhk=;
        b=ANo/ZBjzbJxD1fwLzVN2KY63i4HMkcnGpsETHRyILMum/mnT6bI7w7rQSLm+j/jV5h
         mUUI85lGIAF+muhNt0EFB1H1SvFpwPqgWN6MxROdPqctbENACn7gql4ZGuYxSGUJ7Ke0
         HoVWf6dS6pughzdsThZDx4RH9+xEXNeObqYHuzeyo0M1yrW8i7FZMV9/5klIgYH2KlN8
         DV841lG3axZZHoVHBMyxatjYTz9Dy/i8QobsUwqm/CRqLLrl2sJ3ntWiDmPDImRsSOd3
         js3BrqsZJ1YJ9m3E32qBe4FbNHFkgEynskq1mDln3T7ia8OadbVW45OWOPewB5DhAEq2
         VvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GSFi2Vbaam24zbQ2UHEtgn0YLJt9Gjcf9TUTQdEKRhk=;
        b=l79rA53gURhF0q1eBr359WFx4ZM/CoVEdnAq84t7U0hPnGIQ2jA3Munusegy1qbkeD
         PabMZfOXco7DEzJpEuLwGt0QBsCI0M+6ZIjsLBNw7RDuroG7dOfnZZ6ZXRz+VWkTf6gV
         /9e0F3K9S8XSVNSbYiQKB9vUw/8JpM1KTShsjDmgRTKjmdbrhHsuXWTTvSCRIPNbQA7t
         IVfpREmuxcuScKiios9SEXjv0GyYKdWIaEJ3T4PgZdpIPO1y6u/ObOZod+HBaDgil0jZ
         2HaFBDq1t2+sv5jpZU9SK+ZpidYxvy4CGgSlNVDfBp/GC7Zucj2hhpIa2xFmEPdJCIO6
         EUhQ==
X-Gm-Message-State: AOAM532JX7eyg06f4+dZpZWqdEoQjvHehJsq9kH5KGkbHdbYuTHjS3Uj
        PDyk0Wb9HG8f7MsoULsUt/8pepYsZktFZA==
X-Google-Smtp-Source: ABdhPJzz5skU9XAsb8nwsYzCfNOufYhY+mQd7sbgLahPCs9cXcMI5utFQeUaXbA/iTRfW4PrxRH1oQ==
X-Received: by 2002:a05:6402:40c9:b0:419:4b81:162e with SMTP id z9-20020a05640240c900b004194b81162emr25135170edb.380.1648895637722;
        Sat, 02 Apr 2022 03:33:57 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id ka22-20020a170907921600b006e4c1ab0bbdsm1886965ejb.207.2022.04.02.03.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:33:57 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH v2 2/4] tracing: Remove usage of list iterator variable after the loop
Date:   Sat,  2 Apr 2022 12:33:39 +0200
Message-Id: <20220402103341.1763932-3-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220402103341.1763932-1-jakobkoschel@gmail.com>
References: <20220402103341.1763932-1-jakobkoschel@gmail.com>
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

In preparation to limit the scope of a list iterator to the list
traversal loop, use a dedicated pointer to point to the found element
[1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 kernel/trace/trace_events.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index e11e167b7809..97c7eb2f55e5 100644
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
@@ -1734,14 +1734,16 @@ static int subsystem_open(struct inode *inode, struct file *filp)
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
-				if (dir->nr_events) {
+				if (iter_dir->nr_events) {
 					__get_system_dir(dir);
 					system = dir->subsystem;
 				}
+				tr = iter_tr;
+				dir = iter_dir;
 				goto exit_loop;
 			}
 		}
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

