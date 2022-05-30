Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBCA538700
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 20:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240862AbiE3SEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 14:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiE3SEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:04:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D312A205F
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 11:03:58 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e2so15711029wrc.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 11:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eEF/THqP4/KMnhR3Jx46Pp2/fGel1OrMSQe1WykeaFE=;
        b=YjA/47czGUZcB3jHTGA93lpns9MvpQGWDsDLKqd8CFUEsg1VNHhCm2d7nwCGBfQvja
         E7bGvlwNaBeG/I0zVOqu77Y2ZNhxxc3/1DkrFu6rxz08JUgpYX1cMjrVpm+M9HET6FRa
         yS5VYOlJEUvUzgwXXhnfX7VhNKQvOninG0lZEJqPss8cwi0GrsZtu0pdyN6SIsiy55+m
         oW4sbMy84PoQgMFQ1rI0dknEbE8i08PEYhC+NU3e4mv5JCYQYqyOedDXKp5i4CsYMfDB
         wtXofgV58zwq8U8hgNi42vXMkUF6nmV31OKlRYNzQpZ+7K70ot1UtCVuanhwp9pxzAlz
         NGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eEF/THqP4/KMnhR3Jx46Pp2/fGel1OrMSQe1WykeaFE=;
        b=OtXqgdg0U9PWgTSk72WPrXwTkgUhBD2rT9DY3kEr8FGoBNjmWG/9Pz4Eyo5lmniKuh
         eHyoyscOdxYkgJEhK+NuYh9YTBfP0SI1H2UtgOHQDbuB5ZGJ1jDzFK+B0gan8PMie3Bj
         p3qGN/ZLH7ikk0NKdLbZBSP7YTZ7E9v1LVowBwnIkmi21hbPCj8ZjVm59qQgFpnF2KoX
         Q8Dc+Bs1j2yDNcKPUom66dZU0H9CW+GtXH2fOpYMSxtrMQZrgk1dMoM/Vwn1n8sSEy19
         Va8wKPhAbuROD4WpDdSWvFMRfqPLYNZWw4CxZFJx4pywSqYlrFmPKWjBz70yzCdB1Xt+
         GI8Q==
X-Gm-Message-State: AOAM530rTaO/0wZieAYeUhYp2oefPj9lMlIarahuCcYBEswi5q6RIVT5
        QfDoSQxUXkiprBtkpjSVaDoAqA==
X-Google-Smtp-Source: ABdhPJwy5EGuO92uUYbYm+RoosB6dUYzPz/zHdWaBA9pWwIWvfY+x51eD4gAdsAxVp9Fy19bMTkIcg==
X-Received: by 2002:a5d:6a92:0:b0:210:3387:23ec with SMTP id s18-20020a5d6a92000000b00210338723ecmr5422504wru.102.1653933836689;
        Mon, 30 May 2022 11:03:56 -0700 (PDT)
Received: from helium.lan ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id 9-20020a1c0209000000b00397550b387bsm1647wmc.23.2022.05.30.11.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 11:03:55 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] dt-bindings: iommu: mediatek: add binding documentation for MT8365 SoC
Date:   Mon, 30 May 2022 20:03:26 +0200
Message-Id: <20220530180328.845692-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
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

Add IOMMU binding documentation for the MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../bindings/iommu/mediatek,iommu.yaml        |  2 +
 include/dt-bindings/memory/mt8365-larb-port.h | 96 +++++++++++++++++++
 2 files changed, 98 insertions(+)
 create mode 100644 include/dt-bindings/memory/mt8365-larb-port.h

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index 97e8c471a5e8..5ba688365da5 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -77,6 +77,7 @@ properties:
           - mediatek,mt8173-m4u  # generation two
           - mediatek,mt8183-m4u  # generation two
           - mediatek,mt8192-m4u  # generation two
+          - mediatek,mt8365-m4u  # generation two
 
       - description: mt7623 generation one
         items:
