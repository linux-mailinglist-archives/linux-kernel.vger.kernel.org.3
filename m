Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD33546C6B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346558AbiFJSeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241313AbiFJSeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:34:17 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9A039141;
        Fri, 10 Jun 2022 11:34:10 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 25AIX5TQ020882;
        Sat, 11 Jun 2022 03:33:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 25AIX5TQ020882
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654885991;
        bh=lUG0NgnACAHHS74el4oK5OBZvnr8gUW/ueE3VkEfAzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TVkm43y1fPNy7bHuIMWG7DrGnrIceHzV6X1lU6v4ZL9E8/NLc7HBlXBUmeLQSrcTf
         O4tu6f8AtUkuDszRKWhXvE0+QRT6oE0/veGNGFRrDsUZYuV6Lr7pmYLf/Wqn2HVRO9
         /uLwGVNVsIKmT6fFuBQYzixM4f7RTMTIOfJNPDpVRIDtmNUddZISqgXF3Rb2Zro+0S
         KgX2+FF1wYwZg1gcIs8+lU+S9Ogy8K1keaZFccyqirv+3YTgnx1yvi9KiMC3oB1xRP
         on3+vNDPgO4kDl5oexNjxh1Ct/6vJSvmFKERWW6G5SrufMm+6fcg+kF8C3InAgdmXL
         xBLUSPmhkWKNw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Nicolas Pitre <npitre@baylibre.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] checkpatch: warn if <asm/export.h> is included
Date:   Sat, 11 Jun 2022 03:32:34 +0900
Message-Id: <20220610183236.1272216-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220610183236.1272216-1-masahiroy@kernel.org>
References: <20220610183236.1272216-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the previous refactoring,

 - <asm/export.h> is a wrapper of <asm-generic/export.h>
 - <asm-generic/export.h> is a wrapper of <linux/export.h>

My hope is to replace

   #include <asm/export.h>  -->  #include <linux/export.h>

for all *.S files.

For now, adding a warning in the checkpatch.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 503e8abbb2c1..f824d690a565 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3753,6 +3753,13 @@ sub process {
 			     "Avoid using '.L' prefixed local symbol names for denoting a range of code via 'SYM_*_START/END' annotations; see Documentation/asm-annotations.rst\n" . $herecurr);
 		}
 
+# warn if <asm/export.h> is included.
+# <asm/export.h> is a wrapper of <linux/export.h>. Please include <linux/export.h> directly.
+		if ($tree && $rawline =~ m{^.\s*\#\s*include\s*\<asm\/export\.h\>}) {
+			WARN("INCLUDE_LINUX_EXPORT",
+			    "Please include <linux/export.h> instead of <asm/export.h>\n" . $herecurr);
+		}
+
 # check we are in a valid source file C or perl if not then ignore this hunk
 		next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
 
-- 
2.32.0

