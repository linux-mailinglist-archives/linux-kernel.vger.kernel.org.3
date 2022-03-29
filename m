Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F1F4EAB23
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbiC2KUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbiC2KUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:20:06 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116D431372
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:18:15 -0700 (PDT)
Received: from integral2.. (unknown [182.2.70.161])
        by gnuweeb.org (Postfix) with ESMTPSA id 8A8AE7E733;
        Tue, 29 Mar 2022 10:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648549094;
        bh=FxtBrp49dfrBIXa72go2hDycnGwH5xLsPNTZN2AYVhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z4PjSn0zimerFsS+87aNyp/EZZoZauwsQvsU/2PIY2lVb7zfdJTrrk0UbA8wg5+eF
         Z4dC8ou5hL1Ijrnpyxs3Grepe3q0OsrDqeON2quFdTebEgVyt/1cEzrnalRByFD2ds
         bawZlJEq6iS0vYxCCOT48JabpWTPFJubpOZarNknj/nPw7sa8EpLw+9XIYNTd1jTKN
         HzJODGnYbqk8quAduX3IC0sit5YH1A9C1q63CuoFWLaCp7lLlSBaLAhGZZzbRrwNVz
         +bVJHfyWZbuJ3BKSIOSeTjGOK7J8wVh3Xbb6hZKjVUrfgxiNZUQnznhOpmOtDupdK/
         84I1LYdb2BbEA==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [PATCH v2 8/9] tools/nolibc/string: Implement `strnlen()`
Date:   Tue, 29 Mar 2022 17:17:36 +0700
Message-Id: <20220329101737.58985-9-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220329101737.58985-1-ammarfaizi2@gnuweeb.org>
References: <20220329101737.58985-1-ammarfaizi2@gnuweeb.org>
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

  size_t strnlen(const char *str, size_t maxlen);

The strnlen() function returns the number of bytes in the string
pointed to by sstr, excluding the terminating null byte ('\0'), but at
most maxlen. In doing this, strnlen() looks only at the first maxlen
characters in the string pointed to by str and never beyond str[maxlen-1].

The first use case of this function is for determining the memory
allocation size in the strndup() function.

Link: https://lore.kernel.org/lkml/CAOG64qMpEMh+EkOfjNdAoueC+uQyT2Uv3689_sOr37-JxdJf4g@mail.gmail.com
Suggested-by: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
===

@@ Changelog:

   Link v1: https://lore.gnuweeb.org/gwml/20220324073039.140946-11-ammarfaizi2@gnuweeb.org
   v1 -> v2:
    * No changes *

   Link v2: https://lore.kernel.org/lkml/20220322102115.186179-8-ammarfaizi2@gnuweeb.org
   RFC v2 -> v1:
    * No changes *
---
 tools/include/nolibc/string.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 75a453870498..f43d52a44d09 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -147,6 +147,15 @@ size_t nolibc_strlen(const char *str)
 #define strlen(str) nolibc_strlen((str))
 #endif
 
+static __attribute__((unused))
+size_t strnlen(const char *str, size_t maxlen)
+{
+	size_t len;
+
+	for (len = 0; (len < maxlen) && str[len]; len++);
+	return len;
+}
+
 static __attribute__((unused))
 size_t strlcat(char *dst, const char *src, size_t size)
 {
-- 
Ammar Faizi

