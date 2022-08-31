Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE3F5A85F1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiHaSoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbiHaSoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:44:16 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C4E242
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:44:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-340e618b145so141881327b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=6le8oKuVgvil+VEktUjcgmMbP4uznetVRcbKqcwmc9g=;
        b=hOSBJ0dhMM/gcYrV4pHQaaLJizqGUf7PQqU9HmaLDYXQMBvqqV8eJtVT2xij1ey8fW
         xA18V4atnIwDoGam9xmx8sC/ETkDGJyKaYMZYOodeaXCVISFSeBXTag+sHDiVL5IEtjN
         baY8Wv7c3EYa3B1s2Dvd/wKmwFB2IXABSbOJcq3vBKYB+6EGYHPZ61tcveP91ULX47vj
         BOiD3cYEKzcI1t+aKx9dC3cDkyFy09WVOhFbOjdDg/QdShRYru0Ht0/nBSb6vmySyqon
         9QQvFO4hj1Bn976gID72FEHd78xT5FiynWo8dKXnH7T4P78M/PiMV0dAHUF4wQ34ndCY
         HzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=6le8oKuVgvil+VEktUjcgmMbP4uznetVRcbKqcwmc9g=;
        b=s4FTL9hhUjYCR0q1OiIDnfdgGdE/Noeh2k5gwSsmOchx+OB4EJr0dKzKhJMpJstvvq
         XPFhVZ+LsxJRD6CoT2/u54x2ZIpZXzFP9xjkVICXoLovzdGXmie9rUp1c2uz8L3tkg7N
         rDlG0gHvJM82JYtau3j3IT+z7qCIVMwDnbzhR87ja4gDRm1NVDpT8O6W0Cu/jiFajGTr
         vjQzbzDd/ieANUkMKwPltflOe56DSjU9ctmbn85N7s9TlSFfxhZ9FlbGDr894B0M37gn
         8ipHQezZvKptU8biXF1mmsOQRILWMWFj6BtUmkmmXWl+ogCr0OvjyG+3+DmG13tsCAV+
         C/PA==
X-Gm-Message-State: ACgBeo0nxo/wEYU0laSJSppcLu42hJN5ttXsCVRCDvIte+Fnpf45+/bP
        +BxsJQEd7kBKJ4vlaUi19xNJIbYajQSKwqppB48=
X-Google-Smtp-Source: AA6agR45wDOUkCh/L2HDnf9K1endI406O6j9IzYUDsAfQICWpUAgKXoC+Rp0ECqLGm7Um6L/2tphQDrnjlqrAKim+p0=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:0:100e:712:5f5d:95d5:9a3:d41])
 (user=ndesaulniers job=sendgmr) by 2002:a0d:f045:0:b0:324:55ec:6595 with SMTP
 id z66-20020a0df045000000b0032455ec6595mr19520284ywe.255.1661971454809; Wed,
 31 Aug 2022 11:44:14 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:44:04 -0700
In-Reply-To: <20220831184408.2778264-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20220831184408.2778264-1-ndesaulniers@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1661971448; l=1613;
 i=ndesaulniers@google.com; s=20211004; h=from:subject; bh=SUQQIb6Y+sTgOkn8ylHM+uEVIsOT1dvilITBQ2Hta9o=;
 b=nLKSJd3L/Tgv6SsitOrCoIehfWuY3K87K27T3Hn17A3aSaePVrNvQiC6Dlex7MqpilBpzEIeUbf9
 F8/QrNuIA98h1PJISpPwZ7+m08r3OLYFGMEeVu5PDfeUL7B2Kwdb
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220831184408.2778264-2-ndesaulniers@google.com>
Subject: [PATCH v2 1/5] x86/boot/compressed: prefer cc-option for CFLAGS additions
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev, x86@kernel.org,
        Dmitrii Bundin <dmitrii.bundin.a@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Bill Wendling <morbo@google.com>,
        Greg Thelen <gthelen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
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

We have an issue where as-option is testing new options with accumulated
CFLAGS. This makes it so that we can't use as-option to update AFLAGS
since many CFLAGS aren't valid AFLAGS. This is being fixed in a follow
up patch. Before doing so, move the assembler test for
-Wa,-mrelax-relocations=no from using as-option to cc-option.

Cc: Arvind Sankar <nivedita@alum.mit.edu>
Cc: x86@kernel.org
Link: https://lore.kernel.org/llvm/CAK7LNATcHt7GcXZ=jMszyH=+M_LC9Qr6yeAGRCBbE6xriLxtUQ@mail.gmail.com/
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v1 -> v2:
* Split off of v1 [1/3].
* Use cc-option to update CFLAGS, as per Masahiro.
* Add Masahiro's Suggested-by, Cc Arvind.

 arch/x86/boot/compressed/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 35ce1a64068b..85934204d905 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -49,7 +49,7 @@ KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS += -D__DISABLE_EXPORTS
 # Disable relocation relaxation in case the link is not PIE.
-KBUILD_CFLAGS += $(call as-option,-Wa$(comma)-mrelax-relocations=no)
+KBUILD_CFLAGS += $(call cc-option,-Wa$(comma)-mrelax-relocations=no)
 KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
 
 # sev.c indirectly inludes inat-table.h which is generated during
-- 
2.37.2.672.g94769d06f0-goog

