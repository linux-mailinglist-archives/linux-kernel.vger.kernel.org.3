Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1438477265
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbhLPM56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:57:58 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44256 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237083AbhLPM55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:57:57 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 4CFF91F46288
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639659475; bh=KFuMBQfVL28/kfB5f81HGzz+sMyNbLb3OFS9ZTL2CQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=czehGqNztf0K2oYqk4TThOGz/MaXf9eaemF3y53YIlmZhuI3qf5eJYnufTfXOPpYC
         Yp3wA96fNdP3ppiKtqh63jSRGfQdA5NSFn4RyEMeLtwB+bgEEetRGJ8JVu1WVAbjdT
         OynlAkPg2aMaZdeJyMfOdwKmlv1xJTITLCzaL4sYhScVwUp22cwbSCvRWQCmIel2tK
         Y0MhbSo7VRH8vlGbdglxZmg95s0vnoi1ZdXQjWalT3tYOLQpJCf/nE6tjQeuAmRIzX
         YdnR+CK/asrCxE4o2attRi9gW+MYIDnrYgFT5WXia+2MujEQMO5InBRwurqzWJ2dAo
         kgwa/t31yjvZg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chaotian.jing@mediatek.com
Cc:     ulf.hansson@linaro.org, matthias.bgg@gmail.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 2/5] mmc: mtk-sd: Use BIT() and GENMASK() macros to describe fields
Date:   Thu, 16 Dec 2021 13:57:45 +0100
Message-Id: <20211216125748.179602-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211216125748.179602-1-angelogioacchino.delregno@collabora.com>
References: <20211216125748.179602-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register fields are currently represented with open-coded bit
shifting: replace all occurrences of that to make use of kernel
provided macros BIT and GENMASK to increase human readability.

This patch provides no functional change.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/mmc/host/mtk-sd.c | 437 +++++++++++++++++++-------------------
 1 file changed, 219 insertions(+), 218 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index d5a9c269d492..d067636434ca 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
@@ -98,226 +99,226 @@
 /*--------------------------------------------------------------------------*/
 
 /* MSDC_CFG mask */
-#define MSDC_CFG_MODE           (0x1 << 0)	/* RW */
-#define MSDC_CFG_CKPDN          (0x1 << 1)	/* RW */
-#define MSDC_CFG_RST            (0x1 << 2)	/* RW */
-#define MSDC_CFG_PIO            (0x1 << 3)	/* RW */
-#define MSDC_CFG_CKDRVEN        (0x1 << 4)	/* RW */
-#define MSDC_CFG_BV18SDT        (0x1 << 5)	/* RW */
-#define MSDC_CFG_BV18PSS        (0x1 << 6)	/* R  */
-#define MSDC_CFG_CKSTB          (0x1 << 7)	/* R  */
-#define MSDC_CFG_CKDIV          (0xff << 8)	/* RW */
-#define MSDC_CFG_CKMOD          (0x3 << 16)	/* RW */
-#define MSDC_CFG_HS400_CK_MODE  (0x1 << 18)	/* RW */
-#define MSDC_CFG_HS400_CK_MODE_EXTRA  (0x1 << 22)	/* RW */
-#define MSDC_CFG_CKDIV_EXTRA    (0xfff << 8)	/* RW */
-#define MSDC_CFG_CKMOD_EXTRA    (0x3 << 20)	/* RW */
+#define MSDC_CFG_MODE           BIT(0)	/* RW */
+#define MSDC_CFG_CKPDN          BIT(1)	/* RW */
+#define MSDC_CFG_RST            BIT(2)	/* RW */
+#define MSDC_CFG_PIO            BIT(3)	/* RW */
+#define MSDC_CFG_CKDRVEN        BIT(4)	/* RW */
+#define MSDC_CFG_BV18SDT        BIT(5)	/* RW */
+#define MSDC_CFG_BV18PSS        BIT(6)	/* R  */
+#define MSDC_CFG_CKSTB          BIT(7)	/* R  */
+#define MSDC_CFG_CKDIV          GENMASK(15, 8)	/* RW */
+#define MSDC_CFG_CKMOD          GENMASK(17, 16)	/* RW */
+#define MSDC_CFG_HS400_CK_MODE  BIT(18)	/* RW */
+#define MSDC_CFG_HS400_CK_MODE_EXTRA  BIT(22)	/* RW */
+#define MSDC_CFG_CKDIV_EXTRA    GENMASK(19, 8)	/* RW */
+#define MSDC_CFG_CKMOD_EXTRA    GENMASK(21, 20)	/* RW */
 
 /* MSDC_IOCON mask */
