Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C0F5476D9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 19:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238895AbiFKRXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 13:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236066AbiFKRXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 13:23:43 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C963CFD3;
        Sat, 11 Jun 2022 10:23:38 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 25BHMhjN022692;
        Sun, 12 Jun 2022 02:22:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 25BHMhjN022692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654968163;
        bh=nuJ9fX78Hn2THkCVuIttIKmGkLM6Dk/qRQ+cuZnHrm8=;
        h=From:To:Cc:Subject:Date:From;
        b=1RE3Uu54helDOf0cj2T9yhUCVy3XiBs+UO77ut4ySI4SO64ULrIRVOQ+HkNGmm+uG
         kzsxdHqrhl22d2von3RncQU0ZzcKSNLrCDLmZM7rAW8pEflxjxp3JiS7Cpe0kaGeed
         0mUwg2Z48gF2IdKpl9KZIAhMD0idS/YF5lI1dtPgIFMX+sNn+gWcHHW31bxchV5t0i
         KwTYeaTUJzcxIwK33X3u8Vg25ev0WrKZd/vZgw5Oy78R3pWrnyu5jQGB0cnE8s1KFC
         Z0bf1v6DqPtoFyl799xXm5JqwRM0PTRqyPpcnna8HMYTqf5rbCKc5MFUNHkPzCtYjR
         3FuFK5+b/4x+A==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?q?Micka=8F=AB=B3l=20Sala=8F=AB=E4n?= 
        <mic@linux.microsoft.com>, Masahiro Yamada <masahiroy@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] certs/blacklist_hashes.c: fix const confusion in certs blacklist
Date:   Sun, 12 Jun 2022 02:22:30 +0900
Message-Id: <20220611172233.1494073-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file fails to compile as follows:

  CC      certs/blacklist_hashes.o
certs/blacklist_hashes.c:4:1: error: ignoring attribute ‘section (".init.data")’ because it conflicts with previous ‘section (".init.rodata")’ [-Werror=attributes]
    4 | const char __initdata *const blacklist_hashes[] = {
      | ^~~~~
In file included from certs/blacklist_hashes.c:2:
certs/blacklist.h:5:38: note: previous declaration here
    5 | extern const char __initconst *const blacklist_hashes[];
      |                                      ^~~~~~~~~~~~~~~~

Apply the same fix as commit 2be04df5668d ("certs/blacklist_nohashes.c:
fix const confusion in certs blacklist").

Fixes: 734114f8782f ("KEYS: Add a system blacklist keyring")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 certs/blacklist_hashes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/certs/blacklist_hashes.c b/certs/blacklist_hashes.c
index 344892337be0..d5961aa3d338 100644
--- a/certs/blacklist_hashes.c
+++ b/certs/blacklist_hashes.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "blacklist.h"
 
-const char __initdata *const blacklist_hashes[] = {
+const char __initconst *const blacklist_hashes[] = {
 #include CONFIG_SYSTEM_BLACKLIST_HASH_LIST
 	, NULL
 };
-- 
2.32.0

