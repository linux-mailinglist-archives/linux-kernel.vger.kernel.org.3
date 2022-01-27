Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4978349EDA8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 22:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344502AbiA0Vom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 16:44:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47490 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344490AbiA0Voj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 16:44:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D94A61B36
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 21:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22192C340E4;
        Thu, 27 Jan 2022 21:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643319878;
        bh=FZjygqRcorIfdOsGqxbFJ4YYvK2FTppWojlh7N45qsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=k5lgidlHXq4zbyC7DDUYoCpCS53/+42Bvt0N/1mNf9bi/48hfqOMGd9evo01ZB8oa
         p0KT2Ay+BfNFiPwpuou1ko4PejvwZGiwPZPtAlWEPIlAqtev+kJWAHk+HnAguijd7X
         HFZHqZz1ua/eiTPM4UJ2WKO3xvyrQoF5zMmatxjAFh8zI7LYOOfdEoav5OjsfjPSK8
         AUs8BOmDGxQ6pVkx8zPed4i3XfLqwxWmyYxBY2R2LKSVjSCc9phI0olJNHD3L3+IQj
         BSpM9HjoDX9wPKJZKamejnNJjsCo/lOpu81E+k83oX28ZVWXOUr7VupLnzpJ/jcJvt
         5TN0Mc/VzPoJg==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 7/7] tracing: Remove size restriction on synthetic event cmd error logging
Date:   Thu, 27 Jan 2022 15:44:21 -0600
Message-Id: <a291c672d6e1d7f557d9e15a5ac3f0b446e29dcd.1643319703.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1643319703.git.zanussi@kernel.org>
References: <cover.1643319703.git.zanussi@kernel.org>
In-Reply-To: <cover.1643319703.git.zanussi@kernel.org>
References: <cover.1643319703.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, synthetic event command error strings are restricted to a
length of MAX_FILTER_STR_VAL (256), which is too short for some
commands already seen in the wild (with cmd strings longer than that
showing up truncated in err_log).

Remove the restriction so that no synthetic event command error string
is ever truncated.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_synth.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 149011e34ad9..7d50b4251c60 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -42,10 +42,13 @@ enum { ERRORS };
 
 static const char *err_text[] = { ERRORS };
 
-static char last_cmd[MAX_FILTER_STR_VAL];
+static char *last_cmd;
 
 static int errpos(const char *str)
 {
+	if (!str || !last_cmd)
+		return 0;
+
 	return err_pos(last_cmd, str);
 }
 
@@ -54,11 +57,19 @@ static void last_cmd_set(const char *str)
 	if (!str)
 		return;
 
-	strncpy(last_cmd, str, MAX_FILTER_STR_VAL - 1);
+	kfree(last_cmd);
+	last_cmd = kzalloc(strlen(str) + 1, GFP_KERNEL);
+	if (!last_cmd)
+		return;
+
+	strncpy(last_cmd, str, strlen(str));
 }
 
-static void synth_err(u8 err_type, u8 err_pos)
+static void synth_err(u8 err_type, u16 err_pos)
 {
+	if (!last_cmd)
+		return;
+
 	tracing_log_err(NULL, "synthetic_events", last_cmd, err_text,
 			err_type, err_pos);
 }
-- 
2.17.1

