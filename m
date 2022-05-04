Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458E951B17A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378931AbiEDWB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352006AbiEDWBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:01:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72C724C7BB
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 14:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651701496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J9HgWbd8sU4BMyUvUsTJN8e3BPoAu1T5H5ui+stohEE=;
        b=So+BpLNVPCiQ/WB/zdHMlSMLOY7MabjIy6VhzSe276e0FxsFeJrmZ+6kwjepD12Jprjeo4
        QltDsQVOPboIuIeUAno0QAKL05YKLcFGfrweQIcew7Gf1qW3JKkYVGwebgMQJWnc0PhRo/
        3wa77LW6Bw2DXmyTulz4n4y2WYgljq4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-9PilUsThORWErYDVBCAj5g-1; Wed, 04 May 2022 17:58:15 -0400
X-MC-Unique: 9PilUsThORWErYDVBCAj5g-1
Received: by mail-wm1-f71.google.com with SMTP id n186-20020a1c27c3000000b00392ae974ca1so1915887wmn.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 14:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J9HgWbd8sU4BMyUvUsTJN8e3BPoAu1T5H5ui+stohEE=;
        b=LwlZqmS5B5yIxkN/384fJppPvzSms/F5nZa6QVsaMsaxZh421DrWr4p7w+3Cmer9Nm
         MTPfzJVCdy2178pkVX+e5Vkkkgdej33TJhKjA7Flt1WKs6/7uZFfRUamVub1X9I0uLjQ
         tC6yZfZqYZXvd27SHoF03eyhwQYCKl9sNbt8TpTyVy8NaZICfySPnopWwRTKKStDIiDQ
         FyooflCIN0A5oc7HGDRDWsxie/C2hl7Cv5vaGaO3EtEvZ5WS4mZ+Hpcq+XdlGW7aFJyK
         BJt9AzndAKphczCLwbxrwwEqR/fhNBbofTaHcVUR0YxpEam76u9gBh76Hq0U3EcnYS3U
         9ySA==
X-Gm-Message-State: AOAM530EzZ/xjbI/jrCVbxso/PoVXkwrQGEpObBVjqFcVxa7HqgwWejP
        grYIH/EDErtwfdpVE9hzeNXrfjF07nyGZybjesJ2+m3Nwk5/92/m9J3zPYqyevbFwPyHvClZdje
        Yj30a5izqfAvMLd/gUBXYdxjSA7HDgMvvWxYgXq8pQ4hGoOq2eeIMA4GQCzxlcWSOPwCzVs6aZZ
        c=
X-Received: by 2002:a5d:584a:0:b0:20c:5a8b:cee7 with SMTP id i10-20020a5d584a000000b0020c5a8bcee7mr14891890wrf.111.1651701494367;
        Wed, 04 May 2022 14:58:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyi1rI7Ysw/yS2KuEXDRIJhqrF+e633rbFMsZfhkqQBH5RX7aHp1FggslnaX3+T4EtZ2beo3g==
X-Received: by 2002:a5d:584a:0:b0:20c:5a8b:cee7 with SMTP id i10-20020a5d584a000000b0020c5a8bcee7mr14891871wrf.111.1651701494069;
        Wed, 04 May 2022 14:58:14 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q10-20020a1cf30a000000b003942a244ee9sm4553648wmq.46.2022.05.04.14.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 14:58:13 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>, Peter Jones <pjones@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 3/3] fbdev/efifb: Cleanup fb_info in .fb_destroy rather than .remove
Date:   Wed,  4 May 2022 23:58:06 +0200
Message-Id: <20220504215806.57147-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220504215151.55082-1-javierm@redhat.com>
References: <20220504215151.55082-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is calling framebuffer_release() in its .remove callback, but
this will cause the struct fb_info to be freed too early. Since it could
be that a reference is still hold to it if user-space opened the fbdev.

This would lead to a use-after-free error if the framebuffer device was
unregistered but later a user-space process tries to close the fbdev fd.

The correct thing to do is to only unregister the framebuffer in the
driver's .remove callback, but do any cleanup in the fb_ops.fb_destroy.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/efifb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index ea42ba6445b2..cfa3dc0b4eee 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -243,6 +243,10 @@ static void efifb_show_boot_graphics(struct fb_info *info)
 static inline void efifb_show_boot_graphics(struct fb_info *info) {}
 #endif
 
+/*
+ * fb_ops.fb_destroy is called by the last put_fb_info() call at the end
+ * of unregister_framebuffer() or fb_release(). Do any cleanup here.
+ */
 static void efifb_destroy(struct fb_info *info)
 {
 	if (efifb_pci_dev)
@@ -254,6 +258,9 @@ static void efifb_destroy(struct fb_info *info)
 		else
 			memunmap(info->screen_base);
 	}
+
+	framebuffer_release(info);
+
 	if (request_mem_succeeded)
 		release_mem_region(info->apertures->ranges[0].base,
 				   info->apertures->ranges[0].size);
@@ -620,9 +627,9 @@ static int efifb_remove(struct platform_device *pdev)
 {
 	struct fb_info *info = platform_get_drvdata(pdev);
 
+	/* efifb_destroy takes care of info cleanup */
 	unregister_framebuffer(info);
 	sysfs_remove_groups(&pdev->dev.kobj, efifb_groups);
-	framebuffer_release(info);
 
 	return 0;
 }
-- 
2.35.1

