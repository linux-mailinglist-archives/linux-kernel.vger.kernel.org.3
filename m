Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4E4550776
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 01:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiFRX1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 19:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiFRX1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 19:27:42 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5609325DA
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 16:27:41 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id l4so7064369pgh.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 16:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eyOniFzGkggN/BNR4fP33bSiUm/C5vv+vYb/J1FSUS4=;
        b=Ttg3wdyzeiKJB847h7nBdgl63ewqXqb81I4QWBIPaMTFfJmyE+YCT26WXMSL8xq/XD
         rGaUsrDNU0KcaAnhuiZOIWdyl3ZqZMUIuhzVxfAR92mXkesEu3JgtkNXe3hFy1NUB6yv
         kxw5tIXIqjprqmL+s1CklztKAoVKkszrbuVfJ4D79IKVSRBZzG8z8xPRFDa9LSpF7rw+
         Et5JzFIOmDogBuwG6vr3sadNoDvn2UW0qCGiAEvo/Wr2cn2BMqrCxHcFp1BaqQfj3pNs
         1MZsw7DALTAAS5ix9rGIu0zi9jZHoZjFTMR08ucY/2Gv04UL/MaNveP0y7UiZBCmndzL
         o+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=eyOniFzGkggN/BNR4fP33bSiUm/C5vv+vYb/J1FSUS4=;
        b=GJfN6VIwm72lrn/KI7r9X5D1sbubviU+cEs+yEs21kwhxqRPKAdc/LWWB8ZHg23V8k
         FwdUsfjOQygMV2VQa9PVJAxe4nV4KKxJJcCEE6p0tc1YaR8ZAMA1jVItohvB7Xqxj8WJ
         TigHcRHW0hPvjFnpUxOkPr5mNqTw4CIF3ZhTPK/MXBOHG7iimLmcJ20jstavLXm7TFDJ
         5Iw0MhGbc9qVFXYP+z7gqiEEDhKXh7PoquhH7TSHcM5/Ok9D0Tduv/jODgdWb97rCVTN
         LC446mQt9DVP/zF8hiPhOFAm1Redxmkzcx5UUOgFTs0voQlizdVP5fLUdgbz4PkZa9aD
         5+3Q==
X-Gm-Message-State: AJIora800+E9Jzb265myl7eg1m+JPolKDnPppNK+7B0QSLPVDNs020Wi
        RqFsLF9sDx0WNMosyaKvI51COEXoCg8=
X-Google-Smtp-Source: AGRyM1u62PBcm5Y40nQHnj8D6xkwCDaulpOuvJfCK9cwHwss7CDToxb5H9oHXGRGs95dI8vjU3pbzA==
X-Received: by 2002:a05:6a00:278e:b0:525:1aeb:d5a with SMTP id bd14-20020a056a00278e00b005251aeb0d5amr1204939pfb.61.1655594860400;
        Sat, 18 Jun 2022 16:27:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ik10-20020a170902ab0a00b001617541c94fsm5838954plb.60.2022.06.18.16.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 16:27:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH] drm/amd/display: Add missing hard-float compile flags for PPC64 builds
Date:   Sat, 18 Jun 2022 16:27:37 -0700
Message-Id: <20220618232737.2036722-1-linux@roeck-us.net>
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

ppc:allmodconfig builds fail with the following error.

powerpc64-linux-ld:
	drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o
		uses hard float,
	drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.o
		uses soft float
powerpc64-linux-ld:
	failed to merge target specific data of file
	drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.o
powerpc64-linux-ld:
	drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o
		uses hard float,
	drivers/gpu/drm/amd/amdgpu/../display/dc/dcn315/dcn315_resource.o
		uses soft float
powerpc64-linux-ld:
	failed to merge target specific data of
	file drivers/gpu/drm/amd/amdgpu/../display/dc/dcn315/dcn315_resource.o
powerpc64-linux-ld:
	drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o
		uses hard float,
	drivers/gpu/drm/amd/amdgpu/../display/dc/dcn316/dcn316_resource.o
		uses soft float
powerpc64-linux-ld:
	failed to merge target specific data of file
	drivers/gpu/drm/amd/amdgpu/../display/dc/dcn316/dcn316_resource.o

The problem was introduced with commit 41b7a347bf14 ("powerpc: Book3S
64-bit outline-only KASAN support") which adds support for KASAN. This
commit in turn enables DRM_AMD_DC_DCN because KCOV_INSTRUMENT_ALL and
KCOV_ENABLE_COMPARISONS are no longer enabled. As result, new files are
compiled which lack the selection of hard-float.

Fixes: 41b7a347bf14 ("powerpc: Book3S 64-bit outline-only KASAN support")
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Daniel Axtens <dja@axtens.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile  | 4 ++++
 drivers/gpu/drm/amd/display/dc/dcn315/Makefile | 4 ++++
 drivers/gpu/drm/amd/display/dc/dcn316/Makefile | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
index ec041e3cda30..74be02114ae4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
@@ -15,6 +15,10 @@ DCN31 = dcn31_resource.o dcn31_hubbub.o dcn31_hwseq.o dcn31_init.o dcn31_hubp.o
 	dcn31_apg.o dcn31_hpo_dp_stream_encoder.o dcn31_hpo_dp_link_encoder.o \
 	dcn31_afmt.o dcn31_vpg.o
 
+ifdef CONFIG_PPC64
+CFLAGS_$(AMDDALPATH)/dc/dcn31/dcn31_resource.o := -mhard-float -maltivec
+endif
+
 AMD_DAL_DCN31 = $(addprefix $(AMDDALPATH)/dc/dcn31/,$(DCN31))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DCN31)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/Makefile b/drivers/gpu/drm/amd/display/dc/dcn315/Makefile
index 59381d24800b..1395c1ced8c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/Makefile
@@ -25,6 +25,10 @@
 
 DCN315 = dcn315_resource.o
 
+ifdef CONFIG_PPC64
+CFLAGS_$(AMDDALPATH)/dc/dcn315/dcn315_resource.o := -mhard-float -maltivec
+endif
+
 AMD_DAL_DCN315 = $(addprefix $(AMDDALPATH)/dc/dcn315/,$(DCN315))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DCN315)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/Makefile b/drivers/gpu/drm/amd/display/dc/dcn316/Makefile
index 819d44a9439b..c3d2dd78f1e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/Makefile
@@ -25,6 +25,10 @@
 
 DCN316 = dcn316_resource.o
 
+ifdef CONFIG_PPC64
+CFLAGS_$(AMDDALPATH)/dc/dcn316/dcn316_resource.o := -mhard-float -maltivec
+endif
+
 AMD_DAL_DCN316 = $(addprefix $(AMDDALPATH)/dc/dcn316/,$(DCN316))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DCN316)
-- 
2.35.1

