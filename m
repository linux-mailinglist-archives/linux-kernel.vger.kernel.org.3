Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8B0519DFD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348789AbiEDLc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348781AbiEDLcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:32:51 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE111ADA8;
        Wed,  4 May 2022 04:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651663756; x=1683199756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Os8aG/GdpU99rvd0ouHCuTPWhAHDiOeHpDYUMpv2miY=;
  b=syLFGaUOw9ZkzjPpRpCHgfoW6b1akqg8/5XNlqeZAxdC/XO7u0gfYgpS
   dz4G8O3fBMDLdI9CqSfGhR3GBs0CQPKqzhJphskBCl70kmZktvFJDYKgq
   9SAc0hdI+OtVOWSnBbXYfZ0DvzWiOTa/E+YiptNm91+TiPPGSRwJgWWiz
   Y=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 04 May 2022 04:29:16 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 04:29:15 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 4 May 2022 04:29:15 -0700
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 4 May 2022 04:29:10 -0700
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     <arnd@arndb.de>, <catalin.marinas@arm.com>, <rostedt@goodmis.org>
CC:     <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <maz@kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_tsoni@quicinc.com>, <will@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        "Neil Armstrong" <narmstrong@baylibre.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCHv14 4/9] drm/meson: Fix overflow implicit truncation warnings
Date:   Wed, 4 May 2022 16:58:23 +0530
Message-ID: <6064ec7d0f21ccaee91b02da72b4a9dc8fda7a79.1651663123.git.quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1651663123.git.quic_saipraka@quicinc.com>
References: <cover.1651663123.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
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

