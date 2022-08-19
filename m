Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93C859A93C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243812AbiHSXLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243682AbiHSXL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:11:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ECAD5DEB
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660950680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0y/a4pTSF6VtadOpwMNTC/mvZDJbVIcTrD8TXNTMH9w=;
        b=e4sUl5rhbcDtgpuKtwGdwId8WiJHqNZEe3aWFrcnsBqI5QvP9XKWtSyUijHVnUfQwvA3ON
        NlmAKv1+ynauy/ZXxp86DYWTGQYtbEkvu9pOvGVGGVNeTEmS9wTLtKdEOqBa8JuuJhvbwr
        ohKkn4vW+A8RJgwcBcob4xWHZu5bucQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-360-b6xnA5ofMZWPN1goblxMEA-1; Fri, 19 Aug 2022 19:11:19 -0400
X-MC-Unique: b6xnA5ofMZWPN1goblxMEA-1
Received: by mail-ej1-f72.google.com with SMTP id hv19-20020a17090760d300b00730d0a018a6so1982635ejc.21
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=0y/a4pTSF6VtadOpwMNTC/mvZDJbVIcTrD8TXNTMH9w=;
        b=4sLZhWBZ3dHhNZ3dCNaj907eD5UXWu04unHC8ZvkB/uZQMjyWPKY/e34LJX9YsyjMe
         o+FCL8lpb3tDPktMzYsap+28NW9apMmpxXkebf2s7WBYX+De1BTf2eMDR9FjJsfOsTXV
         n3oiLxSVLfiId5UxtXYHBbntJHEoN4ZgzyqKFpu0kyPidcftpjD03D41w6YIv/HrhwEN
         nKBoQwAeU4PndcExlyGDFJl1oMNgKuyJEq+1MrKKgZlhgss9V00q0BeYOV/UVKQgV9J4
         saogB4ARARaezGWe19mCKnsT1bbsAheNQ1SSIoavok3gTYlehgZVJInWHp/1Fx9drxVt
         O0EQ==
X-Gm-Message-State: ACgBeo13EA+YA9wz5DoH+MIjfm+dukRrzWpkdEscnJdGWbe8b6KdlhKN
        Jph52beYHYFvwgMxTFW7yipX7EgD3OvIzfGHzw2XRWyh+IDpvGePJIc5HdkbbZKv6LQPCqUNAgW
        dFdxumTCG8wKX1+HszKDw51Rd
X-Received: by 2002:a05:6402:2714:b0:43d:ca4f:d2a2 with SMTP id y20-20020a056402271400b0043dca4fd2a2mr7764355edd.185.1660950678519;
        Fri, 19 Aug 2022 16:11:18 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5t8ZWTVk4y4Y4BTXVKS9pOWxmu4s8KtL9YowyUh5bjRrc9ssHwXdvbPAqefLHaOgjt3XLApA==
X-Received: by 2002:a05:6402:2714:b0:43d:ca4f:d2a2 with SMTP id y20-20020a056402271400b0043dca4fd2a2mr7764349edd.185.1660950678398;
        Fri, 19 Aug 2022 16:11:18 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090694c500b00734bfab4d59sm2923078ejy.170.2022.08.19.16.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 16:11:18 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 7/7] drm/arm/hdlcd: debugfs: protect device resources after removal
Date:   Sat, 20 Aug 2022 01:10:58 +0200
Message-Id: <20220819231058.647658-8-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819231058.647658-1-dakr@redhat.com>
References: <20220819231058.647658-1-dakr@redhat.com>
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

