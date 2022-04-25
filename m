Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B2550DC54
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbiDYJWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiDYJWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:22:16 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065ED24080;
        Mon, 25 Apr 2022 02:18:41 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id v2so3199739qto.6;
        Mon, 25 Apr 2022 02:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c3DGZK5DUQkJKoG1zq/bxgy9gvzlprZtCF4qarINkuM=;
        b=mtp/DXIrhnVz/pLfkYQB5MdLNeGrEdBvnkDNvJkZUFa9Y0esmOj0owxut/Kk26hO3B
         RsMmoVB6nrDBIwAG6LSDS8NUHZkzwDELdgXznUpF1FY2uMJGylRSBzYFc8pIvjwmuOyf
         cfapt5EubqdRJH6ctJeLD90l7YdW5unwIeldh3BswN+y/6lDghhkOIfMv4kqmQozPgHm
         U0LpH/UCUwOnoh6JnHGh6WCtKx6RpnpQHM55lUHC7wkBugT3EjMMcKXZ96fVzpWEmp9W
         qI9WqppV/GGVV7LUaY/Aj1I6NAyxzwE4oWhjv/3NDu5EuwJW0ujr8G8xw0edR+DVucGP
         W5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c3DGZK5DUQkJKoG1zq/bxgy9gvzlprZtCF4qarINkuM=;
        b=s23o8ttbyXUrH6AZ7cV+YxzNC6VLNleFcpwi9BFe2uPPbvJ0CNV4eFVkS3vfF4YM9t
         ZoEmK6CrzEGG7zCY49aZprwc8B7cj2AAMA3vp04ux9bumUW6G8N+MC+Fp4cZm8ABwgIx
         7MdcEdANlef10lz97drUoj+6X9xWs7xIPIXmxGRhgu2UGAC/crbMt4Z4rBelZf9yIVrk
         WIr71HFkiT7bf+RKs4CfSenFBRm/QaCmgMFDx07wtNP4qyabMa7l7gN1jvRMrU7KsxmO
         NICRmxkRm5BKON/xhCvobzWWmNh9HPJEyepYE8kh4iSj7aGEFUGRuOoOZRUMqxba43HH
         vEFg==
X-Gm-Message-State: AOAM5325vzhPkUzmjXgEgqAryw7v5VJqXUu6IhavjX0y7m6+VRh4HJTR
        QiDaQ4FkWMzOjQc1R8Pr8FQ=
X-Google-Smtp-Source: ABdhPJySq8HdV/v++Aqw4NLLiOBRDiQu9mv8AeH8tmM6FwSF/kC2yWt97V5SHtW1stLpGSnViUZ3gw==
X-Received: by 2002:ac8:5905:0:b0:2f3:677a:efaf with SMTP id 5-20020ac85905000000b002f3677aefafmr2995920qty.83.1650878320204;
        Mon, 25 Apr 2022 02:18:40 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m4-20020ac85b04000000b002f363eccb2csm3416405qtw.89.2022.04.25.02.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 02:18:39 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     sean@poorly.run, quic_abhinavk@quicinc.com
Cc:     robdclark@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, swboyd@chromium.org,
        angelogioacchino.delregno@collabora.com,
        daniel.thompson@linaro.org, linmq006@gmail.com,
        christophe.jaillet@wanadoo.fr, lv.ruyi@zte.com.cn,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/msm/hdmi: fix error check return value of irq_of_parse_and_map()
Date:   Mon, 25 Apr 2022 09:18:31 +0000
Message-Id: <20220425091831.3500487-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

The irq_of_parse_and_map() function returns 0 on failure, and does not
return a negative value anyhow, so never enter this conditional branch.

Fixes: f6a8eaca0ea1 ("drm/msm/mdp5: use irqdomains")
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/gpu/drm/msm/hdmi/hdmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index ec324352e862..c3b661c2932d 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -298,9 +298,9 @@ int msm_hdmi_modeset_init(struct hdmi *hdmi,
 	drm_connector_attach_encoder(hdmi->connector, hdmi->encoder);
 
 	hdmi->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
-	if (hdmi->irq < 0) {
-		ret = hdmi->irq;
-		DRM_DEV_ERROR(dev->dev, "failed to get irq: %d\n", ret);
+	if (!hdmi->irq) {
+		ret = -EINVAL;
+		DRM_DEV_ERROR(dev->dev, "failed to get irq\n");
 		goto fail;
 	}
 
-- 
2.25.1

