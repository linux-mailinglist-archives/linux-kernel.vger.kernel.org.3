Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA12471C9F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 20:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhLLTbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 14:31:07 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:25056 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhLLTbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 14:31:02 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 1BCJTqAl000552;
        Mon, 13 Dec 2021 04:29:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 1BCJTqAl000552
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639337394;
        bh=sqXOYwkFablz41E0oWMVhTZpxyt50WK1mBZfVI4Zx3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H205vjUCdYO6xAa7AFuA6ENjwwIOzFL+Gy1a1mP8wKMOfFtNWIZZryXg+wyNaw7OA
         IbKTWhQfZxQAS5If5CCA9FFh52sabHUa830/BZElnjhRK85oG47czr0t5h2e7wuHEF
         30gJNIaW8WjXihtwxDZpp8fxp8/s73Os/PWoXEVe4g8c0nmJffHHamdsFP4eMQ8FiI
         OJnhsaY8wDwV/HABFtHvDFxGmkYXr1nf8sEUe36r5AUkMIIprKKdubTgJUox6RMH/A
         6r/+9b2p4qPI6ICJsDFk1PfI+vFtonVtd11TRGAHUack5exrLUidPuguKzkXa2dCx9
         cK+pWYUZAqV5Q==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 01/10] certs: use $@ to simplify the key generation rule
Date:   Mon, 13 Dec 2021 04:29:32 +0900
Message-Id: <20211212192941.1149247-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211212192941.1149247-1-masahiroy@kernel.org>
References: <20211212192941.1149247-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not repeat $(obj)/signing_key.pem

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 certs/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/certs/Makefile b/certs/Makefile
index a702b70f3cb9..97fd6cc02972 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -61,8 +61,7 @@ keytype-$(CONFIG_MODULE_SIG_KEY_TYPE_ECDSA) := -newkey ec -pkeyopt ec_paramgen_c
 quiet_cmd_gen_key = GENKEY  $@
       cmd_gen_key = openssl req -new -nodes -utf8 -$(CONFIG_MODULE_SIG_HASH) -days 36500 \
 		-batch -x509 -config $(obj)/x509.genkey \
-		-outform PEM -out $(obj)/signing_key.pem \
-		-keyout $(obj)/signing_key.pem $(keytype-y) 2>&1
+		-outform PEM -out $@ -keyout $@ $(keytype-y) 2>&1
 
 $(obj)/signing_key.pem: $(obj)/x509.genkey FORCE
 	$(call if_changed,gen_key)
-- 
2.32.0

