Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B94157A85D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240057AbiGSUjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239906AbiGSUjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:39:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFF052FC9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:39:03 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 81AFA6601A3D;
        Tue, 19 Jul 2022 21:39:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658263142;
        bh=yOsyoTXecbnpR+05MoxtIppKOEPuY7CytKHIOjJLXrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N0XMnIEyAk8gNYUxn57slek8jQfjqHtzk47gpqD22xdCI8YeTXc7n8wXnjoxAjQ6p
         gWgyIbLsWH+KwEkxm9CCAQTlParvg+kT7STLFl9Zzt4pc3NhMJRxr8JScpRRYJHAZ+
         /S99eoMABwvqYp8ZWec+LT7OycnOLUUZ+LIZksv/ro6Uepqyyf3aeUx6LBU0sj5SGb
         d+dmvmMDr826ZZ7P15NZvKPmiE+h3q3wQsPCo34NSGWqfLFD1dwTiHJm+T5SBoZ0uH
         8MuL60jA/9NmRYDkEVLt6ZAlluZM373OaEv+m57jt2jyrjAjLfgNY7P3mZpdFZaKV3
         yXQzwOyaH7VkA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm/panel-edp: Add panel entry for R140NWF5 RH
Date:   Tue, 19 Jul 2022 16:38:54 -0400
Message-Id: <20220719203857.1488831-2-nfraprado@collabora.com>
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

Add panel identification entry for the IVO R140NWF5 RH (product ID:
0x057d) panel.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---
The comments on the driver indicate that the T3 timing should be set on
hpd_absent, while hpd_reliable would have a shorter time just while the
HPD line stabilizes on low after power is supplied.

But can we really assume that the HPD line will be reliable at all
before the DDIC is done booting up, at which point the HPD line is
brought up? IOW, shouldn't we always delay T3 (by setting hpd_reliable =
T3), since only then we're really sure that the DDIC is done setting up
and the HPD line is reliable?

I've set the T3 delay to hpd_absent in this series, following what's
instructed in the comments, but I'd like to discuss whether we shouldn't
be setting T3 on hpd_reliable instead, for all panels, to be on the
safer side.

 drivers/gpu/drm/panel/panel-edp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 3626469c4cc2..675d793d925e 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1854,6 +1854,12 @@ static const struct panel_delay delay_100_500_e200 = {
 	.enable = 200,
 };
 
+static const struct panel_delay delay_200_500_e200 = {
+	.hpd_absent = 200,
+	.unprepare = 500,
+	.enable = 200,
+};
+
 #define EDP_PANEL_ENTRY(vend_chr_0, vend_chr_1, vend_chr_2, product_id, _delay, _name) \
 { \
 	.name = _name, \
@@ -1882,6 +1888,8 @@ static const struct edp_panel_entry edp_panels[] = {
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x114c, &innolux_n116bca_ea1.delay, "N116BCA-EA1"),
 
+	EDP_PANEL_ENTRY('I', 'V', 'O', 0x057d, &delay_200_500_e200, "R140NWF5 RH"),
+
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x0624, &kingdisplay_kd116n21_30nv_a010.delay, "116N21-30NV-A010"),
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x1120, &delay_200_500_e80_d50, "116N29-30NK-C007"),
 
-- 
2.37.0

