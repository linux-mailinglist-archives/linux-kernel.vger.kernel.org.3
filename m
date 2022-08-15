Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FF259278E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiHOBej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHOBeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:34:37 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5069C5E;
        Sun, 14 Aug 2022 18:34:36 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id x10so6343934ljq.4;
        Sun, 14 Aug 2022 18:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=SUz1TqPyL7KJmvxJDlgGqvLb94MqI6W6P3Guvvw/hls=;
        b=kSVveydjmJOefsqBmiJ5KB4R6JWr/+FK1rl1S8263XwJ3mXjbw7kBW7K5OCyKY2AjV
         UOmeUQgx8+sxaXmhnQaNSquRfteVH0+QikmFQKYIBvDTRLYjph4FvDZVxIwaZVtSlRa9
         BaKC2Zn/E8GiYqBZkEXOGGIDHF8Fi2ayOpjBSBprgXTnwygYHUvsAb8PkeXU0IW0c6/U
         mo9yfy8Ml7TVfoCwS52nnM8QqqOPhWuFuKlIChmbXh1DnfyACneEbd1lJ8QvE1Sarorg
         acZver1QBUEx76udAw6L6UBaqXAuCclABv4CGBYGV0FM40bySFi3S3qe/DBGrQrU6yR4
         eC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=SUz1TqPyL7KJmvxJDlgGqvLb94MqI6W6P3Guvvw/hls=;
        b=5UCsWnVsHDxVdptrvbr8BLL03/ekpqoWbxgnT+bYJpbgG/vcIPbz10qpxC81djo6GR
         nvLM1KgcXgiJSwL1drwESfo9p7J59DjQ0Zt3wONL+5QPKeoU4cBw4p++nqcrjnDwCQf5
         ZWYdat+6byZ9UaJf1MExdj9jHgkHlhMMluS66KZbnkDvZorFM8ATqE8OJYGiBl6BahqC
         yPY9af670HVv9FObq3m6XoDmFXVxo2uxlbu3FAaadFJEZwZm2poX366AG2oNcG8A51G9
         U3T9soimeLPgEQhdIgQPrUWgbl6s8iwpBqSm/X2NYCrBtczP0zbZx/xLL7CBut6hn2h9
         Uwsg==
X-Gm-Message-State: ACgBeo0s/GLE5gOdNbChPnk/bEWgiMEDXjYJ44mJucjVCauFHLmq7rVZ
        5B0JLgi8906xKW0kZsclehI=
X-Google-Smtp-Source: AA6agR7Md0UfdPjsovzukZNxlPYXrTJQQn+a5dQY+6HkmzW+7IsXxSwhieZpJdyGyWFgpst9DIwF1w==
X-Received: by 2002:a2e:b0ec:0:b0:25e:55ec:a9c with SMTP id h12-20020a2eb0ec000000b0025e55ec0a9cmr4088993ljl.226.1660527274877;
        Sun, 14 Aug 2022 18:34:34 -0700 (PDT)
Received: from localhost.localdomain (37-145-44-55.broadband.corbina.ru. [37.145.44.55])
        by smtp.gmail.com with ESMTPSA id u1-20020ac258c1000000b0047f7722b73csm946039lfo.142.2022.08.14.18.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 18:34:34 -0700 (PDT)
From:   Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
To:     masahiroy@kernel.org
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        edumazet@google.com, isabbasso@riseup.net, jpoimboe@kernel.org,
        keescook@chromium.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        dmitrii.bundin.a@gmail.com, maskray@google.com,
        michal.lkml@markovi.net, nathan@kernel.org,
        ndesaulniers@google.com, peterz@infradead.org, vbabka@suse.cz
Subject: [PATCH v3] kbuild: add debug level and macro defs options
Date:   Mon, 15 Aug 2022 04:33:17 +0300
Message-Id: <20220815013317.26121-1-dmitrii.bundin.a@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CANXV_XwgZMCGXijfoUyZ9+KyM6Rgeqiq-sCfubyj_16d-2CN=A@mail.gmail.com>
References: <CANXV_XwgZMCGXijfoUyZ9+KyM6Rgeqiq-sCfubyj_16d-2CN=A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds config options to control debug info level and producing of macro
definitions for GCC/Clang.

