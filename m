Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651CF569272
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 21:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbiGFTOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 15:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiGFTOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 15:14:45 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4E919C19
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 12:14:45 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id m2so14428231plx.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 12:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rmyIuGz4xgr5RGO7XFrd0kJyn+/e00wc5WntWtW/Wbo=;
        b=lONXGA0Oa94we1VM7SSu7upm24Oh6HuikccFcEH52YRtWEe8CoVmmJw6AlYuEhyklh
         GhsqRocP4eFVQvD8NknHWpsvJ20dKMNLUp8qwtWaozNM7OA2uVx9cz3ROUU1epoBvz9S
         07+zyYz+BjlojJI3SZUG4GbsjOnPHRpGMAUp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rmyIuGz4xgr5RGO7XFrd0kJyn+/e00wc5WntWtW/Wbo=;
        b=S50dV19x93xEV2jlw+4oNw8ZjY6tvPqSauvKTtIId3TwLawW/TWAQ2vF1TKlC8FSCr
         FbYvs4t06T2hHIjhz0+cELWfQt7LDyl4fn+4uBS4Yna2wXZy3xlz+w1ZkHI0d1NN1W2w
         KiK6zq0RFORPqcsI8Voq0aEKkgRw1oZYxBE4f/nmYSXzwbvTw4hh0aw9Fec/jW1YnMRn
         pg04UnHt+Zw6mV61+LArwR3/7rGXmSYgsWkDG+5JN7ZdiCeVJnsAmiBFHJEB26anoX1L
         YrMzMcu4mU+ZBNR+ejV/hhi2e01Qr8ZN3hGR3kEkI5wFtAuF/BgGRa2tqw/NLzGoWxvl
         UMYA==
X-Gm-Message-State: AJIora+ExAGBYX3bfNIJXI9SwiU1AMWTP6GCPIxkkkmFFO3BvN4YEgTH
        adAJdDB4IsGqC9i5brveWe+PvQ==
X-Google-Smtp-Source: AGRyM1s4Ik+wpzNwQpGqqCRJEELSjtoAI7uTiFsZlXwgvkaUnMOhJxHPZHTcNWqz5GJbIRFES3lg7A==
X-Received: by 2002:a17:902:988b:b0:16b:fae3:fcd5 with SMTP id s11-20020a170902988b00b0016bfae3fcd5mr7996093plp.109.1657134884659;
        Wed, 06 Jul 2022 12:14:44 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:a20f:cad4:2229:c6bb])
        by smtp.gmail.com with ESMTPSA id n9-20020a17090b0d0900b001ef8912f763sm7051714pjz.7.2022.07.06.12.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 12:14:44 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] drm/msm/dsi: Set panel orientation when directly connected
Date:   Wed,  6 Jul 2022 12:14:42 -0700
Message-Id: <20220706191442.1150634-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the panel orientation in drm when the panel is directly connected,
i.e. we're not using an external bridge. The external bridge case is
already handled by the panel bridge code, so we only update the path we
take when the panel is directly connected/internal. This silences a
warning splat coming from __drm_mode_object_add() on Wormdingler boards.

Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

This relies on commit 5e41b01a7808 ("drm/panel: Add an API to allow drm
to set orientation from panel") which is in drm-misc

 drivers/gpu/drm/msm/dsi/dsi_manager.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index cb84d185d73a..9333f7095acd 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -268,6 +268,8 @@ static int msm_dsi_manager_panel_init(struct drm_connector *conn, u8 id)
 		return PTR_ERR(panel);
 	}
 
+	drm_connector_set_orientation_from_panel(conn, panel);
+
 	if (!panel || !IS_BONDED_DSI())
 		goto out;
 

base-commit: 15b9ca1641f0c3cd74885280331e9172c62a125e
-- 
https://chromeos.dev

