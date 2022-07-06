Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DD45691BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbiGFS1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbiGFS1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:27:35 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFC313DC3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:27:32 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id i186so15930239vsc.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FyZPG7ecMtPTu7c8gkIkFgQ1x9YPQvFNs7IqBS9P2iw=;
        b=AMczT6RYxuWehfaVB4N6c/YCGTIUDa5AonsWRb9tk0ZgIB8E18MZBsP45Ils2GHr2S
         GykDSQkeasORYtEvX2DWlWovRf8degKgU73O7ghh+YgX4aBx3UyDjYRxx8lrOKHK844W
         QU4poqa9He4qO5LcH7XLfBcK2c6EHsK9J/kszxeSVWNUWNpc2NYzUMYuiUaGMPIFeMoE
         tb/XCxAJ0pXfwUfh7oszL/W7NCWBtIGdvPfbVGBK7KfGImnt+Hdbk/SVC/adbAYTqnr8
         rFUNmU4+Ig0gvs3fEVomfBsntx3V/PoE8h8HqGIczGAQUABzuh1pD7Zwv0utzvSWRK77
         +L9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FyZPG7ecMtPTu7c8gkIkFgQ1x9YPQvFNs7IqBS9P2iw=;
        b=5eyxOXbG7L5vZEwvT1VGYKfaQzXkY0O1C2ZnLQ+M7r3PTP+/tl1h/EWf8TD4zMa1L9
         xBMt9BhR6zx4B38LqYBVK4Rscv2hGcdHDnV//G0/6ynuz0Ad3eWxwhULkojuVrrt1rO7
         N7tLWJjdBWqPMq+oU4SS++AwC4C0w7eE8EofxHK8a3hLDxhFfwAgCv00Tsd7ijtJSqZ7
         sJqEUsJjcDP1ces/vSCMNq8ADB6g9qlWLkF1YUYOW9A1lw7eZJrv60gI0A7RAaRTfPHZ
         1tzKhkvsCXUW+oXl+tlozN7bskU3g0a388d1ASrIjED1tfs8zO51rqP4kqaMwQ/Q2Kex
         D3LA==
X-Gm-Message-State: AJIora/URnrgZx9zwyFfIjMqd2ZsHl1l/nnfr00Fq/AExXh0gLEaE3I2
        RMztLtfGUKlxRqpC/GLfG48SoQ==
X-Google-Smtp-Source: AGRyM1tszaPEGImA9JSpi/gagvfI+XhMcXbb2tzzDh0J0vODfixd06pXodsQX2mdEZzJ750HWUCmHA==
X-Received: by 2002:a67:fbc2:0:b0:356:fd6b:8d09 with SMTP id o2-20020a67fbc2000000b00356fd6b8d09mr5415717vsr.45.1657132052034;
        Wed, 06 Jul 2022 11:27:32 -0700 (PDT)
Received: from zeta-build.. ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id bl9-20020a056102508900b003563680212asm7445539vsb.27.2022.07.06.11.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:27:31 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH 3/8] tegra-vde: Use vb2_find_buffer
Date:   Wed,  6 Jul 2022 15:26:52 -0300
Message-Id: <20220706182657.210650-4-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220706182657.210650-1-ezequiel@vanguardiasur.com.ar>
References: <20220706182657.210650-1-ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the newly introduced vb2_find_buffer API to get a vb2_buffer
given a buffer timestamp.

Cc: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/media/platform/nvidia/tegra-vde/h264.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/nvidia/tegra-vde/h264.c b/drivers/media/platform/nvidia/tegra-vde/h264.c
index 88f81a134ba0..204e474d57f7 100644
--- a/drivers/media/platform/nvidia/tegra-vde/h264.c
+++ b/drivers/media/platform/nvidia/tegra-vde/h264.c
@@ -659,20 +659,19 @@ static struct vb2_buffer *get_ref_buf(struct tegra_ctx *ctx,
 {
 	const struct v4l2_h264_dpb_entry *dpb = ctx->h264.decode_params->dpb;
 	struct vb2_queue *cap_q = &ctx->fh.m2m_ctx->cap_q_ctx.q;
-	int buf_idx = -1;
+	struct vb2_buffer *vb = NULL;
 
 	if (dpb[dpb_idx].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
-		buf_idx = vb2_find_timestamp(cap_q,
-					     dpb[dpb_idx].reference_ts, 0);
+		vb = vb2_find_buffer(cap_q, dpb[dpb_idx].reference_ts);
 
 	/*
 	 * If a DPB entry is unused or invalid, address of current destination
 	 * buffer is returned.
 	 */
-	if (buf_idx < 0)
+	if (!vb)
 		return &dst->vb2_buf;
 
-	return vb2_get_buffer(cap_q, buf_idx);
+	return vb;
 }
 
 static int tegra_vde_validate_vb_size(struct tegra_ctx *ctx,
-- 
2.34.3

