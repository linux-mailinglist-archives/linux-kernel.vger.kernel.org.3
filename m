Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DB15955FE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiHPJOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiHPJNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:13:50 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BF4E096F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:29:27 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 7D589413B5;
        Tue, 16 Aug 2022 12:29:22 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1660634963; bh=KO2yBCCsjyqMCOIjGZUnVjiLjyzF2mSA6vth3iKlpFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hyKSTkBpeELAqETpHujZtkVzXW8QG+Ln6oD4o87dZSJNTi0U/fL/lyiJ02aWGKclm
         RBe7FaIlZJxDXzIHCr3pmHd/fSqy+ZUJhRg9glXvq5gqWNmycMT6aVu1UzrN6qfCPA
         MDJw56YBxACMrQHM5d2SSd6bwBjhGSFcOW1k7OqeviDLrSlFIp8EXMcObBMfw4ORcO
         mi5UmsntLQNA/t6er3NYGU8dhVi4SwLYhR3CRvfeRt1Sm9qIKEnkPLuRiwFgmw49W7
         DyhVdtpUv6jg+h6cZUqgAIySs1Lm5Kw1Z6fitn0kz4ZFaKR9j3AJwnD9gVNp8BdFGe
         sQkSlewmF/cjA==
From:   Nikita Travkin <nikita@trvn.ru>
To:     samuel.thibault@ens-lyon.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org, Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCHv4] speakup: Generate speakupmap.h automatically
Date:   Tue, 16 Aug 2022 12:28:43 +0500
Message-Id: <20220816072843.1699317-1-nikita@trvn.ru>
In-Reply-To: <20220612172244.il3siyq7ueqnvah5@begin>
References: <20220612172244.il3siyq7ueqnvah5@begin>
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

Hi,
I was building 6.0-rc1 and this patch seem to cause some compiling
issues. The u_char was not defined in my host build environment (I
suspect because of the musl based host) which leads to the makemapdata
failing to compile. Changing the file to use "unsigned char" seems to
solve the issue.

After that I also had some weird issues of the build system trying to
write speakupmap.h into the source dir and not the output dir (the
source is read only due to the tooling I use) but this seems to have
been resolved by cleanly rebuilding the speakup dir.

A patch changing the type follows.

Nikita

-- >8 --
From bc239d8740f9e31240e8727f76227daa1aec3c4f Mon Sep 17 00:00:00 2001
From: Nikita Travkin <nikita@trvn.ru>
Date: Tue, 16 Aug 2022 11:39:52 +0500
Subject: [PATCH] speakup: Fix compilation in some build environments

A compilation error may occur if the host CC doesn't have u_char
defined:

  HOSTCC  drivers/accessibility/speakup/makemapdata.o
In file included from ../drivers/accessibility/speakup/makemapdata.c:15:
../drivers/accessibility/speakup/utils.h: In function 'hash_name':
../drivers/accessibility/speakup/utils.h:57:9: error: unknown type name 'u_char'; did you mean 'char'?
   57 |         u_char *pn = (u_char *)name;
      |         ^~~~~~
      |         char

Fix this by using "unsigned char" instead.

Fixes: 6a5c94d92699 ("speakup: Generate speakupmap.h automatically")
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 drivers/accessibility/speakup/utils.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accessibility/speakup/utils.h b/drivers/accessibility/speakup/utils.h
index 4bf2ee8ac246..4ce9a12f7664 100644
--- a/drivers/accessibility/speakup/utils.h
+++ b/drivers/accessibility/speakup/utils.h
@@ -54,7 +54,7 @@ static inline int oops(const char *msg, const char *info)
 
 static inline struct st_key *hash_name(char *name)
 {
-	u_char *pn = (u_char *)name;
+	unsigned char *pn = (unsigned char *)name;
 	int hash = 0;
 
 	while (*pn) {
-- 
2.35.3

