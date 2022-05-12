Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435D35248C9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351916AbiELJVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351928AbiELJVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:21:25 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813424EDFD
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:21:24 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n10so4606216pjh.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=trstv+pRRGZWnVg0+iN5UCLh2DdH9t4IV2sdILAbWVo=;
        b=KDQhOyYHM/ghyxsyYX2XznPNtfLuxQL/rD+vsMnBO34aYxBsr9ceM9eDUWXAMLJM1g
         9qJpLzk42GzZaBZbcgWUjy6LOebVHmF9bqI7MPkd/10lA1bpzvrEX45t8Y33GLQnbz1E
         4xjhKznHXiYyv4C74c+8dkaHPGwnM2Xr5nFisIkCTmppBiVXORiPXCaEqfAxG9UA6jiV
         iL9Ahrh/AabO+F2dHjvO1YsOn69pZxSPvrDoiSdzFVMIhkAU5/Q6mldf5ISJuihXbdN9
         8ApW3DsCjYYcUVvQ+vqQFrvDS6DEiNcNP1oYqHta/uiDkShGesbOpsU+nrVUkSoMHASh
         qtag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=trstv+pRRGZWnVg0+iN5UCLh2DdH9t4IV2sdILAbWVo=;
        b=nApqMUj1j3IWmAVaddmUUD+YTLhe+eHE9Znu/tcDM6Zd5SvhyT2kGNlTDPcPVjRAIT
         rUB7t87M7GK8QD2SFE3gXOiGo+zSSGzYszZYpSs8GiVyqPzeQ8HCyaEqriBWoY7QBttG
         lS4vVdBrmGaC3BEWyCtjBi9dfECRzHj2ATdsMVX/xcbvD1E/fhCY97HH6MZp9oC1bZ/O
         /0VvJEVRGNcbXoa4cxLIj73LbML4k7QrJqFpcNXVb9Hhsg8XZ/u860WNKg2HeNY2tLnI
         F0ztBqP8pfOMeOEoWAb6wsP38AV9rJZkOhilDez+q/Fa7ZQKihv9ouVXLPoU4Ga1MXln
         fzrg==
X-Gm-Message-State: AOAM530tBV893aGmqOYBBmO6p7gFedyNIcLHQjRq2jDRi7h5MeRPmEpa
        8H4EW5vEKJvdxUjfQkDUGo8=
X-Google-Smtp-Source: ABdhPJzZwN6t9mhBq0vhDH0XiM6VYuy8GmDZ2wYMYQ05gapLnZQ2or//JNGRUEmvLf3VxVplWrAO8w==
X-Received: by 2002:a17:90b:1d82:b0:1dc:ba02:52a0 with SMTP id pf2-20020a17090b1d8200b001dcba0252a0mr9773736pjb.246.1652347284037;
        Thu, 12 May 2022 02:21:24 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id gj9-20020a17090b108900b001cd4989fedfsm1336874pjb.43.2022.05.12.02.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 02:21:23 -0700 (PDT)
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
Subject: [PATCH] drm/meson: Fix refcount leak in meson_encoder_hdmi_init
Date:   Thu, 12 May 2022 13:21:13 +0400
Message-Id: <20220512092114.38426-1-linmq006@gmail.com>
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

of_find_device_by_node() takes a reference to the embedded struct device,
we should use put_device() to release it when not need anymore.
Add missing put_device() in error path to avoid refcount leak.

Fixes: 0af5e0b41110 ("drm/meson: encoder_hdmi: switch to bridge DRM_BRIDGE_ATTACH_NO_CONNECTOR")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/meson/meson_encoder_hdmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
index 5e306de6f485..de87f02cd388 100644
--- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
@@ -435,8 +435,10 @@ int meson_encoder_hdmi_init(struct meson_drm *priv)
 		cec_fill_conn_info_from_drm(&conn_info, meson_encoder_hdmi->connector);
 
 		notifier = cec_notifier_conn_register(&pdev->dev, NULL, &conn_info);
-		if (!notifier)
+		if (!notifier) {
+			put_device(&pdev->dev);
 			return -ENOMEM;
+		}
 
 		meson_encoder_hdmi->cec_notifier = notifier;
 	}
-- 
2.25.1

