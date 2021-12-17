Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F580478195
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhLQAir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21272 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231225AbhLQAiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C8Q6E31CvRdgFQjI6r+opNRluhu+1AsXEHVhyYbhi9U=;
        b=IcPn+dGeCRLq1kjPhBXaYqVcTjo754i5GyHUxWj0c5jc+kadq3fIYnSrtBdSpX4YjdTXFD
        8Rh1NmhsZzKa1Z3BiTEJe0ag+D9vV45hIE/ansfscrOZwvyjNoc97LgPScNiEXRIvEWSVF
        RDGCsUE4IFAGwS84//lg9HJ10TPvheQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-z831v5HBPxW7eGP0zGG9mw-1; Thu, 16 Dec 2021 19:38:14 -0500
X-MC-Unique: z831v5HBPxW7eGP0zGG9mw-1
Received: by mail-wr1-f71.google.com with SMTP id v15-20020adf8b4f000000b001a24c46d6ceso143686wra.15
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C8Q6E31CvRdgFQjI6r+opNRluhu+1AsXEHVhyYbhi9U=;
        b=J0YqDRFnXnREGfibRolWLKW4mHjHTmqvuIahMFZal5IOG8ZnzBUubvBlAPlmkm7Y5y
         6B7KQfvAQzXDMqGRAUAsiEUAQzBtEj5w45Ogj5FxO5t9zpo6D6tpGFVyO6MqgY8yTqnP
         r/EGmfE7gaMZQa5024R2p41BA5u0g9LkUlsdeLgDqbji2EFA8KUiyJyvdP9tIZWdvYzb
         GjD7rpbz5on9Wo7BqTLuKjJ35DOGs2H1B/AMaadSTz0WLUCoaYZSQ/TtPusfysVOi6gQ
         497diQenDIUHVbfHask9NFyRGR43ixmkaoSdbpfOL9HSkvWJpxAsM6XC72l7h863jhMv
         H+og==
X-Gm-Message-State: AOAM531HI1eLR4WaGrCaZyzUhjnS3X4xKZ/Te6tbjwzJYwfLCEZwwHom
        YDkhGO7zAYbC1zezQOuR9b3g8N8lvnC1vPPJBsUATJdi2NPXS0XBkysTE5WY0GfTQAN9Lmhp2lv
        HFI0NfasBGFbs+/pVr1q0aMM2AYPDtKwZvgGnrJOPaCn5yf0viDY/VQCDjEQkGpAdsfFwBkNTxp
        Q=
X-Received: by 2002:a05:600c:b42:: with SMTP id k2mr377644wmr.6.1639701493519;
        Thu, 16 Dec 2021 16:38:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMFw6g6irhLxPXJNgVKK8Lxu5pyTbKsmFvkdUXt9719H31xcpVTOILpNIB58naQJ4SO6dTmQ==
X-Received: by 2002:a05:600c:b42:: with SMTP id k2mr377632wmr.6.1639701493312;
        Thu, 16 Dec 2021 16:38:13 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:13 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>
Subject: [PATCH v2 15/37] drm/stm: Use drm_module_platform_driver() to register the driver
Date:   Fri, 17 Dec 2021 01:37:30 +0100
Message-Id: <20211217003752.3946210-16-javierm@redhat.com>
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

 drivers/gpu/drm/stm/drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index 222869b232ae..143b508b68db 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -236,7 +236,7 @@ static struct platform_driver stm_drm_platform_driver = {
 	},
 };
 
-module_platform_driver(stm_drm_platform_driver);
+drm_module_platform_driver(stm_drm_platform_driver);
 
 MODULE_AUTHOR("Philippe Cornu <philippe.cornu@st.com>");
 MODULE_AUTHOR("Yannick Fertre <yannick.fertre@st.com>");
-- 
2.33.1

