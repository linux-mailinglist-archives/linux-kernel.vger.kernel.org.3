Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5082E47ED59
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 09:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352055AbhLXIn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 03:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352046AbhLXInW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 03:43:22 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0F7C061401
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 00:43:22 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id a23so7146226pgm.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 00:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sV79zWvBxTOqiRZPPrLUHjZwFpDP1ZUgCFSQrPsf5D0=;
        b=BLVFhC+h53krTnpc+WG9bIg2JTuQleaJrdnZ5YXjAD3Ln3kK/uLw9Pt4feMO/A4CCQ
         g+9vSojwHSMRX29Sxqozsxs5oTBoXmGz0fDPBDyuNyhSxLKEvK7/Z14FTqYhgiwCZSr7
         RXx4T/BqM3kwo8PWegvZox7nbr48TjLAFPpfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sV79zWvBxTOqiRZPPrLUHjZwFpDP1ZUgCFSQrPsf5D0=;
        b=wcZXcVyb38Ppewbzyt4A0vLcjJrFv0A1AbQFWWbTn3lAeJplrEots3ROUSAiWyqL6Z
         LOxOaRSbLC2iEzvA6OSQXItaaQZL+GINHX84IbjiZcwlCetUlMqH9j6oLiQq6Xp6IVUv
         GDxyeDNU9iVjv3y7DRWyIoOWiZdQVMYk87pjQ+XmO8lqhtFrsK0+Ye26+Hj3Jo0Z9tf4
         /mN2dRpMlGpbETVclLThuk/wr5aYUsYJnVgig1mY+7E67JxUq5uQhJKdOODBwWs3Rpw4
         W4TVWu2BZGMCUgpXndEhVuPeaCQP1CG1PDy0ohqVhDgWvDhxAXsiGCgyI/zvbZNnChbh
         xavA==
X-Gm-Message-State: AOAM532uAsav1597WnScv4i9TEdQhnpuezPkx2OnkyqkXc4MZ68JEdla
        PEshzdpXMeh+kOBqfXhHatGSOR769IyzWQ==
X-Google-Smtp-Source: ABdhPJy3lka870xa8XlfbNt22sIwH0/xXExdqyGdWA4JxBQGedOAgCWjbfJVSbfkPnLbjyVrgC8Plg==
X-Received: by 2002:a05:6a00:21c8:b0:4a8:125:de32 with SMTP id t8-20020a056a0021c800b004a80125de32mr5969607pfj.49.1640335401680;
        Fri, 24 Dec 2021 00:43:21 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:fd40:cbd0:c42a:3c26])
        by smtp.gmail.com with ESMTPSA id p13sm436369pgl.23.2021.12.24.00.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 00:43:21 -0800 (PST)
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
Subject: [PATCH RFT 2/7] media: hantro: Fix overfill bottom register field name
Date:   Fri, 24 Dec 2021 16:42:43 +0800
Message-Id: <20211224084248.3070568-3-wenst@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20211224084248.3070568-1-wenst@chromium.org>
References: <20211224084248.3070568-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Hantro H1 hardware can crop off pixels from the right and bottom of
the source frame. These are controlled with the H1_REG_IN_IMG_CTRL_OVRFLB
and H1_REG_IN_IMG_CTRL_OVRFLR in the H1_REG_IN_IMG_CTRL register.

The ChromeOS kernel driver that this was based on incorrectly added the
_D4 suffix H1_REG_IN_IMG_CTRL_OVRFLB. This field crops the bottom of the
input frame, and the number is _not_ divided by 4. [1]

Correct the name to avoid confusion when crop support with the selection
API is added.

[1] https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/ \
	heads/chromeos-4.19/drivers/staging/media/hantro/hantro_h1_vp8_enc.c#377

Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
Fixes: a29add8c9bb2 ("media: rockchip/vpu: rename from rockchip to hantro")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/staging/media/hantro/hantro_h1_jpeg_enc.c | 2 +-
 drivers/staging/media/hantro/hantro_h1_regs.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c b/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c
index 03db1c3444f8..96153c755fb8 100644
--- a/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c
+++ b/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c
@@ -23,7 +23,7 @@ static void hantro_h1_set_src_img_ctrl(struct hantro_dev *vpu,
 
 	reg = H1_REG_IN_IMG_CTRL_ROW_LEN(pix_fmt->width)
 		| H1_REG_IN_IMG_CTRL_OVRFLR_D4(0)
-		| H1_REG_IN_IMG_CTRL_OVRFLB_D4(0)
+		| H1_REG_IN_IMG_CTRL_OVRFLB(0)
 		| H1_REG_IN_IMG_CTRL_FMT(ctx->vpu_src_fmt->enc_fmt);
 	vepu_write_relaxed(vpu, reg, H1_REG_IN_IMG_CTRL);
 }
diff --git a/drivers/staging/media/hantro/hantro_h1_regs.h b/drivers/staging/media/hantro/hantro_h1_regs.h
index d6e9825bb5c7..30e7e7b920b5 100644
--- a/drivers/staging/media/hantro/hantro_h1_regs.h
+++ b/drivers/staging/media/hantro/hantro_h1_regs.h
@@ -47,7 +47,7 @@
 #define H1_REG_IN_IMG_CTRL				0x03c
 #define     H1_REG_IN_IMG_CTRL_ROW_LEN(x)		((x) << 12)
 #define     H1_REG_IN_IMG_CTRL_OVRFLR_D4(x)		((x) << 10)
-#define     H1_REG_IN_IMG_CTRL_OVRFLB_D4(x)		((x) << 6)
+#define     H1_REG_IN_IMG_CTRL_OVRFLB(x)		((x) << 6)
 #define     H1_REG_IN_IMG_CTRL_FMT(x)			((x) << 2)
 #define H1_REG_ENC_CTRL0				0x040
 #define    H1_REG_ENC_CTRL0_INIT_QP(x)			((x) << 26)
-- 
2.34.1.448.ga2b2bfdf31-goog

