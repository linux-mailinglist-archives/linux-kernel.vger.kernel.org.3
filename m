Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35209518F87
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242479AbiECU7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242203AbiECU6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:58:44 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6AD3DDC9
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 13:55:11 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so3368380pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 13:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G7gjgj4/4LSK9c/JAyPIXqGgMKHVguykDn2bHyT8voA=;
        b=lPFLR0C5AR5qKEBPAIWTWtzBk+9lgyDMXniJNA7VZybl5Svtynw7Q/xjEYdb832RxY
         jR+mmBUtRcDesMD4DEG7CNWGz0KtJaT50b3NMMS76x0LFx22QrYMECu2xX38hf/AwNb7
         MMJL5gT3MvziRSysXThA4xSGWJAbkPXC9dKQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G7gjgj4/4LSK9c/JAyPIXqGgMKHVguykDn2bHyT8voA=;
        b=DSi1AHFywA6m7B/ZS7pl93mZbecW7ta5b2quKCLoyFLhpdRWHNj+X+bI66Ii3ezC8G
         AL8RprGeV4O+uPG8iIP+lPxk9bLVlwVFTIg1qzqsfFYAzqo2BxsR1c3iVvFPBWBK8BxJ
         bCk6PKtF22esZiZxLR75T9XeS1E+S7MPFbBih3rkub5J4uAMgFww5r8dVKvBFivgfEca
         ToWLePzSfIAxZEmUQy4bspm1Kzlbo5qrH9c/9pIi/p/NYDASWpOvCrDg/v/Elv5+VLuH
         JiIHRJBpqbf1mdXVHGIUXjwXFw+jvUsZfcxNE4TSSaFMyB0frZiDF+gNCKTJORrc3jBQ
         MUxA==
X-Gm-Message-State: AOAM530LAZkucjGlCqK8SoftytNKMhsX2eZ3TEebe+3Y6+K5l9zs/lkK
        pd5m/oyM/CDbKXtFsQbeIoqTvw==
X-Google-Smtp-Source: ABdhPJzlRQDlCCwN12p3T2iXLOmaoOKLrPyOTgiWQ5BWcgjSqfBDOLgzhdNXlPBULmM7f+FaLlbpCA==
X-Received: by 2002:a17:902:bb90:b0:158:a031:2ff2 with SMTP id m16-20020a170902bb9000b00158a0312ff2mr18429818pls.117.1651611311296;
        Tue, 03 May 2022 13:55:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s10-20020a63450a000000b003c14af50607sm13111823pga.31.2022.05.03.13.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 13:55:10 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Bill Wendling <morbo@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 6/6] randstruct: Enable Clang support
Date:   Tue,  3 May 2022 13:55:03 -0700
Message-Id: <20220503205503.3054173-7-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220503205503.3054173-1-keescook@chromium.org>
References: <20220503205503.3054173-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2492; h=from:subject; bh=70QhakHoqRBTF2BhS4yZEwFNAa1mWnEa/ie6xwzJGBY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBicZamZGgPTMDtkz2lAP6v2msQMzZKulCSX+KAGB5j E1bmlEqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYnGWpgAKCRCJcvTf3G3AJlU5D/ 9Xyd51aYNqszUUL7SvvNyC19VjSU0o+jEEkpPilQKRN1uRHK9nWVWsrPw3aFhoMz4iTS5XBzAGpYfE DZEIcZQKS7f0MQGz6vgp5cG+EgrB5CcQ4ePyGGRn7IdfAg53lo+OIxP2oilAbt8NP58LUyzfd4EjYV kt5olI/+81/6ht6froYHo+0Qv+4W3GPz9sGufyfAEbFQyXjsEcy9Ro2qAdyOxtoCS8aDDznVpsbfQL 9z41A3ZD5ml0/L04Rk485Bom22yCPUP/1gkISFHvDq23I4slmV8kNHcqAFOPhTq4bc4MJ8+3dUZqmD VvFFb5wmyDS0grBSDnO9ihBplIWn5/Aq5sH2CcmQKp7DKALkQPjHNdED2ABfy/jQdoGogxCHAyuP9F zW7FjuKazB8lTmSMZKxUakxyGS0ANjJR32zyrofE+RdyI7hElnpEzP7vnVTb3vnK8zo+Vk6KYGGEzZ 4yZIbE1lnLdCkvvS3GxZubDQI7e/adQqf/kcL2bKQ9RXvw4IAWaBA4onxJpmaRDtEBar+YGUT9jS3E hcT67gCbpkmG3Vccv5IlmGAI/6hpgM986H4ODejuZbIJymhKClI/n8pqWJdg9ZBGccPsezfwigdKIu oPS4Fo4Cf2D4ZToRh8wuX98q/HcA7kcOkiuSlaUmKQWv49ct43TIINfIBBkQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang 15 will support randstruct via the -frandomize-layout-seed-file=...
option. Update the Kconfig and Makefile to recognize this feature.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/Makefile.randstruct |  3 +++
 security/Kconfig.hardening  | 14 ++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.randstruct b/scripts/Makefile.randstruct
index 4d741e6db554..24e283e89893 100644
--- a/scripts/Makefile.randstruct
+++ b/scripts/Makefile.randstruct
@@ -7,6 +7,9 @@ randstruct-cflags-y	\
 	+= -fplugin=$(objtree)/scripts/gcc-plugins/randomize_layout_plugin.so
 randstruct-cflags-$(CONFIG_RANDSTRUCT_PERFORMANCE)		\
 	+= -fplugin-arg-randomize_layout_plugin-performance-mode
+else
+randstruct-cflags-y	\
+	+= -frandomize-layout-seed-file=$(objtree)/scripts/basic/randstruct.seed
 endif
 
 export RANDSTRUCT_CFLAGS := $(randstruct-cflags-y)
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 0277ba578779..bd2aabb2c60f 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -266,9 +266,12 @@ config ZERO_CALL_USED_REGS
 
 endmenu
 
+config CC_HAS_RANDSTRUCT
+	def_bool $(cc-option,-frandomize-layout-seed-file=/dev/null)
+
 choice
 	prompt "Randomize layout of sensitive kernel structures"
-	default RANDSTRUCT_FULL if COMPILE_TEST && GCC_PLUGINS
+	default RANDSTRUCT_FULL if COMPILE_TEST && (GCC_PLUGINS || CC_HAS_RANDSTRUCT)
 	default RANDSTRUCT_NONE
 	help
 	  If you enable this, the layouts of structures that are entirely
@@ -297,13 +300,20 @@ choice
 
 	config RANDSTRUCT_FULL
 		bool "Fully randomize structure layout"
-		depends on GCC_PLUGINS
+		depends on CC_HAS_RANDSTRUCT || GCC_PLUGINS
 		select MODVERSIONS if MODULES
 		help
 		  Fully randomize the member layout of sensitive
 		  structures as much as possible, which may have both a
 		  memory size and performance impact.
 
+		  One difference between the Clang and GCC plugin
+		  implementations is the handling of bitfields. The GCC
+		  plugin treats them as fully separate variables,
+		  introducing sometimes significant padding. Clang tries
+		  to keep adjacent bitfields together, but with their bit
+		  ordering randomized.
+
 	config RANDSTRUCT_PERFORMANCE
 		bool "Limit randomization of structure layout to cache-lines"
 		depends on GCC_PLUGINS
-- 
2.32.0

