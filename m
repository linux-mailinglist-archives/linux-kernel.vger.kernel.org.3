Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB78C50611F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241634AbiDSAp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241151AbiDSApO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D956C2AC5C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 01870CE1299
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC5DC385DB;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=byMzJe2H2GUtc2cOXlkFwHCrNq/HY4AjpqDjvfRblZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BHRomnEW9/Ytc7BPx3QAijQMqWJlL96oxk7MZOZ3uih6/1zLY4MFnuv1xPSd16W3k
         nZcWOFQdnfEO3sCaJZ/StRTOt1O4edjJChiMSQq9hoJJrKqCioPQI9cLjE6MjqcXt8
         TlBFYFRlzWQpgDVuI2meBdiT5b54wnNdJDlw/J/yDR0TaVJR974MKxyWPTrvxO4tmU
         omd0Aw91unuDLZCaxtsPfo/4MibtjotVKUIwJSbBI7K0kqIttJ4j8Gh80izTUPHsIA
         WN+Sx+C9Uxbu2g4cLa6L2I6jAFwtn1+/gqeXkMJ8qv6gOI+WTTandhBcMaiqCi304v
         nEpXRoslachqw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 415EE5C3108; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 32/61] tools/nolibc: move exported functions to their own section
Date:   Mon, 18 Apr 2022 17:41:56 -0700
Message-Id: <20220419004225.3952530-32-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
References: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau <w@1wt.eu>

Some functions like raise() and memcpy() are permanently exported because
they're needed by libgcc on certain platforms. However most of the time
they are not needed and needlessly take space.

Let's move them to their own sub-section, called .text.nolibc_<function>.
This allows ld to get rid of them if unused when passed --gc-sections.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/stdlib.h | 2 +-
 tools/include/nolibc/string.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 4cc1fdf6791e..da08ff30c15a 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -314,7 +314,7 @@ int msleep(unsigned int msecs)
 }
 
 /* This one is not marked static as it's needed by libgcc for divide by zero */
-__attribute__((weak,unused))
+__attribute__((weak,unused,section(".text.nolibc_raise")))
 int raise(int signal)
 {
 	return sys_kill(sys_getpid(), signal);
diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index c550c9ba8f4c..c1661589cb3c 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -69,7 +69,7 @@ void *memmove(void *dst, const void *src, size_t len)
 }
 
 /* must be exported, as it's used by libgcc on ARM */
-__attribute__((weak,unused))
+__attribute__((weak,unused,section(".text.nolibc_memcpy")))
 void *memcpy(void *dst, const void *src, size_t len)
 {
 	return _nolibc_memcpy_up(dst, src, len);
-- 
2.31.1.189.g2e36527f23

