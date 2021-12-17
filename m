Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166C747817E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhLQAi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34907 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231207AbhLQAiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CH/yLDN3aiuSoANBKfiRVu9bkbDIfJXNva4DO0r+zh8=;
        b=hSHnyPj3Ktje9nUahcYueE4/r+UpQK1UC7IAlTLicRYYjrKPLZFWB6HY3EEPuDJD4GF7GO
        sPs7zcDcdrGCrohBWumHOAeJMaLSBeLBa5S0EFDRNSr2tT9icipeunXWS2w1pyxR/fxKtM
        E8MR96CDVsGW7Dg61GGGkPg4TU1SeGE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-VWVCbU9aOMKei_8KAa2P3Q-1; Thu, 16 Dec 2021 19:38:11 -0500
X-MC-Unique: VWVCbU9aOMKei_8KAa2P3Q-1
Received: by mail-wr1-f69.google.com with SMTP id x20-20020adfbb54000000b001a0d044e20fso145305wrg.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CH/yLDN3aiuSoANBKfiRVu9bkbDIfJXNva4DO0r+zh8=;
        b=45omnHEYFhR0GX3G5oZBGr8gkjRs3D5q1y/6PpmouXVhC9mnVw/d3W3zUEhOIID6DB
         NeljZWKFpD9NfvVXNkqgc+FhM3JZluSH2oOyEKuJtLLecloDKCtDkOY2K71yAOtKIEtL
         O5eOEFhKIWs/HIrlBtHZ/rFMc8jXO5XRBfkvvO1PMFzr7Nxa/w0KaBueBBPUkibraOiW
         W3wzymUYXgwpFAjQXY87gIrrNQeSEG4zhM0qelV+UUx1YAVPE/Na4n4ASc7eQyim3+E1
         5c4RuP6gYSHfgLP8TRxLgEfuxCdlb0K89Y7D+rKIPVqK8Uwf+tO9DPQWRnlJ8tqeqign
         kdIw==
X-Gm-Message-State: AOAM531+WEYQMAaXCzaS82Jvlw3w5/NMBF19xpn8UWzosaN2lz585zAz
        OMSQiIMv1MsZY1TfbES1xTXPoLmPPj+oEpa39KxOehVLGsUFKRtlhjK8aVNpAU/LSp2u9blm7xZ
        NP/K3HyqqR6KM0C58FEVfU/274DNoHV3J4+uq6bn4kn3lsn8lfPd9ftMOdEokqShcXNGz+yvWmd
        o=
X-Received: by 2002:adf:e482:: with SMTP id i2mr403192wrm.284.1639701490485;
        Thu, 16 Dec 2021 16:38:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzYwZOIGG0CxZbG8jz1k7y09aVqYCd8qTtTPMvByStDzhdRk6KnTXyYvLLH536sDgjoNdiQ5A==
X-Received: by 2002:adf:e482:: with SMTP id i2mr403176wrm.284.1639701490222;
        Thu, 16 Dec 2021 16:38:10 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:09 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 12/37] drm/meson: Use drm_module_platform_driver() to register the driver
Date:   Fri, 17 Dec 2021 01:37:27 +0100
Message-Id: <20211217003752.3946210-13-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217003752.3946210-1-javierm@redhat.com>
References: <20211217003752.3946210-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro calls to a DRM specific platform driver init handler that checks
whether the driver is allowed to be registered or not.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/meson/meson_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 80f1d439841a..36a107e9bafa 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -541,7 +541,7 @@ static struct platform_driver meson_drm_platform_driver = {
 	},
 };
 
-module_platform_driver(meson_drm_platform_driver);
+drm_module_platform_driver(meson_drm_platform_driver);
 
 MODULE_AUTHOR("Jasper St. Pierre <jstpierre@mecheye.net>");
 MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
-- 
2.33.1

