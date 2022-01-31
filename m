Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403A54A4FFD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378477AbiAaUPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:15:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46706 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378385AbiAaUPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643660150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=P/KHNPBIlcRDaY5ETa8oTdy0xiJiz17FpbXZqN4X7V4=;
        b=OoLJot0H+vf0ohfIJX9ItZagq+Z/conCPSuJkpAUZfSlGZeOlb1E8f/RtjqYFREau6lJgE
        5LMWM7IsRPx2DOTUn9LJEPfE+RNvDwRGC00AoWFA6fF9k8I83duu78sh1hXeN90FrrsKa1
        yEH9JyG7A3VDyXPXFqbDD+bRHZuOtAI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-Pt5AZmh4PnCOeVpE23pDfQ-1; Mon, 31 Jan 2022 15:15:48 -0500
X-MC-Unique: Pt5AZmh4PnCOeVpE23pDfQ-1
Received: by mail-wm1-f69.google.com with SMTP id o194-20020a1ca5cb000000b00350b177fb22so137519wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:15:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P/KHNPBIlcRDaY5ETa8oTdy0xiJiz17FpbXZqN4X7V4=;
        b=IMVhWnY+B3QcKbkWzb7JweUXmCHJXIHayCfEVUGL1kgSEYaMLbrZWn3+y2sQ+XzJnt
         Jk+6L6130uB7v9bq/xONMUf6BpXmBdM/jvuLaTlY0nrvmfpNjVE7ODqA7fvf0ovpPzI6
         upPIRi7WduUM32ohSpM7tqo1a/XAeXGpelcNYYCyGPNZSNfBJHepBS9cb8pTgTV2vRPF
         GH1v2PYi2R1lgxXWI4/+lKfuKleU2SUmAVUaAiUqk/c5XN7D7i5yBdBgnjl2e/iA2j+c
         AAk0XNvLgvylUDYTRj+Go1MEVseIkoHKt2lrDWEf+JW17bm2uGhFkqoLAip/uE69lQQZ
         se2w==
X-Gm-Message-State: AOAM533UT/nrManPadeNMqTVCi+kl7bm9jLEH3qALlsWreTUGV5ez24k
        BRqzBbnbezMDvleT75cRQhxnxrsRx8VOEgZ//2eQ+HOU6QJeXWnEc8t9QuDnpyC/6a/B/HOI3Zo
        Gq0yZYCUbxp92ybF1/BD7A86ptW363r0nqS412PR+cZu05q4OtYEM3zpznEd6VFq1sVmYoJdSva
        8=
X-Received: by 2002:a05:6000:1568:: with SMTP id 8mr19296564wrz.54.1643660147670;
        Mon, 31 Jan 2022 12:15:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwkX67HueJQ6/s9AOMuGXHq/iOmq0TwIP4aXBdkOVjFwHzTVLicQvA1eGq6qlRfaX+3usULDg==
X-Received: by 2002:a05:6000:1568:: with SMTP id 8mr19296541wrz.54.1643660147387;
        Mon, 31 Jan 2022 12:15:47 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o3sm12574638wrq.70.2022.01.31.12.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 12:15:47 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 4/4] MAINTAINERS: Add entry for Solomon SSD1307 OLED displays DRM driver
Date:   Mon, 31 Jan 2022 21:15:37 +0100
Message-Id: <20220131201537.2325487-1-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make sure that tools like the get_maintainer.pl script will suggest
to Cc me if patches are posted for this driver.

Also include the Device Tree binding for the old ssd1307fb fbdev driver
since the new DRM driver was made compatible with the existing binding.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d03ad8da1f36..2e6c3aad5d71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6102,6 +6102,13 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/repaper.txt
 F:	drivers/gpu/drm/tiny/repaper.c
 
+DRM DRIVER FOR SOLOMON SSD1307 OLED DISPLAYS
+M:	Javier Martinez Canillas <javierm@redhat.com>
+S:	Maintained
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+F:	Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
+F:	drivers/gpu/drm/tiny/ssd1307.c
+
 DRM DRIVER FOR QEMU'S CIRRUS DEVICE
 M:	Dave Airlie <airlied@redhat.com>
 M:	Gerd Hoffmann <kraxel@redhat.com>
-- 
2.34.1

