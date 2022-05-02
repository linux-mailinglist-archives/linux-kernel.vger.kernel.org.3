Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B637516C7B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383916AbiEBIwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383868AbiEBIwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A26B3522E0
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 01:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651481351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nUb3Cdutv1MKxDV6ingzdmF5ZaYeX01o1Hla2Evf+TU=;
        b=CNfxZZGAxdtvqisxQw5GNnTcUT2KpMoaAmUCEHFDAtFP6gcXUX3i0WZahOKDz4XG22EbO3
        5w2vFQglca1EECIL03hyjO1J96CYhZhKobnW5ccC3fZOVt337ahzS1hUMoLKnW9BUccQ78
        N7F18Nr4M28r52eOthnDgruTvr7oKPw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-TVvo94TxNE2EnYgXswS95Q-1; Mon, 02 May 2022 04:49:03 -0400
X-MC-Unique: TVvo94TxNE2EnYgXswS95Q-1
Received: by mail-wm1-f70.google.com with SMTP id d6-20020a05600c34c600b0039296a2ac7cso4313122wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 01:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nUb3Cdutv1MKxDV6ingzdmF5ZaYeX01o1Hla2Evf+TU=;
        b=ViHZBaGbjcQ6m87k+eaLZLMZKf5lyA6FNV7It122QTGGnjPwTfjS8Ki+eUTrjYIeoe
         35WoEs+79nCO21HSCl81aCFuH+zfDw4MrUBkB6EiiyFFyM3sM0jfUDo8STepiGTZsEdL
         vCbi0pLhm0vngBHUWS/1/253fdoMNJVJdCAl7wOnI1lXDb0l67M0wet45Hlmtn/qJGHa
         /4MgoR5iu6Mv29cThaRHe4riF+oGukzXH5omrtHaD1JmeygPTzFskABbBmcTjaflaaLI
         7YndTUlQKuuWBnoVOBiSA+YHM24nHk9Bzy4qx3a/01VNHwiPp7kX3GMv01Qxxv58HIw2
         PG+w==
X-Gm-Message-State: AOAM532w8fnJo1E9eX7A3Zp64i+UBxAdpCmrSffyNKhAkjvBcWEHWurm
        5tL2fhvIRqYVdGZBHwLa+3Tacd7RDJlCE0TV7I/xVhAY878Ywq82KK3Yy6Zf01UcraJourZGZnK
        /6+2x8revSOaKbNAvwklAAkOj8eLU0iRsJlTbeHotPlMZftHmVHSBaNe0PhlBRhmP+3ope40UpN
        o=
X-Received: by 2002:adf:f481:0:b0:205:b814:887b with SMTP id l1-20020adff481000000b00205b814887bmr8534248wro.472.1651481341995;
        Mon, 02 May 2022 01:49:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAXHYxvLbyws8GB/tbUJd38HBu5iob+xH8VrObZKgF2/b4LPU+2ChH0C1K1Jw1h4dwPv9ZCA==
X-Received: by 2002:adf:f481:0:b0:205:b814:887b with SMTP id l1-20020adff481000000b00205b814887bmr8534221wro.472.1651481341758;
        Mon, 02 May 2022 01:49:01 -0700 (PDT)
Received: from minerva.. ([90.167.94.74])
        by smtp.gmail.com with ESMTPSA id i14-20020adfa50e000000b0020c5253d8c6sm8032307wrb.18.2022.05.02.01.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 01:49:01 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Nirmoy Das <nirmoy.das@amd.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 1/3] drm: Remove superfluous arg when calling to drm_fbdev_generic_setup()
Date:   Mon,  2 May 2022 10:48:28 +0200
Message-Id: <20220502084830.285639-2-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502084830.285639-1-javierm@redhat.com>
References: <20220502084830.285639-1-javierm@redhat.com>
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
---

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

