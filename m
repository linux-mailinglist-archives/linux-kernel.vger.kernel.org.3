Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62644ECC6E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350060AbiC3Si3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352841AbiC3SgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:36:14 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA005674E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:34:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2e644c76556so177242097b3.15
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+4R6y5raOlQ9R0zgKhvV82ZZoP1rqgneLzWJSULXCiw=;
        b=RAY2GQBdP6QU7CEm44ojhugWJ8xRAoOO6+oUEcSqfyDWgQyRYGQITKPdKjv8eJYzGN
         LY1BA/9MGUQEmX+ZoVYJmWMkRzntR1qSqvzlqXMPUkuQEvPHa01sV10Ap9ca1oprkMvf
         +43CTdzJg06l+iU15m9il2lMPP0v0MPqsr9ATJ8XhV2Q23moPQirq11ytF1vQANecIjD
         LdteUME8glkX6ZpSgNTTbYO91h0ZqV8r2ZiuLqEaCwyWd0g9mWHno70bqZ+5bqODCbXd
         aEYgg3SQ4pEju+a9LZNd8C/eXMUjFP6MIi00fHKysRwZbl/w1baALwFaNyqRVKha7ygj
         KNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+4R6y5raOlQ9R0zgKhvV82ZZoP1rqgneLzWJSULXCiw=;
        b=SG+AOxdj+8Nca4Z60J38Q7oyd+z4cCLqoYMbyC+Wq3E0y1kmdBe5FvppR3VYK7ui0o
         Pc/U8glrwxwQvASMpA4qj5f82pPLPEMBsW57UvUtwhiBpgpuQJbIfxgwcetfq7pSq0Od
         8AUNpQ8J5NG8F2R5EY9KTCxoNgR2edrs8HJtZfkAqZDYiQPwVF31gOUEq4rMaKTAVxlm
         5vgyHYuG1EhzfXo9Bis2hzVvSc3dTggBF/rJNyXorDGT0bRfCdk1SMRmdJuueLsgGpW2
         /UrpiErwbbDQdG5fZY9w3TQT0HYQxB85WTuynz38n3Bz9YVZBnNxDGvvGCxRsJ/u1BbF
         6U5g==
X-Gm-Message-State: AOAM530/Fh1lUCsjuXoQXJRxBumZqrXoB4EDih33Pb+bHWKuzP/1UdpA
        NzPlp3tmIPX1jhQIL/u0mGNFMv2jRk/fGUlZzJM=
X-Google-Smtp-Source: ABdhPJzyaSoM/0f9uqXbttdQDpbV5fsP4I95bt3jQtr9Iql7aVNodJffhghvwsqmlh2PtF+ZI60PSHvOXmIAZT/QbwA=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:2889:ef97:ceb1:6f72])
 (user=ndesaulniers job=sendgmr) by 2002:a81:ac15:0:b0:2e6:d7e3:c4ba with SMTP
 id k21-20020a81ac15000000b002e6d7e3c4bamr1177927ywh.10.1648665266195; Wed, 30
 Mar 2022 11:34:26 -0700 (PDT)
Date:   Wed, 30 Mar 2022 11:34:06 -0700
Message-Id: <20220330183409.2025109-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1648665246; l=1109;
 s=20211004; h=from:subject; bh=n8UsFP1cY/oLIUzC/8lmbuCD/y/IfhI2jrvMeC7MWXM=;
 b=N9+qRQNc6sFg7St0vUeHnTPdlVmfGySQ42D0YjOx8gq+O/AD+1GFKE7FwX9qwKLqNK+nuR5TvJpt
 zyrlQX0uCLjuby2gUgRarHoYqnk9q0SDrz0+XRcuUzfiHmzIV9Nl
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH] kbuild: uapi: use -fsyntax-only rather than -S
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UAPI header tests are checking that the generated headers do not
have syntax errors. There's no need to run the rest of the compilation
pipeline after semantic analysis has run. Replace -S -o /dev/null with
-fsyntax-only.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 usr/include/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/usr/include/Makefile b/usr/include/Makefile
index 7b283d43f00d..bf193e205dbe 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -89,7 +89,7 @@ extra-y := $(patsubst $(obj)/%.h,%.hdrtest, $(shell find $(obj) -name '*.h' 2>/d
 # Include the header twice to detect missing include guard.
 quiet_cmd_hdrtest = HDRTEST $<
       cmd_hdrtest = \
-		$(CC) $(c_flags) -S -o /dev/null -x c /dev/null \
+		$(CC) $(c_flags) -fsyntax-only -x c /dev/null \
 			$(if $(filter-out $(no-header-test), $*.h), -include $< -include $<); \
 		$(PERL) $(srctree)/$(src)/headers_check.pl $(obj) $(SRCARCH) $<; \
 		touch $@

base-commit: 74164d284b2909de0ba13518cc063e9ea9334749
-- 
2.35.1.1021.g381101b075-goog

