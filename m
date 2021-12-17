Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08916478199
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhLQAiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58498 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231252AbhLQAiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eWIZ87MUo0cEUhCnqBRUdqKqzQv0kebYslmFPB1YJWY=;
        b=HyfwtOvAYg4oWOmgqkmrBVcojdE0ih92hfk/9wC7ShIgD/zmEXJSLPH6Lnbse/y9J7gpzv
        B8+EC3RDXr2ZiT/5VIDIBw93nwxlgPEzn8vjJZf9a2pBXkKZLAt0FnatWf3nr5YR6vmOKu
        705oZuHnri7wgZfV/gA4PlxfccjdPA0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-C8IVTRX6M3KeLrND9ffrsw-1; Thu, 16 Dec 2021 19:38:22 -0500
X-MC-Unique: C8IVTRX6M3KeLrND9ffrsw-1
Received: by mail-wr1-f70.google.com with SMTP id s23-20020adf9797000000b001a24674f0f7so146301wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eWIZ87MUo0cEUhCnqBRUdqKqzQv0kebYslmFPB1YJWY=;
        b=lt+UfswB0WJTtrDPYjqJg1IRJmG1ySGhe4+t0YEFVQJ6w4gM8pbl6J798pqoL5KT6t
         P5vPfiV2X/K1MHB0fPMPr9hYSIsDoDE+wVLCIhZql4GxrYhfn4AYoyrnW4jchh2N4y4F
         61cf3jzlhxh1nJ8cVGahv3OupQTbS5PtEsLb+i7Zeoy8UywwpJzoMNNOHB6p6BTZ9muc
         Oj1/twc6pXS426IAFHGD5yYucQeNTHg5bcnFv7QSjDI3pV78Mx0wUtz6T3VgF0W21h0G
         m8L1/aCDsk7QSionfJYw3OFZGaegUGi0mErEwuyxx2G/YSDqhKZkre3+Yrk9NrBuQzaH
         w1Zg==
X-Gm-Message-State: AOAM533ytFgPb2uZDQNHK+Wef5n1FqgkEsl0hQMFLwFbZ+h3/xxkrVEm
        YaB0sj4afLs/7xcZKQRonv+vLqeRKwuSlZNY2HUeoHGHMunQoCStSL4QjdseizMMhpQvisNU7tR
        i72D8wpXu4Ak+/6IOjgiFVzYchibPucn5rEJ+/fidWGeZTy08cH3iOQmCuSMudAsfHtFEdURGW9
        A=
X-Received: by 2002:a5d:564f:: with SMTP id j15mr366096wrw.366.1639701501246;
        Thu, 16 Dec 2021 16:38:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzTFfvoBc9Gq2NFZc+CJBEfpNHVs8STFhbVw5McSXQJVdGwqdmltnAmye6C790hGSSWCdjm8A==
X-Received: by 2002:a5d:564f:: with SMTP id j15mr366078wrw.366.1639701500951;
        Thu, 16 Dec 2021 16:38:20 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:20 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Subject: [PATCH v2 23/37] drm/gma500: Add support for the nomodeset kernel parameter
Date:   Fri, 17 Dec 2021 01:37:38 +0100
Message-Id: <20211217003752.3946210-24-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217003752.3946210-1-javierm@redhat.com>
References: <20211217003752.3946210-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to disable Documentation/admin-guide/kernel-parameters.txt, this
parameter can be used to disable kernel modesetting.

DRM drivers will not perform display-mode changes or accelerated rendering
and only the system framebuffer will be available if it was set-up.

But only a few DRM drivers currently check for nomodeset, make this driver
to also support the command line parameter.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/gma500/psb_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 65cf1c79dd7c..eeb681be9c95 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -538,6 +538,9 @@ static struct pci_driver psb_pci_driver = {
 
 static int __init psb_init(void)
 {
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	return pci_register_driver(&psb_pci_driver);
 }
 
-- 
2.33.1

