Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EBE4B21A5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348466AbiBKJW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:22:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiBKJWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:22:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 413E4337
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644571338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/bi42S9VA+rXZukavob2heYyTf52jS05inWB/COJe28=;
        b=KHQOcee2iNrMmFYpaA6imqsaJLhUo1uBQEQ48M4EBPYRT3QG/w1kolyxEidwD4kDxzNdYf
        YZbMF+gmdDY9pLFsGqzhwh4YnSAyRKLacoLVMO5WioFSP2BDglZ5fUVAct05rFLgnleg0l
        9wPG/V5Vfexeq7Av22HMUhDioQmVOGY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-tJnvhYxoOnqAYGu3YrbsHQ-1; Fri, 11 Feb 2022 04:22:17 -0500
X-MC-Unique: tJnvhYxoOnqAYGu3YrbsHQ-1
Received: by mail-wm1-f71.google.com with SMTP id l20-20020a05600c1d1400b0035153bf34c3so5634777wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:22:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/bi42S9VA+rXZukavob2heYyTf52jS05inWB/COJe28=;
        b=bt1GeuXB9i0Fl9rrYnvux9toU2lGP4U6sNunr2AnjQsx4w6ZjDWPG0mV9qN38eLF3u
         DUKfT3ZfLVI1cU6fKhNfWwCA8FB2cI3XZSms7Cw2CgUXHk02Kmn9AA3LScFuAP/UzPKx
         r1T++C7VddwXJ7K8waYpZ9ixatLinWfMQPJ+n/14/cTEq2UNRLNwbdOjnYSFfWd7d07R
         tBa7FdBpuXzH14VB9ZCew4MxDDtc0rni+RyrZiIIOxPT7jC4LmFshtPIInRr1cLiRnWf
         G4eoFUFCt+bPv+3dCJiIPrwQWcglkjn4Aag4gUEmqbAB9cZwQlTtz6zXEXvdaVRspQe1
         qotA==
X-Gm-Message-State: AOAM531SqD+GInpfvQV/EwnU0PRf91ep09mAKg/IZ1h+sX2mNxY41+VW
        sTRmpMsdjUhNaODXTQ8yj+igyaMw92kYqmtxL5rVvK5Fs/qZrO2xRsVfw64p59KSiCw2xng6Ttq
        CrFWhjCGzOdVgFfsg/ZcWE84dpUnOAv4BN8MaSngBV9WEuH4JFXce2Iw6/EZYnvYvJ8fDm2VneS
        0=
X-Received: by 2002:a7b:cbd7:: with SMTP id n23mr1369751wmi.76.1644571336010;
        Fri, 11 Feb 2022 01:22:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVyNwlqjVh91bNTF7uCkHKI+vxIB6I7J+ATyw7Om9fonGEf2KmhkFvJu7P23thXV+nsQsQLg==
X-Received: by 2002:a7b:cbd7:: with SMTP id n23mr1369727wmi.76.1644571335738;
        Fri, 11 Feb 2022 01:22:15 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z5sm4237804wmp.10.2022.02.11.01.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 01:22:15 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v4 5/6] MAINTAINERS: Add entry for Solomon SSD130x OLED displays DRM driver
Date:   Fri, 11 Feb 2022 10:21:57 +0100
Message-Id: <20220211092157.2988713-1-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211091927.2988283-1-javierm@redhat.com>
References: <20220211091927.2988283-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make sure that tools like the get_maintainer.pl script will suggest
to Cc me if patches are posted for this driver.

Also include the Device Tree binding for the old ssd1307fb fbdev driver
since the new DRM driver was made compatible with the existing binding.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---

(no changes since v3)

Changes in v3:
- Adapt MAINTAINERS entry to point to the new drivers/gpu/drm/solomon directory.

Changes in v2:
- Add Sam Ravnborg's acked-by to patch adding a MAINTAINERS entry (Sam Ravnborg)

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d03ad8da1f36..05c306986ab0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6102,6 +6102,13 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/repaper.txt
 F:	drivers/gpu/drm/tiny/repaper.c
 
+DRM DRIVER FOR SOLOMON SSD130X OLED DISPLAYS
+M:	Javier Martinez Canillas <javierm@redhat.com>
+S:	Maintained
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+F:	Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
+F:	drivers/gpu/drm/solomon/ssd130x*
+
 DRM DRIVER FOR QEMU'S CIRRUS DEVICE
 M:	Dave Airlie <airlied@redhat.com>
 M:	Gerd Hoffmann <kraxel@redhat.com>
-- 
2.34.1

