Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6159D468E77
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 02:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhLFBJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 20:09:48 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:48716 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhLFBJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 20:09:47 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 1B615ljf028855;
        Mon, 6 Dec 2021 10:05:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 1B615ljf028855
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1638752747;
        bh=q1Op97abVoqIjR+56+86L5oiHgfExctj0V5BWNC95cs=;
        h=From:To:Cc:Subject:Date:From;
        b=wRmKe0+swy6Vvxx97MuvqPJKmZza04Q8ozI2mTfVhv28XJvNNJas+t8JMhO9aO9pj
         UDrTRkWQhv+kEaJ7agcOy37IP+ddU6ryRZErH6WMP5+Ups8o2L3jZuWulleQkfk8LV
         syyNGUmwEHMDPhvg/ZSCynZG0Kmy9saWQoumTRe2IMeLS5MFfVWgOoyobLlCKCHzBH
         q6c6zWJg1Qnmf/4EYj7f1+JRQzREyRBMsd98v0o0xucur04u4OKO73CSEQMU4lUxKA
         aoWu/qoGfXFJyW/8nr7M+mtfPWSLoGYSXDVZnIDq68wFdBnHD289mmZiLsTvG7EU2S
         555PEtNCECh+Q==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kbuild: move headers_check.pl to usr/include/
Date:   Mon,  6 Dec 2021 10:05:32 +0900
Message-Id: <20211206010533.439981-1-masahiroy@kernel.org>
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

 include/uapi/linux/soundcard.h            | 2 +-
 usr/include/Makefile                      | 2 +-
 {scripts => usr/include}/headers_check.pl | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename {scripts => usr/include}/headers_check.pl (100%)

diff --git a/include/uapi/linux/soundcard.h b/include/uapi/linux/soundcard.h
index f3b21f989872..57d1841cc4ed 100644
--- a/include/uapi/linux/soundcard.h
+++ b/include/uapi/linux/soundcard.h
@@ -1051,7 +1051,7 @@ typedef struct mixer_vol_table {
  *	the GPL version of OSS-4.x and build against that version
  *	of the header.
  *
- *	We redefine the extern keyword so that make headers_check
+ *	We redefine the extern keyword so that scripts/headers_check.pl
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

