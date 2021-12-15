Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C45474FFD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbhLOBBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:01:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34162 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238736AbhLOBA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ta/BJOrkWopySKAnFVtxGY/BWy3a5d+p8/Y0sx9Nc9s=;
        b=ClozrupQyQtfZkt6tcaTDgk0tKCN4dPJTRt2VT2DAvPtwnDGqO13aILvLgyhN2guVsSvLZ
        c83OKX3eGic57DepAUcB8RiqU1a5rGdB0SEnQ/jsKQGThZhtDCS4pctN1Ok/F+7BzzppyF
        aMfasnjN6NyMbomsE7sUylfur2xedqQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-600-0Q0wU_VOMoW7-p_H-Y9HGw-1; Tue, 14 Dec 2021 20:00:54 -0500
X-MC-Unique: 0Q0wU_VOMoW7-p_H-Y9HGw-1
Received: by mail-wm1-f70.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso13871929wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:00:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ta/BJOrkWopySKAnFVtxGY/BWy3a5d+p8/Y0sx9Nc9s=;
        b=D7DhHYPi5d5YKTl+cAx7VXAy6YHKEH+aHmYCvBjsyx4S0eIUok50JODVXNtHXXCi+2
         cJ0QoJdGOf7VjhSW50HJstiMjkQvL8dSQ9UOu866aJDOPThyR6EOjf3XIzzosJYNG21Y
         RNh2r1cGGxRITgCyDWNg+26XOlLa/hjLVL71Da33mu9eaJ1VVgvc3qD5c6OSkA6HTTTS
         w5vE5Sfp2BWCNN5b5MzJ7/AdhJE1qEfLICyk7LwSo8kK6m6DLaYsl4UxjGe36781JnrD
         OIY8LS6mIufPik3VYU9aBmIbeZQKAFenFH7t1Op0ZFAP78P+Q+loO12F3BeTFTWQDhqA
         cXpg==
X-Gm-Message-State: AOAM533JmpuK2kLg2HAhfscwEg790RQcdBSVNYXkWo3cLWyHMfSX5CeB
        R/0I9ianD4zHoMZIVV9WBC7QBTrD5Zb01N9C3yfMcyzaX4+kdtiKLBPltnp3eB3cZsmxucMfMM0
        4BicOfaBqJJ3ldjrOkt7btsDbSwGM2KQ9DHfB/dW4F23c89knh79x/eXYL5XWWxOokkrhYS4Xa+
        E=
X-Received: by 2002:a5d:4b8a:: with SMTP id b10mr2080133wrt.413.1639530053316;
        Tue, 14 Dec 2021 17:00:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwsLRMjBE0wc5ZwF8ARaHlVSv0EqCsQANIP5PykNXkYwInd75dCCI3LsyC5MKdbqvLnMvVoqQ==
X-Received: by 2002:a5d:4b8a:: with SMTP id b10mr2080118wrt.413.1639530053088;
        Tue, 14 Dec 2021 17:00:53 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:00:52 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 04/60] drm/armada: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:12 +0100
Message-Id: <20211215010008.2545520-5-javierm@redhat.com>
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

 drivers/gpu/drm/armada/armada_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index 8e3e98f13db4..4f9b0a9f13e3 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -273,6 +273,9 @@ static int __init armada_drm_init(void)
 {
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	ret = platform_driver_register(&armada_lcd_platform_driver);
 	if (ret)
 		return ret;
-- 
2.33.1

