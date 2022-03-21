Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973CB4E2F1B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349191AbiCURfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348662AbiCURe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:34:57 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C17FD6623B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:33:30 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22LHXNTJ007570;
        Mon, 21 Mar 2022 18:33:23 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH 1/8] tools/nolibc/stdio: make printf(%s) accept NULL
Date:   Mon, 21 Mar 2022 18:33:07 +0100
Message-Id: <20220321173314.7519-2-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220321173314.7519-1-w@1wt.eu>
References: <20220321173314.7519-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's often convenient to support this, especially in test programs where
a NULL may correspond to an allocation error or a non-existing value.
Let's make printf("%s") support being passed a NULL. In this case it
prints "(null)" like glibc's printf().

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index cb4d3ab3a565..559ebe052a75 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -220,6 +220,8 @@ int vfprintf(FILE *stream, const char *fmt, va_list args)
 			}
 			else if (c == 's') {
 				outstr = va_arg(args, char *);
+				if (!outstr)
+					outstr="(null)";
 			}
 			else if (c == '%') {
 				/* queue it verbatim */
-- 
2.35.1

