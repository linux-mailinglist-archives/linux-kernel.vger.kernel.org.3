Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E505F51140A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 11:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbiD0JGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbiD0JGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:06:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6473E1E2730
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 02:03:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EFB161C5D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9720BC385A7;
        Wed, 27 Apr 2022 09:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651050207;
        bh=+UW4jAqfFuauhXMLKLKHOttXSnjvT0HfZAAZisUcDi4=;
        h=From:To:Cc:Subject:Date:From;
        b=Iwa9OaiTP+cx39/Pj73i+duAt6fSplWS26ygk2bMuVXm4b58bl7P+AidhGU0hsIjj
         jqvVgJXD11ZJKUWzmklEcN+0fH+J5yKtpLiqYalZoW3ElcUukThZip+7nUHLoWBxv0
         Av+f3ltUkK+/qXX9BhZlbxWNTBT+oNwmcdQQYI1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Matthias Maennich <maennich@google.com>
Subject: [PATCH] module.h: simplify MODULE_IMPORT_NS
Date:   Wed, 27 Apr 2022 11:03:21 +0200
Message-Id: <20220427090321.2105373-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428; i=gregkh@linuxfoundation.org; h=from:subject; bh=+UW4jAqfFuauhXMLKLKHOttXSnjvT0HfZAAZisUcDi4=; b=owGbwMvMwCRo6H6F97bub03G02pJDEmZbNfmzGkrOnrg2pr8ff8VDn06GpjbHuP67ugP1sVWq9OP bba+2xHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQAT8T/GsOBCfl33vFRbvzxunwm/+r Mv8Vm7JzPMld9+I/QXe6HvgWi7kr3/HxxWnclQDwA=
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

In commit ca321ec74322 ("module.h: allow #define strings to work with
MODULE_IMPORT_NS") I fixed up the MODULE_IMPORT_NS() macro to allow
defined strings to work with it.  Unfortunatly I did it in a two-stage
process, when it could just be done with the __stringify() macro as
pointed out by Masahiro Yamada.

Clean this up to only be one macro instead of two steps to achieve the
same end result.

Fixes: ca321ec74322 ("module.h: allow #define strings to work with MODULE_IMPORT_NS")
Reported-by: Masahiro Yamada <masahiroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Matthias Maennich <maennich@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/module.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 1e135fd5c076..d5e9066990ca 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -290,8 +290,7 @@ extern typeof(name) __mod_##type##__##name##_device_table		\
  * files require multiple MODULE_FIRMWARE() specifiers */
 #define MODULE_FIRMWARE(_firmware) MODULE_INFO(firmware, _firmware)
 
-#define _MODULE_IMPORT_NS(ns)	MODULE_INFO(import_ns, #ns)
-#define MODULE_IMPORT_NS(ns)	_MODULE_IMPORT_NS(ns)
+#define MODULE_IMPORT_NS(ns)	MODULE_INFO(import_ns, __stringify(ns))
 
 struct notifier_block;
 
-- 
2.36.0

