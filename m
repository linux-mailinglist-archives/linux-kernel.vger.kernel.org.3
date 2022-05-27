Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E7853644A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 16:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351830AbiE0OlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 10:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245525AbiE0OlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 10:41:03 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423C813C4DB;
        Fri, 27 May 2022 07:41:00 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 24REeJ2J013191;
        Fri, 27 May 2022 23:40:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 24REeJ2J013191
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653662420;
        bh=qJE4Lyed4RpdGGN2vQmVksXJyu1zJCIMzvjNxBAeCOs=;
        h=From:To:Cc:Subject:Date:From;
        b=xuC9fxTko81FYMxDk9S3HKVdt429R17J7GF44ILhG0qLAyDpVcV2Oe7z83bDeoNby
         EG5HD1/wEtLtKNEUK9CuryuKssQnqm1jUbIoNpkLjN0YnqQAydCmedGmSeEU7gUxnj
         0tIiKHvH/vOmZrvKUUI6/kggFLeVo+V91Gdo+XjAhEUEwLEuLAtoZXFo1ZDAyn0gSB
         8qi6UdpPHVjkYd3uuFxtpooBpYUD3YYE4HmJ26bBQM7jsEsd80moyWa+VITr/OTBt3
         MjckLvZj2Mtd6sz0U4bamxruIoV+DYWPOzMsw15ZftQoBD91XzNyDbeHTuy5RJuwZf
         f51yhqZx3XRtQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>,
        linux-parisc@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH] parisc: fix the exit status of arch/parisc/nm
Date:   Fri, 27 May 2022 23:39:31 +0900
Message-Id: <20220527143931.2161635-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parisc overrides 'nm' with a shell script. I was hit by a false-positive
error of $(NM) because this script returns the exit code of grep instead
of ${CROSS_COMPILE}nm. (grep exits with 1 if no lines were selected)

I tried to fix it, but in the code review, Helge suggested to remove it
entirely. [1]

This script was added in 2003. [2]

Presumably, it was a workaround for old toolchains (but even the parisc
maintainer does not know the detail any more).

Hopefully recent tools should work fine.

[1]: https://lore.kernel.org/all/1c12cd26-d8aa-4498-f4c0-29478b9578fe@gmx.de/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=36eaa6e4c0e0b6950136b956b72fd08155b92ca3

Suggested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

I want to apply this to kbuild tree with Helge's Ack

 arch/parisc/Makefile | 1 -
 arch/parisc/nm       | 6 ------
 2 files changed, 7 deletions(-)
 delete mode 100644 arch/parisc/nm

diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index aca1710fd658..e38d993d87f2 100644
--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -18,7 +18,6 @@
 boot := arch/parisc/boot
 KBUILD_IMAGE := $(boot)/bzImage
 
-NM		= sh $(srctree)/arch/parisc/nm
 CHECKFLAGS	+= -D__hppa__=1
 
 ifdef CONFIG_64BIT
diff --git a/arch/parisc/nm b/arch/parisc/nm
deleted file mode 100644
index c788308de33f..000000000000
--- a/arch/parisc/nm
+++ /dev/null
@@ -1,6 +0,0 @@
-#!/bin/sh
-##
-# Hack to have an nm which removes the local symbols.  We also rely
-# on this nm being hidden out of the ordinarily executable path
-##
-${CROSS_COMPILE}nm $* | grep -v '.LC*[0-9]*$'
-- 
2.32.0

