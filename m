Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30875AD67A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbiIEP2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238982AbiIEP23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:28:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0C661B2E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662391648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FE6F/FaZU56VVek/ild/rdOe20eLgXYTWVytxZbV5OU=;
        b=BrBryYJSqQFDz7IoeBGTa4OHr01RLtlBbfIwq35pywSAP2w69MT5dPVP92R+pOASplCRTZ
        st3/YbJcJFlQqjkdCdKQltFpwO5TBnWVLZMIzGpxGz5T6bjwiBGTrmt7y76vPL1/blOXJr
        PZ9NSzB4wvg0FgjyqF20UXKUXFGG4kw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-424-o-UVyxE6PzOienL87QkROQ-1; Mon, 05 Sep 2022 11:27:27 -0400
X-MC-Unique: o-UVyxE6PzOienL87QkROQ-1
Received: by mail-ed1-f72.google.com with SMTP id y14-20020a056402440e00b0044301c7ccd9so5932753eda.19
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 08:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FE6F/FaZU56VVek/ild/rdOe20eLgXYTWVytxZbV5OU=;
        b=fSo6RL96aD1HVTJLzs4UyVao5ieJi+r54Eo+55gvYlwBvpdTmFAVd5WeX1H2R96AM0
         sNpI54zlND/SwPeJyErp8rkiRse0S+ACCQLsspvraS4orpD/o/ki7VFi91mn7IFr+hyF
         dfyvBVVD9jHP0coCmPvywwdxH95KUmnlN1XJeEu6IKOqHbfTd9uOIAOQChJIhjyjF25X
         BZw2b1ItaiGC7Hf/Rlp+/5VwKBtxUvVuTKYQ+9b/VmpGFt/CwE91xfbmBisgWWDr8CAB
         2IjelGUkqD+MOJDjiP2hTQbILIrCdsl88XWW4H7qGSDX55i+GPUJg1LeZt4s7vydDAyV
         KtFw==
X-Gm-Message-State: ACgBeo1Z6mYc+48CN8Vatdes9YPY7hRHpGSxerksiKLKjYK9kL1CjWDH
        vCRb3AnJrh5syz7h9W8fL7gkFwdWS8G5ecsdibT0ZbBxf3tbXO5UtBo76IcoHAUea27/wIQ+vrq
        lZlXgty7iw7rVLPv3tWf6CJ9F
X-Received: by 2002:a05:6402:440c:b0:43a:1124:e56a with SMTP id y12-20020a056402440c00b0043a1124e56amr44852799eda.134.1662391646403;
        Mon, 05 Sep 2022 08:27:26 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4BS5DNOpTRPfqGzZykMKxlBAlMPKYg+ROhMX68+pN9BWH3v/YckKemYfM6AbpZZ05FOv8u2A==
X-Received: by 2002:a05:6402:440c:b0:43a:1124:e56a with SMTP id y12-20020a056402440c00b0043a1124e56amr44852783eda.134.1662391646266;
        Mon, 05 Sep 2022 08:27:26 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id bv6-20020a170906b1c600b00730979f568fsm5145387ejb.150.2022.09.05.08.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 08:27:25 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND drm-misc-next 1/7] drm/arm/hdlcd: use drmm_* to allocate driver structures
Date:   Mon,  5 Sep 2022 17:27:13 +0200
Message-Id: <20220905152719.128539-2-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220905152719.128539-1-dakr@redhat.com>
References: <20220905152719.128539-1-dakr@redhat.com>
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

Use drm managed resources to allocate driver structures and get rid of
the deprecated drm_dev_alloc() call and replace it with
devm_drm_dev_alloc().

This also serves as preparation to get rid of drm_device->dev_private
and to fix use-after-free issues on driver unload.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/hdlcd_drv.c | 12 ++++--------
 drivers/gpu/drm/arm/hdlcd_drv.h |  1 +
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index a032003c340c..463381d11cff 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -247,13 +247,11 @@ static int hdlcd_drm_bind(struct device *dev)
 	struct hdlcd_drm_private *hdlcd;
 	int ret;
 
-	hdlcd = devm_kzalloc(dev, sizeof(*hdlcd), GFP_KERNEL);
-	if (!hdlcd)
-		return -ENOMEM;
+	hdlcd = devm_drm_dev_alloc(dev, &hdlcd_driver, typeof(*hdlcd), base);
+	if (IS_ERR(hdlcd))
+		return PTR_ERR(hdlcd);
 
-	drm = drm_dev_alloc(&hdlcd_driver, dev);
-	if (IS_ERR(drm))
-		return PTR_ERR(drm);
+	drm = &hdlcd->base;
 
 	drm->dev_private = hdlcd;
 	dev_set_drvdata(dev, drm);
@@ -319,7 +317,6 @@ static int hdlcd_drm_bind(struct device *dev)
 err_free:
 	drm_mode_config_cleanup(drm);
 	dev_set_drvdata(dev, NULL);
-	drm_dev_put(drm);
 
 	return ret;
 }
@@ -344,7 +341,6 @@ static void hdlcd_drm_unbind(struct device *dev)
 	drm_mode_config_cleanup(drm);
 	drm->dev_private = NULL;
 	dev_set_drvdata(dev, NULL);
-	drm_dev_put(drm);
 }
 
 static const struct component_master_ops hdlcd_master_ops = {
diff --git a/drivers/gpu/drm/arm/hdlcd_drv.h b/drivers/gpu/drm/arm/hdlcd_drv.h
index 909c39c28487..3892b36767ac 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.h
+++ b/drivers/gpu/drm/arm/hdlcd_drv.h
@@ -7,6 +7,7 @@
 #define __HDLCD_DRV_H__
 
 struct hdlcd_drm_private {
+	struct drm_device		base;
 	void __iomem			*mmio;
 	struct clk			*clk;
 	struct drm_crtc			crtc;
-- 
2.37.2

