Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5780D494796
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 07:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbiATGpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 01:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237587AbiATGpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 01:45:31 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB96AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 22:45:31 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id x37so538900pfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 22:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecs-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=M7J5tzZZVmeA1P0cwSulRKeIAGlLrTXUVBwKsO/DNQw=;
        b=eBnTE6KboIcUgSDDHcRQhY2E71dW8BbaqtL3pUmTx2vZPBStcEcsZkn6A9deXugJr2
         9n/Vzusq3cNbE1mzKZgorVOsPiQvyTafYqvPVffslRVClVIOvBjOuEuSMcv2eSkg47+G
         +JCmxKeABWTOzOg+THVBInMstvKXX/VaLyupe+C0EuZ5tzAskH9iUFr4g+fOMppc6J7L
         LtK8rwkLS0+yd1fu5SWPuBD2NlsQjNK5Os/je79glzOJ3ctqxFPVoWtVF15UYf0xkFBh
         b4IXeTWwExPYk+VbyCn9H9uiYWwLOGUrYy7n+duiG5ZAvnXPrRJCI5qUQsJ0r2vyTJm8
         7buQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M7J5tzZZVmeA1P0cwSulRKeIAGlLrTXUVBwKsO/DNQw=;
        b=YcFjgN/YfPM2vmUtxMUYHpzwI93RNQUPLiK2ogNph3vggTYoYmDfv9M5ThZ3lN9O2R
         dKrvcCmJjMoPKG1SZBcxlhqMMvB/XEdZ65cNX2KUZdJBRd0RklGFxrdjpq1VtBQsOsPr
         7E9O57sJcvuImvtTZRC0Ig/s81hmx9OkbmJswpPUl2yRsfYwcgfgFzf9F7khmEeeQZ50
         VLYn4X0LeBZVUWjsr3NsuF97ZQtHu2n/PoQuB3gdpwrHzATvPI1u+DFXdFf/D0xXV+Xc
         NfFOezZ7ZKW2yKx6HRqoiQqCp3DGFlakWQPVyvJPuU1IHWRq0OWlp1Rb/fxeU59rrJf0
         ydbQ==
X-Gm-Message-State: AOAM530tiHWNTjzYaeN1RjLMVqGJLR7RnAEQIVeWoTgHCc/SQpMOin2g
        cawvUtW66RsnqCZrNOs9BkQRRDQzXYrZDg==
X-Google-Smtp-Source: ABdhPJyZh6hf8sXFC79qwpGEmAAO9vEOJdZKhLkHRFW/LA3lP4oPb6YD8zz1q31NcvrKvBr9zJTtEA==
X-Received: by 2002:a05:6a00:808:b0:4c1:3960:bb1c with SMTP id m8-20020a056a00080800b004c13960bb1cmr34830892pfk.84.1642661131061;
        Wed, 19 Jan 2022 22:45:31 -0800 (PST)
Received: from localhost.localdomain ([103.104.171.42])
        by smtp.gmail.com with ESMTPSA id q21sm1760129pfj.94.2022.01.19.22.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 22:45:30 -0800 (PST)
From:   Grace Mi <grace.mi@ecs.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        Grace Mi <grace.mi@ecs.corp-partner.google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] gpu: drm: panel-edp: Add panels planned for sc7180-trogdor-pazquel
Date:   Thu, 20 Jan 2022 06:45:10 +0000
Message-Id: <20220120064457.1.I337b8db7efaba8eb9c0ffd4da0d8c8133faf6f19@changeid>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>

We have added corresponding information:
    [BOE]NV116WHM-N45 use delay_200_500_e50
    [KDB]116N29-30NK-C007 use delay_200_500_e80_d50
    [STA]2081116HHD028001-51D use delay_100_500_e200
Add 3 panels & 2 delay.

Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
Signed-off-by: Grace Mi <grace.mi@ecs.corp-partner.google.com>
---

 drivers/gpu/drm/panel/panel-edp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 176ef0c3cc1da..1baed4b9e5d1a 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1745,6 +1745,19 @@ static const struct panel_delay delay_200_500_e50 = {
 	.enable = 50,
 };
 
+static const struct panel_delay delay_200_500_e80_d50 = {
+	.hpd_absent = 200,
+	.unprepare = 500,
+	.enable = 80,
+	.disable = 50,
+};
+
+static const struct panel_delay delay_100_500_e200 = {
+	.hpd_absent = 100,
+	.unprepare = 500,
+	.enable = 200,
+};
+
 #define EDP_PANEL_ENTRY(vend_chr_0, vend_chr_1, vend_chr_2, product_id, _delay, _name) \
 { \
 	.name = _name, \
@@ -1768,13 +1781,17 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x07d1, &boe_nv133fhm_n61.delay, "NV133FHM-N61"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x082d, &boe_nv133fhm_n61.delay, "NV133FHM-N62"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x098d, &boe_nv110wtm_n61.delay, "NV110WTM-N61"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a5d, &delay_200_500_e50, "NV116WHM-N45"),
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x114c, &innolux_n116bca_ea1.delay, "N116BCA-EA1"),
 
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x0624, &kingdisplay_kd116n21_30nv_a010.delay, "116N21-30NV-A010"),
+	EDP_PANEL_ENTRY('K', 'D', 'B', 0x1120, &delay_200_500_e80_d50, "116N29-30NK-C007"),
 
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x154c, &delay_200_500_p2e100, "LQ116M1JW10"),
 
+	EDP_PANEL_ENTRY('S', 'T', 'A', 0x0100, &delay_100_500_e200, "2081116HHD028001-51D"),
+
 	{ /* sentinal */ }
 };
 
-- 
2.17.1

