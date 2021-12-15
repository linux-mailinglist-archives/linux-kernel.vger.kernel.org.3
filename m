Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045E147501A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239032AbhLOBCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:02:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238771AbhLOBBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QlDMfQhcV7AZSs8IvwxBHAeCaGQ4pJFItbhLR/NMUvk=;
        b=Ug9qfCvXNH70+tyPGYXGFkq9mdozRFuNoL3gf2l20m7dvRxBrKL2dyU788bQbb7PjMXUb5
        NI+Idt9LUFN6GAgC5FdOCe3WYTmIBf3AWCsZfu6tqChAUxPM0H6RIg4WzpV9MUy8pTnkcx
        rLIEeuQThU4kO9TD41BcaeafAkypmYE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-ZpdJl33SOn-XMzyQn6aHJg-1; Tue, 14 Dec 2021 20:01:12 -0500
X-MC-Unique: ZpdJl33SOn-XMzyQn6aHJg-1
Received: by mail-wr1-f70.google.com with SMTP id o4-20020adfca04000000b0018f07ad171aso5388228wrh.20
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QlDMfQhcV7AZSs8IvwxBHAeCaGQ4pJFItbhLR/NMUvk=;
        b=mj+KvtfTROJEs/TNMiJrKdKeEMh0op8qI6kXVGrlg6rfgqnEtImyiCtp1i9y5cPM1l
         etCfG3JWi1iFJ4oOW9d5ehsPCoYGfRwWuCtNqejzUFAMeOd7W9qOoQNup6Yt3uAVfg19
         ELRRbJL48dJ8FbwdKgDV7kPH1vcn732g4hRF7bN9nlqWvN6vviZcr+RaVPcSQH8QAFqz
         2idGbV3KMtkSmrxRCJ2t9Msc8GM9PrOT2I94OwUfJh+uSYSjtJL9X6py2ya8hjXdjsEZ
         RWr9uTc/OLM18dWG35YHDYU93mzzl8DFQ5OAb/t8bI6nS8FKrIXeL4w7PbW8cjmC4Bit
         ikWA==
X-Gm-Message-State: AOAM530Mid1nv0B+frc+y7+OOBUwh6clD9qSzJD0r3kvGD2d7sKlwZph
        mCXHacuSG/5cCK95/ooMg9udGHT2SqVDC2lXxUU1bTuzWLkqe4k9HjtT7vVcXeTRiXLD+16SfLI
        C0+9z8OmDLHVh8J7AwOyyKsp35onGFOHWSMhn5+jLjoGe82d+2Q5ZFdkh3ZuizBv79VhirnQMHR
        U=
X-Received: by 2002:a5d:4883:: with SMTP id g3mr2181230wrq.590.1639530070985;
        Tue, 14 Dec 2021 17:01:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzqBTmUVUxMpnj2vnusf3lwGrdrHWm0F0q/QNuFSPpSWq/aWByz7IaWGYOGpolNWIglB7ngdA==
X-Received: by 2002:a5d:4883:: with SMTP id g3mr2181210wrq.590.1639530070724;
        Tue, 14 Dec 2021 17:01:10 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:10 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 24/60] drm/mga: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:32 +0100
Message-Id: <20211215010008.2545520-25-javierm@redhat.com>
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

 drivers/gpu/drm/mga/mga_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/mga/mga_drv.c b/drivers/gpu/drm/mga/mga_drv.c
index 71128e6f6ae9..dc4154d39133 100644
--- a/drivers/gpu/drm/mga/mga_drv.c
+++ b/drivers/gpu/drm/mga/mga_drv.c
@@ -87,6 +87,9 @@ static struct pci_driver mga_pci_driver = {
 
 static int __init mga_init(void)
 {
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	driver.num_ioctls = mga_max_ioctl;
 	return drm_legacy_pci_init(&driver, &mga_pci_driver);
 }
-- 
2.33.1

