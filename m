Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F784A0307
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 22:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343826AbiA1Vlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 16:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238634AbiA1Vle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 16:41:34 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F240C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 13:41:34 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id oa14-20020a17090b1bce00b001b61aed4a03so6268657pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 13:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3wXlxO8ivxh19lX0NUWVIj5SKVX6xM1bt7/6ivcawkI=;
        b=oaKziv6vTJhWuDvXhdfjGZVLHKZ7L83vnVgyfI1+9l/jD7sXBS4r7CUk8PrAOaF54E
         epgiy7APhyZWhgKMr/MBLD6P2x6Cmj0RNCqWb0nXyoqbATE91TzVh02Lr6uOrCV85QGS
         Lr2dE/lBl5NP+xz5eIbm4Pk5LJNr4MpcOFPOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3wXlxO8ivxh19lX0NUWVIj5SKVX6xM1bt7/6ivcawkI=;
        b=vpvKyKznV8XppIr3eUt4Qlwmlg1kNIBlT+XP2bBwIz+O+lpy4yXRnjURm5sLCeneZc
         SbfkA+tOvrhVOBLEmaGv2SaKMqZjKJHgPuI+uqfqCtODgow17uittzaMU4yxeQD7rmNy
         FStWF2gQLNF7qX2MbTRSxl114fnCNNMlWAL+E2tt2HyHjOemPZ+ofNJKm9/tHQlrwbnI
         klq78yOXYW4lKxsIczolaQTeOnRku5sx0uaxHQBa+OV+UanL5B550sdn3x8hxldo7Rcd
         0bdDLicP2d24d5pq4iL1aZfTjZ3NnCANck+Xy//EOCSKzTbjIzr8kYD/YIH77WLBwqVo
         Lwcg==
X-Gm-Message-State: AOAM531RZOKORIB2brDwTK9p2FC2QpSbz4Ek/7K6MMU9Eh6ecAngehXG
        i7ZnU4wHpTocFHw52mWrliyLDg==
X-Google-Smtp-Source: ABdhPJz/fgfsI4xLVm3DEvsoPHm+vtuTG0j/blq9GjI1DbhuSDmGKszKc7oySUS+0SZfLJxZpj/t5A==
X-Received: by 2002:a17:902:a5c1:: with SMTP id t1mr10890722plq.106.1643406093578;
        Fri, 28 Jan 2022 13:41:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id rj1sm3460112pjb.49.2022.01.28.13.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 13:41:33 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Isabella Basso <isabbasso@riseup.net>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] Kconfig.debug: Make DEBUG_INFO always default=n
Date:   Fri, 28 Jan 2022 13:41:31 -0800
Message-Id: <20220128214131.580131-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2150; h=from:subject; bh=s9N1b3JvxLd7oL7UEPREgGNdTUKoGAUWw3SiLd7haIE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh9GMLirleATojwN3w57Xd5078WAD6SduT1rPt5nHf EBZlc2+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYfRjCwAKCRCJcvTf3G3AJl31D/ 9ft+lnP5M4ywaWKG9O5qM3gN9sPC7U6rj3pBTCI3T9DcMj+hNqsExa3v9nqxtx35MG+vmzfqhSisa0 ouiA9NrfacD8srxm+etJSmTPdjxu8x4XuesC/avRPeuazGXTwm1W0kizYnBXLjbT6ZNoFJ/TGQKqfI 5fZWRb407xFVfYmcdcCRmsU8z40c0XaTXD/pSbXWHK4dZsy9sYeJPkFBy2btTFB/WVBYBxpoX9yzM8 0CqjseXHvuYkxfjAqYMhJWozZEW9OBHmNjDT43exDBNwfHOo+viIc8cRQbFYGFcW2YEs15G7C5/qQH IMyxcmYIFoiZIkrEDYosigQExBoVIEXg8v+76M+B1GVcyt9Wp3mCoxqOmGOP3PBL4AIkPzoI9IPVvJ O0UP/nWg3Slu8guiRmGSQsIADBMSFjWKzy3K9f55THnW6SOyjO8OPkZGsV550X90RlDh63try++a38 19MJTobH+EGJJHCBTiERWwKnCa+wuvwYY19T4wRZVrOHFuRHsUDiyA8tuD2xsStAsJZhfRv9wg5hYG HpbrRozX/XPcOtqscWXqbDCKUETeHBgZczVz2wrEf8mt7zMjEcNT+OUKoOr4Xdw2km2tfySmAPDTQG IbUks5MlGWA0d0D+uQR5/R6svXYL3b6Zh1nXThDJFyGPyLMggEjEIu+KkHeA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to make sure CONFIG_DEBUG_INFO wasn't set for COMPILE_TEST,
I ordered the choices incorrectly to retain the prior default=n state.
Move DEBUG_INFO_NONE to the top so that the default choice is disabled,
and remove the "if COMPILE_TEST" as it is now redundant.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/lkml/YfRY6+CaQxX7O8vF@dev-arch.archlinux-ax161
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Andrew, this is a fix for kconfigdebug-make-debug_info-selectable-from-a-choice.patch
---
 lib/Kconfig.debug | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a7b657d67318..a1262358d55a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -234,7 +234,6 @@ config DEBUG_INFO
 choice
 	prompt "Debug information"
 	depends on DEBUG_KERNEL
-	default DEBUG_INFO_NONE if COMPILE_TEST
 	help
 	  Selecting something other than "None" results in a kernel image
 	  that will include debugging info resulting in a larger kernel image.
@@ -245,6 +244,12 @@ choice
 	  Choose which version of DWARF debug info to emit. If unsure,
 	  select "Toolchain default".
 
+config DEBUG_INFO_NONE
+	bool "Disable debug information"
+	help
+	  Do not build the kernel with debugging information, which will
+	  result in a faster and smaller build.
+
 config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
 	bool "Rely on the toolchain's implicit default DWARF version"
 	select DEBUG_INFO
@@ -283,12 +288,6 @@ config DEBUG_INFO_DWARF5
 	  config if they rely on tooling that has not yet been updated to
 	  support DWARF Version 5.
 
-config DEBUG_INFO_NONE
-	bool "Disable debug information"
-	help
-	  Do not build the kernel with debugging information, which will
-	  result in a faster and smaller build.
-
 endchoice # "Debug information"
 
 if DEBUG_INFO
-- 
2.30.2

