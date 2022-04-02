Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF224F00A3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 12:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354369AbiDBKbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 06:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354338AbiDBKb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:31:27 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3714660A95
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 03:29:36 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id pv16so10758656ejb.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 03:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GSFi2Vbaam24zbQ2UHEtgn0YLJt9Gjcf9TUTQdEKRhk=;
        b=RT3ohHQVa+IYDcIk8WJqgDomBq1QQX6riclTplVUZDHi8dV02q8LDm3l39dhkW4O/o
         z2fiwElJ9fWqN0Q96PntEbt/75VnI5a9ogjuHElmGC65JuEDppS1zlXjFACfuHFqToGp
         qj1m8eS6WLPvA2i++L3Cv1gXOO9gE0fCFBa+ZSmK9lqssSUUYkM9+uRqa5d6lJmKIfXI
         lpUr89uGOV9f54tEOeVJo7XweyLNbI/GOhShnAXIyAYuSB3sqYL4XKWBmu6ILMKYp8BG
         AGvb+EppPcqzGID0p+57pRmePIJZzhWk0wCxUR3Nfq9nJaBqVV5yETWp6Qg7rolKcNcC
         CUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GSFi2Vbaam24zbQ2UHEtgn0YLJt9Gjcf9TUTQdEKRhk=;
        b=PIhR5PqfitFUwxvdB/IhJSobktDXZAl2uO4IZGP2kxU9SjB2+8j7hdlotVFoh9WHXf
         qY+NYfDHaKvyE25ChtJ6UkKC8jGgpcumZUCIF8QWlfW+ROxFc+vZx+2rvmeJ0bzll7L5
         II5gyGoMKMsCidBcDocTMtI+XYZX1DE/xBAzfEGNWh67c9u0jAeRDYOZA6R2OkBn7ISp
         8LerSGFSAb9kcAwj5eHD5CMEN4nGMsT1sFH8Pjcv0s5ZVxhxx0zZ/+QJimzA7zAobpl/
         0PfbsPp8z2lLY+4nmMZ75tNa/5V9gAmR+esqvbOeA3lzjCqHe2v4cotPzZy/JIpwWH4H
         nwdg==
X-Gm-Message-State: AOAM5335TN2Ef8E33wsFPMo5QiMUPAkbN+aK1qvVqHqT5o53nkvyicNW
        OkI3NFa0TWvvz+/PJinus/U/2IhlhH0QMQ==
X-Google-Smtp-Source: ABdhPJxXnIdLxHqvoHa9rHI160qUzxGgo83hI7bj/EEvZbV3A5YeBawbosmgwLMmGTv7pThDCF55qw==
X-Received: by 2002:a17:907:86a8:b0:6db:6c1c:d9c4 with SMTP id qa40-20020a17090786a800b006db6c1cd9c4mr3187417ejc.640.1648895374738;
        Sat, 02 Apr 2022 03:29:34 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id qk32-20020a1709077fa000b006df6bb30b28sm1952187ejc.171.2022.04.02.03.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:29:34 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH v2 2/4] tracing: Remove usage of list iterator variable after the loop
Date:   Sat,  2 Apr 2022 12:28:46 +0200
Message-Id: <20220402102848.1759172-3-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220402102848.1759172-1-jakobkoschel@gmail.com>
References: <20220402102848.1759172-1-jakobkoschel@gmail.com>
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

