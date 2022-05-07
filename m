Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97E951E74E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 15:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446467AbiEGNQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 09:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446466AbiEGNQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 09:16:49 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4984666F
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 06:13:02 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id qe3-20020a17090b4f8300b001dc24e4da73so9250781pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 06:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zjch41DGKwtjob6zJCWThmkugQGSUhNZeUMcVYURjQw=;
        b=hz0KK1bSS2F4PJnEMw/jSlYYG/MTbmWhLmJYP2HDRg7s/nypCnOGJV7The9LID8yBG
         K15VWmepZN4FyUF6e+uUHCqveUMibPb29QMlLnohAuF+XfFzgaW+OWk/KGy7ceGABFkJ
         rQi2o4Z6OY3RsXskX5KyU4twCnVXsiTFSRjQgY8Hml/nwpUXrrjs8KMYK0D/isbwDD3I
         wGDplUg9UgdcYOYQEC1ENq/GCcPxCZOOJ4c8wfL68RFkwBOHkLtRbBTo9a4NqV9QX5i3
         10PdsNaDlXpnecgzFzyFID8/JZAphd3MacwyLiCeobiKIGLCj/BnsMpeU7P5BKmAXzYI
         IrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Zjch41DGKwtjob6zJCWThmkugQGSUhNZeUMcVYURjQw=;
        b=KtdZwAvXWM1HSR50XbgSqtZi+jUr/D082i16Iolen5cLoM4Sxwl2gILaAggOg+Hj+t
         35NoM0Y0KanOdhTnNYN2t6oRpQKghfVBqdwvlwUWn2HENFGDqdiZgXsViRYm/t3aROs5
         5Ws9Ryr53iYEL4GNAbA0y/VuPtZO0VOhQY+XQOQULutz6Qr2sfMggNjIgCV8bm14Olo5
         IddFgtTGE3NPT9EifEDHAcHnbUeGzkHBAAB8xd0wtppVi0ESzvgN/Tm+a/bnzsxkmDz3
         Iy7SJEyv7u7i8xlW+4HqccCxL+eTq7wgjZG1EAJCMTa/REIUpPDb+BLaRJ8g1JjBR0Uy
         YweA==
X-Gm-Message-State: AOAM531p9jhs8wm2DSioz98CL15ooM+x4G5N5WPdorfZSU0aT3r8ISdR
        sXn+9F01+8VO/pH6jCOD0T0=
X-Google-Smtp-Source: ABdhPJwFhmb5L9Rcxt4JFbUgeRj/jPEvyLFfYyz8Z1mU/mGvJCEOtZDuMRA0U29mYx59cdH8uJlImA==
X-Received: by 2002:a17:90b:1a88:b0:1dc:8e84:9133 with SMTP id ng8-20020a17090b1a8800b001dc8e849133mr9397979pjb.231.1651929182627;
        Sat, 07 May 2022 06:13:02 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i191-20020a639dc8000000b003c14af50620sm571418pgd.56.2022.05.07.06.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 06:13:02 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH v2 2/2] kbuild: call check-atomics.sh only if prerequisites change
Date:   Sat,  7 May 2022 22:11:45 +0900
Message-Id: <20220507131146.834810-3-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220507131146.834810-1-mailhol.vincent@wanadoo.fr>
References: <20220426155229.436681-1-mailhol.vincent@wanadoo.fr>
 <20220507131146.834810-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check-atomics.sh is executed unconditionally. Most developers will not
modify the files being checked by this script and thus do not need to
execute it again for each iterative make.

We first add an additional dependency to include/linux/atomic/* to
make sure that the script gets executed again if the headers are
modified. We then use the if_change macro instead of cmd. c.f. [1] and
create the dot file scripts/atomic/.check-atomics which is used for
the target timestamp. Finally, the dot file is added to the
CLEAN_FILES target.

[1] https://www.kernel.org/doc/html/latest/kbuild/makefiles.html#command-change-detection

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 Kbuild   | 7 ++++---
 Makefile | 3 ++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Kbuild b/Kbuild
index fa441b98c9f6..c3cb76ebcbaf 100644
--- a/Kbuild
+++ b/Kbuild
@@ -50,10 +50,11 @@ missing-syscalls: scripts/checksyscalls.sh $(offsets-file) FORCE
 #####
 # Check atomic headers are up-to-date
 
-always-y += old-atomics
+always-y += scripts/atomic/.check-atomics
 
 quiet_cmd_atomics = CALL    $<
       cmd_atomics = $(CONFIG_SHELL) $<
 
-old-atomics: scripts/atomic/check-atomics.sh FORCE
-	$(call cmd,atomics)
+scripts/atomic/.check-atomics: scripts/atomic/check-atomics.sh $(wildcard include/linux/atomic/*) FORCE
+	$(call if_changed,atomics)
+	@touch $@
diff --git a/Makefile b/Makefile
index 9a820c525b86..9e815c8bb0b6 100644
--- a/Makefile
+++ b/Makefile
@@ -1483,7 +1483,8 @@ endif # CONFIG_MODULES
 # Directories & files removed with 'make clean'
 CLEAN_FILES += include/ksym vmlinux.symvers modules-only.symvers \
 	       modules.builtin modules.builtin.modinfo modules.nsdeps \
-	       compile_commands.json .thinlto-cache
+	       compile_commands.json .thinlto-cache \
+	       scripts/atomic/.check-atomics
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_FILES += include/config include/generated          \
-- 
2.35.1