Option DEBUG_INFO_LEVEL is responsible for controlling debug info level.
Before GCC 11 and Clang 12 -gsplit-dwarf implicitly uses -g2. To provide
a way to override the setting with, e.g. -g1, DEBUG_INFO_LEVEL is set
independently from DEBUG_INFO_SPLIT.

Option DEBUG_MACRO_DEFINITIONS is responsible for controlling inclusion
of macro definitions. Since Clang uses -fdebug-macro to control if macro
definitions are produced which is different from GCC, provides a
compiler-specific way of handling macro inclusion. The option is handled
after DEBUG_INFO_LEVEL since -g3 -g2 implies -g2, but -g2 -g3 implies
-g3 and GCC uses -g3 to produce macro definitions.

Signed-off-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
---

Changes in v2: https://lore.kernel.org/all/20220804223504.4739-1-dmitrii.bundin.a@gmail.com/
  - Replace hardcoded -g3 with a configurable debug info level

Changes in v3: https://lore.kernel.org/all/20220814002021.16990-1-dmitrii.bundin.a@gmail.com/
  - Make -g<level> and -gdwarf-split to be set independently
  - Add a separate option to control macro definitions for GCC/Clang

 lib/Kconfig.debug      | 20 ++++++++++++++++++++
 scripts/Makefile.debug | 12 ++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2e24db4bff19..ace6f2eddb56 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -304,6 +304,26 @@ config DEBUG_INFO_REDUCED
 	  DEBUG_INFO build and compile times are reduced too.
 	  Only works with newer gcc versions.
 
+config DEBUG_INFO_LEVEL
+	int "Debug info level"
+	range 1 3
+	default "2"
+	help
+	  Sets the level of how much debug information to generate (-glevel).
+	  Level 1 produces minimal debug information without including information
+	  about local variables. Level 3 includes extra information like macro
+	  definitions. Setting up level 3 will require significantly more disk
+	  space and increase built time.
+
+config DEBUG_MACRO_DEFINITIONS
+	bool "Add macro definitions to debug info"
+	default n
+	help
+	  Generates macro definitions to provide a way to expand macros right
+	  in the debugging session. This information can be used with macro expand,
+	  info macro in gdb. This option is equivalent to setting -g3 in GCC and
+	  -fdebug-macro in Clang.
+
 config DEBUG_INFO_COMPRESSED
 	bool "Compressed debugging information"
 	depends on $(cc-option,-gz=zlib)
diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
index 9f39b0130551..29cd04234e75 100644
--- a/scripts/Makefile.debug
+++ b/scripts/Makefile.debug
@@ -2,8 +2,6 @@ DEBUG_CFLAGS	:=
 
 ifdef CONFIG_DEBUG_INFO_SPLIT
 DEBUG_CFLAGS	+= -gsplit-dwarf
-else
-DEBUG_CFLAGS	+= -g
 endif
 
 ifndef CONFIG_AS_IS_LLVM
@@ -16,6 +14,16 @@ dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
 DEBUG_CFLAGS	+= -gdwarf-$(dwarf-version-y)
 endif
 
+DEBUG_CFLAGS	+= -g$(CONFIG_DEBUG_INFO_LEVEL)
+ifdef CONFIG_DEBUG_MACRO_DEFINITIONS
+ifdef CONFIG_CC_IS_GCC
+DEBUG_CFLAGS	+= -g3
+endif
+ifdef CONFIG_CC_IS_CLANG
+DEBUG_CFLAGS	+= -fdebug-macro
+endif
+endif
+
 ifdef CONFIG_DEBUG_INFO_REDUCED
 DEBUG_CFLAGS	+= -fno-var-tracking
 ifdef CONFIG_CC_IS_GCC
-- 
2.17.1

