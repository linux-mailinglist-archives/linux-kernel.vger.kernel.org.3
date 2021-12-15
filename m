Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D07B475028
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238916AbhLOBDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:03:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56989 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238786AbhLOBBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oC0WIoOQuniwzJjXALje/d+9j4IKW4teFV70BFaXDnI=;
        b=N9Tjk2LSV7okrLpM7FYYBl/V/KhiaWu+WcMLhYjXZefeb7J3Nntgs0zL+aHR9cJBqK5Slv
        cgkrsody/WXangMF2oh5BHmgVmlYXRzasngvLcIA/z0QL60kTnzIFCJLyko3DTfgtJqSP7
        3GhxU38aa/PTkVl/aEc1McHaqWV4QbE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-UQbhiaIDPBiFpWwf3yFONA-1; Tue, 14 Dec 2021 20:01:31 -0500
X-MC-Unique: UQbhiaIDPBiFpWwf3yFONA-1
Received: by mail-wm1-f72.google.com with SMTP id l34-20020a05600c1d2200b00344d34754e4so1155127wms.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oC0WIoOQuniwzJjXALje/d+9j4IKW4teFV70BFaXDnI=;
        b=dW3vNre2vcWGXgp4hqyaVqdjro2YfFhaluO5Oc6ks7a0eaubt1REU5FlS/OYvxqcwz
         X52b95jfbkXs0b/zCLlQiflWFazETRyRWREf6ChrWHCS6W+9QO5qijF7jbKW1a5FFepu
         7c0/fsf1OqAT/65mfP9FXPkP6IBmsG7iPAKg/niUGMKhhGD3YUVu3ImxLHWkzWY+An/G
         s+Awi9thX/6DkEuMppZF5AFyrs1bgi5uktvaZMbr8za9IX56ZZmqLC8aZPcqk8U38wZk
         G2D5MHP2pSmMpGlKQdVmTpClv0Ed/ld1vDVDk593Ytg1Sty0nlVeqZ+WuQPKboHYYCsN
         E6fg==
X-Gm-Message-State: AOAM531UvDutBLdSchgkZemUsUSvA/YpoxruoSDv5kOS+896YRImg+WQ
        iAIwgshHq4vqzvalaWmrQPwWiJWJ5mwr+qj6d6lX/gD+0tIr/0V1/sKrCJMCuqa1yD/88mkqSie
        7GPVbUf3aHODGYtHa6PCzDwCYIE3XdzK7/NR7KmnGVU+x+LEeguuB+m4P5cTXQ6WeuMB0vcHtV5
        Y=
X-Received: by 2002:adf:9cc2:: with SMTP id h2mr2116492wre.464.1639530090339;
        Tue, 14 Dec 2021 17:01:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6DCqgPThKnpIur5x6pebNj3fJU1IgKA5z5+Ijpw8mGj+VILk3gMjJquokMJ4EX/I+MKH3vg==
X-Received: by 2002:adf:9cc2:: with SMTP id h2mr2116484wre.464.1639530090148;
        Tue, 14 Dec 2021 17:01:30 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:29 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 46/60] drm/gm12u320: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:54 +0100
Message-Id: <20211215010008.2545520-47-javierm@redhat.com>
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

 drivers/gpu/drm/tiny/gm12u320.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
index 6bc0c298739c..b9a5f4969337 100644
--- a/drivers/gpu/drm/tiny/gm12u320.c
+++ b/drivers/gpu/drm/tiny/gm12u320.c
@@ -636,6 +636,9 @@ static int gm12u320_usb_probe(struct usb_interface *interface,
 	struct drm_device *dev;
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	/*
 	 * The gm12u320 presents itself to the system as 2 usb mass-storage
 	 * interfaces, we only care about / need the first one.
-- 
2.33.1

