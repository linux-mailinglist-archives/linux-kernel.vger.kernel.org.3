Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC1B50098D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241629AbiDNJUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241602AbiDNJUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:20:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E1251E4D;
        Thu, 14 Apr 2022 02:18:15 -0700 (PDT)
From:   Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649927893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iLmCDPlHlx+4vJ7+eT/pCoYu1/+sbjT/6wC8EGaZi10=;
        b=Ouz9SoFspDW418thOwaQ0Wmr2WP5cb7znTdJES07Jqk9ljP7qEuX4Ja0bp2p9Bx1rL46+0
        KEM/ThW4kR7QqxstcwNG1UBJMbrSEcivkYgDo2AA3pJHs6Vv+FzGnev/fhr1PZlTqUDAWd
        6f2Z2ddOjcAn5KCI+LKeV41G5Wyutpu08s+KxiTMHy/EPTRQLGrsB+Xt4YKuI6fXJkLvno
        4K89hh3dbaTp+7PlMhnUVQK4fYa+WiGDSzXbiAzGiLOtHyRA3iNtaSgJD9QlQ+dOltQ2nK
        RblARhI6wi4jP2x1Os0ZUdTxZUAMvhPMUzyZMgTeX2JXgl3mXcUdKIDh8hJV+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649927893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iLmCDPlHlx+4vJ7+eT/pCoYu1/+sbjT/6wC8EGaZi10=;
        b=Fup1SrnNBv5FuCo7x/lZ5UGJZXakS/VRTQw77bfksXFJPu8+Pso4qvtggfACDwPEjBiz36
        3b1SHOh6BLCvwJAA==
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Richard Cochran <richardcochran@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH v2 3/3] tracing: Add documentation for trace clock tai
Date:   Thu, 14 Apr 2022 11:18:05 +0200
Message-Id: <20220414091805.89667-4-kurt@linutronix.de>
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

Add documentation for newly introduced trace clock "tai".
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

