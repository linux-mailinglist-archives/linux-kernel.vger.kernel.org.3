Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDBD4B51EE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354380AbiBNNje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:39:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245609AbiBNNjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:39:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F08904C43C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644845964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q0nJAs/QVKzUPfZInqWn93G2x7vjNHkbBF9qYOiGnWA=;
        b=Pc8DFin9FoU9qHi/lnCvtBM4g0mo8QRtq29Uw9Z5PYhpcCzAD07cpVg2leT4e0Qrv6/LPL
        XKF1a1JR1eB5iTakejv48Df8CG5FbFsq0DE4MZgEwcmf/Hr9PQjexORRxskpCzYBzN2vYv
        TCrIdYVH1Jy7Y61NXjrN4DxiGHH84u0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45-ThiNw74oMxmnJvj48tXH1w-1; Mon, 14 Feb 2022 08:39:22 -0500
X-MC-Unique: ThiNw74oMxmnJvj48tXH1w-1
Received: by mail-wr1-f69.google.com with SMTP id h29-20020adfa4dd000000b001e498f51244so6813129wrb.14
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:39:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q0nJAs/QVKzUPfZInqWn93G2x7vjNHkbBF9qYOiGnWA=;
        b=ojBsBjg770/GFJEOOQi6PszuDKK3C6XAFUm+n/RvKnoHK+qddpWufcVsQV2GAaW7Mr
         zD0OctSzVS4PdPeFmADseH9VOn00Bbun5sBu7oQD7peebZgAdKd7o3BGmgvH4NVUh7e3
         cog6Ys9HsV0mBHNsnZIzKLZCFDLB7vDym9Z+syX560PJs+GraH1wpi+eAX9/JXGIAm50
         gQuX4mE/Pcz0YmpGVXMFha7XPmaTaeDEHx9g6jwA/d68c+Ju9QGGWfPa6W4+rmmmzIEB
         zBUhCXIeZhNCoBR9WJrX+bPv4xI12e3DSOLDTkiCo15EI7yi1cWNgFw7rbEm9Blbyjex
         2dGQ==
X-Gm-Message-State: AOAM532oSDzHtWHKGYQ7BdpRnoIq1GUF0R8vyE1wOLNVlfqdyoO9K5n5
        ceL3js2iUfkANYa1oMHPtQSCBKyd8yqiynznHotaTL+ssxLNpDuXsPp0/BO+7FpTH9TOh68dM09
        p5VpQLCJxjpwhMHkAsgwNJ2e1TAIiKyPU9m88uMf6BjsMwQmwo3D82RQijW55OdCm5XPU7+oRqt
        k=
X-Received: by 2002:a5d:4652:: with SMTP id j18mr9457910wrs.600.1644845961603;
        Mon, 14 Feb 2022 05:39:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynrCAqmAm2n2lQ+jT84K1ccY7RTWNT1XbLbIiM5V2Tu7Q5FECiZBbqhtjbe/uKekjhMZ/1gA==
X-Received: by 2002:a5d:4652:: with SMTP id j18mr9457887wrs.600.1644845961377;
        Mon, 14 Feb 2022 05:39:21 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n20sm2108941wmq.42.2022.02.14.05.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 05:39:21 -0800 (PST)
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
Subject: [PATCH v6 5/6] MAINTAINERS: Add entry for Solomon SSD130x OLED displays DRM driver
Date:   Mon, 14 Feb 2022 14:39:15 +0100
Message-Id: <20220214133915.3278886-1-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214133710.3278506-1-javierm@redhat.com>
References: <20220214133710.3278506-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

(no changes since v5)

Changes in v5:
- Add Andy Shevchenko's Reviewed-by tag to patch #5.

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

