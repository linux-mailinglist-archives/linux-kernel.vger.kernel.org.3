Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C8B4D23B9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344804AbiCHV6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350577AbiCHV55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:57:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E78D50E07;
        Tue,  8 Mar 2022 13:57:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6039B81D86;
        Tue,  8 Mar 2022 21:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC43C340F9;
        Tue,  8 Mar 2022 21:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646776617;
        bh=MSDAfiFmxb619SbNV0Do6ViYQlOLDRcmxvg0q5mQXVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MGcDWHDdpzSijirtmAR+bbuZP2FzIWh8GyKHYDevUEiMiwo5oAaKV8kVMjuWYTcZl
         QeSIFMI4XCpErcpUaSG8ulhzpgVPJq1gCUwI2SftIEoafLPwXA74zMnYRIuI9kTY/X
         KgnJDTclYL4o7ODLvWSOpj6I+iUf88LiLWNYyLbA7TH1AV8VLlm6n/u5EdB49MrJ/0
         fZ6Baio/T7JaQ+1y35Ic458d1rPh0QxXs87jgA7/VFNJDxsC5tvBs5XaBZ8JRQFPRT
         yr9CvKVbA37y+Jz7GPiMGTrG6R8VI5WacCYe6SzjSOqr6DEaT6eV/xkTes5b6yWItb
         +wXyUC9EAOI6Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     alexs@kernel.org, arnd@arndb.de, arnd@kernel.org, dsterba@suse.com,
        elver@google.com, jani.nikula@intel.com, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, mark.rutland@arm.com,
        ndesaulniers@google.com, ojeda@kernel.org,
        torvalds@linux-foundation.org
Subject: [PATCH 1/4] [v4] Kbuild: add -Wno-shift-negative-value where -Wextra is used
Date:   Tue,  8 Mar 2022 22:56:12 +0100
Message-Id: <20220308215615.14183-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220308215615.14183-1-arnd@kernel.org>
References: <20220308215615.14183-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

As a preparation for moving to -std=gnu11, turn off the
-Wshift-negative-value option. This warning is enabled by gcc when
building with -Wextra for c99 or higher, but not for c89. Since
the kernel already relies on well-defined overflow behavior,
the warning is not helpful and can simply be disabled in
all locations that use -Wextra.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
[v4]
  split into a separate patch
---
 drivers/gpu/drm/i915/Makefile          | 1 +
 drivers/staging/greybus/tools/Makefile | 3 ++-
 fs/btrfs/Makefile                      | 1 +
 scripts/Makefile.extrawarn             | 1 +
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 1b62b9f65196..1618a6e0af4e 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -17,6 +17,7 @@ subdir-ccflags-y += -Wno-unused-parameter
 subdir-ccflags-y += -Wno-type-limits
 subdir-ccflags-y += -Wno-missing-field-initializers
 subdir-ccflags-y += -Wno-sign-compare
+subdir-ccflags-y += -Wno-shift-negative-value
 subdir-ccflags-y += $(call cc-disable-warning, unused-but-set-variable)
 subdir-ccflags-y += $(call cc-disable-warning, frame-address)
 subdir-ccflags-$(CONFIG_DRM_I915_WERROR) += -Werror
diff --git a/drivers/staging/greybus/tools/Makefile b/drivers/staging/greybus/tools/Makefile
index ad0ae8053b79..a3bbd73171f2 100644
--- a/drivers/staging/greybus/tools/Makefile
+++ b/drivers/staging/greybus/tools/Makefile
@@ -12,7 +12,8 @@ CFLAGS	+= -std=gnu99 -Wall -Wextra -g \
 	    -Wredundant-decls \
 	    -Wcast-align \
 	    -Wsign-compare \
-	    -Wno-missing-field-initializers
+	    -Wno-missing-field-initializers \
+	    -Wno-shift-negative-value
 
 CC	:= $(CROSS_COMPILE)gcc
 
diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 4188ba3fd8c3..99f9995670ea 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -17,6 +17,7 @@ subdir-ccflags-y += $(condflags)
 subdir-ccflags-y += -Wno-missing-field-initializers
 subdir-ccflags-y += -Wno-sign-compare
 subdir-ccflags-y += -Wno-type-limits
+subdir-ccflags-y += -Wno-shift-negative-value
 
 obj-$(CONFIG_BTRFS_FS) := btrfs.o
 
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 8be892887d71..650d0b8ceec3 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -36,6 +36,7 @@ KBUILD_CFLAGS += $(call cc-option, -Wstringop-truncation)
 KBUILD_CFLAGS += -Wno-missing-field-initializers
 KBUILD_CFLAGS += -Wno-sign-compare
 KBUILD_CFLAGS += -Wno-type-limits
+KBUILD_CFLAGS += -Wno-shift-negative-value
 
 KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN1
 
-- 
2.29.2

