Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180C8478185
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhLQAik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57624 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231279AbhLQAiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aYRJCKrd2+7uPQGF190uQYPQip+gsBG97QfrRl/YyLs=;
        b=RygKAhcD0ulQht/joj9NJQNrlancvZ0Wc71Rw6Rq7xLTwHZtz/DQQ21ISi0OSQABjF/TEZ
        mI0B/AG01EoNrVm5iB6/mqWFEb0/csX/vkSMQXnLBt3w8Na/kkDc7NkgAnNhhj3lFfqb++
        O8WP5+GHNE8B4UnyHjL0DLyQSyfms7I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-0HEIR-7NP6GoIp9V5w2IvQ-1; Thu, 16 Dec 2021 19:38:19 -0500
X-MC-Unique: 0HEIR-7NP6GoIp9V5w2IvQ-1
Received: by mail-wm1-f70.google.com with SMTP id l34-20020a05600c1d2200b00344d34754e4so2071477wms.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aYRJCKrd2+7uPQGF190uQYPQip+gsBG97QfrRl/YyLs=;
        b=rTAsjytYcPHQuNoTvhIyykY5lCRXsr4dyEdrWb7J3o4LTTEere+KAbAcpaPW/6dokI
         MHUCs8XkayxF6h2HPEKRnL6XaM+1DBgFZHLCyf3rBo31VIV6vGUEtSeP4Tp3AsdgxTU1
         SMbTFjs4muoqmkHqxmEK9VTyTU0SmvzBCuiGT8MucpAzVXQikzNUy7WyEcFfBPRzxCbB
         ID8wvxiqVmJ3VfOJTjGf0H+JFDm2OFiuZb2a5XvGgv/3LKxJ9IUp0dy+t/SI5t8xjwTr
         D38kGETtEVocFvIlVk/0C9gC8jjx8gdRXxC4lIKiN/TpYmFyfHte1G+MWTVtYD03TaGY
         OqfA==
X-Gm-Message-State: AOAM532b2H+yENxFM5Gkn89l0rP1pqgClFhvGJSxZrD61sh0F4TStU0K
        Qr6pwIAd5kPczmWmj9XziFgOEjwvA0FRzl8a/tPm3GARrXvD11Q8r4TMtPcVPN2S55WJyyoFRfu
        9TQpvy+il2D5Sj7xj0VyL7kwDQLya/CE6cbCkCuturHGwSNthKkf1JIXrHVfFgr5iO3y84jAyYx
        8=
X-Received: by 2002:a5d:548f:: with SMTP id h15mr369931wrv.99.1639701498445;
        Thu, 16 Dec 2021 16:38:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJykGTqlKLbJaHtGWlvMlQeut/mMfG1i8liFQGHb5nirG+I23IdOtiMdza3+LogSE5Gfa31P+w==
X-Received: by 2002:a5d:548f:: with SMTP id h15mr369920wrv.99.1639701498253;
        Thu, 16 Dec 2021 16:38:18 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:18 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 20/37] drm/xlnx: Use drm_module_platform_driver() to register the driver
Date:   Fri, 17 Dec 2021 01:37:35 +0100
Message-Id: <20211217003752.3946210-21-javierm@redhat.com>
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

 drivers/gpu/drm/xlnx/zynqmp_dpsub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
index ac37053412a1..311796106b70 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
@@ -286,7 +286,7 @@ static struct platform_driver zynqmp_dpsub_driver = {
 	},
 };
 
-module_platform_driver(zynqmp_dpsub_driver);
+drm_module_platform_driver(zynqmp_dpsub_driver);
 
 MODULE_AUTHOR("Xilinx, Inc.");
 MODULE_DESCRIPTION("ZynqMP DP Subsystem Driver");
-- 
2.33.1

