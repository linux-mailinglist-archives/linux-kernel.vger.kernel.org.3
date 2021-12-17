Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFB9478174
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhLQAiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51680 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231150AbhLQAiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/41J8DAM1gdd3WP+PUnIuvtC1QrJS0LZN5dpagEG/EU=;
        b=AJ3S4EhdohlXR/YVHQ6iRmS7KuxXfDpSNWRJGbrssw1OFQb5RsuA2vKoHuWCqiH0wZwLu3
        8uGF287WUld+O0mN7kAY+0qbKojFDGGkep59iYSsS0rNiDn33zbm92b1Kjze/dixVWp9Kt
        zJj/Eghhhxx8zjX0g+7Wt+st4Jv2FBM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-cFE2eZhbNYCkn4_ORDkjig-1; Thu, 16 Dec 2021 19:38:06 -0500
X-MC-Unique: cFE2eZhbNYCkn4_ORDkjig-1
Received: by mail-wr1-f70.google.com with SMTP id y4-20020adfd084000000b00186b16950f3so142864wrh.14
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/41J8DAM1gdd3WP+PUnIuvtC1QrJS0LZN5dpagEG/EU=;
        b=4MScvffrFrpZX+hM5rByudfUckHlyOEEHYdRPXXHBnkepWRC0ol/z6TK6yhcBvPEzg
         A/B8Ab7ExktymUlC+FstSP3fX0hyGejSfmdC0FkepCXNA+gewU4tLZRjJ72rrbtr/ELI
         ghihnVNeWN7B6kGcTDNx4nrPHCWZqVMsq9Paa/8qe0Pa8A4zCN4ULTWLOW+o6A/1uUiL
         +tDADfCrhDEokKRrrduj9AHbOJg3IublsIbvhzGs3426XH92ZLWK6mwIv22rmrw5Ri+3
         mIwsWgWPZwUuW17JHacy2huCeWJyF2kY6JRRhV+MrfauEkiOmod5Rz2PTLhQSs8sQnxB
         cm1g==
X-Gm-Message-State: AOAM5325IxPHWm7c1YHEOzneMKH5QWL36n3VdAGCcM6i19DPgbcks/bz
        ozxe/TRZhCbLDSlwktStdTEUbEPUKWQRk010hBFpaefAiSfIeweLesL/Ak0VQTVxyjwBoI8H/Hh
        Kr2Vp8kc2nqlLI76Y0MYHOq0P6a6h/DtO8tQGehvEoVV4dydj1/97/Gz+Lb4wZjlUgpIRDBHUFc
        w=
X-Received: by 2002:adf:cf05:: with SMTP id o5mr362393wrj.325.1639701485570;
        Thu, 16 Dec 2021 16:38:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwjZVTrbXpQQ+uX2glLN271I37ZMYitMAf7//HnyLzVu2ZhFdMQrRZkMmi8So3CiwT6jRlLCg==
X-Received: by 2002:adf:cf05:: with SMTP id o5mr362380wrj.325.1639701485328;
        Thu, 16 Dec 2021 16:38:05 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:04 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v2 07/37] drm/atmel-hlcdc: Use drm_module_platform_driver() to register the driver
Date:   Fri, 17 Dec 2021 01:37:22 +0100
Message-Id: <20211217003752.3946210-8-javierm@redhat.com>
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

 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index 1656d27b78b6..3c01ede792bb 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -833,7 +833,7 @@ static struct platform_driver atmel_hlcdc_dc_platform_driver = {
 		.of_match_table = atmel_hlcdc_dc_of_match,
 	},
 };
-module_platform_driver(atmel_hlcdc_dc_platform_driver);
+drm_module_platform_driver(atmel_hlcdc_dc_platform_driver);
 
 MODULE_AUTHOR("Jean-Jacques Hiblot <jjhiblot@traphandler.com>");
 MODULE_AUTHOR("Boris Brezillon <boris.brezillon@free-electrons.com>");
-- 
2.33.1

