Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD57478184
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhLQAij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45143 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231156AbhLQAiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aro9Nni/tJ9jlKm8kD+solQuJshNFFRMvr/HoiFuQkE=;
        b=Q1Wqzzcak0PebV9SjTgVw2mA5WOigTcv2HgsiKGvmnotveKh0f8ByMwoIiWYYuABfjTOho
        WXhtMSOJCE8VoSrA8MZXgDatFA/Ap+FBEibrwoWgRsYDNQiYo19RO3QKC1Gqk2LDKs1EZD
        yyqZ6gczjb7q3BZrrGoP8Y2Wlge79PY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-5xta0fNCNta0NIUQX1UXYw-1; Thu, 16 Dec 2021 19:38:18 -0500
X-MC-Unique: 5xta0fNCNta0NIUQX1UXYw-1
Received: by mail-wr1-f72.google.com with SMTP id c16-20020adfa310000000b001a2349890e1so160618wrb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aro9Nni/tJ9jlKm8kD+solQuJshNFFRMvr/HoiFuQkE=;
        b=TpYqcsDJOmltA5gnlh9pvBkfLPd1V41PWZErrAqQ58nQLkp6fXuAAZYep+gAYq7oT3
         fkFngLj1KnDSVgmOqOqgxeDN+E30R26Rn6clmOEZvGppFGn+G7ApvYvyql/hkjoVzvur
         30nkFfjLLUDgTwjLIg016pP7mZ7EJwUQGWvC40YsLjNboUUGZL5wn0v72o0kY4LPP0f+
         lt8rPmzyBRuNfsLnDvWFqleF0YEpzOR/rentN0DxjyNVICdXXuJneS4N2/AuEokp0LCN
         +v2806cjbYlvrqEp14t9X5wVpXmwT1NS/lhc29P1MeyTD5Qz60V142X+3CpOXBbxCIiA
         VC7A==
X-Gm-Message-State: AOAM533OYTDfzDotIsA8VlWN3PKVQE7w1WNKQ84m1FAdJIXzxPxmQuTw
        XDhZ2x0oYvkIQc+kKHhwfDkyMSgJmViXbOebURbkNqTYgQ2JgL4/yTyH7xgLp1+DdICzJJOlS3b
        8TpyKcq5Us5AUbLI66P45ZOq0m8eQMzNHVLfdOmYzFYFIPMPJKgVpeweZ+glwdu1//CXNCWk28B
        4=
X-Received: by 2002:a1c:741a:: with SMTP id p26mr7367090wmc.133.1639701497654;
        Thu, 16 Dec 2021 16:38:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBD5MWnCftfU41wLw4KyALiYsF6+lJ+n1/l4WeDW6hQzr2fmxHvIg+BhSFpM7Bahl+mg3bsQ==
X-Received: by 2002:a1c:741a:: with SMTP id p26mr7367075wmc.133.1639701497383;
        Thu, 16 Dec 2021 16:38:17 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:16 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 19/37] drm/tve200: Use drm_module_platform_driver() to register the driver
Date:   Fri, 17 Dec 2021 01:37:34 +0100
Message-Id: <20211217003752.3946210-20-javierm@redhat.com>
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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---

(no changes since v1)

 drivers/gpu/drm/tve200/tve200_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c
index 7fa71c8bb828..b1c35c13faeb 100644
--- a/drivers/gpu/drm/tve200/tve200_drv.c
+++ b/drivers/gpu/drm/tve200/tve200_drv.c
@@ -266,7 +266,7 @@ static struct platform_driver tve200_driver = {
 	.probe = tve200_probe,
 	.remove = tve200_remove,
 };
-module_platform_driver(tve200_driver);
+drm_module_platform_driver(tve200_driver);
 
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
-- 
2.33.1