-#define MSDC_IOCON_SDR104CKS    (0x1 << 0)	/* RW */
-#define MSDC_IOCON_RSPL         (0x1 << 1)	/* RW */
-#define MSDC_IOCON_DSPL         (0x1 << 2)	/* RW */
-#define MSDC_IOCON_DDLSEL       (0x1 << 3)	/* RW */
-#define MSDC_IOCON_DDR50CKD     (0x1 << 4)	/* RW */
-#define MSDC_IOCON_DSPLSEL      (0x1 << 5)	/* RW */
-#define MSDC_IOCON_W_DSPL       (0x1 << 8)	/* RW */
-#define MSDC_IOCON_D0SPL        (0x1 << 16)	/* RW */
-#define MSDC_IOCON_D1SPL        (0x1 << 17)	/* RW */
-#define MSDC_IOCON_D2SPL        (0x1 << 18)	/* RW */
-#define MSDC_IOCON_D3SPL        (0x1 << 19)	/* RW */
-#define MSDC_IOCON_D4SPL        (0x1 << 20)	/* RW */
-#define MSDC_IOCON_D5SPL        (0x1 << 21)	/* RW */
-#define MSDC_IOCON_D6SPL        (0x1 << 22)	/* RW */
-#define MSDC_IOCON_D7SPL        (0x1 << 23)	/* RW */
-#define MSDC_IOCON_RISCSZ       (0x3 << 24)	/* RW */
+#define MSDC_IOCON_SDR104CKS    BIT(0)	/* RW */
+#define MSDC_IOCON_RSPL         BIT(1)	/* RW */
+#define MSDC_IOCON_DSPL         BIT(2)	/* RW */
+#define MSDC_IOCON_DDLSEL       BIT(3)	/* RW */
+#define MSDC_IOCON_DDR50CKD     BIT(4)	/* RW */
+#define MSDC_IOCON_DSPLSEL      BIT(5)	/* RW */
+#define MSDC_IOCON_W_DSPL       BIT(8)	/* RW */
+#define MSDC_IOCON_D0SPL        BIT(16)	/* RW */
+#define MSDC_IOCON_D1SPL        BIT(17)	/* RW */
+#define MSDC_IOCON_D2SPL        BIT(18)	/* RW */
+#define MSDC_IOCON_D3SPL        BIT(19)	/* RW */
+#define MSDC_IOCON_D4SPL        BIT(20)	/* RW */
+#define MSDC_IOCON_D5SPL        BIT(21)	/* RW */
+#define MSDC_IOCON_D6SPL        BIT(22)	/* RW */
+#define MSDC_IOCON_D7SPL        BIT(23)	/* RW */
+#define MSDC_IOCON_RISCSZ       GENMASK(25, 24)	/* RW */
 
 /* MSDC_PS mask */
-#define MSDC_PS_CDEN            (0x1 << 0)	/* RW */
-#define MSDC_PS_CDSTS           (0x1 << 1)	/* R  */
-#define MSDC_PS_CDDEBOUNCE      (0xf << 12)	/* RW */
-#define MSDC_PS_DAT             (0xff << 16)	/* R  */
-#define MSDC_PS_DATA1           (0x1 << 17)	/* R  */
-#define MSDC_PS_CMD             (0x1 << 24)	/* R  */
-#define MSDC_PS_WP              (0x1 << 31)	/* R  */
+#define MSDC_PS_CDEN            BIT(0)	/* RW */
+#define MSDC_PS_CDSTS           BIT(1)	/* R  */
+#define MSDC_PS_CDDEBOUNCE      GENMASK(15, 12)	/* RW */
+#define MSDC_PS_DAT             GENMASK(23, 16)	/* R  */
+#define MSDC_PS_DATA1           BIT(17)	/* R  */
+#define MSDC_PS_CMD             BIT(24)	/* R  */
+#define MSDC_PS_WP              BIT(31)	/* R  */
 
 /* MSDC_INT mask */
-#define MSDC_INT_MMCIRQ         (0x1 << 0)	/* W1C */
-#define MSDC_INT_CDSC           (0x1 << 1)	/* W1C */
-#define MSDC_INT_ACMDRDY        (0x1 << 3)	/* W1C */
-#define MSDC_INT_ACMDTMO        (0x1 << 4)	/* W1C */
-#define MSDC_INT_ACMDCRCERR     (0x1 << 5)	/* W1C */
-#define MSDC_INT_DMAQ_EMPTY     (0x1 << 6)	/* W1C */
-#define MSDC_INT_SDIOIRQ        (0x1 << 7)	/* W1C */
-#define MSDC_INT_CMDRDY         (0x1 << 8)	/* W1C */
-#define MSDC_INT_CMDTMO         (0x1 << 9)	/* W1C */
-#define MSDC_INT_RSPCRCERR      (0x1 << 10)	/* W1C */
-#define MSDC_INT_CSTA           (0x1 << 11)	/* R */
-#define MSDC_INT_XFER_COMPL     (0x1 << 12)	/* W1C */
-#define MSDC_INT_DXFER_DONE     (0x1 << 13)	/* W1C */
-#define MSDC_INT_DATTMO         (0x1 << 14)	/* W1C */
-#define MSDC_INT_DATCRCERR      (0x1 << 15)	/* W1C */
-#define MSDC_INT_ACMD19_DONE    (0x1 << 16)	/* W1C */
-#define MSDC_INT_DMA_BDCSERR    (0x1 << 17)	/* W1C */
-#define MSDC_INT_DMA_GPDCSERR   (0x1 << 18)	/* W1C */
-#define MSDC_INT_DMA_PROTECT    (0x1 << 19)	/* W1C */
-#define MSDC_INT_CMDQ           (0x1 << 28)	/* W1C */
+#define MSDC_INT_MMCIRQ         BIT(0)	/* W1C */
+#define MSDC_INT_CDSC           BIT(1)	/* W1C */
+#define MSDC_INT_ACMDRDY        BIT(3)	/* W1C */
+#define MSDC_INT_ACMDTMO        BIT(4)	/* W1C */
+#define MSDC_INT_ACMDCRCERR     BIT(5)	/* W1C */
+#define MSDC_INT_DMAQ_EMPTY     BIT(6)	/* W1C */
+#define MSDC_INT_SDIOIRQ        BIT(7)	/* W1C */
+#define MSDC_INT_CMDRDY         BIT(8)	/* W1C */
+#define MSDC_INT_CMDTMO         BIT(9)	/* W1C */
+#define MSDC_INT_RSPCRCERR      BIT(10)	/* W1C */
+#define MSDC_INT_CSTA           BIT(11)	/* R */
+#define MSDC_INT_XFER_COMPL     BIT(12)	/* W1C */
+#define MSDC_INT_DXFER_DONE     BIT(13)	/* W1C */
+#define MSDC_INT_DATTMO         BIT(14)	/* W1C */
+#define MSDC_INT_DATCRCERR      BIT(15)	/* W1C */
+#define MSDC_INT_ACMD19_DONE    BIT(16)	/* W1C */
+#define MSDC_INT_DMA_BDCSERR    BIT(17)	/* W1C */
+#define MSDC_INT_DMA_GPDCSERR   BIT(18)	/* W1C */
+#define MSDC_INT_DMA_PROTECT    BIT(19)	/* W1C */
+#define MSDC_INT_CMDQ           BIT(28)	/* W1C */
 
 /* MSDC_INTEN mask */
