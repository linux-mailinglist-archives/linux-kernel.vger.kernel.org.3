Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5435AD697
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbiIEP3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239093AbiIEP2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:28:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0FF61717
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662391662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AFFGKxt+Rynb6H3rLFquNUiuipOW4GaSN2+USkzDWw0=;
        b=TCPOSYrfa0+oqzcstFEo8G/DQEzKcY8eTPSNYNoNtAPTUguhEWfD54ruMrRk3Tfpg8MHw2
        m1dN8YbBSELA4Ycf8EyK3KXb1JBoJphawi37cpfjfa8fD466Ucb1smdyN521DGYfs6iAQI
        Nj+LtUC872z3M8+dJmAYVRIWDl2y6uA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-oZJVnwHdNDKxC1PKwWq55w-1; Mon, 05 Sep 2022 11:27:41 -0400
X-MC-Unique: oZJVnwHdNDKxC1PKwWq55w-1
Received: by mail-ed1-f69.google.com with SMTP id v1-20020a056402348100b00448acc79177so6046956edc.23
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 08:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AFFGKxt+Rynb6H3rLFquNUiuipOW4GaSN2+USkzDWw0=;
        b=BGNFYVYSeV644y4uekozMF5YezUTRjCVI78Actanjz/YeWeBFnhOZwdV3upxjRV/rp
         voXiQw43LPdy8+e5GoNW2DiXx3LHM4rmQZZpOyvm8T+TokG0d02PHTF7+40SmFt/MN3R
         3gKSnolGmcrnVUBkymI731JQm/oADcPYfLjIz49B6zIkUfWeB66PujV+yn0xRLIjOysV
         C07qOQzyvFzhyHY7+S9c65M7ILa0JvWnkdM0GvRupiPwxYBOPQ5EwG9Nj4qq+KPAC9fc
         fn9zcsKM/DzHHy9GFaEODNasP5r11FP+iNdyEnVBr+pRJpkNpVhCJCUgwm9baBgtmLB7
         KHMg==
X-Gm-Message-State: ACgBeo3ZezJ67XfpeVZTRFNolx6aJnXVib6m3dRVZFa5fAtgJkhWNdlA
        KskvoLIYQ7RnTmx+tB74YG/B38XCEMwZBgZovv/hgTTNfMzyyJ+l/OoId/gKp+sLyfKLixFqCqj
        Um+ry7X6qgFM5hIpubdq7Ytkc
X-Received: by 2002:a17:907:1c89:b0:741:4453:75be with SMTP id nb9-20020a1709071c8900b00741445375bemr30493940ejc.208.1662391660390;
        Mon, 05 Sep 2022 08:27:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6WM2uFwG2RTEDgKoROw3MIJz+VXV9au2IY/ThjnrDXlkgsiZ2ds5tMDggnRKnnGCTJfkxepA==
X-Received: by 2002:a17:907:1c89:b0:741:4453:75be with SMTP id nb9-20020a1709071c8900b00741445375bemr30493926ejc.208.1662391660199;
        Mon, 05 Sep 2022 08:27:40 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906264a00b0073cf8e0355fsm5034306ejc.208.2022.09.05.08.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 08:27:39 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND drm-misc-next 5/7] drm/arm/hdlcd: use drm_dev_unplug()
Date:   Mon,  5 Sep 2022 17:27:17 +0200
Message-Id: <20220905152719.128539-6-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220905152719.128539-1-dakr@redhat.com>
References: <20220905152719.128539-1-dakr@redhat.com>
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
 drivers/gpu/drm/arm/hdlcd_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 120c87934a91..e41def6d47cc 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -325,7 +325,7 @@ static void hdlcd_drm_unbind(struct device *dev)
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
 
-	drm_dev_unregister(drm);
+	drm_dev_unplug(drm);
 	drm_kms_helper_poll_fini(drm);
 	component_unbind_all(dev, drm);
 	of_node_put(hdlcd->crtc.port);
-- 
2.37.2

