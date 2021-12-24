Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EE047EB96
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 06:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351335AbhLXFXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 00:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245564AbhLXFXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 00:23:42 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC24C061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 21:23:42 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bq20so16913100lfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 21:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3vLn3V8hakrMnbWh9eTJX5Ws7e/fiZzoe10eOrTOCq8=;
        b=FHrkXdgcVJ6I4Cr7CEfnkrWcfzhb5v4om4TFV9enflli5haSp9odJBhecbmC0B6AxC
         KhnWcCb5UIRr97Mz8M9vGJrPmONYz1N/M5slOOb13NiXTQ3Y1NDq8kz2GYav6Q2dl6Gh
         Swfa1I2I1CGrFdWpDd4mghTZ4OrSM+NwvmWs4kl7dX8smza3jVzszNAsyxLzCfAZCc7R
         wSmZg0Vao3qr3XblzmeDyVm0Z/ziLWxLk1zdXJEzkqIOoZczP/ePCMKYCokEz+xI6Zw8
         BhSJggBkaTjwZqLz44xkUebaHLarLYH5rAncMhcVLfSk5+2aEny3N/Rm9VMP/bCC9jz4
         ZD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3vLn3V8hakrMnbWh9eTJX5Ws7e/fiZzoe10eOrTOCq8=;
        b=ynPnayvistw9L+wf3VgcS4ctj3XMcxKA7Gcy9raDrTdf4j8Imn/ttukePHRpMxC+pE
         cfdKfogzErCpwGqlA1gWX2k9b2A/O05VSzaM/J16tt31vKcNzJglbXBtJx/coa8jzVLk
         Yqvdre+qTJZwS68eQxva9xcGS33zOUsSWd1VZyXP0xhL2YV6SAvQay8hpGZZYyFgGq5B
         ANFZOdijzKYVLZDpTvzU7Mgw9FcpHIfCosEYSex/Mn4TdAgiRBLmu24oHNvGlHhCh6z0
         6uc64xUHiBDm0Z/o4Sc1pnmlqTRea0+JgzxebwPWFKvLLskPXCYXRa+xuEvgQrnyRPsx
         8ZUg==
X-Gm-Message-State: AOAM531HvKBVlEVEU6K9HW/x9iuyqKqxHR8gqtiCnMWeMkQPgfmKLxPa
        /b0L2wpUMUQD7C5sfH+U0UFpGA==
X-Google-Smtp-Source: ABdhPJycx87ictKT8G0oaGXYgKX3KGQb93rTh2lVD1X1vPRpPeQuD1GsvVvaBwhKLFj/JYCBabnhFw==
X-Received: by 2002:a19:f241:: with SMTP id d1mr3883660lfk.131.1640323420407;
        Thu, 23 Dec 2021 21:23:40 -0800 (PST)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id e13sm702858lfs.306.2021.12.23.21.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 21:23:40 -0800 (PST)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 1/3] drm: rcar-du: lvds: Add r8a77961 support
Date:   Fri, 24 Dec 2021 08:23:07 +0300
Message-Id: <20211224052309.1997096-2-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211224052309.1997096-1-nikita.yoush@cogentembedded.com>
References: <20211224052309.1997096-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The M3-W+ SoC has the same LVDS encoder as other R-Car Gen3 chips.
Add support for M3-W+ (R8A77961) SoC to the LVDS encoder driver.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/gpu/drm/rcar-du/rcar_lvds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
index 72a272cfc11e..8dbfbbd3cad1 100644
--- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
+++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
@@ -901,6 +901,7 @@ static const struct of_device_id rcar_lvds_of_table[] = {
 	{ .compatible = "renesas,r8a7793-lvds", .data = &rcar_lvds_gen2_info },
 	{ .compatible = "renesas,r8a7795-lvds", .data = &rcar_lvds_gen3_info },
 	{ .compatible = "renesas,r8a7796-lvds", .data = &rcar_lvds_gen3_info },
+	{ .compatible = "renesas,r8a77961-lvds", .data = &rcar_lvds_gen3_info },
 	{ .compatible = "renesas,r8a77965-lvds", .data = &rcar_lvds_gen3_info },
 	{ .compatible = "renesas,r8a77970-lvds", .data = &rcar_lvds_r8a77970_info },
 	{ .compatible = "renesas,r8a77980-lvds", .data = &rcar_lvds_gen3_info },
-- 
2.30.2

