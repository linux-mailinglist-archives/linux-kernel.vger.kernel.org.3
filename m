Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A5D4781AB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhLQAjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:39:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49988 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231428AbhLQAic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A01Ev1RLvxyt82eZGFo2uP87MzinUPDeffH9HM1ovKM=;
        b=K4xLmWWqFDXl52P1vpfe8PzD4310AzVfYDw3WI6JiMttXCCUYBoagrjqaeQeNrT3ZmGzj5
        WKFWwRHqfGbtRDYrpDS01b6W3B811h2y/tvUAchuR8ii3kqaaUnAlMgWhqBgAx1bUczY7/
        yJ4HgUT0zYpWwFHrfgh10LeA6TqOF40=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-aKGQ5SW6PS-bwtyWAngH6Q-1; Thu, 16 Dec 2021 19:38:29 -0500
X-MC-Unique: aKGQ5SW6PS-bwtyWAngH6Q-1
Received: by mail-wm1-f69.google.com with SMTP id 138-20020a1c0090000000b00338bb803204so399170wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A01Ev1RLvxyt82eZGFo2uP87MzinUPDeffH9HM1ovKM=;
        b=NXYELZPLl+WXyofSfjI7MdzMU2fmG6hu0r9VsPjjA0/NdOzNzjA+BSEvjgavZu2UCb
         5eCYe9uLmbkUiuideIe3emuA2EIhiECK06SXsu5b59T6FhOrnnuJqgSHq6tNMd4yihcr
         2PhuGXuNvS/W+1CDs0yl1abShN4S98q718mpJqbglVGj1HPBI9X1ndV++Ieu7OW3xd+o
         KLBAt9hgjQl8eI0WsWzZlWJj53prrwslpnxz3UKn9qv7ndMPKNrFy+Z8ul5cFsFZSfSQ
         qSwcX5fPBrbIdKKY2OGSOnDqG0Q4ZBvP/xse82+DUnC/wLM/GwPYx4COY3FueWlS6BPV
         kCgw==
X-Gm-Message-State: AOAM532POTsPrAxrSUCfRwvDW9HelpyIXTwIvb9Epy+rVRrHQumVKznH
        MPuQSTzq7af0EtPfIdMx7Dqkg+Go6Iemig4ZIM+E6/Zo3uZkaZalonCpMh6h9tUjEALKxIVHoRp
        jVZ9PEHfwt9m4uyy7poiusqv6k7xU+RZFf5P0pysswilvEbYyxPMxw/5HFecFnh9jvszZwW9qyR
        I=
X-Received: by 2002:a05:6000:1869:: with SMTP id d9mr378208wri.416.1639701508582;
        Thu, 16 Dec 2021 16:38:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw3FL49j/6BhFXA9xM36BJ50ni1jnBa0VBdSkEYAvHATpp+oC/TCM7yUjqhtSUTJHdRddpaeg==
X-Received: by 2002:a05:6000:1869:: with SMTP id d9mr378198wri.416.1639701508357;
        Thu, 16 Dec 2021 16:38:28 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:28 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 31/37] drm: rcar-du: Add support for the nomodeset kernel parameter
Date:   Fri, 17 Dec 2021 01:37:46 +0100
Message-Id: <20211217003752.3946210-32-javierm@redhat.com>
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

 drivers/gpu/drm/rcar-du/rcar_du_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 5a8131ef81d5..982e450233ed 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -701,6 +701,9 @@ static struct platform_driver rcar_du_platform_driver = {
 
 static int __init rcar_du_init(void)
 {
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	rcar_du_of_init(rcar_du_of_table);
 
 	return platform_driver_register(&rcar_du_platform_driver);
-- 
2.33.1

