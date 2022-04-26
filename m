Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E11451023B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352637AbiDZPz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352633AbiDZPzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:55:55 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B68474DED;
        Tue, 26 Apr 2022 08:52:47 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b12so15844769plg.4;
        Tue, 26 Apr 2022 08:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GC7DL53ai6k3NGlh2GS+CUKAHaq0iiM5lF16d5uI1v8=;
        b=HjsRLxrVtAKkoXCItST1hFzeyRKLJdMwwGTDD1KhKkHSp9U9y5kpKCLSfd7wMxX0Wy
         gPeOc0mTaTm5Wgz786M7UZjpZTkjdVxM+UA2cC/eAoZLDIAABa3MJVe1rm/kpv85TtgD
         3oZfZ331K0YC8NS26H6THAeZKI/bq0FmOIuMAWtQOQs1ZTUm2a2PqBsD/TDYLB0Sxvoa
         tLH13vv7DUIUcg5Tg+EPNKgtfxR4bIu28DcVgPUi7BuNd0vwHa57NFwbeOZNUtMjCDEN
         AssUR8EWhtheGo9umFo7IiAMRrQztNiXtorp/cTgg6QiCcak3zOC5t8e7yz6FLJTkUrp
         t6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=GC7DL53ai6k3NGlh2GS+CUKAHaq0iiM5lF16d5uI1v8=;
        b=z32zwswefSS/qE2NAqIcbqnaVzNH2Jzdi6YMEk+g/VzarrfLhcEWd4WjrB3s8cbBwN
         WKenbNXgULY+zevf3doA0c/dxY4r9+kh+bIGt2AemaBm2auGZlSPGBTJP2ANIV/BvOIq
         fnFfroLO8aKsgt8dbIn58IIDtV2myYuVF92UiVqKc3UynPGNrw4CFGIu5IGbHEgDpg6I
         KKd/NobAzo0aNIUBV/Ra+ywORBo5MF01CM4p3FCrp5XRNeVvCKPUWD+patlo69nmhpPq
         DdJdqH/nVVmD5YHunDsdt17uBhdl2zHooiRzOw/65Ku6ZcIxw1eoPiMvBBduMOGWcC4i
         P0fg==
X-Gm-Message-State: AOAM532ILt+iazsKAq6fqMBKK8TucdMybPWbY8Gk7cs9rpEeFdFk1exj
        lgoD8LREgIOq3qiJ44+1PxI=
X-Google-Smtp-Source: ABdhPJx1srVR9TBBVXc+NkJTALo2Bg9NrDLgeyjKGSuPMtZpd7O2FF5aF1WXzRnW91TsfavQDbZ3uw==
X-Received: by 2002:a17:903:1248:b0:151:9708:d586 with SMTP id u8-20020a170903124800b001519708d586mr24057168plh.15.1650988366668;
        Tue, 26 Apr 2022 08:52:46 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id g10-20020a17090ace8a00b001cd4989ff64sm3515376pju.43.2022.04.26.08.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 08:52:45 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH] kbuild: call checksyscalls.sh and check-atomics.sh only if prerequisites change
Date:   Wed, 27 Apr 2022 00:52:29 +0900
Message-Id: <20220426155229.436681-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, checksyscalls.sh and check-atomics.sh are executed
unconditionally. Most developers will not modify the files being
checked by those scripts and thus do not need to execute these again
for each iterative make. Change Kbuild target so that those two
scripts get executed only if the prerequisite are modified.

In order to implement this we:

  1. use the if_change macro instead of cmd. c.f. [1]

  2. create two dot files: scripts/.checksyscalls and
  scripts/atomic/.check-atomics to keep track of whether the script
  were already executed or not. Otherwise, the prerequisite would
  always be considered as newer than the target (c.f. output "due to
  target missing" of make V=2).

  3. modify the CLEAN_FILES target of the root Makefile to removed the
  two temporary dot files created in 2.

We also added an additional dependency to include/linux/atomic/* for
check-atomics.sh to make sure that the script gets executed again if
the header are modified. check-atomics.sh already has a dependency
toward include/generated/asm-offsets.h and so no additional
dependencies were added.

[1] https://www.kernel.org/doc/html/latest/kbuild/makefiles.html#command-change-detection

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Sending this as RFC because I am not an expert of Kbuild. The use of
the dot files was my best shot at tackling this issue. Maybe there is
a smarter way which I just missed?

If I receive no comments for the next two weeks, I will resend this
patch without the RFC tag.
---
 Kbuild   | 14 ++++++++------
 Makefile |  3 ++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/Kbuild b/Kbuild
index fa441b98c9f6..d579f4971aa3 100644
--- a/Kbuild
+++ b/Kbuild
@@ -39,21 +39,23 @@ $(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
 #####
 # Check for missing system calls
 
-always-y += missing-syscalls
+always-y += scripts/.missing-syscalls
 
 quiet_cmd_syscalls = CALL    $<
       cmd_syscalls = $(CONFIG_SHELL) $< $(CC) $(c_flags) $(missing_syscalls_flags)
 
-missing-syscalls: scripts/checksyscalls.sh $(offsets-file) FORCE
-	$(call cmd,syscalls)
+scripts/.missing-syscalls: scripts/checksyscalls.sh $(offsets-file) FORCE
+	$(call if_changed,syscalls)
+	@touch $@
 
 #####
 # Check atomic headers are up-to-date
 
-always-y += old-atomics
+always-y += scripts/atomic/.old-atomics
 
 quiet_cmd_atomics = CALL    $<
       cmd_atomics = $(CONFIG_SHELL) $<
 
-old-atomics: scripts/atomic/check-atomics.sh FORCE
-	$(call cmd,atomics)
+scripts/atomic/.old-atomics: scripts/atomic/check-atomics.sh $(wildcard include/linux/atomic/*) FORCE
+	$(call if_changed,atomics)
+	@touch $@
diff --git a/Makefile b/Makefile
index fa5112a0ec1b..b18af9d4248a 100644
--- a/Makefile
+++ b/Makefile
@@ -1483,7 +1483,8 @@ endif # CONFIG_MODULES
 # Directories & files removed with 'make clean'
 CLEAN_FILES += include/ksym vmlinux.symvers modules-only.symvers \
 	       modules.builtin modules.builtin.modinfo modules.nsdeps \
-	       compile_commands.json .thinlto-cache
+	       compile_commands.json .thinlto-cache \
+	       scripts/.missing-syscalls scripts/atomic/.old-atomics
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_FILES += include/config include/generated          \
-- 
2.35.1

