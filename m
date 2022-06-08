Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F70542C93
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbiFHKGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbiFHKFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:05:44 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D75612F0CD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:48:29 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f65so8208650pgc.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 02:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W5IKfgYz5xf2GI+6lvPe+62g09BBcgumm5yF5o1+Nx4=;
        b=FQ7vGEL7CIyuMkUWz69rqKrfbSKqncuXS8hn3qh8zQiCYfyqiMehg/B+6gdS5GARXc
         ui9CaQ7f77yeRz7RY/Zsh7ogBiuv7UkxPXGf8AbJYk/iYQ6T/2ylrotouKqEowLpbmeo
         JdnYEyK/8LRszk3diG3Wrg1lqdPFcK30T8wZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W5IKfgYz5xf2GI+6lvPe+62g09BBcgumm5yF5o1+Nx4=;
        b=HeHuMC5xMUY65Xs9hvM79F+slnvLJpRjewn3q3tubX6sYtvNJGpzzhxICb73/KzTEN
         6yK1QF8XGmMeUmnAZTEonA9SSYIZmcsL+OEX4KYuDZyRy0UE64/rA/PWxLYEQJ9/tcJN
         8oSkjXjV3tWw0foAYWWDQuoQHHLrrgoTFpVh87NVjBIHKEukK8IspIxrXkPmDHn4fxnh
         fR+xKg//EFWbMJJS1TzmKKdy2y5Ui6H1E95UKM57wq/+iUsIROIFfEjHJRlWXB8JYeN8
         bYXOGmMTTWiBmJu9bpegD3oBmegUN5SstaoMD1bLF6MhbvHoa8wmeYrl//RU5e0T5tP/
         gaTw==
X-Gm-Message-State: AOAM533zkLjTtfgGN6KqyGK8C7Rhu3NkeJSrVw9A32W2ezUo9ees51//
        4qaLLRAp1Rh2v6kFV2rD9jxb0w==
X-Google-Smtp-Source: ABdhPJwY10X54qkCemGXIJKUyFcIOP4JABpqefy/KV0RlOOHwUX0S+RhW7c3RXQRcQoGKn5AVKPZbw==
X-Received: by 2002:aa7:85d1:0:b0:51b:f4b5:db7b with SMTP id z17-20020aa785d1000000b0051bf4b5db7bmr21661005pfn.41.1654681708744;
        Wed, 08 Jun 2022 02:48:28 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:c46b:e7b1:f6c8:5eb8])
        by smtp.gmail.com with ESMTPSA id t10-20020a17090a950a00b001e28e80a8d6sm13584038pjo.38.2022.06.08.02.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 02:48:28 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/8] drm/panel: boe-tv101wum-nl6: Implement .get_orientation callback
Date:   Wed,  8 Jun 2022 17:48:10 +0800
Message-Id: <20220608094816.2898692-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220608094816.2898692-1-hsinyi@chromium.org>
References: <20220608094816.2898692-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To return the orientation property to drm/kms driver.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 1be150ac758f..07f722f33fc5 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1511,16 +1511,28 @@ static int boe_panel_get_modes(struct drm_panel *panel,
 	connector->display_info.width_mm = boe->desc->size.width_mm;
 	connector->display_info.height_mm = boe->desc->size.height_mm;
 	connector->display_info.bpc = boe->desc->bpc;
+	/*
+	 * TODO: Remove once all drm drivers call
+	 * drm_connector_set_orientation_from_panel()
+	 */
 	drm_connector_set_panel_orientation(connector, boe->orientation);
 
 	return 1;
 }
 
+static enum drm_panel_orientation boe_panel_get_orientation(struct drm_panel *panel)
+{
+	struct boe_panel *boe = to_boe_panel(panel);
+
+	return boe->orientation;
+}
+
 static const struct drm_panel_funcs boe_panel_funcs = {
 	.unprepare = boe_panel_unprepare,
 	.prepare = boe_panel_prepare,
 	.enable = boe_panel_enable,
 	.get_modes = boe_panel_get_modes,
+	.get_orientation = boe_panel_get_orientation,
 };
 
 static int boe_panel_add(struct boe_panel *boe)
-- 
2.36.1.255.ge46751e96f-goog

