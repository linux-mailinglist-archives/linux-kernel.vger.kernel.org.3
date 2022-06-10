Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A047E5466E4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344666AbiFJMwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbiFJMwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:52:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F057729361;
        Fri, 10 Jun 2022 05:52:35 -0700 (PDT)
Received: from whitebuilder.lan (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 45E776601723;
        Fri, 10 Jun 2022 13:52:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654865554;
        bh=p58BGLd7hMm8p/2ISuy3Dy0LlqXqYJNmYcWNBWGs/eo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k/12mt8TUAGfUMKdUILYc1U9Q0mcOKvYLKWOvKQehdBhmZwNiUxJswfiOfpoooU6Y
         K7SyrWEXe2qjxHIqPHedkJ37gilThxf4XJm1pghTKSzfqIS5CJyy/DGRM6cwux/56x
         BJC76p7e5Fq2jAX5N9L4Q+7mVubr9Jjllr2y0C1llKCJP6kL7yxELDiubw4W84nWK5
         y2J3cAIz0OPwwKlQj8IYtTfQsYgJi0tzCounvyIkiAzE3Nbynsh4HGqqJjeLMjn96a
         wnXDKPIFQARXVZqpvN92Lkf+CAUBKMooUOkILCPvyNcXkpfILLtadGlIz7x/dGu5lp
         QNoDgEhEwkwOA==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     linux-media@vger.kernel.org,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        kernel@collabora.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] media: rkvdec: Disable H.264 error detection
Date:   Fri, 10 Jun 2022 08:52:11 -0400
Message-Id: <20220610125215.240539-2-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610125215.240539-1-nicolas.dufresne@collabora.com>
References: <20220610125215.240539-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quite often, the HW get stuck in error condition if a stream error
was detected. As documented, the HW should stop immediately and self
reset. There is likely a problem or a miss-understanding of the self
self reset mechanism, as unless we make a long pause, the next command
will then report an error even if there is no error in it.

Disabling error detection fixes the issue, and let the decoder continue
after an error. This patch is safe for backport into older kernels.

Fixes: cd33c830448b ("media: rkvdec: Add the rkvdec driver")
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/staging/media/rkvdec/rkvdec-h264.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
index 2992fb87cf72..55596ce6bb6e 100644
--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
@@ -1175,8 +1175,8 @@ static int rkvdec_h264_run(struct rkvdec_ctx *ctx)
 
 	schedule_delayed_work(&rkvdec->watchdog_work, msecs_to_jiffies(2000));
 
-	writel(0xffffffff, rkvdec->regs + RKVDEC_REG_STRMD_ERR_EN);
-	writel(0xffffffff, rkvdec->regs + RKVDEC_REG_H264_ERR_E);
+	writel(0, rkvdec->regs + RKVDEC_REG_STRMD_ERR_EN);
+	writel(0, rkvdec->regs + RKVDEC_REG_H264_ERR_E);
 	writel(1, rkvdec->regs + RKVDEC_REG_PREF_LUMA_CACHE_COMMAND);
 	writel(1, rkvdec->regs + RKVDEC_REG_PREF_CHR_CACHE_COMMAND);
 
-- 
2.36.1

