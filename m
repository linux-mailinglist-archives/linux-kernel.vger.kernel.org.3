Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96A658A350
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239639AbiHDWfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbiHDWfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:35:36 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AB46267;
        Thu,  4 Aug 2022 15:35:35 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id e15so1102258lfs.0;
        Thu, 04 Aug 2022 15:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=GuH1IgdHnDZeAAouh4oPzemlYkEDcMWKAl7tAivCveg=;
        b=hsz2473hgGEv+hrs9vsc0Ymx9ks4Sj8+rYaw/lj8AYQm6O5TaqqZZH23KchUQzJuJf
         vu+Wzy3x9lQ/A15K6xZ2xAzdQcRQPm7Vb2NR3cICUcd9Z3woWrUgrRP7h0k4BRlFSvfJ
         rCesNkaA0C1JjL3ZyzvqdrIniqiAv7IzaWb4edVPyJ+wHsl0K6LDfSF/LD88skRq4dLi
         nLsX4WcPtZr29+yUoFB+RrzNVJAILfaoQPZPLoK5k0wMNqjqv7UiWznf0q/Fykr16J74
         zOTFZSf0myrT8AFq6drD+Iv0MWrQk05v6L/Jv/xqfM1hn/dfamsmZCyTW5HYgGdGgnCh
         ixOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=GuH1IgdHnDZeAAouh4oPzemlYkEDcMWKAl7tAivCveg=;
        b=yIPXHsL6LJbQ6UpAigRtTJHFa5vkOvhXuYSx1TzZRfcV2WYmICZ+pArOiFh88PKDH3
         8Xo5S0Aqoe8oIAYfG4L+19j0xdfuROW1kRUoJxlT3boU0pAKgD1fzXuIIWqTDsGQLhWa
         iaiEAJWuuZZqDfke76Tw1Ag2DptQo9vC0j3CCDqaGgV4kjrmFd5pWlKyaddcujdNNrjH
         YHbbTWETGUa5RL9MfcMKXFmiIyXU0o6xSFi7FEVlnw29avDeB2o1q4whR+TBJIU9b/u4
         JYiXsL7EGqe728HQZGctQKya32dEqdmtYK910NB9ExuALHizNiiKiK0z/goJ8BAbQ4P+
         EzRw==
X-Gm-Message-State: ACgBeo3HdZJ8wGtHftdUI/MIjoxCAQLh9cYZqHZuu90yt0Jd13Piqyuc
        dANQtXP+yBEbPBqwmjW04TQ=
X-Google-Smtp-Source: AA6agR5QYfh/5CBEyhIC04l1LwkouxiBYgZS/Xk6bjS9iRZgfYipqNNlopq3OfLxEJiwfWuhq9Splg==
X-Received: by 2002:ac2:5639:0:b0:48b:3976:b316 with SMTP id b25-20020ac25639000000b0048b3976b316mr829581lff.568.1659652533551;
        Thu, 04 Aug 2022 15:35:33 -0700 (PDT)
Received: from localhost.localdomain (37-145-40-25.broadband.corbina.ru. [37.145.40.25])
        by smtp.gmail.com with ESMTPSA id q28-20020a2eb4bc000000b0025e4dcc48b1sm264715ljm.19.2022.08.04.15.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:35:33 -0700 (PDT)
From:   Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
To:     masahiroy@kernel.org
Cc:     michal.lkml@markovi.net, ndesaulniers@google.com,
        akpm@linux-foundation.org, nathan@kernel.org, peterz@infradead.org,
        keescook@chromium.org, jpoimboe@kernel.org,
        dan.j.williams@intel.com, isabbasso@riseup.net,
        edumazet@google.com, vbabka@suse.cz, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Subject: [PATCH] kbuild: add option to set max level of debug info
Date:   Fri,  5 Aug 2022 01:35:04 +0300
Message-Id: <20220804223504.4739-1-dmitrii.bundin.a@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with -g3 option and debugging with gdb it provides some
extra abilities like macro expand, info macro etc... It's sometimes
useful to unerstand behavior of complicated macros.

Signed-off-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
---
 lib/Kconfig.debug      | 9 +++++++++
 scripts/Makefile.debug | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2e24db4bff19..1e8bef3e2a95 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -304,6 +304,15 @@ config DEBUG_INFO_REDUCED
 	  DEBUG_INFO build and compile times are reduced too.
 	  Only works with newer gcc versions.
 
+config DEBUG_INFO_MAXLEVEL
+	bool "Maximum debug information level"
+	depends on !DEBUG_INFO_REDUCED
+	default n
+	help
+	  Sets the maximum level of debug information compilers may generate
+	  (-g3). Enabling this option will require significantly more disk space
+	  and increase built time, but it's useful for debugging purposes.
+
 config DEBUG_INFO_COMPRESSED
 	bool "Compressed debugging information"
 	depends on $(cc-option,-gz=zlib)
diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
index 9f39b0130551..7e1d8beecfc4 100644
--- a/scripts/Makefile.debug
+++ b/scripts/Makefile.debug
@@ -2,6 +2,8 @@ DEBUG_CFLAGS	:=
 
 ifdef CONFIG_DEBUG_INFO_SPLIT
 DEBUG_CFLAGS	+= -gsplit-dwarf
+else ifdef CONFIG_DEBUG_INFO_MAXLEVEL
+DEBUG_CFLAGS	+= -g3
 else
 DEBUG_CFLAGS	+= -g
 endif
-- 
2.17.1

