Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A16475004
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbhLOBBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:01:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43738 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238749AbhLOBBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hlwmMpDs7rI0oeMFDz50CNwBVV8B4o70fliBdr6Ssvs=;
        b=iy+nrBSv4iChvShmevO+nTzGj7sRdsYZgoIEBicK612UVntNfZEJQ/n3F+pZnKVHVFol7V
        PHD3yphwbT35pBhWH3ex7b4zeBxGehkszixTb+Dy2NBYH/zlFF5RrGx6dgRqwnhvCiclw2
        eI29dTMIcQ4v00M0wY1ddYoJl9V+tys=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-kfhPCWFvMnG0attEna81-Q-1; Tue, 14 Dec 2021 20:00:58 -0500
X-MC-Unique: kfhPCWFvMnG0attEna81-Q-1
Received: by mail-wm1-f72.google.com with SMTP id a85-20020a1c7f58000000b0033ddc0eacc8so13865832wmd.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:00:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hlwmMpDs7rI0oeMFDz50CNwBVV8B4o70fliBdr6Ssvs=;
        b=lQdGApnCy/6XOtfDHLTAp2wZEV/Ff2xXWyrFiSMVhZqw5qMfdmRVDfd316txBfvxFi
         FNC7j1UBS6Fc6LM5COYu4j5vJUVnSNM8yt0rXoW+YJ+wxl8x8hbh6LezwS7wHD8manSN
         tEk2loGFiVL7ZkoeTWqTzfSThJ0+V5ALxroY4/EsVu+PJL7amhwRhGXmXTjaE+uJlGkh
         dAIqrG6wteXVPZsn7TiwUtxLPUMwLOPS7DZ1Vaa27RXnaZ3ZUnOPXqS98c6Nm1ULQN+d
         eFkfgfg/SzTiqONbye5R/UwLTDH1DxeKLwpmWrf2UeQv2bE3HUGpj0Q9n8JwWMfxZTB+
         gnuQ==
X-Gm-Message-State: AOAM532ZmKFF9Dzzc1fTfTibm6FdOgdVVGS5VMtxX+nRYYR9oq4ZpA5R
        Bni8n0g336v1g1UCKI8ye/WqF2pUJni2AzAAKedoFcCy0o1enh/c1swx7gT341wtARaqENF8w3j
        2GggQr95cyN0zV6xG/O9PEUvNf00WqWj2caNFl1HTa3HRjnTcQ1cbSiOVj4fGXMVNymFBEEw4Tb
        o=
X-Received: by 2002:a1c:2:: with SMTP id 2mr2292573wma.41.1639530057613;
        Tue, 14 Dec 2021 17:00:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNXHTo+e2PB/eHuFET+/zbQRmAraTRzbs4BC9O1M1wtzs+H5k80hNY0ix6RAXDNXF/Bpcp6Q==
X-Received: by 2002:a1c:2:: with SMTP id 2mr2292557wma.41.1639530057411;
        Tue, 14 Dec 2021 17:00:57 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:00:57 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Alison Wang <alison.wang@nxp.com>,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 09/60] drm/fsl-dcu: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:17 +0100
Message-Id: <20211215010008.2545520-10-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211215010008.2545520-1-javierm@redhat.com>
References: <20211215010008.2545520-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to disable Documentation/admin-guide/kernel-parameters.txt, this
parameter can be used to disable kernel modesetting.

DRM drivers will not perform display-mode changes or accelerated rendering
and only the systewm system framebuffer will be available if it was set-up.

But only a few DRM drivers currently check for nomodeset, make this driver
to also support the command line parameter.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index 660fe573db96..9b9e1b200005 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -255,6 +255,9 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
 	int ret;
 	u8 div_ratio_shift = 0;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	fsl_dev = devm_kzalloc(dev, sizeof(*fsl_dev), GFP_KERNEL);
 	if (!fsl_dev)
 		return -ENOMEM;
-- 
2.33.1

