Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4E0546F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 23:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350815AbiFJVfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 17:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350668AbiFJVfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 17:35:10 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5DE59966
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 14:35:07 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gl15so433818ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 14:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jlsqq7ENvzaBFmYrM2EurpWQmALPa/xYxdqi5jsfiWY=;
        b=CXF+NeUoCyYJUvbNACNtBhwGfBuGl/3hLER61cBCZPQ7uXOUZldZy83nBEMs77hhqN
         BL6+m5kaNZ3H4xImv0ykiTvblGE1e4GBPCsiobg0vr192yJdFpOOfQxu6BahlTTHi2mk
         N5j3FUWMqS/DwNSBh0ARdPbBjd9Cyiy/usgR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jlsqq7ENvzaBFmYrM2EurpWQmALPa/xYxdqi5jsfiWY=;
        b=JOCUV3gB8W0g3i1zNnCbJuSFaSRvqRLL/FHi6SYMwylHZtz7mtRGb3a09fcpoPy3BY
         bKzt9rFXNnzFUAAhMXmNRZOzliYWa2+R0zZ63/G4btd4hmtVREjXbDQx16YbxrT9LGpN
         Nm6IIeXEvTGYy8Y7iJ70T46gRblhqW00tBzgmUOlaJ/vPvllQ2RBSvF/EUN4An5jsFFA
         pm6sCSqoiZkrPqZD1O7wEnyjprH/HFDqZ89u1ELVxaSW2ikLtBDjYUeV/1+uycZ05c2/
         78sTMJgKVTAyF4FqKkIFRJhaZrfIOpEFw25o+dkas7aO2AgQOZkiZ62zBkMpkEsrMJdb
         qVsw==
X-Gm-Message-State: AOAM530Tl//btCnBsYSNpZcOO+fFTeDIoV3+1mO5qlPoPELhtcSr+ms/
        U8R/tMQAu3vrNgpC1utqkRTX+w==
X-Google-Smtp-Source: ABdhPJy/68a6lYrN5y9k/UonqDtcQMXjmnR26kEr0kn41xqIIOcZuheVhyVvg6y4boW5DKUtnd3hpA==
X-Received: by 2002:a17:907:868c:b0:6fe:fd7a:e0d7 with SMTP id qa12-20020a170907868c00b006fefd7ae0d7mr41997149ejc.90.1654896905963;
        Fri, 10 Jun 2022 14:35:05 -0700 (PDT)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id f16-20020a170906085000b006fec4ee28d0sm80783ejd.189.2022.06.10.14.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 14:35:05 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] kbuild: use a pipe rather than process substitution
Date:   Fri, 10 Jun 2022 23:34:52 +0200
Message-Id: <20220610213453.630304-1-alvin@pqrs.dk>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Bash process substitution of the form `foo < <(bar)`, as found in
scripts/check-local-export, can cause issues in chrooted environments
and with tools such as pseudo. The blamed commit started to cause build
errors for me when using the Yocto project's devshell environment;
devshell uses pseudo internally:

.../scripts/check-local-export: line 51: /dev/fd/63: No such file or directory

Replace the process substitution with a simple pipe into the while loop.
This is functionally equivalent and more portable than the former. Note
that pipefail is enabled so that the script terminates when ${NM} fails.

Link: https://bugzilla.yoctoproject.org/show_bug.cgi?id=13288
Fixes: 31cb50b5590f ("kbuild: check static EXPORT_SYMBOL* by script instead of modpost")
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 scripts/check-local-export | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/scripts/check-local-export b/scripts/check-local-export
index da745e2743b7..42de6f8f2541 100755
--- a/scripts/check-local-export
+++ b/scripts/check-local-export
@@ -7,12 +7,24 @@
 # EXPORT_SYMBOL should be used for global symbols.
 
 set -e
+set -o pipefail
 
 declare -A symbol_types
 declare -a export_symbols
 
 exit_code=0
 
+# If there is no symbol in the object, ${NM} (both GNU nm and llvm-nm)
+# shows 'no symbols' diagnostic (but exits with 0). It is harmless and
+# hidden by '2>/dev/null'. However, it suppresses real error messages
+# as well. Add a hand-crafted error message here.
+#
+# Use --quiet instead of 2>/dev/null when we upgrade the minimum version
+# of binutils to 2.37, llvm to 13.0.0.
+#
+# Then, the following line will be really simple:
+#   done < <(${NM} --quiet ${1})
+(${NM} ${1} 2>/dev/null || { echo "${0}: ${NM} failed" >&2; false; } ) | \
 while read value type name
 do
 	# Skip the line if the number of fields is less than 3.
@@ -37,21 +49,7 @@ do
 	if [[ ${name} == __ksymtab_* ]]; then
 		export_symbols+=(${name#__ksymtab_})
 	fi
-
-	# If there is no symbol in the object, ${NM} (both GNU nm and llvm-nm)
-	# shows 'no symbols' diagnostic (but exits with 0). It is harmless and
-	# hidden by '2>/dev/null'. However, it suppresses real error messages
-	# as well. Add a hand-crafted error message here.
-	#
-	# Use --quiet instead of 2>/dev/null when we upgrade the minimum version
-	# of binutils to 2.37, llvm to 13.0.0.
-	#
-	# Then, the following line will be really simple:
-	#   done < <(${NM} --quiet ${1})
-done < <(${NM} ${1} 2>/dev/null || { echo "${0}: ${NM} failed" >&2; false; } )
-
-# Catch error in the process substitution
-wait $!
+done
 
 for name in "${export_symbols[@]}"
 do
-- 
2.36.1

