Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78CF51EE7D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 17:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbiEHPR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 11:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbiEHPRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 11:17:17 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 08 May 2022 08:13:27 PDT
Received: from mx1.arbitrary.ch (may.arbitrary.ch [IPv6:2a01:4f8:221:3641::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A07ADF20
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 08:13:27 -0700 (PDT)
Received: from [0.0.0.0] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: peter)
        by mx1.arbitrary.ch (Postfix) with ESMTPSA id C618314EE0D7;
        Sun,  8 May 2022 16:56:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=arbitrary.ch;
        s=mx1-arbitrary-ch; t=1652021793;
        bh=45/69u/Kyw1A3HHSPSfkFbn8AxFRBJSrAkChF2wibpI=;
        h=Date:From:To:Cc:Subject:From;
        b=P53WUHv/EG5cqw2Vn/+gR69BnnVreV6ecqcT+FqYOK3SEv5Ufb84ygSR+sBxc+gZy
         GTdK9X9YUa142/zTanEu6hjcusvas7Xo5ZsHLbrBy0LGoGdA4Pnb+g1eQ4FpXZIfPG
         sgAeI4tcpVyzD7Ymo276lAYI9N2yC4ZaoVHM1u8LONUwA88k9l17xm1N50BLJNZHVT
         OEWfjgrlOHt3eS5/daC5kvdDbWcZwF8tK7vtKeCkm0r3nZNTn19Rq+gA3YQOin+GWX
         4sV//jYK9rOjU2Lbwd/Q5OAto7NoZoiaReH/9rznJLmz00nkpIjVmQkwenFSIUcP2I
         A+JhN0F0cbSnA==
Message-ID: <8e472c9e-2076-bc25-5912-8433adf7b579@arbitrary.ch>
Date:   Sun, 8 May 2022 16:56:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
From:   Peter Gerber <peter@arbitrary.ch>
To:     kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] Decouple slub_debug= from no_hash_pointers again
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While, as mentioned in 792702911f58, no_hash_pointers is what
one wants for debugging, this option is also used for hardening.

Various places recommend or use slub_debug for hardening:

a) The Kernel Self Protection Project lists slub_debug as
   a recommended setting. [1]
b) Debian offers package hardening-runtime [2] which enables
   slub_debug for hardening.
c) Security- and privacy-oriented Tails enables slub_debug
   by default [3].

I understand that encountering hashed pointers during debugging
is most unwanted. Thus, I updated the documentation to make
it as clear as possible that no_hash_pointers is what one
wants when using slub_debug for debugging. I also added a
mentioned of the hardening use case in order to discourage
any other, well-meant, tries to disable hashing with slub_debug.

[1]: https://kernsec.org/wiki/index.php/Kernel_Self_Protection_Project/Recommended_Settings
[2]: https://packages.debian.org/bullseye/hardening-runtime
[3]: https://tails.boum.org/contribute/design/kernel_hardening/

Fixes: 792702911f58 ("slub: force on no_hash_pointers when slub_debug is enabled")
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/kernel-hardening/202204121715.11B2CA80@keescook/T/#t
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++--
 Documentation/vm/slub.rst                       | 10 ++++++++++
 include/linux/kernel.h                          |  2 --
 mm/slub.c                                       |  4 ----
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3f1cc5e317ed..8987c07e206c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5344,8 +5344,9 @@
 			culprit if slab objects become corrupted. Enabling
 			slub_debug can create guard zones around objects and
 			may poison objects when not in use. Also tracks the
-			last alloc / free. For more information see
-			Documentation/vm/slub.rst.
+			last alloc / free. If used for debugging, rather
+			than hardening, also set no_hash_pointers.
+			For more information see Documentation/vm/slub.rst.
 
 	slub_max_order= [MM, SLUB]
 			Determines the maximum allowed order for slabs.
diff --git a/Documentation/vm/slub.rst b/Documentation/vm/slub.rst
index d3028554b1e9..1ae6c27d0ff0 100644
--- a/Documentation/vm/slub.rst
+++ b/Documentation/vm/slub.rst
@@ -41,6 +41,16 @@ slub_debug=<Debug-Options>,<slab name1>,<slab name2>,...
 	Enable options only for select slabs (no spaces
 	after a comma)
 
+.. hint::
+
+   **Also enable no_hash_pointers** for debugging. Otherwise, only hashed
+   pointers are printed.
+
+   Hashing is disabled by default because this option, despite having
+   debug in its name, is also in useed to provide `additional hardening`_.
+
+.. _additional hardening: https://kernsec.org/wiki/index.php/Kernel_Self_Protection_Project/Recommended_Settings
+
 Multiple blocks of options for all slabs or selected slabs can be given, with
 blocks of options delimited by ';'. The last of "all slabs" blocks is applied
 to all slabs except those that match one of the "select slabs" block. Options
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index fe6efb24d151..e3d9d3879495 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -229,8 +229,6 @@ int sscanf(const char *, const char *, ...);
 extern __scanf(2, 0)
 int vsscanf(const char *, const char *, va_list);
 
-extern int no_hash_pointers_enable(char *str);
-
 extern int get_option(char **str, int *pint);
 extern char *get_options(const char *str, int nints, int *ints);
 extern unsigned long long memparse(const char *ptr, char **retptr);
diff --git a/mm/slub.c b/mm/slub.c
index ed5c2c03a47a..b78ccfde9214 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4800,10 +4800,6 @@ void __init kmem_cache_init(void)
 	if (debug_guardpage_minorder())
 		slub_max_order = 0;
 
-	/* Print slub debugging pointers without hashing */
-	if (__slub_debug_enabled())
-		no_hash_pointers_enable(NULL);
-
 	kmem_cache_node = &boot_kmem_cache_node;
 	kmem_cache = &boot_kmem_cache;
 
-- 
2.35.1

