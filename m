Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7559F57A85F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240140AbiGSUjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240032AbiGSUjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:39:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80D952DEC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:39:06 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8FAFB66019F4;
        Tue, 19 Jul 2022 21:39:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658263145;
        bh=Aq5S2gkpJATVIFJkGq8D34wf45tOEaY6CNq3MR0BK0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gZuUFo9Vy6cZQoonAOzTsCRvxxn2F+ic4Ay7DsNSAm1Q0HLQxF9C/s/43Fa1TRkyJ
         C0mSmFFyYBNtnVYvPQFvZgzF9Hs2RrbtIXE0TKmiX0RHIRK+EI1t8jPUoCvuGE6LcY
         8TrGVP7AwDkOCUNu/bWwEgZBVN8DcqG39jzg2VkKLBdvX1JQbMH+3U+8jdq7atksab
         m6A07wpR1XcEsCxYYb5StPXHEdyR9mKlKCAoUlSzE2jFJ4qwN68sFPjGh1lSMFRWa6
         p58epxBKKype+4S9oBmnK+F8/kO/GsUPzUwIITECtf+yyIGkwoNzTRzvh1flalhJxH
         +4nHrVfukDZbQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm/panel-edp: Fix variable typo when saving hpd absent delay from DT
Date:   Tue, 19 Jul 2022 16:38:56 -0400
Message-Id: <20220719203857.1488831-4-nfraprado@collabora.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220719203857.1488831-1-nfraprado@collabora.com>
References: <20220719203857.1488831-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value read from the "hpd-absent-delay-ms" property in DT was being
saved to the wrong variable, overriding the hpd_reliable delay. Fix the
typo.

Fixes: 5540cf8f3e8d ("drm/panel-edp: Implement generic "edp-panel"s probed by EDID")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 drivers/gpu/drm/panel/panel-edp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 152e00eb846f..b3536d8600f4 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -738,7 +738,7 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 	of_property_read_u32(dev->of_node, "hpd-reliable-delay-ms", &reliable_ms);
 	desc->delay.hpd_reliable = reliable_ms;
 	of_property_read_u32(dev->of_node, "hpd-absent-delay-ms", &absent_ms);
-	desc->delay.hpd_reliable = absent_ms;
+	desc->delay.hpd_absent = absent_ms;
 
 	/* Power the panel on so we can read the EDID */
 	ret = pm_runtime_get_sync(dev);
-- 
2.37.0

