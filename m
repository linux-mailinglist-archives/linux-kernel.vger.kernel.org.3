Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E19559843
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 12:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiFXK4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 06:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiFXK4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 06:56:34 -0400
Received: from smtp89.ord1d.emailsrvr.com (smtp89.ord1d.emailsrvr.com [184.106.54.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F07877054
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1656068192;
        bh=S14l7ZmCjcVAAO1R8frxNEYveVaqQgMJOQWYyJitZXg=;
        h=From:To:Subject:Date:From;
        b=BhoxHQSLxydzgHSsM9JXclf0WSJrRDJJOuWqA8T43srxNio071Q2hWXelMEJXtxZ0
         VD923lYukL4WOnDJSBTQrTVSOJRb0uir1vlQwivgavRkhW5fk/9YbSsUB9mLH5Lyx2
         0Pm86+ReGxg+2vgt+oasHzH8cjs3bg9be2bHXRlo=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp20.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 62F2FC00AB;
        Fri, 24 Jun 2022 06:56:32 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Ian Abbott <abbotti@mev.co.uk>
Subject: [RESEND PATCH] typecheck.h: Force a compilation error if typecheck(type,x) fails
Date:   Fri, 24 Jun 2022 11:56:12 +0100
Message-Id: <20220624105612.137575-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220203143557.218112-1-abbotti@mev.co.uk>
References: <20220203143557.218112-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: f8bdbfde-5249-450d-b1d7-4b7f3b375993-1-1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
2.35.1

