Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1C55172F6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385903AbiEBPmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385891AbiEBPmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:42:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBD72BE09
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651505947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qGLa+lXukZKp8BbfHT/fB6GHKDmAj4WrWWwniVTMInI=;
        b=LObeA4hU56PZy3E5ow7pVk/Ojjhd4cxnwhRHj0PhLRj67DkFIpaawna6VlJ/BpPUKNDvqQ
        DroHMUclVmPmcbHNQ5Ea75gBKnK1if0c3tVOjRCO8lLRZGU3JvbJMqGXalePziMEO0xedw
        4zAQmmTUsfw2WRjup/0s62sJulYu3BA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-547-GerOuCvhNheqZJNQz4QZ6g-1; Mon, 02 May 2022 11:39:06 -0400
X-MC-Unique: GerOuCvhNheqZJNQz4QZ6g-1
Received: by mail-wr1-f72.google.com with SMTP id l7-20020adfa387000000b0020acc61dbaeso5463736wrb.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 08:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qGLa+lXukZKp8BbfHT/fB6GHKDmAj4WrWWwniVTMInI=;
        b=Nj0DWEvWq+qRZ46Nx+Xvpfn5IGX1rXDmlbs2DBfWw+RIgF7+2fgsaIIoG0rV5S7qbf
         UeKpiQeSCd9oFwb2gziFxp6DDSZUnu6B37d4IBhunGN+BP0vrvqBwiQCkz//ZgmJrfyc
         q5Y/yg4VLYSlk3WXh6cMGItDcjHABfoTAfuhiAgPV9HwHhcM9hr16/QubqBH8lZIz5J7
         QdGBWo0BnoR0Up5PgrPDLPuFzTWwwPPNMsTXrI/BwGphCfSm42ti2cm+h49rEkspRU1K
         2xxpckw6cS/xtEAEBK91nwJSPfwiarVqTjCchSwv6c7U3zPlP5KS02GTz4sNJf81cL7E
         kgPQ==
X-Gm-Message-State: AOAM532Z2bb9KTe+00cXeuGPDNch9MmpXs1ZVJNsmhIxEaG7G7X8dQJ0
        2mTTWz4F/lkE0oEvqcIuIvf43Pmr11brPZcyBRiH9nbN4x0ZMyQrVIVAkbl/rzTSTjl3dDpMBCd
        d9wJJ1zpkWaX3QfZfuHLejlAICEmlf98S0+S1oRv5GV2AxFkyhCfJYJtCPd1eow0e9HrqyUdKOV
        Q=
X-Received: by 2002:a05:600c:268b:b0:394:13d6:c176 with SMTP id 11-20020a05600c268b00b0039413d6c176mr11124078wmt.184.1651505944667;
        Mon, 02 May 2022 08:39:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWSbJhAkXVVu+oVX5bF/r4ippsODeDHinPDW6sbIqFvmnW9SSlA9Sk7qtkg3/18TRsa7LmjA==
X-Received: by 2002:a05:600c:268b:b0:394:13d6:c176 with SMTP id 11-20020a05600c268b00b0039413d6c176mr11124061wmt.184.1651505944432;
        Mon, 02 May 2022 08:39:04 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v28-20020adfa1dc000000b0020c5253d923sm7294489wrv.111.2022.05.02.08.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 08:39:03 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 1/3] drm: Remove superfluous arg when calling to drm_fbdev_generic_setup()
Date:   Mon,  2 May 2022 17:38:58 +0200
Message-Id: <20220502153900.408522-2-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502153900.408522-1-javierm@redhat.com>
References: <20220502153900.408522-1-javierm@redhat.com>
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

