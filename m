Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21ECE4B27AE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344946AbiBKORq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:17:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiBKORo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:17:44 -0500
X-Greylist: delayed 369 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 06:17:42 PST
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4CEE188
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 06:17:42 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id DAFD8FF837;
        Fri, 11 Feb 2022 14:11:31 +0000 (UTC)
From:   Max Staudt <max@enpas.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Max Staudt <max@enpas.org>
Subject: [PATCH] tty: Reserve ldisc 29 for development purposes
Date:   Fri, 11 Feb 2022 15:10:36 +0100
Message-Id: <20220211141036.6403-1-max@enpas.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's handy to have an ldisc number free for out-of-tree testing. This
way, a new ldisc can be developed on any running system, without having
to recompile the kernel just to define a new number.

This is the highest number (and also the last one) available under the
old numbering scheme, so let's reserve it before it's too late.

From now on, every new ldisc upstreamed will have to increment NR_LDISCS
in lockstep with its addition to the table in tty.h.

Signed-off-by: Max Staudt <max@enpas.org>
---
 include/uapi/linux/tty.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/tty.h b/include/uapi/linux/tty.h
index a58deb3061eb..9d0f06bfbac3 100644
--- a/include/uapi/linux/tty.h
+++ b/include/uapi/linux/tty.h
@@ -6,8 +6,6 @@
  * 'tty.h' defines some structures used by tty_io.c and some defines.
  */
 
-#define NR_LDISCS		30
-
 /* line disciplines */
 #define N_TTY		0
 #define N_SLIP		1
@@ -39,5 +37,9 @@
 #define N_SPEAKUP	26	/* Speakup communication with synths */
 #define N_NULL		27	/* Null ldisc used for error handling */
 #define N_MCTP		28	/* MCTP-over-serial */
+#define N_DEVELOPMENT	29	/* Manual out-of-tree testing */
+
+/* Always the newest line discipline + 1 */
+#define NR_LDISCS	30
 
 #endif /* _UAPI_LINUX_TTY_H */
-- 
2.30.2

