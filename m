Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9365859774A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241677AbiHQUDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbiHQUDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:03:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD5B1F623
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:03:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5C65B81F61
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB2FC4347C;
        Wed, 17 Aug 2022 20:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660766623;
        bh=wv0Zebl3/M8/sl1p7uqmjBF5ITW2e0LsrTBPWFRbNuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IybX3rRa0kAATdNa9CEutWHHd6nJNB/y5T4vkHUm4SCBxsG8J6o2lnKb5ITB9GZwT
         WOunqvHZDReF98jHFUrT4omATeTvB3UCsg/rZDPxcxrrDrtzAcum1B8j4gTkqj0NLe
         en9O7rOnvqqyggowmKPE4BeGmXuDlKMcTntGHaJ3PwQamtksLtjybpR/aPxmhpwVMg
         pA2qJizPk36y4j50+h95mxHjC0e9BVblhawKMwatNS0D4RpoUMf6u6kUMoXnrzZfTH
         6NXMp7SKRpNPotFkq14UcIQPtJFT6KTkDsDWLgb0zPPUVkbS/L4c+4E5yToxy65t3j
         CT26aaydcxB2A==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, pali@kernel.org,
        josef.schlehofer@nic.cz,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH linux-phy v2 1/4] string.h: Add str_has_proper_prefix()
Date:   Wed, 17 Aug 2022 22:03:32 +0200
Message-Id: <20220817200335.911-2-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220817200335.911-1-kabel@kernel.org>
References: <20220817200335.911-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add str_has_proper_prefix(), similar to str_has_prefix(), but requires
that the prefix is proper: the string itself must be longer than the
prefix.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
Andy, Kees, could you ack this if it is ok?
---
 include/linux/string.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 61ec7e4f6311..375f51b9182c 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -316,4 +316,22 @@ static __always_inline size_t str_has_prefix(const char *str, const char *prefix
 	return strncmp(str, prefix, len) == 0 ? len : 0;
 }
 
+/**
+ * str_has_proper_prefix - Test if a string has a proper prefix
+ * @str: The string to test
+ * @prefix: The string to see if @str starts with
+ *
+ * This is like str_has_prefix(), but fails if the strings are equal.
+ *
+ * Returns:
+ * * strlen(@prefix) if @str starts with @prefix and they aren't equal
+ * * 0 otherwise
+ */
+static __always_inline size_t str_has_proper_prefix(const char *str,
+						    const char *prefix)
+{
+	size_t len = strlen(prefix);
+	return strncmp(str, prefix, len) == 0 && len != strlen(str) ? len : 0;
+}
+
 #endif /* _LINUX_STRING_H_ */
-- 
2.35.1