-#define MSDC_INTEN_MMCIRQ       (0x1 << 0)	/* RW */
-#define MSDC_INTEN_CDSC         (0x1 << 1)	/* RW */
-#define MSDC_INTEN_ACMDRDY      (0x1 << 3)	/* RW */
-#define MSDC_INTEN_ACMDTMO      (0x1 << 4)	/* RW */
-#define MSDC_INTEN_ACMDCRCERR   (0x1 << 5)	/* RW */
-#define MSDC_INTEN_DMAQ_EMPTY   (0x1 << 6)	/* RW */
-#define MSDC_INTEN_SDIOIRQ      (0x1 << 7)	/* RW */
-#define MSDC_INTEN_CMDRDY       (0x1 << 8)	/* RW */
-#define MSDC_INTEN_CMDTMO       (0x1 << 9)	/* RW */
-#define MSDC_INTEN_RSPCRCERR    (0x1 << 10)	/* RW */
-#define MSDC_INTEN_CSTA         (0x1 << 11)	/* RW */
-#define MSDC_INTEN_XFER_COMPL   (0x1 << 12)	/* RW */
-#define MSDC_INTEN_DXFER_DONE   (0x1 << 13)	/* RW */
-#define MSDC_INTEN_DATTMO       (0x1 << 14)	/* RW */
-#define MSDC_INTEN_DATCRCERR    (0x1 << 15)	/* RW */
-#define MSDC_INTEN_ACMD19_DONE  (0x1 << 16)	/* RW */
-#define MSDC_INTEN_DMA_BDCSERR  (0x1 << 17)	/* RW */
-#define MSDC_INTEN_DMA_GPDCSERR (0x1 << 18)	/* RW */
-#define MSDC_INTEN_DMA_PROTECT  (0x1 << 19)	/* RW */
+#define MSDC_INTEN_MMCIRQ       BIT(0)	/* RW */
+#define MSDC_INTEN_CDSC         BIT(1)	/* RW */
+#define MSDC_INTEN_ACMDRDY      BIT(3)	/* RW */
+#define MSDC_INTEN_ACMDTMO      BIT(4)	/* RW */
+#define MSDC_INTEN_ACMDCRCERR   BIT(5)	/* RW */
+#define MSDC_INTEN_DMAQ_EMPTY   BIT(6)	/* RW */
+#define MSDC_INTEN_SDIOIRQ      BIT(7)	/* RW */
+#define MSDC_INTEN_CMDRDY       BIT(8)	/* RW */
+#define MSDC_INTEN_CMDTMO       BIT(9)	/* RW */
+#define MSDC_INTEN_RSPCRCERR    BIT(10)	/* RW */
+#define MSDC_INTEN_CSTA         BIT(11)	/* RW */
+#define MSDC_INTEN_XFER_COMPL   BIT(12)	/* RW */
+#define MSDC_INTEN_DXFER_DONE   BIT(13)	/* RW */
+#define MSDC_INTEN_DATTMO       BIT(14)	/* RW */
+#define MSDC_INTEN_DATCRCERR    BIT(15)	/* RW */
+#define MSDC_INTEN_ACMD19_DONE  BIT(16)	/* RW */
+#define MSDC_INTEN_DMA_BDCSERR  BIT(17)	/* RW */
+#define MSDC_INTEN_DMA_GPDCSERR BIT(18)	/* RW */
+#define MSDC_INTEN_DMA_PROTECT  BIT(19)	/* RW */
 
 /* MSDC_FIFOCS mask */
-#define MSDC_FIFOCS_RXCNT       (0xff << 0)	/* R */
-#define MSDC_FIFOCS_TXCNT       (0xff << 16)	/* R */
-#define MSDC_FIFOCS_CLR         (0x1 << 31)	/* RW */
+#define MSDC_FIFOCS_RXCNT       GENMASK(7, 0)	/* R */
+#define MSDC_FIFOCS_TXCNT       GENMASK(23, 16)	/* R */
+#define MSDC_FIFOCS_CLR         BIT(31)	/* RW */
 
 /* SDC_CFG mask */
-#define SDC_CFG_SDIOINTWKUP     (0x1 << 0)	/* RW */
-#define SDC_CFG_INSWKUP         (0x1 << 1)	/* RW */
-#define SDC_CFG_WRDTOC          (0x1fff  << 2)  /* RW */
-#define SDC_CFG_BUSWIDTH        (0x3 << 16)	/* RW */
-#define SDC_CFG_SDIO            (0x1 << 19)	/* RW */
-#define SDC_CFG_SDIOIDE         (0x1 << 20)	/* RW */
-#define SDC_CFG_INTATGAP        (0x1 << 21)	/* RW */
-#define SDC_CFG_DTOC            (0xff << 24)	/* RW */
+#define SDC_CFG_SDIOINTWKUP     BIT(0)	/* RW */
+#define SDC_CFG_INSWKUP         BIT(1)	/* RW */
+#define SDC_CFG_WRDTOC          GENMASK(14, 2)  /* RW */
+#define SDC_CFG_BUSWIDTH        GENMASK(17, 16)	/* RW */
+#define SDC_CFG_SDIO            BIT(19)	/* RW */
+#define SDC_CFG_SDIOIDE         BIT(20)	/* RW */
+#define SDC_CFG_INTATGAP        BIT(21)	/* RW */
+#define SDC_CFG_DTOC            GENMASK(31, 24)	/* RW */
 
 /* SDC_STS mask */
