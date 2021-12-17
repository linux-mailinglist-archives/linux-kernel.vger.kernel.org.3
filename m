Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605524781B0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhLQAjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:39:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44324 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229817AbhLQAig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LS45ptuKLtucyzrI9aH/fv6UqLJgOvCJlOd2PAEqfE8=;
        b=BiztDQu7PAD1cQ8p+KmsWNatiDRyeE3RMnn92Qq1adChB8QZihy4+MiNFS+E3azVUiR63t
        3RbHjmQ162Hl9g0SwBq+kogWLc+iQHpRKjhsIG6DRCHuyS+6sk5XLypVr0XTXdtxwwj6XQ
        +lUFMUMVKfq6i5/gI63wydPP58Oj4kY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-102-wnQaDBIkPf-7_a6pBOolGw-1; Thu, 16 Dec 2021 19:38:34 -0500
X-MC-Unique: wnQaDBIkPf-7_a6pBOolGw-1
Received: by mail-wr1-f72.google.com with SMTP id q21-20020adfab15000000b001a24b36e47eso148745wrc.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LS45ptuKLtucyzrI9aH/fv6UqLJgOvCJlOd2PAEqfE8=;
        b=Zkw7pL3YiTlmwMYsPWHFKGJtt/Jie+jJ8JuvHO/1xztXZOK7aMJHg/nECvAwAeAMNW
         K6Exwm9zK03bABZTGD3zaCIHNW/bJhzdLBn8Q+rDQNMYEsPwEnVEYQpnh3poml+pocUy
         Fsma2GaJoBohanayJ4v59kJGHBCVbNYmI5NK8zfwdjWlWWBg+1TwOUvVhHEefyoGxu/5
         kTpLCQ4B/erQRfBrv5DyDDqGa7c06XFalWL/Gwx3SuOLoZKO9Y7JI13EqzFhMJKe47Rz
         RPd7zHXJUZ0YPESZNXMhHdkcZ/HrLS7lq61L3UQDnTvF7KRZCcluHpRLE8RCK10Zjyqf
         XQSA==
X-Gm-Message-State: AOAM532TNqGZeh/krfANdymgTOmD3Y2tACqRu/apgC7Rlb6zINlNa2Cr
        nxPr9BIptqPuZZw6n0JfnUQqWataZjo2ywYX/nbWJSq94T4LzIu+OeHBDz/dRFYut3FuVaEkUG3
        B2vPGzaFEUi+heZ+VBRhByawmNWW6L/MR8tjiwiUPXPkleIXXvZfWryOWWpOWMvdKjcQHExoG79
        k=
X-Received: by 2002:adf:ed83:: with SMTP id c3mr369011wro.169.1639701512878;
        Thu, 16 Dec 2021 16:38:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgNRxmXpv8ar/HlM4TfNJSibrarj6nNRlhhEoWvFkpXvNFl1qNA/H5nvze7GA/dpw0kCtyVQ==
X-Received: by 2002:adf:ed83:: with SMTP id c3mr368998wro.169.1639701512577;
        Thu, 16 Dec 2021 16:38:32 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:32 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>
Subject: [PATCH v2 36/37] drm/tilcdc: Add support for the nomodeset kernel parameter
Date:   Fri, 17 Dec 2021 01:37:51 +0100
Message-Id: <20211217003752.3946210-37-javierm@redhat.com>
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

 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index cc567c87057d..eee3c447fbac 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -604,6 +604,9 @@ static struct platform_driver tilcdc_platform_driver = {
 
 static int __init tilcdc_drm_init(void)
 {
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	DBG("init");
 	tilcdc_panel_init();
 	return platform_driver_register(&tilcdc_platform_driver);
-- 
2.33.1

