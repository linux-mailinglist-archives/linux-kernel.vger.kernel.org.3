Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3768B5523A5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 20:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240588AbiFTSNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 14:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245301AbiFTSNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 14:13:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D83E1A387
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:13:39 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n185so6241788wmn.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+Bp4C6tHNEGnt3nH/cIgRCgYn49Fk+PkAiYN+Dhmk4=;
        b=Zejyg6E+FHLKxRKdaEVHf2AZnDX7ypJREPoEvt3q1fFl3poi2cMzNceoS2L5xfLnPb
         Hj+R732naG47N54mKP5MQpsSSUdgqOafOLptTfNnpGpubW05/fVMDbTQV+sMTeE5+PGP
         G1PtclC9DqxT26xSkM2/3RaxOLmFefPV37XUIQua/iSphifY21dvtzrbnCUZpiXg0N2n
         XHXPevhVP0+l851iCLc4EkMrnfLnwki+2xj71hWiMdp2ZVSD9hEm9rzWNJpCO9T6G8hu
         5SHb0+fboJV+3XgJVsDIf3OWHEYhAcr8JYttvJwxKMLyTDOEH0o0B+KvQ5EYF5l9zpIf
         8uQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+Bp4C6tHNEGnt3nH/cIgRCgYn49Fk+PkAiYN+Dhmk4=;
        b=HBi2/kghZtbu4LElw711RY2OgKQDLmlNuMa3DsOGUALSPDKxNwZ0QedRXiMu/BRfDz
         H0uFwIyuB2kKtbz0zhbDyQLP5+j+EPMyZ1FSrOb2wkKaP3v5ZR+iPyfG05oQHN2db8Lo
         IjkY81hIIpFrmbbvqMcpG71ZmDU8AgjmcOiXz/8PEHktF3gAYVv3ACEG2Du2BLhXGmAI
         4+zv/fJ8aN/+uec8bSCQoOXWZeyag+JnTX06wss6LeXyjmlfpcXbjii38HcCLt23HUNl
         vhPRJ7/pe1qBLwPnNzupFWsRFbAnBSu4aNylmoIcAHiNz6+5y60f8kB92oiWqtMav5qt
         sdJA==
X-Gm-Message-State: AJIora9AIGlZJX+DEPO+8VRMsngN/61MrRtEDB6tGxHk+PQwSJhy2LJ3
        6JvXU4LbLOxpu44NqVoH1Qeb/O3bB0I=
X-Google-Smtp-Source: AGRyM1uI4F8cjHPAFAwOIFBOoZgwystK4qPSTCHz/P/WvlP3vbn23eKdbUXeK8JyCxxGaxVhOGfXAw==
X-Received: by 2002:a7b:c389:0:b0:39c:49fe:25df with SMTP id s9-20020a7bc389000000b0039c49fe25dfmr25474259wmj.164.1655748818130;
        Mon, 20 Jun 2022 11:13:38 -0700 (PDT)
Received: from kista.localdomain (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id k20-20020adfc714000000b002103aebe8absm14006977wrg.93.2022.06.20.11.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 11:13:37 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, samuel@sholland.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2] drm/sun4i: Add DMA mask and segment size
Date:   Mon, 20 Jun 2022 20:13:33 +0200
Message-Id: <20220620181333.650301-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Kernel occasionally complains that there is mismatch in segment size
when trying to render HW decoded videos and rendering them directly with
sun4i DRM driver. Following message can be observed on H6 SoC:

[  184.298308] ------------[ cut here ]------------
[  184.298326] DMA-API: sun4i-drm display-engine: mapping sg segment longer than device claims to support [len=6144000] [max=65536]
[  184.298364] WARNING: CPU: 1 PID: 382 at kernel/dma/debug.c:1162 debug_dma_map_sg+0x2b0/0x350
[  184.322997] CPU: 1 PID: 382 Comm: ffmpeg Not tainted 5.19.0-rc1+ #1331
[  184.329533] Hardware name: Tanix TX6 (DT)
[  184.333544] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  184.340512] pc : debug_dma_map_sg+0x2b0/0x350
[  184.344882] lr : debug_dma_map_sg+0x2b0/0x350
[  184.349250] sp : ffff800009f33a50
[  184.352567] x29: ffff800009f33a50 x28: 0000000000010000 x27: ffff000001b86c00
[  184.359725] x26: ffffffffffffffff x25: ffff000005d8cc80 x24: 0000000000000000
[  184.366879] x23: ffff80000939ab18 x22: 0000000000000001 x21: 0000000000000001
[  184.374031] x20: 0000000000000000 x19: ffff0000018a7410 x18: ffffffffffffffff
[  184.381186] x17: 0000000000000000 x16: 0000000000000000 x15: ffffffffffffffff
[  184.388338] x14: 0000000000000001 x13: ffff800009534e86 x12: 6f70707573206f74
[  184.395493] x11: 20736d69616c6320 x10: 000000000000000a x9 : 0000000000010000
[  184.402647] x8 : ffff8000093b6d40 x7 : ffff800009f33850 x6 : 000000000000000c
[  184.409800] x5 : ffff0000bf997940 x4 : 0000000000000000 x3 : 0000000000000027
[  184.416953] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000003960e80
[  184.424106] Call trace:
[  184.426556]  debug_dma_map_sg+0x2b0/0x350
[  184.430580]  __dma_map_sg_attrs+0xa0/0x110
[  184.434687]  dma_map_sgtable+0x28/0x4c
[  184.438447]  vb2_dc_dmabuf_ops_map+0x60/0xcc
[  184.442729]  __map_dma_buf+0x2c/0xd4
[  184.446321]  dma_buf_map_attachment+0xa0/0x130
[  184.450777]  drm_gem_prime_import_dev+0x7c/0x18c
[  184.455410]  drm_gem_prime_fd_to_handle+0x1b8/0x214
[  184.460300]  drm_prime_fd_to_handle_ioctl+0x2c/0x40
[  184.465190]  drm_ioctl_kernel+0xc4/0x174
[  184.469123]  drm_ioctl+0x204/0x420
[  184.472534]  __arm64_sys_ioctl+0xac/0xf0
[  184.476474]  invoke_syscall+0x48/0x114
[  184.480240]  el0_svc_common.constprop.0+0x44/0xec
[  184.484956]  do_el0_svc+0x2c/0xc0
[  184.488283]  el0_svc+0x2c/0x84
[  184.491354]  el0t_64_sync_handler+0x11c/0x150
[  184.495723]  el0t_64_sync+0x18c/0x190
[  184.499397] ---[ end trace 0000000000000000 ]---

Fix that by setting DMA mask and segment size.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
Changes from v1:
- added comment
- updated commit message with kernel report

 drivers/gpu/drm/sun4i/sun4i_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 275f7e4a03ae..f135a6b3cadb 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/component.h>
+#include <linux/dma-mapping.h>
 #include <linux/kfifo.h>
 #include <linux/module.h>
 #include <linux/of_graph.h>
@@ -367,6 +368,13 @@ static int sun4i_drv_probe(struct platform_device *pdev)
 
 	INIT_KFIFO(list.fifo);
 
+	/*
+	 * DE2 and DE3 cores actually supports 40-bit addresses, but
+	 * driver does not.
+	 */
+	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
+
 	for (i = 0;; i++) {
 		struct device_node *pipeline = of_parse_phandle(np,
 								"allwinner,pipelines",
-- 
2.36.1

