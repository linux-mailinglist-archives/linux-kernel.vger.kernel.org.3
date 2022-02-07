Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C85D4AC64F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383444AbiBGQoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390492AbiBGQeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:34:50 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A865DC0401D8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:34:48 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOaeF014385;
        Mon, 7 Feb 2022 17:24:36 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 02/42] tools/nolibc: guard the main file against multiple inclusion
Date:   Mon,  7 Feb 2022 17:23:14 +0100
Message-Id: <20220207162354.14293-3-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220207162354.14293-1-w@1wt.eu>
References: <20220207162354.14293-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Including nolibc.h multiple times results in build errors due to multiple
definitions. Let's add a guard against multiple inclusions.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/nolibc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index ad23712f9cb5..4660637d9b17 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -80,6 +80,8 @@
  *      https://w3challs.com/syscalls/
  *
  */
+#ifndef _NOLIBC_H
+#define _NOLIBC_H
 
 #include <asm/unistd.h>
 #include <asm/ioctls.h>
@@ -2582,3 +2584,5 @@ dev_t makedev(unsigned int major, unsigned int minor)
 {
 	return ((major & 0xfff) << 8) | (minor & 0xff);
 }
+
+#endif /* _NOLIBC_H */
-- 
2.35.1

