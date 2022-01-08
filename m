Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CFB4883E7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 15:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbiAHOEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 09:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbiAHOEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 09:04:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E672C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 06:04:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB036B808BF
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 14:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F26C36AE3;
        Sat,  8 Jan 2022 14:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641650659;
        bh=39tSvTLT04lC8vOCTF5RHXB9JFBq1CIb4BSXwe+BA2s=;
        h=From:To:Cc:Subject:Date:From;
        b=I9Zza1Im9yHLaZ9mbkTZQgffKBDF+JaK6IH0iq+5o09vQDE5a/x6W4vLZ35e3SBJK
         9vTesCqS5gBuiLX2lZV/FwJ8POEzVZivDTel+HYuDoHVWadbrxUh+puLYOdz9RuLRx
         x8Qd0Fqn27HmL4xf2YdFCF5aDQAKYjNAMvno2D8o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Jessica Yu <jeyu@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>
Subject: [PATCH] export: fix string handling of namespace in EXPORT_SYMBOL_NS
Date:   Sat,  8 Jan 2022 15:04:15 +0100
Message-Id: <20220108140415.3360088-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1999; h=from:subject; bh=39tSvTLT04lC8vOCTF5RHXB9JFBq1CIb4BSXwe+BA2s=; b=owGbwMvMwCRo6H6F97bub03G02pJDIk3Z97ZvufghijX9S8Z7p+QcOae/oCZa9vxczdbPqfOj01T vnxsU0csC4MgE4OsmCLLl208R/dXHFL0MrQ9DTOHlQlkCAMXpwBMRGM9w4L9W3+/XNWpmTX3TcoWR4 9M76uyTr8YFlyx8eqfkSW7zH61VZuDeNG+1WYKQQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c3a6cf19e695 ("export: avoid code duplication in
include/linux/export.h") broke the ability for a defined string to be
used as a namespace value.  Fix this up by adding another layer of
indirection to preserve the previous functionality.

Fixes: c3a6cf19e695 ("export: avoid code duplication in include/linux/export.h")
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Matthias Maennich <maennich@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, I found this while forward porting an out-of-tree Android kernel
patch from 5.4 to 5.10 that used module namespaces to help wall-off vfs
symbols from being used by non-filesystem modules.  This issue does not
affect any in-kernel code, so I am not so sure if it really is needed
here, but it does restore the previous functionality that was being used
in older kernels so it might be good to put back in case others want to
do much the same thing.

 include/linux/export.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/export.h b/include/linux/export.h
index 27d848712b90..9a992809f57d 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -162,8 +162,10 @@ struct kernel_symbol {
 
 #define EXPORT_SYMBOL(sym)		_EXPORT_SYMBOL(sym, "")
 #define EXPORT_SYMBOL_GPL(sym)		_EXPORT_SYMBOL(sym, "_gpl")
-#define EXPORT_SYMBOL_NS(sym, ns)	__EXPORT_SYMBOL(sym, "", #ns)
-#define EXPORT_SYMBOL_NS_GPL(sym, ns)	__EXPORT_SYMBOL(sym, "_gpl", #ns)
+#define _EXPORT_SYMBOL_NS(sym, ns)	__EXPORT_SYMBOL(sym, "", #ns)
+#define _EXPORT_SYMBOL_NS_GPL(sym, ns)	__EXPORT_SYMBOL(sym, "_gpl", #ns)
+#define EXPORT_SYMBOL_NS(sym, ns)	_EXPORT_SYMBOL_NS(sym, ns)
+#define EXPORT_SYMBOL_NS_GPL(sym, ns)	_EXPORT_SYMBOL_NS_GPL(sym, ns)
 
 #endif /* !__ASSEMBLY__ */
 
-- 
2.34.1

