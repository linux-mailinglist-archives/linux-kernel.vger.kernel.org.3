Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E43513E2B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347549AbiD1VzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352598AbiD1Vy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:54:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775E8340FA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 14:51:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28BEDB83079
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 21:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32C7C385BB;
        Thu, 28 Apr 2022 21:51:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nkC32-003MbM-VP;
        Thu, 28 Apr 2022 17:51:40 -0400
Message-ID: <20220428215140.807739542@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 28 Apr 2022 17:51:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jakob Koschel <jakobkoschel@gmail.com>
Subject: [for-next][PATCH 6/8] tracing: Remove usage of list iterator variable after the loop
References: <20220428215102.260147624@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakob Koschel <jakobkoschel@gmail.com>

In preparation to limit the scope of a list iterator to the list
traversal loop, use a dedicated pointer to point to the found element
[1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Link: https://lkml.kernel.org/r/20220427170734.819891-3-jakobkoschel@gmail.com

Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
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
2.35.1
