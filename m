Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239364DD19D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 01:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiCRAIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 20:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiCRAIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 20:08:51 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E408B2AA19D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 17:07:33 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id s11so8104680pfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 17:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1i8tHBCz0yGUnXTP63evaW8shC/1FTv22ymAKssO43g=;
        b=Ur+HSlhkoIDLHekqpPNSXAVLlxD5+T81ff6OBaHTxdXzokDkA8qnnVLDj9q0QAArhQ
         8B28qd/JYP4jKNuPGjkNF8Z9JI3moyBARf9Nk/nhV0r4cLAzMLmI/7ti/9uugVGYGR/J
         4cAJHw+XO9GiplYxM7ZZn9UlMuvIuvwPzTl/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1i8tHBCz0yGUnXTP63evaW8shC/1FTv22ymAKssO43g=;
        b=QWCaYJuFMLswe9s4Lg5ZhBhHZeMNsxmfkrqq22Rs/BErejzFrMxEIFwQJKlYfWb7ec
         NXCoPCVLHb0rejau/whU9gerywHteB7ChwknCg7pTtr4V/tR+PD7BmbT79gxcoum7byv
         SapGxq0PwCr5T35CydVVlUhRAMnHiZPI1uumlZP0XzzmO60vBj3HBruC+9Buz6NpcGe/
         dcVgBmVXMEPN6TWjK149ibbzebi02GBpiylcJ+be1AVJNCqOc9Z3k/ceDwPDYNBaqjtB
         ViNLv6kF2iADC3oJWu/NTFUCWtwGv2Zvw3pjfc67pEcn4pGQ1sVVP5s0uNDM2fqAXuxN
         /ruA==
X-Gm-Message-State: AOAM533cpU2r42Ryt+5MKtmfd30hIYjKeTlcbjzyVZbJcdbZ5r2VU8MO
        CZsNdvDhuK0tXzsdE64AeiWbfw==
X-Google-Smtp-Source: ABdhPJxx5b5fjDNUn/yUMHMvPSEd5Y6joMRanwaFw9+NHRmy92bdTzHYRpjmt7wsM7IX3PrGoD3Btw==
X-Received: by 2002:a05:6a00:815:b0:4f6:ee04:30af with SMTP id m21-20020a056a00081500b004f6ee0430afmr7183021pfk.15.1647562053324;
        Thu, 17 Mar 2022 17:07:33 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:49cf:7701:359e:b28f])
        by smtp.gmail.com with ESMTPSA id o5-20020a056a0015c500b004f76735be68sm8280640pfu.216.2022.03.17.17.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 17:07:33 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH] drm/msm/dsi: Use connector directly in msm_dsi_manager_connector_init()
Date:   Thu, 17 Mar 2022 17:07:31 -0700
Message-Id: <20220318000731.2823718-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The member 'msm_dsi->connector' isn't assigned until
msm_dsi_manager_connector_init() returns (see msm_dsi_modeset_init() and
how it assigns the return value). Therefore this pointer is going to be
NULL here. Let's use 'connector' which is what was intended.

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sean Paul <seanpaul@chromium.org>
Fixes: 6d5e78406991 ("drm/msm/dsi: Move dsi panel init into modeset init path")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

I don't know if this is superseeded by something else but I found this
while trying to use the connector from msm_dsi in this function.

 drivers/gpu/drm/msm/dsi/dsi_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index 0c1b7dde377c..9f6af0f0fe00 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -638,7 +638,7 @@ struct drm_connector *msm_dsi_manager_connector_init(u8 id)
 	return connector;
 
 fail:
-	connector->funcs->destroy(msm_dsi->connector);
+	connector->funcs->destroy(connector);
 	return ERR_PTR(ret);
 }
 

base-commit: 05afd57f4d34602a652fdaf58e0a2756b3c20fd4
-- 
https://chromeos.dev

