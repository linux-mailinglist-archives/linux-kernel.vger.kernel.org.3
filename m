Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4C1474FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238745AbhLOBA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:00:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34106 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238722AbhLOBAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g+pg6gkvVTg/jCDYXqfj7uILQP1iaPO5/VLqlopAnEk=;
        b=JjKmHc2LKzhBx4K/zPZ8bdf/ySl47chRngQYeuBZ/tpTsVTW2CsMvq3i0fCpgG1MUL59Kf
        s6rzicFbtSQ43vjnr6vzg3TXguCwDhmpWxRLBtxm7d4SHJkY5TZzOo/5B4T2rs9/0cnoWd
        9O42uvKJsREf2disIG9E3NMZyEJ0KKc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-mgB3IV9aNpWRY8lHJSzq6Q-1; Tue, 14 Dec 2021 20:00:53 -0500
X-MC-Unique: mgB3IV9aNpWRY8lHJSzq6Q-1
Received: by mail-wr1-f72.google.com with SMTP id q17-20020adfcd91000000b0017bcb12ad4fso5374656wrj.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:00:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g+pg6gkvVTg/jCDYXqfj7uILQP1iaPO5/VLqlopAnEk=;
        b=rYHeoBZAVfkfdrVvt04PsnmPtde4QYOjRloAoDsQvAqcRA2rlj+1Deto35ntWG0xBt
         69hf6bHOyqNkmGYlkgZN1m9xvKvVzTnDLYHEmrgBawMW8gidaoJSB/y9JHqsS1O+HTSm
         oB0GTU8sMM51y1bNy6ZZXPZLn24de9yPfsrutq1gc5YJQFr6zXxVxtmRk9+fYtTfxJuy
         sJTwVJqyFUAFo7UlULB0+UJty02ZNtVCGPSAoJzHHfrnglSKoCjDlvIlIHJ8M4uaer4d
         BaPJlsFPYmx/gisMKpcORUtQyCbxWl0gnXxdhM1XkwiEG2kzfuviWb5XVxcB9DcRzem5
         RL9g==
X-Gm-Message-State: AOAM5325CJ1wPE5gUa1tGu/oCybTXaO+tjaIP/voRDzw6HHNby+SXSJT
        TxUhLWYZVHgD5JcoSVCcfpvVIk+k3fpf9oven48VCz9ME2pNvAnzTMofURLGT/ggFemSrb4ZiAn
        hrfDvljX8t5ztKHqgfCcoPlL1YD6g6XfPY7HMGrrEjwmtXq/E1ly/9vqep8MGPtypd3SgpIppD2
        M=
X-Received: by 2002:adf:d1c1:: with SMTP id b1mr2135494wrd.296.1639530051704;
        Tue, 14 Dec 2021 17:00:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxa9ZR3JBVySwgyk50lbQenu9lQKPho5TOnp36sCmx/rNFAlgMq2f5DxCJIrOkA3pY24zdg9g==
X-Received: by 2002:adf:d1c1:: with SMTP id b1mr2135481wrd.296.1639530051453;
        Tue, 14 Dec 2021 17:00:51 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:00:51 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH 02/60] drm/arm/hdlcd: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:10 +0100
Message-Id: <20211215010008.2545520-3-javierm@redhat.com>
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

 drivers/gpu/drm/arm/hdlcd_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 479c2422a2e0..0939a64a9bd2 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -382,6 +382,9 @@ static int hdlcd_probe(struct platform_device *pdev)
 	struct device_node *port;
 	struct component_match *match = NULL;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	/* there is only one output port inside each device, find it */
 	port = of_graph_get_remote_node(pdev->dev.of_node, 0, 0);
 	if (!port)
-- 
2.33.1

