Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F56853A124
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351423AbiFAJq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351433AbiFAJqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:46:53 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EB212AAD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 02:46:51 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so2503378pjm.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 02:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=INHYjrtzuqTmW29J42HX48K917nNuhGdGFIMxI84h6U=;
        b=LvoSbn8q477RrYSibfBveWnjpFmVPUg2kyylSMS3U9WKUzvZCOaAlljYZnNmB8h3IH
         KUfDjgnk6qR2j0EyxzpkDV27Lrn/h0xLPVTM/K48nLP97GkQUIcK/5Xj12qxQ980Pg5A
         F2Kp0FCwVJ89GKq2sYlijKOfjGgViTwvxvTj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=INHYjrtzuqTmW29J42HX48K917nNuhGdGFIMxI84h6U=;
        b=kOB8QFk88SMIpizIouykiF2ki1lYsdQiPZdk5korWy24r/mCknG33j58qeM4eHO2E4
         PTbTJeWxDL3Dh+5iT/ZXfYtCeGjhU1gx6cE0NsDUJ7+ZaMX5UTb6lwmbV+QAq8/HAKGJ
         kW/zYEIM9oJH+xMQZMHfrJbcY78+KlEkzcNIUp7ISog20tQOCaLfDPzxUutSVpQieEyj
         k217o5OTDxOrYRg7LnXZptEWhzgNSiuOpJh6DJjYv7msCAibemAtVOvYOHkT7Lu3hXjN
         uM76BdjEI+Pecrd3IFZvNSs9m51tg5GSq5gkI5FtHL4pXcifw22uMJM0c6bkBbUxf1se
         zO2A==
X-Gm-Message-State: AOAM533IKMH4aKMYITLUbbumfYXSEmP9rPZjMnpR4bsM2ir/MsHPVZPn
        h3u0wwS1zKlpDcAXzzrxywT09g==
X-Google-Smtp-Source: ABdhPJzmCwkp/oP9bNtMxaNhr0RDu6E+1BWrnv69WtPiA4cmKqDHhI/gba5a1xxURUe2vVmGy8TPkQ==
X-Received: by 2002:a17:903:22ce:b0:163:f186:f3f6 with SMTP id y14-20020a17090322ce00b00163f186f3f6mr11348483plg.59.1654076811040;
        Wed, 01 Jun 2022 02:46:51 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:dc30:e75c:ae95:f2d6])
        by smtp.gmail.com with ESMTPSA id x42-20020a056a0018aa00b0050dc762815esm1039494pfh.56.2022.06.01.02.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 02:46:50 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] drm/panel: boe-tv101wum-nl6: Implement .get_orientation callback
Date:   Wed,  1 Jun 2022 17:46:31 +0800
Message-Id: <20220601094637.1200634-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220601094637.1200634-1-hsinyi@chromium.org>
References: <20220601094637.1200634-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 1be150ac758f..0f1c9b685da3 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1516,11 +1516,19 @@ static int boe_panel_get_modes(struct drm_panel *panel,
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

