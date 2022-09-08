Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398CC5B17CB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiIHIzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiIHIzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:55:11 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C24C4821
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:55:09 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m3so6493406pjo.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=uacXOofD8iMt8GLUR5lx4NNyko53fwtDtrMNESrEi8c=;
        b=CITPCIDUriXf+nDAVczMxdww75NlJvrkYEzD6+e9xKCS+gVi9AWf5wp4Hx49+wjx/I
         rCeT33PSgA704aayIDWByWvmBlFnby0oJy5zZZRfIRlnO83GPAWQ/7LDkqtcxOPGPp+N
         BHQppY+hkRZRKxeMeRsVquLb/tniJrf6EVcRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=uacXOofD8iMt8GLUR5lx4NNyko53fwtDtrMNESrEi8c=;
        b=sSZ6MjPA/XMsYBk+r0c31b/3JE6xgHcfEhFRNui1dDSN8K4AaH4XYG8ZB1x3/2NJJA
         BC8bgcr66yZghfdr7L7ZWPmu+P+0N1WMn41XnJIWCMKkyIMxJzI/hQltPdm/Xp486vSO
         YiuDVszmBnOOAPWsVhfJJzRT0HYn9XrV0AddsR0lay6K6fOJ3OABpbCkM8KB+OkepKO7
         H2OwD5OD1jTTLsBpdzFWoK5X9k8FllPu1pe/oXVn4n/h+f9nibcFm/Thn3jStLFWwHqP
         iJlwYY7fb6aH94nbIdOL+QAakFeZ88guFldqNew4WBopoeZLAlkVm9ndMA0MfXNEV78R
         Ottg==
X-Gm-Message-State: ACgBeo0mzP5EZwMJkxYVSQ4tbcBaJKdaZvFhvayS9zj9preDdVhUIFcz
        6ilXWal6FuNlaIcV6e4RBaSsdw==
X-Google-Smtp-Source: AA6agR6NcpB09eefHHYXp6GkJKUOTTDK2AyTs5wLlrRzKJdAfD4PHYm6JQ29Zc8u7kSciiOn6EqWZA==
X-Received: by 2002:a17:902:c94a:b0:16f:81c1:255a with SMTP id i10-20020a170902c94a00b0016f81c1255amr7603761pla.35.1662627308604;
        Thu, 08 Sep 2022 01:55:08 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:c6ba:fe7c:d2b:242e])
        by smtp.gmail.com with ESMTPSA id mj19-20020a17090b369300b001f334aa9170sm1188629pjb.48.2022.09.08.01.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:55:08 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/panel-edp: Fix delays for Innolux N116BCA-EA1
Date:   Thu,  8 Sep 2022 16:54:53 +0800
Message-Id: <20220908085454.1024167-1-wenst@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 52824ca4502d ("drm/panel-edp: Better describe eDP panel delays")
clarified the various delays used for eDP panels, tying them to the eDP
panel timing diagram.

For Innolux N116BCA-EA1, .prepare_to_enable would be:

    t4_min + t5_min + t6_min + max(t7_max, t8_min)

Since t4_min and t5_min are both 0, the panel can use either .enable or
.prepare_to_enable.

As .enable is better defined, switch to using .enable for this panel.

Also add .disable = 50, based on the datasheet's t9_min value. This
effectively makes the delays the same as delay_200_500_e80_d50.

Cc: Douglas Anderson <dianders@chromium.org>
Fixes: 51d35631c970 ("drm/panel-simple: Add N116BCA-EA1")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 2bef3e707a95..65e3a5361c80 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1295,7 +1295,8 @@ static const struct panel_desc innolux_n116bca_ea1 = {
 	},
 	.delay = {
 		.hpd_absent = 200,
-		.prepare_to_enable = 80,
+		.enable = 80,
+		.disable = 50,
 		.unprepare = 500,
 	},
 };
-- 
2.37.2.789.g6183377224-goog

