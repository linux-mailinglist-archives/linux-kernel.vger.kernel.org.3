Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AFA5A1C1E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244100AbiHYWTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243933AbiHYWTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:19:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21932C0E60
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:19:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9F60B82B29
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 22:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA4CC433D6;
        Thu, 25 Aug 2022 22:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661465948;
        bh=ea9EgdnqEW7WsDo1Ihdc0Otqc3WndDziUCFn40MAu90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VBKVn2XMtf/CzHWHfZVYssxrd30EQLlJRypsYKBgDsBC4uoDXgEQRRwQqUJtcP74j
         ZPLZ2AoO6xjvfoMIp2h/NZ3316PoT8X0gzOogXr0KnA91dADNGVnTy+zRraT10M6w1
         HSKfDHeXfuvRODVLSF2CIHv18HQI03SlvGdf+kf2dDhOeGlz4iT3k+zLDNVeOtbzJp
         BSvNFyqGzDwIHoA3w1CMtQDpeKCTEl0AlGtVkIF/+z6ppx1vzKgIHclBV78s7AP30V
         VWtFZi9QZBChHImcGFbjfOoswnLHti3GCjfhBd2XJ14eetHd3pcasTmOLSHDghKXvX
         0nYVG7m/v07MA==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] tracing: Allow multiple hitcount values in histograms
Date:   Thu, 25 Aug 2022 17:19:01 -0500
Message-Id: <2b0a73549f8fb4115c06639c75a4b7abd7825aaa.1661464992.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1661464992.git.zanussi@kernel.org>
References: <cover.1661464992.git.zanussi@kernel.org>
MIME-Version: 1.0
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

The hitcount is treated specially in the histograms - since it's
always expected to be there regardless of whether the user specified
anything or not, it's always added as the first histogram value.

Currently the code doesn't allow it to be added more than once as a
value, which is inconsistent with all the other possible values.  It
would seem to be a pointless thing to want to do, but other features
being added such as percent and graph modifiers don't work properly
with the current hitcount restrictions.

Fix this by allowing multiple hitcounts to be added.

Signed -off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_hist.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 92fbd72b6408..8f858e0bdaf3 100644
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
+	unsigned int i, j = 1, n_hitcount;
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
-- 
2.34.1

