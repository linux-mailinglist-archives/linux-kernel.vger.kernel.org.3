Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C2F50491A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 20:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbiDQS7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 14:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbiDQS7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 14:59:46 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BE135875;
        Sun, 17 Apr 2022 11:57:10 -0700 (PDT)
Received: from integral2.. (unknown [36.80.217.41])
        by gnuweeb.org (Postfix) with ESMTPSA id 171F87E3C6;
        Sun, 17 Apr 2022 18:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1650221828;
        bh=W/B15O4/x8QrATxnTZ+KI9F1A5LySUR4+bRcaz8u5yU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bD/Bkb+G2IASp7bWPXJrLygzl5789e2fKMjlZQ51xEkJf5CkaBuiPexp/8F+ryICY
         N2/V8108wtl81Ua+jdQmISkTthsoEJ9asSVqIZiiP71xuEbjdkMxDA6IXDaX3fd2DX
         j4yKYFxJrxg/v0fXyRqtuy0k//sHc8QKMFJCCFbq66v08qL3uxQpQaoc3Ysjsm78Uu
         TBbvgFt4SvYV8Lhzt9U2T4tRSff9rABXIDU+mkbrNLHlyhufyqxk6XY+YToyvRg60W
         +OSCJbdQQbte/NQ03RL1rhLGRb1VM7M9xgCU/LJ77PZaIkZhM6NA2vspgxFtzzDZXQ
         nWQ3BfcLDeCqQ==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Trace Devel Mailing List 
        <linux-trace-devel@vger.kernel.org>
Subject: [RESEND PATCH 2/2] tracing: Change `if (strlen(glob))` to `if (glob[0])`
Date:   Mon, 18 Apr 2022 01:56:30 +0700
Message-Id: <20220417185630.199062-3-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220417185630.199062-1-ammarfaizi2@gnuweeb.org>
References: <20220417185630.199062-1-ammarfaizi2@gnuweeb.org>
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

