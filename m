Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3995AD693
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbiIEP3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239181AbiIEP2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:28:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F012861DA4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662391669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0y/a4pTSF6VtadOpwMNTC/mvZDJbVIcTrD8TXNTMH9w=;
        b=AxMSfgwvYietlsuY/+o2r43BJIto4+6mKjgNmTt4MiPb06PIu9vh5wrKAMHVgGlzVJmYQN
        CiQg1xxKqMbUAxtUyds/2VGXN5w7tgz5MKiSrCR9TZDOE97+FYaCDLduZlk80cxcmArlHq
        XXlqBygLpu2hBbASzcPxDusNfcPmXA8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-616-iFf_uNHPO9uuw-G_iv3ICw-1; Mon, 05 Sep 2022 11:27:48 -0400
X-MC-Unique: iFf_uNHPO9uuw-G_iv3ICw-1
Received: by mail-ed1-f70.google.com with SMTP id l19-20020a056402255300b0043df64f9a0fso5997361edb.16
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 08:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0y/a4pTSF6VtadOpwMNTC/mvZDJbVIcTrD8TXNTMH9w=;
        b=iFFO+xVq1WKwAHMq1vs6iBgYTtGthT/vxMjfrp2OU3rx6xDfeApNOfiRXlDT5y0WIU
         Fsh+lYBvmfV2SNMFWyqKfnp3M69tReTDjcK7reG5/zwCTLsMO5f6h68gIhx2OvyTk3bK
         BdZMoGM+QRr74LsOlvQ9dLc4wnUVe+d2zwprD2ODJxcJwAOsfpZ+HbabVhWcmmZ5ETOh
         xyMC7jr2ohbXvaXj7fSth6d9uX2OPoBrmBp93e6uIij0NzMg9PerpoOc2SlFm7CtjQh5
         HcPN7Siw2fInWjqgOS+chwUqWO/56AaPmgwp7VmwvNBYRE5+faGuRd0gN4VIRQan6GoO
         HEdA==
X-Gm-Message-State: ACgBeo3K/JVe+cXQH0vnwWKuWzb+jFF+UZwswmeBcKh1/G30c/0MR2Z7
        oDWd1XGX4/BR/hYbEV03plcgVnSlj16mBtr/OdqmX5yPlgF19e2XuBFXtipNFNcwaJCUGCXb2eN
        4HUk0tJmsC1GcX+0JUudrreNl
X-Received: by 2002:a17:907:2c44:b0:741:5173:8082 with SMTP id hf4-20020a1709072c4400b0074151738082mr27811201ejc.428.1662391667248;
        Mon, 05 Sep 2022 08:27:47 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6KUF8JbNYhrJVPVL+fNpO9wlbYaKNx1Fi+IP83CtCcvsAKUfVUGf8JgD4mpG+Mk8t00cPgUg==
X-Received: by 2002:a17:907:2c44:b0:741:5173:8082 with SMTP id hf4-20020a1709072c4400b0074151738082mr27811186ejc.428.1662391667099;
        Mon, 05 Sep 2022 08:27:47 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id b10-20020a056402138a00b0044e81203bebsm2338949edv.31.2022.09.05.08.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 08:27:46 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND drm-misc-next 7/7] drm/arm/hdlcd: debugfs: protect device resources after removal
Date:   Mon,  5 Sep 2022 17:27:19 +0200
Message-Id: <20220905152719.128539-8-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220905152719.128539-1-dakr@redhat.com>
References: <20220905152719.128539-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Hardware) resources which are bound to the driver and device lifecycle
must not be accessed after the device and driver are unbound.

However, the DRM device isn't freed as long as the last user didn't
close it, hence userspace can still call into the driver.

Therefore protect the critical sections which are accessing those
resources with drm_dev_enter() and drm_dev_exit().

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/hdlcd_drv.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index e41def6d47cc..020c7d0c70a5 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -204,11 +204,19 @@ static int hdlcd_show_pxlclock(struct seq_file *m, void *arg)
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *drm = node->minor->dev;
 	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
-	unsigned long clkrate = clk_get_rate(hdlcd->clk);
-	unsigned long mode_clock = hdlcd->crtc.mode.crtc_clock * 1000;
+	unsigned long clkrate, mode_clock;
+	int idx;
+
+	if (!drm_dev_enter(drm, &idx))
+		return -ENODEV;
+
+	clkrate = clk_get_rate(hdlcd->clk);
+	mode_clock = hdlcd->crtc.mode.crtc_clock * 1000;
 
 	seq_printf(m, "hw  : %lu\n", clkrate);
 	seq_printf(m, "mode: %lu\n", mode_clock);
+
+	drm_dev_exit(idx);
 	return 0;
 }
 
-- 
2.37.2

