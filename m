Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE645A3442
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 06:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbiH0EDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 00:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbiH0EDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 00:03:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0579E3986
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 21:03:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 640E561DCF
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 04:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6A7C433B5;
        Sat, 27 Aug 2022 04:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661572998;
        bh=6h0q3HLOupjIluOvt0WI/JeaJ5DW/jOkFgt32sgYqnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JQXR+kXgSYH5qk8Eg/0CnOXI94pve9FpGWIbzbjntjQXG1/nd0Jg/oFndYtQ7IArO
         xGQQvT/OVioR3pFcK0VLu6uVIhFswZaE2J4ZcFYBKEF2IN2chGjUeJZpK8mL10inSh
         1zb9GEFJFZZmr8C1bzSxCgpotUEy8wWNvPG4zr8S/KDVj2Y+iyZMLcl8zDa/b4tjtK
         80GjR6TinlPKXJXID5OizEmBJvvCl2qCxDkXRd6TWCW+HweiOUiyyxI04xraGVGYb4
         vb7ibFuJ8B5FRWr2Ss+tSdog6hwc8CO+kqNZ2J6sQ+eOUJEjB5zp4n9cOAZSqRMNXX
         gz1ciOD4wg20A==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] tracing: Allow multiple hitcount values in histograms
Date:   Sat, 27 Aug 2022 13:03:15 +0900
Message-Id: <166157299482.348924.7718303119342203371.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <166157298537.348924.2537162090505397377.stgit@devnote2>
References: <166157298537.348924.2537162090505397377.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

The hitcount is treated specially in the histograms - since it's
always expected to be there regardless of whether the user specified
anything or not, it's always added as the first histogram value.

Currently the code doesn't allow it to be added more than once as a
value, which is inconsistent with all the other possible values.  It
would seem to be a pointless thing to want to do, but other features
being added such as percent and graph modifiers don't work properly
with the current hitcount restrictions.

Fix this by allowing multiple hitcounts to be added.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>

---
 Changes in v4:
  - Initialize n_hitcount.
---
 kernel/trace/trace_events_hist.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 92fbd72b6408..e80a41e380bb 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1356,6 +1356,8 @@ static const char *hist_field_name(struct hist_field *field,
 			field_name = field->name;
 	} else if (field->flags & HIST_FIELD_FL_TIMESTAMP)
 		field_name = "common_timestamp";
+	else if (field->flags & HIST_FIELD_FL_HITCOUNT)
+		field_name = "hitcount";
 
 	if (field_name == NULL)
 		field_name = "";
@@ -2328,6 +2330,8 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 			hist_data->attrs->ts_in_usecs = true;
 	} else if (strcmp(field_name, "common_cpu") == 0)
 		*flags |= HIST_FIELD_FL_CPU;
+	else if (strcmp(field_name, "hitcount") == 0)
+		*flags |= HIST_FIELD_FL_HITCOUNT;
 	else {
 		field = trace_find_event_field(file->event_call, field_name);
 		if (!field || !field->size) {
@@ -4328,8 +4332,8 @@ static int create_var_field(struct hist_trigger_data *hist_data,
 static int create_val_fields(struct hist_trigger_data *hist_data,
 			     struct trace_event_file *file)
 {
+	unsigned int i, j = 1, n_hitcount = 0;
 	char *fields_str, *field_str;
-	unsigned int i, j = 1;
 	int ret;
 
 	ret = create_hitcount_val(hist_data);
@@ -4346,8 +4350,10 @@ static int create_val_fields(struct hist_trigger_data *hist_data,
 		if (!field_str)
 			break;
 
-		if (strcmp(field_str, "hitcount") == 0)
-			continue;
+		if (strcmp(field_str, "hitcount") == 0) {
+			if (!n_hitcount++)
+				continue;
+		}
 
 		ret = create_val_field(hist_data, j++, file, field_str);
 		if (ret)

