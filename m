Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E8D4FA5CE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 10:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240837AbiDIIPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 04:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237199AbiDIIP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 04:15:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F00F102D;
        Sat,  9 Apr 2022 01:13:20 -0700 (PDT)
From:   Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649491998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YlxWxeEGkgLnVt3u2pgdSqjRibYcLflLeZsegRG9WOc=;
        b=xDmm0sG3jd/oqIpzz8MQ38dxRoQ52XMer/238Lvsr3ZhBDH5h7w+uotPNjeiLa8xna5d2b
        2YA0DbImJoadBLtlE5Zo2oDLiIkPb4aWcU5DuHqEysd9ba+a55Boo6oRI4h3Pou88EdW1V
        iLKGLVjUmPX4udhoz7gjJLy/ZiETfod2XfNrGERDtKq0hPCLxFPKRO5ZQv1VIHBAdequMX
        D7YfO77+caxoJBd4q80qDHqEbZLyQuVpt0x8gkvl1aU3XZ5EQj4hMI+MF7tAZ2vd61+be6
        UaV6kEsriP66SRRPET3L4N2/pgU42xejczJiWEV7m5IWSZrCV2dQe1x0op+Wsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649491998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YlxWxeEGkgLnVt3u2pgdSqjRibYcLflLeZsegRG9WOc=;
        b=cnO2eHfwQp0Gdg+4h4uQCl1yl1f8YhWosVFtQh7ktUuNizTZnxjdgfiHEf72xqFaCbMuWw
        CaH7olfYTqOcG6Bw==
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Richard Cochran <richardcochran@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH 2/3] tracing: Introduce trace clock tai
Date:   Sat,  9 Apr 2022 10:12:59 +0200
Message-Id: <20220409081300.4762-3-kurt@linutronix.de>
In-Reply-To: <20220409081300.4762-1-kurt@linutronix.de>
References: <20220409081300.4762-1-kurt@linutronix.de>
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

