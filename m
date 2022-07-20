Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EEE57BEA6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbiGTTde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiGTTd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:33:28 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000FE5B040
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=qbSvOmWl9+ElFHyX4OzDqfeIk40FylSCYkoBkmd7xSI=; b=OkXflFVy/FC6KvgJhr+JyIoHkU
        VxvGdtdxAlm8IpIYi7EqtkS2IW2OLuvTyuIoh65rrjOuMbHnZJsd5XpMzj1AszU+y96LCbjrxDOzS
        F0GuaM+j91qTUw9dXekga2rl0nGvHC49i9SWr2uxpBxf4aZORbI1DOXp0XQO2cQA0Jd9z/1ZkcizH
        vKaJT6qCW9JkCyJib9acFoPYFwlKVU2QwIrWbIwYSPx0klWhjDKDI+/x4XD4hwMYyMtb44Osd5VHU
        M5F4/Emwq78bu9CtvFJYPPtf8zft+mjPNVt0urq2pt3wcqJAczXhYSg9hFyKO3lqOt0l4e6Dhz0Qp
        ZOgBlyvg==;
Received: from [165.90.126.25] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oEFRU-000fxI-VC; Wed, 20 Jul 2022 21:33:08 +0200
From:   Melissa Wen <mwen@igalia.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        kernel-dev@igalia.com, Melissa Wen <mwen@igalia.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] drm/amd/display: remove useless FPU protection wrapper from dcn31_resource file
Date:   Wed, 20 Jul 2022 18:32:05 -0100
Message-Id: <20220720193208.1131493-3-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220720193208.1131493-1-mwen@igalia.com>
References: <20220720193208.1131493-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many lines of code in dcn31_resource_construct are wrapped by DC_FP
macro to protect FPU operations; however, there is no FPU in this
region. Therefore, just remove the wrapper for clarity.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 929b712cbada..6d25fcf865bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1863,8 +1863,6 @@ static bool dcn31_resource_construct(
 	struct dc_context *ctx = dc->ctx;
 	struct irq_service_init_data init_data;
 
-	DC_FP_START();
-
 	ctx->dc_bios->regs = &bios_regs;
 
 	pool->base.res_cap = &res_cap_dcn31;
@@ -2175,13 +2173,9 @@ static bool dcn31_resource_construct(
 
 	dc->dcn_ip->max_num_dpp = dcn3_1_ip.max_num_dpp;
 
-	DC_FP_END();
-
 	return true;
 
 create_fail:
-
-	DC_FP_END();
 	dcn31_resource_destruct(pool);
 
 	return false;
-- 
2.35.1

