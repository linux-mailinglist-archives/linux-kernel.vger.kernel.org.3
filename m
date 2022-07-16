Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083D4576CDA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 11:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiGPJdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 05:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiGPJdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 05:33:39 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C91E2655C;
        Sat, 16 Jul 2022 02:33:39 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so13619775pjr.4;
        Sat, 16 Jul 2022 02:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NaserlcC6hSl3SwHUAah5zXW3IuFUW5WcFOL2/suCG8=;
        b=ByuL8OG9nl+Vf3yYQ4gi7DetKcxMxUMuJrV9E2E9JpIX5/jB8cp9mk57+YYI0NNSmV
         yaKq8Rr2yWGGDal8VYKW8NGP1kN+M7+xu/3q+KPIiBZUc1I8BMA2YvE8B/GELvSEEKOX
         i3yTCqFrmSekzm4KVTcvE/sEyqdgZ7EE8fwGsOcMN6f8ZAcSCovWerdNjxIg1FvYOfip
         bSg+hk+OGzkm9ctvm/h892XJ/5fusGSquZnpBwsDEBFfpoxqxm1AvbFWqD5c+bji4Bhg
         fPDoY9gDMs/bwV+eEITI+/xe50gVPOvkPEs9Pd9KJTTwzsD3S/+O7NfBbibePgTjZtC5
         cgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NaserlcC6hSl3SwHUAah5zXW3IuFUW5WcFOL2/suCG8=;
        b=opii/Plb1Nch9WTo4RPRH4MrrxEhxgO39hkj41ZXe7qaPuOhABBGe5yTz+jD3vHTZ6
         Nip0yRchZ7sm8BlERe52rXkm7SsRIUkeEHggwpWJ5JFDbrnATW+T2FXFcJog21QxhX9f
         EyXn+GrdZKQEH1mUGJMffc+MOBS8lWicvwSxKk7pDsss9D1lmFnpHg3zevBq0ePVhKmO
         4TgcNx9n9GzbE9tnP/y0vzzo3uWMm/i3jpWP22WlOK9OX/kCK1Z1ay15/Zxq1ZBVQNn9
         tVu9MELdKXtCZpguTRHyvjlLwwZYOjpw0F2lEMDzcD36I8cvnjKbUXliliz73ZklRrOp
         jXFQ==
X-Gm-Message-State: AJIora86or7q2nBSrnq6G5aceqh4obT94tuG16Ezzub8resT/6TmMouc
        TX01WpnsqC4eA+0/SPgXLvU=
X-Google-Smtp-Source: AGRyM1uSAFRt/vvd1YRX/u/uEw6Wixbw2nFqqMIBxadlr/p7/1iu7OmearIrb10VU4zG23rgJgwv9g==
X-Received: by 2002:a17:902:f64c:b0:16c:131:73ff with SMTP id m12-20020a170902f64c00b0016c013173ffmr17492991plg.170.1657964018733;
        Sat, 16 Jul 2022 02:33:38 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-23.three.co.id. [116.206.28.23])
        by smtp.gmail.com with ESMTPSA id c5-20020a170903234500b0016be8da658fsm5057280plh.130.2022.07.16.02.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 02:33:38 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 8C956103844; Sat, 16 Jul 2022 16:33:33 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Martin Liska <mliska@suse.cz>, Andi Kleen <ak@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kbuild@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 4/4] Documentation: lto: add LTO documentation to toc index
Date:   Sat, 16 Jul 2022 16:32:50 +0700
Message-Id: <20220716093249.19326-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220716093249.19326-1-bagasdotme@gmail.com>
References: <20220716093249.19326-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot reported toctree warning:

Documentation/kbuild/lto-build.rst: WARNING: document isn't included in any toctree

Add LTO documentation (lto-build.rst) to kbuild table of contents.

Link: https://lore.kernel.org/linux-doc/202207161100.lCdR6Unx-lkp@intel.com/
Fixes: 0350b4dd55922f ("Kbuild, lto: Add Link Time Optimization support")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/kbuild/index.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/kbuild/index.rst b/Documentation/kbuild/index.rst
index cee2f99f734b5a..1937eee7c43705 100644
--- a/Documentation/kbuild/index.rst
+++ b/Documentation/kbuild/index.rst
@@ -22,6 +22,8 @@ Kernel Build System
     gcc-plugins
     llvm
 
+    lto-build
+
 .. only::  subproject and html
 
    Indices
-- 
An old man doll... just what I always wanted! - Clara

