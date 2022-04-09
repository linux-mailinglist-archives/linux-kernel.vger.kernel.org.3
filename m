Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870F54FA5CF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 10:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240782AbiDIIPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 04:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiDIIP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 04:15:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C387A674F0;
        Sat,  9 Apr 2022 01:13:20 -0700 (PDT)
From:   Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649491999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oM+FoGv/BkTkG2TdHv8UkTd+jiQ2ziLqcW0PI5BxId8=;
        b=RJ3g47WFm501Wsc7a9Pc5BI3r/v+TZVkRFbVskQ9OA/vtf7diHW8GOxpwN0OjYnOl3cWvH
        V8zwNI+H645fJ8qK38iBrXLvxzt/M4zGpCRHCMGdjv/6JIKldxAXKb0+5488FVLRrAqTu4
        FdhMYkIzer+9Pn+WIS6WVdjTYkLAkgAIOgo/1n46l68lbS2PXCEtZTBvBeQVd/OoYDHPLe
        rkZyayYQSeZ78dLxC5efEwKBYKSrL+T/wQKC02xj/R7xBxoGzfKQ8FAUAKWUQ3VRvlk2IM
        8DfNxUS2JgJYxzfE471Rw3frvW/vj3QLmWQXNbbrU6LCQPCWhDE9dxRiRLhMzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649491999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oM+FoGv/BkTkG2TdHv8UkTd+jiQ2ziLqcW0PI5BxId8=;
        b=v+XCuAeDY6E9LehoYbDZmkqdjG0BKLsseED+lKx6+nUBcdJnfzPjov3fYy203ZyXQFwslg
        n/BsRLw11Sgpx6Bw==
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Richard Cochran <richardcochran@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH 3/3] tracing: Add documentation for trace clock tai
Date:   Sat,  9 Apr 2022 10:13:00 +0200
Message-Id: <20220409081300.4762-4-kurt@linutronix.de>
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

Add documentation for new introduced trace clock tai.
This clock corresponds to CLOCK_TAI.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 Documentation/trace/ftrace.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 45b8c56af67a..b37dc19e4d40 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -517,6 +517,18 @@ of ftrace. Here is a list of some of the key files:
 		processing should be able to handle them. See comments in the
 		ktime_get_boot_fast_ns() function for more information.
 
+	tai:
+		This is the tai clock (CLOCK_TAI) and is derived from the wall-
+		clock time. However, this clock does not experience
+		discontinuities and backwards jumps caused by NTP inserting leap
+		seconds. Since the clock access is designed for use in tracing,
+		side effects are possible. The clock access may yield wrong
+		readouts in case the internal TAI offset is updated e.g., caused
+		by setting the system time or using adjtimex() with an offset.
+		These effects are rare and post processing should be able to
+		handle them. See comments in the ktime_get_tai_fast_ns()
+		function for more information.
+
 	To set a clock, simply echo the clock name into this file::
 
 	  # echo global > trace_clock
-- 
2.30.2

