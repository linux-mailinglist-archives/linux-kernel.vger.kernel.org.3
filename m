Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC75517E62
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiECHTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiECHT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 046162CCB4
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 00:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651562154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VNf4e3fbyBJGkVRkEbfckfxgCWLnKBLAoem7Lai8HII=;
        b=fQxN8zSNz+U94gqdOUqI+GomEzjbFHJXsGswxn0i/vFWSCdkInxrEFwRtCemZpwBd85PoR
        e20ISoOaRnrGdQeQJFHr5uaLRbK4Yq3Zcq9Eby0+ConCVOy14+MyRMsSIknTpuNlvL6BXz
        x0Enaqip9vqiKh+TfLHhEFvchTTUEiM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-n-MCGQuMNMWTpk_e8eWYcw-1; Tue, 03 May 2022 03:15:52 -0400
X-MC-Unique: n-MCGQuMNMWTpk_e8eWYcw-1
Received: by mail-wr1-f71.google.com with SMTP id w11-20020adf8bcb000000b0020c550ba8d7so2489002wra.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 00:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VNf4e3fbyBJGkVRkEbfckfxgCWLnKBLAoem7Lai8HII=;
        b=5hmUjVtpFSND3ghKGZmKcI+fEXnh0Nq7MlOQQrU2KztZ3UKvOFAa+ZVIthizAxcEbw
         gbM2lE8W6YFOySkjQVsDGBorvDukdWujasc66wZ9UOoBks3YQGETx3DtZMjFBnEsTyR2
         n4Qo+al/LTrjFYCh0AQ0JQbtCa0uq4D5KhDatpxE/payH6Ji0cakWth5tWZjXRdvV23n
         8yzVZvRCOhTyitwZEGH6cq6FwlWHDqTi+efijIMMkGSeRk5OV4Mp9+AgE5TbUhlMbmfg
         DVPwLzQGTSXWYk9uMEMz0UxNbp6xj7NUxgjnXoY885Q7Ql12ennlPb+v5leiPzHsgbuQ
         5RIQ==
X-Gm-Message-State: AOAM530rW/XXfwX+I75dMBwKnDi36aFWXxMxNypZsQhcrd05qIVZRUWu
        +rfGrh7NUZ3S4WEMeDS3EfOpaBGP43dEidyH+qH3UAY/zR0e+2/Np9vFq97NEJ6BNyfjiRkHYoM
        UR3jQzMwJEGEmDABm/zdvfWGyFhIjBY2v0CgtgHFwovHrulRL76HLl+cSHW0LXV62CLBX4jZ41N
        U=
X-Received: by 2002:a5d:4307:0:b0:207:9f82:e238 with SMTP id h7-20020a5d4307000000b002079f82e238mr12237329wrq.430.1651562150692;
        Tue, 03 May 2022 00:15:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyt/DpumST4sznzbp8voI+uEPyajFQx/vgp8YQ3FbrRg/zCpbZ5SRq2WP4wKlQfVMCSVT2fYw==
X-Received: by 2002:a5d:4307:0:b0:207:9f82:e238 with SMTP id h7-20020a5d4307000000b002079f82e238mr12237310wrq.430.1651562150401;
        Tue, 03 May 2022 00:15:50 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c339400b003942a244f33sm1035387wmp.12.2022.05.03.00.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 00:15:50 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 1/3] drm: Remove superfluous arg when calling to drm_fbdev_generic_setup()
Date:   Tue,  3 May 2022 09:15:38 +0200
Message-Id: <20220503071540.471667-2-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503071540.471667-1-javierm@redhat.com>
References: <20220503071540.471667-1-javierm@redhat.com>
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

The drm_fbdev_generic_setup() function already sets the preferred bits per
pixel for the device to dev->mode_config.preferred_depth, if preferred_bpp
value is zero.

Passing the same value to the function is unnecessary. Let's cleanup that
in the two drivers that do it.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

(no changes since v1)

 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 2 +-
 drivers/gpu/drm/tiny/cirrus.c                   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index fe4269c5aa0a..ace92459e462 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -349,7 +349,7 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
 		goto err_unload;
 	}
 
-	drm_fbdev_generic_setup(dev, dev->mode_config.preferred_depth);
+	drm_fbdev_generic_setup(dev, 0);
 
 	return 0;
 
diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
index c8e791840862..ed5a2e14894a 100644
--- a/drivers/gpu/drm/tiny/cirrus.c
+++ b/drivers/gpu/drm/tiny/cirrus.c
@@ -601,7 +601,7 @@ static int cirrus_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	drm_fbdev_generic_setup(dev, dev->mode_config.preferred_depth);
+	drm_fbdev_generic_setup(dev, 0);
 	return 0;
 }
 
-- 
2.35.1

