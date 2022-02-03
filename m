Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C594A86B0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351368AbiBCOhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:37:09 -0500
Received: from smtp94.ord1c.emailsrvr.com ([108.166.43.94]:42746 "EHLO
        smtp94.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237445AbiBCOgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1643898980;
        bh=j9UR+w9Yyq3GuAjplCqH7KpvvTpAPND1acDGdT4YSPQ=;
        h=From:To:Subject:Date:From;
        b=Y8PRddp8s4S3yeImUPzTL+pA8a1D+GF7Ramj82GrvCze4z8HKRYn92+YP1NdMe2mg
         ZL2JYzXi84sRKGrFsG8X0LKRqu6V4MuWrE60SCSexP2ZbV3tIuT+fEGUFa6xe4C55f
         u8B2KpMr+FwTyV6Qyd0aArNHK451lmFEnxFyzs0o=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp20.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id BE0C5E00E1;
        Thu,  3 Feb 2022 09:36:19 -0500 (EST)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH] typecheck.h: Force a compilation error if typecheck(type,x) fails
Date:   Thu,  3 Feb 2022 14:35:57 +0000
Message-Id: <20220203143557.218112-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: b2283325-1f61-4e3a-ac4d-3cb4c3d97e5f-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling the `typecheck(type,x)` macro emits a compiler warning if the
type of `x` is incompatible with type `type`.  Change it to force a
compilation error instead.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 include/linux/typecheck.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/typecheck.h b/include/linux/typecheck.h
index 46b15e2aaefb..c9125304f6ba 100644
--- a/include/linux/typecheck.h
+++ b/include/linux/typecheck.h
@@ -2,14 +2,15 @@
 #ifndef TYPECHECK_H_INCLUDED
 #define TYPECHECK_H_INCLUDED
 
+#include <linux/compiler_types.h>
+#include <linux/build_bug.h>
+
 /*
  * Check at compile time that something is of a particular type.
  * Always evaluates to 1 so you may use it easily in comparisons.
  */
 #define typecheck(type,x) \
-({	type __dummy; \
-	typeof(x) __dummy2; \
-	(void)(&__dummy == &__dummy2); \
+({	BUILD_BUG_ON(!__same_type(type, (x))); \
 	1; \
 })
 
-- 
2.34.1

