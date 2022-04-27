Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852D851140E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 11:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbiD0JJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbiD0JJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:09:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66976D397
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 02:05:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A79E461C11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A93EC385AE;
        Wed, 27 Apr 2022 09:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651050288;
        bh=T3TeOxjkIya0gidMNU4IwIgPgO6yLgii9YhkKzTmk7I=;
        h=From:To:Cc:Subject:Date:From;
        b=lN8MtJNGyB09gzH+12y2anSran25Oy/FXKk8BEtAmQjPJhOd8ddWDwBkgzv5kAp7c
         6qhwJbaE4wfpqMRN6RBNyjGQ0KvUOOf9jv+LYLRxE26dtgl0p/l57cmm00guNtfxeF
         PRL3lJlKwn7IevU0p4uWDbFH6DLw7Yntzdb2XK0k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Jessica Yu <jeyu@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>
Subject: [PATCH v2] export: fix string handling of namespace in EXPORT_SYMBOL_NS
Date:   Wed, 27 Apr 2022 11:04:42 +0200
Message-Id: <20220427090442.2105905-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2049; i=gregkh@linuxfoundation.org; h=from:subject; bh=T3TeOxjkIya0gidMNU4IwIgPgO6yLgii9YhkKzTmk7I=; b=owGbwMvMwCRo6H6F97bub03G02pJDEmZ7FpOy0ROpWXI/OIW3PN3hgBHOrPgHT7TBMvTdgZS90v7 Vvp1xLIwCDIxyIopsnzZxnN0f8UhRS9D29Mwc1iZQIYwcHEKwESYbzPMFeg1at5+Kqn3yPRpt1kURH 8rWTKUMMzhTIn7Vc73eMmi1Zs1Dz+UZ11Y3O4NAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c3a6cf19e695 ("export: avoid code duplication in
include/linux/export.h") broke the ability for a defined string to be
used as a namespace value.  Fix this up by using stringify to properly
encode the namespace name.

Fixes: c3a6cf19e695 ("export: avoid code duplication in include/linux/export.h")
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Matthias Maennich <maennich@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: use stringify() instead of 2 step redirection as pointed out by Masahiro

 include/linux/export.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/export.h b/include/linux/export.h
index 27d848712b90..5910ccb66ca2 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_EXPORT_H
 #define _LINUX_EXPORT_H
 
+#include <linux/stringify.h>
+
 /*
  * Export symbols from the kernel to modules.  Forked from module.h
  * to reduce the amount of pointless cruft we feed to gcc when only
@@ -154,7 +156,6 @@ struct kernel_symbol {
 #endif /* CONFIG_MODULES */
 
 #ifdef DEFAULT_SYMBOL_NAMESPACE
-#include <linux/stringify.h>
 #define _EXPORT_SYMBOL(sym, sec)	__EXPORT_SYMBOL(sym, sec, __stringify(DEFAULT_SYMBOL_NAMESPACE))
 #else
 #define _EXPORT_SYMBOL(sym, sec)	__EXPORT_SYMBOL(sym, sec, "")
@@ -162,8 +163,8 @@ struct kernel_symbol {
 
 #define EXPORT_SYMBOL(sym)		_EXPORT_SYMBOL(sym, "")
 #define EXPORT_SYMBOL_GPL(sym)		_EXPORT_SYMBOL(sym, "_gpl")
-#define EXPORT_SYMBOL_NS(sym, ns)	__EXPORT_SYMBOL(sym, "", #ns)
-#define EXPORT_SYMBOL_NS_GPL(sym, ns)	__EXPORT_SYMBOL(sym, "_gpl", #ns)
+#define EXPORT_SYMBOL_NS(sym, ns)	__EXPORT_SYMBOL(sym, "", __stringify(ns))
+#define EXPORT_SYMBOL_NS_GPL(sym, ns)	__EXPORT_SYMBOL(sym, "_gpl", __stringify(ns))
 
 #endif /* !__ASSEMBLY__ */
 
-- 
2.36.0

