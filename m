Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE11F468F37
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 03:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbhLFCjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 21:39:41 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:33935 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbhLFCjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 21:39:39 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 1B62Zi2B027181;
        Mon, 6 Dec 2021 11:35:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 1B62Zi2B027181
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1638758144;
        bh=1VfYTro9Ncr0XdEjK4cLP1MpZHiAlWQWbz6bzJAj5Rk=;
        h=From:To:Cc:Subject:Date:From;
        b=XrzyBW87qPx9/q9qOgYLdJHjlzATAbsVIlBnDhCqGq13Ud+A27KjjkabPhSKmUOrM
         LRqqU/nN8mNUgsvP0DWp6DWPdaudlYneUf7DtIoNtrSU1kUZss4I7DMZZO4s5zz9A4
         5ClIBVGHmRxn/RBgQS8QYkH2oLtI23hLP033Fn4hKmLl9S1jVXvgYX3CGdUn5oxKSJ
         sXnA3NkQhrNjNrQdA8eUAlpWm93GFgnUe4jk8MKndYuZBUARsHWLc9dyOjZxXJxsLu
         D1E8toyDrIbopH+2ksjqvOUS3DR9Gq6UTmRSXXVxspkVnQ+Y3T85DH+/XKfWjuwcqe
         3tGCS5IyMoujA==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] kbuild: move headers_check.pl to usr/include/
Date:   Mon,  6 Dec 2021 11:35:06 +0900
Message-Id: <20211206023507.447574-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This script is only used by usr/include/Makefile. Make it local to
the directory.

Update the comment in include/uapi/linux/soundcard.h because
'make headers_check' is no longer functional.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
 - Fix the comment in soundcard.sh to point to the new file path

 include/uapi/linux/soundcard.h            | 2 +-
 usr/include/Makefile                      | 2 +-
 {scripts => usr/include}/headers_check.pl | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename {scripts => usr/include}/headers_check.pl (100%)

diff --git a/include/uapi/linux/soundcard.h b/include/uapi/linux/soundcard.h
index f3b21f989872..ac1318793a86 100644
--- a/include/uapi/linux/soundcard.h
+++ b/include/uapi/linux/soundcard.h
@@ -1051,7 +1051,7 @@ typedef struct mixer_vol_table {
  *	the GPL version of OSS-4.x and build against that version
  *	of the header.
  *
- *	We redefine the extern keyword so that make headers_check
+ *	We redefine the extern keyword so that usr/include/headers_check.pl
  *	does not complain about SEQ_USE_EXTBUF.
  */
 #define SEQ_DECLAREBUF()		SEQ_USE_EXTBUF()
diff --git a/usr/include/Makefile b/usr/include/Makefile
index 1c2ae1368079..0e9c3e72f43a 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -99,7 +99,7 @@ quiet_cmd_hdrtest = HDRTEST $<
       cmd_hdrtest = \
 		$(CC) $(c_flags) -S -o /dev/null -x c /dev/null \
 			$(if $(filter-out $(no-header-test), $*.h), -include $< -include $<); \
-		$(PERL) $(srctree)/scripts/headers_check.pl $(obj) $(SRCARCH) $<; \
+		$(PERL) $(srctree)/$(src)/headers_check.pl $(obj) $(SRCARCH) $<; \
 		touch $@
 
 $(obj)/%.hdrtest: $(obj)/%.h FORCE
diff --git a/scripts/headers_check.pl b/usr/include/headers_check.pl
similarity index 100%
rename from scripts/headers_check.pl
rename to usr/include/headers_check.pl
-- 
2.32.0

