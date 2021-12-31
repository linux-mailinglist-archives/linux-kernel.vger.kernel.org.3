Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFBD4822AA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 09:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242779AbhLaIEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 03:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhLaIEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 03:04:39 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36825C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 00:04:37 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id z9-20020a17090a7b8900b001b13558eadaso29987067pjc.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 00:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=WWn2vHEnNgrYMCO42Q0aqy5dnJYo2Iw24qL0jhZtEHI=;
        b=JXhQ7nTpM8HWET9l2RCzezcfeFKcAnWRbCiQDsvtDUGToDRXWZWRm5H+fI3ypWKOWf
         wIWa7zlSokdGPvPFuLU0nubICVSeiWLczFgO7MJniaoDClPLl2tFqlt5wvgFFbCF2j8S
         Fu75qhTnWkAfHHP3JQxGdVYM2N3XVCQiylb2kxZQcy2lSnd9KSexJH8LjWAtNbBVSsEA
         oxSt349vEBWedCl+KEv3XknJzF+fLrdfmpNiriUvKlOLnQ1GVBJcJij+RKSkNveN/tEs
         Qy+8bCBk1zQdBUJKRCtrPA+gDHr2/QJQ5dgqDgkDbmjbPkQxoK8JRg9BAimZEgmPlxsN
         b6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WWn2vHEnNgrYMCO42Q0aqy5dnJYo2Iw24qL0jhZtEHI=;
        b=DFAf6X7QA6hhftUc1N+RW06NGUNOh/SgtA20LCPziLSNP4V4B3R3RsQtieesuQ0kdU
         E4rfNkVHhsRbIvWRMRatwez4xWKETt1FXqHvJFdktU6EXYPG50mojODZP0fW8K7o8m98
         7Fqi7djpKubYOiCorrHlSmT8Xdm05gGg8XGhbVaeoxT0ib9V+zDZewhCqJj+3dY0e5db
         rAqwpEssxopGLkinCRJ/7BiOW9vE7bbUYsIqxoY0mkpX2fuRk9UVHPzGgCi7hYkU5qWU
         iFzW0jB4Rbdd9zeOcyKE2HnIyYeVOV25DPQMmuYWnyfZxjTrpNZI5tQyAM2EJINVvCjC
         J8Jg==
X-Gm-Message-State: AOAM530s9emYRksgBfPfm7pRl1M80rrKz7jiSEaTu1Lo+agS/7hsjp83
        dgouT4ArvsjbPgPUk/gtsDc=
X-Google-Smtp-Source: ABdhPJzUJOrgMtiFt9FPjgmTx1pg/1HmRXDyLgZmd5iHb55dFpFpKmANb8tK7FgB6bm5SDJOokaOxQ==
X-Received: by 2002:a17:90a:5b:: with SMTP id 27mr41735448pjb.148.1640937876616;
        Fri, 31 Dec 2021 00:04:36 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id q9sm26265959pjg.1.2021.12.31.00.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 00:04:36 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Borislav Petkov <bp@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/firmware: Add missing platform_device_put() in sysfb_create_simplefb
Date:   Fri, 31 Dec 2021 08:04:25 +0000
Message-Id: <20211231080431.15385-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing platform_device_put() before return from
sysfb_create_simplefb() in the error handling case.

Fixes: 8633ef8 ("drivers/firmware: consolidate EFI framebuffer setup for all arches")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/firmware/sysfb_simplefb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/sysfb_simplefb.c b/drivers/firmware/sysfb_simplefb.c
index b86761904949..303a491e520d 100644
--- a/drivers/firmware/sysfb_simplefb.c
+++ b/drivers/firmware/sysfb_simplefb.c
@@ -113,12 +113,16 @@ __init int sysfb_create_simplefb(const struct screen_info *si,
 	sysfb_apply_efi_quirks(pd);
 
 	ret = platform_device_add_resources(pd, &res, 1);
-	if (ret)
+	if (ret) {
+		platform_device_put(pd);
 		return ret;
+	}
 
 	ret = platform_device_add_data(pd, mode, sizeof(*mode));
-	if (ret)
+	if (ret) {
+		platform_device_put(pd);
 		return ret;
+	}
 
 	return platform_device_add(pd);
 }
-- 
2.17.1

