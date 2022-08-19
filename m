Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE37E59A7B8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 23:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352478AbiHSVZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 17:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352452AbiHSVY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 17:24:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F918E2C67
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660944294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZNisDhpi4BOnPBk5Q4gtZJ5EEe/qIg6dIjsLwDYtTko=;
        b=VUjI9ajBhinWVDcJ4FDZfm3la+NYyQZdypNEIdpNp8xaaFviHV08kKUUhSZ8qo92JGWSNN
        nFMp6sKACIsYgi1w2UUc5oTfYplC0EcRK7h44J+ppCzih57XXpGKhg1oeXr7mUv6CSObKM
        +cXg4H4X3/d6v7tdPNkKtNRSsPy98q0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-193-L087EfdmNSKkIVX_zNaOpw-1; Fri, 19 Aug 2022 17:24:52 -0400
X-MC-Unique: L087EfdmNSKkIVX_zNaOpw-1
Received: by mail-ej1-f72.google.com with SMTP id qk37-20020a1709077fa500b00730c2d975a0so1908042ejc.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZNisDhpi4BOnPBk5Q4gtZJ5EEe/qIg6dIjsLwDYtTko=;
        b=Fp02hnGRseZ478mMiVGEIu9+Mp16IBp6Nrr3lMByrKjZmKHpcm/JffPn7f34Q7rKQm
         +N+rsiLZS51Y8mg7vGIjJIdBmPG5eqwQ7ue/cET1ONGpZmTlZy9Y+DLPaHJ21Y85+SS7
         ePFyTvov/+7hBFlS/51zP7QmKMIlQh6WZCRYiInjGF6ZsiNj2rEDtGeyjzOiFd3hZBnm
         x01pubGDIA0CglIKHMLtgXa4RP9C1deUcNfdhEFxB9EJ2M6BOJVQksCCs3bJFW5t+JkO
         tnxI7v8d8erCssRtvoCIo4N3Quv46SiKpEeRm0arc8tjNgvxztKvTOVwT9nOcBiZq1Le
         c1Ww==
X-Gm-Message-State: ACgBeo0KTsUZ7wzgsjxnyA4AMtjf4lk25mwyT8IwXfHVVB+dn/NwbgLR
        UuUX06IYmQ/+RncNE+4I6+03w//oxW78Yv4dyhpAkpVRDwlMHwOqx17yXdB62Tejky8wAKlStXN
        n8942i+tN5ZHyU4gmDVAkeb/H
X-Received: by 2002:a05:6402:c45:b0:442:c549:8e6b with SMTP id cs5-20020a0564020c4500b00442c5498e6bmr7454923edb.123.1660944291636;
        Fri, 19 Aug 2022 14:24:51 -0700 (PDT)
X-Google-Smtp-Source: AA6agR49IKZ4pGTeuQlGM57eBuT/of7Y2qxJpRK+S8Nj2BgkCRrujKKcPSdvM66LTG6G1UhdU+EVxA==
X-Received: by 2002:a05:6402:c45:b0:442:c549:8e6b with SMTP id cs5-20020a0564020c4500b00442c5498e6bmr7454914edb.123.1660944291440;
        Fri, 19 Aug 2022 14:24:51 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id k21-20020a170906579500b0072fa24c2ecbsm2842999ejq.94.2022.08.19.14.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 14:24:50 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 5/8] drm/arm/malidp: use drm_dev_unplug()
Date:   Fri, 19 Aug 2022 23:24:42 +0200
Message-Id: <20220819212445.559790-3-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819212015.556220-1-dakr@redhat.com>
References: <20220819212015.556220-1-dakr@redhat.com>
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

When the driver is unbound, there might still be users in userspace
having an open fd and are calling into the driver.

While this is fine for drm managed resources, it is not for resources
bound to the device/driver lifecycle, e.g. clocks or MMIO mappings.

To prevent use-after-free issues we need to protect those resources with
drm_dev_enter() and drm_dev_exit(). This does only work if we indicate
that the drm device was unplugged, hence use drm_dev_unplug() instead of
drm_dev_unregister().

Protecting the particular resources with drm_dev_enter()/drm_dev_exit()
is handled by subsequent patches.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/malidp_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 678c5b0d8014..aedd30f5f451 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -893,7 +893,7 @@ static void malidp_unbind(struct device *dev)
 	struct malidp_drm *malidp = drm_to_malidp(drm);
 	struct malidp_hw_device *hwdev = malidp->dev;
 
-	drm_dev_unregister(drm);
+	drm_dev_unplug(drm);
 	drm_kms_helper_poll_fini(drm);
 	pm_runtime_get_sync(dev);
 	drm_atomic_helper_shutdown(drm);
-- 
2.37.2

