Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A914500986
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241616AbiDNJUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241162AbiDNJUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:20:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786EB51312;
        Thu, 14 Apr 2022 02:18:14 -0700 (PDT)
From:   Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649927893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YlxWxeEGkgLnVt3u2pgdSqjRibYcLflLeZsegRG9WOc=;
        b=woA4MM1nalDUbF5qByr5OrBaLP7a5QmD3vxg+EGDy9AV7h0kQexg01M+J801NGmDK5Yg36
        MegPwzTgDfDGGTOSwH4FYz/HTngLe1bYBBO697YTTfEiy4tTLaikGgtBSrWDfepkhDZ5qQ
        dMOdbfNCzg7um5DRLP977CmoerlO0gR7QZ/YuG0c9izsqwa/5ssRuARbilkvgCgYRm08Hw
        b1AftCe7fPuNs0c88r+9q9+reHruSAIWA7V1eg6X4szqXL1BSe7QeoDUMqkSASEzYBSMKQ
        FoelKpto4IcKmr0h0oZwHBFh3NSTy2C5361MWnJVgcXiCXJwINjIGR+SomoHxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649927893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YlxWxeEGkgLnVt3u2pgdSqjRibYcLflLeZsegRG9WOc=;
        b=TrVTrdBxZf6P1A7fu27oe3ucmEXu0kBss2Q6deigtyXa+CA3Kjl7ePQI1NoxVkBLowQnN/
        2nyJAW2UpLWqdHDw==
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Richard Cochran <richardcochran@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH v2 2/3] tracing: Introduce trace clock tai
Date:   Thu, 14 Apr 2022 11:18:04 +0200
Message-Id: <20220414091805.89667-3-kurt@linutronix.de>
In-Reply-To: <20220414091805.89667-1-kurt@linutronix.de>
References: <20220414091805.89667-1-kurt@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A fast/NMI safe accessor for CLOCK_TAI has been introduced.
Use it for adding the additional trace clock "tai".

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 kernel/trace/trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f4de111fa18f..7be87b29c6c1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1542,6 +1542,7 @@ static struct {
 	{ ktime_get_mono_fast_ns,	"mono",		1 },
 	{ ktime_get_raw_fast_ns,	"mono_raw",	1 },
 	{ ktime_get_boot_fast_ns,	"boot",		1 },
+	{ ktime_get_tai_fast_ns,	"tai",		1 },
 	ARCH_TRACE_CLOCKS
 };
 
-- 
2.30.2

