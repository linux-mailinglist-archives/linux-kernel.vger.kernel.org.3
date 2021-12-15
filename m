Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AD8475020
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239404AbhLOBCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:02:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31764 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238979AbhLOBB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1XLGTzZR5SpObjnbZJCz+iRhH5vaorImXn0ahIouADE=;
        b=QlsL8weXw2zMAolHPdk2MJeBIKg17O41jUrfe4rtP9AiZkbV8+UKFseyGLpU78/j3LqBwA
        8Je+Dh27SP25WCSj/0TMBEAwETuDXgotBnkrQyIyCa8Y9ZwH667oIS+trLPnMUuc3M5ocR
        f3ml0JpV4ZZXB2u4KMWXVKoAQ36evuQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-A_i-mo2wPS-PwSlolJB1CQ-1; Tue, 14 Dec 2021 20:01:25 -0500
X-MC-Unique: A_i-mo2wPS-PwSlolJB1CQ-1
Received: by mail-wr1-f70.google.com with SMTP id d7-20020a5d6447000000b00186a113463dso5382012wrw.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1XLGTzZR5SpObjnbZJCz+iRhH5vaorImXn0ahIouADE=;
        b=fTupXY7dLnM5+eTnHnXtr/QOz2g0f6pRxvOfl+3BZ0yjR82CErCyz+DcRg0Jh4F/E+
         W2IiKrmxtDj9XNkx/bISIHwOYPvEOpIio11C0y1zxnJPNe3MdaidX81HvXcL4fTTvmbi
         23+lEFwxeFIEwyfmbBeFoMyl50tqc1iAgHob6d4/lKapJXjAyTSaGlhl9xo6YLCE+AoE
         7SVYhoPMcswGeyz8svly9BaAMSgFAk8hxN5XngjGdMhiCq1p1fLt7MHs52HbRNkP/4Uy
         FMXVrqNeR/7ca0biNfwMkzAGY981VbKwJi+tpOTlPuCH+ZSvnD1MrD9O/iLfVzqJ84gW
         75gA==
X-Gm-Message-State: AOAM530h92X+h6P/GXZ9Dc2yqyK3fEwMzsPMrIeKGT/faoTozfh6/BqV
        XGEFFAq6lD4lf+UgfeDl0Vc0ASPhkoNt9RnqlwMyRTcaKDla5dEHSRitmyyR4inmut8J0QPTxb6
        M8qmwmefI41WcIJCNzo7A+ri2vPMeptVdtvE4uidMpuigB/7dQXNjebtwCxSzauAZLqlUWdPoiX
        U=
X-Received: by 2002:a05:600c:4fcc:: with SMTP id o12mr2464276wmq.110.1639530083953;
        Tue, 14 Dec 2021 17:01:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwj9EYvx5qVp7UwgDZOdpKhwMxubh+UJgDB1lS5DDoN+p82jW7COF0RCzNGJqVYM/ugqhTVgg==
X-Received: by 2002:a05:600c:4fcc:: with SMTP id o12mr2464254wmq.110.1639530083696;
        Tue, 14 Dec 2021 17:01:23 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:23 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH 38/60] drm/sti: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:46 +0100
Message-Id: <20211215010008.2545520-39-javierm@redhat.com>
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

 drivers/gpu/drm/sti/sti_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
index c7efb43b83ee..860b2230aa08 100644
--- a/drivers/gpu/drm/sti/sti_drv.c
+++ b/drivers/gpu/drm/sti/sti_drv.c
@@ -287,6 +287,9 @@ static struct platform_driver * const drivers[] = {
 
 static int sti_drm_init(void)
 {
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	return platform_register_drivers(drivers, ARRAY_SIZE(drivers));
 }
 module_init(sti_drm_init);
-- 
2.33.1

