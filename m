Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751D247817C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhLQAiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24527 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231151AbhLQAiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/GvonJ2NqZfXSQGClXdvnbTmZF4yYJy2D12acQMdHo=;
        b=d9XN2woGJU/b3qmXohS5cM0Zed7rMmmDyezQpj0uiFiGP/0Ah+ioUCPl9akC4tlPQQLGxm
        XY182hetycv1XdcbuVSAAM+bo5Oxu/x1fzqifIJvVZ4NFyHiEPlJhdl1E0QBtRIrGgb2XP
        7caXvSXwYreCFUFARF1NhYbz473YoLw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-6t9jgURBNJCUdmAzCsN-8A-1; Thu, 16 Dec 2021 19:38:10 -0500
X-MC-Unique: 6t9jgURBNJCUdmAzCsN-8A-1
Received: by mail-wr1-f70.google.com with SMTP id l9-20020adfa389000000b001a23bd1c661so146810wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y/GvonJ2NqZfXSQGClXdvnbTmZF4yYJy2D12acQMdHo=;
        b=7lFi1/k44/k3Xggp8TKmpN2sf/hGnaLAhhMwfBgftooFPVDGf3LL+o9ZcxEtQe+q6n
         l8uyMTzOzA8uWj6j8jrZfEo1F+K6FuEqS+PCQu5JLmXe03Rx0B0vTRnRPY/tkp5eKHmk
         Tgy2LK7fiOWVwLjA+g0NaR8VnrkD7S2yxJem7yjqGKqd+MWWqIG3kzGAgf03gvYFxKvp
         sCDznPyMipH0v/tLfFA7dL2rNIRgeq9YdIA7pj64on8WpRAovlJE8vN709UNuyOOjzw7
         8wLQ6EgCQMicNc6duiMp2VktVrCLM4ROlZrU2x2/iixSSWbqVkG47l2Hcgekyv/HqirO
         8npA==
X-Gm-Message-State: AOAM532ATQvXBY99JbNxlgCMIO0643SLit0azkd5+KvT4BFhf5YPFcIs
        962EDLEUSm4iXEi+2qtwJxooMQ0+1/COZAR6/0HzvL05wC1wKETGipEYoMjDlmRnZATaNgOBypx
        VZN59xSGWtE7YbixfGq44WuIfxPlyHY7dk3N+Di4b06Aismr/KiFzzZHX74cyf3mDzjEi5IKldo
        4=
X-Received: by 2002:a5d:6d88:: with SMTP id l8mr402267wrs.270.1639701489244;
        Thu, 16 Dec 2021 16:38:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfLsvA2QaVHBD6DAMzBCXtLFy/U3iM87lNHcw8gWbPySLfAC8QpFJ3Cyc324OOY+OgCJZKxw==
X-Received: by 2002:a5d:6d88:: with SMTP id l8mr402251wrs.270.1639701489002;
        Thu, 16 Dec 2021 16:38:09 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:08 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Edmund Dea <edmund.j.dea@intel.com>
Subject: [PATCH v2 11/37] drm/kmb: Use drm_module_platform_driver() to register the driver
Date:   Fri, 17 Dec 2021 01:37:26 +0100
Message-Id: <20211217003752.3946210-12-javierm@redhat.com>
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

 drivers/gpu/drm/kmb/kmb_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
index ed2424350773..4a835f90fe3a 100644
--- a/drivers/gpu/drm/kmb/kmb_drv.c
+++ b/drivers/gpu/drm/kmb/kmb_drv.c
@@ -628,7 +628,7 @@ static struct platform_driver kmb_platform_driver = {
 	},
 };
 
-module_platform_driver(kmb_platform_driver);
+drm_module_platform_driver(kmb_platform_driver);
 
 MODULE_AUTHOR("Intel Corporation");
 MODULE_DESCRIPTION("Keembay Display driver");
-- 
2.33.1

