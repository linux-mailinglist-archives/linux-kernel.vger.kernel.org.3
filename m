Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C444AB62B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244332AbiBGHzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 02:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348035AbiBGHxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:53:40 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1A2C0401C7
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 23:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644220417; x=1675756417;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8tNcGqTA9NJY3U02NWeIXjX+4/ME8GMu6a+ysHONpb4=;
  b=PthaB0kT51bA4GVjsyOwIrSC0lU63gppL+bVcVbqBKii6f3pPSiVjlfO
   25D6hXFLpHGhb3MwH7JJZChEGfln/IdYi+pcWc0Ix/si9ONRqnNPAo1xO
   KpRN9RhtkLB+VebX/FKvwUkyqz7rbEvgcFn8l9QhwVyxV5QLX+0fqNxEM
   Jjw8A2H9ZmkycS9RimD3MHko2yNJ4SBzz6BhOVJ8hUxfaRttiRgtpvjrU
   EfplJg7FhZiZj0h1mg6K0d+QQFDbQfkkq7jvazb8yThGrBvSLr2UbT0Ph
   Vy2BLXVOxko2M67vO3lpuXE2LnS1aXjY1YIChzEZfub/VXAbOSFeehV++
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="21922574"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Feb 2022 08:53:35 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 07 Feb 2022 08:53:35 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 07 Feb 2022 08:53:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644220415; x=1675756415;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8tNcGqTA9NJY3U02NWeIXjX+4/ME8GMu6a+ysHONpb4=;
  b=HAvsgjddvMsMepw5pP3QDuh86Dqyh2voAruCWzfrep3BsxEEpfzVlH0w
   HZGogrcUjS8T3m/IUEjhFrmsDAyQUUHSLFP1ioYQG72bIdvzKoZco7gYI
   BJ2TkaVbz9wziQQChGkfOpPTbFhm3T5Ij732HYtDnXeLjEedWmnUYQJxc
   LLVUaigFP2BRQ4jUXGs17L/BnhKLZvKumwVPSS0Wj3FOWp+6hjtubRjrC
   zTy6IDZ1ooqQdX6MdfyWzWrHmEuqexg+F0oW8L66RpEbPNHIanECRJAyh
   7zcRYkb/2wjjkqOrr7w290iF/XWDqcuQLMkcWOqP+JSOppzuicO8nxBZm
   w==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="21922573"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Feb 2022 08:53:34 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id AAE73280065;
        Mon,  7 Feb 2022 08:53:34 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/bridge: ti-sn65dsi83: use dev_err_probe
Date:   Mon,  7 Feb 2022 08:53:24 +0100
Message-Id: <20220207075325.285179-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sn65dsi83_host_attach is called from probe, so silence message upon
deferred probe. This can happen, e.g. if the bridge driver is built-in, but
the host is built as module.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
This might look a bit weird in the first place, but the real benefit is
usage of device_set_deferred_probe_reason() inside dev_err_probe().
Having /sys/kernel/debug/devices_deferred providing more information
actually helped me tracking down an issue.

 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index a88d90f928ce..1f02596d6db4 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -644,8 +644,7 @@ static int sn65dsi83_host_attach(struct sn65dsi83 *ctx)
 
 	host = of_find_mipi_dsi_host_by_node(ctx->host_node);
 	if (!host) {
-		dev_err(dev, "failed to find dsi host\n");
-		return -EPROBE_DEFER;
+		return dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n");
 	}
 
 	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
-- 
2.25.1

