Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0DF4E9D66
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244575AbiC1RYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbiC1RYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:24:00 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764F564BCE;
        Mon, 28 Mar 2022 10:22:19 -0700 (PDT)
Received: from grover.. (133-32-185-133.west.xps.vectant.ne.jp [133.32.185.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 22SHLdGY017332;
        Tue, 29 Mar 2022 02:21:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 22SHLdGY017332
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648488100;
        bh=a1RDShE0uWC0OhbAt+4QzV+tQ/pdHe8WAiRE756c3W0=;
        h=From:To:Cc:Subject:Date:From;
        b=RCDk9PCuaJFsqcnuTc1cCV86kdxgz9+vRh03BPeaMVSz9jxwij1W1oCar3Mi7++Q3
         3LdkaOwdZsqz7bWaGJVQ9U54S0IWu39zjEDVnx/9YcIyg/ox5+gdnDV4EdNgTd6XG0
         m91SPvkhunrgydwR6iwo6IuoVQLXg6ZNRB8cAA+y3fpUmqLnQ+Vm6n+y9keyuaL5mZ
         6gIsIKqzPHRO/rTRTqM9z8FgGzOCAqePQIj3lIvtx1YlJf5XBvXj4mDaqj7jOR16cN
         3ETTch9XoG6fk/EvJpZc0VNUXSPnV+WDgg1mWEF65vxJ+cH664GWI2JWKFlcQRs7Yw
         DdibEitGXs14Q==
X-Nifty-SrcIP: [133.32.185.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        David Airlie <airlied@linux.ie>
Subject: [PATCH 1/2] agpgart.h: do not include <stdlib.h> from exported header
Date:   Tue, 29 Mar 2022 02:21:29 +0900
Message-Id: <20220328172130.197319-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 35d0f1d54ecd ("include/uapi/linux/agpgart.h: include stdlib.h in
userspace") included <stdlib.h> to fix the unknown size_t error, but
I do not think it is the right fix.

This header already uses __kernel_size_t a few lines below.

Replace the remaining size_t, and stop including <stdlib.h>.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/uapi/linux/agpgart.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/agpgart.h b/include/uapi/linux/agpgart.h
index f5251045181a..9cc3448c0b5b 100644
--- a/include/uapi/linux/agpgart.h
+++ b/include/uapi/linux/agpgart.h
@@ -52,7 +52,6 @@
 
 #ifndef __KERNEL__
 #include <linux/types.h>
-#include <stdlib.h>
 
 struct agp_version {
 	__u16 major;
@@ -64,10 +63,10 @@ typedef struct _agp_info {
 	__u32 bridge_id;	/* bridge vendor/device         */
 	__u32 agp_mode;		/* mode info of bridge          */
 	unsigned long aper_base;/* base of aperture             */
-	size_t aper_size;	/* size of aperture             */
-	size_t pg_total;	/* max pages (swap + system)    */
-	size_t pg_system;	/* max pages (system)           */
-	size_t pg_used;		/* current pages used           */
+	__kernel_size_t aper_size;	/* size of aperture             */
+	__kernel_size_t pg_total;	/* max pages (swap + system)    */
+	__kernel_size_t pg_system;	/* max pages (system)           */
+	__kernel_size_t pg_used;	/* current pages used           */
 } agp_info;
 
 typedef struct _agp_setup {
-- 
2.32.0

