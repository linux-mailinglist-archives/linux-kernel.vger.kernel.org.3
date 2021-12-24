Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0116A47ED57
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 09:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352061AbhLXInZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 03:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352041AbhLXInU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 03:43:20 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98D5C061401
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 00:43:19 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v16so7180474pjn.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 00:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mlbvlnlc5ECOuwY+fmdHWmlq/HvKa+/AWyi6jrBEyVk=;
        b=QUpeyU4ozzEExZYC53GPCIo345mlX3Up0uMIXU9ol7Y3xE97WX6Yps8UrzK/bu8zwf
         GDUjygz/zZAJ8SuoQ0g9WTSASjDii+9Pn+4W6GvfpVSQ3btRM/LEpIT1nR6RbX0X4cfL
         zD5wOCoJ5KNixvc+PVlf52w8CTdudb5xD648c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mlbvlnlc5ECOuwY+fmdHWmlq/HvKa+/AWyi6jrBEyVk=;
        b=ZW0TDwHwt9LTTo5kEOYxORxQz8ayB+Mbhvaqu4z3sHAsX1wZHQvHWQEmquyiOFhU9J
         nDi2PUREsLQwBgToC4ld19wHCQz66o/hpEoAIDFrI+AhgKw2ISRdOMYn3mNZOW2fTcdB
         t5Sa4Jo71JnfPkGZ1OrS38vkAE7km6lcZ/s24i4EXLoe52tLz6X3oBLpJRp7q4dkPSX8
         yVn2qYffBbgjSpC8XYHACaoN1XO67kYomLC0zT8+zVIInfCEKvBcw5NgSFivGkBNbMQw
         q7e5Lx8OXhYmoqxYNqpzOrgeUeDV9VxBlmcbyzzFK9/usyvohptz/Y4Cm2NbDX9OKrc1
         4mgQ==
X-Gm-Message-State: AOAM530BqDIcrIyQIKYExkB9BxaIhZKSPmGQO/b3eE2OdZjsrXf/ashM
        Xm2XNJjWQuyH2TsGUe8wZ+D9ng==
X-Google-Smtp-Source: ABdhPJz+m1CkCeHpGL1ORDi92M2Qxm8IPKb08iVIJbZZGhbQv7LRalwXM/qB2WNnXDeTOo0535Idqg==
X-Received: by 2002:a17:902:8346:b0:148:b843:751a with SMTP id z6-20020a170902834600b00148b843751amr5940338pln.141.1640335399358;
        Fri, 24 Dec 2021 00:43:19 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:fd40:cbd0:c42a:3c26])
        by smtp.gmail.com with ESMTPSA id p13sm436369pgl.23.2021.12.24.00.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 00:43:19 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFT 1/7] media: hantro: jpeg: Relax register writes before write starting hardware
Date:   Fri, 24 Dec 2021 16:42:42 +0800
Message-Id: <20211224084248.3070568-2-wenst@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20211224084248.3070568-1-wenst@chromium.org>
References: <20211224084248.3070568-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the earlier submissions of the Hantro/Rockchip JPEG encoder driver, a
wmb() was inserted before the final register write that starts the
encoder. In v11, it was removed and the second-to-last register write
was changed to a non-relaxed write, which has an implicit wmb() [1].
The rockchip_vpu2 (then rk3399_vpu) variant is even weirder as there
is another writel_relaxed() following the non-relaxed one.

Turns out only the last writel() needs to be non-relaxed. Device I/O
mappings already guarantee strict ordering to the same endpoint, and
the writel() triggering the hardware would force all writes to memory
to be observed before the writel() to the hardware is observed.

[1] https://lore.kernel.org/linux-media/CAAFQd5ArFG0hU6MgcyLd+_UOP3+T_U-aw2FXv6sE7fGqVCVGqw@mail.gmail.com/

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/staging/media/hantro/hantro_h1_jpeg_enc.c        | 3 +--
 drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c b/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c
index 1450013d3685..03db1c3444f8 100644
--- a/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c
+++ b/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c
@@ -123,8 +123,7 @@ int hantro_h1_jpeg_enc_run(struct hantro_ctx *ctx)
 		| H1_REG_AXI_CTRL_INPUT_SWAP32
 		| H1_REG_AXI_CTRL_OUTPUT_SWAP8
 		| H1_REG_AXI_CTRL_INPUT_SWAP8;
-	/* Make sure that all registers are written at this point. */
-	vepu_write(vpu, reg, H1_REG_AXI_CTRL);
+	vepu_write_relaxed(vpu, reg, H1_REG_AXI_CTRL);
 
 	reg = H1_REG_ENC_CTRL_WIDTH(MB_WIDTH(ctx->src_fmt.width))
 		| H1_REG_ENC_CTRL_HEIGHT(MB_HEIGHT(ctx->src_fmt.height))
diff --git a/drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c b/drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c
index 4df16f59fb97..b931fc5fa1a9 100644
--- a/drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c
+++ b/drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c
@@ -152,8 +152,7 @@ int rockchip_vpu2_jpeg_enc_run(struct hantro_ctx *ctx)
 		| VEPU_REG_INPUT_SWAP8
 		| VEPU_REG_INPUT_SWAP16
 		| VEPU_REG_INPUT_SWAP32;
-	/* Make sure that all registers are written at this point. */
-	vepu_write(vpu, reg, VEPU_REG_DATA_ENDIAN);
+	vepu_write_relaxed(vpu, reg, VEPU_REG_DATA_ENDIAN);
 
 	reg = VEPU_REG_AXI_CTRL_BURST_LEN(16);
 	vepu_write_relaxed(vpu, reg, VEPU_REG_AXI_CTRL);
-- 
2.34.1.448.ga2b2bfdf31-goog

