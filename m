Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26F151253D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 00:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiD0W14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbiD0W1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 965012E0BA
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651098281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Qr4MU4/s4LvUq27SfddGnKVd9R5tIj+q1sHUP3u3fiM=;
        b=QmKekI113Xcmc8IF9hw+XncC+d/bglPabYXgM9ze+dJkrJRYLNmKtJX1CJZMG5uH7J0vB4
        jTZriP6AKgx23+c2zdmWsyDjBGtYR7n4+QLECMQrwvtohq7EA6UGumy7app4CcOSqYPQM/
        W2Aylypz9IWgfjT4YgG/k5QIPVMliQo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-giruKvJsOwin5w5dxWY5jQ-1; Wed, 27 Apr 2022 18:24:40 -0400
X-MC-Unique: giruKvJsOwin5w5dxWY5jQ-1
Received: by mail-lf1-f71.google.com with SMTP id bt27-20020a056512261b00b004720e026d4dso1180817lfb.16
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qr4MU4/s4LvUq27SfddGnKVd9R5tIj+q1sHUP3u3fiM=;
        b=pIDa2EkaONaZX1s0rUNEzV6oEXzOh+E1PXowx+JNyl+bre/Ip/pe2WIXsV5ZH8LviQ
         Gl0rBLRkPFdt9IwxqlOh7QIhTNrXoXpt/11OKE3M0w28v6hVPEo5oNObwhHZ/b2vw/fw
         6Ce/ZJvIYOb34UEsqv9g1E/NZNLuJ6DJZpZybxlhRtN+K1CuD3lfI9Z13R5VcWpV2OAj
         CUyDuht6bgL8go2toDvOQjpAHxMYfmcpuzit6DtEaxAH+6gCkNQjYW4SScPWKDIs45FY
         ylqtyUfbNoMRbTX6rY6BC5nLcYHTk2g/dYgvZl0xSpjhlI0Q3YdXNv9RV3DURIaFIhFP
         woEg==
X-Gm-Message-State: AOAM530/KBMllJHeli0L4KRWhxTVN203OEt9pAeCjjzEFuKTaeOqOYsU
        8QhWsFf6v46DSpBIy4R1jFmyu9S75YzrnkYPyKZ1L0CWIfAbJDim1OpzK5FNHGosFjTW1WcRB6S
        z9kO5zntM07SSZt1T2LIJMksqsTJAJzkyGe1BhmOsReZdBNKb87SoXUzlp6w5eU/MCs7hTepGU0
        Q=
X-Received: by 2002:a05:6512:1319:b0:44a:c200:61e5 with SMTP id x25-20020a056512131900b0044ac20061e5mr21990117lfu.550.1651098278727;
        Wed, 27 Apr 2022 15:24:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRP5NVvfVLFQtoQbpfc/PozRMwNi4jv7Z/n1MdceTR2qQBqzUinnuR5+PQZQaDcs93GP369A==
X-Received: by 2002:adf:ef01:0:b0:20a:8068:ca5e with SMTP id e1-20020adfef01000000b0020a8068ca5emr23634532wro.661.1651096541322;
        Wed, 27 Apr 2022 14:55:41 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b5-20020adff905000000b0020a8781be70sm14377139wrr.12.2022.04.27.14.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 14:55:41 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Lyude Paul <lyude@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/display: Select DP helper for DRM_DP_AUX_CHARDEV and DRM_DP_CEC
Date:   Wed, 27 Apr 2022 23:55:28 +0200
Message-Id: <20220427215528.237861-1-javierm@redhat.com>
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

Note: It seems this has been an issue for a long time but was made easier
to reproduce after the commit 1e0f66420b13 ("drm/display: Introduce a DRM
display-helper module"). Adding a Fixes: tag just to make sure that this
fix will be picked for stable once the mentioned change also lands there.

Fixes: 1e0f66420b13 ("drm/display: Introduce a DRM display-helper module")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- Explain better the issue in the change description.
- Only select DRM_DISPLAY_DP_HELPER and not DRM_DISPLAY_HELPER.

 drivers/gpu/drm/display/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/display/Kconfig b/drivers/gpu/drm/display/Kconfig
index f84f1b0cd23f..9fe80c4e555c 100644
--- a/drivers/gpu/drm/display/Kconfig
+++ b/drivers/gpu/drm/display/Kconfig
@@ -32,6 +32,7 @@ config DRM_DISPLAY_HDMI_HELPER
 config DRM_DP_AUX_CHARDEV
 	bool "DRM DP AUX Interface"
 	depends on DRM
+	select DRM_DISPLAY_DP_HELPER
 	help
 	  Choose this option to enable a /dev/drm_dp_auxN node that allows to
 	  read and write values to arbitrary DPCD registers on the DP aux
@@ -40,6 +41,7 @@ config DRM_DP_AUX_CHARDEV
 config DRM_DP_CEC
 	bool "Enable DisplayPort CEC-Tunneling-over-AUX HDMI support"
 	depends on DRM
+	select DRM_DISPLAY_DP_HELPER
 	select CEC_CORE
 	help
 	  Choose this option if you want to enable HDMI CEC support for
-- 
2.35.1

