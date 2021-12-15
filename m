Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4D647503B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbhLOBDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:03:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26478 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239108AbhLOBBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hzb21Riag0BzYvxQqZNndntEVa/HKVhBstIzR442xdc=;
        b=JsfMJ4okomgDk1T1FxMhiER3C1Rlwe8YiOe9ul6ceQcOe2/yBoiLnkrgAFRKl7vTo3aOae
        m2FZw/5vXADo8eLfuxJyJX9n4vm691cT+6xDnK3HjBUaOgJ2/0P1ttKakFeuqkmBfn9Ts4
        rYUALKxtnIOAvg7oNaFliym6W1ASOvQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-U_zjYUVYMBGATmwxTVpxJw-1; Tue, 14 Dec 2021 20:01:36 -0500
X-MC-Unique: U_zjYUVYMBGATmwxTVpxJw-1
Received: by mail-wm1-f71.google.com with SMTP id 144-20020a1c0496000000b003305ac0e03aso13858082wme.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hzb21Riag0BzYvxQqZNndntEVa/HKVhBstIzR442xdc=;
        b=2afkCY/DjTfU8+V4xpGTPxvfKxu5cVWVuq8T7boPWOZGYUk0GcKIXcSdcLewtxaE0n
         ZkZiqgxLsvWf/WKonGrQxdQ4l3Rq9gvRnh88ZIynH5osb5d8ZfYfDzAE+pqGk3ewLenx
         jSL5P24kNY3p404veA2xu7RScyjfmzA+THgy22PCMX9jYy+PF7YD/ZuLnYyIiKC6fxTh
         vVdBmAXtko6DkcDwze0x/Y18PrFeZg5KVUv++FFNc5KeTXi5YNBVYf6r+XvtFZzOqDOO
         ebbXXiJfenAU3tk0WB1nC/fv6QFh1qgmSjHWntBK73eTV9RCAwBbaulMen3120eWCBVl
         w03w==
X-Gm-Message-State: AOAM532RWOu+WLMlH5zy65PTtWqgN24JvtBzZX87Uxvlwxrxg3SvmFIB
        8EPRKDYkAOcPFqghkQeXiOwzQbjSSF0YKxWbou9hlgUk0CjeXW82LjQgNA2AUK2DoKomfW74GA1
        RSvRjBxKlGIhKyIgsFXFZ+KuNe2l7YAln6aZJ86hfOog41VLamApnoIUtN2p3lt3DUZ/ZP86ekZ
        o=
X-Received: by 2002:a5d:4c87:: with SMTP id z7mr2232321wrs.108.1639530095094;
        Tue, 14 Dec 2021 17:01:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwv/GbbCBx5XytBBwaLIiM9pzKWYQkrTmgkllinTV4/CSY0c7oGPrWn945cRBUw5QxDc9nqdg==
X-Received: by 2002:a5d:4c87:: with SMTP id z7mr2232311wrs.108.1639530094912;
        Tue, 14 Dec 2021 17:01:34 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:34 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH 52/60] drm/mi0283qt: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 02:00:00 +0100
Message-Id: <20211215010008.2545520-53-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211215010008.2545520-1-javierm@redhat.com>
References: <20211215010008.2545520-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

 drivers/gpu/drm/tiny/mi0283qt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/tiny/mi0283qt.c b/drivers/gpu/drm/tiny/mi0283qt.c
index 023de49e7a8e..f96fd350d373 100644
--- a/drivers/gpu/drm/tiny/mi0283qt.c
+++ b/drivers/gpu/drm/tiny/mi0283qt.c
@@ -186,6 +186,9 @@ static int mi0283qt_probe(struct spi_device *spi)
 	u32 rotation = 0;
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	dbidev = devm_drm_dev_alloc(dev, &mi0283qt_driver,
 				    struct mipi_dbi_dev, drm);
 	if (IS_ERR(dbidev))
-- 
2.33.1

