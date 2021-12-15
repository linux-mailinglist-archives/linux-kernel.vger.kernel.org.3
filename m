Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F3B47500C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238862AbhLOBBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:01:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238736AbhLOBBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=buQa/q4lH2BtifIaLjaqC/HHZXhIkn7s/entEE4V0Lw=;
        b=J7n1asnOPqymgO33KfUTUEaWOM5ovAUZjTQsApb6gQ6MDVaLjdA7Q/GZKZjSTm5QpFo3cy
        LMaFUOnqRQ0CgL4uWNBtshw3x63c25rrvE5aE233HNQ3Oquuof2iKVfBQTlrSIsSfc+zB2
        h8IcTyNQ7P6Sq9pYEEoz9/nXhfv0vJk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-RqU4it2XNP-7R6Hav2MV6w-1; Tue, 14 Dec 2021 20:01:06 -0500
X-MC-Unique: RqU4it2XNP-7R6Hav2MV6w-1
Received: by mail-wr1-f71.google.com with SMTP id q7-20020adff507000000b0017d160d35a8so5377950wro.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=buQa/q4lH2BtifIaLjaqC/HHZXhIkn7s/entEE4V0Lw=;
        b=kWKydWYQ85TycPuuS1cA+eIY/bvG/2RvuCuZZiQCm9rMip4YR49Oty7xeDLkEZF579
         jx3TxBQdAb9osxSBz/HKA/xLxeCdp/yaKmduGUNkAn3vvaEY8iopDw2BRxTOASVA9BdN
         FQ6ucxXCWRxv4VmPIhDjWjd1W63ODq1yGGHrHyXrAQnEmK7JCDymmuwa0Ju1M0LRDIjq
         ZV/snggLpLWAVPsSmtFC+UfhXoVfHvPgQ9MaKvNE3E4Sd5HLAfrfxbthuqi4GeW0VkSJ
         Tl7dO0g1uq24bVcCZMYyAcgdXAWmdGJYmJo1n2S0TE20+yWBeUtiD3RBT2ToQ2SA13PO
         Ep8g==
X-Gm-Message-State: AOAM530dO3Hg0TdoRpPX0ZfQmOwF0NsJCZz0S2ujIwmGaIkD1dpLszeX
        Y0KzqSOUXnygIaEfXF7o5HvBDc7tuUi3GLwB8UcNIikWHi0vXJrp025b+u/i4OD4viVup5UkZDI
        MpeVNApgC0IeLS4RDqmPKcZLG9c8YCooHXZrYWD8Sj2lj9umxJ9w9Rf4J12gkXae0NnUdq5t4H/
        Q=
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr2197912wrd.114.1639530065683;
        Tue, 14 Dec 2021 17:01:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjnCCBCYToqRjdRNxAmerjAQhtI/o7UoTXtHCb9XWsRZ8oOku/Gp1bPO/ee31R4W2GQgac+A==
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr2197894wrd.114.1639530065497;
        Tue, 14 Dec 2021 17:01:05 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:05 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 18/60] drm/ingenic: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:26 +0100
Message-Id: <20211215010008.2545520-19-javierm@redhat.com>
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

 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index b4943a56be09..8748cc5d2069 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -1487,6 +1487,9 @@ static int ingenic_drm_init(void)
 {
 	int err;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	if (IS_ENABLED(CONFIG_DRM_INGENIC_IPU)) {
 		err = platform_driver_register(ingenic_ipu_driver_ptr);
 		if (err)
-- 
2.33.1

