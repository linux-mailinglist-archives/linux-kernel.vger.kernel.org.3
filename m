Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF1146C41C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 21:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241034AbhLGUHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 15:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbhLGUHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 15:07:23 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0270CC061574;
        Tue,  7 Dec 2021 12:03:53 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id u80so376786pfc.9;
        Tue, 07 Dec 2021 12:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6EkS8Nvrc0mLwPSTwo7vPbxig6A1y6814RHQt01NTVI=;
        b=AsljNNwj8qOWOVE9bmXhbXKiE4Esi4ccz46SPr/aK5d7tMGE6rDcC4aKxX/q7MdIAR
         6eqc5s0Usx+36Nl9Cr0WGDSMqUIP5YS0o99r5FWTOCZYtjiJ2BTQh06CUWxc3zUgjDv4
         4/MyXIJm3jrZI8JBT7iPhzxh+TmfeS39lhLcyCCVIqB24rGA/XV1hwMCT1zp1FLkQL8w
         nMLripi8OnnUNFuRqWYwX1U7uYNYW5PNCEuWjUe7zToBLcU73oHJSrQ0/W7Qo6EcASf1
         y/doPuhW7FDx3CKSmm7AzlyJ2BuZOS1kGyvumFIr/5psmfHxya/4oyYw5qnz1mIRnD9s
         wadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6EkS8Nvrc0mLwPSTwo7vPbxig6A1y6814RHQt01NTVI=;
        b=F0k7mzYQK1F++GQ1pnjOrUDepD4b448KkOOCHjR9d0w7RrgYchgNXiLMiIzTCYfj6r
         m8gEFrrrQdpKTJNPkOdkKaLcyLDYVFkU+UdVwirMBAg8r7QCDcFEz2VsRh9k1nP2kF75
         EPCn5N3KAbQQuRZkuhaZ+TJjlFqHKEIDfDQwOlk8s9QSGCSjVepUA/lbIDglZK2KKrc+
         KYfEzEXFC0NnmhBcBuqDDhHX0w/oqcJw0orOKsHtbwq4SvgXSEoUa8r2IQthj2mO78fx
         y12LUr8P/42bSqDmFd1IW2MaIDj/1Sui2/4we6WtSMo2mSS1g2BxOIw0aCU0N8vpUIOv
         VXAA==
X-Gm-Message-State: AOAM531DSptMr8EtY0q+7pxiVlK/8KlaofOmv9sGBmy6XEPLZoBxX3ew
        KFH+6xe3o7TWDoJRqOERoQy2JCsysmo=
X-Google-Smtp-Source: ABdhPJyDZzLVyupTsP3jSm1uQ1TVGy9Yo7iWxipVefr/je0F5T82/yBDGk6mtlZOAUTLteBzHa6PTw==
X-Received: by 2002:a62:1909:0:b0:4a7:e88c:286b with SMTP id 9-20020a621909000000b004a7e88c286bmr1270023pfz.26.1638907431667;
        Tue, 07 Dec 2021 12:03:51 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id d20sm563648pfl.88.2021.12.07.12.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 12:03:50 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/bridge: sn65dsi86: defer if there is no dsi host
Date:   Tue,  7 Dec 2021 12:09:06 -0800
Message-Id: <20211207200906.609673-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Otherwise we don't get another shot at it if the bridge probes before
the dsi host is registered.  It seems like this is what *most* (but not
all) of the other bridges do.

It looks like this was missed in the conversion to attach dsi host at
probe time.

Fixes: c3b75d4734cb ("drm/bridge: sn65dsi86: Register and attach our DSI device at probe")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 02b490671f8f..3684e12fbac3 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -716,7 +716,7 @@ static int ti_sn_attach_host(struct ti_sn65dsi86 *pdata)
 	host = of_find_mipi_dsi_host_by_node(pdata->host_node);
 	if (!host) {
 		DRM_ERROR("failed to find dsi host\n");
-		return -ENODEV;
+		return -EPROBE_DEFER;
 	}
 
 	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
-- 
2.33.1

