Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F18475003
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbhLOBBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:01:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20491 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238706AbhLOBBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pipp5Hk74a/1STom3UVKk7EFvp7D65TSNGTYUyjtDlk=;
        b=FrE1cCKd8q3E2Wb6pMopOdZ3CavJ/ff1jFr3uKKuPx20R8zxOH3znG45BBom6GJctTnMS3
        ZZz08Pt+h1zQn+6vF7Pw619wCBgA5H6i2kN13FA9FHkfdTRuIq8hnjIlvRWPOg50wy7Y4j
        eleNp220LdND7kL6fOrA2X2Dhv3fDIw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-ePYcTd_2M0WmaJSLTPPO5Q-1; Tue, 14 Dec 2021 20:00:59 -0500
X-MC-Unique: ePYcTd_2M0WmaJSLTPPO5Q-1
Received: by mail-wr1-f71.google.com with SMTP id v18-20020a5d5912000000b001815910d2c0so5392552wrd.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:00:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pipp5Hk74a/1STom3UVKk7EFvp7D65TSNGTYUyjtDlk=;
        b=mSksj83mnEnTwfXmZ9h9QAviqCPFQ2L5FRSN2f9hqZC5FBTsIS5/VeGDd3LdNyg77o
         lGmwL2Vqi4QL4SKUOCMNX5dBjO3tAcg11H+cJYXv1Lly3FBK6Ztu+azEwMjTcFobYfPa
         GEKSLwd12qaDO3l2Y1eN8r4T0euxx62QulteeUVmHuCeX4CskMWell7Mpf819RyaEnMG
         R7geilbxWdwPhhaU5WpmLVL4n+ez32u8PYiTWqM2g6b7Kwvwf196NUAXiC0a3zvnxmTS
         n8SZ9uZ/GnusgHjbd/3KeZ8h7uS5aeb6I4V6f+aDTghFUXLbM+XLuAVafr6YY39WIWhW
         mTWw==
X-Gm-Message-State: AOAM531MYL/rqDR7kUaYVAlwccUAtxDTGlh0yUzpyc3/sOrMiZqEXDHC
        Qv8aHes8Dn+Zce+55b+LLncN86dyaBTX4Tl2Cn3qM8TMDtiLmnNHFfH9/NpLbA86RIx1iIWBBQU
        aa3x93nU8SfvGNpdAGU+vgFzWJXtniv9FSS6d02jpmsyyy9Dfpo9XUqdrU319O3vUX6ynYMXaqa
        s=
X-Received: by 2002:adf:c5d1:: with SMTP id v17mr2040426wrg.571.1639530058357;
        Tue, 14 Dec 2021 17:00:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxc2FHtBXm7KY5VUL2eaL902we5JmBihfDLC7w8UAkYHKv6H+YkvJRKFmrkn5Za3LZ6R1tVlA==
X-Received: by 2002:adf:c5d1:: with SMTP id v17mr2040409wrg.571.1639530058134;
        Tue, 14 Dec 2021 17:00:58 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:00:57 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Subject: [PATCH 10/60] drm/gma500: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:18 +0100
Message-Id: <20211215010008.2545520-11-javierm@redhat.com>
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

