Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDB858379A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiG1De4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbiG1De0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:34:26 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6EB5C340;
        Wed, 27 Jul 2022 20:34:23 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ha11so820505pjb.2;
        Wed, 27 Jul 2022 20:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=j10ToGanO3cd/vYuHa5Kn8foeTs8uMlyZtELPg2UY1U=;
        b=ZCpCWijzlJKFs64G+1k7Jl5GKh6G4zOE6ybwGhhR/exQ9bGqHu5jiznO5HvWlqa/rJ
         6blTRDDSiBqKmbeZa1uCPh2Nyo9/0lSgoBae4muND+4qWPGNamj5AmdAYBJUEm7SGqbw
         HXf6QFOrlDBQfF0eLDtdaVtzxe79XUj6OMXvc70gPfydf9HkHcRXdr6fvkFRltTf5//h
         6Fy6RAqzfsW2N7ZbZKzdwib5zi2mCAOr5ScVrstEYPdirvZgJ8zOFm9HKdRn/Y5LPWwJ
         ZY60cdEvLCP8iXWLUhJQo99JJiatYHysQCuaGzKDYXD6AMFLvjVx1VTyMSLscmEAgq2B
         xtsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=j10ToGanO3cd/vYuHa5Kn8foeTs8uMlyZtELPg2UY1U=;
        b=3dLL3LT2qKsh8dbz4Bx4kgWtoBbBlMC6LVGI3xXskWibh6XCSGPyuGySavy565uRXE
         N0jObY7l9dbf70Zn3zjpy9VfmvG6sei46CJ9nhIgmdbRrtUxtIt0WPAyDSANFEicoLbC
         r9Akq1d9C55tSWBuO/qLd73TWyFWGK+ScZGff2mlDZPCpZElTS/jR9vGsMtyy8xTrDwy
         Fi9wBGe1payuBtHLM0y652fEVT8MDqfp7DdE/W8cynjCVi4XrxZrJaXditXGBlBlgFr4
         RwGhFiWA83Nte7GKnjmPfzIF7BWFiOxhS27M6mnhLxh0v6qenthx5M04/e+ld+UrZSY3
         5+cA==
X-Gm-Message-State: AJIora/UMYlmY4NBEjWpdw8lPgGbHY69mATFZqdWVGakJyWk6aFTVtTA
        2F4NRNdyYo4GYunhmFD63oA=
X-Google-Smtp-Source: AGRyM1stnTgNjHqQvTX8yokSMFJC+fEv40VFSklSquPlJzshMGe0L5wVcYIHWCUudBsD3zBQBgCCow==
X-Received: by 2002:a17:902:d54f:b0:16d:3bce:c40e with SMTP id z15-20020a170902d54f00b0016d3bcec40emr24861840plf.87.1658979262545;
        Wed, 27 Jul 2022 20:34:22 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-54.three.co.id. [116.206.12.54])
        by smtp.gmail.com with ESMTPSA id m17-20020a170902db1100b0016d33b8a231sm8418629plx.270.2022.07.27.20.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 20:34:21 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 5F5C7104A8C; Thu, 28 Jul 2022 10:34:16 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org, linux-next@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Nicholas Piggin <npiggin@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 2/3] Documentation: use different label names for each arch's elf_hwcaps.rst
Date:   Thu, 28 Jul 2022 10:33:32 +0700
Message-Id: <20220728033332.27836-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220727220050.549db613@canb.auug.org.au>
References: <20220727220050.549db613@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx reported duplicate label warning:

WARNING: duplicate label elf_hwcaps_index, other instance in Documentation/arm64/elf_hwcaps.rst

The warning is caused by elf_hwcaps_index label name is already used for
arm64 documentation, whileas powerpc use the same name.

Disambiguate the label name for each architecture's documentation. While
at it, also adjust original reference in translated documentation.

Link: https://lore.kernel.org/linuxppc-dev/20220727220050.549db613@canb.auug.org.au/
Fixes: 3df1ff42e69e91 ("powerpc: add documentation for HWCAPs")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/arm64/elf_hwcaps.rst                    | 2 +-
 Documentation/powerpc/elf_hwcaps.rst                  | 2 +-
 Documentation/translations/zh_CN/arm64/elf_hwcaps.rst | 2 +-
 Documentation/translations/zh_TW/arm64/elf_hwcaps.rst | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
index 3d116fb536c538..63b75080ec4544 100644
--- a/Documentation/arm64/elf_hwcaps.rst
+++ b/Documentation/arm64/elf_hwcaps.rst
@@ -1,4 +1,4 @@
-.. _elf_hwcaps_index:
+.. _elf_hwcaps_arm64:
 
 ================
 ARM64 ELF hwcaps
diff --git a/Documentation/powerpc/elf_hwcaps.rst b/Documentation/powerpc/elf_hwcaps.rst
index bb7438cebf36e8..3366e5b18e6759 100644
--- a/Documentation/powerpc/elf_hwcaps.rst
+++ b/Documentation/powerpc/elf_hwcaps.rst
@@ -1,4 +1,4 @@
-.. _elf_hwcaps_index:
+.. _elf_hwcaps_powerpc:
 
 ==================
 POWERPC ELF HWCAPs
diff --git a/Documentation/translations/zh_CN/arm64/elf_hwcaps.rst b/Documentation/translations/zh_CN/arm64/elf_hwcaps.rst
index 9aa4637eac979c..39a94ff5383c01 100644
--- a/Documentation/translations/zh_CN/arm64/elf_hwcaps.rst
+++ b/Documentation/translations/zh_CN/arm64/elf_hwcaps.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: :ref:`Documentation/arm64/elf_hwcaps.rst <elf_hwcaps_index>`
+:Original: :ref:`Documentation/arm64/elf_hwcaps.rst <elf_hwcaps_arm64>`
 
 Translator: Bailu Lin <bailu.lin@vivo.com>
 
diff --git a/Documentation/translations/zh_TW/arm64/elf_hwcaps.rst b/Documentation/translations/zh_TW/arm64/elf_hwcaps.rst
index 3eb1c623ce31b0..76164d851d0b5e 100644
--- a/Documentation/translations/zh_TW/arm64/elf_hwcaps.rst
+++ b/Documentation/translations/zh_TW/arm64/elf_hwcaps.rst
@@ -2,7 +2,7 @@
 
 .. include:: ../disclaimer-zh_TW.rst
 
-:Original: :ref:`Documentation/arm64/elf_hwcaps.rst <elf_hwcaps_index>`
+:Original: :ref:`Documentation/arm64/elf_hwcaps.rst <elf_hwcaps_arm64>`
 
 Translator: Bailu Lin <bailu.lin@vivo.com>
             Hu Haowen <src.res@email.cn>
-- 
An old man doll... just what I always wanted! - Clara

