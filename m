Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E878F575358
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239858AbiGNQsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240286AbiGNQsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:48:09 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C67F67CBF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:46:04 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4LkL2q44zBzDrYb;
        Thu, 14 Jul 2022 16:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1657817139; bh=xdr173yUdV6H2bOcR/HCbsRH65xbrytPimpZaF7SsCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BnfGHZ8gM0pzSDfFhHbfVTxMFY1PgM86vQ7U3srnzhrb33via26qQHvYkwFuo9Lfp
         8iEtPvTaPfp86wDHfRbwRw/ggoXWrJKxkprp2Q7m80yWjtIvhoTlRP6TetTCbESuag
         rTY++c7wnOYbomPmODh0d3NsmzxrahoNSHPmVAvI=
X-Riseup-User-ID: EB11A1FD491C23ABBAA526948F24A2E75E803645CC4D17DBD835B8F691E7EC88
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LkL2j2SXcz5wCk;
        Thu, 14 Jul 2022 16:45:33 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        mwen@igalia.com, andrealmeid@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH 03/12] drm/amd/display: Remove unused clk_src variable
Date:   Thu, 14 Jul 2022 13:44:58 -0300
Message-Id: <20220714164507.561751-3-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-1-mairacanal@riseup.net>
References: <20220714164507.561751-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the variable clk_src from the function dcn3_get_pix_clk_dividers.

This was pointed by clang with the following warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:1279:25: warning:
variable 'clk_src' set but not used [-Wunused-but-set-variable]
        struct dce110_clk_src *clk_src;
                               ^
1 warning generated.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 5cc7cc0b2f2d..d55da1ab1ac2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1276,9 +1276,7 @@ static uint32_t dcn3_get_pix_clk_dividers(
 		struct pll_settings *pll_settings)
 {
 	unsigned long long actual_pix_clk_100Hz = pix_clk_params ? pix_clk_params->requested_pix_clk_100hz : 0;
-	struct dce110_clk_src *clk_src;
 
-	clk_src = TO_DCE110_CLK_SRC(cs);
 	DC_LOGGER_INIT();
 
 	if (pix_clk_params == NULL || pll_settings == NULL
-- 
2.36.1