-#define SDC_STS_SDCBUSY         (0x1 << 0)	/* RW */
-#define SDC_STS_CMDBUSY         (0x1 << 1)	/* RW */
-#define SDC_STS_SWR_COMPL       (0x1 << 31)	/* RW */
+#define SDC_STS_SDCBUSY         BIT(0)	/* RW */
+#define SDC_STS_CMDBUSY         BIT(1)	/* RW */
+#define SDC_STS_SWR_COMPL       BIT(31)	/* RW */
 
-#define SDC_DAT1_IRQ_TRIGGER	(0x1 << 19)	/* RW */
+#define SDC_DAT1_IRQ_TRIGGER	BIT(19)	/* RW */
 /* SDC_ADV_CFG0 mask */
-#define SDC_RX_ENHANCE_EN	(0x1 << 20)	/* RW */
+#define SDC_RX_ENHANCE_EN	BIT(20)	/* RW */
 
 /* DMA_SA_H4BIT mask */
-#define DMA_ADDR_HIGH_4BIT      (0xf << 0)      /* RW */
+#define DMA_ADDR_HIGH_4BIT      GENMASK(3, 0)	/* RW */
 
 /* MSDC_DMA_CTRL mask */
-#define MSDC_DMA_CTRL_START     (0x1 << 0)	/* W */
-#define MSDC_DMA_CTRL_STOP      (0x1 << 1)	/* W */
-#define MSDC_DMA_CTRL_RESUME    (0x1 << 2)	/* W */
-#define MSDC_DMA_CTRL_MODE      (0x1 << 8)	/* RW */
-#define MSDC_DMA_CTRL_LASTBUF   (0x1 << 10)	/* RW */
-#define MSDC_DMA_CTRL_BRUSTSZ   (0x7 << 12)	/* RW */
+#define MSDC_DMA_CTRL_START     BIT(0)	/* W */
+#define MSDC_DMA_CTRL_STOP      BIT(1)	/* W */
+#define MSDC_DMA_CTRL_RESUME    BIT(2)	/* W */
+#define MSDC_DMA_CTRL_MODE      BIT(8)	/* RW */
+#define MSDC_DMA_CTRL_LASTBUF   BIT(10)	/* RW */
+#define MSDC_DMA_CTRL_BRUSTSZ   GENMASK(14, 12)	/* RW */
 
 /* MSDC_DMA_CFG mask */
-#define MSDC_DMA_CFG_STS        (0x1 << 0)	/* R */
-#define MSDC_DMA_CFG_DECSEN     (0x1 << 1)	/* RW */
-#define MSDC_DMA_CFG_AHBHPROT2  (0x2 << 8)	/* RW */
-#define MSDC_DMA_CFG_ACTIVEEN   (0x2 << 12)	/* RW */
-#define MSDC_DMA_CFG_CS12B16B   (0x1 << 16)	/* RW */
+#define MSDC_DMA_CFG_STS        BIT(0)	/* R */
+#define MSDC_DMA_CFG_DECSEN     BIT(1)	/* RW */
+#define MSDC_DMA_CFG_AHBHPROT2  BIT(9)	/* RW */
+#define MSDC_DMA_CFG_ACTIVEEN   BIT(13)	/* RW */
+#define MSDC_DMA_CFG_CS12B16B   BIT(16)	/* RW */
 
 /* MSDC_PATCH_BIT mask */
