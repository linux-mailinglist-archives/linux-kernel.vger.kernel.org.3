Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F15533D45
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243826AbiEYNIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiEYNIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:08:36 -0400
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B994BB97;
        Wed, 25 May 2022 06:08:31 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 86AD8101CCD; Wed, 25 May 2022 14:08:30 +0100 (BST)
Date:   Wed, 25 May 2022 14:08:30 +0100
From:   Sean Young <sean@mess.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] media: lirc: revert removal of unused feature flags
Message-ID: <Yo4qTnYYT+55vlQ9@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit b2a90f4fcb14 ("media: lirc: remove unused lirc features") removed
feature flags which were never implemented, but they are still used by
the lirc daemon went built from source.

Reinstate these symbols in order not to break the lirc build.

Cc: Jiri Slaby <jirislaby@kernel.org>
Link: https://lkml.org/lkml/2022/5/25/58
Fixes: b2a90f4fcb14 ("media: lirc: remove unused lirc features")
Signed-off-by: Sean Young <sean@mess.org>
---
 include/uapi/linux/lirc.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/uapi/linux/lirc.h b/include/uapi/linux/lirc.h
index 23b0f2c8ba81..8d7ca7c6af42 100644
--- a/include/uapi/linux/lirc.h
+++ b/include/uapi/linux/lirc.h
@@ -84,6 +84,13 @@
 #define LIRC_CAN_SEND(x) ((x)&LIRC_CAN_SEND_MASK)
 #define LIRC_CAN_REC(x) ((x)&LIRC_CAN_REC_MASK)
 
+/*
+ * Unused features. These features were never implemented, in tree or
+ * out of tree. These definitions are here so not to break the lircd build.
+ */
+#define LIRC_CAN_SET_REC_FILTER		0
+#define LIRC_CAN_NOTIFY_DECODE		0
+
 /*** IOCTL commands for lirc driver ***/
 
 #define LIRC_GET_FEATURES              _IOR('i', 0x00000000, __u32)
-- 
2.36.1

