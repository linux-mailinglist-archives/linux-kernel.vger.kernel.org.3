Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E5353FD0B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242605AbiFGLL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243022AbiFGLKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:10:32 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185748B0A3;
        Tue,  7 Jun 2022 04:08:54 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cx11so15378461pjb.1;
        Tue, 07 Jun 2022 04:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Po1Q5+6dI5yA4ldBgb2PF70K+bMXEwc5eVZhSQFEPLQ=;
        b=oGkUJxSiFWnEbzHhenRsTq1+Di2BTqEPtyQKOuzfE117dtISgEKhcUGbepRpqseLXc
         uDjuopqh2LIvIPWDRqkn3HtKKfO5WfoShBll48QLsqVtzwIG2CqplMMXW8kWt+77SMZz
         eUfInGS8fV+8vqasQ/gFjGTS7u4hQ4Z1Gw0R2Y1jzLfKm9MQSduAN5Csz1EseWH4Tv3u
         kTxulbf3f9SvFFo7VVjRTl9VDqktaI+zbxKnHuAeGK53bVfl7dPZpgqO1vNb4s74A+WS
         iWkQdPJDO8jOgwTbwFasvLepqmcno7hRXfXSzHI1OKITixe1XbMtaxn8/j1hneoXgDmh
         c0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Po1Q5+6dI5yA4ldBgb2PF70K+bMXEwc5eVZhSQFEPLQ=;
        b=7qKmQwv5pNaE7+NNzs0ABtNPCxVi7fS3XnefOUfeEIu58TP5vFF6EW128LwPA6Dv6H
         PEGEwMKCdAkCuGOv9ly3dEr9wIl+2u/RJKSVihZ4BFeqFn4LNqSTFVU3Rh88O2hbghaX
         hw5/42vvNUjoEgXt2V6G49/81TaNXIgJUSpjKVenZ6pIGXqkXnyZHX0ZE+mnBi4fZ7U2
         1bcmDc2gLzo6mN37cX6wjbYXMWltUHuZNQvpx2+KxLFr7KqZpk5v51Ks4HhxqvlX/W7d
         6TroS1Fs2Gi5RrNlgSkjAjYuVenlv3myxBQq8ezMJKjjJkR4MgxFy14YF9IaEUFFvUWP
         N1kg==
X-Gm-Message-State: AOAM533LNoTgzr9cd3r9oecMMIbzBKejmkA7ic5vsd3j0nDbrOr1fk+x
        SYNRZ6BacDPVkJUJbVFRQdE=
X-Google-Smtp-Source: ABdhPJyzMIIixx7LNlorf8GeSs9/oSuBiBElDRVrwCUcFan3ee56iXcevAaVtwW0gAdH+D0FOIGpsg==
X-Received: by 2002:a17:902:d58a:b0:164:f5d1:82e9 with SMTP id k10-20020a170902d58a00b00164f5d182e9mr28874742plh.3.1654600133569;
        Tue, 07 Jun 2022 04:08:53 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id i4-20020aa787c4000000b0051bc581b62asm10439542pfo.121.2022.06.07.04.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 04:08:52 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        David Heidelberg <david@ixit.cz>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Xu Wang <vulab@iscas.ac.cn>, Miaoqian Lin <linmq006@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/mdp4: Fix refcount leak in mdp4_modeset_init_intf
Date:   Tue,  7 Jun 2022 15:08:38 +0400
Message-Id: <20220607110841.53889-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_graph_get_remote_node() returns remote device node pointer with
refcount incremented, we should use of_node_put() on it
when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: 86418f90a4c1 ("drm: convert drivers to use of_graph_get_remote_node")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index fb48c8c19ec3..17cb1fc78379 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -216,6 +216,7 @@ static int mdp4_modeset_init_intf(struct mdp4_kms *mdp4_kms,
 		encoder = mdp4_lcdc_encoder_init(dev, panel_node);
 		if (IS_ERR(encoder)) {
 			DRM_DEV_ERROR(dev->dev, "failed to construct LCDC encoder\n");
+			of_node_put(panel_node);
 			return PTR_ERR(encoder);
 		}
 
@@ -225,6 +226,7 @@ static int mdp4_modeset_init_intf(struct mdp4_kms *mdp4_kms,
 		connector = mdp4_lvds_connector_init(dev, panel_node, encoder);
 		if (IS_ERR(connector)) {
 			DRM_DEV_ERROR(dev->dev, "failed to initialize LVDS connector\n");
+			of_node_put(panel_node);
 			return PTR_ERR(connector);
 		}
 
-- 
2.25.1

