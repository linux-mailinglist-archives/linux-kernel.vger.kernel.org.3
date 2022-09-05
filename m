Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922FC5AD62C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238799AbiIEPUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238704AbiIEPTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:19:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F221261A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662391170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZNisDhpi4BOnPBk5Q4gtZJ5EEe/qIg6dIjsLwDYtTko=;
        b=cYx3M3viuuuQny9TJX1bf1lo7HUKGVOuLJVznO4dtDyahD1+pDzfKUfDOnsWeHBxpjbNIs
        vrS5jSoiKcoFNV5rmM0m5kEVfiGRDtleVwDYS5G9YWaryUGN7kNdcqbh0VhzOLrIyo2/15
        v1tERyf2umHqP74I+/s1l/Rb/vU75/4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-616-l7WRz_VLO6SYzv1kiCp1EA-1; Mon, 05 Sep 2022 11:19:29 -0400
X-MC-Unique: l7WRz_VLO6SYzv1kiCp1EA-1
Received: by mail-wr1-f70.google.com with SMTP id a13-20020adfbc4d000000b00228631ddfafso791246wrh.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 08:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZNisDhpi4BOnPBk5Q4gtZJ5EEe/qIg6dIjsLwDYtTko=;
        b=LoxqlZuSpWHoQeW49OCmlnvQNIKBjdpCPgEpW7ShrIjn0i1UPzUw/e0EAxdzFBcuQ/
         Gcki2eD+MG96B34AAlWmWz+JPnvGyuTsQC/z9ou7IA13vsnmsLu1kz1PbzIbKbecLSfA
         4/r1qHPdIWcVK7JB0i5tqIYyWFiplD+4G6ZhpGVNx63fKUGjjDe5cez9E7+vkIE/TMIe
         ge+GSerE5fTy7RWgGDk0bNeTJF+g712P9wWeD2PEFCbFeZiIrXV8IG9lcfuaQc6YjT2+
         2vvjhNImHP3Z/TjvzR7j6opbmPf2o0es2irhV0C/VDKZwcO2TXJL2FMFwrmHUcbM6Zz8
         HkHw==
X-Gm-Message-State: ACgBeo0CN8wRnlGkp/c4WUcfjlagNND1yVopYF+8JzvD7KZz98FzsIuP
        6wQGKNJ5cFwrA7BPzUk7btQyhS2EIXSE39WDm4kozcM95gDe9YgfPi47BwOtIozvZ33fOlZuFmc
        1l2tjsRbbKiS5feSWCz0yJ/Df
X-Received: by 2002:a5d:574a:0:b0:228:b90c:e5ee with SMTP id q10-20020a5d574a000000b00228b90ce5eemr1807459wrw.328.1662391168240;
        Mon, 05 Sep 2022 08:19:28 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6eWxwVNqHxhAwNSWdaScWGMzVC83ybJupld88qShpGqLG4sQlF8ye4ahmYcqUVP9A/HW6EjQ==
X-Received: by 2002:a5d:574a:0:b0:228:b90c:e5ee with SMTP id q10-20020a5d574a000000b00228b90ce5eemr1807443wrw.328.1662391168083;
        Mon, 05 Sep 2022 08:19:28 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id t4-20020a05600001c400b00228aea99efcsm2209641wrx.14.2022.09.05.08.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 08:19:27 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND drm-misc-next 5/8] drm/arm/malidp: use drm_dev_unplug()
Date:   Mon,  5 Sep 2022 17:19:07 +0200
Message-Id: <20220905151910.98279-6-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220905151910.98279-1-dakr@redhat.com>
References: <20220905151910.98279-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

