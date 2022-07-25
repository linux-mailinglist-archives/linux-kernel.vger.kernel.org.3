Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFD458016B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 17:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbiGYPPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 11:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236299AbiGYPOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 11:14:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FD5193E9;
        Mon, 25 Jul 2022 08:12:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A2D3033F4E;
        Mon, 25 Jul 2022 15:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658761938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IcDfe1qAsKkryZs7ENDkQI7bMbsGz7rgNqa1mogQ454=;
        b=FqQXrlGrrxmt0aM8+v+78qRkIdfb+iiCU3Fw30Fh/w35dX0oP8yWqfj5ruNMDB5j/tovuQ
        8tGemOXcr/7YWZKLjwfkZB+oy5Q/mVCNt3kE2jYlOFY4wP3vo0NHERiRN80VAjtkf68C5T
        +c9Oxth3THuo6Hf6V7COUBiXOUCWO/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658761938;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IcDfe1qAsKkryZs7ENDkQI7bMbsGz7rgNqa1mogQ454=;
        b=sZZgRw+WeMhTWaGaVHimeTVkyj2CTEIF5GLLEqydHebpfEREJ2XXry01kLpoCjtv0D57Qg
        O6bBPfHyNBUmcvBw==
Received: from hawking.suse.de (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id 942442C171;
        Mon, 25 Jul 2022 15:12:18 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id 479F1444B2F; Mon, 25 Jul 2022 17:12:18 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rtla: Fix double free
References: <mvmzggxl4n1.fsf@suse.de>
        <fd0888a4-099c-95fe-7e20-82be1489061f@kernel.org>
        <mvmv8rll2yn.fsf@suse.de> <20220725105639.295a7d7d@gandalf.local.home>
X-Yow:  It don't mean a THING if you ain't got that SWING!!
Date:   Mon, 25 Jul 2022 17:12:18 +0200
In-Reply-To: <20220725105639.295a7d7d@gandalf.local.home> (Steven Rostedt's
        message of "Mon, 25 Jul 2022 10:56:39 -0400")
Message-ID: <mvmilnlkyzx.fsf_-_@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid double free by making trace_instance_destroy indempotent.  When
trace_instance_init fails, it calls trace_instance_destroy, but its only
caller osnoise_destroy_tool calls it again.

Fixes: 0605bf009f18 ("rtla: Add osnoise tool")
Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 tools/tracing/rtla/src/trace.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 5784c9f9e570..e1ba6d9f4265 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -134,13 +134,18 @@ void trace_instance_destroy(struct trace_instance *trace)
 	if (trace->inst) {
 		disable_tracer(trace->inst);
 		destroy_instance(trace->inst);
+		trace->inst = NULL;
 	}
 
-	if (trace->seq)
+	if (trace->seq) {
 		free(trace->seq);
+		trace->seq = NULL;
+	}
 
-	if (trace->tep)
+	if (trace->tep) {
 		tep_free(trace->tep);
+		trace->tep = NULL;
+	}
 }
 
 /*
-- 
2.37.1


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
