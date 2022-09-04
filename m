Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28DD5AC23C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 06:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiIDEMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 00:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiIDEM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 00:12:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6994AD58
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 21:12:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 34FDBCE0AD5
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 04:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7D4C433D6;
        Sun,  4 Sep 2022 04:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662264744;
        bh=6h0q3HLOupjIluOvt0WI/JeaJ5DW/jOkFgt32sgYqnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H0kO4P5TT9M5mNvpGzXPq0MCEHF17YwCSFMnNrqbnvw+MLrxPzhNKLtIpLKVWXAiG
         v3DMvlczv2mFxnG/X6nnLfbp/zbtzpIUrve2ovXra2DAZzJeiO0gllBxGdD53IgQHy
         CUn5a+paP/+QCwBPJcdx4oJTryQhRa63NwF2Sv8TO6kIuQqQ8J+Wxs6Wj2GJ2Q4T3H
         jArrreGWNcIxhPy3vcJtWkbHWA9fnMWCgD2b/oOExJg2Zb4xjQYjZ1NwlbNk4i94Y2
         iuLqHlW4jH1fEwK4Dk+ymjUO0K6Wvjrk8Zf3jbZPdRsQbDPzl0wpXdO+kn84fgkyqC
         KomlgA9r2e51g==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/6] tracing: Allow multiple hitcount values in histograms
Date:   Sun,  4 Sep 2022 13:12:20 +0900
Message-Id: <166226474055.223837.13947085068863989044.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <166226473132.223837.9011128463174539022.stgit@devnote2>
References: <166226473132.223837.9011128463174539022.stgit@devnote2>
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