-#define MSDC_PATCH_BIT_ODDSUPP    (0x1 <<  1)	/* RW */
-#define MSDC_INT_DAT_LATCH_CK_SEL (0x7 <<  7)
-#define MSDC_CKGEN_MSDC_DLY_SEL   (0x1f << 10)
-#define MSDC_PATCH_BIT_IODSSEL    (0x1 << 16)	/* RW */
-#define MSDC_PATCH_BIT_IOINTSEL   (0x1 << 17)	/* RW */
-#define MSDC_PATCH_BIT_BUSYDLY    (0xf << 18)	/* RW */
-#define MSDC_PATCH_BIT_WDOD       (0xf << 22)	/* RW */
-#define MSDC_PATCH_BIT_IDRTSEL    (0x1 << 26)	/* RW */
-#define MSDC_PATCH_BIT_CMDFSEL    (0x1 << 27)	/* RW */
-#define MSDC_PATCH_BIT_INTDLSEL   (0x1 << 28)	/* RW */
-#define MSDC_PATCH_BIT_SPCPUSH    (0x1 << 29)	/* RW */
-#define MSDC_PATCH_BIT_DECRCTMO   (0x1 << 30)	/* RW */
-
-#define MSDC_PATCH_BIT1_CMDTA     (0x7 << 3)    /* RW */
-#define MSDC_PB1_BUSY_CHECK_SEL   (0x1 << 7)    /* RW */
-#define MSDC_PATCH_BIT1_STOP_DLY  (0xf << 8)    /* RW */
-
-#define MSDC_PATCH_BIT2_CFGRESP   (0x1 << 15)   /* RW */
-#define MSDC_PATCH_BIT2_CFGCRCSTS (0x1 << 28)   /* RW */
-#define MSDC_PB2_SUPPORT_64G      (0x1 << 1)    /* RW */
-#define MSDC_PB2_RESPWAIT         (0x3 << 2)    /* RW */
-#define MSDC_PB2_RESPSTSENSEL     (0x7 << 16)   /* RW */
-#define MSDC_PB2_CRCSTSENSEL      (0x7 << 29)   /* RW */
-
-#define MSDC_PAD_TUNE_DATWRDLY	  (0x1f <<  0)	/* RW */
-#define MSDC_PAD_TUNE_DATRRDLY	  (0x1f <<  8)	/* RW */
-#define MSDC_PAD_TUNE_CMDRDLY	  (0x1f << 16)  /* RW */
-#define MSDC_PAD_TUNE_CMDRRDLY	  (0x1f << 22)	/* RW */
-#define MSDC_PAD_TUNE_CLKTDLY	  (0x1f << 27)  /* RW */
-#define MSDC_PAD_TUNE_RXDLYSEL	  (0x1 << 15)   /* RW */
-#define MSDC_PAD_TUNE_RD_SEL	  (0x1 << 13)   /* RW */
-#define MSDC_PAD_TUNE_CMD_SEL	  (0x1 << 21)   /* RW */
-
-#define PAD_DS_TUNE_DLY_SEL       (0x1 << 0)	/* RW */
-#define PAD_DS_TUNE_DLY1	  (0x1f << 2)   /* RW */
-#define PAD_DS_TUNE_DLY2	  (0x1f << 7)   /* RW */
-#define PAD_DS_TUNE_DLY3	  (0x1f << 12)  /* RW */
-
-#define PAD_CMD_TUNE_RX_DLY3	  (0x1f << 1)  /* RW */
+#define MSDC_PATCH_BIT_ODDSUPP    BIT(1)	/* RW */
+#define MSDC_INT_DAT_LATCH_CK_SEL GENMASK(9, 7)
+#define MSDC_CKGEN_MSDC_DLY_SEL   GENMASK(14, 10)
+#define MSDC_PATCH_BIT_IODSSEL    BIT(16)	/* RW */
+#define MSDC_PATCH_BIT_IOINTSEL   BIT(17)	/* RW */
+#define MSDC_PATCH_BIT_BUSYDLY    GENMASK(21, 18)	/* RW */
+#define MSDC_PATCH_BIT_WDOD       GENMASK(25, 22)	/* RW */
+#define MSDC_PATCH_BIT_IDRTSEL    BIT(26)	/* RW */
+#define MSDC_PATCH_BIT_CMDFSEL    BIT(27)	/* RW */
+#define MSDC_PATCH_BIT_INTDLSEL   BIT(28)	/* RW */
+#define MSDC_PATCH_BIT_SPCPUSH    BIT(29)	/* RW */
+#define MSDC_PATCH_BIT_DECRCTMO   BIT(30)	/* RW */
+
+#define MSDC_PATCH_BIT1_CMDTA     GENMASK(5, 3)    /* RW */
+#define MSDC_PB1_BUSY_CHECK_SEL   BIT(7)    /* RW */
+#define MSDC_PATCH_BIT1_STOP_DLY  GENMASK(11, 8)    /* RW */
+
+#define MSDC_PATCH_BIT2_CFGRESP   BIT(15)   /* RW */
+#define MSDC_PATCH_BIT2_CFGCRCSTS BIT(28)   /* RW */
+#define MSDC_PB2_SUPPORT_64G      BIT(1)    /* RW */
+#define MSDC_PB2_RESPWAIT         GENMASK(3, 2)   /* RW */
+#define MSDC_PB2_RESPSTSENSEL     GENMASK(18, 16) /* RW */
+#define MSDC_PB2_CRCSTSENSEL      GENMASK(31, 29) /* RW */
+
+#define MSDC_PAD_TUNE_DATWRDLY	  GENMASK(4, 0)		/* RW */
+#define MSDC_PAD_TUNE_DATRRDLY	  GENMASK(12, 8)	/* RW */
+#define MSDC_PAD_TUNE_CMDRDLY	  GENMASK(20, 16)	/* RW */
+#define MSDC_PAD_TUNE_CMDRRDLY	  GENMASK(26, 22)	/* RW */
+#define MSDC_PAD_TUNE_CLKTDLY	  GENMASK(31, 27)	/* RW */
+#define MSDC_PAD_TUNE_RXDLYSEL	  BIT(15)   /* RW */
+#define MSDC_PAD_TUNE_RD_SEL	  BIT(13)   /* RW */
+#define MSDC_PAD_TUNE_CMD_SEL	  BIT(21)   /* RW */
+
+#define PAD_DS_TUNE_DLY_SEL       BIT(0)	  /* RW */
+#define PAD_DS_TUNE_DLY1	  GENMASK(6, 2)   /* RW */
+#define PAD_DS_TUNE_DLY2	  GENMASK(11, 7)  /* RW */
+#define PAD_DS_TUNE_DLY3	  GENMASK(16, 12) /* RW */
+
+#define PAD_CMD_TUNE_RX_DLY3	  GENMASK(5, 1)   /* RW */
 
 /* EMMC51_CFG0 mask */
-#define CMDQ_RDAT_CNT		  (0x3ff << 12)	/* RW */
+#define CMDQ_RDAT_CNT		  GENMASK(21, 12) /* RW */
 
-#define EMMC50_CFG_PADCMD_LATCHCK (0x1 << 0)   /* RW */
-#define EMMC50_CFG_CRCSTS_EDGE    (0x1 << 3)   /* RW */
-#define EMMC50_CFG_CFCSTS_SEL     (0x1 << 4)   /* RW */
-#define EMMC50_CFG_CMD_RESP_SEL   (0x1 << 9)   /* RW */
+#define EMMC50_CFG_PADCMD_LATCHCK BIT(0)   /* RW */
+#define EMMC50_CFG_CRCSTS_EDGE    BIT(3)   /* RW */
+#define EMMC50_CFG_CFCSTS_SEL     BIT(4)   /* RW */
+#define EMMC50_CFG_CMD_RESP_SEL   BIT(9)   /* RW */
 
 /* EMMC50_CFG1 mask */
