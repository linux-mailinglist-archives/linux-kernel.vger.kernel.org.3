Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EFA471446
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 15:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhLKOuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 09:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhLKOuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 09:50:03 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29982C061714
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 06:50:03 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso9890894pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 06:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Pn3ZNHAbrFAUG3+9tRrD8FUh+HGvY/p1TctxGzM5QjU=;
        b=ncT1CNwAjuA1Puzp9g5CTKeAWNiwxpjquYkFQYSykIcrwI0BmIrKhc5rv+ltSl37pp
         VORjz+PVSGB0ArJ6bfJDmwdIvQb+yRlJOV6h8kb7cJhK+9YU+ol7zMxESUCWjiWP4Not
         UB9MNBauC4vma3Ml17cPlemZZEwhA/VdSF+b3KQHzVulIBn+11Fb4ydrHcSYUZAYZxd4
         G7j2W+VFRYCSgYAFHaORYfLa95L0/9paUIJbLV0Rvb5NVW8OchohqD2q3PJvrNUzDo3f
         UrpE0vVuodBb/3ozidkiRnMVYCy4jGUk/9QcV0ywdmZd/i2Ywlx4+9ias/I2DLSG/Ujj
         t9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Pn3ZNHAbrFAUG3+9tRrD8FUh+HGvY/p1TctxGzM5QjU=;
        b=OER+yeDqxfv0avru5oPzsJQMbk0tAbqtt4Qe7ZPzU66zM3cehp6LndSZrH2i7mIltC
         wdgMBwuq1qIrydJ57GPFP533CyN42IXbvxqVOxuDVKMhg7wUS86qX1NrL5DQObpBZpWr
         0ih5WrKHNELi4wvodu4ykggIRkCx2Q527UpnXIpoaffEWGcWfyHjPDVsVmOpOwQ5YWbk
         wHxO1VscXhJajclCb86QqonPJAxeEJxokmWauCA4wyLwDdACHjaTHq9iaO3haU4IpnKG
         yq951CousJE47gF8QppZxaR/401PSgBTqDGdQT5plgLjva3hDbVkh9FuWQnyPJUNK8ZE
         kwtQ==
X-Gm-Message-State: AOAM531u9hknT7wDJ4LrekCj8C3NvIxqRx6gp2EbtxIt7HksnfSaeCkp
        3hJhvnaTXdTPuXwzl94Q4ug=
X-Google-Smtp-Source: ABdhPJwyPQTAjeOvEucKcjd3koaSPvfAUCnqdC0LWh3RvkUVHMCoBJfZAlV0Uka0+7EHgTg2b5QSuQ==
X-Received: by 2002:a17:902:c182:b0:148:699a:5147 with SMTP id d2-20020a170902c18200b00148699a5147mr14590148pld.61.1639234202602;
        Sat, 11 Dec 2021 06:50:02 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id u3sm7557852pfk.32.2021.12.11.06.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 06:50:02 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/genalloc: Fix NULL vs IS_ERR() checking
Date:   Sat, 11 Dec 2021 14:49:56 +0000
Message-Id: <20211211144957.31381-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_gen_pool_create() function does not return NULL. It
returns error pointers.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/vboxvideo/vbox_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vboxvideo/vbox_main.c b/drivers/gpu/drm/vboxvideo/vbox_main.c
index f28779715ccd..c9e8b3a63c62 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_main.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_main.c
@@ -127,8 +127,8 @@ int vbox_hw_init(struct vbox_private *vbox)
 	/* Create guest-heap mem-pool use 2^4 = 16 byte chunks */
 	vbox->guest_pool = devm_gen_pool_create(vbox->ddev.dev, 4, -1,
 						"vboxvideo-accel");
-	if (!vbox->guest_pool)
-		return -ENOMEM;
+	if (IS_ERR(vbox->guest_pool))
+		return PTR_ERR(vbox->guest_pool);
 
 	ret = gen_pool_add_virt(vbox->guest_pool,
 				(unsigned long)vbox->guest_heap,
-- 
2.17.1

