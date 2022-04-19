Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812DF506119
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242730AbiDSArY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241322AbiDSApQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6538BFD0D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F2BEB8115B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE2EC385D0;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=7Ybu+vkDXcO1KNiVVZoGvdimbgM9oY5KoCdhAc3BDE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oT2Tx+P78JKU3NM/qC5CoTlNfiCKJgVrGtBSOCEWufl7InnXHKigVpq/HKdgLkMfC
         F8+kMcOM6fAStSNO8ob3+qFv0PPN1jsrOEqcgLJKdAr4ye8SudAHTnJ6lFOcAgf3JX
         Jj93IFMwprS91a+u3L5Fwggchyo7hXq8+6KroPIuACWmVov3w0Oqg06gDQQAcn9ksU
         bnljYyzPalRSgrioxNI+fNwfgfrm2aYYmm+gFqSDID61x0LPCnngRf36MWf4nDdYeD
         nmT4FvZOxZZnck+lRiA3CFd7HL4wJMX5g80Vu+fSmkgkR2Cu9grJ+k+guFvBIQGQdG
         +okyFvCSd7ibA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3163A5C30F6; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 23/61] tools/nolibc/stdio: add perror() to report the errno value
Date:   Mon, 18 Apr 2022 17:41:47 -0700
Message-Id: <20220419004225.3952530-23-paulmck@kernel.org>
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

It doesn't contain the text for the error codes, but instead displays
"errno=" followed by the errno value. Just like the regular errno, if
a non-empty message is passed, it's placed followed with ": " on the
output before the errno code. The message is emitted on stderr.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/stdio.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index a73cf24cb68d..5f1cf32470d3 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -286,4 +286,10 @@ int printf(const char *fmt, ...)
 	return ret;
 }
 
+static __attribute__((unused))
+void perror(const char *msg)
+{
+	fprintf(stderr, "%s%serrno=%d\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "", errno);
+}
+
 #endif /* _NOLIBC_STDIO_H */
-- 
2.31.1.189.g2e36527f23