@@ -120,6 +121,7 @@ properties:
       dt-binding/memory/mt8173-larb-port.h for mt8173,
       dt-binding/memory/mt8183-larb-port.h for mt8183,
       dt-binding/memory/mt8192-larb-port.h for mt8192.
+      dt-binding/memory/mt8365-larb-port.h for mt8365.
 
   power-domains:
     maxItems: 1
diff --git a/include/dt-bindings/memory/mt8365-larb-port.h b/include/dt-bindings/memory/mt8365-larb-port.h
new file mode 100644
index 000000000000..e7d5637aa38e
--- /dev/null
+++ b/include/dt-bindings/memory/mt8365-larb-port.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Yong Wu <yong.wu@mediatek.com>
+ */
+#ifndef _DT_BINDINGS_MEMORY_MT8365_LARB_PORT_H_
+#define _DT_BINDINGS_MEMORY_MT8365_LARB_PORT_H_
+
+#include <dt-bindings/memory/mtk-memory-port.h>
+
+#define M4U_LARB0_ID			0
+#define M4U_LARB1_ID			1
+#define M4U_LARB2_ID			2
+#define M4U_LARB3_ID			3
+#define M4U_LARB4_ID			4
+#define M4U_LARB5_ID			5
+#define M4U_LARB6_ID			6
+#define M4U_LARB7_ID			7
+
+/* larb0 */
+#define M4U_PORT_DISP_OVL0		MTK_M4U_ID(0, 0)
+#define M4U_PORT_DISP_OVL0_2L		MTK_M4U_ID(0, 1)
+#define M4U_PORT_DISP_RDMA0		MTK_M4U_ID(0, 2)
+#define M4U_PORT_DISP_WDMA0		MTK_M4U_ID(0, 3)
+#define M4U_PORT_DISP_RDMA1		MTK_M4U_ID(0, 4)
+#define M4U_PORT_MDP_RDMA0		MTK_M4U_ID(0, 5)
+#define M4U_PORT_MDP_WROT1		MTK_M4U_ID(0, 6)
+#define M4U_PORT_MDP_WROT0		MTK_M4U_ID(0, 7)
+#define M4U_PORT_MDP_RDMA1		MTK_M4U_ID(0, 8)
+#define M4U_PORT_DISP_FAKE0		MTK_M4U_ID(0, 9)
+
+/* larb1 */
+#define M4U_PORT_VENC_RCPU		MTK_M4U_ID(1, 0)
+#define M4U_PORT_VENC_REC		MTK_M4U_ID(1, 1)
+#define M4U_PORT_VENC_BSDMA		MTK_M4U_ID(1, 2)
+#define M4U_PORT_VENC_SV_COMV		MTK_M4U_ID(1, 3)
+#define M4U_PORT_VENC_RD_COMV		MTK_M4U_ID(1, 4)
+#define M4U_PORT_VENC_NBM_RDMA		MTK_M4U_ID(1, 5)
+#define M4U_PORT_VENC_NBM_RDMA_LITE	MTK_M4U_ID(1, 6)
+#define M4U_PORT_JPGENC_Y_RDMA		MTK_M4U_ID(1, 7)
+#define M4U_PORT_JPGENC_C_RDMA		MTK_M4U_ID(1, 8)
+#define M4U_PORT_JPGENC_Q_TABLE		MTK_M4U_ID(1, 9)
+#define M4U_PORT_JPGENC_BSDMA		MTK_M4U_ID(1, 10)
+#define M4U_PORT_JPGDEC_WDMA		MTK_M4U_ID(1, 11)
+#define M4U_PORT_JPGDEC_BSDMA		MTK_M4U_ID(1, 12)
+#define M4U_PORT_VENC_NBM_WDMA		MTK_M4U_ID(1, 13)
+#define M4U_PORT_VENC_NBM_WDMA_LITE	MTK_M4U_ID(1, 14)
+#define M4U_PORT_VENC_CUR_LUMA		MTK_M4U_ID(1, 15)
+#define M4U_PORT_VENC_CUR_CHROMA	MTK_M4U_ID(1, 16)
+#define M4U_PORT_VENC_REF_LUMA		MTK_M4U_ID(1, 17)
+#define M4U_PORT_VENC_REF_CHROMA	MTK_M4U_ID(1, 18)
+
+/* larb2 */
+#define M4U_PORT_CAM_IMGO		MTK_M4U_ID(2, 0)
+#define M4U_PORT_CAM_RRZO		MTK_M4U_ID(2, 1)
+#define M4U_PORT_CAM_AAO		MTK_M4U_ID(2, 2)
+#define M4U_PORT_CAM_LCS		MTK_M4U_ID(2, 3)
+#define M4U_PORT_CAM_ESFKO		MTK_M4U_ID(2, 4)
+#define M4U_PORT_CAM_CAM_SV0		MTK_M4U_ID(2, 5)
+#define M4U_PORT_CAM_CAM_SV1		MTK_M4U_ID(2, 6)
+#define M4U_PORT_CAM_LSCI		MTK_M4U_ID(2, 7)
+#define M4U_PORT_CAM_LSCI_D		MTK_M4U_ID(2, 8)
+#define M4U_PORT_CAM_AFO		MTK_M4U_ID(2, 9)
+#define M4U_PORT_CAM_SPARE		MTK_M4U_ID(2, 10)
+#define M4U_PORT_CAM_BPCI		MTK_M4U_ID(2, 11)
+#define M4U_PORT_CAM_BPCI_D		MTK_M4U_ID(2, 12)
+#define M4U_PORT_CAM_UFDI		MTK_M4U_ID(2, 13)
+#define M4U_PORT_CAM_IMGI		MTK_M4U_ID(2, 14)
+#define M4U_PORT_CAM_IMG2O		MTK_M4U_ID(2, 15)
+#define M4U_PORT_CAM_IMG3O		MTK_M4U_ID(2, 16)
+#define M4U_PORT_CAM_WPE0_I		MTK_M4U_ID(2, 17)
+#define M4U_PORT_CAM_WPE1_I		MTK_M4U_ID(2, 18)
+#define M4U_PORT_CAM_WPE_O		MTK_M4U_ID(2, 19)
+#define M4U_PORT_CAM_FD0_I		MTK_M4U_ID(2, 20)
+#define M4U_PORT_CAM_FD1_I		MTK_M4U_ID(2, 21)
+#define M4U_PORT_CAM_FD0_O		MTK_M4U_ID(2, 22)
+#define M4U_PORT_CAM_FD1_O		MTK_M4U_ID(2, 23)
+
+/* larb3 */
+#define M4U_PORT_HW_VDEC_MC_EXT		MTK_M4U_ID(3, 0)
+#define M4U_PORT_HW_VDEC_UFO_EXT	MTK_M4U_ID(3, 1)
+#define M4U_PORT_HW_VDEC_PP_EXT		MTK_M4U_ID(3, 2)
+#define M4U_PORT_HW_VDEC_PRED_RD_EXT	MTK_M4U_ID(3, 3)
+#define M4U_PORT_HW_VDEC_PRED_WR_EXT	MTK_M4U_ID(3, 4)
+#define M4U_PORT_HW_VDEC_PPWRAP_EXT	MTK_M4U_ID(3, 5)
+#define M4U_PORT_HW_VDEC_TILE_EXT	MTK_M4U_ID(3, 6)
+#define M4U_PORT_HW_VDEC_VLD_EXT	MTK_M4U_ID(3, 7)
+#define M4U_PORT_HW_VDEC_VLD2_EXT	MTK_M4U_ID(3, 8)
+#define M4U_PORT_HW_VDEC_AVC_MV_EXT	MTK_M4U_ID(3, 9)
+#define M4U_PORT_HW_VDEC_RG_CTRL_DMA_EXT MTK_M4U_ID(3, 10)
+
+/* larb4 */
+#define M4U_PORT_APU_READ		MTK_M4U_ID(0, 0)
+#define M4U_PORT_APU_WRITE		MTK_M4U_ID(0, 1)
+
+#endif
-- 
2.36.1

