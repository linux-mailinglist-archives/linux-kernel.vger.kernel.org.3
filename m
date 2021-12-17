Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5BA47817D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhLQAi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44364 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231217AbhLQAiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rA/uqKsHzPJPd8l1W3h6dIgfMpUINwyO957MUf0hISg=;
        b=BY8P1Kn/eoNpP/5aPGx+fV3+0KDKCaz2cI3N0nVO03IpL0CQkLH1OK8dp871Rm0WolcylY
        ABkINoH7UN/1H8+6aB6takSglIdnNkNZiFNt7hzoyKdjRCQEtxJSm2Sjy8GvcpwDo5uyzY
        bYWXgohTyMun1m5Gm0Iq1RaNE+ALBxs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-KKZzPLpzNUO3o5V4X5gENg-1; Thu, 16 Dec 2021 19:38:12 -0500
X-MC-Unique: KKZzPLpzNUO3o5V4X5gENg-1
Received: by mail-wr1-f69.google.com with SMTP id n22-20020adf8b16000000b001a22f61b29cso137298wra.23
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rA/uqKsHzPJPd8l1W3h6dIgfMpUINwyO957MUf0hISg=;
        b=t7PcMRdKh2AZ9LWjW0aQl9Hc4PCEqIs/lnoE0c0YZnVecQ7iDp/8IQExGOa2tA8ipn
         vZc9LLfTBXg9+sLgXgKJ/Qaqrtrwmngwa4ivIiUa1+R/OqurXkq4QqHCJfopT7RoxqX+
         nRG4UIPXyIt4pvmc6owsxJ2R1OL/5RpvEieFTCzS9BG79pBcETOy2qhHVatWPQXxkCdF
         +pj/6LdI35sCt+SBRWYJbqD8jlc3RkhB7ChNFIbHHK+y4L9MYQJY3dUWbRPPLsnzJscn
         U4jSGAojAqshCXGrzO5M45mC4hBygOLxgiSasTVVaOimMUlnvKEYvjiAEqDWLfkJFg4x
         Xglg==
X-Gm-Message-State: AOAM533P+5GvD43DHHAeti/tdMaTZwMV74h/GRseGzFas3THY0SqjODC
        cloRP2x2c2ZtbLcElErnfiAPm36NvrSWwve8je0nI8SFbnRUWdcb8C4jMan24DJPhsxF53LZM89
        WYP6E1CL6EESoH732zk2+xNm6sLnVCAyKAyhN3DmpcyEkHtkjOuVYk+meCwmPdR9BG9bhk7Dqbq
        E=
X-Received: by 2002:a05:600c:3584:: with SMTP id p4mr359690wmq.65.1639701491273;
        Thu, 16 Dec 2021 16:38:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxkPbBfL1LKyLF0LYv7GreHJ/NzzHpIBVh77Z2RQuAqRa640p3xksCecEIWH4K3qpBobFpqNA==
X-Received: by 2002:a05:600c:3584:: with SMTP id p4mr359678wmq.65.1639701491083;
        Thu, 16 Dec 2021 16:38:11 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:10 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 13/37] drm: mxsfb: Use drm_module_platform_driver() to register the driver
Date:   Fri, 17 Dec 2021 01:37:28 +0100
Message-Id: <20211217003752.3946210-14-javierm@redhat.com>
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

 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 86d78634a979..c843314d5b49 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -410,7 +410,7 @@ static struct platform_driver mxsfb_platform_driver = {
 	},
 };
 
-module_platform_driver(mxsfb_platform_driver);
+drm_module_platform_driver(mxsfb_platform_driver);
 
 MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
 MODULE_DESCRIPTION("Freescale MXS DRM/KMS driver");
-- 
2.33.1