-#define EMMC50_CFG1_DS_CFG        (0x1 << 28)  /* RW */
+#define EMMC50_CFG1_DS_CFG        BIT(28)  /* RW */
 
-#define EMMC50_CFG3_OUTS_WR       (0x1f << 0)  /* RW */
+#define EMMC50_CFG3_OUTS_WR       GENMASK(4, 0)  /* RW */
 
-#define SDC_FIFO_CFG_WRVALIDSEL   (0x1 << 24)  /* RW */
-#define SDC_FIFO_CFG_RDVALIDSEL   (0x1 << 25)  /* RW */
+#define SDC_FIFO_CFG_WRVALIDSEL   BIT(24)  /* RW */
+#define SDC_FIFO_CFG_RDVALIDSEL   BIT(25)  /* RW */
 
 /* CQHCI_SETTING */
-#define CQHCI_RD_CMD_WND_SEL	  (0x1 << 14) /* RW */
-#define CQHCI_WR_CMD_WND_SEL	  (0x1 << 15) /* RW */
+#define CQHCI_RD_CMD_WND_SEL	  BIT(14) /* RW */
+#define CQHCI_WR_CMD_WND_SEL	  BIT(15) /* RW */
 
 /* EMMC_TOP_CONTROL mask */
-#define PAD_RXDLY_SEL           (0x1 << 0)      /* RW */
-#define DELAY_EN                (0x1 << 1)      /* RW */
-#define PAD_DAT_RD_RXDLY2       (0x1f << 2)     /* RW */
-#define PAD_DAT_RD_RXDLY        (0x1f << 7)     /* RW */
-#define PAD_DAT_RD_RXDLY2_SEL   (0x1 << 12)     /* RW */
-#define PAD_DAT_RD_RXDLY_SEL    (0x1 << 13)     /* RW */
-#define DATA_K_VALUE_SEL        (0x1 << 14)     /* RW */
-#define SDC_RX_ENH_EN           (0x1 << 15)     /* TW */
+#define PAD_RXDLY_SEL           BIT(0)      /* RW */
+#define DELAY_EN                BIT(1)      /* RW */
+#define PAD_DAT_RD_RXDLY2       GENMASK(6, 2)     /* RW */
+#define PAD_DAT_RD_RXDLY        GENMASK(11, 7)    /* RW */
+#define PAD_DAT_RD_RXDLY2_SEL   BIT(12)     /* RW */
+#define PAD_DAT_RD_RXDLY_SEL    BIT(13)     /* RW */
+#define DATA_K_VALUE_SEL        BIT(14)     /* RW */
+#define SDC_RX_ENH_EN           BIT(15)     /* TW */
 
 /* EMMC_TOP_CMD mask */
-#define PAD_CMD_RXDLY2          (0x1f << 0)     /* RW */
-#define PAD_CMD_RXDLY           (0x1f << 5)     /* RW */
-#define PAD_CMD_RD_RXDLY2_SEL   (0x1 << 10)     /* RW */
-#define PAD_CMD_RD_RXDLY_SEL    (0x1 << 11)     /* RW */
-#define PAD_CMD_TX_DLY          (0x1f << 12)    /* RW */
+#define PAD_CMD_RXDLY2          GENMASK(4, 0)	/* RW */
+#define PAD_CMD_RXDLY           GENMASK(9, 5)	/* RW */
+#define PAD_CMD_RD_RXDLY2_SEL   BIT(10)		/* RW */
+#define PAD_CMD_RD_RXDLY_SEL    BIT(11)		/* RW */
+#define PAD_CMD_TX_DLY          GENMASK(16, 12)	/* RW */
 
 /* EMMC50_PAD_DS_TUNE mask */
-#define PAD_DS_DLY_SEL		(0x1 << 16)	/* RW */
-#define PAD_DS_DLY1		(0x1f << 10)	/* RW */
-#define PAD_DS_DLY3		(0x1f << 0)	/* RW */
+#define PAD_DS_DLY_SEL		BIT(16)	/* RW */
+#define PAD_DS_DLY1		GENMASK(14, 10)	/* RW */
+#define PAD_DS_DLY3		GENMASK(4, 0)	/* RW */
 
-#define REQ_CMD_EIO  (0x1 << 0)
-#define REQ_CMD_TMO  (0x1 << 1)
-#define REQ_DAT_ERR  (0x1 << 2)
-#define REQ_STOP_EIO (0x1 << 3)
-#define REQ_STOP_TMO (0x1 << 4)
-#define REQ_CMD_BUSY (0x1 << 5)
+#define REQ_CMD_EIO  BIT(0)
+#define REQ_CMD_TMO  BIT(1)
+#define REQ_DAT_ERR  BIT(2)
+#define REQ_STOP_EIO BIT(3)
+#define REQ_STOP_TMO BIT(4)
+#define REQ_CMD_BUSY BIT(5)
 
-#define MSDC_PREPARE_FLAG (0x1 << 0)
-#define MSDC_ASYNC_FLAG (0x1 << 1)
-#define MSDC_MMAP_FLAG (0x1 << 2)
+#define MSDC_PREPARE_FLAG BIT(0)
+#define MSDC_ASYNC_FLAG BIT(1)
+#define MSDC_MMAP_FLAG BIT(2)
 
 #define MTK_MMC_AUTOSUSPEND_DELAY	50
 #define CMD_TIMEOUT         (HZ/10 * 5)	/* 100ms x5 */
