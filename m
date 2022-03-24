Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976914E5F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348377AbiCXHeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348740AbiCXHcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:32:55 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF79C99684
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:31:19 -0700 (PDT)
Received: from integral2.. (unknown [182.2.71.236])
        by gnuweeb.org (Postfix) with ESMTPSA id 5677E7E704;
        Thu, 24 Mar 2022 07:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648107078;
        bh=fJcSLnuw44NoUHae7y/oNQpDDIPqjE4FIFL9l+7MB1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A9XBai20pypo06J+WL0KH2qpSL+/EkzbhFNKWNqQHvt3OfWQjjFPEHrJyUXR2VGrZ
         JEx0z5vAija+MJwAWzQSZPEP5tlU9lb8DNEzZ/BrVXD7KwHUglbUM8DXzWC8d0m8wA
         FVLTvGOdPycQFeZRDNXxezzaZpyiOZdCDseZF0rmus6Cla/68k45UK/Epi1XR8JcHp
         rtPm+849fdAY102mZlNB0RUGpLUEbxbOkn3KEGkj2aN6KyH4xL+NJYubnHFxswL6VG
         Kh0h2LEuEfApGAJ24Vp1eyxxqj2nLXtCjXYhU6F6TtquUp3cnTlVZRFg97/iH0NBqD
         39ZncWjSwuK7g==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH v1 08/11] tools/nolibc/types: Implement `offsetof()` and `container_of()` macro
Date:   Thu, 24 Mar 2022 14:30:36 +0700
Message-Id: <20220324073039.140946-9-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220324073039.140946-1-ammarfaizi2@gnuweeb.org>
References: <20220324073039.140946-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement `offsetof()` and `container_of()` macro. The first use case
of these macros is for `malloc()`, `realloc()` and `free()`.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
@@ Changelog:

   Link RFC v2: https://lore.kernel.org/lkml/20220322102115.186179-6-ammarfaizi2@gnuweeb.org/
   RFC v2 -> v1:
    * No changes *
---
 tools/include/nolibc/types.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 357e60ad38a8..959997034e55 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -191,4 +191,15 @@ struct stat {
 #define major(dev) ((unsigned int)(((dev) >> 8) & 0xfff))
 #define minor(dev) ((unsigned int)(((dev) & 0xff))
 
+#ifndef offsetof
+#define offsetof(TYPE, FIELD) ((size_t) &((TYPE *)0)->FIELD)
+#endif
+
+#ifndef container_of
+#define container_of(PTR, TYPE, FIELD) ({			\
+	__typeof__(((TYPE *)0)->FIELD) *__FIELD_PTR = (PTR);	\
+	(TYPE *)((char *) __FIELD_PTR - offsetof(TYPE, FIELD));	\
+})
+#endif
+
 #endif /* _NOLIBC_TYPES_H */
-- 
Ammar Faizi

