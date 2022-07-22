Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218C757DC5C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbiGVI2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiGVI23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:28:29 -0400
X-Greylist: delayed 424 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Jul 2022 01:28:29 PDT
Received: from redcrew.org (redcrew.org [37.157.195.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0CF9E793
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:28:29 -0700 (PDT)
Received: from server.danny.cz (85-71-161-19.rce.o2.cz [85.71.161.19])
        by redcrew.org (Postfix) with ESMTP id 8CBCFA0C;
        Fri, 22 Jul 2022 10:21:23 +0200 (CEST)
Received: from talos.danny.cz (unknown [IPv6:2001:470:5c11:160:47df:83f6:718e:218])
        by server.danny.cz (Postfix) with ESMTP id C649E11AA6B;
        Fri, 22 Jul 2022 10:21:22 +0200 (CEST)
From:   =?UTF-8?q?Dan=20Hor=C3=A1k?= <dan@danny.cz>
To:     amd-gfx@lists.freedesktop.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Ellerman <michael@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Cc:     Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] amdgpu: re-enable DCN for ppc64le
Date:   Fri, 22 Jul 2022 10:21:22 +0200
Message-Id: <20220722082122.571974-1-dan@danny.cz>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d11219ad53dc disabled the DCN driver for all platforms that
define PPC64 due long build issues during "make allmodconfig" using
cross-compilation. Cross-compilation defaults to the ppc64_defconfig
and thus big-endian toolchain configuration. The ppc64le platform uses a
different ABI and doesn't suffer from the build issues. Thus keep the
DCN driver disabled only for big-endian ppc64 builds and avoid
regression for ppc64le users of the amdgpu driver. Distros are mostly
focusing on ppc64le and that's likely why it got unnoticed, because
there were no build issues related to the amdgpu driver on ppc64le in
the 5.19 development cycle.

Tested by a local rebuild on ppc64le and using make.cross from a x86_64
machines.

Fixes: d11219ad53dc ("amdgpu: disable powerpc support for the newer display engine")

Signed-off-by: Dan Horák <dan@danny.cz>
Acked-by: Alex Deucher <alexdeucher@gmail.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2100
---
 drivers/gpu/drm/amd/display/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 0ba0598eba20..778a6f58047c 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -6,7 +6,7 @@ config DRM_AMD_DC
 	bool "AMD DC - Enable new display engine"
 	default y
 	select SND_HDA_COMPONENT if SND_HDA_CORE
-	select DRM_AMD_DC_DCN if X86 && !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
+	select DRM_AMD_DC_DCN if (X86 || (PPC64 && CPU_LITTLE_ENDIAN)) && !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
 	help
 	  Choose this option if you want to use the new display engine
 	  support for AMDGPU. This adds required support for Vega and
-- 
2.37.1

