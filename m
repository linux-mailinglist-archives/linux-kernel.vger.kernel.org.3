Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B1449D795
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 02:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbiA0Bom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 20:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiA0Bol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 20:44:41 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C49C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 17:44:41 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id o3so1272498qtm.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 17:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fkZRVSlN4OVqtWVL7pewLYQ6zSvcJSeKEV0uiFIaRLk=;
        b=dH5AjtjcUNRW+nbSzvOeXBjGXOwYbtL3LGiDQxPOv2Jd0Xz8ZpG66rlr80WsqXfIxS
         IeVSSkW0TY+us/IaD+OJr90QsyPSqiBM9QbHlWVUfzdZquhT7Fw9RNYnZzzFL8ZfZbJo
         0nanawA37PuhwHwyemb9WmwmD5T0mML991BB/sYoysqrr8VtNKr3AjVUkxqHtvAlgqYM
         defAdyrdpcVU6/xUWtn6SmGrdVGp+fOPxF6iLOwMXuFOOmqnvaCP4KARYbtZ+zWe7xlT
         VjQjAVVUBzq+t+szZ1wG+87BFZZtobEtRReSCKtBPI0cHjsOogAjfu3tLOFD6Ch5izPd
         2CmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fkZRVSlN4OVqtWVL7pewLYQ6zSvcJSeKEV0uiFIaRLk=;
        b=4tQtEAZkTKRqIvy/iunXr3uUPd1dKGK9i/vw6a4RzpIM6/VQayHSBogkcSx6GlzQnE
         N2Wg2xGPIjKUYGx96qIT4k3eRbOsCSGF8nHSLZIVuMdf75pE7oSL+S02ILSIt621a4Gb
         LhZ/D7UtcXehNxUOdprbScMvmIUflQv1xGnwwafOeXeUaYs5wE3Yslkm1GphlfMIoGRd
         0enwtENd2593pONcCMIk6HWv4eZiHDAD17RK1t3wpUwz8G4/qsvpgd/BAcwrhxSLDNBA
         ayffUcoYjEhGrknqZtSxfGLVilGKdSPD5ZrLL1q28NIBq/xVfIa3VwP7VLqtqZWXUhU9
         kzYw==
X-Gm-Message-State: AOAM5323K68Cmn3UGMZY1dE/XJlhadhN94syq5j8T+R6HI3elPuSYY8C
        mVZl2BZnarS0uFAKLh85lLBSXpP5q+E=
X-Google-Smtp-Source: ABdhPJy4vAwIjbPf59Lgx5QWmb2pX3lLzFpQDOjoRe8jLEPWzH36QASNhH77p7m6WXw3/OOm9bkHAQ==
X-Received: by 2002:a05:622a:1008:: with SMTP id d8mr1201056qte.222.1643247880468;
        Wed, 26 Jan 2022 17:44:40 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h6sm730432qko.7.2022.01.26.17.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 17:44:40 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     nsaenz@kernel.org
Cc:     rdunlap@infradead.org, unixbhaskar@gmail.com,
        stefan.wahren@i2se.com, dave.stevenson@raspberrypi.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] vchiq-mmal: Remove redundant 'flush_workqueue()' calls
Date:   Thu, 27 Jan 2022 01:44:32 +0000
Message-Id: <20220127014432.1185206-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>

'destroy_workqueue()' already drains the queue before destroying it,
so there is no need to flush it explicitly.

Remove the redundant 'flush_workqueue()' calls.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 76d3f0399964..60305c63c6f6 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -1844,7 +1844,6 @@ int vchiq_mmal_finalise(struct vchiq_mmal_instance *instance)
 	mutex_unlock(&instance->vchiq_mutex);
 
 	vchiq_shutdown(instance->vchiq_instance);
-	flush_workqueue(instance->bulk_wq);
 	destroy_workqueue(instance->bulk_wq);
 
 	vfree(instance->bulk_scratch);
-- 
2.25.1

