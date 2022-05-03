Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08AF518F7A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242567AbiECU7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242148AbiECU6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:58:44 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B004633E04
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 13:55:10 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x23so10406522pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 13:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D8001mr4LabgPK6vdQOkTgjpB8frOhBImqWC9OKD9m8=;
        b=a6XXUyblvoUHJJ2m8UB7SU0n251adAuXNR9X6v+Za2Hlmw1sNp0o/S7+TNefs8MDJU
         1K/zSR1PUN+uRHggUvZwKd7XqE9esYkWif0Ca3ZgdL7z/u8LPOLEliBLqz4gDpXb8NxR
         lxoWF5b0hqYzYmX7E6RCC1SdQfGlIXXqkFpmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D8001mr4LabgPK6vdQOkTgjpB8frOhBImqWC9OKD9m8=;
        b=tN9AKaILqElkasrIq9TviiqAZdzZA48CUxo5UAeN3IPcKC96qdNxKPpLDrIHKatdrY
         7CdkphUXbU19JaGKZLVjygp6SFN8gqFT5Cwr+p3eFkPAF13zTF97lgh2KbZGY48Clwkt
         9VoSXV4ZbwK2UJbZdPw3vERBgSPEdrsROnPPEoVh+1zFzVXGUxJb+EUJBCuSTsAmJI4W
         Ee6MxsguGZ5sZjvD9fErvY1gRUV4J/FygqRPnMCOdW41mudWnWHny+ekwtOCyscsU8Vn
         7SbLRnNXWHELN4mK7Q8VbNxfXWq7isbqMszem7BKKrRaRb8XMTdAciODjaIkVlt/BSwC
         ORMw==
X-Gm-Message-State: AOAM5335gOU8nlYzc2BJ0A9lXWa1ceA38Zoy/sF3yblYcntPcMfzXJ3d
        g7uOZwlJFhyReJbGp0OYYln6JQ==
X-Google-Smtp-Source: ABdhPJy0r6jfI214JohcyFyrwVL84vsHM25sexru4n4aT6ATYpL01QZWrLNASKhCm8I23UcXpHmx/w==
X-Received: by 2002:a63:191e:0:b0:3c1:6920:c4a4 with SMTP id z30-20020a63191e000000b003c16920c4a4mr15613857pgl.365.1651611310150;
        Tue, 03 May 2022 13:55:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w13-20020aa7858d000000b0050dc762814bsm6716806pfn.37.2022.05.03.13.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 13:55:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Bill Wendling <morbo@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH 2/6] sancov: Split plugin build from plugin CFLAGS
Date:   Tue,  3 May 2022 13:54:59 -0700
Message-Id: <20220503205503.3054173-3-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220503205503.3054173-1-keescook@chromium.org>
References: <20220503205503.3054173-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2293; h=from:subject; bh=Z+W1/VzUmR9ZJufPDIl2IGsNAVokPGco3yw6gcXBPsw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBicZalfdpPHCtbFo/0LtbdJECo+DuY6+Cvl0iSgGt8 qmJAIyWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYnGWpQAKCRCJcvTf3G3AJpGVD/ 45paKBOSJMGdYykZni1+b9PFueY4o7xyFCrnukAmYC807VctcCbZeTj9kOFVbB6FUqRl299CyE5lOS 0Vv2x1ORa5MDkdnewBrkAhinq3hf6VYQjQa1WhwghwMcR7O8dkjldlYFQFfWNd+vkHqWGplWx9AtoM 9LqQiDjUBDblzBywzgTI1U9wsStkT5D8OfCxeRCIBpDmrFCimfXKY7nBxWd6NYhX3Gp+zGqP72w18c 9KchJnxEW7GgG5kUUyEgTtJkzHjmvqvMs9TjDk3NIjdHXeqbbgUzqzRpTf57BvDoGnR/NIzSCeQRr6 pBQwd/e0X/JfhMFlCms1vzSrsNpH2mti4MoexFcY8LbRMERFPNbDjGJe7cX+bVbl96QIxPonay3PIF gIcRUVZV5fHy2ufAT1QpQfEaBbAiiW6i4IqgymV9h7oTO+xntdnPrUMdnj8lqYNJJzQHVyncHaNwuv BoB4DQe3wA83QmlAAKISXfQHkxRrfvE2Krf15KnElZEJ96K5TtMPr3wzOUYHFvi7xXmkIyJEsGTcra NWUP2AAiRfv5tLmmjyF8VI8Plz9H0wMy4puNT+CrlVsO0+1sttwAcxXdNjfT16kEfS/1qUStk/AHCE 1JxYtah2EwLWng98hEZwZ9f0aqO+Bc7VIK05wgHnm4eYG7ztr4gF3u8poq9g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the sancov_plugin is enabled, it gets added to gcc-plugin-y which
is used to populate both GCC_PLUGIN (for building the plugin) and
GCC_PLUGINS_CFLAGS (for enabling and options). Instead of adding sancov
to both and then removing it from GCC_PLUGINS_CFLAGS, create a separate
list, gcc-plugin-external-y, which is only added to GCC_PLUGIN.

This will also be used by the coming randstruct build changes.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/Makefile.gcc-plugins | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index f67153b260c0..927c3dd57f84 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -8,8 +8,6 @@ ifdef CONFIG_GCC_PLUGIN_LATENT_ENTROPY
 endif
 export DISABLE_LATENT_ENTROPY_PLUGIN
 
-gcc-plugin-$(CONFIG_GCC_PLUGIN_SANCOV)		+= sancov_plugin.so
-
 gcc-plugin-$(CONFIG_GCC_PLUGIN_STRUCTLEAK)	+= structleak_plugin.so
 gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE)	\
 		+= -fplugin-arg-structleak_plugin-verbose
@@ -53,13 +51,17 @@ export DISABLE_ARM_SSP_PER_TASK_PLUGIN
 # All the plugin CFLAGS are collected here in case a build target needs to
 # filter them out of the KBUILD_CFLAGS.
 GCC_PLUGINS_CFLAGS := $(strip $(addprefix -fplugin=$(objtree)/scripts/gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y))
-# The sancov_plugin.so is included via CFLAGS_KCOV, so it is removed here.
-GCC_PLUGINS_CFLAGS := $(filter-out %/sancov_plugin.so, $(GCC_PLUGINS_CFLAGS))
 export GCC_PLUGINS_CFLAGS
 
 # Add the flags to the build!
 KBUILD_CFLAGS += $(GCC_PLUGINS_CFLAGS)
 
-# All enabled GCC plugins are collected here for building below.
-GCC_PLUGIN := $(gcc-plugin-y)
+# Some plugins are enabled outside of this Makefile, but they still need to
+# be included in GCC_PLUGIN so they can get built.
+gcc-plugin-external-$(CONFIG_GCC_PLUGIN_SANCOV)			\
+	+= sancov_plugin.so
+
+# All enabled GCC plugins are collected here for building in
+# scripts/gcc-scripts/Makefile.
+GCC_PLUGIN := $(gcc-plugin-y) $(gcc-plugin-external-y)
 export GCC_PLUGIN
-- 
2.32.0

