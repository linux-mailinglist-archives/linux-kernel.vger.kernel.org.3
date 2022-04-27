Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F215123D9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 22:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbiD0U3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 16:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236564AbiD0U2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 16:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1B22B18A4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651091120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DWkcC1Mw2kGsDS6+CAaSOc7PdrzllYlAOUnL4kSDScE=;
        b=SzGQQII8i5ZjOrdpkhW6N5DvWZwjAuKqw0koUZQEh4+B8I79YEPwbB2g7xojimOfqX9NnI
        guj586IV91epcQ0/ok/vu1PdL4fYaI3OX55hgLdXcdcfsIak4vp8qzCZoD5RFW4n8DYhHf
        IImUWZoD28e1kXOJR2ExadK+Kk9i50M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-1ik5oXm6Pz-gKhopaSSKNA-1; Wed, 27 Apr 2022 16:25:19 -0400
X-MC-Unique: 1ik5oXm6Pz-gKhopaSSKNA-1
Received: by mail-wr1-f70.google.com with SMTP id e21-20020adfa455000000b0020ae075cf35so1151329wra.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 13:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DWkcC1Mw2kGsDS6+CAaSOc7PdrzllYlAOUnL4kSDScE=;
        b=rnzP6OVu8m2Nu9c//66M6KMsXXVltlkzWozNctrfiRtCLnuUz8C25VYH8SSeDl7E//
         p6NJZMj7DyQ0OjjaKewrkYWUK8Ucumu/50TLXSkgvpRLD93o6uc/sdQtG9GT4UP7aBE+
         7AdEZf6KahDn7mKYHb2N/nc89xKr09+cj7bpoHD6QmmDJsNkVakW89ivlaVJC4HbLdiT
         q0MbJd5CcN7odKMqkdDfj1miV9Ne1CD+0NCfqDbA7MoTA9nDZgA9PAZkOP0w1+9CkyCr
         fH8/m6wl2gnMvWbMZa5zypZSlBZghsk+9qbn1ajvATVP0RqWclWQNUYp3AETbjh44zyU
         W+AQ==
X-Gm-Message-State: AOAM532BkF2gsttdc916VxOx0tfTCtxrjmrAxRmKUk1XssAnicItmBdu
        +NbTFN4UX8Ur8iC8xmT01sTiLI+q5V3jkVjiweaNfP/4r3sQ3NVW94+g5DyM2kybGqT75qd5b4g
        vR7BXudBcCk9/SJIW6sjHFqCy04NpTs+WKrpcIqcdq0w5vTx62ZfnCqWCDMiNr5PY3/iVjvuzej
        8=
X-Received: by 2002:a05:6000:178f:b0:20a:8009:7cd3 with SMTP id e15-20020a056000178f00b0020a80097cd3mr23927710wrg.532.1651091118348;
        Wed, 27 Apr 2022 13:25:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeyUQBNyusRg7cR3OhmiRejZFOBGxuVFHcl4pM81Q6ah77SVWgTi13DCfSIVex/7kUiivQwQ==
X-Received: by 2002:a05:6000:178f:b0:20a:8009:7cd3 with SMTP id e15-20020a056000178f00b0020a80097cd3mr23927684wrg.532.1651091118025;
        Wed, 27 Apr 2022 13:25:18 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v2-20020adf8b42000000b0020aa790a258sm15147634wra.8.2022.04.27.13.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 13:25:17 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/display: Select DP helpers for DRM_DP_AUX_CHARDEV and DRM_DP_CEC
Date:   Wed, 27 Apr 2022 22:25:13 +0200
Message-Id: <20220427202513.46996-1-javierm@redhat.com>
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

The DRM_DP_AUX_CHARDEV and DRM_DP_CEC boolean Kconfig symbols enable code
that use DP helper functions, exported by the display-helper module.

But these don't select the DRM_DISPLAY_DP_HELPER and DRM_DISPLAY_HELPER
symbols, to make sure that the functions used will be present. This leads
to the following linking errors if CONFIG_DRM_DISPLAY_HELPER is set to m:

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

Note: It seems this has been an issue for a long time but was made easier
to reproduce after the commit 1e0f66420b13 ("drm/display: Introduce a DRM
display-helper module"). Adding a Fixes: tag just to make sure that this
fix will be picked for stable once the mentioned change also lands there.

Fixes: 1e0f66420b13 ("drm/display: Introduce a DRM display-helper module")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/display/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/display/Kconfig b/drivers/gpu/drm/display/Kconfig
index f84f1b0cd23f..d7a413a2c6cc 100644
--- a/drivers/gpu/drm/display/Kconfig
+++ b/drivers/gpu/drm/display/Kconfig
@@ -32,6 +32,8 @@ config DRM_DISPLAY_HDMI_HELPER
 config DRM_DP_AUX_CHARDEV
 	bool "DRM DP AUX Interface"
 	depends on DRM
+	select DRM_DISPLAY_DP_HELPER
+	select DRM_DISPLAY_HELPER
 	help
 	  Choose this option to enable a /dev/drm_dp_auxN node that allows to
 	  read and write values to arbitrary DPCD registers on the DP aux
@@ -40,6 +42,8 @@ config DRM_DP_AUX_CHARDEV
 config DRM_DP_CEC
 	bool "Enable DisplayPort CEC-Tunneling-over-AUX HDMI support"
 	depends on DRM
+	select DRM_DISPLAY_DP_HELPER
+	select DRM_DISPLAY_HELPER
 	select CEC_CORE
 	help
 	  Choose this option if you want to enable HDMI CEC support for
-- 
2.35.1

