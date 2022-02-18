Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5374BB5E1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbiBRJpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:45:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbiBRJo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:44:59 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D70E24BEE;
        Fri, 18 Feb 2022 01:44:43 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id z16so1921874pfh.3;
        Fri, 18 Feb 2022 01:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A05PdbAAT5RslfaLGjSbZiT8ptnvoIwXk5E/3L39Ufg=;
        b=T0KmbCAcbHo6p3GrUSCrkagNNqE2crxXfZSeqk+5honbSzuhtAE9KEz5/lmcQ/sU9R
         NZW/3hlrs+2l2sgwdeX+mMx4VP5uALRlgzmL7S5+S4o4vI1YqV37sXdc9+5y83KePNt0
         mPh5HvxoMVlgrY9vUd8HAevxii2MA64VEUia/zTnhKiTwpjY1ONo50Z1on+J8PHNCBCZ
         8HuH8fHKDKL/VvS9QboVlXx7xJpk6J56My0pVXew+3RkpaGaNGeBJ2LOP9HpGmf3HgCx
         fKy9wv7je5/yCcpnHpFi+KTbtafD/zw3YllaW9DuBW0iS2fW/JrmBsmDN2X8jPYixDMR
         0Y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A05PdbAAT5RslfaLGjSbZiT8ptnvoIwXk5E/3L39Ufg=;
        b=DLH7CzycS0aUA8pyAzZ/kpBN4jF32o+vLBKfBReHS/TOH7tOsuxj0DLainXtNeKaei
         x6yReMLdC7wnC51rY7aYfnk6PrRbWCBlDrUGjhRdAeTT++K90YsX9qKRpsQDlFo/JDpu
         YsPplmgcMT69tPh4wgzwGe0HNEZcjFqatv3/aSO8e4CLR5HNWRX2bvxIsPAqj69NjvM0
         2fMVghPJ1hHE7351rb5AiYagSzqXklvbKCJpaCOUAV8tL2LMCUkE0WS1T1K7NF8kc7Ia
         c0Z2AipcuXol9pakzLjvTGE6G/+7uAik6Tozh+blPC7ml2BXdY2LEV4zqcIa3rh6D1I+
         c4Pg==
X-Gm-Message-State: AOAM533JAPZiOuw1WtdT2fwEEr43ccvELM7PQli4yBdFDPqYlUyH4N9X
        kpLyLIp6iumLaC7QIR2Gjwg=
X-Google-Smtp-Source: ABdhPJzgkWXMlWqPifpwnUsfJUPZqinF4EGSp9R2f9iaH57jBs4n1/LQLaP+/O0MtcT0WDTDneU4yg==
X-Received: by 2002:aa7:88cb:0:b0:4df:7b9e:1cc3 with SMTP id k11-20020aa788cb000000b004df7b9e1cc3mr7265229pff.82.1645177482532;
        Fri, 18 Feb 2022 01:44:42 -0800 (PST)
Received: from localhost.localdomain ([101.78.151.222])
        by smtp.gmail.com with ESMTPSA id j14sm2284741pfa.81.2022.02.18.01.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 01:44:41 -0800 (PST)
From:   Rex Nie <rexnie3@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daocai Nie <niedaocai@huaqin.corp-partner.google.com>
Subject: [PATCH 1/2] drm/panel-edp: Add eDP innolux panel support
Date:   Fri, 18 Feb 2022 17:44:17 +0800
Message-Id: <20220218094417.1631559-1-rexnie3@gmail.com>
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

From: Daocai Nie <niedaocai@huaqin.corp-partner.google.com>

Add support for the 14" innolux,n140hca-eac eDP panel.

Signed-off-by: Daocai Nie <niedaocai@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index f7bfcf63d48e..f5f9c9cb26ba 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1330,6 +1330,29 @@ static const struct panel_desc innolux_n125hce_gn1 = {
 	},
 };
 
+static const struct display_timing innolux_n140hca_eac_timing = {
+	.pixelclock = { 72600000, 76420000, 80240000 },
+	.hactive = { 1920, 1920, 1920 },
+	.hfront_porch = { 80, 80, 80 },
+	.hback_porch = { 190, 190, 190 },
+	.hsync_len = { 60, 60, 60 },
+	.vactive = { 1080, 1080, 1080 },
+	.vfront_porch = { 6, 6, 6 },
+	.vback_porch = { 38, 38, 38 },
+	.vsync_len = { 8, 8, 8 },
+	.flags = DISPLAY_FLAGS_VSYNC_LOW | DISPLAY_FLAGS_HSYNC_LOW,
+};
+
+static const struct panel_desc innolux_n140hca_eac = {
+	.timings = &innolux_n140hca_eac_timing,
+	.num_timings = 1,
+	.bpc = 6,
+	.size = {
+		.width = 309,
+		.height = 174,
+	},
+};
+
 static const struct drm_display_mode innolux_p120zdg_bf1_mode = {
 	.clock = 206016,
 	.hdisplay = 2160,
@@ -1750,6 +1773,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "innolux,n125hce-gn1",
 		.data = &innolux_n125hce_gn1,
+	}, {
+		.compatible = "innolux,n140hca-eac",
+		.data = &innolux_n140hca_eac,
 	}, {
 		.compatible = "innolux,p120zdg-bf1",
 		.data = &innolux_p120zdg_bf1,
-- 
2.25.1

