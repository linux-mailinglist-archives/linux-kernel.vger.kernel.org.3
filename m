Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0107E47819D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhLQAi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52513 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231309AbhLQAi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2sBzpk2fsKwHpZn+T2FBimQdU3OJP1/6a//W+uFghJ4=;
        b=HEjyk5+bVVuGv0TofhLZvk4P/LxfDJ9MCRQsXXvOMagH08PaZnrWYHpANjT46OIN0/Gbe8
        p1EnzXP3h2qzoFnJNhEpATb4HdDnMCTQZZSgLuuUjDbAq9cpjU8KOY5pkeCy4iVilTymbN
        yWZ/tTLvjbYnqm3zxtZ11C1hxbwi2W0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-7ZNxeY2uOjWZB9JrFuoifQ-1; Thu, 16 Dec 2021 19:38:25 -0500
X-MC-Unique: 7ZNxeY2uOjWZB9JrFuoifQ-1
Received: by mail-wm1-f72.google.com with SMTP id 144-20020a1c0496000000b003305ac0e03aso2065900wme.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2sBzpk2fsKwHpZn+T2FBimQdU3OJP1/6a//W+uFghJ4=;
        b=J5Zhq6fYn3X2f5Nc9QfpdNfq+VXp8Qh6Uq7bdr+mZTU1X/Y2k9Q0U6r+0G06EoQXnS
         4LxT6FoKdDNk5d0ryXEhzSd8E44wmq6dlkEZLQ2a29a7fUi2/1xNboF9PKfMRzI7vSBb
         EoKooz52ZVMbT0ZKpWwOGCJ9r2q4QAyVYZ3xvl2FxzSog550aghH1DTbSAm8CeIu4pW/
         Y0Jzv12loMkWeBpbLDVCbaGrQips8WCwDqJoH5AKYTRme/jSI48Uwvj6oShNnHfVDzUR
         uaScSLdwD9RO52eW3Z0aQVQQWZDBCtChQDoX5DV+dy9DilByfsxOnESd82DQljnZylPB
         WFKw==
X-Gm-Message-State: AOAM5328O11wBSFpvcO6kosSed3ZddtFy0OPPcWy+vFwfChlZYH/LMx2
        6F9LirWSxdGLqEteDwdslb/tKsDUeXfbXA20U6vQ1UE5z8x3jva6xFkY7eyAAFY6MbPTVOryNAz
        VgxHSoI0M+D1V5mF3Vro9opK5+6r7JOHRo++x9LLQdv7Rmt2z++uS7QzYNtuHzDxm6++kRDJg97
        E=
X-Received: by 2002:a05:600c:4e91:: with SMTP id f17mr346891wmq.195.1639701503893;
        Thu, 16 Dec 2021 16:38:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwRsau1I8cEnOg7ZqXrQs2zfayzOf7wmlzMPCpNNKy5x2CNdg7fDpz7eQOKnlfL+aWa2xn22A==
X-Received: by 2002:a05:600c:4e91:: with SMTP id f17mr346876wmq.195.1639701503621;
        Thu, 16 Dec 2021 16:38:23 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:23 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 26/37] drm/ingenic: Add support for the nomodeset kernel parameter
Date:   Fri, 17 Dec 2021 01:37:41 +0100
Message-Id: <20211217003752.3946210-27-javierm@redhat.com>
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

 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 542c4af70661..7f10d6eed549 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -1543,6 +1543,9 @@ static int ingenic_drm_init(void)
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

