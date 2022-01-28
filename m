Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E026F4A016B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 21:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351132AbiA1UIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 15:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351109AbiA1UIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:08:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B410C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 12:08:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C03B361DCA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 20:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF54BC340EB;
        Fri, 28 Jan 2022 20:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643400514;
        bh=4K4IWRbcZ254e2H50ie9lOC9n8GLTP1rVEIdNgWO43w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=BBNDEXBEQbf+6n9IWqTgisEvB+ZnZD6Wg5xB/iHrZ/YY1RNG2D0oRAfdykvviIHpq
         YG3+mXHvF9UkIjSQnAeA4niBiOGaxKdrad/ovigZHcM5+vOYKpWIZYTtdqWWtS9DES
         dITLbMTvY1V0PoAP1KRZYjY8hkVD7CV8bVkqTaA4Os/WaHp6+d55Od2SY9/IH00xS/
         EIcRDHEpIzINwfRSan0oQdJ8L905xrTifieVT8HpEy2ofTv1UiQgl2T/3kSdC8/bKg
         XeLMVyYy9MqrOVTWBHhFZHxH/MrvdHemohbe/Lv5TQE+lsLAbLU1sqEvrQVd6+T+C+
         BLCLgTlous+Kg==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v2 2/2] tracing: Remove size restriction on synthetic event cmd error logging
Date:   Fri, 28 Jan 2022 14:08:27 -0600
Message-Id: <0376692396a81d0b795127c66ea92ca5bf60f481.1643399022.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1643399022.git.zanussi@kernel.org>
References: <cover.1643399022.git.zanussi@kernel.org>
In-Reply-To: <cover.1643399022.git.zanussi@kernel.org>
References: <cover.1643399022.git.zanussi@kernel.org>
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
index 149011e34ad9..d3d9cd677f9a 100644
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
+	strncpy(last_cmd, str, strlen(str) + 1);
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

