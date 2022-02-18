Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1767F4BB3F8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbiBRIMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:12:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbiBRIMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:12:38 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764E62019C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 00:12:20 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d6180e0ab4so36681957b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 00:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LY6LzpHZdIBxY444vO4HWJP1kgYlpz84LA6VZYt38hY=;
        b=lEuSn3l5pcezU1xInfoD249SjcfV6GaVFory27iWzbW7ZT7zmkar496VK30MXNJk7x
         789tElCsrFcMjN6iW4M0SbGSgFcN94e5GteBtfV6rt/GjbUNjQsnptSi3adn0kHyWwoj
         /AjelhWScjsbeOMhC+fHS+cHCVwAdMgloltoS9zdXhtqrQTvBapwSHCxhl3DjTB5fy38
         HNolxKHOxT0fBft8mmI3ZP4/+GjGdm9TltWJ4MhKH6Wm/utyS3p3X3HyKNiAAViTAbaZ
         GocNFUTq6VjrdohFHC8YgLDjm6I7O87roTjWj+vI+igE4vicWRZLPvIBkEazW6m5GkH5
         jb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LY6LzpHZdIBxY444vO4HWJP1kgYlpz84LA6VZYt38hY=;
        b=QsEizFHBc1KJYbscs3FsGPfCYlJllOFsesFw9J/G0Yf85rRPXQxttnIXoiN2YC4vjr
         l1tgfBSbsmqigUDQS0fR0gaaFClJ/zv8F6YVBzd71NHc0gCdUbfAbPWqCyl9LxQxjahu
         DHy/nX5aR0ZmFbTTirudCId2nV7dV+t7xRxDpwHgd6ooNWLyjcQAWlyTalSybWT5f3QE
         E/4lCWhp9bDCETJIE+1CSJ0lzCiCSh+PwQMy3aAYt/JfEskq/qQ8ju+HeA7SKViskXlW
         +o8zD2/gVkyq5EkcReYA4gpNtOSk9zGVbhEbQpbkPoF44jqPcR0V8+/kfbOeirERkYrT
         ZzCw==
X-Gm-Message-State: AOAM533WNWBciMxBwT4SDMMG+53H8UmnAXRH9F36zFDgY9DZd5/LelJG
        wuxn6+cIgmKolCbcTFqcEvsQDNWUsGH5
X-Google-Smtp-Source: ABdhPJyUH15xOgfJE/7Eoy6tw1EPASMqd2Dis3ZnH3C2ddCvFItgcrZSngmFaM+Jm6gD5vKMDevc9gHUk2Xe
X-Received: from maskray1.svl.corp.google.com ([2620:15c:2ce:200:bdb7:3728:9760:87c])
 (user=maskray job=sendgmr) by 2002:a81:364b:0:b0:2cf:5d3f:d256 with SMTP id
 d72-20020a81364b000000b002cf5d3fd256mr6356301ywa.458.1645171939884; Fri, 18
 Feb 2022 00:12:19 -0800 (PST)
Date:   Fri, 18 Feb 2022 00:12:09 -0800
Message-Id: <20220218081209.354383-1-maskray@google.com>
Mime-Version: 1.0
Subject: [PATCH] arm64 module: remove (NOLOAD)
From:   Fangrui Song <maskray@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ELF, (NOLOAD) sets the section type to SHT_NOBITS[1]. It is conceptually
inappropriate for .plt and .text.* sections which are always
SHT_PROGBITS.

In GNU ld, if PLT entries are needed, .plt will be SHT_PROGBITS anyway
and (NOLOAD) will be essentially ignored. In ld.lld, since
https://reviews.llvm.org/D118840 ("[ELF] Support (TYPE=<value>) to
customize the output section type"), ld.lld will report a `section type
mismatch` error. Just remove (NOLOAD) to fix the error.

[1] https://lld.llvm.org/ELF/linker_script.html As of today, "The
section should be marked as not loadable" on
https://sourceware.org/binutils/docs/ld/Output-Section-Type.html is
outdated for ELF.
---
 arch/arm64/include/asm/module.lds.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/module.lds.h b/arch/arm64/include/asm/module.lds.h
index a11ccadd47d2..094701ec5500 100644
--- a/arch/arm64/include/asm/module.lds.h
+++ b/arch/arm64/include/asm/module.lds.h
@@ -1,8 +1,8 @@
 SECTIONS {
 #ifdef CONFIG_ARM64_MODULE_PLTS
-	.plt 0 (NOLOAD) : { BYTE(0) }
-	.init.plt 0 (NOLOAD) : { BYTE(0) }
-	.text.ftrace_trampoline 0 (NOLOAD) : { BYTE(0) }
+	.plt 0 : { BYTE(0) }
+	.init.plt 0 : { BYTE(0) }
+	.text.ftrace_trampoline 0 : { BYTE(0) }
 #endif
 
 #ifdef CONFIG_KASAN_SW_TAGS
-- 
2.35.1.265.g69c8d7142f-goog

