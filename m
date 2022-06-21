Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57D7552BBD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346303AbiFUHV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345963AbiFUHVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:21:22 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4140A22530
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:21:21 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id cw10so1784159ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ujXg7tbiFKFG9Xv1lpmXMbIqHNMRftScv0fuP2to1p4=;
        b=mR7SSvzxKBsVGWmW7rKMKm11PMO2JzWQjOvgSCKOXzUg76jvtygFg5Ko/iBLe/V5YM
         qEnz0PtDiVTbLZx2GOQDDGhJuxgco2xipCkiF1Snhg/1/sGCA9d8964K1JqVJG1d5gyi
         XBubX7jmbgcsPTuJ+Ll442ofRMaJoAwFI5nyCTm1Cw+XnTgZms5IVuJA/brnu1jG5XyA
         XvKRmT9CSL/9+Xziz1C5p63hIIuZSayprT+g1+uLzd+TJrhW30vVobsB1qZJnYf6XFIN
         c9E2RkMqxJwoROp9op4RIbSwNQfOZ47tSX74h3knzx2GIQNdn24NvgRGIFzWqP2oAjE9
         fXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ujXg7tbiFKFG9Xv1lpmXMbIqHNMRftScv0fuP2to1p4=;
        b=W1o74Mdt771ovfRg7zPjNUAvcje9lJKnxMR+m9xV5e2IsaRLwsAl3O9skAbQOVRQlY
         Df4BR3/+At5GViQ3ndpaPu6Z/tf+v9XSCAWoYLxnOApA2OCpAXahFaS4prT9NmLI1eqr
         xeQaqetk+fRENln2IBTvWdYJug47K7E70qyIJZ8VF5iHoAD79tTi8SA8zkfHMDad2HRl
         yJ0sA3ic8Lo8J3gKGIPyBJKZkv9DXHN6oKZbWFuyg9GZuI4egeRDydXYnUMTu7dFgFZS
         UuBXEARgPXKnNbEAK136fChNsvQyzi2XErYUQrjZ/qFu1JNM4JnLs+9kFcWkS+YcDsNf
         CzGg==
X-Gm-Message-State: AJIora8S20L8qGpZdC+rqvCZ48hqtcBkODJ9FVgUAzWcAAl0vNYf8mvU
        ZO5+gjCMZKTkvHmFPEyG+W30+GvZWP4=
X-Google-Smtp-Source: AGRyM1vCyhurjoTwHqtO0qcT9zB5pBmZ/2iCYJki53eJ3YCFskGqaVpFKRg+a2h4X0orIH6PALuMag==
X-Received: by 2002:a17:907:7daa:b0:720:b3e1:12b7 with SMTP id oz42-20020a1709077daa00b00720b3e112b7mr14304301ejc.11.1655796079661;
        Tue, 21 Jun 2022 00:21:19 -0700 (PDT)
Received: from localhost.localdomain.info (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id p1-20020a17090653c100b00722e771007fsm50711ejo.37.2022.06.21.00.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 00:21:19 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        etnaviv@lists.freedesktop.org (moderated list:DRM DRIVERS FOR VIVANTE
        GPU IP),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR VIVANTE GPU
        IP)
Subject: [PATCH v2 3/4] drm/etnaviv: show loadavg in debugfs
Date:   Tue, 21 Jun 2022 09:20:49 +0200
Message-Id: <20220621072050.76229-4-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621072050.76229-1-christian.gmeiner@gmail.com>
References: <20220621072050.76229-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Might be helpful to see the loadavg in debugfs.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 202002ae75ee..113faff9b02e 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -926,7 +926,7 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu, struct seq_file *m)
 {
 	struct dma_debug debug;
 	u32 dma_lo, dma_hi, axi, idle;
-	int ret;
+	int ret, i;
 
 	seq_printf(m, "%s Status:\n", dev_name(gpu->dev));
 
@@ -1044,6 +1044,16 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu, struct seq_file *m)
 	if (idle & VIVS_HI_IDLE_STATE_AXI_LP)
 		seq_puts(m, "\t AXI low power mode\n");
 
+	seq_printf(m, "\tload:\n");
+	spin_lock_bh(&gpu->loadavg_spinlock);
+
+	for (i = 0; i < ARRAY_SIZE(etna_idle_module_names); i++)
+		seq_printf(m, "\t %s: %u%%\n",
+				  etna_idle_module_names[i].name,
+				  gpu->loadavg_percentage[i]);
+
+	spin_unlock_bh(&gpu->loadavg_spinlock);
+
 	if (gpu->identity.features & chipFeatures_DEBUG_MODE) {
 		u32 read0 = gpu_read(gpu, VIVS_MC_DEBUG_READ0);
 		u32 read1 = gpu_read(gpu, VIVS_MC_DEBUG_READ1);
-- 
2.36.1

