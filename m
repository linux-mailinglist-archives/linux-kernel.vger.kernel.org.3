Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16417475035
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239651AbhLOBDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:03:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21406 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239132AbhLOBBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=If0/Rf9Wm5tTSQlPAKpGzbiBM/4txD6ayzOYSnTn4nc=;
        b=gFxD8mOMKeB4ZPAZaqHjzjncR2KNkO3e4M5M5Z5KmTKClIKLQ19VY+iPH4zdl5l2s8GvTv
        g06fl7in8n8h5/uBBKN1CeaDuMbZwYUd57BdX2Lyxx+05ye9ik4kXVS0RR5uzUCo56TTMU
        oQW66APy2izvPi0YiBPjtPkeWmH+DBA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-548-nq58DTyMMIuG0Vx4reE2wQ-1; Tue, 14 Dec 2021 20:01:41 -0500
X-MC-Unique: nq58DTyMMIuG0Vx4reE2wQ-1
Received: by mail-wm1-f69.google.com with SMTP id 205-20020a1c00d6000000b003335d1384f1so13898404wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=If0/Rf9Wm5tTSQlPAKpGzbiBM/4txD6ayzOYSnTn4nc=;
        b=u8MDLh6gXzSteXl28O5Nd0Nzqf0+dD8g1qJxLqCaZA8dzkTkccMZKBiFqYdYlXzTzr
         MDyg8GReuHUxfTQ6kl/Aoh9079stDUmZnig/zgLElJL1pjTVwuHWpq1FrfcSJRdRZMF7
         S2QTjA8c55fLlidd/x0SZPzF5I2EoytwvSG1QWDfd07SwvXfSYgKUhofpaJNxNEXqxhG
         TvLGdoW5a3wWd3SHtTwh7kkObilpJFkl+7gdKIublq3wehRngSIUwZHWhBFBIy/6albi
         gVTeZ/9XrW6crnGqFub4ATk9Pu05RYaoTFlDvIzzNVHLVdk1qsiCQY6jW054E3KQUDtG
         bCew==
X-Gm-Message-State: AOAM531bNx9iMg+y3fZe199wqGt3d8FxXH8vD8vrz5v8waBgyRkfBPv9
        2KXbK5KUpEgBR++wIC0MsV9bMG6dH5PkMHED6PFkWkJJktLaIZ8eRE2A9oFvqbYSp6jbD237q9s
        K8c1knMO7coK5ie5cdKPlgriVkMAnmMMucLFmGdXOtwcwy85I0839jdXD/rsHyMt7al1xieOcnn
        4=
X-Received: by 2002:a5d:4883:: with SMTP id g3mr2182493wrq.590.1639530100003;
        Tue, 14 Dec 2021 17:01:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxDseigahROS0KmkmjXTnhvtROBpPvhKmvaS4LRmNphhZDojYZ2ZPoPBDEcYQbylIv7aDz6CQ==
X-Received: by 2002:a5d:4883:: with SMTP id g3mr2182473wrq.590.1639530099756;
        Tue, 14 Dec 2021 17:01:39 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:39 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 58/60] drm/via: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 02:00:06 +0100
Message-Id: <20211215010008.2545520-59-javierm@redhat.com>
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

 drivers/gpu/drm/via/via_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/via/via_drv.c b/drivers/gpu/drm/via/via_drv.c
index 5da38082821f..57d63514f812 100644
--- a/drivers/gpu/drm/via/via_drv.c
+++ b/drivers/gpu/drm/via/via_drv.c
@@ -106,6 +106,9 @@ static struct pci_driver via_pci_driver = {
 
 static int __init via_init(void)
 {
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	driver.num_ioctls = via_max_ioctl;
 	via_init_command_verifier();
 	return drm_legacy_pci_init(&driver, &via_pci_driver);
-- 
2.33.1

