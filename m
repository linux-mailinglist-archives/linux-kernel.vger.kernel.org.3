Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F167539357
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 16:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345333AbiEaOts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 10:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345299AbiEaOtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 10:49:47 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA2E1EAFF
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 07:49:46 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id e66so13045871pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 07:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ceYIzlL/twTH8Sr59LajLbKK1xxBDxgWw7CtT5vS84w=;
        b=K0S/p3jRO0pqQZ0yw9hdVvC9iMKHlzc6CLAZtSMin3YKcxUYUj0ek3P+WGYNxDZl/h
         9azmVFZ0uzK8PCDufF/Gjw66qtxTwQqzJdFJuIxxWUxF8ww4bqrf15X+U13iBBErU1fp
         DX3oH+7ABnJSlbwItxycWDd41+OPp8j+1cKrlbFn39i5y4pgUCwGq499xs8oPoiRbGv/
         bwfjPX/feLbTjyI0TiFgnStzne1oJOBmjMLEgxGWTeffJ/3xpVBhg6lwr/qhOoGdjBWq
         JqCwX0CVSpdiZWifOYpTuacvZTwYd6lwx9r5/r0M8zr3ltCWRlJ2SukjjgtidI0y2BYS
         Zzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ceYIzlL/twTH8Sr59LajLbKK1xxBDxgWw7CtT5vS84w=;
        b=CDcNprzopwgzd3GPx+nYt6wE9mcUF2OyL0FG60nl1TuwoXCvczXIJwAuGv9ydaRrSu
         j4gYPacsmf4c3P05xuc88utAFyOygMhWC9aHad89yHoZoD5nshGeo/QhGZFeZbSb+OVT
         J0IoDWfh9IO9kiGFGD44F4DXTGXBVwPSHQVx/gKVCDrm0Fj+sCETASp3mHOMjsEsqLVk
         OjUvUdJNH+gnUyeclorLqT7rg3gyb6kqAlsFOWtD4f2hNY6rohbsPTMJwNUU01KlRrFc
         7PYip83YuviQWRPBDwGx+gCOG9tKA3RDKOsAjm3igfOizH8Idb1joKoP9lzkBo3LK7Xm
         gtHA==
X-Gm-Message-State: AOAM530hp2yWZyEPFh6Y8fSDvXce5AKOKCA0dA+RUpLkLhgTlc94Hkl7
        mRdNNBGCA68K4aEBoNwt5E4=
X-Google-Smtp-Source: ABdhPJzDSi4itj4Z6llVe4OArFqnAITyU34dFBtLDFQN+cm+fuixe6WVqtcPuXnd4vYgLmf0MRQtHA==
X-Received: by 2002:a63:ef4e:0:b0:3f9:e8c4:b72d with SMTP id c14-20020a63ef4e000000b003f9e8c4b72dmr42409832pgk.328.1654008585955;
        Tue, 31 May 2022 07:49:45 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id d3-20020a17090a8d8300b001e2d4ef6160sm2007215pjo.27.2022.05.31.07.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 07:49:45 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH 2/2] drm/meson: encoder_hdmi: Fix refcount leak in meson_encoder_hdmi_init
Date:   Tue, 31 May 2022 18:48:16 +0400
Message-Id: <20220531144818.26943-2-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220531144818.26943-1-linmq006@gmail.com>
References: <20220531144818.26943-1-linmq006@gmail.com>
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

of_graph_get_remote_node() returns remote device nodepointer with
refcount incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: e67f6037ae1b ("drm/meson: split out encoder from meson_dw_hdmi")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/meson/meson_encoder_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
index 5e306de6f485..f3341458f8b7 100644
--- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
@@ -363,6 +363,7 @@ int meson_encoder_hdmi_init(struct meson_drm *priv)
 	}
 
 	meson_encoder_hdmi->next_bridge = of_drm_find_bridge(remote);
+	of_node_put(remote);
 	if (!meson_encoder_hdmi->next_bridge) {
 		dev_err(priv->dev, "Failed to find HDMI transceiver bridge\n");
 		return -EPROBE_DEFER;
-- 
2.25.1