@@ -331,17 +332,17 @@
 /*--------------------------------------------------------------------------*/
 struct mt_gpdma_desc {
 	u32 gpd_info;
-#define GPDMA_DESC_HWO		(0x1 << 0)
-#define GPDMA_DESC_BDP		(0x1 << 1)
-#define GPDMA_DESC_CHECKSUM	(0xff << 8) /* bit8 ~ bit15 */
-#define GPDMA_DESC_INT		(0x1 << 16)
-#define GPDMA_DESC_NEXT_H4	(0xf << 24)
-#define GPDMA_DESC_PTR_H4	(0xf << 28)
+#define GPDMA_DESC_HWO		BIT(0)
+#define GPDMA_DESC_BDP		BIT(1)
+#define GPDMA_DESC_CHECKSUM	GENMASK(15, 8)
+#define GPDMA_DESC_INT		BIT(16)
+#define GPDMA_DESC_NEXT_H4	GENMASK(27, 24)
+#define GPDMA_DESC_PTR_H4	GENMASK(31, 28)
 	u32 next;
 	u32 ptr;
 	u32 gpd_data_len;
-#define GPDMA_DESC_BUFLEN	(0xffff) /* bit0 ~ bit15 */
-#define GPDMA_DESC_EXTLEN	(0xff << 16) /* bit16 ~ bit23 */
+#define GPDMA_DESC_BUFLEN	GENMASK(15, 0)
+#define GPDMA_DESC_EXTLEN	GENMASK(23, 16)
 	u32 arg;
 	u32 blknum;
 	u32 cmd;
@@ -349,17 +350,17 @@ struct mt_gpdma_desc {
 
 struct mt_bdma_desc {
 	u32 bd_info;
-#define BDMA_DESC_EOL		(0x1 << 0)
-#define BDMA_DESC_CHECKSUM	(0xff << 8) /* bit8 ~ bit15 */
-#define BDMA_DESC_BLKPAD	(0x1 << 17)
-#define BDMA_DESC_DWPAD		(0x1 << 18)
-#define BDMA_DESC_NEXT_H4	(0xf << 24)
-#define BDMA_DESC_PTR_H4	(0xf << 28)
+#define BDMA_DESC_EOL		BIT(0)
+#define BDMA_DESC_CHECKSUM	GENMASK(15, 8)
+#define BDMA_DESC_BLKPAD	BIT(17)
+#define BDMA_DESC_DWPAD		BIT(18)
+#define BDMA_DESC_NEXT_H4	GENMASK(27, 24)
+#define BDMA_DESC_PTR_H4	GENMASK(31, 28)
 	u32 next;
 	u32 ptr;
 	u32 bd_data_len;
-#define BDMA_DESC_BUFLEN	(0xffff) /* bit0 ~ bit15 */
-#define BDMA_DESC_BUFLEN_EXT	(0xffffff) /* bit0 ~ bit23 */
+#define BDMA_DESC_BUFLEN	GENMASK(15, 0)
+#define BDMA_DESC_BUFLEN_EXT	GENMASK(23, 0)
 };
 
 struct msdc_dma {
@@ -724,7 +725,7 @@ static inline void msdc_dma_setup(struct msdc_host *host, struct msdc_dma *dma,
 	sdr_set_field(host->base + MSDC_DMA_CFG, MSDC_DMA_CFG_DECSEN, 1);
 	dma_ctrl = readl_relaxed(host->base + MSDC_DMA_CTRL);
 	dma_ctrl &= ~(MSDC_DMA_CTRL_BRUSTSZ | MSDC_DMA_CTRL_MODE);
-	dma_ctrl |= (MSDC_BURST_64B << 12 | 1 << 8);
+	dma_ctrl |= (MSDC_BURST_64B << 12 | BIT(8));
 	writel_relaxed(dma_ctrl, host->base + MSDC_DMA_CTRL);
 	if (host->dev_comp->support_64g)
 		sdr_set_field(host->base + DMA_SA_H4BIT, DMA_ADDR_HIGH_4BIT,
@@ -768,7 +769,7 @@ static u64 msdc_timeout_cal(struct msdc_host *host, u64 ns, u64 clks)
 		do_div(timeout, clk_ns);
 		timeout += clks;
 		/* in 1048576 sclk cycle unit */
-		timeout = DIV_ROUND_UP(timeout, (0x1 << 20));
+		timeout = DIV_ROUND_UP(timeout, BIT(20));
 		if (host->dev_comp->clk_div_bits == 8)
 			sdr_get_field(host->base + MSDC_CFG,
 				      MSDC_CFG_CKMOD, &mode);
@@ -1013,15 +1014,15 @@ static inline u32 msdc_cmd_prepare_raw_cmd(struct msdc_host *host,
 
 	if ((opcode == SD_IO_RW_DIRECT && cmd->flags == (unsigned int) -1) ||
 	    opcode == MMC_STOP_TRANSMISSION)
-		rawcmd |= (0x1 << 14);
+		rawcmd |= BIT(14);
 	else if (opcode == SD_SWITCH_VOLTAGE)
-		rawcmd |= (0x1 << 30);
+		rawcmd |= BIT(30);
 	else if (opcode == SD_APP_SEND_SCR ||
 		 opcode == SD_APP_SEND_NUM_WR_BLKS ||
 		 (opcode == SD_SWITCH && mmc_cmd_type(cmd) == MMC_CMD_ADTC) ||
 		 (opcode == SD_APP_SD_STATUS && mmc_cmd_type(cmd) == MMC_CMD_ADTC) ||
 		 (opcode == MMC_SEND_EXT_CSD && mmc_cmd_type(cmd) == MMC_CMD_ADTC))
-		rawcmd |= (0x1 << 11);
+		rawcmd |= BIT(11);
 
 	if (cmd->data) {
 		struct mmc_data *data = cmd->data;
@@ -1029,16 +1030,16 @@ static inline u32 msdc_cmd_prepare_raw_cmd(struct msdc_host *host,
 		if (mmc_op_multi(opcode)) {
 			if (mmc_card_mmc(mmc->card) && mrq->sbc &&
 			    !(mrq->sbc->arg & 0xFFFF0000))
-				rawcmd |= 0x2 << 28; /* AutoCMD23 */
+				rawcmd |= BIT(29); /* AutoCMD23 */
 		}
 
 		rawcmd |= ((data->blksz & 0xFFF) << 16);
 		if (data->flags & MMC_DATA_WRITE)
-			rawcmd |= (0x1 << 13);
+			rawcmd |= BIT(13);
 		if (data->blocks > 1)
-			rawcmd |= (0x2 << 11);
+			rawcmd |= BIT(12);
 		else
-			rawcmd |= (0x1 << 11);
+			rawcmd |= BIT(11);
 		/* Always use dma mode */
 		sdr_clr_bits(host->base + MSDC_CFG, MSDC_CFG_PIO);
 
@@ -1691,7 +1692,7 @@ static void msdc_init_hw(struct msdc_host *host)
 	}
 
 	if (host->dev_comp->busy_check)
-		sdr_clr_bits(host->base + MSDC_PATCH_BIT1, (1 << 7));
+		sdr_clr_bits(host->base + MSDC_PATCH_BIT1, BIT(7));
 
 	if (host->dev_comp->async_fifo) {
 		sdr_set_field(host->base + MSDC_PATCH_BIT2,
@@ -1871,7 +1872,7 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 static u32 test_delay_bit(u32 delay, u32 bit)
 {
 	bit %= PAD_DELAY_MAX;
-	return delay & (1 << bit);
+	return delay & BIT(bit);
 }
 
 static int get_delay_len(u32 delay, u32 start_bit)
@@ -1976,9 +1977,9 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 		for (j = 0; j < 3; j++) {
 			mmc_send_tuning(mmc, opcode, &cmd_err);
 			if (!cmd_err) {
-				rise_delay |= (1 << i);
+				rise_delay |= BIT(i);
 			} else {
-				rise_delay &= ~(1 << i);
+				rise_delay &= ~BIT(i);
 				break;
 			}
 		}
@@ -2000,9 +2001,9 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 		for (j = 0; j < 3; j++) {
 			mmc_send_tuning(mmc, opcode, &cmd_err);
 			if (!cmd_err) {
-				fall_delay |= (1 << i);
+				fall_delay |= BIT(i);
 			} else {
-				fall_delay &= ~(1 << i);
+				fall_delay &= ~BIT(i);
 				break;
 			}
 		}
@@ -2030,7 +2031,7 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 			      MSDC_PAD_TUNE_CMDRRDLY, i);
 		mmc_send_tuning(mmc, opcode, &cmd_err);
 		if (!cmd_err)
-			internal_delay |= (1 << i);
+			internal_delay |= BIT(i);
 	}
 	dev_dbg(host->dev, "Final internal delay: 0x%x\n", internal_delay);
 	internal_delay_phase = get_best_delay(host, internal_delay);
@@ -2075,9 +2076,9 @@ static int hs400_tune_response(struct mmc_host *mmc, u32 opcode)
 		for (j = 0; j < 3; j++) {
 			mmc_send_tuning(mmc, opcode, &cmd_err);
 			if (!cmd_err) {
-				cmd_delay |= (1 << i);
+				cmd_delay |= BIT(i);
 			} else {
-				cmd_delay &= ~(1 << i);
+				cmd_delay &= ~BIT(i);
 				break;
 			}
 		}
@@ -2107,7 +2108,7 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
 		msdc_set_data_delay(host, i);
 		ret = mmc_send_tuning(mmc, opcode, NULL);
 		if (!ret)
-			rise_delay |= (1 << i);
+			rise_delay |= BIT(i);
 	}
 	final_rise_delay = get_best_delay(host, rise_delay);
 	/* if rising edge has enough margin, then do not scan falling edge */
@@ -2121,7 +2122,7 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
 		msdc_set_data_delay(host, i);
 		ret = mmc_send_tuning(mmc, opcode, NULL);
 		if (!ret)
-			fall_delay |= (1 << i);
+			fall_delay |= BIT(i);
 	}
 	final_fall_delay = get_best_delay(host, fall_delay);
 
@@ -2165,7 +2166,7 @@ static int msdc_tune_together(struct mmc_host *mmc, u32 opcode)
 		msdc_set_data_delay(host, i);
 		ret = mmc_send_tuning(mmc, opcode, NULL);
 		if (!ret)
-			rise_delay |= (1 << i);
+			rise_delay |= BIT(i);
 	}
 	final_rise_delay = get_best_delay(host, rise_delay);
 	/* if rising edge has enough margin, then do not scan falling edge */
@@ -2181,7 +2182,7 @@ static int msdc_tune_together(struct mmc_host *mmc, u32 opcode)
 		msdc_set_data_delay(host, i);
 		ret = mmc_send_tuning(mmc, opcode, NULL);
 		if (!ret)
-			fall_delay |= (1 << i);
+			fall_delay |= BIT(i);
 	}
 	final_fall_delay = get_best_delay(host, fall_delay);
 
@@ -2298,7 +2299,7 @@ static int msdc_execute_hs400_tuning(struct mmc_host *mmc, struct mmc_card *card
 				      PAD_DS_TUNE_DLY1, i);
 		ret = mmc_get_ext_csd(card, &ext_csd);
 		if (!ret) {
-			result_dly1 |= (1 << i);
+			result_dly1 |= BIT(i);
 			kfree(ext_csd);
 		}
 	}
-- 
2.33.1

