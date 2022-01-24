Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBB14978F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 07:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241635AbiAXGeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 01:34:17 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:44103 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241644AbiAXGeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 01:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643006055; x=1674542055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DQWaPQ+0rviNbgTffzEDspCm5f8s267jdCGIyLu/vFM=;
  b=P0QUnxpWfjz0jqBWwpqs73TMd4U0WlkUfJ73IZIByen7AOFXQcVG7Rua
   h5c4hLJb0YFDh0Llb3jlYmnc6E7roZFF2ihkNwF3QET2A3pyn8t5ShVu0
   7cBYuHfrRiUv18daXrO3KnuSNsUcZ1+b0q+4YsTs81Gm0AySs1X0U27y2
   s=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 23 Jan 2022 22:34:15 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 22:34:15 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 23 Jan 2022 22:34:14 -0800
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 23 Jan 2022 22:34:09 -0800
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     gregkh <gregkh@linuxfoundation.org>, <quic_psodagud@quicinc.com>,
        "Trilok Soni" <quic_tsoni@quicinc.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCHv9 3/5] drm/meson: Fix overflow implicit truncation warnings
Date:   Mon, 24 Jan 2022 12:03:32 +0530
Message-ID: <b5e5b45bcb7b022147dc0036daf35d72d102e946.1642482334.git.quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1642482334.git.quic_saipraka@quicinc.com>
References: <cover.1642482334.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix -Woverflow warnings for drm/meson driver which is a result
of moving arm64 custom MMIO accessor macros to asm-generic function
implementations giving a bonus type-checking now and uncovering these
overflow warnings.

drivers/gpu/drm/meson/meson_viu.c: In function ‘meson_viu_init’:
drivers/gpu/drm/meson/meson_registers.h:1826:48: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
 #define  VIU_OSD_BLEND_REORDER(dest, src)      ((src) << (dest * 4))
                                                ^
drivers/gpu/drm/meson/meson_viu.c:472:18: note: in expansion of macro ‘VIU_OSD_BLEND_REORDER’
   writel_relaxed(VIU_OSD_BLEND_REORDER(0, 1) |
                  ^~~~~~~~~~~~~~~~~~~~~

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
---
 drivers/gpu/drm/meson/meson_viu.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_viu.c b/drivers/gpu/drm/meson/meson_viu.c
index 259f3e6bec90..bb7e109534de 100644
--- a/drivers/gpu/drm/meson/meson_viu.c
+++ b/drivers/gpu/drm/meson/meson_viu.c
@@ -469,17 +469,17 @@ void meson_viu_init(struct meson_drm *priv)
 			priv->io_base + _REG(VD2_IF0_LUMA_FIFO_SIZE));
 
 	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
-		writel_relaxed(VIU_OSD_BLEND_REORDER(0, 1) |
-			       VIU_OSD_BLEND_REORDER(1, 0) |
-			       VIU_OSD_BLEND_REORDER(2, 0) |
-			       VIU_OSD_BLEND_REORDER(3, 0) |
-			       VIU_OSD_BLEND_DIN_EN(1) |
-			       VIU_OSD_BLEND1_DIN3_BYPASS_TO_DOUT1 |
-			       VIU_OSD_BLEND1_DOUT_BYPASS_TO_BLEND2 |
-			       VIU_OSD_BLEND_DIN0_BYPASS_TO_DOUT0 |
-			       VIU_OSD_BLEND_BLEN2_PREMULT_EN(1) |
-			       VIU_OSD_BLEND_HOLD_LINES(4),
-			       priv->io_base + _REG(VIU_OSD_BLEND_CTRL));
+		u32 val = (u32)VIU_OSD_BLEND_REORDER(0, 1) |
+			  (u32)VIU_OSD_BLEND_REORDER(1, 0) |
+			  (u32)VIU_OSD_BLEND_REORDER(2, 0) |
+			  (u32)VIU_OSD_BLEND_REORDER(3, 0) |
+			  (u32)VIU_OSD_BLEND_DIN_EN(1) |
+			  (u32)VIU_OSD_BLEND1_DIN3_BYPASS_TO_DOUT1 |
+			  (u32)VIU_OSD_BLEND1_DOUT_BYPASS_TO_BLEND2 |
+			  (u32)VIU_OSD_BLEND_DIN0_BYPASS_TO_DOUT0 |
+			  (u32)VIU_OSD_BLEND_BLEN2_PREMULT_EN(1) |
+			  (u32)VIU_OSD_BLEND_HOLD_LINES(4);
+		writel_relaxed(val, priv->io_base + _REG(VIU_OSD_BLEND_CTRL));
 
 		writel_relaxed(OSD_BLEND_PATH_SEL_ENABLE,
 			       priv->io_base + _REG(OSD1_BLEND_SRC_CTRL));
-- 
2.33.1

