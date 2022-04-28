Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A765C512E2C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343853AbiD1I0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiD1I0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:26:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DBF79D4DE
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651134170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=R9+SPpuY/53xWbtQcQ19Ca0p6As0qKIDguvyi3xRKuA=;
        b=HbxbiJi9x/DjmtmZfbGwIKodpbAiCitbuK0S0KJshBokuyAdP3jvin4BUAqOEGLuvhtCz8
        yRSxWpW8d3BxYw2wvm2ZG9Z77V3b0nsXQT9I1r7QgP0NFXrRBfTgp2f362zEr4YH4Dx0Hr
        Y30mOfshio6ahx3nhQpNWMduF1esOHc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-xzZwMChOO-CZLCGQsYSRNg-1; Thu, 28 Apr 2022 04:22:49 -0400
X-MC-Unique: xzZwMChOO-CZLCGQsYSRNg-1
Received: by mail-wm1-f69.google.com with SMTP id r186-20020a1c44c3000000b00393f52ed5ceso3290390wma.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9+SPpuY/53xWbtQcQ19Ca0p6As0qKIDguvyi3xRKuA=;
        b=NoOV/aohp8qosy5GuK6KQmsAOXeC8jimsp/va+/EP7HPERPBgS0q2kmjMa9bHgAHPw
         vgV0zfOfiK+xjw9eRHtm9KaQeilOhMjbSAnjnZ5fZ6aCHiyVFiweo6xsD4m8FhgRQTNQ
         SA2+vpHSDw1gl1FcGgO+VGasz7uS4Om5C/XWXe+YF8o0Y0MdsJ+o5KJ1MgLoTcTOpLCV
         lR/mxYfZsDuOprPHtJn3A4p5dvuotTN50nSRUxlXhCKixDsGYAjBCMGCbJu9mWuV6qc5
         4N4lsvpdBm5RyFAXQ/X9DQy9KgFPewxjtqQpZx3OzbiRtF0pr/CjYLrL1H8YOQKvrbTm
         D1ug==
X-Gm-Message-State: AOAM533Qp+MhWBkCV/rQXxOprwNsI/osyP1qUp8oKjP8lYQnmNnMnxVs
        IJGkyx+9anjJMNJY1jn9CpxrLDI+6HKrRhU9Ej1bYsse8uCnH7GhB7/7jmpARQ4S6KDj/DhFyrK
        qwvIFilmSDPs6SKGBvoSZSmamlt3xXymtLqa+WEMz70wdtGph8OFQEDz/YGCSIETHRM2mk5IknM
        Y=
X-Received: by 2002:a5d:6085:0:b0:20a:d53f:4b82 with SMTP id w5-20020a5d6085000000b0020ad53f4b82mr19218160wrt.179.1651134167733;
        Thu, 28 Apr 2022 01:22:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAOxNIujfjjGnE4mnlBE81yQgSXJdlVH3vXVmWZHIbbWYWf867nQI0LV9aNfKV3cxaxvCXtA==
X-Received: by 2002:a5d:6085:0:b0:20a:d53f:4b82 with SMTP id w5-20020a5d6085000000b0020ad53f4b82mr19218142wrt.179.1651134167439;
        Thu, 28 Apr 2022 01:22:47 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i11-20020a5d584b000000b0020a8d859e5fsm16468356wrf.10.2022.04.28.01.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 01:22:47 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lyude Paul <lyude@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v3] drm/display: Select DP helper for DRM_DP_AUX_CHARDEV and DRM_DP_CEC
Date:   Thu, 28 Apr 2022 10:22:44 +0200
Message-Id: <20220428082244.390859-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRM_DP_AUX_CHARDEV and DRM_DP_CEC Kconfig symbols enable code that use
DP helper functions, that are only present if CONFIG_DRM_DISPLAY_DP_HELPER
is also enabled.

But these don't select the DRM_DISPLAY_DP_HELPER symbol, meaning that it
is possible to enable any of them without CONFIG_DRM_DISPLAY_DP_HELPER.

That will lead to the following linking errors with the mentioned config:

  LD      vmlinux.o
  MODPOST vmlinux.symvers
  MODINFO modules.builtin.modinfo
  GEN     modules.builtin
  LD      .tmp_vmlinux.kallsyms1
  KSYMS   .tmp_vmlinux.kallsyms1.S
  AS      .tmp_vmlinux.kallsyms1.S
  LD      .tmp_vmlinux.kallsyms2
  KSYMS   .tmp_vmlinux.kallsyms2.S
  AS      .tmp_vmlinux.kallsyms2.S
  LD      vmlinux
  SYSMAP  System.map
  SORTTAB vmlinux
  OBJCOPY arch/arm64/boot/Image
  MODPOST modules-only.symvers
ERROR: modpost: "drm_dp_dpcd_write" [drivers/gpu/drm/display/drm_display_helper.ko] undefined!
ERROR: modpost: "drm_dp_read_desc" [drivers/gpu/drm/display/drm_display_helper.ko] undefined!
ERROR: modpost: "drm_dp_dpcd_read" [drivers/gpu/drm/display/drm_display_helper.ko] undefined!
make[1]: *** [scripts/Makefile.modpost:134: modules-only.symvers] Error 1
make[1]: *** Deleting file 'modules-only.symvers'
make: *** [Makefile:1749: modules] Error 2

Besides making these symbols to select CONFIG_DRM_DISPLAY_DP_HELPER, make
them to depend on DRM_DISPLAY_HELPER, since can't be enabled without it.

Note: It seems this has been an issue for a long time but was made easier
to reproduce after the commit 1e0f66420b13 ("drm/display: Introduce a DRM
display-helper module"). Adding a Fixes: tag just to make sure that this
fix will be picked for stable once the mentioned change also lands there.

Fixes: 1e0f66420b13 ("drm/display: Introduce a DRM display-helper module")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v3:
- Also make DRM_DP_AUX_CHARDEV and DRM_DP_CEC depend on DRM_DISPLAY_HELPER
  (Thomas Zimmermann).

Changes in v2:
- Explain better the issue in the change description.
- Only select DRM_DISPLAY_DP_HELPER and not DRM_DISPLAY_HELPER.

 drivers/gpu/drm/display/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/display/Kconfig b/drivers/gpu/drm/display/Kconfig
index f84f1b0cd23f..1b6e6af37546 100644
--- a/drivers/gpu/drm/display/Kconfig
+++ b/drivers/gpu/drm/display/Kconfig
@@ -31,7 +31,8 @@ config DRM_DISPLAY_HDMI_HELPER
 
 config DRM_DP_AUX_CHARDEV
 	bool "DRM DP AUX Interface"
-	depends on DRM
+	depends on DRM && DRM_DISPLAY_HELPER
+	select DRM_DISPLAY_DP_HELPER
 	help
 	  Choose this option to enable a /dev/drm_dp_auxN node that allows to
 	  read and write values to arbitrary DPCD registers on the DP aux
@@ -39,7 +40,8 @@ config DRM_DP_AUX_CHARDEV
 
 config DRM_DP_CEC
 	bool "Enable DisplayPort CEC-Tunneling-over-AUX HDMI support"
-	depends on DRM
+	depends on DRM && DRM_DISPLAY_HELPER
+	select DRM_DISPLAY_DP_HELPER
 	select CEC_CORE
 	help
 	  Choose this option if you want to enable HDMI CEC support for
-- 
2.35.1

