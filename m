Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19397481A20
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbhL3HJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236041AbhL3HJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:09:51 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124F3C061574;
        Wed, 29 Dec 2021 23:09:51 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so21903152pjf.3;
        Wed, 29 Dec 2021 23:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ZDP2T3kEdA2Z/HSfJU3quwQVcpsj6OKL669wXFyJOLM=;
        b=ewFBGrrBkM1b1Tm+9/Tfx0/jdnhhjHUmqN2gPCUfoaIQiudnZP/aHzudqr0wsCP8aQ
         rormtM95j8BEp56u+2L+GF4D3FjPjcn1CSbQzU9UcbEXBZ/Po2MLBtH8STz9EiTk6vmn
         ozXz9s1afuD1u/5C9jV+0eiG5+aqTim261vL0eh2HAdfDULaO5th6A6024sSxM6o97Aa
         LJbiRLmRMETO6TQMR7imF/w7tgASINZQOXVtJ2VMQHjHafd+HpGPLT93RdWgc04k1udX
         sL53h+kRamfZtJ9pSSKuzzzCa2P96TKD/393I4LXYaULqtE6RGMpE44hI8TGAmxNkuS+
         Kh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZDP2T3kEdA2Z/HSfJU3quwQVcpsj6OKL669wXFyJOLM=;
        b=h2fj3S9Ls9QhCMGDSHMMS70xiTsUtOYNgiPv3sVsVpbiXeOMoV5eJnUcJH2DxvCkuM
         HjbdnZH4l+O1eWkzP+ve8xkFqXDDZQ+lSxwxXvkszWxai+/aUtOhDgeraAI8InUfJRda
         Y0fkpuASADG8Y2tEN2PtyMwnJOiyKOkQWGEdAgNph8mgYhdZb95Zm/EVLrSC7hh/FhpB
         hvrjmU/zqXoCr50kbt78VE3/MtnKh2S0F7W0JcORt5X5dibeI1FbV1vS8CzXe3UPCbbF
         zrgM44hFQQxiJtTFkNUH0VcMzA3o0lOrnFmFaTZ97km1xhJlPi9bbxw5DbeNpuioRQZP
         GrTg==
X-Gm-Message-State: AOAM530ZVMQMIT7zn6BQeyPdpz09qUHASSe5hjgG1dgO9UtSZi4J3AYf
        swGPW33O2pMu1pzJTCQ7Hnc=
X-Google-Smtp-Source: ABdhPJx3W4rYV1Sq+P6R0r+0aSLlg1TI58NlfVsAeHyTkdba/dBdZqLjrK02fPkqUSdPeo9VzcuRNA==
X-Received: by 2002:a17:902:c94f:b0:148:d23a:c88e with SMTP id i15-20020a170902c94f00b00148d23ac88emr31023765pla.26.1640848190523;
        Wed, 29 Dec 2021 23:09:50 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id x2sm21640486pgo.2.2021.12.29.23.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 23:09:50 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hai Li <hali@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dsi: Fix missing put_device() call in dsi_get_phy
Date:   Thu, 30 Dec 2021 07:09:40 +0000
Message-Id: <20211230070943.18116-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If of_find_device_by_node() succeeds, dsi_get_phy() doesn't
a corresponding put_device(). Thus add put_device() to fix the exception
handling.

Fixes: ec31abf ("drm/msm/dsi: Separate PHY to another platform device")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/msm/dsi/dsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index 75ae3008b68f..35be526e907a 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -40,7 +40,12 @@ static int dsi_get_phy(struct msm_dsi *msm_dsi)
 
 	of_node_put(phy_node);
 
-	if (!phy_pdev || !msm_dsi->phy) {
+	if (!phy_pdev) {
+		DRM_DEV_ERROR(&pdev->dev, "%s: phy driver is not ready\n", __func__);
+		return -EPROBE_DEFER;
+	}
+	if (!msm_dsi->phy) {
+		put_device(&phy_pdev->dev);
 		DRM_DEV_ERROR(&pdev->dev, "%s: phy driver is not ready\n", __func__);
 		return -EPROBE_DEFER;
 	}
-- 
2.17.1

