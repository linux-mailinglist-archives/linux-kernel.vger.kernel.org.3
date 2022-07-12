Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA3557296F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 00:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbiGLWmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 18:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiGLWmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 18:42:51 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE28C9120
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 15:42:51 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y9so8658173pff.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 15:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EOQK1yQsd3sxXf3ifqolSQDmS565G3PBpmyW4cpx2HA=;
        b=MSBeQK///1NrBGbw7DV7tnTXdkZYNFjowCKH7HWWo6GHJtRs2JBzAZOUS8wJPeS3uB
         FdmbaYtn+hTpf1LGNZgEyeUWRG1cVzTz/1oEyLDknyKU4hUPvpIGJ+X4vRY3nURrKaay
         11uzpc4OgaK1zQf7vNDHPl0glTe00vOyLDwPjtJLPoJSgRslvY7XqKtECfR51PBum7Vz
         +hrGteaVNQuO34sksAm9/YBxtGc0pA3exzkgYaL3hFnNKNEJn3y4DsWBEdU8q+fmIgR9
         0JZlBNgeX/nc44836d3Gy6EyMmJKZyLrer3qSJ861OHV3LL6WQVB1FeqbxasQjhsatFy
         ILTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=EOQK1yQsd3sxXf3ifqolSQDmS565G3PBpmyW4cpx2HA=;
        b=oUoRbbde5feQ8zxo9d4Xz+szrS/JDXxBBgdjJ8Y0P+ym/JGqZldPShDBkCiSnY3ZTP
         2uewqZc+zXSQseCWjYcKhcGuDZtyqUvdiOPokCKu+FtsnXzLAmbg7X0avDixh+Lcrbsm
         cHQrf0nY7Hxu6sH/H1hhoDom7r7c10h8Pou+AjWXN8EDiYLnzCCpMxmHIxEdsYjyAMl6
         0IpKqS+4JQ1pv0GyiPUUW2rqZy0P6T+p2FhQD9dHdvjWFO8Pf/7lGZRYYbfMBGyYuuTo
         XpsxleQ+1ZC9Z1lehF00hOwVsMVcRyMuLRp2XiB2CIR30p6DgY7o6b86LuyLud/S878d
         08qw==
X-Gm-Message-State: AJIora84NxEfdEgd5NhlyAK0pXvIDL4d9IfyA2EWHkqxeAxJ9k9Ih3IR
        rduZ9ao7WhQkuSnNPxAS5FY=
X-Google-Smtp-Source: AGRyM1tLJIcznWizk9iJQMKwRvzQyZlrxC0AQCyjI0CRaOuIOSRtFl2r3Pu3cEB73Omx8SddXOOy/g==
X-Received: by 2002:a63:6c42:0:b0:3fe:465:7a71 with SMTP id h63-20020a636c42000000b003fe04657a71mr398029pgc.101.1657665770859;
        Tue, 12 Jul 2022 15:42:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 6-20020a631446000000b00415fcde23a4sm4552956pgu.27.2022.07.12.15.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 15:42:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH] drm/amd/display: Enable building new display engine with KCOV enabled
Date:   Tue, 12 Jul 2022 15:42:47 -0700
Message-Id: <20220712224247.1950273-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new display engine uses floating point math, which is not supported
by KCOV. Commit 9d1d02ff3678 ("drm/amd/display: Don't build DCN1 when kcov
is enabled") tried to work around the problem by disabling
CONFIG_DRM_AMD_DC_DCN if KCOV_INSTRUMENT_ALL and KCOV_ENABLE_COMPARISONS
are enabled. The result is that KCOV can not be enabled on systems which
require this display engine. A much simpler and less invasive solution is
to disable KCOV selectively when compiling the display enagine while
keeping it enabled for the rest of the kernel.

Fixes: 9d1d02ff3678 ("drm/amd/display: Don't build DCN1 when kcov is enabled")
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/gpu/drm/amd/display/Kconfig     | 2 +-
 drivers/gpu/drm/amd/display/dc/Makefile | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index b4029c0d5d8c..96cbc87f7b6b 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -6,7 +6,7 @@ config DRM_AMD_DC
 	bool "AMD DC - Enable new display engine"
 	default y
 	select SND_HDA_COMPONENT if SND_HDA_CORE
-	select DRM_AMD_DC_DCN if (X86 || PPC64) && !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
+	select DRM_AMD_DC_DCN if (X86 || PPC64)
 	help
 	  Choose this option if you want to use the new display engine
 	  support for AMDGPU. This adds required support for Vega and
diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index b4eca0236435..b801973749d2 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -26,6 +26,9 @@
 DC_LIBS = basics bios dml clk_mgr dce gpio irq link virtual
 
 ifdef CONFIG_DRM_AMD_DC_DCN
+
+KCOV_INSTRUMENT := n
+
 DC_LIBS += dcn20
 DC_LIBS += dsc
 DC_LIBS += dcn10
-- 
2.35.1

