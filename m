Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C45E5A5D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiH3HfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiH3HfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:35:07 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CC73ED75
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:35:04 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y29so6466851pfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=fO2EnFJGzG6t/nL9IambfctgthnkaId3/4iEgLm8L2A=;
        b=hOO+72gvpKXcAS+/rsk4FADNO6DztmuhbQXbhId235N/XLKv0GYHSTB+3yawRXSDYo
         2UizYS01o+vi/yNOLO2IWmJY0Dgp+5APxNUrvqz6k0EmMCj0/Rp1ss5G5Ahbo2O9+i67
         dJEorYvWPtHEFw0ZijS7+3dBMz+ibiVDtO9aDYDs6w0V8GGaTc/r58wmkP22euZXRDiv
         ieO7DGiHPtit9L/zfECwST3Jhraj4vLtfgMt6O2958qkJsGS5X3UA9ievMlWtdHRB0Nn
         2MANuUmMFRqNaVdQJyKyiHxvXPrXKrxXXNaAkyoPB2WIowDfVSdMCKuiA+oKvJ5FxF++
         DPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=fO2EnFJGzG6t/nL9IambfctgthnkaId3/4iEgLm8L2A=;
        b=U3vqIOYGdQOoxdVK54GbEuLCIUP+qJFdf91TlRpAT2xYG+lnDcp1RMX2pB4+Oq1EHT
         Wrh8VUZMFDtF8n9Ykh5qtfAn1dQMwvzgXS+xNuDS+ZO2y+j6JWhdnK96TwEx9zL7OA9c
         wjAFtIcbh4fdhg0shTpNxz7MZBz4fyZsMwIAu6cp5fwc1LXdqGCL7H+zI9HUsk/90wxY
         zdXejpqnVSc1n2JYvMnfll8jDLtkY7wDRB0CeTgC0bCO0wJ0+IQrvv143ZRGGrG1/lct
         rLl3Sd/L+5P8jr1UgXakMJ4asueUQQyhtu6Iia9vGfsVXraHNRIGVh0VOgJgINro5hmS
         205w==
X-Gm-Message-State: ACgBeo3BAtGJhV6/ROWI8515oHMdad/7GoNmGvZK0gYdaU0wLByPeXTu
        C53YYLZC7s42xCS6zrs8rCSNXt6qqGrIVNY=
X-Google-Smtp-Source: AA6agR6duJPXZKEM8gxLlfvdmsYqtYzBmyHMVV/NxX55Z9HC/9eQtXc1pBqmLGtxLK8suQGSUZ4yfA==
X-Received: by 2002:aa7:8b44:0:b0:537:a35d:3c11 with SMTP id i4-20020aa78b44000000b00537a35d3c11mr20037734pfd.76.1661844903771;
        Tue, 30 Aug 2022 00:35:03 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id e2-20020a17090a630200b001fdcfe9a731sm3157522pjj.50.2022.08.30.00.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 00:35:03 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     peter.senna@gmail.com, martin.donnelly@ge.com,
        martyn.welch@collabora.co.uk, andrzej.hajda@intel.com,
        narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v2] drm/bridge: megachips: Fix a null pointer dereference bug
Date:   Tue, 30 Aug 2022 15:34:50 +0800
Message-Id: <20220830073450.1897020-1-zheyuma97@gmail.com>
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

When removing the module we will get the following warning:

[   31.911505] i2c-core: driver [stdp2690-ge-b850v3-fw] unregistered
[   31.912484] general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
[   31.913338] KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
[   31.915280] RIP: 0010:drm_bridge_remove+0x97/0x130
[   31.921825] Call Trace:
[   31.922533]  stdp4028_ge_b850v3_fw_remove+0x34/0x60 [megachips_stdpxxxx_ge_b850v3_fw]
[   31.923139]  i2c_device_remove+0x181/0x1f0

The two bridges (stdp2690, stdp4028) do not probe at the same time, so
the driver does not call ge_b850v3_resgiter() when probing, causing the
driver to try to remove the object that has not been initialized.

Fix this by checking whether both the bridges are probed.

Fixes: 11632d4aa2b3 ("drm/bridge: megachips: Ensure both bridges are probed before registration")
Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
Changes in v2:
    - Alignment format
---
 drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
index cce98bf2a4e7..72248a565579 100644
--- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
+++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
@@ -296,7 +296,9 @@ static void ge_b850v3_lvds_remove(void)
 	 * This check is to avoid both the drivers
 	 * removing the bridge in their remove() function
 	 */
-	if (!ge_b850v3_lvds_ptr)
+	if (!ge_b850v3_lvds_ptr ||
+	    !ge_b850v3_lvds_ptr->stdp2690_i2c ||
+		!ge_b850v3_lvds_ptr->stdp4028_i2c)
 		goto out;
 
 	drm_bridge_remove(&ge_b850v3_lvds_ptr->bridge);
-- 
2.25.1

