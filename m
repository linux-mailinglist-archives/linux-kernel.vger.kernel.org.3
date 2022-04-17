Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9079504915
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 20:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbiDQS40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 14:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbiDQS4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 14:56:21 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A570C338A1;
        Sun, 17 Apr 2022 11:53:45 -0700 (PDT)
Received: from integral2.. (unknown [36.80.217.41])
        by gnuweeb.org (Postfix) with ESMTPSA id 5421E7E3B9;
        Sun, 17 Apr 2022 18:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1650221625;
        bh=W/B15O4/x8QrATxnTZ+KI9F1A5LySUR4+bRcaz8u5yU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HfyehUHfpp5Os+sZQK97eIpUXTHlO290GdmSLtWean27Up+3D0nCTYoIZWEhd6lmJ
         dqFw4s1PaXSHawNOG/P03ZIh8vUGLn3K7fKgReNAilj4xTMYrPZF5AEw8M8USkPsZW
         Kigh+1werbkzoIg7h49+lkLTiVtPRfk9UWSdlxMWoGSpaVJ1bBUAXoU2RPw9FYc9X7
         dNMVeezqsIiUj1nx79pS/QoL95azi1JM0vAbjXqGcsRhNN5GqPhWK/nrK2eH1Tnlww
         BngpQYxzRlRQ9r6LLBlALpTg4aSGWPN4l1OVbLO73H+/gB2h0JJn2HGJ1+KfZvTrm7
         H74G82Nqq4Nbg==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Trace Devel Mailing List 
        <llinux-trace-devel@vger.kernel.org>
Subject: [PATCH 2/2] tracing: Change `if (strlen(glob))` to `if (glob[0])`
Date:   Mon, 18 Apr 2022 01:53:23 +0700
Message-Id: <20220417185323.198034-3-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220417185323.198034-1-ammarfaizi2@gnuweeb.org>
References: <20220417185323.198034-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to traverse to the end of string. If the first byte is not a NUL
char, it's guaranteed `if (strlen(glob))` is true.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 0b99ad68e3fa..1968e497ef44 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6189,7 +6189,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 	if (WARN_ON(!glob))
 		return -EINVAL;
 
-	if (strlen(glob)) {
+	if (glob[0]) {
 		hist_err_clear();
 		last_cmd_set(file, param);
 	}
-- 
Ammar Faizi

