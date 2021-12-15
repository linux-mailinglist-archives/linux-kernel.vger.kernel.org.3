Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D2B47501B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbhLOBCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:02:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47101 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238832AbhLOBBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cH57dCYc7qQEnW1RZcjru/jBz/1ABWEV4ceGTOsTwqE=;
        b=Ykwco+T53N11EAztuIy99GGe9lm9H5OecBjcWQhmahN/AyZ4BlKUMvELZdN3VbWI8i+mbn
        HlxaiXemFDwlWv4d31ma/40UilL/Tv23WLP64oFr/T5mho+lR2n9s/KPCpDrRWE9jITBfk
        QBP5Ds9S0AMROpIdjuOR7fEQrV9/O0c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-pZuUWqUwPXmvQB3QAY7OsQ-1; Tue, 14 Dec 2021 20:01:11 -0500
X-MC-Unique: pZuUWqUwPXmvQB3QAY7OsQ-1
Received: by mail-wr1-f71.google.com with SMTP id x20-20020adfbb54000000b001a0d044e20fso1099054wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cH57dCYc7qQEnW1RZcjru/jBz/1ABWEV4ceGTOsTwqE=;
        b=ZgSRF8jkbgYEpvG1ZbDRioyFRbws6RPm9mcj89V3IEsNNVuBszHEGrCOYZPa5PjMJG
         D6G2N+vl1ODqITQofegg84bP34t/jq4b3arZ6UFSMFqwyCrPLH8UNnB/gmdVaKEZ/9I9
         E6MrFOiR0hdBXUcbyAh4SAwIAblduyGSKo3NgAmVkXBp7+uXx+HmrnFL7rskrIXE37ak
         IJlcUUdCphrD8U/89SlRq3pdGz4Xw6IyehPeR6HILxJrlZXR7uIb6v/8u9/gYXsBeGJ4
         d3FC/sdkn07s85LATLnYnQZMAtz+t+LPh68oON88vk4hvTNL1A0Iiv8AbliOSDKRI6cI
         mb2w==
X-Gm-Message-State: AOAM532pJPZD8LblS6Hft+vQgpD+CTInGCnjzKb7MqttG3tM8rHLo1L+
        UhBtrE5ifDtfMVd5rmVIcLRQG3J6TgDav/W1aY3TUWY9sYynyvVnSEuh72z121RTyzvBP4a0Bdo
        2WajFgzpX7c8WXHtROPScMgXxEXmX9K+lg5Ajq8b6Pfb1+jb7vvrK6aRM6BQ/ARXpz81zSXv5ct
        A=
X-Received: by 2002:a5d:5008:: with SMTP id e8mr2129682wrt.594.1639530070201;
        Tue, 14 Dec 2021 17:01:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzblwOb0jm3iBz8Eq90b8slpp6L3JOM2UhdyTKTr+bC0gBD3KlyxYsVH2bV1jQdyWO4JjPNqg==
X-Received: by 2002:a5d:5008:: with SMTP id e8mr2129662wrt.594.1639530069890;
        Tue, 14 Dec 2021 17:01:09 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:09 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 23/60] drm/meson: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:31 +0100
Message-Id: <20211215010008.2545520-24-javierm@redhat.com>
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

 drivers/gpu/drm/meson/meson_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 80f1d439841a..719724ad3c5b 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -456,6 +456,9 @@ static int meson_drv_probe(struct platform_device *pdev)
 	struct device_node *ep, *remote;
 	int count = 0;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	for_each_endpoint_of_node(np, ep) {
 		remote = of_graph_get_remote_port_parent(ep);
 		if (!remote || !of_device_is_available(remote)) {
-- 
2.33.1

